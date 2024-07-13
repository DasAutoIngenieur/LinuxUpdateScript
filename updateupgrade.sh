if ping -c 1 google.com &> /dev/null; then
    sudo apt update && sudo apt-get update
else
    echo "No Network Connection, Check Network interfaces" 
