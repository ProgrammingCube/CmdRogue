::CmdRogue
::version 1.0.0.1s
::Created by Patrick Jackson, a.k.a. TheWinnieston/GinDiamond
::started on 4/29/2012 at 9:08 AM

::Picked back up on 12/24/2018 at 1:51 PM
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

:setdifficulty
graphic.exe hidecursor
Graphic.exe locate 0 0
if %selected% == 1 (
	set ONEclr=0e
	set TWOclr=07
	set THREEclr=07
	set FOURclr=07
)
if %selected% == 2 (
	set ONEclr=07
	set TWOclr=0e
	set THREEclr=07
	set FOURclr=07
)
if %selected% == 3 (
	set ONEclr=07
	set TWOclr=07
	set THREEclr=0e
	set FOURclr=07
)
call :TitleDisplay
echo.
echo.
echo.
ctext.exe "{04}               Choose difficulty:"
echo.
echo.
ctext.exe "{04}               -----  {%ONEclr%}Easy  {04}-----"
echo.
ctext.exe "{04}               ----- {%TWOclr%}Medium {04}-----"
echo.
ctext.exe "{04}               -----  {%THREEclr%}Hard  {04}-----"
echo.
echo.
Kbd.exe
set key=%errorlevel%
if %key% == 72 (
	if %selected% equ 1 set selected=3 && goto setdifficulty
	if %selected% equ 2 set selected=1 && goto setdifficulty
	if %selected% equ 3 set selected=2 && goto setdifficulty
)
if %key% == 80 (
	if %selected% equ 1 set selected=2 && goto setdifficulty
	if %selected% equ 2 set selected=3 && goto setdifficulty
	if %selected% equ 3 set selected=1 && goto setdifficulty
)
if %key% == 13 (
	if %selected% equ 1 set difficulty=1
	if %selected% equ 2 set difficulty=2
	if %selected% equ 3 set difficulty=3
)
if %key% == 27 (
	if %selected% equ 4 (
		exit
	) else (
		set selected=1
		cls
		mode con cols=52 lines=25
		goto titlescreen
	)
)
mode con cols=52 lines=25
:: 15 19
set /a monsters=%random%%%3+%difficulty%

:startgame
cls
::mode con cols=52 lines=27
color 07
echo.
echo Loading game...
echo.
echo Clearing previous floors...
cd floors
echo %cd%
for /f %%i in ('dir /b %cd%') do (
	if %%i neq castle.bat (
		del /q %%i
	)
)
cd ..
setlocal enabledelayedexpansion
echo Loading firstlvl_monster.bat...
call core\enemies\firstlvl_monster.bat
echo Load complete!
echo.
echo Loading castle.bat...
call floors\castle.bat
echo Load complete!
echo.
echo Loading weapons.bat...
call core\weapons.bat
echo Load complete!

::player's settings (default)
set player.armor=0^/0
set player.xp.level=1

set weapon=fists
set weapon.dmg=!%weapon%.dmg!
for /f "tokens=1-3 delims=d" %%a in ("!weapon.dmg!") do (
	set dice=%%a
	set sides=%%b
	set number=%%c
)

set message1=Welcome to CmdRogue^!
set message2=You start exploring...

set turns=1
set player.hp=50
set player.armor=0
set gametime=1.00
set xp.pccent=0

call :setVirtualLines

set die_floorcount=1
goto genCharpos

:roll
echo Generating map...
set /a die_floorcount+=1

::Level generator
set /a pickFloor=%random%%%2
if !pickFloor! == 0 (
	call core\generator\cave_generator.bat 38 13 200 floors\map%die_floorcount%
) else if !pickFloor! == 1 (
	call core\generator\arena_generator.bat 4 2 floors\map%die_floorcount%
)
call floors\map%die_floorcount%.bat

call :setVirtualLines

set /a monsters=%random%%%2+%difficulty%
call core\enemies\firstlvl_monster.bat

:genStair
set /a stair_x=!random!%%36+1
set /a stair_y=!random!%%12+1
set /a chars=!stair_x!+1
set line=!line[%stair_y%]!
set chkline=!line:~0,%chars%!
set c.line=!chkline:~-1!
if !c.line! == # (
	goto genStair
)
set line[%stair_y%]=!line:~0,%stair_x%!^>!line:~%chars%!
set stair=!stair_x!d!stair_y!

call :setVirtualLines

cls

:genCharpos
set /a pos.x=!random!%%36+1
set /a pos.y=!random!%%12+1
set /a chars=!pos.x!+1
set line=!line[%pos.y%]!
set chkline=!line:~0,%chars%!
set c.line=!chkline:~-1!
if !c.line! == # (
	goto genCharpos
)

