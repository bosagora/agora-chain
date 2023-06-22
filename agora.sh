#!/bin/bash

echo "agora.sh version 2.0.0"

MAINNET="mainnet"
TESTNET="testnet"
DEVNET="devnet"

function color() {
  # Usage: color "31;5" "string"
  # Some valid values for color:
  # - 5 blink, 1 strong, 4 underlined
  # - fg: 31 red,  32 green, 33 yellow, 34 blue, 35 purple, 36 cyan, 37 white
  # - bg: 40 black, 41 red, 44 blue, 45 purple
  printf '\033[%sm%s\033[0m\n' "$@"
}

current_path="$(pwd)"
script_path="$(dirname "$0")"
network=""

function getNetwork() {

  if [ ! -f ".network" ]
  then
    network="$MAINNET"
    rm -f "$(pwd)/$script_path/.network" && echo "$network" >> "$(pwd)/$script_path/.network"
  else
    network="$(cat -s "$(pwd)/$script_path/.network")"

    if [ "$network" != "$MAINNET" ] && [ "$network" != "$TESTNET" ] && [ "$network" != "$DEVNET" ]
    then

      network="$MAINNET"
      rm -f "$(pwd)/$script_path/.network" && echo "$network" >> "$(pwd)/$script_path/.network"

    fi
  fi

}

function createFolder() {
  mkdir -p "$@"
}

function downloadFile() {
  wget https://raw.githubusercontent.com/bosagora/agora-chain/v0.x.x/"$*" -q -O "$*"
}

if [ ! -d "networks" ]
then

  echo "Starts install ..."

  echo "Creating folds ..."
  createFolder networks
  createFolder networks/mainnet
  createFolder networks/testnet
  createFolder networks/devnet

  createFolder networks/mainnet/monitoring
  createFolder networks/mainnet/monitoring/dashboard
  createFolder networks/mainnet/monitoring/prometheus
  createFolder networks/mainnet/root
  createFolder networks/mainnet/root/config
  createFolder networks/mainnet/root/config/cl
  createFolder networks/mainnet/root/config/el

  createFolder networks/testnet/monitoring
  createFolder networks/testnet/monitoring/dashboard
  createFolder networks/testnet/monitoring/prometheus
  createFolder networks/testnet/root
  createFolder networks/testnet/root/config
  createFolder networks/testnet/root/config/cl
  createFolder networks/testnet/root/config/el

  createFolder networks/devnet/monitoring
  createFolder networks/devnet/monitoring/dashboard
  createFolder networks/devnet/monitoring/prometheus
  createFolder networks/devnet/root
  createFolder networks/devnet/root/config
  createFolder networks/devnet/root/config/cl
  createFolder networks/devnet/root/config/el

  echo "Downloading files used on the main network ..."
  downloadFile networks/mainnet/monitoring/dashboard/agora-chain-dashboard.json
  downloadFile networks/mainnet/monitoring/prometheus/config.yml
  downloadFile networks/mainnet/root/config/cl/chain-config.yaml
  downloadFile networks/mainnet/root/config/cl/config.yaml
  downloadFile networks/mainnet/root/config/cl/password.txt
  downloadFile networks/mainnet/root/config/cl/proposer_config.json
  downloadFile networks/mainnet/root/config/el/config.toml
  downloadFile networks/mainnet/root/config/el/genesis.json
  downloadFile networks/mainnet/agora.bat
  downloadFile networks/mainnet/agora.sh
  downloadFile networks/mainnet/docker-compose.yml
  downloadFile networks/mainnet/docker-compose-monitoring.yml

  echo "Downloading files used on the test network ..."
  downloadFile networks/testnet/monitoring/dashboard/agora-chain-dashboard.json
  downloadFile networks/testnet/monitoring/prometheus/config.yml
  downloadFile networks/testnet/root/config/cl/chain-config.yaml
  downloadFile networks/testnet/root/config/cl/config.yaml
  downloadFile networks/testnet/root/config/cl/password.txt
  downloadFile networks/testnet/root/config/cl/proposer_config.json
  downloadFile networks/testnet/root/config/el/config.toml
  downloadFile networks/testnet/root/config/el/genesis.json
  downloadFile networks/testnet/agora.bat
  downloadFile networks/testnet/agora.sh
  downloadFile networks/testnet/docker-compose.yml
  downloadFile networks/testnet/docker-compose-monitoring.yml

  echo "Downloading files used on the development network ..."
  downloadFile networks/devnet/monitoring/dashboard/agora-chain-dashboard.json
  downloadFile networks/devnet/monitoring/prometheus/config.yml
  downloadFile networks/devnet/root/config/cl/chain-config.yaml
  downloadFile networks/devnet/root/config/cl/config.yaml
  downloadFile networks/devnet/root/config/cl/password.txt
  downloadFile networks/devnet/root/config/cl/proposer_config.json
  downloadFile networks/devnet/root/config/el/config.toml
  downloadFile networks/devnet/root/config/el/genesis.json
  downloadFile networks/devnet/agora.bat
  downloadFile networks/devnet/agora.sh
  downloadFile networks/devnet/docker-compose.yml
  downloadFile networks/devnet/docker-compose-monitoring.yml

  downloadFile agora.bat
  downloadFile agora.sh

  chmod 755 networks/mainnet/agora.sh
  chmod 755 networks/testnet/agora.sh
  chmod 755 networks/devnet/agora.sh
  chmod 755 agora.sh


  FILENAME=root/config/el/genesis.json

  if [ -f "$FILENAME" ]
  then

    echo "Starts migration ..."

    if find . | grep -q "2151" "$FILENAME"
    then
        cp -rf root/chain networks/mainnet/root/
        cp -rf root/wallet networks/mainnet/root/
        cp -f root/config/cl/password.txt networks/mainnet/root/config/cl/password.txt
        cp -f root/config/cl/proposer_config.json networks/mainnet/root/config/cl/proposer_config.json
        mv -f root .root
        rm docker-compose.yml
        rm docker-compose-monitoring.yml
        ./agora.sh network mainnet
    elif find . | grep -q "2019" "$FILENAME"
    then
        cp -rf root/chain networks/testnet/root/
        cp -rf root/wallet networks/testnet/root/
        cp -f root/config/cl/password.txt networks/testnet/root/config/cl/password.txt
        cp -f root/config/cl/proposer_config.json networks/testnet/root/config/cl/proposer_config.json
        mv -f root .root
        rm docker-compose.yml
        rm docker-compose-monitoring.yml
        ./agora.sh network testnet
    elif find . | grep -q "1337" "$FILENAME"
    then
        cp -rf root/chain networks/devnet/root/
        cp -rf root/wallet networks/devnet/root/
        cp -f root/config/cl/password.txt networks/devnet/root/config/cl/password.txt
        cp -f root/config/cl/proposer_config.json networks/devnet/root/config/cl/proposer_config.json
        mv -f root .root
        rm docker-compose.yml
        rm docker-compose-monitoring.yml
        ./agora.sh network devnet
    fi

    echo "Completed migration ..."

  fi

  echo "Completed install ..."

  exit

