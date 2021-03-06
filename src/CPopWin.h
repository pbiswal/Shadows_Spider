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

#ifndef CPOPWIN_H
#define CPOPWIN_H

#include "MainWin.h"

class CPopWin : public QMainWindow
{
    Q_OBJECT
public:
    MainWin &myWin;
    CPopWin(MainWin &, QWidget *parent = 0);

    QStackedLayout *stackedMain;
    CPop *myCPop;

protected:
    void resizeEvent(QResizeEvent *);

};

#endif // CPOPWIN_H
