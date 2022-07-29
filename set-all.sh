#!/bin/bash

./set-rootfs.sh $1
echo VMM $1 root file system configured.
./set-network.sh $1
echo VMM $1 network configured.
./set-kernel.sh $1
echo VMM $1 kernel configured.
./start-guest.sh $1
echo VMM $1 guest started!
