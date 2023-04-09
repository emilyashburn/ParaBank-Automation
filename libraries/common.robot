*** Settings ***
Library         SeleniumLibrary
Library         OperatingSystem
Library         webDriver.py

*** Variables ***
${DEFAULT_TIMEOUT}      15s
${PARABANK_URL}         https://parabank.parasoft.com/parabank/index.htm
${ADMIN_USERNAME}       john
${ADMIN_PASSWORD}       demo

*** Keywords ***
Open Chrome Browser
    # // TODO: [ENA] Upgrade this keyword to use the python "chromedriver-autoinstaller" library. This will
    # // automatically update the ChromeDriver to the current version of your Google Chrome browser.
    [Arguments]     ${url}
    Set Selenium Timeout                ${DEFAULT_TIMEOUT}
    ${chrome_options}=                  create_chrome_options
    ${chromedriverPath}=                Set Variable        ${EXEC_DIR}\\webdrivers\\chromedriver.exe
    Append To Environment Variable      PATH       ${chromedriverPath}
    Open Browser                        url=${url}      browser=chrome      options=${chrome_options}       executable_path=${chromedriverPath}

Login As Admin
    Wait Until Element Is Visible       //h2[.="Customer Login"]
    Input Text                          //*[@name="username"]           ${ADMIN_USERNAME}
    Input Text                          //*[@name="password"]           ${ADMIN_PASSWORD}
    Click Element                       //*[@value="Log In"]
    Wait Until Element Is Visible       //h1[.="Accounts Overview"]

Logout
    Wait Until Element Is Visible       //a[.="Log Out"]
    Click Element                       //a[.="Log Out"]
    Wait Until Element Is Visible       //h2[.="Customer Login"]