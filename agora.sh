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

  echo "Completed install ..."

  exit

fi

getNetwork

if [ "$1" = "network" ]
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

if [ "$network" = "$MAINNET" ] || [ "$network" = "$TESTNET" ] || [ "$network" = "$DEVNET" ]
then

  network_path="$(pwd)/$script_path/networks/$network"
  cd "$network_path"
  ./agora.sh "$@"
  cd "$current_path"

else

    color "31" "Network '$network' is not available!"

fi
