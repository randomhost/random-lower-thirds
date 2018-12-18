@echo off& setlocal enabledelayedexpansion& set i=%~2& if "%~2"=="" set i=1
set c=& set /a 2>nul c=%i%
if defined c if "%c%"=="%i%" if not exist "%~1\" if exist "%~1" goto args_ok

if not "%~1%~2"=="" echo %~n0: *** file doesn't exist or bad count& exit/b
echo.
echo Outputs unique random file lines to stdout.  paulhoule.com 3/14/2016
echo.& echo Usage:    %~n0 file.txt {cnt}     [cnt defaults to 1]
echo.& echo Blank lines in source file are ignored (never returned).
echo Result lines occur in ascending order from source file.
exit /b

:args_ok
set r=0& for /f "tokens=1* delims==" %%v in ('set r') do set %%v=
set r=0& for /f "delims=" %%f in (%1) do set /a r+=1
(if %c% GTR %r% set c=%r%)& if !c!==0 exit /b

set i=0
:rlp
set /a rb31=!random!*65536+!random!*2+!random!%%2& set /a j=!rb31!%%r+1
(if defined r!j! goto rlp)& set r%j%=.& set /a i+=1& if not !i!==%c% goto rlp
set i=0& for /f "delims=" %%f in (%1) do (set /a i+=1
  if defined r!i! setlocal disabledelayedexpansion& echo %%f& endlocal)
