from selenium import webdriver

def create_chrome_options():
    options = webdriver.ChromeOptions()
    options.add_experimental_option("excludeSwitches", ["enable-automation"])
    options.add_experimental_option('prefs', {"credentials_enable_service": False,
                                              'profile': {'password_manager_enabled': False}})
    return options
