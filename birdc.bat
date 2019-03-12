:: The Bird language compiler

@echo off
setlocal EnableDelayedExpansion
setlocal EnableExtensions

set input=%1
set inpath=%~dp1
set name=%~n1
set /p code=<%input%

set output=%2

set lib=%~dp0^lib\
set isLib=false
set debug=false
if "%3" == "debug" (
    echo Debugging is enabled
    set debug=true
)

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
        echo call :Main _0 "%%*"
        echo exit /b 0
    ) >> %output%
)

set i=0
for /f "tokens=* delims= " %%a in (%input%) do (
    set line=%%a

    set i=0
    for /l %%a in (1,1,32) do (
        set word[!i!]=
        set /a i+=1
    )

    set i=0
    for %%a in (!line!) do (
        set word[!i!]=%%a
        set /a i+=1
    )
    set /a i-=1

    set skip=false
    set return=false
    set callSet=false
    set callCall=false

    for /l %%i in (0,1,!i!) do (
        set word=!word[%%i]!
        set first=!word:~0,1!

        if "!skip!" == "false" (
            if "!word[0]!" == "library" (
                if "!debug!" == "true" echo Library: !name!
                set isLib=true
                set skip=true

                if not "!word[1]!" == "" (
                    set name=!word[1]!
                )
            ) else if "!line:~0,1!" == "#" (
                if "!debug!" == "true" echo Comment: !line!

                set skip=true
                (echo | set /p="::!line:~1!") >> %output%
            ) else if "!line:~0,1!" == ":" (
                if "!debug!" == "true" echo Batch: !line!

                set skip=true
                (echo | set /p="!line:~1!") >> %output%
            ) else if "!first!" == "$" (
                if "%%i" == "0" (
                    if "!debug!" == "true" echo Variable Set: !word!

                    if not "!word[1]!" == "" (
                        if not "!word[1]:~0,1!" == "$" (
                            if not !word[1]:~0^,1!!word[1]:~-1! == "" (
                                if "!debug!" == "true" echo Call: !word[1]!

                                set callSet=true
                                if "!isLib!" == "true" (
                                    (echo | set /p=call :!word[1]! $!name!.!word[0]:~1! ) >> %output%
                                ) else (
                                    (echo | set /p=call :!word[1]! !word[0]! ) >> %output%
                                )
                            )
                        )
                    )

                    if "!callSet!" == "false" (
                        if "!debug!" == "true" echo Setting using no call
                        if "!isLib!" == "true" (
                            (echo | set /p=set $!name!.!word:~1!=) >> %output%
                        ) else (
                            (echo | set /p=set !word!=) >> %output%
                        )
                    )
                ) else if not "!word[0]!" == "define" (
                    if "!debug!" == "true" echo Variable Get: !word!
                    if not "!word[1]:~0,1!" == "$" (
                        (echo | set /p=""^^!!word!^^!" ") >> %output%
                    ) else (
                        (echo | set /p=""^^!!word!^^!"") >> %output%
                    )
                )
            ) else if !word:~0^,1!!word:~-1! == "" (
                if "!debug!" == "true" echo Value: !word!

                (echo | set /p="!word! ") >> %output%
            ) else if "!word!" == "use" (
                if "%%i" == "0" (
                    for /l %%j in (1,1,!i!) do (
                        if "!debug!" == "true" echo Use: !word[%%j]!
                        if exist "!lib!!word[%%j]!.blib" (
                            (echo.) >> %output%
                            (echo | type "!lib!!word[%%j]!.blib") >> %output%
                            (echo.) >> %output%
                        ) else if !word[%%j]:~0^,1!!word[%%j]:~-1! == "" (
                            set word[%%j]=!word[%%j]:"=!
                            echo !inpath!!word[%%j]!.blib
                            if exist "!inpath!!word[%%j]!.blib" (
                                (echo.) >> %output%
                                (echo | type "!inpath!!word[%%j]!.blib") >> %output%
                                (echo.) >> %output%
                            ) else if exist "!inpath!!word[%%j]!" (
                                (echo.) >> %output%
                                (echo | type "!inpath!!word[%%j]!") >> %output%
                                (echo.) >> %output%
                            ) else (
                                if "!debug!" == "true" echo Library: !word[%%j]! cannot be found
                            )
                        ) else (
                            if "!debug!" == "true" echo Library: !word[%%j]! does not exist
                        )
                    )
                )
            ) else if "!word!" == "define" (
                if "%%i" == "0" (
                    if "!debug!" == "true" echo Define: !word[1]!

                    if not "!word[2]!" == "" (
                        if "!isLib!" == "true" (
                            (echo :!name!.!word[1]!) >> %output%
                        ) else (
                            (echo :!word[1]!) >> %output%
                        )
                    ) else (
                        if "!isLib!" == "true" (
                            (echo | set /p=:!name!.!word[1]!) >> %output%
                        ) else (
                            (echo | set /p=:!word[1]!) >> %output%
                        )
                    )

                    for /l %%j in (2,1,!i!) do (
                        if "!word[%%j]:~0,1!" == "$" (
                            if "%%j" == "!i!" (
                                (echo | set /p=set !word[%%j]!=%%~%%j) >> %output%
                            ) else (
                                (echo set !word[%%j]!=%%~%%j) >> %output%
                            )
                        )
                    )
                )
            ) else if "!word!" == "end" (
                if "%%i" == "0" (
                    if "!debug!" == "true" echo End

                    (echo exit /b 0) >> %output%
                )
            ) else if "!word!" == "return" (
                if "%%i" == "0" (
                    set return=true
                    if not "!word[1]!" == "" (
                        if "!debug!" == "true" echo Return: !line!

                        (echo | set /p=set %%~1=) >> %output%
                    ) else (
                        if "!debug!" == "true" echo Return
                    )
                )
            ) else if not "!word!" == "" (
                if "%%i" == "0" (
                    if not "!word[1]!" == "" (
                        if not "!word[1]:~0,1!" == "$" (
                            if not !word[1]:~0^,1!!word[1]:~-1! == "" (
                                if "!debug!" == "true" echo Call: !word[1]!

                                set callCall=true
                                (echo | set /p=call :!word[1]! _1 ) >> %output%
                            )
                        )
                    )

                    if "!callCall!" == "false" (
                        if "!debug!" == "true" echo Call: !word[0]!
                        (echo | set /p=call :!word[0]! _0 ) >> %output%
                    )
                )
            )
        )
    )

    (echo.) >> %output%

    if "!callCall!" == "true" (
        if "!debug!" == "true" echo Call: !word[0]!
        (echo set _1=^^!_1:^"=^^!) >> %output%
        (echo call :!word[0]! _0 ^"^^!_1^^!^") >> %output%
    )
    if "!callSet!" == "true" (
        (echo set !word[0]!=^^!!word[0]!:^"=^^!) >> %output%
    )
    if "!return!" == "true" (
        (echo exit /b 0) >> %output%
    )
)

if "!code:~0,7!" == "library" (
    (echo.) >> %output%
    (echo :: End of library: %name%) >> %output%
)
