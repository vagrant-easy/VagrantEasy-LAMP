#!/bin/bash

function error_exit
{
	echo "$1" 1>&2
	exit 1
}

if [ -z "$1" ]; then error_exit "module name was not given!"; fi

a2enmod $1