fi

if [ "$#" -lt 1 ]; then
    color "31;5" "Usage: ./agora.sh PROCESS FLAGS."
    color "31;5" "PROCESS can be el-node, cl-node, validator, docker-compose, docker-compose-monitoring, start, stop, exec, upgrade"
    color "37;1" ""
    color "33;5" "./agora.sh network <network to change>"
    color "37;1" "       - <network to change> is one of mainnet, testnet, and devnet, and the default is mainnet."
    color "37;1" "       - If <network to change> is not specified, it shows the currently set up network."
    color "37;1" ""
    color "33;5" "./agora.sh el-node ( init, run )"
    color "34;5" "    el-node init"
    color "37;1" "       - Initialize agora-el. At this point, all existing block data is deleted."
    color "34;5" "    el-node run"
    color "37;1" "       - Run agora-el."
    color "37;1" ""
    color "33;5" "./agora.sh cl-node ( run )"
    color "34;5" "    cl-node run"
    color "37;1" "       - Run agora-cl."
    color "37;1" ""
    color "33;5" "./agora.sh validator ( accounts, exit, withdraw, slashing-protection-history, wallet )"
    color "37;1" ""
    color "33;5" "./agora.sh validator accounts ( import, list, backup )"
    color "34;5" "    validator accounts import <validator keys folder>"
    color "37;1" "       - Add the validator's keys to the local wallet."
    color "34;5" "    validator accounts list"
    color "37;1" "       - Show the validator's keys stored in the local wallet."
    color "34;5" "    validator accounts delete"
    color "37;1" "       - Delete the validator's keys from the local wallet."
    color "34;5" "    validator accounts backup <validator keys folder>"
    color "37;1" "       - Back up the validator's keys stored in the local wallet."
    color "37;1" ""
    color "34;5" "    validator exit"
    color "37;1" "       - Used to voluntarily exit the validator's function. After this is done, you will see a screen where you select the validator's keys."
    color "34;5" "    validator withdraw <data folder>"
    color "37;1" "       - Send pre-created withdrawal address registration data to the network."
    color "37;1" "       - Currently, only devnet is supported. Other networks will be supported later."
    color "37;1" ""
    color "33;1" "./agora.sh validator slashing-protection-history ( export, import ) "
    color "34;5" "    validator slashing-protection-history export <data folder>"
    color "37;1" "       - Save the information that the verifiers worked on as a file. At this point, the validator on the current server must be stopped."
    color "37;1" "       - One validator must validate only once per block. Otherwise, the validator may be slashed."
    color "37;1" "           - If a validator runs on multiple servers, that validator may violate the above condition."
    color "37;1" "           - If a validator's server is changed to another server, the validator may violate the above condition."
    color "37;1" "           - To avoid this, you need to transfer the block verification information that the validators has performed so far."
    color "34;5" "    validator slashing-protection-history import <data folder>"
    color "37;1" "       - Register block verification information performed by validators."
    color "37;1" ""
    color "33;1" "./agora.sh validator wallet ( create, recover ) "
    color "34;5" "    validator wallet create <wallet folder>"
    color "37;1" "       - Create an HD wallet."
    color "34;5" "    validator wallet recover <wallet folder>"
    color "37;1" "       - Recovery an HD wallet."
    color "37;1" ""
    color "33;5" "./agora.sh deposit-cli ( new-mnemonic, existing-mnemonic, generate-bls-to-execution-change )"
    color "34;5" "    deposit-cli new-mnemonic"
    color "37;1" "       - This command is used to generate keystores with a new mnemonic."
    color "34;5" "    deposit-cli existing-mnemonic"
    color "37;1" "       - This command is used to re-generate or derive new keys from your existing mnemonic."
    color "34;5" "    deposit-cli generate-bls-to-execution-change <data folder>"
    color "37;1" "       - Generates the data required to register the address to which the validator's amount will be withdrawn."
    color "37;1" "       - Currently, only devnet is supported. Other networks will be supported later."
    color "37;1" ""
    color "33;5" "./agora.sh docker-compose ( up, down )"
    color "34;5" "    docker-compose up"
    color "37;1" "       - Run agora-el, agora-cl, validator."
    color "34;5" "    docker-compose down"
    color "37;1" "       - Stop agora-el, agora-cl, validator."
    color "37;1" ""
    color "33;5" "./agora.sh docker-compose-monitoring ( up, down )"
    color "34;5" "    docker-compose-monitoring up"
    color "37;1" "        - Run agora-el, agora-cl, validator, and containers required for monitoring."
    color "34;5" "    docker-compose-monitoring down"
    color "37;1" "       - Stop agora-el, agora-cl, validator, and containers required for monitoring."
    color "37;1" ""
    color "33;5" "./agora.sh start"
    color "37;1" "       - Run agora-el, agora-cl, validator, and containers required for monitoring."
    color "37;1" "       - It's the same as './agora.sh docker-compose-monitoring up'"
    color "37;1" ""
    color "33;5" "./agora.sh stop"
    color "37;1" "       - Stop agora-el, agora-cl, validator, and containers required for monitoring."
    color "37;1" "       - It's the same as './agora.sh docker-compose-monitoring down'"
    color "37;1" ""
    color "33;5" "./agora.sh exec ( el-node, cl-node, cl-validator, cl-ctl )"
    color "34;5" "    exec el-node ..."
    color "37;1" "       - Run agora-el-node with user-entered parameters."
    color "34;5" "    exec cl-node ..."
    color "37;1" "       - Run agora-cl-node with user-entered parameters."
    color "34;5" "    exec cl-validator ..."
    color "37;1" "       - Run agora-cl-validator with user-entered parameters."
    color "34;5" "    exec cl-ctl ..."
    color "37;1" "       - Run agora-cl-ctl with user-entered parameters."
    color "37;1" ""
    color "33;5" "./agora.sh upgrade"
    color "37;1" "       - The latest version is installed, at which point the user data is preserved."
    exit 1
fi

getNetwork

if [ "$1" = "upgrade" ]
then

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/bosagora/agora-chain/v0.x.x/upgrade.sh)"

  exit

elif [ "$1" = "network" ]
then

  if [ "$2" = "$MAINNET" ] || [ "$2" = "$TESTNET" ] || [ "$2" = "$DEVNET" ]
  then

    rm -f "$(pwd)/$script_path/.network" && echo "$2" >> "$(pwd)/$script_path/.network"

    getNetwork

    echo "Current network is $network"

  else

    echo "Current network is $network"

  fi

  exit

fi

echo "The selected network is '$network'"
if [ "$network" = "$MAINNET" ] || [ "$network" = "$TESTNET" ] || [ "$network" = "$DEVNET" ]
then

  network_path="$(pwd)/$script_path/networks/$network"
  cd "$network_path"
  ./agora.sh "$@"
  cd "$current_path"

else

  color "31" "Network '$network' is not available!"

fi
