#!/bin/bash

# Checks if a VMM ID was supplied...
if (($# == 0)); then
	echo "I need a VMM ID please."
	exit 1
fi
# ... and it's valid.
if (($1 < 0 || $1 > 100)); then
	echo "Please give me a VMM ID between 0 and 99."
	exit 1
fi

SOCKET_FILE=/tmp/firecracker_$1.socket
ROOTFS_PATH=$(pwd)"/hello-rootfs.ext4"

sudo curl --unix-socket ${SOCKET_FILE} -i \
	-X PUT 'http://localhost/drives/rootfs' \
	-H 'Accept: application/json'           \
	-H 'Content-Type: application/json'     \
	-d '{
		"drive_id": "rootfs",
		"path_on_host": "'${ROOTFS_PATH}'",
		"is_root_device": true,
		"is_read_only": false
	}'
