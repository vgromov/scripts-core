rem echo OFF
rem Find scripting console
set CURPATH=%cd%

for /r "%ProgramFiles(x86)%\ECO-E" %%a in (*) do (
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
rem Check if compiled binary present, and if not, compile it
set CESSE=%CURPATH%\dfmfmx2pot.cesse
if not exist "%CESSE%" (
	%ESSCON% -f dfmfmx2pot.ess -o "%CESSE%" -c -x
)
set SCRIPT=%CESSE%
rem execute dfm fmx string extractor _1 - input lookup path, _2 - which properties to look up, _3 - where to put extracted output
%ESSCON% -f "%SCRIPT%" -e dfmfmx2pot;"%1";"%2";"%3" -x

:exit