*** Settings ***
Library             SeleniumLibrary
Resource            ../libraries/common.robot

Suite Setup         PARA Setup
Suite Teardown      Close All Browsers

# Test Setup          Go To Parabank Login Page
# Test Teardown       Logout

*** Variables ***

*** Test Cases ***
TC-PARA-001 Hello, World!
    #// This testcase is only testing that the Test/Suite Setup runs fine.
    Log To Console          \nHello, world!\n

TC-PARA-002 Login and Logout of ParaBank
    #// This testcase is testing the login and logout features.
    Login As Admin
    Log To Console      \nLogged in successfully!\n
    Logout
    log to console      \nLogged out successfully.\n

TC-PARA-003 Open a New Account from Main Existing Account
    #// This testcase is testing the flow for opening new accounts, provided that we use the permanent account 13344.
    Login As Admin
    ${accountType}=         Set Variable            SAVINGS
    ${existingAccount}=     Set Variable            13344
    Verify Existing Account Has More Than $100      ${existingAccount}     #// 13344 is always the value of the main account
    Go To Page              Open New Account
    ${newSavingsAccountId}         ${newSavingsAccountURL}=       Open New Account        ${accountType}      ${existingAccount}
    Log To Console          \n\nNew Account ID: ${newSavingsAccountId}
    Log To Console          \n\nNew Account URL: ${newSavingsAccountURL}
    Go To                    ${newSavingsAccountURL}

*** Keywords ***
PARA Setup
    Open Chrome Browser        ${PARABANK_URL}