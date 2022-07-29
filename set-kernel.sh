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
KERNEL_PATH=$(pwd)"/hello-vmlinux.bin"
TAP_IP=172.16.$1.1
GUEST_IP=172.16.$1.128

sudo curl --unix-socket $SOCKET_FILE -i \
	-X PUT 'http://localhost/boot-source'   \
	-H 'Accept: application/json'           \
	-H 'Content-Type: application/json'     \
	-d '{
		"kernel_image_path": "'${KERNEL_PATH}'",
		"boot_args": "keep_bootcon console=ttyS0 reboot=k panic=1 pci=off ip='$GUEST_IP'::'$TAP_IP':255.255.0.0::eth0:none"
	}'
