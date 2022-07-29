#!/bin/bash

firecracker-tryout/init-network.sh
for vmm_id in $(seq 0 $(($1 - 1))); do
	nohup ./start-firecracker.sh $vmm_id &>massive_firecracker.log & 
	echo VMM $vmm_id started.
done
