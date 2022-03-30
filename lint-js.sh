#!/bin/bash

# Run setup.
. ./setup.sh

# Run the lint command from the wp-content directory.
if [ "$fix" = "1" ]; then
	npm run lint:js "$plugindir" --config .eslintrc --fix;
else
	npm run lint:js "$plugindir" --config .eslintrc;
fi
