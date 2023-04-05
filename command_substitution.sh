#!/bin/bash

for url in $(cat example.md); 	
	do 
		host $url;
	done
