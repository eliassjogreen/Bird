@echo off
echo Compiling libraries...
for /r %%f in (.\lib\*.bird) do (
    echo compiling %%~nf...
    .\birdc.bat .\lib\%%~nxf .\lib\%%~nf.blib rem debug
)
echo Done!
