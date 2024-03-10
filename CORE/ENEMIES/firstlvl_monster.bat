@echo off
for /l %%i in (1,1,!monsters!) do (
	set mons%%i.hp=10
	set mons%%i.armor=0
	set mons%%i.xp=14
	set monslive%%i=true
	set monsstate%%i=M
)
set mons.weapon.dmg=2d2d1
set mons.weapon.acc=5
set mons.weapon.spd=1.0
goto :eof