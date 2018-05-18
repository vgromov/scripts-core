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
	%ESSCON% -i "%~dp1scripts-core/fwUtils" -f esFwQuartaConverter.ess -o "%CESSE%" -c -x
)

set BIN2SCRIPT=%CESSE%\esFwQuartaConverter.cesse

rem execute binary converter _1 - input bin file base name without version suffix, _2 - version suffix, _3 - folder to output compiled fw
rem create temporary ess file with version suffix
set FW_BIN=%1.bin
set FW_ESS_BASE=%~dp1%~n1.ess
set FW_ESS=%~dp1%~n1.%2.ess
set FW_BIN_ESS="%~dp1bin.ess"
copy /Y %FW_ESS_BASE% %FW_ESS%

%ESSCON% -f "%BIN2SCRIPT%" -e convert;"%FW_BIN%";"%FW_BIN_ESS%" -r -x

rem finally, compile firmware binary, save encrypted file
%ESSCON% -i "%~dp1scripts-core" -f "%FW_ESS%" -o %3 -c -x

rem delete temporary stuff
del /Q "%FW_BIN_ESS%"
del /Q "%FW_ESS%"

:exit