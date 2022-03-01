while getopts 'p:n:t:f:' flag; do
	case "${flag}" in
		j) jobname=${OPTARG} ;;
		p) plugindirname=${OPTARG} ;;
		n) namespace=${OPTARG} ;;
		t) textdomain=${OPTARG} ;;
		f) fix=${OPTARG} ;;
	esac
done

if [ "$jobname" = "phpunit" ]; then
	cd ../wp-plugin-sidekick/wp-modules/linter; sh phpunit.sh -p $plugindirname;
fi

if [ "$jobname" = "lintphp" ]; then
	cd ../wp-plugin-sidekick/wp-modules/linter; sh phpcs.sh -p $plugindirname -n $namespace -t $textdomain;
fi
