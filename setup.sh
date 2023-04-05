#!/bin/bash

# copy contents of this directory to /usr/local/bin

# expand the absolute path of this directory
DIR=$(realpath ".")

# ${BASH_SOURCE:-$0} only called once in the loop, better to define it here
# use "" to stringify the standard output
SRC="$(basename "${BASH_SOURCE:-$0}")"

# remove basename extension
SRC_NE="${SRC%.*}"

for FILE in "$DIR/*.sh"
do
	BASE="$(basename "${FILE}")"
	# -eq does not work names with extensions
	if [[ $SRC_BASE -eq $SRC_BASE ]]; then
		printf "True"
	fi
# 	if [[ $BASE = $SRC ]]; then
# 		echo $BASE
# # 	# 	# BASE_SRC=$(basename "${BASH_SOURCE:-$0}")

done
