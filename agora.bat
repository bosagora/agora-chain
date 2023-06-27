@echo off

echo agora.bat version 2.0.0

set MAINNET=mainnet
set TESTNET=testnet
set DEVNET=devnet

set current_path=%cd%
set script_path=%~dp0

if not exist "networks" (

  echo Starts install ...

  echo Stops BOSagora nodes ...
  agora.bat docker-compose-monitoring down

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

  call :moveStorage

  echo Completed install ...

  goto :end

)

if "%~1"=="" (
  goto printHelp
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

echo The selected network is '%network%'
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

:printHelp
echo [31mUsage: agora.bat PROCESS FLAGS.[0m
echo [31mPROCESS can be el-node, cl-node, validator, docker-compose, docker-compose-monitoring, start, stop, exec, upgrade.[0m
echo.
echo [33magora.bat network ^< network to change ^>[0m
echo        - ^< network to change ^> is one of mainnet, testnet, and devnet, and the default is mainnet.
echo        - If ^< network to change ^> is not specified, it shows the currently set up network.
echo.
echo [33magora.bat el-node ( init, run )[0m
echo [34m    el-node init[0m
echo        - Initialize agora-el. At this point, all existing block data is deleted.
echo [34m    el-node run[0m
echo        - Run agora-el.
echo.
echo [33magora.bat cl-node ( run )[0m
echo [34m    cl-node run[0m
echo        - Run agora-cl.
echo.
echo [33magora.bat validator ( accounts, exit, withdraw, slashing-protection-history, wallet )[0m
echo.
echo [33magora.bat validator accounts ( import, list, backup  )[0m
echo [34m    validator accounts import ^<validator keys folder^>[0m
echo        - Add the validator's keys to the local wallet.
echo [34m    validator accounts list[0m
echo        - Show the validator's keys stored in the local wallet.
echo [34m    validator accounts delete[0m
echo        - Delete the validator's keys from the local wallet.
echo [34m    validator accounts backup ^<validator keys folder^>[0m
echo        - Back up the validator's keys stored in the local wallet.
echo.
echo [34m    validator exit[0m
echo        - Used to voluntarily exit the validator's function. After this is done, you will see a screen where you select the validator's keys.
echo [34m    validator withdraw ^<data folder^>[0m
echo        - Send pre-created withdrawal address registration data to the network.
echo        - Currently, only devnet is supported. Other networks will be supported later.
echo.
echo [33magora.bat validator slashing-protection-history ( export, import )[0m
echo [34m    validator slashing-protection-history export ^<data folder^>[0m
echo        - Save the information that the verifiers worked on as a file. At this point, the validator on the current server must be stopped.
echo        - One validator must validate only once per block. Otherwise, the validator may be slashed.
echo            - If a validator runs on multiple servers, that validator may violate the above condition.
echo            - If a validator's server is changed to another server, the validator may violate the above condition.
echo            - To avoid this, you need to transfer the block verification information that the validators has performed so far.
echo [34m    validator slashing-protection-history import ^<data folder^>[0m
echo        - Register block verification information performed by validators.
echo.
echo [33magora.bat validator wallet ( create, recover )[0m
echo [34m    validator wallet create ^<wallet folder^>[0m
echo        - Create an HD wallet.
echo [34m    validator wallet create ^<wallet folder^>[0m
echo        - Recovery an HD wallet.
echo.
echo [33magora.bat deposit-cli ( new-mnemonic, existing-mnemonic, generate-bls-to-execution-change )[0m
echo [34m    deposit-cli new-mnemonic[0m
echo        - This command is used to generate keystores with a new mnemonic..
echo [34m    deposit-cli existing-mnemonic[0m
echo        - This command is used to re-generate or derive new keys from your existing mnemonic.
echo [34m    deposit-cli generate-bls-to-execution-change ^<data folder^>[0m
echo        - Generates the data required to register the address to which the validator's amount will be withdrawn.
echo        - Currently, only devnet is supported. Other networks will be supported later.
echo.
echo [33magora.bat docker-compose ( up, down )[0m
echo [34m    docker-compose up[0m
echo        - Run agora-el, agora-cl, validator.
echo [34m    docker-compose down[0m
echo        - Stop agora-el, agora-cl, validator.
echo.
echo [33magora.bat docker-compose-monitoring ( up, down )[0m
echo [34m    docker-compose-monitoring up[0m
echo        - Run agora-el, agora-cl, validator, and containers required for monitoring.
echo [34m    docker-compose-monitoring down[0m
echo        - Stop agora-el, agora-cl, validator, and containers required for monitoring.
echo.
echo [33magora.bat start[0m
echo        - Run agora-el, agora-cl, validator, and containers required for monitoring.
echo        - It's the same as 'agora.bat docker-compose-monitoring up'"
echo.
echo [33magora.bat stop[0m
echo        - Stop agora-el, agora-cl, validator, and containers required for monitoring.
echo        - It's the same as 'agora.bat docker-compose-monitoring down'
echo.
echo [33magora.bat exec ( el-node, cl-node, cl-validator, cl-ctl )[0m
echo [34m    exec el-node[0m
echo        - Run agora-el-node with user-entered parameters.
echo [34m    exec cl-node[0m
echo        - Run agora-cl-node with user-entered parameters.
echo [34m    exec cl-validator[0m
echo        - Run agora-cl-validator with user-entered parameters.
echo [34m    exec cl-ctl[0m
echo        - Run agora-cl-ctl with user-entered parameters.
echo.
echo [33magora.bat upgrade[0m
echo        - The latest version is installed, at which point the user data is preserved.
exit /B 1

:end
