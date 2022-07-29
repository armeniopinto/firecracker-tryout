#!/bin/bash

# Checks if a VMM ID was supplied...
if (($# == 0)); then
	echo "I need a VMM ID please."
	exit 1
fi
# ... and it's valid.
if (($1 < 0 || $1 >= 100)); then
	echo "Please give me a VMM ID between 0 and 99."
	exit 1
fi

SOCKET_FILE=/tmp/firecracker_$1.socket

sudo curl --unix-socket ${SOCKET_FILE} -i \
	-X PUT 'http://localhost/actions' \
	-H 'Accept: application/json' \
 	-H 'Content-Type: application/json' \
	-d '{
		"action_type": "InstanceStart"
	}'
