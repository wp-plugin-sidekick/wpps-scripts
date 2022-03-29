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

# Duplicate the phpcs.xml boiler, and call it phpcs.xml.
cp phpcs-boiler.xml phpcs.xml

# Modify the phpcs.xml file in the wpps-scripts module to contain the namespace and text domain of the plugin in question.
sed -i.bak "s/MadeWithWPPS/$namespace/g" phpcs.xml
sed -i.bak "s/madewithwpps/$textdomain/g" phpcs.xml

# Run the phpcs command from the wp-content directory.
if [ "$fix" = "1" ]; then
	./vendor/bin/phpcbf -q "$plugindir";
	./vendor/bin/phpcs -q "$plugindir";
else
	./vendor/bin/phpcs -q "$plugindir";
fi