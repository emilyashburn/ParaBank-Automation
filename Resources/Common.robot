*** Settings ***
Library         SeleniumLibrary
Library         OperatingSystem
Library         String
Library         Webdrivers.py
Resource        ../Resources/PageObjects/AccountServices_AboutUsPage.robot
Resource        ../Resources/PageObjects/AccountServices_AccountsOverviewPage.robot
Resource        ../Resources/PageObjects/AccountServices_BillPayPage.robot
Resource        ../Resources/PageObjects/AccountServices_FindTransactionsPage.robot
Resource        ../Resources/PageObjects/AccountServices_OpenNewAccountPage.robot
Resource        ../Resources/PageObjects/AccountServices_RequestLoanPage.robot
Resource        ../Resources/PageObjects/AccountServices_TransferFundsPage.robot
Resource        ../Resources/PageObjects/AccountServices_UpdateContactInfoPage.robot


*** Variables ***
${DEFAULT_TIMEOUT}      15s
${browserType}          chrome
${env}                  https://parabank.parasoft.com/parabank/index.htm

*** Keywords ***

Launch Browser
    [Documentation]    This keyword installs the latest webdriver chosen (Chrome or Firefox | defaulted to Chrome) and
    ...     opens the browser with the chosen ENV (or URL), sets the default Selenium Timeout, and maximizes the
    ...     browser.
    # Make the cmd line argument all lowercase (to avoid minor fails)
    ${browserType}=     Convert To Lower Case        ${browserType}

    # Install the appropriate webdriver for current browser version
    install_webdriver       ${browserType}

    # Launch browser for provided browserType (valid args: chrome, firefox. IE and Edge are not working properly.)
    IF          "${browserType}" == "chrome"
        ${chrome_options}=      create_chrome_options
        ${driverPath}=          Set Variable        ${EXEC_DIR}${/}Webdrivers${/}chromedriver.exe
        Append To Environment Variable    PATH      ${driverPath}
        Open Browser    url=${env}  browser=${browserType}  options=${chrome_options}   executable_path=${driverPath}
    ELSE IF     "${browserType}" == "firefox"
    # TODO: add firefox options
        ${driverPath}=          Set Variable        ${EXEC_DIR}${/}Webdrivers${/}geckodriver.exe
        Append To Environment Variable      PATH       ${driverPath}
        Open Browser    url=${env}  browser=${browserType}  executable_path=${driverPath}
    END

    Set Selenium Timeout                ${DEFAULT_TIMEOUT}
    Maximize Browser Window

############### Navigation ###############

Go To Page
    [Arguments]     ${option}
    #// Bottom Left Nav Menu
    IF                      "${option}"=="Open New Account"        Go To Open New Account Page
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
    Wait Until Element Is Visible       ${header_openNewAccountTitle}

Go To Accounts Overview Page
    Click Element                       //a[.="Accounts Overview"]
    Wait Until Element Is Visible       ${header_accountsOverviewPageTitle}
    #// There will ALWAYS be one account in the Overview, so wait until that first TR row with a value in the Account column loads in.
    Wait Until Element Is Visible       ${table_accountTable}

Go To Transfer Funds Page
    Click Element                       //a[.="Transfer Funds"]
    Wait Until Element Is Visible       ${header_transferFundsPageTitle}

Go To Bill Pay Page
    Click Element                       //a[.="Bill Pay"]
    Wait Until Element Is Visible       ${header_billPayPageTitle}

Go To Find Transactions Page
    Click Element                       //a[.="Find Transactions"]
    Wait Until Element Is Visible       ${header_findTransactionsPageTitle}

Go To Update Contact Info Page
    Click Element                       //a[.="Update Contact Info"]
    Wait Until Element Is Visible       ${header_updateContactInfoPageTitle}

Go To Request Loan Page
    Click Element                       //a[.="Request Loan"]
    Wait Until Element Is Visible       ${header_requestLoanPageTitle}

Go To About Us Page
    Click Element                       //*[@class="leftmenu"]//a[.="About Us"]
    Wait Until Element Is Visible       ${header_aboutUsPageTitle}

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
    #// In order to make a new account, we need to know the source account has the appropriate funds.Login As Admin
    #// We also need to know what type of an account to make.
    [Arguments]     ${accountType}      ${sourceAccount}        ${minAmount}
    ${minAmount}=                       Get Min Amount to Open New Account
    Verify Account Has More Than        ${minAmount}      ${sourceAccount}
    Go To Page                          Open New Account
    Select Account Type                 ${accountType}
    Select Option From Dropdown         //*[@id="fromAccountId"]        ${sourceAccount}
    Click Open New Account
    ${newAccountId}=                    Get Text                        //*[@id="newAccountId"]
    ${newAccountUrl}=                   Get Element Attribute           //*[@id="newAccountId"]     attribute=href
    [Return]                            ${newAccountId}     ${newAccountUrl}

