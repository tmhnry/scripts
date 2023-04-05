#!/bin/bash

while getopts t: flag;
do
    case "${flag}" in
            t) TYPE=${OPTARG};;
            *)
                    printf "Use [-t] for file type. Available options: \n<android> (Android)\n<nodejs> (Node JS)\n"
      esac
done

cp "$HOME/Bash/gitignore_$TYPE.md" .gitignore
