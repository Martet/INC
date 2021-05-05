@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
:: Main project testing script
::
:: Author: Michal Kekely <ikekelym@fit.vutbr.cz>
:: Date: 31.3.2021

set LOGIN=xlogin00

set WORK_DIR=work
set LOG_DIR=%WORK_DIR%\log
set TB_DIR=vhdl

if [%1] == [] (
    call scripts/unpack.bat
    if !errorlevel! neq 0 exit /b 1
    call scripts/simulate.bat
    call scripts/eval.bat
)

if [%1] == [clean] (
    rd /s /q work >NUL 2>NUL
)
