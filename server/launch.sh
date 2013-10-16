#!/bin/bash
#
# [usage]
#	$ launch.sh chrome
#	$ launch.sh firefox
#
# [doc]
#
# selenium-server-standalone-2.*:
#	https://code.google.com/p/selenium/wiki/RemoteWebDriverServer
#
# Chrome Driver:
#	https://code.google.com/p/selenium/wiki/ChromeDriver

absoluteDir=$(cd $(dirname $0) && pwd)
jarPath="$absoluteDir/bin/selenium-server-standalone-2.35.0.jar"

if [ "$1" = "firefox" ]; then

# FireFoxDriver
java -jar "$jarPath"\
	-port 4445\
	-timeout=20\
	-browserTimeout=60

else

# ChromeDriver: default port = 4444
java -jar "$jarPath"\
	-timeout=20\
	-browserTimeout=60\
	-Dwebdriver.chrome.driver="$absoluteDir/bin/chromedriver"

fi