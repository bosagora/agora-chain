# Agora Testnet

- [Abort](#abort)

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

## Abort
Agora-el is an execution client that has an EVM.  
Agora-el was forked from Ethereum's execution client, 'geth' version 1.10.23.  
We implemented the function of issuing commons budget in Agora-el.  

Agora-cl is a consensus client with a focus on usability, security, and reliability.  
Agora-cl was forked from Ethereum's consensus client, 'prysm' version 3.1.1.  
We modified the block confirmation rewards in Agora-cl.

## For Linux or MacOS users

### Install for Linux or MacOS

```shell
wget https://github.com/bosagora/agora-chain/archive/refs/heads/testnet.zip
unzip testnet.zip
cd agora-chain-testnet
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
curl https://github.com/bosagora/agora-chain/archive/refs/heads/testnet.zip --output testnet.zip
tar -xf testnet.zip
cd agora-chain-testnet
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
