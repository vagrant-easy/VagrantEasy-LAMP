#!/bin/bash

function error_exit
{
	echo "$1" 1>&2
	exit 1
}

# Defaults:
HOST="example.dev"
ROOT_PASS="root"

# Override defaults using passed parameters:
while [[ $# > 1 ]]
do
  key="$1"

  case $key in
      --host)
      HOST="$2"
      shift
      ;;
      --root_pass)
      ROOT_PASS="$2"
      shift
      ;;
      --default)
      DEFAULT=YES
      shift
      ;;
      *)
        # Die if parameter not listed above.
        error_exit "Unknown option '$key' with value '$2'! Aborting..."
      ;;
  esac
  shift
done

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password ${ROOT_PASS}"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${ROOT_PASS}"
sudo apt-get -y install mysql-server