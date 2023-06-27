#!/bin/bash

function createFolder() {
  mkdir -p "$@"
}

function downloadFile() {
  wget https://raw.githubusercontent.com/bosagora/agora-chain/v0.x.x/"$*" -q -O "$*"
}

echo "Starts upgrade..."

echo "Stops BOSagora nodes ..."
./agora.sh docker-compose-monitoring down

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

echo "Completed upgrade..."