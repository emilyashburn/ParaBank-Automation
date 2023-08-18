from selenium import webdriver
import subprocess       # to run a shell script that copies the new webdriver to a specified location
import urllib3          # to disable the InsecureRequestWarning for Parabank's website


def install_webdriver(browser):
    urllib3.disable_warnings()      # Disabled InsecureRequestWarning for Parabank. This helps clean up the console.
    if browser == "chrome":
        install_latest_chromedriver()
    elif browser == "firefox":
        install_latest_geckodriver()


def install_latest_chromedriver():
    subprocess.call('webdrivermanager chrome:latest --linkpath ./Webdrivers', shell=True)


def install_latest_geckodriver():
    subprocess.call('webdrivermanager firefox:latest --linkpath ./Webdrivers', shell=True)


def create_chrome_options():
    options = webdriver.ChromeOptions()
    # Removes 'Chrome is being controlled by automated software' infobar within Chrome
    options.add_experimental_option("excludeSwitches", ["enable-automation"])
    # Leaves Selenium webpage open after Python completes this script
    options.add_experimental_option('detach', True)
    # Avoids 'Do you want chrome to save your password?' pop up within Chrome
    options.add_experimental_option('prefs', {"credentials_enable_service": False,
                                              'profile': {'password_manager_enabled': False}})
    return options
