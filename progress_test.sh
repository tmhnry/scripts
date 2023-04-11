#!/bin/bash

total=36
for task in $(seq $total); do
	sleep 0.5
	show_progress $task $total
done
