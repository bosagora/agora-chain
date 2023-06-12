@echo off

echo agora.bat version 2.0.0

set MAINNET=mainnet
set TESTNET=testnet
set DEVNET=devnet

set current_path=%cd%
set script_path=%~dp0

if not exist "networks" (

  echo Starts install ...

  echo Creating folds ...
  call :createFolder networks
  call :createFolder networks\mainnet
  call :createFolder networks\testnet
  call :createFolder networks\devnet

  call :createFolder networks\mainnet\monitoring
  call :createFolder networks\mainnet\monitoring\dashboard
  call :createFolder networks\mainnet\monitoring\prometheus
  call :createFolder networks\mainnet\root
  call :createFolder networks\mainnet\root\config
  call :createFolder networks\mainnet\root\config\cl
  call :createFolder networks\mainnet\root\config\el

  call :createFolder networks\testnet\monitoring
  call :createFolder networks\testnet\monitoring\dashboard
  call :createFolder networks\testnet\monitoring\prometheus
  call :createFolder networks\testnet\root
  call :createFolder networks\testnet\root\config
  call :createFolder networks\testnet\root\config\cl
  call :createFolder networks\testnet\root\config\el

  call :createFolder networks\devnet\monitoring
  call :createFolder networks\devnet\monitoring\dashboard
  call :createFolder networks\devnet\monitoring\prometheus
  call :createFolder networks\devnet\root
  call :createFolder networks\devnet\root\config
  call :createFolder networks\devnet\root\config\cl
  call :createFolder networks\devnet\root\config\el

  echo Downloading files used on the main network ...
  call :downloadFile networks/mainnet/monitoring/dashboard/agora-chain-dashboard.json
  call :downloadFile networks/mainnet/monitoring/prometheus/config.yml
  call :downloadFile networks/mainnet/root/config/cl/chain-config.yaml
  call :downloadFile networks/mainnet/root/config/cl/config.yaml
  call :downloadFile networks/mainnet/root/config/cl/password.txt
  call :downloadFile networks/mainnet/root/config/cl/proposer_config.json
  call :downloadFile networks/mainnet/root/config/el/config.toml
  call :downloadFile networks/mainnet/root/config/el/genesis.json
  call :downloadFile networks/mainnet/agora.bat
  call :downloadFile networks/mainnet/agora.sh
  call :downloadFile networks/mainnet/docker-compose.yml
  call :downloadFile networks/mainnet/docker-compose-monitoring.yml

  echo Downloading files used on the test network ...
  call :downloadFile networks/testnet/monitoring/dashboard/agora-chain-dashboard.json
  call :downloadFile networks/testnet/monitoring/prometheus/config.yml
  call :downloadFile networks/testnet/root/config/cl/chain-config.yaml
  call :downloadFile networks/testnet/root/config/cl/config.yaml
  call :downloadFile networks/testnet/root/config/cl/password.txt
  call :downloadFile networks/testnet/root/config/cl/proposer_config.json
  call :downloadFile networks/testnet/root/config/el/config.toml
  call :downloadFile networks/testnet/root/config/el/genesis.json
  call :downloadFile networks/testnet/agora.bat
  call :downloadFile networks/testnet/agora.sh
  call :downloadFile networks/testnet/docker-compose.yml
  call :downloadFile networks/testnet/docker-compose-monitoring.yml

  echo Downloading files used on the development network ...
  call :downloadFile networks/devnet/monitoring/dashboard/agora-chain-dashboard.json
  call :downloadFile networks/devnet/monitoring/prometheus/config.yml
  call :downloadFile networks/devnet/root/config/cl/chain-config.yaml
  call :downloadFile networks/devnet/root/config/cl/config.yaml
  call :downloadFile networks/devnet/root/config/cl/password.txt
  call :downloadFile networks/devnet/root/config/cl/proposer_config.json
  call :downloadFile networks/devnet/root/config/el/config.toml
  call :downloadFile networks/devnet/root/config/el/genesis.json
  call :downloadFile networks/devnet/agora.bat
  call :downloadFile networks/devnet/agora.sh
  call :downloadFile networks/devnet/docker-compose.yml
  call :downloadFile networks/devnet/docker-compose-monitoring.yml

  call :downloadFile agora.bat
  call :downloadFile agora.sh

  echo Completed install ...

  goto :end

)

call :getNetwork

if "%~1"=="upgrade" (

  curl -f -s -S -L -o upgrade.bat https://raw.githubusercontent.com/bosagora/agora-chain/v0.x.x/upgrade.bat
  call upgrade.bat

) else if "%~1" == "network" (
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

:createFolder
if not exist %~1 (
    mkdir %~1
)
goto :end

:downloadFile
curl https://raw.githubusercontent.com/bosagora/agora-chain/v0.x.x/%~1 -f -s -S -L -o %~1
goto :end

:end
