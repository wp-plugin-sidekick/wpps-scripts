# WPPS Scripts.

Add phpunit, eslint, and stylelint using WordPress Coding Standards to any WordPress plugin by setting up your package.json file like this:

## Your package.json file in your plugin.
```
{
	"name": "your-plugin-name",
	"version": "1.0.0",
	"license": "GPL-2.0",
	"repository": {
		"type": "git",
		"url": "your-repo-url-here"
	},
	"wpps_options": "-p your-plugin-directory-name -n YourPluginNamespace -t your-plugin-textdomain",
	"scripts": {
		"preinstall": "if [ ! -d ../../wpps-scripts ]; then git clone https://github.com/wp-plugin-sidekick/wpps-scripts ../../wpps-scripts; fi;",
		"dev": "cd ../../wpps-scripts; sh dev.sh $npm_package_wpps_options",
		"build": "cd ../../wpps-scripts; sh build.sh $npm_package_wpps_options",
		"test:phpunit": "cd ../../wpps-scripts; sh phpunit.sh $npm_package_wpps_options;",
		"lint:php": "cd ../../wpps-scripts; sh phpcs.sh $npm_package_wpps_options;",
		"lint:php:fix": "cd ../../wpps-scripts; sh phpcs.sh $npm_package_wpps_options -f 1;",
		"lint:js": "cd ../../wpps-scripts; sh lint-js.sh $npm_package_wpps_options",
		"lint:js:fix": "cd ../../wpps-scripts; sh lint-js.sh $npm_package_wpps_options -f 1;",
		"lint:css": "cd ../../wpps-scripts; sh lint-css.sh $npm_package_wpps_options;",
		"lint:css:fix": "cd ../../wpps-scripts; sh lint-css.sh $npm_package_wpps_options -f 1;",
		"test:js": "cd ../../wpps-scripts; sh test-js.sh $npm_package_wpps_options;",
		"zip": "cd ../../wpps-scripts; sh zip.sh $npm_package_wpps_options"
	}
}

```

In the example package.json file above, simply replace these strings:

- `your-plugin-name` - A slug for your plugin
- `your-plugin-directory-name` - The name of your plugins directory (Used to tell wpps-scripts which plugin to lint/test)
- `YourPluginNamespace` - The unique namespace used for your plugin (Will be enforced as function/class prefix in WordPress Coding Standards)
- `your-plugin-textdomain` - The text domain to use for your plugin (Will be enforced by WordPress Coding Standards)

Then inside your plugin, run `npm run install`. This will clone this repo inside your local wp-content directory, and make the commands like `npm run lint:php` work on the command line when inside the plugin's directory.