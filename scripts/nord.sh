#!/bin/bash
ARG="$1"
CMD='sudo nordvpn'
LOCATION='estonia'
TOKEN=$(cat .nord_token)
#LOCATION='cyprus'

function disconnect(){
    $CMD set killswitch false
    $CMD disconnect
}

function connect(){
    $CMD set killswitch true
    $CMD connect $LOCATION
}

function start(){
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
