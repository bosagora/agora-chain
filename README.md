# Agora Mainnet

- [Abort](#abort)

- [Install Docker Engine](#install-docker-engine)

- [For Linux or MacOS users](#for-linux-or-macos-users)
  - [Install](#install-for-linux-or-macos)
  - [Upgrade](#upgrade-for-linux-or-macos)
  - [Execution Layer](#execution-layer-for-linux-or-macos)
  - [Consensus Layer](#consensus-layer-for-linux-or-macos)
  - [Using docker-compose](#using-docker-compose-for-linux-or-macos)


- [For Windows users](#for-windows-users)
  - [Install](#install-for-windows)
  - [Upgrade](#upgrade-for-windows)
  - [Execution Layer](#execution-layer-for-windows)
  - [Consensus Layer](#consensus-layer-for-windows)
  - [Using docker-compose](#using-docker-compose-for-windows)


- [AWS 의 Ubuntu 에 BOSagora 노드 설치하기](docs/INSTALL-NODE-UBUNTU-KR.md)
- [NHN 클라우드의 Ubuntu 에 BOSagora 노드 설치하기](docs/INSTALL-NODE-UBUNTU-NHNCLOUD-KR.md)
- [Installing the BOSagora's node on Ubuntu on AWS](docs/INSTALL-NODE-UBUNTU-EN.md)

## Abort
[Agora-el](https://github.com/bosagora/agora-el) is an execution client that has an EVM.  
Agora-el was forked from Ethereum's execution client, [ethereum/go-ethereum](https://github.com/ethereum/go-ethereum) version 1.10.23.  
We implemented the function of issuing commons budget in Agora-el.

[Agora-cl](https://github.com/bosagora/agora-cl) is a consensus client with a focus on usability, security, and reliability.  
Agora-cl was forked from Ethereum's consensus client, [prysmaticlabs/prysm](https://github.com/prysmaticlabs/prysm) version 3.1.1.  
We modified the block confirmation rewards in Agora-cl.

## Install Docker Engine

To run the Agora node, you must first install the Docker Engine.  
See [here](https://docs.docker.com/engine/install/) for instructions on how to install the Docker Engine  
https://docs.docker.com/engine/install/

## For Linux or MacOS users

### Install for Linux or MacOS

- Install
  
  ```shell
  mkdir agora-chain
  cd agora-chain
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/bosagora/agora-chain/v0.x.x/agora.sh)"
  ```
  
- Change to BOSagora main network

  ```shell
  ./agora.sh network mainnet
  ```

- Change to BOSagora test network

  ```shell
  ./agora.sh network testnet
  ```

- Change to BOSagora development network

  ```shell
  ./agora.sh network devnet
  ```

- Available commands and descriptions of agora.sh

  ```txt
  ./agora.sh 
  agora.sh version 2.0.0
  Usage: ./agora.sh PROCESS FLAGS.
  PROCESS can be el-node, cl-node, validator, docker-compose, docker-compose-monitoring, start, stop, upgrade
  
  ./agora.sh network <network to change>
         - <network to change> is one of mainnet, testnet, and devnet, and the default is mainnet.
         - If <network to change> is not specified, it shows the currently set up network.
  
  ./agora.sh el-node ( init, run )
      el-node init
         - Initialize agora-el. At this point, all existing block data is deleted.
      el-node run
         - Run agora-el.
  
  ./agora.sh cl-node ( run )
      cl-node run
         - Run agora-cl.
  
  ./agora.sh validator ( accounts, exit, generate-bls-to-execution-change, withdraw, slashing-protection-history )
  
  ./agora.sh validator accounts ( import, list, backup )
      validator accounts import <validator keys folder>
         - Add the validator's keys to the local wallet.
      validator accounts list
         - Show the validator's keys stored in the local wallet.
      validator accounts backup <validator keys folder>
         - Back up the validator's keys stored in the local wallet.
  
      validator exit
         - Used to voluntarily exit the validator's function. After this is done, you will see a screen where you select the validator's keys.
      validator generate-bls-to-execution-change <data folder>
         - Generates the data required to register the address to which the validator's amount will be withdrawn.
         - Currently, only devnet is supported. Other networks will be supported later.
      validator withdraw <data folder>
         - Send pre-created withdrawal address registration data to the network.
         - Currently, only devnet is supported. Other networks will be supported later.
  
  ./agora.sh validator slashing-protection-history ( export, import ) 
      validator slashing-protection-history export <data folder>
         - Save the information that the verifiers worked on as a file. At this point, the validator on the current server must be stopped.
         - One validator must validate only once per block. Otherwise, the validator may be slashed.
             - If a validator runs on multiple servers, that validator may violate the above condition.
             - If a validator's server is changed to another server, the validator may violate the above condition.
             - To avoid this, you need to transfer the block verification information that the validators has performed so far.
      validator slashing-protection-history import <data folder>
         - Register block verification information performed by validators.
  
  ./agora.sh docker-compose ( up, down )
      docker-compose up
         - Run agora-el, agora-cl, validator.
      docker-compose down
         - Stop agora-el, agora-cl, validator.
  
  ./agora.sh docker-compose-monitoring ( up, down )
      docker-compose-monitoring up
          - Run agora-el, agora-cl, validator, and containers required for monitoring.
      docker-compose-monitoring down
         - Stop agora-el, agora-cl, validator, and containers required for monitoring.
  
  ./agora.sh start
         - Run agora-el, agora-cl, validator, and containers required for monitoring.
         - It's the same as './agora.sh docker-compose-monitoring up'
  
  ./agora.sh stop
         - Stop agora-el, agora-cl, validator, and containers required for monitoring.
         - It's the same as './agora.sh docker-compose-monitoring down'
  
  ./agora.sh upgrade
         - The latest version is installed, at which point the user data is preserved.
  ```

### Upgrade for Linux or MacOS

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/bosagora/agora-chain/v0.x.x/upgrade.sh)"
```

### Execution Layer for Linux or MacOS

- Init execution node

  ```shell
  ./agora.sh el-node init
  ```

- Run execution node

  ```shell
  ./agora.sh el-node run
  ```

### Consensus Layer for Linux or MacOS

- Run consensus node

  ```shell
  ./agora.sh cl-node run
  ```

### Validator accounts for Linux or MacOS

- Import your key stores

  ```shell
  ./agora.sh validator import <your key stores folder>
  ```
  
  or

  ```shell
  ./agora.sh validator accounts import <your key stores folder>
  ```
  `<your key stores folder>` is where the validator keys are stored. The default folder is `./validator_keys`

- List your key stores in your wallet

  ```shell
  ./agora.sh validator accounts list
  ```


- Backup your key stores in your wallet

  ```shell
  ./agora.sh validator accounts backup <folder>
  ```
  `<folder>` is where the backup key is stored. The default folder is `./backup-wallet`

### Validator execution for Linux or MacOS

- Run validator

  ```shell
  ./agora.sh validator run
  ```

### Validator exit for Linux or MacOS

- Voluntary exit of the validator

  ```shell
  ./agora.sh validator exit
  ```

### Validator withdrawals for Linux or MacOS

- Generate the SignedBLSToExecutionChange data to enable withdrawals

  ```shell
  ./agora.sh validator generate-bls-to-execution-change <folder>
  ```
  `<folder>` is where the SignedBLSToExecutionChange data is stored. The default folder is `./bls_to_execution_changes`


- Send the SignedBLSToExecutionChange data to enable withdrawals

  ```shell
  ./agora.sh validator withdraw <folder>
  ```
  `<folder>` is where the SignedBLSToExecutionChange data is stored. The default folder is `./bls_to_execution_changes`


### Validator export & import slashing protection history for Linux or MacOS

- export

  ```shell
  ./agora.sh validator slashing-protection-history export <folder>
  ```
  `<folder>` is where the slashing protection history data is stored. The default folder is `./slashing-protection-export`


- import

  ```shell
  ./agora.sh validator slashing-protection-history import <folder>
  ```
  `<folder>` is where the slashing protection history data is stored. The default folder is `./slashing-protection-export`


### Using docker-compose for Linux or MacOS

1. Init the execution node

```shell
./agora.sh el-node init
```

2. Import your key stores

```shell
./agora.sh validator import <your key stores folder>
```

or

```shell
./agora.sh validator accounts import <your key stores folder>
```

3. Edit wallet password

```shell
nano ./root/config/cl/password.txt
```

4. Edit transaction fee receiving address

```shell
nano ./root/config/cl/proposer_config.json
```

5. Run docker-compose

```shell
./agora.sh docker-compose up
```

6. Stop docker-compose

```shell
./agora.sh docker-compose down
```

### Using docker-compose with monitoring for Linux or MacOS

1. Init the execution node

```shell
./agora.sh el-node init
```

2. Import your key stores

```shell
./agora.sh validator import <your key stores folder>
```

or

```shell
./agora.sh validator accounts import <your key stores folder>
```

3. Edit wallet password

```shell
nano ./root/config/cl/password.txt
```

4. Edit transaction fee receiving address

```shell
nano ./root/config/cl/proposer_config.json
```

5. Run docker-compose

```shell
./agora.sh docker-compose-monitoring up
```
or
```shell
./agora.sh start
```

6. Stop docker-compose

```shell
./agora.sh docker-compose-monitoring down
```
or
```shell
./agora.sh stop
```

## For Windows users

### Install for Windows

- Install

  ```shell
  mkdir agora-chain
  cd agora-chain
  curl -S -L -o agora.bat https://raw.githubusercontent.com/bosagora/agora-chain/v0.x.x/agora.bat
  call agora.bat
  ```

- Change to BOSagora main network

  ```shell
  agora.bat network mainnet
  ```

- Change to BOSagora test network

  ```shell
  agora.bat network testnet
  ```

- Change to BOSagora development network

  ```shell
  agora.bat network devnet
  ```

- Available commands and descriptions of agora.bat

  ```txt
  agora.bat
  agora.bat version 2.0.0
  Usage: agora.bat PROCESS FLAGS.
  PROCESS can be el-node, cl-node, validator, docker-compose, docker-compose-monitoring, start, stop, upgrade
  
  agora.bat network <network to change>
         - <network to change> is one of mainnet, testnet, and devnet, and the default is mainnet.
         - If <network to change> is not specified, it shows the currently set up network.
  
  agora.bat el-node ( init, run )
      el-node init
         - Initialize agora-el. At this point, all existing block data is deleted.
      el-node run
         - Run agora-el.
  
  agora.bat cl-node ( run )
      cl-node run
         - Run agora-cl.
  
  agora.bat validator ( accounts, exit, generate-bls-to-execution-change, withdraw, slashing-protection-history )
  
  agora.bat validator accounts ( import, list, backup )
      validator accounts import <validator keys folder>
         - Add the validator's keys to the local wallet.
      validator accounts list
         - Show the validator's keys stored in the local wallet.
      validator accounts backup <validator keys folder>
         - Back up the validator's keys stored in the local wallet.
  
      validator exit
         - Used to voluntarily exit the validator's function. After this is done, you will see a screen where you select the validator's keys.
      validator generate-bls-to-execution-change <data folder>
         - Generates the data required to register the address to which the validator's amount will be withdrawn.
         - Currently, only devnet is supported. Other networks will be supported later.
      validator withdraw <data folder>
         - Send pre-created withdrawal address registration data to the network.
         - Currently, only devnet is supported. Other networks will be supported later.
  
  agora.bat validator slashing-protection-history ( export, import ) 
      validator slashing-protection-history export <data folder>
         - Save the information that the verifiers worked on as a file. At this point, the validator on the current server must be stopped.
         - One validator must validate only once per block. Otherwise, the validator may be slashed.
             - If a validator runs on multiple servers, that validator may violate the above condition.
             - If a validator's server is changed to another server, the validator may violate the above condition.
             - To avoid this, you need to transfer the block verification information that the validators has performed so far.
      validator slashing-protection-history import <data folder>
         - Register block verification information performed by validators.
  
  agora.bat docker-compose ( up, down )
      docker-compose up
         - Run agora-el, agora-cl, validator.
      docker-compose down
         - Stop agora-el, agora-cl, validator.
  
  agora.bat docker-compose-monitoring ( up, down )
      docker-compose-monitoring up
          - Run agora-el, agora-cl, validator, and containers required for monitoring.
      docker-compose-monitoring down
         - Stop agora-el, agora-cl, validator, and containers required for monitoring.
  
  agora.bat start
         - Run agora-el, agora-cl, validator, and containers required for monitoring.
         - It's the same as 'agora.bat docker-compose-monitoring up'
  
  agora.bat stop
         - Stop agora-el, agora-cl, validator, and containers required for monitoring.
         - It's the same as 'agora.bat docker-compose-monitoring down'
  
  agora.bat upgrade
         - The latest version is installed, at which point the user data is preserved.
  ```

### Upgrade for Windows

```shell
curl -S -L -o upgrade.bat https://raw.githubusercontent.com/bosagora/agora-chain/v0.x.x/upgrade.bat
upgrade.bat
```

### Execution Layer for Windows

- Init execution node

  ```shell
  agora.bat el-node init
  ```

- Run execution node
  
  ```shell
  agora.bat el-node run
  ```

### Consensus Layer for Windows

- Run consensus node
  
  ```shell
  agora.bat cl-node run
  ```

### Validator for Windows

- Import your key stores
  
  ```shell
  agora.bat validator import <your key stores folder>
  ```
  
  or
  
  ```shell
  agora.bat validator accounts import <your key stores folder>
  ```

  `<your key stores folder>` is where the validator keys are stored. The default folder is `./validator_keys`


- List your key stores in your wallet
  
  ```shell
  agora.bat validator accounts list
  ```


- Backup your key stores in your wallet

  ```shell
  agora.bat validator accounts backup <folder>
  ```
  `<folder>` is where the backup key is stored. The default folder is `./backup-wallet`

### Validator execution for Windows

- Run validator
  
  ```shell
  agora.bat validator run
  ```

### Validator exit for Windows

- Voluntary exit of the validator
  
  ```shell
  agora.bat validator exit
  ```

### Validator withdrawals for Windows

- Generate the SignedBLSToExecutionChange data to enable withdrawals

  ```shell
  agora.bat validator generate-bls-to-execution-change <folder>
  ```
  `<folder>` is where the SignedBLSToExecutionChange data is stored. The default folder is `./bls_to_execution_changes`


- Send the SignedBLSToExecutionChange data to enable withdrawals

  ```shell
  agora.bat validator withdraw <folder>
  ```
  `<folder>` is where the SignedBLSToExecutionChange data is stored. The default folder is `./bls_to_execution_changes`
  

### Validator export & import slashing protection history for Windows

- export

  ```shell
  ./agora.bat validator slashing-protection-history export <folder>
  ```
  `<folder>` is where the slashing protection history data is stored. The default folder is `./slashing-protection-export`


- import

  ```shell
  ./agora.bat validator slashing-protection-history import <folder>
  ```
  `<folder>` is where the slashing protection history data is stored. The default folder is `./slashing-protection-export`


### Using docker-compose for Windows

1. Init the execution node

```shell
agora.bat el-node init
```

2. Import your key stores

```shell
agora.bat validator import <your key stores folder>
```

or

```shell
agora.bat validator accounts import <your key stores folder>
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

### Using docker-compose with monitoring for Windows

1. Init the execution node

```shell
agora.bat el-node init
```

2. Import your key stores

```shell
agora.bat validator import <your key stores folder>
```

or

```shell
agora.bat validator accounts import <your key stores folder>
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
agora.bat docker-compose-monitoring up
```
or
```shell
agora.bat start
```

6. Stop docker-compose

```shell
agora.bat docker-compose-monitoring down
```
or
```shell
agora.bat stop
```

## Additional Information

[AWS 의 Ubuntu 에 BOSagora 노드 설치하기](docs/INSTALL-NODE-UBUNTU-KR.md)  
[Installing the BOSagora's node on Ubuntu on AWS](docs/INSTALL-NODE-UBUNTU-EN.md)
