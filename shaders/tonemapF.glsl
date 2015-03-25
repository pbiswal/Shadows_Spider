/*

Copyright 2015 Aleksander Berg-Jones

This file is part of Shadow's Spider.

Shadow's Spider is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Shadow's Spider is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Shadow's Spider.  If not, see <http://www.gnu.org/licenses/>.

*/

#version 450 core
#extension GL_ARB_bindless_texture : require

//http://content.gpwiki.org/index.php/D3DBook:High-Dynamic_Range_Rendering#Luminance_History_Function e10 - auto exp

in Vert
{
    vec2 uv;
} v;

layout(bindless_sampler, location = 0) uniform sampler2D bloomC;
layout(bindless_sampler, location = 1) uniform sampler2D lumaT;
layout(location = 0) out vec3 Ci;

uniform bool adaptAuto, vignette;
uniform float expo, vignetteD;

float log10(float x)
{
    return log2(x) / log2(10);
}

vec3 filmicHabel(vec3 x)
{
    float A = .15f;
    float B = .5f;
    float C = .1f;
    float D = .2f;
    float E = .02f;
    float F = .3f;

    return ((x * (A * x + C * B) + D * E) / (x * (A * x + B) + D * F)) - E / F;
}

float vignetteOverlay(vec2 pos, float inner, float outer)
{
    float r = length(pos);

    return 1.f - smoothstep(inner, outer, r);
}

void main()
{
    vec4 bloom = texture(bloomC, v.uv);
    float lum = max(exp(textureLod(lumaT, v.uv, 10.f).r), .0001f);

    if (vignette)
        bloom.rgb *= vignetteOverlay(v.uv * 2.f - 1.f, .55f, vignetteD);

    float expoAdapt = expo;

    if (adaptAuto)
        expoAdapt = 1.03f - (2.f / (2.f + log10(lum + 1.f)));

    Ci = bloom.rgb * expoAdapt / lum;
    Ci = filmicHabel(Ci) / filmicHabel(vec3(11.2f));
}
