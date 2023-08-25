*** Settings ***
Library         SeleniumLibrary
Resource        ../Resources/PageObjects/LoginKeywords.robot
#Variables       ../Resources/PageObjects/TestData/Logins.py
Resource        ../Resources/Common.robot
Resource        ../Resources/Setups.robot

Suite Setup         Setups.Simple Setup
Suite Teardown      Close All Browsers
# Test Setup
# Test Teardown

*** Variables ***
*** Test Cases ***
TC-Logins-001 Login to Parabank as Admin
    Login to Parabank       ${adminUsername}        ${adminPassword}
    User Should Be Logged In
    Logout
    User Should Not Be Logged In

TC-Logins-002 Login to Parabank with Invalid Credentials
    Login to Parabank       ${invalidUsername}      ${invalidPassword}
    User Should Not Be Logged In
