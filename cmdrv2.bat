::CmdRogue 2.0
::version 2.0
::Created by Patrick Jackson a.k.a. TheWinnieston/GinDiamond
::started on 2/12/2023 at 4:02 PM
cls
@echo off
setlocal enabledelayedexpansion
setlocal enableextensions
chcp 437
mode con cols=80 lines=25
title CmdRogue v2
if exist messagelog.txt del messagelog.txt

set homedir=%cd%

::sweet title screen!
:titlescreen
echo [0;0H
echo [?25l
call :TitleDisplay