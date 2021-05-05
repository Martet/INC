@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
::                   ==============================
::                   Project simulation in ModelSim
::                   ==============================
::
::
:: Author: Michal Kekely <ikekelym@fit.vutbr.cz>
:: Date:  22.3.2021

echo Simulating project:

taskkill /im vlm.exe /f >NUL 2>&1
md %WORK_DIR%\sim >NUL 2>&1
xcopy /s %TB_DIR% %WORK_DIR%\sim >NUL

echo|set /p ="--> basic tests                         "
cd %WORK_DIR%\sim
vsim -c -do uart.fdo >..\..\%LOG_DIR%\sim.log 2>&1
cd ..\..

echo [Done]