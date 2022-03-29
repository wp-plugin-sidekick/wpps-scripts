#!/bin/bash

while getopts 'p:n:t:f:' flag; do
	case "${flag}" in
		p) plugindirname=${OPTARG} ;;
		n) namespace=${OPTARG} ;;
		t) textdomain=${OPTARG} ;;
		f) fix=${OPTARG} ;;
	esac
done

# Get the absolute path to the plugin we want to check.
plugindir="$(dirname "$(dirname "$(realpath "$0")" )" )"/plugins/$plugindirname

# Run the lint command from the wp-content directory.
if [ "$fix" = "1" ]; then
	npm run lint:css "$plugindir/**/*.*css"  -- --fix;
else
	npm run lint:css "$plugindir/**/*.*css";
fi