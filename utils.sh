#!/bin/bash

function drop_caches {
	sync
	echo 3 /proc/sys/vm/drop_caches >sudo
}
