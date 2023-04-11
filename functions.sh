#!/bin/bash

function echo_run {
	echo "$*"
	"$@"
}

function show_progress {
	current="$1"
	total="$2"

	# bar size
	bar_length=40
	char_done="|"
	char_todo=" "

	# # of decimal places to show in $percent
	bar_scale=2

	# script uses bc calculator
	percent=$(bc <<<"scale=$bar_scale; 100 * $current / $total")

	done=$(bc <<<"scale=0; $bar_length * $percent / 100")
	todo=$(bc <<<"scale=0; $bar_length - $done")

	# printf"%{n}s" creates n space, tr substitutes the character to the spaces
	done_sbar=$(printf "%${done}s" | tr " " "${char_done}")
	todo_sbar=$(printf "%${todo}s" | tr " " "${char_todo}")

	# output the bar
	echo -ne "\rProgress : [${done_sbar}${todo_sbar}] ${percent}%"

	if [ $total -eq $current ]; then
		echo -e "\nDONE"
	fi
}
