*** Settings ***
Library             SeleniumLibrary
Resource            ../Resources/Common.robot
Resource            ../Resources/Api.robot
Resource            ../Resources/PageObjects/KeywordDefinitionFiles/LoginKeywords.robot

Suite Setup         PARA Setup
Suite Teardown      Close All Browsers

# Test Setup          Go To Parabank Login Page
# Test Teardown       Logout

*** Variables ***

*** Test Cases ***
TC-PARA-001 Hello, World!
    #// This testcase is only testing that the Test/Suite Setup runs fine.
    Log To Console          \nHello, world!\n
    #API_Clean Database
    #API_Get Admin Info
    API_Get Bank Account

TC-PARA-002 Login and Logout of ParaBank
    #// This testcase is testing the login and logout features.
    Login As Admin
    Log To Console      \nLogged in successfully!\n
    Logout
    log to console      \nLogged out successfully.\n

TC-PARA-003 Open a New Account from Main Existing Account
    #// This testcase is testing the flow for opening new accounts, provided that we use the permanent account 13344.
    Login As Admin
    ${accountType}=         Set Variable                    SAVINGS
    ${existingAccount}=     Set Variable                    13344
    ${newSavingsAccountId}  ${newSavingsAccountURL}=        Open New Account        ${accountType}      ${existingAccount}
    Log To Console          \n\nNew Account ID: ${newSavingsAccountId}
    Log To Console          \nNew Account URL: ${newSavingsAccountURL}

TC-PARA-004 Transfer Funds from One Account To Another Account
    #// This testcase is testing the flow for transfering funds from a specifed account to another account.
    ${amount}=              Set Variable        10.00
    ${sourceAccountId}=     Set Variable        13344
    Login As Admin

    #//Step 1:  Create a second bank account (destination account)
    ${accountType}=         Set Variable                    SAVINGS
    ${minAmount}=           Get Min Amount to Open New Account
    ${newSavingsAccountId}  ${newSavingsAccountURL}=        Open New Account        ${accountType}      ${sourceAccountId}      ${minAmount}

    #//Step 2:  Attempt to make the transfer of funds and verify successful transfer
    Transfer Funds From     ${sourceAccountId}        ${amount}     ${newSavingsAccountId}

*** Keywords ***
PARA Setup
    Launch Browser
    #Open Chrome Browser        ${PARABANK_URL}
    #install_latest_chromedriver