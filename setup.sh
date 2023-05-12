#!/bin/bash

while getopts 'p:n:t:f:' flag; do
	case "${flag}" in
		p) plugindir=${OPTARG} ;;
		n) namespace=${OPTARG} ;;
		t) textdomain=${OPTARG} ;;
		f) fix=${OPTARG} ;;
	esac
done

wpps_scripts_dir="$PWD";

plugindirname=$(basename "$plugindir")

# Make sure the node version matches.
nodeversion=$( node -v );
if [[ $nodeversion != v14* ]]; then
	echo "Your version of node needs to be v14, but it is set to be "$nodeversion;
	exit 1;
fi

# Install dependencies.
if [ ! -d node_modules ] || [ ! -d vendor ]; then
	npm install
	composer install
fi

# Loop through each wp-module in the plugin, and install their dependencies.
for DIR in "$plugindir"/wp-modules/*; do
	# If this module has a package.json file.
	if [ -f "$DIR"/package.json ]; then
		# Go to the directory of this wp-module.
		cd "$DIR";

		# Run npm install for this module.
		if [ ! -d node_modules ]; then
			npm install;
		fi
		
		cd - > /dev/null
	fi
done
