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

in Vert
{
    vec3 uv;
} v;

layout(binding = 0) uniform samplerCube cubeM_specular_32;
layout(location = 0) out vec4 rttC;
layout(location = 4) out vec4 ssaoMask;

uniform bool ssaoTgl;

void main()
{
    rttC = texture(cubeM_specular_32, v.uv);

    ssaoMask = (ssaoTgl) ? vec4(1.f) : vec4(0.f);
}
