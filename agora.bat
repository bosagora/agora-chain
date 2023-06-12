@echo off

echo agora.bat version 2.0.0

set MAINNET=mainnet
set TESTNET=testnet
set DEVNET=devnet

set current_path=%cd%
set script_path=%~dp0

call :getNetwork

if "%~1" == "network" (
  if "%~2" == "%MAINNET%" (
    set network=%~2
    echo %~2>%script_path%.network
    echo Current network is %~2
  ) else if "%~2" == "%TESTNET%" (
    set network=%~2
    echo %~2>%script_path%.network
    echo Current network is %~2
  ) else if "%~2" == "%DEVNET%" (
    set network=%~2
    echo %~2>%script_path%.network
    echo Current network is %~2
  ) else (
    echo Current network is %network%
  )
  goto :end
)

if %network% == %MAINNET% (
  call :runScript %*
) else if %network% == %TESTNET% (
  goto :runScript %*
) else if %network% == %DEVNET% (
  goto :runScript %*
) else (
  echo [31mNetwork '%network%' is not available![0m
  exit /B 1
)

goto :end

:runScript
set network_path=%script_path%networks\%network%
cd %network_path%
call agora.bat %*
cd %current_path%
goto :end

:getNetwork
if not exist ".network" (
  set network=%MAINNET%
) else (
  for /F "delims=" %%x in (.network) do (
    if "%%x" equ "%MAINNET%" (
      set network=%MAINNET%
    ) else if "%%x" equ "%TESTNET%" (
      set network=%TESTNET%
    ) else if "%%x" equ "%DEVNET%" (
      set network=%DEVNET%
    )
  )
)
if "%network%" == "" (
  set network=%MAINNET%
)
goto :end

:end
