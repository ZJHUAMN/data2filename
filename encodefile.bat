@echo off
echo.
echo         %~nx0 By ��ʱqwq https://space.bilibili.com/431304449
echo.
echo �����ٶ�:	Լ33KB/s
echo ��������:	Լ21�ļ�/KB
if "%1" == "" echo �÷�: %~nx0 �����ܵ��ļ� & goto :EOF
echo �ļ�����:	%~nx1
set /a FILESIZE=%~z1/1000
echo �ļ���С:	%FILESIZE%KB
set /a COMPILETIME=%~z1/33000
echo Լ��ʱ��:	%COMPILETIME%��
set RAND=%RANDOM%
set FILENAME=%~nx1
for /f "delims=" %%i in ('certutil -encode "%~1" .\file%RAND%.tmp ^| findstr /c:"������� ="') do (set OUTSIZE=%%i)
set /a OUTSIZE=%OUTSIZE:~7%/1024
echo �����С:	%OUTSIZE%KB
mkdir %FILENAME%_encode >nul

echo [INFO] ���ڼ����ļ���ϣֵ...
for /f "delims=" %%i in ('certutil -hashfile %1 MD5 ^| findstr /V ��ϣ ^| findstr /V ���') do (cd. > .\%FILENAME%_encode\hash_%%i) 

echo [INFO] ���ڷֽ��ļ�...
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
echo [INFO] �ֽ����!