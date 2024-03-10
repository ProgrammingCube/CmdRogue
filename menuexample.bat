cls
@echo off
set homedir=%cd%
setlocal enabledelayedexpansion
mode con cols=52 lines=25
setlocal enableextensions
call core\version.bat
title CmdRogue %version_title%
if exist messagelog.txt del messagelog.txt
set selected=1
set 1clr=07
set 2clr=07
set 3clr=07
color 0c
::sweet title screen!
:titlescreen
graphic.exe hidecursor
graphic.exe locate 0 0
if %selected% == 1 (
	set ONEclr=0e
	set TWOclr=07
	set THREEclr=07
)
if %selected% == 2 (
	set ONEclr=07
	set TWOclr=0e
	set THREEclr=07
)
if %selected% == 3 (
	set ONEclr=07
	set TWOclr=07
	set THREEclr=0e
)
call :TitleDisplay
ctext.exe "{04}          Console Roguelike {0c}v.!version!{0a}!vers_build!"
echo.
ctext.exe "{04}           by {0c}Patrick Jackson"
echo.
ctext.exe "{04}           ASCII by {0c}Patrick Jackson"
echo.
echo.
echo  Add. coding  : ChristianXD, kolto101, Charlie Nash
echo                 Ethan Brooks
echo  Music tracks : Sonic Clang, Simon Volpert
echo.
echo.
ctext.exe "{04}                 --- {%ONEclr%}Start Game{04} ---"
echo.
ctext.exe "{04}                 ------ {%TWOclr%}Help{04} ------"
echo.
ctext.exe "{04}                 ------ {%THREEclr%}Exit{04} ------"
echo.
Kbd.exe
set key=%errorlevel%
if %key% == 72 (
	if %selected% equ 1 set selected=3 && goto titlescreen
	if %selected% equ 2 set selected=1 && goto titlescreen
	if %selected% equ 3 set selected=2 && goto titlescreen
)
if %key% == 80 (
	if %selected% equ 1 set selected=2 && goto titlescreen
	if %selected% equ 2 set selected=3 && goto titlescreen
	if %selected% equ 3 set selected=1 && goto titlescreen
)
if %key% == 13 (
	if %selected% equ 1 cls && mode con cols=52 lines=25 && goto setdifficulty
	if %selected% equ 2 goto help
	if %selected% equ 3 exit
)
if %key% == 27 (
	if %selected% equ 3 (
		exit
	) else (
		set selected=3 && goto titlescreen
	)
)
goto titlescreen



:TitleDisplay
ctext.exe {0c}
echo ÛÛÛ
::echo.
::echo.
::echo.    мллл          л   ллллм
::echo.    л             л   л   л
::echo.    л    млмлм мллл   ллллп мллм мллм      млм
::echo.    л    л л л л  л   л  л  л  л л  л л  л л л
::echo.    л    л   л пллп   л   л пллп пллл л  л ллп
::echo     л    л                          л пллп л
::echo.    пллл                         пллп      плл
::echo.
echo.