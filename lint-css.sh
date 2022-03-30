#!/bin/bash

# Run setup.
source ./setup.sh

# Run the lint command from the wp-content directory.
if [ "$fix" = "1" ]; then
	npm run lint:css "$plugindir/**/*.*css"  -- --fix;
else
	npm run lint:css "$plugindir/**/*.*css";
fi