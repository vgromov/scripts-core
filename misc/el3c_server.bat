echo OFF

if "%1"=="" goto usage

set CURPATH=%cd%

echo Looking for scripting console installation ...

for /r "%ProgramFiles(x86)%" %%a in (*) do (
  if "%%~nxa"=="ess-console.exe" (
    set ESSCON2=%%~dpnxa
    goto essc_found
  )
)

for /r "%ProgramFiles%" %%a in (*) do (
  if "%%~nxa"=="ess-console.exe" (
    set ESSCON2=%%~dpnxa
    goto essc_found
  )
)

echo Could not find ESS scripting console executable
goto exit

:essc_found

if exist "%ESSCON1%" (
	set ESSCON="%ESSCON1%"
	goto main
) 

if exist "%ESSCON2%" (
	set ESSCON="%ESSCON2%"
	goto main
) 

:main
set SCRIPT=%CURPATH%\el3c_server.cesse
rem execute server, call el3c_svr_run(port) function, exit upon function exit.
rem _1 - server listener port
echo Starting server script in console on port %1 ...
%ESSCON% -f "%SCRIPT%" -r -e el3c_svr_run;"%1" -x

goto exit

:usage
echo Scripted EL3C TCP socket server.
echo Pre-requisites: ECO-E scripting console installed
echo Parameters: server listener port
echo Usage example: el3c_server 60000

:exit