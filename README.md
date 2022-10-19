# Agora Mainnet

- [For Linux or MacOS users](#for-linux-or-macos-users)
    - [Install](#install-for-linux-or-macos)
    - [Execution Layer](#execution-layer-for-linux-or-macos)
    - [Consensus Layer](#consensus-layer-for-linux-or-macos)
    - [Using docker-compose](#using-docker-compose-for-linux-or-macos)


- [For Windows users](#for-windows-users)
    - [Install](#install-for-windows)
    - [Execution Layer](#execution-layer-for-windows)
    - [Consensus Layer](#consensus-layer-for-windows)
    - [Using docker-compose](#using-docker-compose-for-windows)

## For Linux or MacOS users

### Install for Linux or MacOS

```shell
wget https://github.com/bosagora/agora-chain/archive/refs/heads/mainnet.zip
unzip mainnet.zip
cd agora-chain-mainnet
```

### Execution Layer for Linux or MacOS

Init execution node

```shell
./agora.sh el-node init
```

Run execution node

```shell
./agora.sh el-node run
```


### Consensus Layer for Linux or MacOS


Run consensus node

```shell
./agora.sh cl-node run
```

### Validator for Linux or MacOS

Import your key stores

```shell
./agora.sh validator import <your key stores folder>
```

Run validator

```shell
./agora.sh validator run
```

Voluntary exit of the validator

```shell
./agora.sh validator voluntary-exit
```

### Using docker-compose for Linux or MacOS

1. Init the execution node
```shell
./agora.sh el-node init
```

2. Import your key stores
```shell
./agora.sh validator import <your key stores folder>
```

3. Edit wallet password
```shell
vi ./root/config/cl/password.txt
```

4. Edit transaction fee receiving address
```shell
vi ./root/config/cl/proposer_config.json
```

5. Run docker-compose
```shell
./agora.sh docker-compose up
```

6. Stop docker-compose
```shell
./agora.sh docker-compose down
```

## For Windows users


### Install for Windows

```shell
curl https://github.com/bosagora/agora-chain/archive/refs/heads/mainnet.zip --output mainnet.zip
tar -xf mainnet.zip
cd agora-chain-mainnet
```

### Execution Layer for Windows

Init execution node

```shell
agora.bat el-node init
```

Run execution node

```shell
agora.bat el-node run
```


### Consensus Layer for Windows


Run consensus node

```shell
agora.bat cl-node run
```

### Validator for Windows

Import your key stores

```shell
agora.bat validator import <your key stores folder>
```

Run validator

```shell
agora.bat validator run
```

Voluntary exit of the validator

```shell
agora.bat validator voluntary-exit
```

### Using docker-compose for Windows

1. Init the execution node
```shell
agora.bat el-node init
```

2. Import your key stores
```shell
agora.bat validator import <your key stores folder>
```

3. Edit wallet password
```shell
notepad ./root/config/cl/password.txt
```

4. Edit transaction fee receiving address
```shell
notepad ./root/config/cl/proposer_config.json
```

5. Run docker-compose
```shell
agora.bat docker-compose up
```

6. Stop docker-compose
```shell
agora.bat docker-compose down
```
