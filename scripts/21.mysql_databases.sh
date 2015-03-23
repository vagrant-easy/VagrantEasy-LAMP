#!/bin/bash

function error_exit
{
	echo "$1" 1>&2
	exit 1
}

# No Defaults for you!

# Set needed vars using passed parameters:
while [[ $# > 1 ]]
do
  key="$1"

  case $key in
      --db_name)
      DB_NAME="$2"
      shift
      ;;
      --db_user)
      DB_USER="$2"
      shift
      ;;
      --db_pass)
      DB_PASS="$2"
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

if [ -z ${DB_NAME+x} ]; then error_exit "--db_name is not set!"; fi
if [ -z ${DB_USER+x} ]; then error_exit "--db_user is not set!"; fi
if [ -z ${DB_PASS+x} ]; then error_exit "--db_pass is not set!"; fi
if [ -z ${ROOT_PASS+x} ]; then error_exit "--root_pass is not set!"; fi

mysql -u root -p$ROOT_PASS -e "create database ${DB_NAME}; GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO ${DB_USER}@localhost IDENTIFIED BY '${DB_PASS}'"