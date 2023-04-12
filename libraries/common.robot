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

################# Logins #################

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

############### Navigation ###############

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
    #// There will ALWAYS be one account in the Overview, so wait until that third TR row loads in.
    Wait Until Element Is Visible       //*[@id="accountTable"]//tr[3]//a

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

########### Open New Accounts ############

Open New Account
    #// In order to make a new account, we need to know what type of an account to make.
    #// We also need to pull $100 from an existing account.
    [Arguments]     ${accountType}      ${existingAccount}
    Select Account Type             ${accountType}
    Select Option From Dropdown     //*[@id="fromAccountId"]        ${existingAccount}
    ${newAccountId}=                Get Text                        //*[@id="newAccountId"]
    ${newAccountUrl}=               Get Element Attribute           //*[@id="newAccountId"]@href
    [Return]                        ${newAccountId}     ${newAccountUrl}

Select Account Type
    #// Two valid options: CHECKING or SAVINGS
    [Arguments]     ${accountType}
    Select Option From Dropdown     //*[@id="type"]     ${accountType}

Select Option From Dropdown
    [Arguments]     ${xpath}      ${option}
    Wait and Click                      ${xpath}
    Wait and Click                      ${xpath}//option[contains(.,"${option}")]
    Wait Until Element Is Visible       ${xpath}//option[contains(.,"${option}")][@selected="selected"]

Click Open New Account
    Wait and Click                      //*[@type="submit"]
    Wait Until Element Is Visible       //*[.="Account Opened!"]

############ Accounts Overview ############

Get Existing Account with More Than $100
    Go To Accounts Overview Page
    ${accountCount}=        Get Count of Existing Accounts
    ${col}=     Table_Get Column Index      Available Amount        //*[@id="accountTable"]
    FOR         ${i}      IN RANGE      1       ${accountCount}+1
        Log to Console      \n Account place: ${i}
    END
    Log To Console          \n\n Column index: ${col}!!!!!!!!!!

Get Count of Existing Accounts
    ${accountCount}=        Get Element Count        //*[@id="accountTable"]//tr//a
    [Return]                ${accountCount}

################ Functions ################

Wait and Click
    [Arguments]     ${xpath}
    Wait Until Element Is Visible       ${xpath}
    Click Element                       ${xpath}

Table_Get Column Index
    [Arguments]     ${header}       ${tableId}
    ${headerCount}=     Get Element Count       ${tableId}/thead/tr/th
    ${headerIndex}=     Set Variable            -1
    FOR     ${i}        IN RANGE        1       ${headerCount}+1
        ${currHeader}=      Get Text            ${tableId}/thead/tr/th[${i}]
        ${results}=         Run Keyword And Return Status       Should Be Equal     ${currHeader}       ${header}
        ${headerIndex}=     IF      "${results}"=="True"        Set Variable        ${i}
        IF      "${results}"=="True"        BREAK
    END
    IF      "${headerIndex}"=="-1"          Fail        \n\nThere was no header found with the name ${header} in the table ${tableId}...
    [Return]        ${headerIndex}

Table_Get Row Index