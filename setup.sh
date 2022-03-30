#!/bin/bash

while getopts 'p:n:t:f:' flag; do
	case "${flag}" in
		p) plugindirname=${OPTARG} ;;
		n) namespace=${OPTARG} ;;
		t) textdomain=${OPTARG} ;;
		f) fix=${OPTARG} ;;
	esac
done

if [ ! "$(realpath "$0")" ]; then
	echo "The realpath command might not exist. If you're on macOS, you may need to do 'brew install coreutils'"
	exit 1
fi

# Define the absolute path to the plugin we want to deal with.
plugindir="$(dirname "$(dirname "$(realpath "$0")" )" )"/plugins/$plugindirname

# Install dependencies.
if [ ! -d node_modules ] || [ ! -d vendor ]; then
	npm install
	composer install
fi