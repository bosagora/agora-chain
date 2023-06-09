#!/bin/bash

echo "agora.sh version 2.0.0"

function color() {
    # Usage: color "31;5" "string"
    # Some valid values for color:
    # - 5 blink, 1 strong, 4 underlined
    # - fg: 31 red,  32 green, 33 yellow, 34 blue, 35 purple, 36 cyan, 37 white
    # - bg: 40 black, 41 red, 44 blue, 45 purple
    printf '\033[%sm%s\033[0m\n' "$@"
}

current_path="$(pwd)"
script_path=`dirname $0`
echo $script_path

network="mainnet"

if [ "$network" = "mainnet" ]; then

  network_path="$(pwd)/$script_path/networks/mainnet"
  cd "$network_path"
  ./agora.sh "$@"
  cd "$current_path"

elif [ "$network" = "testnet" ]; then

  network_path="$(pwd)/$script_path/networks/testnet"
  cd "$network_path"
  ./agora.sh "$@"
  cd "$current_path"

elif [ "$network" = "devnet" ]; then

  network_path="$(pwd)/$script_path/networks/devnet"
  cd "$network_path"
  ./agora.sh "$@"
  cd "$current_path"

else

    color "31" "Network '$network' is not available!"

fi
