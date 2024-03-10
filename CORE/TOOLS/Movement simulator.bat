@echo off
mode con cols=80 lines=60
set a=97
set d=100
set w=119
set s=115

set x=20
set y=20



:loop

colous 15 0 %x%,%y% "X"

colous readkey

colous 0 0 %x%,%y% " "

set key=%errorlevel%

if %key% == %a% (
set /a x=%x%-1
)
if %key% == %d% (
set /a x=%x%+1
)
if %key% == %w% (
set /a y=%y%-1
)
if %key% == %s% (
set /a y=%y%+1
)
goto loop