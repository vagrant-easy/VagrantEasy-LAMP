#!/bin/bash

function error_exit
{
	echo "$1" 1>&2
	exit 1
}

# Defaults:
SSH_USER_NAME="admin"
SSH_USER_PASS="admin"
SSH_USER_CAN_SUDO=true

# Override defaults using passed parameters:
while [[ $# > 1 ]]
do
  key="$1"

  case $key in
      --ssh_user_name)
      SSH_USER_NAME="$2"
      shift
      ;;
      --ssh_user_pass)
      SSH_USER_PASS="$2"
      shift
      ;;
      --ssh_user_can_sudo)
      SSH_USER_CAN_SUDO="$2"
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

useradd -m -s /bin/bash $SSH_USER_NAME

if [ "$SSH_USER_PASS" != "no" ]; then
  echo "${SSH_USER_NAME}:${SSH_USER_PASS}" | chpasswd
else
  passwd -l $SSH_USER_NAME
fi

if $SSH_USER_CAN_SUDO
then
  echo "$SSH_USER_NAME  ALL=(ALL:ALL) ALL" >> /etc/sudoers
fi
