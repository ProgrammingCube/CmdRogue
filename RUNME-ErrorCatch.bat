:start
@echo off
cls
::set /p input=File name: 
::cmd /k "%input%"
echo.
echo This script will automatically run Pokemon Batch
echo after pressing any key. If it crashes, this script
echo will keep the window open instead of closing. This
echo way, you can write down the error and report it to
echo me. [kolto101@gmail.com]
echo.
echo Thanks for playing. Enjoy!
echo.
pause
cls
::cmd /k "CmdRogue.bat"
cmd /k "CmdRogue.bat"

echo.
echo Program ended or crashed.
echo.
echo ERRORLEVEL: %ERRORLEVEL%
echo.
:inputloop
set /p input=Run again? [y/n]: 
if /i "%input%" == "y" goto start
if /i "%input%" == "n" exit
goto inputloop