Get Min Amount to Open New Account
    #// From Issue #8, bank account min to open new account has increased from $100 to $1000.
    #// This keyword fixes that change.
    Go To Page          Open New Account
    ${minAmount}=       Get Text        //*[.="Open New Account"]//following-sibling::form//p[contains(.,"$")]
    ${minAmount}=       Fetch From Right        ${minAmount}        $
    ${minAmount}=       Fetch From Left         ${minAmount}        ${SPACE}
    Remove , From Amount        ${minAmount}
    [Return]        ${minAmount}

Select Account Type
    #// Two valid options: CHECKING or SAVINGS
    [Arguments]     ${accountType}
    #// Wanted to verify the option's attribute selected="selected", but that does not work on the Open New Account page
    Select Option From Dropdown     //*[@id="type"]     ${accountType}

Click Open New Account
    Wait and Click                      //*[@type="submit"]
    Wait Until Element Is Visible       //*[.="Account Opened!"]

############ Accounts Overview ############

Verify Account Has More Than
    #// Find the existing account provided and ensure it has a balance of more than ${amount}
    [Arguments]     ${amount}       ${accountNumber}
    Go To Page      Accounts Overview
    #// Find account in table and get current Available Balance
    ${col}=         Table_Get Column Index      Available Amount        //*[@id="accountTable"]
    ${row}=         Table_Get Row Index         ${accountNumber}        Account         //*[@id="accountTable"]
    ${availableBalance}=        Get Text        //*[@id="accountTable"]//tbody/tr[${row}]/td[${col}]
    ${availableBalance}=        Remove $ From Amount        ${availableBalance}
    ${amount}=      Remove , From Amount        ${amount}
    IF  ${availableBalance} < ${amount}
        Fail        Account ${accountNumber} does NOT have more than ${amount}...
    END

Get Count of Existing Accounts
    ${accountCount}=        Get Element Count        //*[@id="accountTable"]//tr//a
    [Return]                ${accountCount}

######## Transfer Funds #############

Transfer Funds From
    [Arguments]     ${sourceAccount}        ${amount}       ${destinationAccount}
    Verify Account Has More Than        ${amount}       ${sourceAccount}
    Go To Page      Transfer Funds
    #// Choose source account
    Select Option From Dropdown         //*[@id="fromAccountId"]        ${sourceAccount}
    #// Choose destination account
    Select Option From Dropdown         //*[@id="toAccountId"]        ${destinationAccount}
    Input Amount        ${amount}
    Click Transfer Button
    #// Verify transfer completed successfully
    Verify Successful Transfer      ${amount}       ${sourceAccount}        ${destinationAccount}

Click Transfer Button
    Click Element       //*[@value="Transfer"]
    Wait Until Element Is Visible       //*[.="Transfer Complete!"]

Input Amount
    [Arguments]     ${amount}
    ${xpath}=       Set Variable        //*[@id="amount"]
    Input Text      ${xpath}            ${amount}

Verify Successful Transfer
    [Arguments]     ${amount}       ${sourceAccount}        ${destinationAccount}
    Wait Until Element Is Visible       //p[contains(.,"${amount} has been transferred from account #${sourceAccount} to account #${destinationAccount}")]

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
    #// The only table Parabank has is for the Accounts Overview page.
    [Arguments]     ${text}     ${columnHeader}     ${tableId}
    Wait Until Element Is Visible       ${tableId}//tr[1]//a
    ${rowCount}=        Get Element Count           ${tableId}//tbody/tr[not(contains(.,"Total"))]      #// Counts num of rows and excludes final row for "Total"
    ${colIndex}=        Table_Get Column Index      ${columnHeader}     ${tableId}
    ${rowIndex}=        Set Variable            -1
    FOR     ${i}            IN RANGE            1       ${rowCount}+1
        ${cellText}=        Get Text       ${tableId}//tbody/tr[${i}][not(contains(.,"Total"))]/td[${colIndex}]/a
        ${results}=         Run Keyword and Return Status       Should Be Equal         ${cellText}     ${text}
        ${rowIndex}=        IF      "${results}"=="True"        Set Variable        ${i}
        Run Keyword If      "${results}"=="True"                Exit For Loop
    END
    IF      "${rowIndex}"=="-1"          Fail        \n\nThere was no row found containing the text ${text} in the table ${tableId}...
    [Return]        ${rowIndex}

Select Option From Dropdown
    [Arguments]     ${xpath}      ${option}
    Wait and Click                      ${xpath}
    Wait and Click                      ${xpath}//option[contains(.,"${option}")]

Remove $ From Amount
    [Arguments]     ${amount}
    ${amount}=      Fetch From Right        ${amount}       $
    [Return]        ${amount}

Remove , From Amount
    [Arguments]     ${amount}
    ${amount}=      Replace String      ${amount}       ,       ${EMPTY}
    [Return]        ${amount}