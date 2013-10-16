#!/bin/bash

if [ "$1" = "chrome" ]; then
	echo "testing with ChromeDriver"
	export SELENIUM_HOST="localhost"
	export SELENIUM_PORT=4444
	export SELENIUM_BROWSER="chrome"
	export SELENIUM_PLATFORM="MAC"
	export SELENIUM_VERSION="10.7"
elif [ "$1" = "firefox" ]; then
	echo "testing with FireFoxDriver"
	export SELENIUM_HOST="localhost"
	export SELENIUM_PORT=4445
	export SELENIUM_BROWSER="firefox"
	export SELENIUM_PLATFORM="MAC"
	export SELENIUM_VERSION="10.8"
elif [ "$1" = "android" ]; then
	echo "testing with AndroidDriver"
	export SELENIUM_HOST="192.168.2.2"
	#export SELENIUM_HOST="192.168.11.133"
	export SELENIUM_PORT=8080
	export SELENIUM_BROWSER="android"
	export SELENIUM_PLATFORM="ANDROID"
	export SELENIUM_VERSION="4.2"
else
	echo -e "error: invalid driver-name\nusage\n\t$ ./do-test.sh chrome\n\t$ ./do-test.sh android"
	exit 1
fi

if [ "$SELENIUM_HOST" != "" ]; then
	mocha
fi

exit