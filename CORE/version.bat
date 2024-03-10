::move monsters into single line arrays containing their values

::----------------move to separate file-----------------------
set raw_version=1/0/0/3.a

set version=
for /f "tokens=1,2 delims=." %%a in ("!raw_version!") do (
	set vers_num=%%a
	set vers_build=%%b
)
for /f "tokens=1,2,3,4 delims=/" %%a in ("!vers_num!") do (
	set version=%%a.%%b.%%c.%%d
)
set version_title=!version!!vers_build!
::------------------------------------------------------------