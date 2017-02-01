rem echo OFF
rem Find scripting console
set CURPATH=%cd%

for /r "D:\Programs\Eco-Electronics" %%a in (*) do (
  if "%%~nxa"=="ess-console.exe" (
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

set ESSCON3=%CURPATH%\..\bin\Win32\Debug\ess-console_ecc18.exe
set ESSCON4=%CURPATH%\..\bin\Win32\Release\ess-console_ecc18.exe

:essc_found

if defined ESSCON1 (
	set ESSCON="%ESSCON1%"
	goto main
) 

if defined ESSCON2 (
	set ESSCON="%ESSCON2%"
	goto main
) 

if exist "%ESSCON3%" (  
	set ESSCON="%ESSCON3%"
	goto main
)	

if exist "%ESSCON4%" (  
	set ESSCON="%ESSCON4%"
	goto main
)	

echo Could not find ess-console.exe
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