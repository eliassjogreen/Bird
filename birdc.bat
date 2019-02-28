:: The Bird language compiler

@echo off
setlocal EnableDelayedExpansion
setlocal EnableExtensions

set input=%1
set name=%~n1
set /p code=<%input%

set output=%2

set lib=%~dp0^lib\

echo | set /p=> %output%

if "!code:~0,7!" == "library" (
    (
        echo :: Start of library: %name%
        echo :: Compiled using the Bird language compiler
    ) >> %output%
) else (
    (
        echo :: Compiled using the Bird language compiler
        echo @echo off
        echo setlocal EnableDelayedExpansion
        echo setlocal EnableExtensions
        echo call :Main "%%*"
        echo exit /b 0
    ) >> %output%
)

for /f "tokens=* delims= " %%a in (%input%) do (
    set line=%%a

    set word[0]=
    set word[1]=
    set word[2]=
    set word[3]=
    set word[4]=
    set word[5]=

    for /f "tokens=1,2,3,4,5,6 delims= " %%a in ("!line!") do (
        set word[0]=%%a
        set word[1]=%%b
        set word[2]=%%c
        set word[3]=%%d
        set word[4]=%%e
        set word[5]=%%f
    )

    if "!word[0]!" == "library" (
        echo>nul
    ) else if "!line:~0,1!" == "#" (
        (echo ::!line:~1!) >> %output%
    ) else if "!line:~0,1!" == ":" (
        (echo !line:~1!) >> %output%
    ) else if "!word[0]!" == "define" (
        (echo :!word[1]!) >> %output%

        if "!word[2]:~0,1!" == "$" (echo set !word[2]!=%%~1) >> %output%
        if "!word[3]:~0,1!" == "$" (echo set !word[3]!=%%~2) >> %output%
        if "!word[4]:~0,1!" == "$" (echo set !word[4]!=%%~3) >> %output%
        if "!word[5]:~0,1!" == "$" (echo set !word[5]!=%%~4) >> %output%
    ) else if "!word[0]!" == "end" (
        (echo exit /b 0) >> %output%
    ) else if "!word[0]!" == "use" (
        (echo.) >> %output%
        (echo | type "!lib!!word[1]!.blib") >> %output%
        (echo.) >> %output%
    ) else if "!line:~0,1!" == "$"  (
        (echo | set /p=set !word[0]!=) >> %output%
        if "!word[1]!" == "=" (
            if "!word[2]:~0,1!" == "$" (
                (echo | set /p=%%!word[2]!%%) >> %output%
            ) else (
                if not "!word[2]!" == "" (echo | set /p=!word[2]! ) >> %output%
                if not "!word[3]!" == "" (echo | set /p=!word[3]! ) >> %output%
                if not "!word[4]!" == "" (echo | set /p=!word[4]! ) >> %output%
                if not "!word[5]!" == "" (echo | set /p=!word[5]! ) >> %output%
            )
        )
        (echo.) >> %output%
    ) else if not "!word[0]!" == "" (
        if "!word[1]!" == "" (
            (echo | set /p=call :!word[0]!) >> %output%
        ) else (
            (echo | set /p=call :!word[0]! ) >> %output%
        )

        if not "!word[1]!" == "" (
            if "!word[1]:~0,1!" == "$" (
                (echo | set /p=%%!word[1]!%% ) >> %output%
            ) else (echo | set /p=!word[1]! ) >> %output%
        )

        if not "!word[2]!" == "" (
            if "!word[2]:~0,1!" == "$" (
                (echo | set /p=%%!word[2]!%% ) >> %output%
            ) else (echo | set /p=!word[2]! ) >> %output%
        )

        if not "!word[3]!" == "" (
            if "!word[3]:~0,1!" == "$" (
                (echo | set /p=%%!word[3]!%% ) >> %output%
            ) else (echo | set /p=!word[3]! ) >> %output%
        )

        if not "!word[4]!" == "" (
            if "!word[4]:~0,1!" == "$" (
                (echo | set /p=%%!word[4]!%% ) >> %output%
            ) else (echo | set /p=!word[4]! ) >> %output%
        )

        if not "!word[5]!" == "" (
            if "!word[5]:~0,1!" == "$" (
                (echo | set /p=%%!word[5]!%% ) >> %output%
            ) else (echo | set /p=!word[5]! ) >> %output%
        )
        
        (echo.) >> %output%
    )
)

if "!code:~0,7!" == "library" (
    (echo :: End of library: %name%) >> %output%
)