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
