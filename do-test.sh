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
elif [ "$1" = "saucelabs" ]; then
	echo "testing with iPhoneEmulator on SauceLabs"
	export SELENIUM_HOST="ondemand.saucelabs.com"
	export SELENIUM_PORT=80
	export SELENIUM_BROWSER="iphone"
	export SELENIUM_PLATFORM="Mac 10.8"
	export SELENIUM_VERSION="6.0"
	# SAUCE_USER_NAME/SAUCE_API_KEYは必要に応じて修正してください
	export SAUCE_USER_NAME="kuronekomichael"
	export SAUCE_API_KEY="i4otkjf3-389r-8373-flk2-t8ioejkakgja"
else
	echo -e "error: invalid driver-name\nusage\n\t$ ./do-test.sh chrome\n\t$ ./do-test.sh android"
	exit 1
fi

if [ "$SELENIUM_HOST" != "" ]; then
	mocha
fi

exit