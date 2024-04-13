#!/bin/bash
# Get the directory of the current script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ARG="$1"
CMD='sudo nordvpn'
LOCATION='cyprus'
TOKEN=$(cat $DIR/.nord_token)

function disconnect(){
    $CMD set killswitch false
    $CMD disconnect
}

function connect(){
    $CMD set killswitch true
    $CMD connect $LOCATION
}

function start(){
    sudo systemctl enable --now nordvpnd
	sudo nordvpn login --token $TOKEN
    sudo systemctl start nordvpnd
}

function stop(){
    sudo systemctl stop nordvpnd
}

if [[ $ARG == connect ]]
then
  connect
fi

if [[ $ARG == disconnect ]]
then
  disconnect
fi

if [[ $ARG == start ]]
then
    start
fi

if [[ $ARG == stop ]]
then
    stop
fi
