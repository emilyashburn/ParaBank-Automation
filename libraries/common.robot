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
    Maximize Browser Window

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

Go To Page
    [Arguments]     ${option}
    #// Bottom Left Nav Menu
    IF                      "${option}"=="Open New Accounts"        Go To Open New Account Page
    ...     ELSE IF         "${option}"=="Accounts Overview"        Go To Accounts Overview Page
    ...     ELSE IF         "${option}"=="Transfer Funds"           Go To Transfer Funds Page
    ...     ELSE IF         "${option}"=="Bill Pay"                 Go To Bill Pay Page
    ...     ELSE IF         "${option}"=="Find Transactions"        Go To Find Transactions Page
    ...     ELSE IF         "${option}"=="Update Contact Info"      Go To Update Contact Info Page
    ...     ELSE IF         "${option}"=="Request Loan"             Go To Request Loan Page
    #// Top Left Nav Menu
    ...     ELSE IF         "${option}"=="About Us"                 Go To About Us Page
    ...     ELSE IF         "${option}"=="Services"                 Go To Services Page
    ...     ELSE IF         "${option}"=="Products"                 Go To Products Page
    ...     ELSE IF         "${option}"=="Locations"                Go To Locations Page
    ...     ELSE IF         "${option}"=="Admin Page"               Go To Admin Page

Go To Open New Account Page
    Click Element                       //a[.="Open New Account"]
    Wait Until Element Is Visible       //h1[.="Open New Account"]

Go To Accounts Overview Page
    Click Element                       //a[.="Accounts Overview"]
    Wait Until Element Is Visible       //h1[.="Accounts Overview"]

Go To Transfer Funds Page
    Click Element                       //a[.="Transfer Funds"]
    Wait Until Element Is Visible       //h1[.="Transfer Funds"]

Go To Bill Pay Page
    Click Element                       //a[.="Bill Pay"]
    Wait Until Element Is Visible       //h1[.="Bill Payment Service"]

Go To Find Transactions Page
    Click Element                       //a[.="Find Transactions"]
    Wait Until Element Is Visible       //h1[.="Find Transactions"]

Go To Update Contact Info Page
    Click Element                       //a[.="Update Contact Info"]
    Wait Until Element Is Visible       //h1[.="Update Profile"]

Go To Request Loan Page
    Click Element                       //a[.="Request Loan"]
    Wait Until Element Is Visible       //h1[contains(.,"Apply for a Loan")]

Go To About Us Page
    Click Element                       //*[@class="leftmenu"]//a[.="About Us"]
    Wait Until Element Is Visible       //h1[.="ParaSoft Demo Website"]

Go To Services Page
    Click Element                       //*[@class="leftmenu"]//a[.="Services"]
    Wait Until Element Is Visible       //*[.="Available Bookstore SOAP services:"]

Go To Products Page
    Click Element                       //*[@class="leftmenu"]//a[.="Products"]
    Wait Until Element Is Visible       //a[@title="Contact Us"][.="Contact Us"]

Go To Locations Page
    Click Element                       //*[@class="leftmenu"]//a[.="Locations"]
    Wait Until Element Is Visible       //a[.="Try Parasoft"]

Go To Admin Page
    Click Element                      //*[@class="leftmenu"]//a[.="Admin Page"]
    Wait Until Element Is Visible       //h1[contains(.,"Administration")]