@echo off
if %1. == . goto MissingParameter
if %2. == . goto MissingParameter
if %2. == debug.   goto GoodParameter
if %2. == release. goto GoodParameter

echo You must send "debug" or "release" as parameter
goto End

:GoodParameter

set HB_ROOT=C:\hb30
set PATH=%HB_ROOT%\bin;%HB_ROOT%\comp\mingw\bin;%PATH%
set HB_COMPILER=mingw
::set HB_COMPILER=msvc
set HB_PATH=%HB_ROOT%

if not exist "%HB_ROOT%\bin\hbmk2.exe" (
    echo hbmk2 nao encontrado em "%HB_ROOT%\bin"
    goto End
)

if not exist "%1\%2\" md "%1\%2\"
cd /d "%1\%2\"

if /i "%2"=="debug" (
    hbmk2 %1\ACBrConsultaCNPJ.hbp -b
) else (
    hbmk2 %1\ACBrConsultaCNPJ.hbp
)

goto End
:MissingParameter
echo Missing Parameter
:End
