#!/bin/bash

# copy contents of this directory to /usr/local/bin
SYM="/usr/local/bin"

# expand the absolute path of this directory
DIR="$(realpath ".")"

# ${BASH_SOURCE:-$0} only called once in the loop, better to define it here
# use "" to stringify the standard output
SRC="$(basename "${BASH_SOURCE:-$0}")"
# remove extension
# SRC="${SRC%.*}"

install(){
	for FILE in $DIR/*.sh
	do
		BASE="$(basename "${FILE}")"
		# use ==, sometimes -eq doesn't workA
		# remove file extensions
		if [[ "${BASE%.*}" == "${SRC%.*}" ]]; then
			echo "skipping $SRC..."
		else
			echo_run sudo ln -s $FILE "$SYM/${BASE%.*}"
		fi
	done
}

clean(){
	for FILE in $DIR/*.sh
	do
		BASE="$(basename "${FILE}")"
		# use ==, sometimes -eq doesn't workA
		# remove file extensions
		if [[ "${BASE%.*}" == "${SRC%.*}" ]]; then
			echo "skipping $SRC..."
		else
			echo_run sudo unlink "$SYM/${BASE%.*}"
		fi
	done

	# https://linuxize.com/post/how-to-remove-symbolic-links-in-linux/
	find $SYS -maxdepth 1 -xtype l
}
