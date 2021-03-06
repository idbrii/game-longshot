:: https://love2d.org/wiki/Game_Distribution

pushd %~dp0

set build_dir=c:\scratch\build_longshot\longshot
set network_dir=M:\gamejam-2019-01-23\longshot
set love_dir=%USERPROFILE%\scoop\apps\love\11.2

rd /S /Q %build_dir%
mkdir %build_dir%

move /Y src\devcheck.lua src\devcheck.lua_bak
copy /Y src\neverdev.lua src\devcheck.lua

%USERPROFILE%\scoop\shims\7z.exe a -y -tzip -x!.git -x!cscope.* -x!*tags -x!*.swp %build_dir%\Longshot.love .
copy /b %love_dir%\love.exe+%build_dir%\Longshot.love %build_dir%\Longshot.exe
copy %love_dir%\*.dll %build_dir%\.
copy README.md %build_dir%\.

del %build_dir%\Longshot.love

del /R %network_dir%
mkdir %network_dir%
copy %build_dir% %network_dir%


move /Y src\devcheck.lua_bak src\devcheck.lua

popd
