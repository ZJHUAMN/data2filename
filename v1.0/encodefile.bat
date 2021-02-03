::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSTk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJGyX8VAjFBdRQguUM1eeA6YX/Ofr0++JoUIZUeQ2dIqV36yLQA==
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
echo.
echo         %~nx0 By 延时qwq https://space.bilibili.com/431304449
echo.
echo 生成速度:	约33KB/s
echo 生成数量:	约21文件/KB
if "%1" == "" echo 用法: %~nx0 待加密的文件 & goto :EOF
echo 文件名称:	%~nx1
set /a FILESIZE=%~z1/1000
echo 文件大小:	%FILESIZE%KB
set /a COMPILETIME=%~z1/33000
echo 约需时间:	%COMPILETIME%秒
set RAND=%RANDOM%
set FILENAME=%~nx1
for /f "delims=" %%i in ('certutil -encode "%~1" .\file%RAND%.tmp ^| findstr /c:"输出长度 ="') do (set OUTSIZE=%%i)
set /a OUTSIZE=%OUTSIZE:~7%/1024
echo 输出大小:	%OUTSIZE%KB
mkdir %FILENAME%_encode >nul

echo [INFO] 正在计算文件哈希值...
for /f "delims=" %%i in ('certutil -hashfile %1 MD5 ^| findstr /V 哈希 ^| findstr /V 完成') do (cd. > .\%FILENAME%_encode\hash_%%i) 

echo [INFO] 正在分解文件...
setlocal enabledelayedexpansion
set COUNT=0
for /f "skip=1 delims=" %%i in ('type .\file%RAND%.tmp') do (
	set FILEDATA=%%i
	set FILEDATA=!FILEDATA:/=-!
	cd. > ".\%FILENAME%_encode\data%RAND%_!COUNT!_!FILEDATA!"
	set /a COUNT=!COUNT!+1
)
set /a COUNT=%COUNT%-1
del /f /q ".\%FILENAME%_encode\data%RAND%_%COUNT%_-----END CERTIFICATE-----" >nul
del /f /q .\file%RAND%.tmp >nul
set /a COUNT=%COUNT%-1
cd. > ".\%FILENAME%_encode\index_%RAND%_%COUNT%"
cd. > ".\%FILENAME%_encode\filename_%FILENAME%"
echo [INFO] 分解完成!