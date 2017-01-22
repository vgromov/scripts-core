echo OFF
rem Find scripting console
set CURPATH=%cd%
set ESSCON1=d:\Programs\Eco-Electronics\ess-console\ess-console.exe
set ESSCON2=%CURPATH%\..\bin\Win32\Debug\ess-console_ecc18.exe
set ESSCON3=%CURPATH%\..\bin\Win32\Release\ess-console_ecc18.exe

if exist "%ESSCON1%" (
	set ESSCON="%ESSCON1%"
	goto main
) 

if exist "%ESSCON2%" (
	set ESSCON="%ESSCON2%"
	goto main
) 

if exist "%ESSCON3%" (  
	set ESSCON="%ESSCON3%"
	goto main
)	

echo Could not find ess-console.exe
goto exit

:main
rem Check if compiled binary present, and if not, compile it
set CESSE=%CURPATH%\sql2pot.cesse
if not exist "%CESSE%" (
	%ESSCON% -f sql2pot.ess -o "%CESSE%" -c -x
)
set SCRIPT=%CESSE%
rem execute dfm fmx string extractor _1 - input sql dump, _2 - where to put extracted output
%ESSCON% -f "%SCRIPT%" -e sql2pot;"%1";"%2" -x

:exit