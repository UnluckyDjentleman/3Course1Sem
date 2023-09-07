@echo off
echo Parameters: %*
echo Mode: %1
echo File: %2
::Remark
if "%1" equ "" (
echo ----+z03-06
echo mode = {create; remove}
echo file = {file name}
goto exit
)
::wrong mode
if not "%1" equ "remove" if not "%1" equ "create" if not "%2" equ "" (
echo ----+wrong mode
goto exit
)
::file not found for "remove"
if "%1" equ "remove" if not "%1" equ "" if not "%2" equ "" if not exist "%2" (
	echo ---+ file not found
	goto EXIT
)
::existed file
if "%1" equ "create" if exist "%2" (
	echo ---+ such file already exists
	goto EXIT
)
:: Error if name not found
if "%1" equ "remove" if "%2" equ "" (
	echo ---+ please, set the name
	goto EXIT
)
if "%1" equ "create" if "%2" equ "" (
	echo ---+ please? set the name
	goto EXIT
)


::succesful create
if "%1" equ "create" (
	copy /y NUL %2 >NUL
	echo ---+ file was created
)

:: successful delete
if "%1" equ "remove" (
	del "%2"
	echo ---+ file was removed
)



:EXIT