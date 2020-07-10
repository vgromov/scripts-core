echo OFF
rem Find scripting console
set CURPATH=%~dp0

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
rem Check if compiled binary present, and if not, compile it
set CESSE=c:%HOMEPATH%\ECO-E\cesse
if not exist "%CESSE%\dfmfmx2pot.cesse" (
	%ESSCON% -f "%CURPATH%\dfmfmx2pot.ess" -o "%CESSE%" -c -x
)

set SCRIPT=%CESSE%\dfmfmx2pot.cesse
rem execute dfm fmx string extractor _1 - input lookup path, _2 - which properties to look up, _3 - where to put extracted output
%ESSCON% -f "%SCRIPT%" -r -e dfmfmx2pot;"%1";"%2";"%3" -x

:exit