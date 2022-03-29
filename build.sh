#!/bin/bash

while getopts 'c:p:' flag; do
	case "${flag}" in
		c) cwdiswppslinter=${OPTARG} ;;
		p) plugindirname=${OPTARG} ;;
	esac
done

# Get the absolute path to the plugin we want to check.
if [ "$cwdiswppslinter" = "1" ]; then
	plugindir="$(dirname "$(dirname "$(dirname "$(dirname "$(realpath "$0")" )" )" )" )/$plugindirname"
else
	plugindir="$(dirname "$(dirname "$(realpath "$0")" )" )"
fi

# Loop through each wp-module in the plugin.
for DIR in $plugindir/wp-modules/*; do
	find=$plugindir
	replace=""
	moduledir="${DIR/${plugindir}/${replace}}"

	# If this module has a package.json file.
	if [[ -f "$DIR/package.json" ]]
	then
		# Go to the directory of this wp-module.
		cd "$DIR";
		# Run npm install for this module.
		npm install;
		
		# Run the build script for this module.
		npm run build;
	fi

done

# Finish with a wait command, which lets a kill (cmd+c) kill all of the process created in this loop.
wait;