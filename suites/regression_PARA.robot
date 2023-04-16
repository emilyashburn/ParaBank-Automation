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

TC-PARA-003
    #// This testcase is testing the flow for opening new accounts.
    Login As Admin

    ${accountType}=         Set Variable        SAVINGS
    ${existingAccount}=     Get Existing Account with More Than $100
    Go To Page      Open New Account
    #Open New Account        ${accountType}      ${existingAccount}


*** Keywords ***
PARA Setup
    Open Chrome Browser        ${PARABANK_URL}