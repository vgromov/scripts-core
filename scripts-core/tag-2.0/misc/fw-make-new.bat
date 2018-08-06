echo OFF
rem Find scripting console
set CURPATH=%cd%

for /r "D:\Programs\Eco-Electronics" %%a in (*) do (
  if "%%~nxa"=="ess-console.exe" (
    set ESSCON1=%%~dpnxa
    goto essc_found
  )
)

for /r "D:\Programs\ECO-E" %%a in (*) do (
  if "%%~nxa"=="ess-console32.exe" (
    set ESSCON1=%%~dpnxa
    goto essc_found
  )
)

for /r "D:\Programs\ECO-E" %%a in (*) do (
  if "%%~nxa"=="ess-console64.exe" (
    set ESSCON1=%%~dpnxa
    goto essc_found
  )
)

for /r "%ProgramFiles%" %%a in (*) do (
  if "%%~nxa"=="ess-console.exe" (
    set ESSCON2=%%~dpnxa
    goto essc_found
  )
)

for /r "%ProgramFiles%\ECO-E" %%a in (*) do (
  if "%%~nxa"=="ess-console32.exe" (
    set ESSCON2=%%~dpnxa
    goto essc_found
  )
)

for /r "%ProgramFiles%\ECO-E" %%a in (*) do (
  if "%%~nxa"=="ess-console64.exe" (
    set ESSCON2=%%~dpnxa
    goto essc_found
  )
)

:essc_found

if defined ESSCON1 (
	set ESSCON="%ESSCON1%"
	goto main
) 

if defined ESSCON2 (
	set ESSCON="%ESSCON2%"
	goto main
) 

echo Could not find ESS scripting console executable
goto exit

:main
rem Check if hex converter present, and if not, compile it
set CESSE=c:%HOMEPATH%\ECO-E\cesse
if not exist "%CESSE%\esFwConverter.cesse" (
	%ESSCON% -i "%~dp1/../scripts-core/fwUtils" -f esFwConverter.ess -o "%CESSE%" -c -x
)
set HEX2BIN_SCRIPT=%CESSE%\esFwConverter.cesse
rem execute binary converter _1 - input hex file, _2 - output compiled fw
%ESSCON% -f "%HEX2BIN_SCRIPT%" -r -e convert;"%1";"%~dp1bin.ess" -r -x
rem finally, compile firmware binary, save encrypted file
set FW_ESS=%~dp1%~n1.ess
%ESSCON% -i "%~dp1/../scripts-core" -f "%FW_ESS%" -o %2 -c -x
rem del /Q "%~dp1bin.ess"

:exit