#!/bin/bash

for vmm_id in $(seq 0 $(($1 - 1))); do
	./set-all.sh $vmm_id &>massive.log &
done
