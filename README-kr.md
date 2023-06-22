# Agora Chain

[English](./README-en.md) | 한국어

- [소개](#소개)

- [Docker Engine 설치](#docker-engine-설치)

- [리눅스 및 맥 사용자용](#리눅스-및-맥-사용자용)
  - [설치](#설치-리눅스-및-맥-사용자용)
  - [업그레이드](#업그레이드-리눅스-및-맥-사용자용)
  - [실행 계층](#실행-계층-리눅스-및-맥-사용자용)
  - [합의 계층](#합의-계층-리눅스-및-맥-사용자용)
  - [검증자의 계정](#검증자의-계정-리눅스-및-맥-사용자용)
  - [검증자 클라이언트 실행](#검증자-실행-리눅스-및-맥-사용자용)
  - [검증자의 역활 수행을 종료](#검증자의-역활-수행을-종료-리눅스-및-맥-사용자용)
  - [검증자의 리워드와 예치금을 인출](#검증자의-리워드와-예치금을-인출-리눅스-및-맥-사용자용)
  - [슬래싱 방지](#슬래싱-방지-리눅스-및-맥-사용자용)
  - [도커 컴포우즈 사용](#도커-컴포우즈-사용-리눅스-및-맥-사용자용)
  - [모니터링을 위한 도커 컴포우즈 사용](#모니터링을-위한-도커-컴포우즈-사용-리눅스-및-맥-사용자용)

- [윈도우즈 사용자용](#윈도우즈-사용자용)
  - [설치](#설치-윈도우즈-사용자용)
  - [업그레이드](#업그레이드-윈도우즈-사용자용)
  - [실행 계층](#실행-계층-윈도우즈-사용자용)
  - [합의 계층](#합의-계층-윈도우즈-사용자용)
  - [검증자의 계정](#검증자의-계정-윈도우즈-사용자용)
  - [검증자 클라이언트 실행](#검증자-실행-윈도우즈-사용자용)
  - [검증자의 역활 수행을 종료](#검증자의-역활-수행을-종료-윈도우즈-사용자용)
  - [검증자의 리워드와 예치금을 인출](#검증자의-리워드와-예치금을-인출-윈도우즈-사용자용)
  - [슬래싱 방지](#슬래싱-방지-윈도우즈-사용자용)
  - [도커 컴포우즈 사용](#도커-컴포우즈-사용-윈도우즈-사용자용)
  - [모니터링을 위한 도커 컴포우즈 사용](#모니터링을-위한-도커-컴포우즈-사용-윈도우즈-사용자용)

- [AWS 의 Ubuntu 에 BOSagora 노드 설치하기](docs/INSTALL-NODE-UBUNTU-KR.md)
- [NHN 클라우드의 Ubuntu 에 BOSagora 노드 설치하기](docs/INSTALL-NODE-UBUNTU-NHNCLOUD-KR.md)

## 소개
Agora Node는 실행 계층 클라이언트와 합의 계층 클라이언트로 구성되어 있습니다. 
[Agora-el](https://github.com/bosagora/agora-el) 은 EVM 을 지원하는 실행 계층의 클라이언트 입니다.  
Agora-el 은 이더리움의 실행 계층 클라이언트인 [ethereum/go-ethereum](https://github.com/ethereum/go-ethereum) 버전 1.10.23 에서 포크되었습니다.  
우리는 공공예산 발행기능을 구현하였습니다.  

[Agora-cl](https://github.com/bosagora/agora-cl) 은 사용성, 보안 및 신뢰성에 중점을 둔 합의 계층 클라이언트 입니다.  
Agora-cl 은 이더리움의 합의 계층 클라이언트인 [prysmaticlabs/prysm](https://github.com/prysmaticlabs/prysm) 버전 3.1.1 에서 포크되었습니다.  
우리는 블록생성에 대한 보상을 수정하였습니다. 

## Docker Engine 설치

Agora 노드를 실행하기 위해서는 먼저 도커엔진을 설치하여야 합니다.  
도커엔진을 설치하기 위해서는 [여기](https://docs.docker.com/engine/install/)를 참조하십시오  
https://docs.docker.com/engine/install/

## 리눅스 및 맥 사용자용

### 설치 (리눅스 및 맥 사용자용)

- 설치
  
  ```shell
  mkdir agora-chain
  cd agora-chain
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/bosagora/agora-chain/v0.x.x/agora.sh)"
  ```

  설치후에는 반드시 네트워크를 선택하여야 합니다. 네트워크를 선택하지 않으면 기본값이 메인넷이 적용됩니다.   


- 메인 네트워크로 전환하기 (기본값)

  ```shell
  ./agora.sh network mainnet
  ```

- 테스트 네트워크로 전환하기

  ```shell
  ./agora.sh network testnet
  ```

- 개발용 네트워크로 전환하기

  ```shell
  ./agora.sh network devnet
  ```

- 스크립트 agora.sh 에서 사용가능한 명령어들

  ```txt
  ./agora.sh 
  agora.sh version 2.0.0
  Usage: ./agora.sh PROCESS FLAGS.
  PROCESS can be el-node, cl-node, validator, docker-compose, docker-compose-monitoring, start, stop, exec, upgrade
  
  ./agora.sh network <network to change>
         - <network to change> 는 mainnet, testnet, devnet 중 하나이며 기본값은 mainnet 입니다.
         - <network to change> 를 지정하지 않으면 현재 설정된 네트워크가 표시됩니다.
  
  ./agora.sh el-node ( init, run )
      el-node init
         - 실행계층의 블록데이타를 초기화합니다. 이 시점에서 기존의 모든 블록 데이터가 삭제됩니다.
      el-node run
         - 실행계층의 클라이언트를 실행합니다.
  
  ./agora.sh cl-node ( run )
      cl-node run
         - 합의계층의 클라이언트를 실행합니다.
  
  ./agora.sh validator ( accounts, exit, withdraw, slashing-protection-history, wallet )
  
  ./agora.sh validator accounts ( import, list, backup )
      validator accounts import <validator keys folder>
         - 로컬 월렛에 검증자키를 추가합니다.
      validator accounts list
         - 로컬 월렛에 저장된 검증자키를 보여줍니다.
      validator accounts delete
         - 로컬 월렛에서 선택한 검증자키를 제거합니다.
      validator accounts backup <validator keys folder>
         - 로컬 월렛에 저장된 검증자키를 백업합니다.
  
      validator exit
         - 검증자 기능을 자발적으로 종료하는 데 사용됩니다. 이렇게 하면 검증자의 키를 선택하는 화면이 나타납니다.
      validator withdraw <data folder>
         - 미리 생성된 인출 주소 등록 데이터를 네트워크로 전송합니다.
         - 현재 devnet만 지원됩니다. 다른 네트워크는 나중에 지원됩니다.
  
  ./agora.sh validator slashing-protection-history ( export, import ) 
      validator slashing-protection-history export <data folder>
         - 검증자가 작업한 정보를 파일로 저장합니다. 이 시점에서 현재 서버의 유효성 검사기를 중지해야 합니다.
         - 검증자 한 명은 블록당 한 번만 검증해야 합니다. 그렇지 않으면 검사기가 슬래싱될 수 있습니다.
             - 하나의 검증자가 여러 서버에서 실행되는 경우, 해당 검증자는 위의 조건을 위반할 수 있습니다.
             - 검증자의 서버가 다른 서버로 변경되면 검증자가 위의 조건을 위반할 수 있습니다.
             - 이를 방지하려면 검증자가 지금까지 수행한 블록 확인 정보를 옮겨가야 합니다. 
             - 이 때 필요한 기능이 이 명령어입니다.
      validator slashing-protection-history import <data folder>
         - 검증자가 수행한 블록 검증 정보를 등록합니다.

  ./agora.sh validator wallet ( create, recover )
      validator wallet create <wallet folder>
         - HD 월렛을 로컬에 생성한다.
      validator wallet recover <wallet folder>
         - HD 월렛을 로컬에 복원한다.
  
  ./agora.sh deposit-cli ( new-mnemonic, existing-mnemonic, generate-bls-to-execution-change )
      deposit-cli new-mnemonic
         - 새로운 니모닉과 함께 검증자키를 생성하기를 원할 때 사용되는 명령어입니다.
      deposit-cli existing-mnemonic
         - 이미 가지고 있는 니모닉을 이용해서 새로운 검증자키를 생성하기를 원할 때 사용되는 명령어입니다.
      deposit-cli generate-bls-to-execution-change <data folder>
         - 검증자의 금액이 인출될 주소를 등록하는 데 필요한 데이터를 생성합니다.
         - 현재 devnet만 지원됩니다. 다른 네트워크는 나중에 지원됩니다.

  ./agora.sh docker-compose ( up, down )
      docker-compose up
         - 실행 계층 클라이언트, 합의 계층 클라이언트, 검증자를 실행합니다.
      docker-compose down
         - 실행 계층 클라이언트, 합의 계층 클라이언트, 검증자를 중지합니다.
  
  ./agora.sh docker-compose-monitoring ( up, down )
      docker-compose-monitoring up
         - 실행 계층 클라이언트, 합의 계층 클라이언트, 검증자 와 모니터링에 필요한 컨테이너들를 실행합니다.
      docker-compose-monitoring down
         - 실행 계층 클라이언트, 합의 계층 클라이언트, 검증자 와 모니터링에 필요한 컨테이너들를 중지합니다.
  
  ./agora.sh start
         - 실행 계층 클라이언트, 합의 계층 클라이언트, 검증자 와 모니터링에 필요한 컨테이너들를 실행합니다.
         - 이것은 './agora.sh docker-compose-monitoring up' 와 동일합니다.
  
  ./agora.sh stop
         - 실행 계층 클라이언트, 합의 계층 클라이언트, 검증자 와 모니터링에 필요한 컨테이너들를 중지합니다.
         - 이것은  './agora.sh docker-compose-monitoring down' 와 동일합니다.

  ./agora.sh exec ( el-node, cl-node, cl-validator, cl-ctl )
      exec el-node ...
         - 사용자가 입력한 파라메터를 사용하여 agora-el-node 를 실행합니다.
      exec cl-node ...
         - 사용자가 입력한 파라메터를 사용하여 agora-cl-node 를 실행합니다.
      exec cl-validator ...
         - 사용자가 입력한 파라메터를 사용하여 agora-cl-validator 를 실행합니다.
      exec cl-ctl ...
         - 사용자가 입력한 파라메터를 사용하여 agora-cl-ctl 를 실행합니다.
  
  ./agora.sh upgrade
         - 가장 최신의 버전이 설치됩니다. 이때 데이타는 보존됩니다.
  ```

### 업그레이드 (리눅스 및 맥 사용자용)

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/bosagora/agora-chain/v0.x.x/upgrade.sh)"
```

### 실행 계층 (리눅스 및 맥 사용자용)

- 실행 계층의 블록데이타를 초기화

  ```shell
  ./agora.sh el-node init
  ```

- 실행 계층의 클라이언트 실행

  ```shell
  ./agora.sh el-node run
  ```

### 합의 계층 (리눅스 및 맥 사용자용)

- 합의 계층의 클라이언트 실행

  ```shell
  ./agora.sh cl-node run
  ```

### 검증자의 계정 (리눅스 및 맥 사용자용)

- 니모닉을 가지고 있지 않을 때 검증자키를 생성하기

  ```shell
  ./agora.sh deposit-cli new-mnemonic
  ```

- 니모닉을 가지고 있을 때 검증자키를 생성하기

  ```shell
  ./agora.sh deposit-cli existing-mnemonic
  ```

- 검증자 키를 월렛에 추가하기

  ```shell
  ./agora.sh validator import <your key stores folder>
  ```
  
  또는

  ```shell
  ./agora.sh validator accounts import <your key stores folder>
  ```
  
  `<your key stores folder>` 는 검증자키가 존재하는 폴더입니다. 입력하지 않으면 기본 폴더 `./validator_keys` 로 처리됩니다.

- 로컬 월렛에 저장된 검증자 계정 출력하기

  ```shell
  ./agora.sh validator accounts list
  ```

- 로컬 월렛에 저장된 검증자 계정을 파일로 백업하기

  ```shell
  ./agora.sh validator accounts backup <folder>
  ```
  `<folder>` 는 백업데이타를 저장할 폴더명입니다. 입력하지 않으면 `./backup-wallet` 로 처리됩니다.

### 검증자 실행 (리눅스 및 맥 사용자용)

- 검증자 클라이언트 실행하기

  ```shell
  ./agora.sh validator run
  ```

### 검증자의 역활 수행을 종료 (리눅스 및 맥 사용자용)

- 검증자의 역활 수행을 자발적으로 종료하기

  ```shell
  ./agora.sh validator exit
  ```

### 검증자의 리워드와 예치금을 인출 (리눅스 및 맥 사용자용)

- 인출이 가능하도록 하기 위해 출금주소가 포함된 서명된 데이타를 생성하기

  ```shell
  ./agora.sh deposit-cli generate-bls-to-execution-change <folder>
  ```
  `<folder>` 는 서명된 데이타가 저장된 폴더입니다. 입력하지 않으면 `./bls_to_execution_changes` 로 처리됩니다.

- 출금주소가 포함된 서명된 데이타를 네트워크로 전송하기

  ```shell
  ./agora.sh validator withdraw <folder>
  ```
  `<folder>` 는 슬래싱 방지를 위한 데이타가 저장될 폴더입니다. 입력하지 않으면 `./slashing-protection-export` 로 처리됩니다.

### 슬래싱 방지 (리눅스 및 맥 사용자용)

검증자 한 명은 블록당 한 번만 검증해야 합니다. 그렇지 않으면 검사기가 슬래싱될 수 있습니다.  
하나의 검증자가 여러 서버에서 실행되는 경우, 해당 검증자는 위의 조건을 위반할 수 있습니다.  
검증자의 서버가 다른 서버로 변경되면 검증자가 위의 조건을 위반할 수 있습니다. 이를 방지하려면 검증자가 지금까지 수행한 블록 확인 정보를 옮겨가야 합니다. 
이 때 필요한 기능이 이 명령어입니다.
- export

  ```shell
  ./agora.sh validator slashing-protection-history export <folder>
  ```
  `<folder>` 는 슬래싱 방지를 위한 데이타가 저장될 폴더입니다. 입력하지 않으면 `./slashing-protection-export` 로 처리됩니다.

- import

  ```shell
  ./agora.sh validator slashing-protection-history import <folder>
  ```
  `<folder>` 는 슬래싱 방지를 위한 데이타가 저장된 폴더입니다. 입력하지 않으면 `./slashing-protection-export` 로 처리됩니다.

### 도커-컴포우즈-사용 (리눅스 및 맥 사용자용)

1. 실행 계층의 블록데이타를 초기화하기
  
  ```shell
  ./agora.sh el-node init
  ```

2. 검증자 키를 임포트하기

```shell
./agora.sh validator accounts import <your key stores folder>
```
`<your key stores folder>` 는 검증자키가 존재하는 폴더입니다. 입력하지 않으면 `./validator_keys` 로 처리됩니다.

3. 프로세스 자동실행을 위해 월렛의 비밀번호를 기록하기

```shell
nano ./root/config/cl/password.txt
```

4. 트랜잭션 수수료를 받을 주소를 등록하기

```shell
nano ./root/config/cl/proposer_config.json
```

5. 도커 컴포우즈를 실행하기

```shell
./agora.sh docker-compose up
```

6. 도커 컴포우즈를 종료하기

```shell
./agora.sh docker-compose down
```

### 모니터링을 위한 도커 컴포우즈 사용 (리눅스 및 맥 사용자용)

1. 실행 계층의 블록데이타를 초기화하기

```shell
./agora.sh el-node init
```

2. 검증자 키를 임포트하기

```shell
./agora.sh validator import <your key stores folder>
```

또는

```shell
./agora.sh validator accounts import <your key stores folder>
```

3. 프로세스 자동실행을 위해 월렛의 비밀번호를 기록하기

```shell
nano ./root/config/cl/password.txt
```

4. 트랜잭션 수수료를 받을 주소를 등록하기

```shell
nano ./root/config/cl/proposer_config.json
```

5. 도커 컴포우즈를 실행

```shell
./agora.sh docker-compose-monitoring up
```

또는

```shell
./agora.sh start
```

6. 도커 컴포우즈를 종료

```shell
./agora.sh docker-compose-monitoring down
```

또는

```shell
./agora.sh stop
```

## 윈도우즈 사용자용

### 설치 (윈도우즈 사용자용)

- 설치

  ```shell
  mkdir agora-chain
  cd agora-chain
  curl -S -L -o agora.bat https://raw.githubusercontent.com/bosagora/agora-chain/v0.x.x/agora.bat
  call agora.bat
  ```

  설치후에는 반드시 네트워크를 선택하여야 합니다. 네트워크를 선택하지 않으면 기본값이 메인넷이 적용됩니다.

- 메인 네트워크로 전환하기 (기본값)

  ```shell
  agora.bat network mainnet
  ```

- 테스트 네트워크로 전환하기

  ```shell
  agora.bat network testnet
  ```

- 개발용 네트워크로 전환하기

  ```shell
  agora.bat network devnet
  ```

- 스크립트 agora.sh 에서 사용가능한 명령어들

  ```txt
  agora.bat
  agora.bat version 2.0.0
  Usage: agora.bat PROCESS FLAGS.
  PROCESS can be el-node, cl-node, validator, docker-compose, docker-compose-monitoring, start, stop, exec, upgrade
  
  agora.bat network <network to change>
         - <network to change> 는 mainnet, testnet, devnet 중 하나이며 기본값은 mainnet 입니다.
         - <network to change> 를 지정하지 않으면 현재 설정된 네트워크가 표시됩니다.
  
  agora.bat el-node ( init, run )
      el-node init
         - 실행계층의 블록데이타를 초기화합니다. 이 시점에서 기존의 모든 블록 데이터가 삭제됩니다.
      el-node run
         - 실행계층의 클라이언트를 실행합니다.
  
  agora.bat cl-node ( run )
      cl-node run
         - 합의계층의 클라이언트를 실행합니다.
  
  agora.bat validator ( accounts, exit, withdraw, slashing-protection-history, wallet )
  
  agora.bat validator accounts ( import, list, backup )
      validator accounts import <validator keys folder>
         - 로컬 월렛에 검증자키를 추가합니다.
      validator accounts list
         - 로컬 월렛에 저장된 검증자키를 보여줍니다.
      validator accounts delete
         - 로컬 월렛에서 선택한 검증자키를 제거합니다.
      validator accounts backup <validator keys folder>
         - 로컬 월렛에 저장된 검증자키를 백업합니다.
  
      validator exit
         - 검증자 기능을 자발적으로 종료하는 데 사용됩니다. 이렇게 하면 검증자의 키를 선택하는 화면이 나타납니다.
      validator withdraw <data folder>
         - 미리 생성된 인출 주소 등록 데이터를 네트워크로 전송합니다.
         - 현재 devnet만 지원됩니다. 다른 네트워크는 나중에 지원됩니다.
  
  agora.bat validator slashing-protection-history ( export, import ) 
      validator slashing-protection-history export <data folder>
         - 검증자가 작업한 정보를 파일로 저장합니다. 이 시점에서 현재 서버의 유효성 검사기를 중지해야 합니다.
         - 검증자 한 명은 블록당 한 번만 검증해야 합니다. 그렇지 않으면 검사기가 슬래싱될 수 있습니다.
             - 하나의 검증자가 여러 서버에서 실행되는 경우, 해당 검증자는 위의 조건을 위반할 수 있습니다.
             - 검증자의 서버가 다른 서버로 변경되면 검증자가 위의 조건을 위반할 수 있습니다.
             - 이를 방지하려면 검증자가 지금까지 수행한 블록 확인 정보를 옮겨가야 합니다. 
             - 이 때 필요한 기능이 이 명령어입니다.
      validator slashing-protection-history import <data folder>
         - 검증자가 수행한 블록 검증 정보를 등록합니다.

  agora.bat validator wallet ( create, recover )
      validator wallet create <wallet folder>
         - HD 월렛을 로컬에 생성한다.
      validator wallet recover <wallet folder>
         - HD 월렛을 로컬에 복원한다.

  agora.bat deposit-cli ( new-mnemonic, existing-mnemonic, generate-bls-to-execution-change )
      deposit-cli new-mnemonic
         - 새로운 니모닉과 함께 검증자키를 생성하기를 원할 때 사용되는 명령어입니다.
      deposit-cli existing-mnemonic
         - 이미 가지고 있는 니모닉을 이용해서 새로운 검증자키를 생성하기를 원할 때 사용되는 명령어입니다.
      deposit-cli generate-bls-to-execution-change <data folder>
         - 검증자의 금액이 인출될 주소를 등록하는 데 필요한 데이터를 생성합니다.
         - 현재 devnet만 지원됩니다. 다른 네트워크는 나중에 지원됩니다.

  agora.bat docker-compose ( up, down )
      docker-compose up
         - 실행 계층 클라이언트, 합의 계층 클라이언트, 검증자를 실행합니다.
      docker-compose down
         - 실행 계층 클라이언트, 합의 계층 클라이언트, 검증자를 중지합니다.
  
  agora.bat docker-compose-monitoring ( up, down )
      docker-compose-monitoring up
         - 실행 계층 클라이언트, 합의 계층 클라이언트, 검증자 와 모니터링에 필요한 컨테이너들를 실행합니다.
      docker-compose-monitoring down
         - 실행 계층 클라이언트, 합의 계층 클라이언트, 검증자 와 모니터링에 필요한 컨테이너들를 중지합니다.
  
  agora.bat start
         - 실행 계층 클라이언트, 합의 계층 클라이언트, 검증자 와 모니터링에 필요한 컨테이너들를 실행합니다.
         - 이것은 './agora.sh docker-compose-monitoring up' 와 동일합니다.
  
  agora.bat stop
         - 실행 계층 클라이언트, 합의 계층 클라이언트, 검증자 와 모니터링에 필요한 컨테이너들를 중지합니다.
         - 이것은  './agora.sh docker-compose-monitoring down' 와 동일합니다.
  
  agora.bat exec ( el-node, cl-node, cl-validator, cl-ctl )
      exec el-node ...
         - 사용자가 입력한 파라메터를 사용하여 agora-el-node 를 실행합니다.
      exec cl-node ...
         - 사용자가 입력한 파라메터를 사용하여 agora-cl-node 를 실행합니다.
      exec cl-validator ...
         - 사용자가 입력한 파라메터를 사용하여 agora-cl-validator 를 실행합니다.
      exec cl-ctl ...
         - 사용자가 입력한 파라메터를 사용하여 agora-cl-ctl 를 실행합니다.
  
  agora.bat upgrade
         - 가장 최신의 버전이 설치됩니다. 이때 데이타는 보존됩니다.
  ```

### 업그레이드 (윈도우즈 사용자용)

```shell
curl -S -L -o upgrade.bat https://raw.githubusercontent.com/bosagora/agora-chain/v0.x.x/upgrade.bat
upgrade.bat
```

### 실행 계층 (윈도우즈 사용자용)

- 실행 계층의 블록데이타를 초기화

  ```shell
  agora.bat el-node init
  ```

- 실행 계층의 클라이언트 실행
  
  ```shell
  agora.bat el-node run
  ```

### 합의 계층 (윈도우즈 사용자용)

- 합의 계층의 클라이언트 실행
  
  ```shell
  agora.bat cl-node run
  ```

### 검증자의 계정 (윈도우즈 사용자용)

- 니모닉을 가지고 있지 않을 때 검증자키를 생성하기

  ```shell
  agora.bat deposit-cli new-mnemonic
  ```

- 니모닉을 가지고 있을 때 검증자키를 생성하기

  ```shell
  agora.bat deposit-cli existing-mnemonic
  ```

- 검증자 키를 월렛에 추가하기
  
  ```shell
  agora.bat validator import <your key stores folder>
  ```

  또는
  
  ```shell
  agora.bat validator accounts import <your key stores folder>
  ```

  `<your key stores folder>` 는 검증자키가 존재하는 폴더입니다. 입력하지 않으면 `./validator_keys` 로 처리됩니다.


- 로컬 월렛에 저장된 검증자 계정 출력하기
  
  ```shell
  agora.bat validator accounts list
  ```

- 로컬 월렛에 저장된 검증자 계정을 파일로 백업하기

  ```shell
  agora.bat validator accounts backup <folder>
  ```
  `<folder>` 는 백업데이터를 저장할 폴더입니다. 입력하지 않으면 `./backup-wallet` 로 처리됩니다.

### 검증자 실행 (윈도우즈 사용자용)

- 검증자 클라이언트 실행하기
  
  ```shell
  agora.bat validator run
  ```

### 검증자의 역활 수행을 종료 (윈도우즈 사용자용)

- 검증자의 역활 수행을 자발적으로 종료하기
  
  ```shell
  agora.bat validator exit
  ```

### 검증자의 리워드와 예치금을 인출 (윈도우즈 사용자용)

- 인출이 가능하도록 하기 위해 출금주소가 포함된 서명된 데이타를 생성하기

  ```shell
  agora.bat deposit-cli generate-bls-to-execution-change <folder>
  ```
  `<folder>` 는 서명된 데이타가 저장될 폴더입니다. 입력하지 않으면 `./bls_to_execution_changes` 로 처리됩니다.


- 출금주소가 포함된 서명된 데이타를 네트워크로 전송하기

  ```shell
  agora.bat validator withdraw <folder>
  ```
  `<folder>` 는 서명된 데이타가 저장된 폴더입니다. 기본 폴더는 `./bls_to_execution_changes`
  

### 슬래싱 방지 (윈도우즈 사용자용)

- export

  ```shell
  ./agora.bat validator slashing-protection-history export <folder>
  ```
  `<folder>` 는 슬래싱 방지를 위한 데이타가 저장될 폴더입니다. 입력하지 않으면 `./slashing-protection-export` 로 처리됩니다.


- import

  ```shell
  ./agora.bat validator slashing-protection-history import <folder>
  ```
  `<folder>` 는 슬래싱 방지를 위한 데이타가 저장된 폴더입니다. 입력하지 않으면 `./slashing-protection-export` 로 처리됩니다.


### 도커 컴포우즈 사용 (윈도우즈 사용자용)

1. 실행 계층의 블록데이타를 초기화하기

```shell
agora.bat el-node init
```

2. 검증자 키를 임포트하기

```shell
agora.bat validator import <your key stores folder>
```

또는

```shell
agora.bat validator accounts import <your key stores folder>
```

3. 프로세스 자동실행을 위해 월렛의 비밀번호를 기록하기

```shell
notepad ./root/config/cl/password.txt
```

4. 트랜잭션 수수료를 받을 주소를 등록하기

```shell
notepad ./root/config/cl/proposer_config.json
```

5. 도커 컴포우즈를 실행

```shell
agora.bat docker-compose up
```

6. 도커 컴포우즈를 종료

```shell
agora.bat docker-compose down
```

### 모니터링을 위한 도커 컴포우즈 사용 (윈도우즈 사용자용)

1. 실행 계층의 블록데이타를 초기화하기

```shell
agora.bat el-node init
```

2. 검증자 키를 임포트하기

```shell
agora.bat validator import <your key stores folder>
```

또는

```shell
agora.bat validator accounts import <your key stores folder>
```

3. 프로세스 자동실행을 위해 월렛의 비밀번호를 기록하기

```shell
notepad ./root/config/cl/password.txt
```

4. 트랜잭션 수수료를 받을 주소를 등록하기

```shell
notepad ./root/config/cl/proposer_config.json
```

5. 도커 컴포우즈를 실행

```shell
agora.bat docker-compose-monitoring up
```

또는

```shell
agora.bat start
```

6. 도커 컴포우즈를 종료

```shell
agora.bat docker-compose-monitoring down
```

또는

```shell
agora.bat stop
```

## 부가적인 정보들

[AWS 의 Ubuntu 에 BOSagora 노드 설치하기](docs/INSTALL-NODE-UBUNTU-KR.md)  
[NHN 클라우드의 Ubuntu 에 BOSagora 노드 설치하기](docs/INSTALL-NODE-UBUNTU-NHNCLOUD-KR.md)
