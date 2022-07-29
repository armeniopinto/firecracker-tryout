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
TAP_DEV=tap$1
MAC_SUFFIX=$1
if (($1 < 10)); then MAC_SUFFIX=0$MAC_SUFFIX; fi
MAC_ADDR=AA:FF:00:00:00:$MAC_SUFFIX

sudo curl --unix-socket ${SOCKET_FILE} -i \
	-X PUT 'http://localhost/network-interfaces/eth0' \
	-H 'Accept: application/json' \
	-H 'Content-Type: application/json' \
	-d '{
		"iface_id": "eth0",
		"guest_mac": "'${MAC_ADDR}'",
		"host_dev_name": "'${TAP_DEV}'"
	}'
