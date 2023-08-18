*** Settings ***
Library             SeleniumLibrary
Resource            ../libraries/common.robot

Suite Setup         TEST Setup
Suite Teardown      Close All Browsers

#Test Setup          Go To Parabank Login Page
#Test Teardown       Logout


*** Variables ***

*** Test Cases ***

TC-TEST-001
    #// This testcase is testing the nav keywords
    Go To Page      Open New Account
    Go To Page      Accounts Overview
    Go To Page      Transfer Funds
    Go To Page      Bill Pay
    Go To Page      Find Transactions
    Go To Page      Update Contact Info
    Go To Page      Request Loan
    Go To Page      About Us
    Go To Page      Services
    Go To Page      Products
    Go Back
    Go To Page      Locations
    Go Back
    Go To Page      Admin Page

*** Keywords ***
TEST Setup
    Open Chrome Browser        ${PARABANK_URL}
