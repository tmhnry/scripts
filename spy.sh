#!/bin/bash

# see https://stackoverflow.com/questions/66059142/what-will-be-the-best-way-to-create-a-temporary-text-file-for-bash-output-proces

tmp=$(mktemp)

[ "$?" -eq 0 ] || {
	printf "error: mktemp had non-zero exit code .\n" >&2
	exit 1
}

[ -f "$tmp" ] || {
	printf "error: tempfile does not exist. \n" >&2
}

## set trap to remove temp file on termination, interrupt or exit
trap 'rm -f "$tmp"' SIGTERM SIGINT EXIT

tldr $1 >$tmp

if [[ $? -eq 0 ]]; then
	vim $tmp
else
	clear && printf 'exit status %d, %s\n' $? "invalid --tldr on $1"
fi

cat >"$tmp" <<eof
The temporary file was successfully created at: '$tmp'.
eof

cat "$tmp"
