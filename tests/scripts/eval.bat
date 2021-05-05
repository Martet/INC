@echo off
::                             ==================
::                             Project evaluation
::                             ==================
::
::
:: Author:  Michal Kekely <ikekelym@fit.vutbr.cz>
:: Date:  22.3.2021

echo|set /p ="Results evaluation                      "

FC %WORK_DIR%\sim\input.txt %WORK_DIR%\sim\output.txt >%LOG_DIR%\eval.log
if %errorlevel% neq 0 (
    echo [Failed]
    echo Error: Unexpected results
    echo ------------------------------------------------------------
		echo -- Comparation of expected outputs vs. actual outputs     --
		echo ------------------------------------------------------------
		type %LOG_DIR%\eval.log
) else (
    echo [Done]
    echo Results are OK
)
