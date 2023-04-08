*** Settings ***
Library         ${EXECDIR}/libraries/webDriver.py

*** Variables ***
*** Keywords ***
Open Chrome Browser
    [Arguments]     ${url}
    ${chrome_options}=      create_chrome_options
    Create Webdriver        Chrome      chrome_options=${chrome_options}
    Go to                   ${url}

