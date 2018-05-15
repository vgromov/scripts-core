rem echo OFF
rem Find scripting console
set CURPATH=%cd%
set ESSCON0=%ProgramFiles%\ECO-E\ess-console32\ess-console32.exe
set ESSCON1=%ProgramFiles(x86)%\ECO-E\ess-console32\ess-console32.exe
set ESSCON3=%ProgramFiles(x86)%\ECO-E\ess console32\ess-console.exe
set ESSCON2=%CURPATH%\..\bin\Win32\Debug\ess-console_ecc25.exe

if exist "%ESSCON0%" (
	set ESSCON="%ESSCON0%"
	goto main
)

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
rem Check if hex converter present, and if not, compile it
set CESSE=c:%HOMEPATH%\Eco-Electronics\cesse
if not exist "%CESSE%\esFwQuartaConverter.cesse" (
	%ESSCON% -i "%~dp1/../scripts-core/fwUtils" -f esFwQuartaConverter.ess -o "%CESSE%" -c -x
)
set HEX2BIN_SCRIPT=%CESSE%\esFwQuartaConverter.cesse
rem execute binary converter _1 - input hex file, _2 - output compiled fw
%ESSCON% -f "%HEX2BIN_SCRIPT%" -e convert;"%1";"%~dp1bin.ess" -r -x
rem finally, compile firmware binary, save encrypted file
set FW_ESS=%~dp1%~n1.ess
%ESSCON% -i "%~dp1/../scripts-core" -f "%FW_ESS%" -o %2 -c -x
rem del /Q "%~dp1bin.ess"

:exit