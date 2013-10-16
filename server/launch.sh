#!/bin/bash

# //TODO:
# [usage]
#	$ launch.sh chrome
#	$ launch.sh firefox
#	$ launch.sh opera
#	$ launch.sh safari

# FireFox Driverは最初から組み込まれているんだっけ？

# android driver
# ios-driver
# はまた別物

# IEDriverはWindows PCから実行する必要があるので、まだ手出ししない
# (できればSauceLabsやBrowserSwarm等を使いたいところ)

# SauceLabs    月額12$
# BrowserSwarm
# BrowserStack
# TestingBot

# java -jar bin/selenium-server-standalone-2.35.0.jar
absoluteDir=$(cd $(dirname $0) && pwd)

#java -jar selenium-server-standalone-2.30.0.jar -timeout=20 -browserTimeout=60 -Dwebdriver.chrome.driver=/Users/hardwarehacking/Build/work/webdriver/server/chromedriver

java -jar "$absoluteDir/bin/selenium-server-standalone-2.35.0.jar"\
	-timeout=20\
	-browserTimeout=60\
	-Dwebdriver.chrome.driver="$absoluteDir/bin/chromedriver"

#	-Dwebdriver.chrome.arg="--user-agent=TEST1"\

# [doc]
#
# selenium-server-standalone-2.*:
#	https://code.google.com/p/selenium/wiki/RemoteWebDriverServer
#
# Chrome Driver:
#	https://code.google.com/p/selenium/wiki/ChromeDriver
#	//TODO: あれ、chromedriverにオプション渡すにはどうしたらいいんだっけ・・・？