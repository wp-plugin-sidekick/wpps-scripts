#!/bin/bash

# Run setup.
. ./setup.sh

# Loop through each wp-module in the plugin.
for DIR in "$plugindir"/wp-modules/*; do
	# If this module has a package.json file.
	if [ -f "$DIR"/package.json ]; then
		# Go to the directory of this wp-module.
		cd "$DIR";

		# If a node_modules directory exists.
		if [ -d node_modules ]; then
			# Move copies of node_modules required to run tests with react-test-renderer to each wp-modules node_modules directory.
			# This allows wp-modules to keep testing dependencies out of their package.json files, and instead rely on wpps-scripts to handle that.
			cp -r "$wpps_scripts_dir"/node_modules/react-test-renderer "$DIR"/node_modules/react-test-renderer
			
			mkdir -p "$DIR"/node_modules/@types
			cp -r "$wpps_scripts_dir"/node_modules/@types/jest "$DIR"/node_modules/@types/jest
			cp -r "$wpps_scripts_dir"/node_modules/@types/react-test-renderer "$DIR"/node_modules/@types/react-test-renderer
			
			mkdir -p "$DIR"/node_modules/@testing-library
			cp -r "$wpps_scripts_dir"/node_modules/@testing-library/react "$DIR"/node_modules/@testing-library/react
			cp -r "$wpps_scripts_dir"/node_modules/@testing-library/dom "$DIR"/node_modules/@testing-library/dom
		fi
		
		cd - > /dev/null
	fi
done

npm run test:js -- --roots "$plugindir"
