@echo off
setlocal EnableDelayedExpansion
setlocal EnableExtensions

set in=%2
set out=%3

if "%1"=="compile" (
	goto :compile
) else if "%1"=="run" (
	goto :run
) else if "%1"=="install" (
	goto :install
) else (
	goto :help
)

:compile
if "%in%" == "" (
	echo No input specified
) else if "%out%" == "" (
	echo No output specified
) else (
	.\birdc.bat %in% %out%
)
goto :eof

:run
set out=.\tmp.bat
call :compile
shift
shift
shift
:: echo Running %in%
call .\tmp.bat %0 %1 %2 %3 %4 %5 %6 %7 %8 %9
del .\tmp.bat
goto :eof

:install
if "%2"=="" (
	echo Compiling libraries...
	for /r %%f in (lib\*.bird) do @(
	    echo Compiling %%~nf...
	    .\birdc.bat lib\%%~nxf lib\%%~nf.blib
		echo Compiled %%~nf!
	)
) else (
	for %%f in ("%2") do @(
		echo Downloading %%~nxf...
		powershell -Command "(New-Object Net.WebClient).DownloadFile('"%%~f"', '"%~dp0^lib\%%~nxf"')"
		echo Downloaded^^!

		if "%%~xf" == ".bird" (
			echo Compiling...
			.\birdc.bat lib\%%~nxf lib\%%~nf.blib
			echo Compiled %%~nf!
		)
	)
)
echo Done!
goto :eof

:help
echo Commands:
echo     compile ^<input file^> ^<output file^> - Compiles a bird file into batch
echo     run ^<input file^>                   - Runs a bird file without creating a file
echo     install ^<link to file?^>            - Downloads and compiles file if link is supplied else compiles libraries directory
goto :eof
