:: https://love2d.org/wiki/Game_Distribution
:: Copy files to make and editable build of the game.

pushd %~dp0

set build_dir=c:\scratch\build_longshot
set network_dir=M:\gamejam-2019-01-23\longshot_dev
set love_dir=%USERPROFILE%\scoop\apps\love\11.2

mkdir %build_dir% 2>NUL

%USERPROFILE%\scoop\shims\7z.exe a -y -tzip -x!.git -x!cscope.* -x!*tags -x!*.swp %build_dir%\Longshot.love .

copy %love_dir%\*.dll %build_dir%\.

%USERPROFILE%\scoop\shims\7z.exe x -y -tzip -o%build_dir% %build_dir%\Longshot.love
copy %love_dir%\*.exe %build_dir%\.
echo love.exe . > %build_dir%\runme.bat

rd /S /Q %network_dir%
mkdir %network_dir%
xcopy /S %build_dir% %network_dir%



popd