::generates each monster's position
:genMonsterpos_1
set loops=0
:genMonsterpos
set /a loops+=1
:genMonsFeedback
set /a monspos!loops!.x=!random!%%36+1
set /a monspos!loops!.y=!random!%%12+1

set monsloops=0
:genMonsFeedback_1
set /a monsloops+=1
set /a chars=!monspos%monsloops%.x!+1
set monspos=!monspos%monsloops%.y!
set line=!line[%monspos%]!
set chkline=!line:~0,%chars%!
set c.line=!chkline:~-1!
if !c.line! == # (
	goto genMonsFeedback
)
if !monspos%monsloops%.x! == !pos.x! (
	if !monspos%monsloops%.y! == !pos.y! (
		goto genMonsterpos_1
	)
)
if %monsloops% lss %monsters% goto genMonsFeedback_1
if !loops! lss !monsters! goto genMonsterpos

mode con cols=52 lines=27

:game
call :display
call :Move
call :Monsters
goto game

:display
graphic.exe hidecursor
graphic.exe locate 0 0

set /a xAdd1=pos.x+1
for /l %%i in (1,1,!monsters!) do (
	set /a n%%iAdd1=monspos%%i.x+1
)

set loopP=0
:loopPrint
::echo. Monsters: [%monsters%]
echo.
set /a loopP+=1
set monster=!loopP!
set monspos=!monspos%loopP%.x!
set monsxAdd1=!n%loopP%Add1!
set monsposy=!monspos%loopP%.y!
set monsstate=!monsstate%loopP%!

	for /l %%b in (0,1,13) do (
		set line=!v.line[%%b]!
		if %%b equ !monsposy! (
			set part1=!line:~0,%monspos%!
			set part2=!line:~%monsxAdd1%!
			REM set line=!part1!{06}!monsstate!{07}!part2!
			set line=!part1!!monsstate!!part2!
			set v.line[%%b]=!line!
		)
	)
if not "!loopP!" == "!monsters!" goto loopPrint

for /l %%n in (0,1,13) do (
	set line=!v.line[%%n]!
	if %%n==%pos.y% (
		set line=!line:~0,%pos.x%!@!line:~%xAdd1%!
	)
	set checkline%%n=!line!
	echo.    !line!
	set v.line[%%n]=!line[%%n]!
)

echo.
echo.
ctext.exe "{09} Player{08} Health: {04}!player.hp!/50    {08} Armor : {0f}[!player.armor!]"
echo.
REM ctext.exe "{08} Exp: {0f}!xp.pccent!%%/!xp.lvl!  {08}Weapon: {0f}!weapon! (!dice!d!sides!)x!number!"
ctext.exe "{08} Exp: {0f}!xp.pccent!%%/[exp]  {08}Weapon: {0f}!weapon! (!dice!d!sides!)x!number!"

echo.
echo.
ctext.exe {0f}- {0e}Messages{0f}  ---------------------
echo.
::Need to redo the message engine.
ctext {0f}
echo  !message1!
ctext {07}
echo. !message2!
echo.
goto :eof

:Move
Kbd.exe
set prev.x=!pos.x!
set prev.y=!pos.y!
set key=%errorlevel%
set errorlevel=

::I've found that IF statements are faster than gotos

::up arrow
if %key% == 72 (
	set /a pos.y-=1
	goto check4posts
)
::left arrow
if %key% == 75 (
	set /a pos.x-=1
	goto check4posts
)
::down arrow
if %key% == 80 (
	set /a pos.y+=1
	goto check4posts
)
::right arrow
if %key% == 77 (
	set /a pos.x+=1
	goto check4posts
)
::Home
if %key% == 71 (
	set /a pos.x-=1
	set /a pos.y-=1
	goto check4posts
)
::PgUp
if %key% == 73 (
	set /a pos.x+=1
	set /a pos.y-=1
	goto check4posts
)
::End
if %key% == 79 (
	set /a pos.x-=1
	set /a pos.y+=1
	goto check4posts
)
::PgDn
if %key% == 81 (
	set /a pos.x+=1
	set /a pos.y+=1
	goto check4posts
)
::(Period) Wait key
if %key% == 46 (
	goto display
)
::messages: m
if %key% == 109 (
	cls
	type messagelog.txt | more
	echo.
	echo Press any key to return to game...
	pause>nul
	cls
	goto game
)
::(Quit) q
if %key% == 113 (
	goto Quit
)
if %key% == 62 (
	if !pos.x!d!pos.y! == %stair% (
		set pos.x=
		set pos.y=
		call :messageRefresh
		set message1=You descend a floor^^!
		::call :clearVars
		cls
		goto roll
	)
	exit /b
)


