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
rem Check if compiled binary present, and if not, compile it
set CESSE=%CURPATH%\sql2pot.cesse
if not exist "%CESSE%" (
	%ESSCON% -f sql2pot.ess -o "%CESSE%" -c -x
)
set SCRIPT=%CESSE%
rem execute dfm fmx string extractor _1 - input sql dump, _2 - where to put extracted output
%ESSCON% -f "%SCRIPT%" -r -e sql2pot;"%1";"%2" -x

:exit