*** Settings ***
Resource        ../Resources/Api.robot
Resource        ../Resources/Common.robot
Resource        ../Resources/PageObjects/LoginKeywords.robot

Suite Setup         API Setup
Suite Teardown      Close All Browsers
# Test Setup          Go To Parabank Login Page
Test Teardown       Logout

*** Variables ***

*** Test Cases ***

TC-Api-001 Get Bank Account via API
    #// This testcase is only testing that the Test/Suite Setup runs fine.
    Log To Console          \nHello, world!\n
    #API_Clean Database
    #API_Get Admin Info
    API_Get Bank Account

*** Keywords ***

API Setup
    Launch Browser