:check4posts
set /a chars=!pos.x!+1
set chkline=!checkline%pos.y%:~0,%chars%!
set c.line=!chkline:~-1!
if !c.line! == # (
	set pos.x=!prev.x!
	set pos.y=!prev.y!
	goto Move
)

for /l %%i in (0, 1, !monsters!) do (
	if !monslive%%i! == true (
		if !pos.x! == !monspos%%i.x! (
			if !pos.y! == !monspos%%i.y! (
				set monster=%%i
				goto playerCombat
			)
		)
	)
)
goto :eof

:Monsters
set loops=0
:Monsters_1
set /a loops+=1
if !loops! gtr !monsters! (
	exit /b
)
if !monslive%loops%! == false (
	if exist !monslive%loops%! (
		set /a loops+=1
	)
)
set monster=!loops!
call :monsterMove
goto Monsters_1



::+-------------------+
::|  Monsters and AI  |
::|                   |
::|This area might be |
::|a bit buggy and off|
::|, but what can you |
::|expect from batch? |
::+-------------------+
:monsterMove
if !monslive%monster%! equ false goto Monsters_1
set monspos.x=!monspos%monster%.x!
set monspos.y=!monspos%monster%.y!
set onMonster=!monster!
set m.prev.x=!monspos.x!
set m.prev.y=!monspos.y!
::Pythagorean theorem
set /a a=!monspos.x!-!pos.x!
set /a b=!monspos.y!-!pos.y!
set /a a.sq=!a!*!a!
set /a b.sq=!b!*!b!
set /a c.sq=!a.sq!+!b.sq!

set count=0
set num=%c.sq%
for /l %%a in (%c.sq%, -1, 1) do (
	set /a sqr=%%a*%%a
	if !sqr! leq %c.sq% (
		set digit=%%a
		set root=%%a
		goto out
	)
)

:out
call set /a count=%%count%%+1
if %count% GTR 0 goto next

:next
if %c.sq% neq 0 set digit=%digit%
set c=!digit!

if !c! leq 6 (
	if !c! gtr 3 (
		::goto fiffif
		set /a fiffifmove=!random!%%2
		if !fiffifmove! == 0 (
			if !monspos.x! gtr !pos.x! set /a monspos.x-=1
			if !monspos.x! lss !pos.x! set /a monspos.x+=1
			if !monspos.y! gtr !pos.y! set /a monspos.y-=1
			if !monspos.y! lss !pos.y! set /a monspos.y+=1
			goto setmonstcoords
		)
	)
	if !c! leq 3 (
		if !monspos.x! gtr !pos.x! set /a monspos.x-=1
		if !monspos.x! lss !pos.x! set /a monspos.x+=1
		if !monspos.y! gtr !pos.y! set /a monspos.y-=1
		if !monspos.y! lss !pos.y! set /a monspos.y+=1
		if !monspos.x!!monspos.y! equ !pos.x!!pos.y! goto monsCombat
		goto setmonstcoords
	)
)

:mRandmove
set /a m.movedie=!random!%%9
if !m.movedie! == 0 (
	set /a monspos.x+=1
	set /a monspos.y+=1
	goto setmonstcoords
)
if !m.movedie! == 1 (
	set /a monspos.x-=1
	set /a monspos.y-=1
	goto setmonstcoords
)
if !m.movedie! == 2 (
	set /a monspos.x+=1
	set /a monspos.y-=1
	goto setmonstcoords
)
if !m.movedie! == 3 (
	set /a monspos.x-=1
	set /a monspos.y+=1
	goto setmonstcoords
)
if !m.movedie! == 4 (
	set /a monspos.x+=1
	goto setmonstcoords
)
if !m.movedie! == 5 (
	set /a monspos.x-=1
	goto setmonstcoords
)
if !m.movedie! == 6 (
	set /a monspos.y+=1
	goto setmonstcoords
)
if !m.movedie! == 7 (
	set /a monspos.y-=1
	goto setmonstcoords
)
if !m.movedie! == 8 (
	goto setmonstcoords
)

:setmonstcoords
set /a chars=!monspos.x!+1
set line=!line[%monspos.y%]!
set chkline=!line:~0,%chars%!
set c.line=!chkline:~-1!

echo # | findstr /c:"%c.line%" > nul && (
	set monspos.x=!m.prev.x!
	set monspos.y=!m.prev.y!
)

::what...why does Other Monster Found happen even on a map with
::just one monster...

::I think its because I go over the monster I'm already on, which
::makes zero sense. Got to fix that
for /l %%i in (1,1,!monsters!) do (
	if !monslive%%i! equ true (
		if %monspos.x% equ !monspos%%i.x! (
			if %monspos.y% equ !monspos%%i.y! (
				echo OTHER_MONSTER_FOUND
				set monspos.x=!m.prev.x!
				set monspos.y=!m.prev.y!
			)
		)
	)
)

