::Arena Generation
::started at 9:53 PM on Thursday, May 28th 2015
::by GinDiamond aka TheWinnieston/Patrick Jackson
@echo off
::call template.bat
set  line[0]=#######################################
set  line[1]=#.....................................#
set  line[2]=#.....................................#
set  line[3]=#.....................................#
set  line[4]=#.....................................#
set  line[5]=#.....................................#
set  line[6]=#.....................................#
set  line[7]=#.....................................#
set  line[8]=#.....................................#
set  line[9]=#.....................................#
set line[10]=#.....................................#
set line[11]=#.....................................#
set line[12]=#.....................................#
set line[13]=#######################################

set floor_level=%1
set game_level=%2
set filename=%3
set /a die_roll=(!random!%%25+1)+(!floor_level!/2)
::horrific recursion, yes, I know
if !die_roll! leq 24 (
	set floor_line[3]=.........
	set floor_line[4]=..#...#..
	set floor_line[5]=.........
	set floor_line[6]=.........
	set floor_line[7]=.........
	set floor_line[8]=..#...#..
	set floor_line[9]=.........
) else (
	if !die_roll! leq 34 (
		set floor_line[3]=.........
		set floor_line[4]=.##...##.
		set floor_line[5]=.........
		set floor_line[6]=.........
		set floor_line[7]=.........
		set floor_line[8]=.##...##.
		set floor_line[9]=.........
	) else (
		if !die_roll! leq 44 (
			set floor_line[3]=.##...##.
			set floor_line[4]=.#.....#.
			set floor_line[5]=.........
			set floor_line[6]=.........
			set floor_line[7]=.........
			set floor_line[8]=.#.....#.
			set floor_line[9]=.##...##.
		) else (
			if !die_roll! leq 50 (
				set floor_line[3]=.##...##.
				set floor_line[4]=##..#..##
				set floor_line[5]=.........
				set floor_line[6]=..#...#..
				set floor_line[7]=.........
				set floor_line[8]=##..#..##
				set floor_line[9]=.##...##.
			)
		)
	)
)

for /l %%i in (3,1,9) do (
	set line=!line[%%i]!
	set line[%%i]=!line:~0,15!!floor_line[%%i]!!line:~24!
)

echo @echo off > %filename%.bat
for /l %%i in (0,1,13) do (
	echo set line[%%i]=!line[%%i]!>> %filename%.bat
)
echo goto :eof >> %filename%.bat
goto :eof