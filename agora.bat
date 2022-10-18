@ECHO OFF
FOR /F "tokens=* USEBACKQ" %%F IN (`curl -s https://ifconfig.me/ip`) DO (
SET P2P_HOST_IP=%%F
)

SetLocal EnableDelayedExpansion & REM All variables are set local to this run & expanded at execution time rather than at parse time (tip: echo !output!)

REM Complain if invalid arguments were provided.

if "%~1"=="" (
  goto printError
)
for %%a in (el-node cl-node validator docker-compose) do (
    if %1 equ %%a (
        goto validprocess
    )
)
:printError
echo [31mERROR: PROCESS missing or invalid[0m
echo Usage: ./agora.bat PROCESS FLAGS.
echo.
echo PROCESS can be el-node, cl-node, validator, docker-compose.
echo FLAGS are the flags or arguments passed to the PROCESS.
echo.
exit /B 1
:validprocess


if "%~1"=="el-node" (

    if "%~2"=="init" (

        if exist .\root\chain\el (
          RD /S /Q .\root\chain\el
        )

        docker run -it ^
        -v %cd%\root:/root ^
        --name el-node --rm  ^
        bosagora/agora-el-node:v1.0.1  ^
        --datadir=/root/chain/el  ^
        init /root/config/el/genesis.json

     ) else if "%~2"=="run" (

        if not exist .\root\chain\el (

            docker run -it ^
            -v %cd%\root:/root ^
            --name el-node --rm  ^
            bosagora/agora-el-node:v1.0.1  ^
            --datadir=/root/chain/el  ^
            init /root/config/el/genesis.json

        )

        docker run -it ^
        -v %cd%\root:/root ^
        -p 30303:30303 -p 30303:30303/udp ^
        --name el-node --rm  ^
        bosagora/agora-el-node:v1.0.1  ^
        --config=/root/config/el/config.toml ^
        --datadir=/root/chain/el

    ) else (

        echo FLAGS are the flags or arguments passed to the PROCESS.
        echo [31mFLAGS '%~2' is not found![0m
        echo [31mUsage: ./agora.bat el-node FLAGS.[0m
        echo [31mFLAGS can be init, run[0m
        exit /B 1

    )

) else if "%~1"=="cl-node" (

    if "%~2"=="run" (

        docker run -it ^
        -v %cd%\root\:/root ^
        -p 3500:3500 -p 4000:4000 -p 13000:13000 -p 12000:12000/udp ^
        --name cl-node --rm ^
        bosagora/agora-cl-node:v1.0.0 ^
        --chain-config-file=/root/config/cl/chain-config.yaml ^
        --config-file=/root/config/cl/config.yaml ^
        --p2p-host-ip=%P2P_HOST_IP%

    ) else (

        echo [31mFLAGS '%~2' is not found![0m
        echo [31mUsage: ./agora.bat cl-node FLAGS.[0m
        echo [31mFLAGS can be run[0m
        exit /B 1

    )

) else if "%~1"=="validator" (

    if "%~2"=="import" (

        if "%~3"=="" (

            echo [31mUsage: ./agora.bat validator import keys-dir.[0m
            echo [31mkeys-dir is the path to a directory where keystores to be imported are stored[0m
            exit /B 1

        ) else (

            docker run -it ^
            -v %cd%\root\:/root ^
            --name cl-validator --rm ^
            bosagora/agora-cl-validator:v1.0.0 ^
            accounts import ^
            --keys-dir=/root/%~3 ^
            --wallet-dir=/root/wallet

        )
    ) else if "%~2"=="run" (

        docker run -it ^
          -v %cd%\root\:/root ^
          --network="host" ^
          --name cl-validator --rm ^
          bosagora/agora-cl-validator:v1.0.0 ^
          --chain-config-file=/root/config/cl/chain-config.yaml ^
          --datadir=/root/chain/cl/ ^
          --accept-terms-of-use ^
          --wallet-dir=/root/wallet ^
          --proposer-settings-file=/root/config/cl/proposer_config.json ^
          --wallet-password-file=/root/config/cl/password.txt

    ) else (

        echo [31mFLAGS '%~2' is not found![0m
        echo [31mUsage: ./agora.bat validator FLAGS.[0m
        echo [31mFLAGS can be import, run[0m
        exit /B 1

    )

) else if "%~1"=="docker-compose" (

    if "%~2"=="up" (

        if not exist .\root\chain\el (

            docker run -it ^
            -v %cd%\root:/root ^
            --name el-node --rm  ^
            bosagora/agora-el-node:v1.0.1  ^
            --datadir=/root/chain/el  ^
            init /root/config/el/genesis.json

        )

        docker-compose -f docker-compose.yml up -d

    ) else if "%~2"=="down" (

        docker-compose -f docker-compose.yml down

    ) else (

        echo [31mFLAGS '%~2' is not found![0m
        echo [31mUsage: ./agora.bat docker-compose FLAGS.[0m
        echo [31mFLAGS can be up down[0m
        exit /B 1

    )
) else (

    echo [31mProcess '%~1' is not found![0m
    echo [31mUsage: ./agora.bat PROCESS FLAGS.[0m
    echo [31mPROCESS can be el-node, cl-node, validator, docker-compose[0m
    exit /B 1

)
