.PHONY: install selenium.PID selenium-stop test

install:
	npm install
	node_modules/selenium-standalone/bin/selenium-standalone install --drivers.chrome.version=2.29 --drivers.chrome.baseURL=https://chromedriver.storage.googleapis.com

selenium.PID:
	@node_modules/selenium-standalone/bin/selenium-standalone start 2> /dev/null & echo "$$!" > selenium.PID

selenium-stop:
	@kill `cat selenium.PID` && rm selenium.PID
	@echo "selenium server stopped"

test: selenium.PID
	sleep 5
	npm test
	@make selenium-stop

