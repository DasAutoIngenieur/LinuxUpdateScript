#!/bin/bash
detect_os_release() {
    os_type=$(uname -s)
    case "$os_type" in
        Linux*)
            if [ -f /etc/os-release ]; then
                grep PRETTY_NAME /etc/os-release | cut -d '"' -f 2
            elif [ -f /etc/centos-release ]; then
                cat /etc/centos-release
            elif [ -f /etc/redhat-release ]; then
                cat /etc/redhat-release
            elif [ -f /etc/fedora-release ]; then
                cat /etc/fedora-release
            elif [ -f /etc/debian_version ]; then
                echo "Debian $(cat /etc/debian_version)" > /dev/null
            elif [ -f /etc/arch-release ]; then
                cat /etc/arch-release
            else
                echo "Unknown Linux distribution"
                exit 1
            fi
            ;;
        Darwin*)
            sw_vers -productVersion
            ;;
        OpenBSD*)
            cat /etc/bsd.rd
            ;;
        FreeBSD*)
            cat /etc/version
            ;;
        *)
            echo "Unsupported OS: $os_type"
            exit 1
            ;;
    esac
}

update_os() {
    os_type=$(uname -s)
    case "$os_type" in
        Linux*)
            if [ -x "$(command -v apt-get)" ]; then
                sudo apt-get update && sudo apt-get upgrade -y
            elif [ -x "$(command -v yum)" ]; then
                sudo yum update -y
            elif [ -x "$(command -v dnf)" ]; then
                sudo dnf update -y
            elif [ -x "$(command -v pacman)" ]; then
                sudo pacman -Syu --noconfirm
            else
                exit 1
            fi
            ;;
        Darwin*)
            sudo softwareupdate -i -a
            ;;
        *)
            exit 1
            ;;
    esac
}

if ping -c 1 google.com &> /dev/null; then
   detect_os_release
   echo "$os_type Detected, Starting Update"
   echo "starting Update $update_os"
else
    echo "No Network Connection, Check Network interfaces"
fi
