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

TAP_DEV=tap$1
TAP_IP=172.16.$1.1
ethtool -i ${TAP_DEV} &> /dev/null
if (($? >> 0)); then
	sudo ip tuntap add ${TAP_DEV} mode tap
	sudo ip addr add ${TAP_IP}/24 dev ${TAP_DEV}
	sudo ip link set ${TAP_DEV} up
	sudo iptables -A FORWARD -i ${TAP_DEV} -o wlan0 -j ACCEPT
	echo "New TAP device created."
else
	echo "Reusing existing TAP device."
fi

SOCKET_FILE=/tmp/firecracker_$1.socket
if test -e "$SOCKET_FILE"; then
	rm ${SOCKET_FILE}
	echo "Existing socket file deleted."
fi

echo "Starting VMM $1..."
sudo ./firecracker --api-sock ${SOCKET_FILE}
sudo rm ${SOCKET_FILE}
