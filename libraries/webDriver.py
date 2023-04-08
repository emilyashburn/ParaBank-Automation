from selenium import webdriver


def create_chrome_options():
    options = webdriver.ChromeOptions()
    options.add_experimental_option("excludeSwitches", ["enable-automation"])
    options.add_experimental_option('prefs', {"credentials_enable_service": False,
                                              'profile': {'password_manager_enabled': False}})
    return options


def open_chrome(path, url):
    # // TODO: [ENA] Upgrade this function to use the python "chromedriver-autoinstaller" library. This will
    # // automatically update the ChromeDriver to the current version of your Google Chrome browser.
    chromeoptions = create_chrome_options()
    driver = webdriver.Chrome(options=chromeoptions, executable_path=path)
    driver.maximize_window()
    driver.get(url)

