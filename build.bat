@echo off
echo.

rem See: http://steve-jansen.github.io/guides/windows-batch-scripting/index.html

rem #############################################################################################################
rem START Change


set source=boilerplate.asm
set destDebug=test.bin
set destRelease=test.tap
set destPath=./build/


rem END Change
rem #############################################################################################################




rem #############################################################################################################
rem # DO NOT EDIT BELOW THIS LINE                                                                               #
rem #############################################################################################################

if not exist %source% (
	echo Sourcefile '%source%' does not exist.
	goto :end
)

set args=%1

if /I "%args%" == "--help" (
	echo [default]  -debug   : Assemble file to binary as '.bin' for monitoring / debugging in emulator.
	echo            -release : Assemble file to self executing '.tap' file.
	echo            -clean   : Deletes all previously built binary files.

	goto :end
)

echo Type --help for command line options.

rem Options: debug (default) | release
set mode=debug

if /I "%args%" == "-release" (
	set mode=release
)

if /I "%args%" == "-clean" (
	set mode=clean
)

if not exist "%destPath%" (
	mkdir build
)

if "%mode%" == "debug" (
	set destFile=%destDebug%
	echo.
	echo Assembly build = Debug [BINARY]
	echo Assembling '%source%' to '%destPath%%destFile%'.
	pasmo --bin %source% ./build/%destDebug%
)

if "%mode%" == "release" (
	set destFile=%destRelease%
	echo.
	echo Assembly build = Release [Auto run]
	echo Assembling '%source%' to '%destPath%%destFile%'.
	pasmo --tapbas %source% ./build/%destRelease%
)

if "%mode%" == "clean" (
	rmdir "%destPath%" /S /Q
	echo.
	echo Clean completed.
)

echo.
rem echo Files can be found in '%destPath%%destFile%'.


:end