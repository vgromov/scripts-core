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

for /r "%ProgramFiles(x86)%" %%a in (*) do (
  if "%%~nxa"=="ess-console32.exe" (
    set ESSCON2=%%~dpnxa
    goto essc_found
  )
)

for /r "%ProgramFiles%" %%a in (*) do (
  if "%%~nxa"=="ess-console64.exe" (
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
echo ON
rem Check if compiled binary present, and if not, compile it
set CESSE=c:%HOMEPATH%\ECO-E\cesse
if not exist "%CESSE%\utf8_2c_esc.cesse" (
	%ESSCON% -f scripts-core\misc\utf8_2c_esc.ess -o "%CESSE%" -c -x
)

set SCRIPT=%CESSE%\utf8_2c_esc.cesse
rem execute utf8 string escaper _1 - input *.strings.cc.in file
%ESSCON% -f "%SCRIPT%" -r -e utf8_2c_esc;"%1" -x

:exit