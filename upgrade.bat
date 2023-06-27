@echo off

echo Starts upgrade...

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
call :downloadFile networks/devnet/root/config/el/config.toml
call :downloadFile networks/devnet/root/config/el/genesis.json
call :downloadFile networks/devnet/agora.bat
call :downloadFile networks/devnet/agora.sh
call :downloadFile networks/devnet/docker-compose.yml
call :downloadFile networks/devnet/docker-compose-monitoring.yml

call :downloadFile agora.bat
call :downloadFile agora.sh

call :stopNodes
call :moveStorage

echo Completed upgrade...

goto :end


:stopNodes

echo Stops BOSagora nodes ...
set RUN_MAIN_NET_OLD=0
for /f "tokens=1" %%i in ('docker-compose ls ^| find /i /c "agora-chain-mainnet"') do set RUN_MAIN_NET_OLD=%%i
if not "%RUN_MAIN_NET_OLD%" == "0" (
  call agora.bat docker-compose-monitoring down
)
set RUN_TEST_NET_OLD=0
for /f "tokens=1" %%i in ('docker-compose ls ^| find /i /c "agora-chain-testnet"') do set RUN_TEST_NET_OLD=%%i
if not "%RUN_TEST_NET_OLD%" == "0" (
  call agora.bat docker-compose-monitoring down
)
set RUN_MAIN_NET=0
for /f "tokens=1" %%i in ('docker-compose ls ^| find /i /c "mainnet"') do set RUN_MAIN_NET=%%i
if not "%RUN_MAIN_NET%" == "0" (
  call agora.bat docker-compose-monitoring down
)
set RUN_TEST_NET=0
for /f "tokens=1" %%i in ('docker-compose ls ^| find /i /c "testnet"') do set RUN_TEST_NET=%%i
if not "%RUN_TEST_NET%" == "0" (
  call agora.bat docker-compose-monitoring down
)
set RUN_DEV_NET=0
for /f "tokens=1" %%i in ('docker-compose ls ^| find /i /c "devnet"') do set RUN_DEV_NET=%%i
if not "%RUN_DEV_NET%" == "0" (
  call agora.bat docker-compose-monitoring down
)
goto :end

:moveStorage
set FILENAME=root\config\el\genesis.json
if exist "%FILENAME%" (
  echo Starts migration ...
  set CHAIN_ID_MAIN_NET=0
  for /f "tokens=1 delims=:" %%i in ('findstr /n 2151 %FILENAME%') do set CHAIN_ID_MAIN_NET=%%i
  if not "%CHAIN_ID_DEV_NET%" == "0" (
    xcopy root\chain\*.* networks\mainnet\root\chain\ /s /c /y /i /h /q
    xcopy root\wallet\*.* networks\mainnet\root\chain\ /s /c /y /i /h /q
    copy root\config\cl\password.txt networks\mainnet\root\config\cl\password.txt /y
    copy root\config\cl\proposer_config.json networks\mainnet\root\config\cl\proposer_config.json /y
    del /q docker-compose.yml
    del /q docker-compose-monitoring.yml
    rename root .root
    call agora.bat mainnet
  ) else (
    set CHAIN_ID_TEST_NET=0
    for /f "tokens=1 delims=:" %%i in ('findstr /n 2019 %FILENAME%') do set CHAIN_ID_TEST_NET=%%i
    echo %CHAIN_ID_TEST_NET%
    if not "%CHAIN_ID_TEST_NET%" == "0" (
      xcopy root\chain\*.* networks\testnet\root\chain\  /s /c /y /i /h /q
      xcopy root\wallet\*.* networks\testnet\root\chain\  /s /c /y /i /h /q
      copy root\config\cl\password.txt networks\testnet\root\config\cl\password.txt /y
      copy root\config\cl\proposer_config.json networks\testnet\root\config\cl\proposer_config.json /y
      rename root .root
      del /q docker-compose.yml
      del /q docker-compose-monitoring.yml
      call agora.bat testnet
    ) else (
      set CHAIN_ID_DEV_NET=0
      for /f "tokens=1 delims=:" %%i in ('findstr /n 1337 %FILENAME%') do set CHAIN_ID_DEV_NET=%%i
      echo %CHAIN_ID_DEV_NET%
      if not "%CHAIN_ID_DEV_NET%" == "0" (
        xcopy root\chain\*.* networks\devnet\root\chain\  /s /c /y /i /h /q
        xcopy root\wallet\*.* networks\devnet\root\chain\  /s /c /y /i /h /q
        copy root\config\cl\password.txt networks\devnet\root\config\cl\password.txt /y
        copy root\config\cl\proposer_config.json networks\devnet\root\config\cl\proposer_config.json /y
        rename root .root
        del /q docker-compose.yml
        del /q docker-compose-monitoring.yml
        call agora.bat devnet
      )
    )
  )
  echo Completed migration ...
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
