#!/bin/bash

mkdir -p monitoring
mkdir -p monitoring/dashboard
mkdir -p monitoring/prometheus
mkdir -p root
mkdir -p root/config
mkdir -p root/config/cl
mkdir -p root/config/el

wget https://raw.githubusercontent.com/bosagora/agora-chain/mainnet/monitoring/dashboard/agora-chain-dashboard.json -O monitoring/dashboard/agora-chain-dashboard.json
wget https://raw.githubusercontent.com/bosagora/agora-chain/mainnet/monitoring/prometheus/config.yml -O monitoring/prometheus/config.yml
wget https://raw.githubusercontent.com/bosagora/agora-chain/mainnet/root/config/cl/chain-config.yaml -O root/config/cl/chain-config.yaml
wget https://raw.githubusercontent.com/bosagora/agora-chain/mainnet/root/config/cl/config.yaml -O root/config/cl/config.yaml
wget https://raw.githubusercontent.com/bosagora/agora-chain/mainnet/root/config/el/config.toml -O root/config/el/config.toml
wget https://raw.githubusercontent.com/bosagora/agora-chain/mainnet/root/config/el/genesis.json -O root/config/el/genesis.json
wget https://raw.githubusercontent.com/bosagora/agora-chain/mainnet/agora.bat -O agora.bat
wget https://raw.githubusercontent.com/bosagora/agora-chain/mainnet/agora.sh -O agora.sh
wget https://raw.githubusercontent.com/bosagora/agora-chain/mainnet/docker-compose.yml -O docker-compose.yml
wget https://raw.githubusercontent.com/bosagora/agora-chain/mainnet/docker-compose-monitoring.yml -O docker-compose-monitoring.yml

chmod agora.sh 755
