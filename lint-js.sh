#!/bin/bash

# Run setup.
. ./setup.sh

# Check if there is an .eslintrc file in this project. If so, use it for standards. Otherwise,
if [ -f "$plugindir/.eslintrc" ];
then
	if [ "$fix" = "1" ]; then
		npm run lint:js "$plugindir" -- --config $plugindir/.eslintrc --fix;
	else
		npm run lint:js "$plugindir" -- --config $plugindir/.eslintrc;
	fi
else 
	# Run the lint command from the wp-content directory.
	if [ "$fix" = "1" ]; then
		npm run lint:js "$plugindir" -- --fix;
	else
		npm run lint:js "$plugindir";
	fi
fi
