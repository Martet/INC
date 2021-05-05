@echo off
::                             =================
::                             Project unpacking
::                             =================
::
::
:: Author:  Michal Kekely <ikekelym@fit.vutbr.cz>
:: Date:  22.3.2021

set ZIP_CONTENT=( ^
    uart.vhd ^
    uart_fsm.vhd ^
    zprava.pdf ^
)

echo|set /p ="Unpack archive                          "

taskkill /im fkterm.exe /f >NUL 2>&1
taskkill /im vlm.exe /f >NUL 2>&1
if exist %WORK_DIR% rd /s /q %WORK_DIR% >NUL 2>&1
md %WORK_DIR% >NUL 2>&1
md %LOG_DIR%  >NUL 2>&1
copy /y %LOGIN%.zip %WORK_DIR% >NUL

unzip %WORK_DIR%\%LOGIN%.zip -d %WORK_DIR% >%LOG_DIR%\unpack.log 2>&1
if %errorlevel% neq 0 echo [Failed] & exit /b 1
del %WORK_DIR%\%LOGIN%.zip

echo Missing files: >>%LOG_DIR%\unpack.log
set ZIP_OK=1
for %%f in %ZIP_CONTENT% do if not exist %WORK_DIR%\%%f echo   %%f >>%LOG_DIR%\unpack.log & set ZIP_OK=0
if %ZIP_OK% neq 1 echo [Failed]& exit /b 1
echo [Done]