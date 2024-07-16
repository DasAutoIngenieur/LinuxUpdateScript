#!/bin/bash
if ping -c 1 google.com &> /dev/null; then
    sudo apt update && sudo apt-get update
    sudo apt upgrade -y && sudo apt-get upgrade -y
else
    echo "No Network Connection, Check Network interfaces" 
fi