if !monspos.x! equ !pos.x! (
	if !monspos.y! equ !pos.y! (
		call :monsCombat
	)
)
set monspos!monster!.x=!monspos.x!
set monspos!monster!.y=!monspos.y!



exit /b
::+----------------+
::| PLAYER COMBAT  |
::|                |
::|This might also |
::|might be a bit  |
::|buggy. But its  |
::|still cool!     |
::+----------------+
:playerCombat
::start sndrec32.exe /play /close /embedding "SOUND\punch.wav"
set weapon.dmg=!%weapon%.dmg!
set damage=0
for /f "tokens=1-3 delims=d" %%a in ("!weapon.dmg!") do (
	set dice=%%a
	set sides=%%b
	set number=%%c
)

set attacks=0
set loop=0
set rolls=0
:rolls
set /a rolls+=1
:dmgLoop
set /a loop+=1
set /a dmge!loop!=!random!%%!sides!+1
set /a damage+=!dmge%loop%!
if !loop! lss !dice! goto dmgLoop
set MonsterDamage=!mons%monster%!

if !rolls! lss !number! set loop=0 && goto rolls
set /a mons!monster!.dmg=!damage!-!mons%monster%.armor!
set /a mons!monster!.hp=!mons%monster%.hp!-!mons%monster%.dmg!

call :messageRefresh
if !mons%monster%.dmg! leq 0 (
	set message1=You hit the monster but there's no effect^^!
) else (
	set message1=You hit the monster for !mons%monster%.dmg! damage^^!
)
set pos.x=!prev.x!
set pos.y=!prev.y!
if !mons%monster%.hp! leq 0 (
	set message1=!message2!
	set message2=You kill the monster^^!              
	set /a xp.pccent=!xp.pccent!+!mons%monster%.xp!
	set monslive!monster!=false
	set monsstate!monster!=%%
)
goto :eof
::+----------------+
::| MONSTER COMBAT |
::|                |
::|This might also |
::|might be a bit  |
::|buggy. But its  |
::|still cool!     |
::+----------------+
:monsCombat
::start sndrec32.exe /play /close /embedding "SOUND\punch.wav"
set m.damage=0
for /f "tokens=1-3 delims=d" %%a in ("!mons.weapon.dmg!") do (
	set m.dice=%%a
	set m.sides=%%b
	set m.number=%%c
)
set loop=0
set rolls=0
:mRolls
set /a rolls+=1
:monsDmgLoop
set /a loop+=1
set /a m.dmge!loop!=!random!%%!m.sides!+1
set /a m.damage+=!m.dmge%loop%!
if !loop! lss !m.dice! goto monsDmgLoop

if !rolls! lss !m.number! set loop=0 && goto mRolls
call :messageRefresh
::accuracy
set /a m_didHit=%random%%%2
if %m_didHit% == 1 (
	set /a player.dmg=%m.damage%-%player.armor%
	set /a player.hp=%player.hp%-%player.dmg%
) else (
	set message1=The monster missed^^!            
)

call :messageRefresh
if !player.dmg! leq 0 (
	set message1=The monster hits you but there's no effect^^!        
) else (
	set message1=The monster hits you for !player.dmg! damage^^!         
)
set monspos%monster%.x=!m.prev.x!
set monspos%monster%.y=!m.prev.y!
if !player.hp! leq 0 goto playerDeath
exit /b

:playerDeath
set message1=
set message1=You die^!...Press Enter
call :display
kbd.exe
cls
goto titlescreen

::+----------------+
::|Common Functions|
::+----------------+

:setVirtualLines
for /l %%n in (0,1,13) do (
	set v.line[%%n]=!line[%%n]!
)
goto :eof

:messageRefresh
echo !message1!>>messagelog.txt
set message2=!message1!
set message1= 
goto :eof

:help

goto :eof

:Quit
cls
echo.
echo Do you want to quit?
echo.
echo [Y/N]
:: Y 121
:: N 110
Kbd.exe
if %errorlevel% == 121 (
	exit
) else (
	goto game
)

:TitleDisplay
ctext.exe {0c}
echo.
echo.
echo.    мллл          л   ллллм
echo.    л             л   л   л
echo.    л    млмлм мллл   ллллп мллм мллм      млм
echo.    л    л л л л  л   л  л  л  л л  л л  л л л
echo.    л    л   л пллп   л   л пллп пллл л  л ллп
echo     л    л                          л пллп л
echo.    пллл                         пллп      плл
echo.
echo.