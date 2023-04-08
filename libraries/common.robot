*** Settings ***
Library         SeleniumLibrary
Library         ${EXEC_DIR}/libraries/webDriver.py

*** Variables ***
${DEFAULT_TIMEOUT}      15s
${PARABANK_URL}         https://parabank.parasoft.com/parabank/index.htm

*** Keywords ***
Open Chrome Browser
    [Arguments]     ${url}
    Set Selenium Timeout        ${DEFAULT_TIMEOUT}
    ${chrome_options}=          create_chrome_options
    ${chromedriverPath}=        Set Variable        ${EXEC_DIR}/webdrivers/chromedriver.exe
    open_chrome                 ${chromedriverPath}     ${url}