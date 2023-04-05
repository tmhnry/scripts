#!/bin/bash

. /usr/local/bin/functions

echo "Github Username: ":
read USER
echo_run eval $(ssh-agent)
echo_run ssh-add -D
echo_run ssh-add "$HOME/.ssh/$USER"
