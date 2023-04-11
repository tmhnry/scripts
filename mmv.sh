#!/bin/bash

# expand the absolute path of this directory
curr_dir="$(realpath ".")"

if [[ $# -eq 2 ]]; then
	echo "Using mv command instead."
	mv $1 $2
	exit 0
fi

declare -a input_files
itr=1
flg=0

declare -A flags
flags["-f"]=0
flags["-d"]=0
flags["-v"]=0

arg_size=$#

function set_input {
	while [[ $itr -le $arg_size ]]; do
		# https://stackoverflow.com/questions/3685970/check-if-a-bash-array-contains-a-value
		if [[ "${flags[*]}" =~ "${!itr}" ]]; then
			echo "skipping ${!itr}"
			break
		else
			echo "${!itr}"
		fi
		itr=$((itr + 1))
	done

	flags["-f"]=0
}

function set_output {
	if [[ "${flags[*]}" =~ "${!itr}" ]]; then
		echo "skipping ${!itr}"
	else
		echo "destination: ${!itr}"
	fi
	itr=$((itr + 1))

	flags["-d"]=0
}

while [[ $itr -le $arg_size ]]; do
	if [[ ${flags["-f"]} -gt 0 ]]; then
		set_input $@
	elif [[ ${flags["-d"]} -gt 0 ]]; then
		set_output $@
	# variable indirection
	# see https://stackoverflow.com/questions/10749976/bash-scripting-n-th-parameter-of-when-the-index-is-a-variable
	elif [[ "${!itr}" == "-f" ]]; then
		flags["-f"]=1
		itr=$((itr + 1))
	elif [[ "${!itr}" == "-d" ]]; then
		flags["-d"]=1
		itr=$((itr + 1))
	# elif [[ "$1" == "-v" ]]; then
	# 	flags["$1"]=1
	fi
done

# while getopts h:f:d flag; do
# 	case "${flag}" in
# 	h) /usr/bin/mv -h ;;
# 	f)
# 		shift 1
# 		echo ${OPTARG}
#
# 		declare -A SRC_FILES
# 		SIZE=0

# 		# while [[ "${1}" != "-d" ]]; do
# 		# 	SRC_FILES[$SIZE]=$1
# 		# 	SIZE=$((SIZE + 1))
# 		# 	shift 1
# 		# done
# 		#
# 		# if [[ $SIZE -gt 3 ]]; then
# 		# 	echo "Invalid use -f. Use -m instead."
# 		# 	unset SRC_FILES
# 		# elif [[ $SIZE -ne 1 ]]; then
# 		# 	for SRC in ${SRC_FILES[@]}; do
# 		# 		echo -e "$SRC\n"
# 		# 	done
# 		# fi
# 		;;
# 	d)
# 		echo "TRUE"
# 		# ls -la $(realpath $1)
# 		;;
# 	esac
# done
#
# unset SRC_FILES
