#!/bin/bash

while getopts 'c:' flag; do
	case "${flag}" in
		c) cwdiswppslinter=${OPTARG} ;;
	esac
done
