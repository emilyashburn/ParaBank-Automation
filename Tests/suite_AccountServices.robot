*** Settings ***
Library             SeleniumLibrary
Resource            ../Resources/Api.robot
Resource            ../Resources/PageObjects/LoginKeywords.robot
Resource            ../Resources/Setups.robot

Suite Setup         Setups.Simple Setup
Suite Teardown      Close All Browsers
# Test Setup          Go To Parabank Login Page
Test Teardown       Logout

*** Variables ***
*** Test Cases ***
TC-PARA-001 Open a New Account from Main Existing Account
    #// This testcase is testing the flow for opening new accounts, provided that we use the permanent account 13344.
    Login As Admin
    ${accountType}=         Set Variable                    SAVINGS
    ${existingAccount}=     Set Variable                    13344
    ${newSavingsAccountId}  ${newSavingsAccountURL}=        Open New Account        ${accountType}      ${existingAccount}      100
    Log To Console          \n\nNew Account ID: ${newSavingsAccountId}
    Log To Console          \nNew Account URL: ${newSavingsAccountURL}

TC-PARA-002 Transfer Funds from One Account To Another Account
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
