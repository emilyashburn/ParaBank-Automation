*** Settings ***
Library             SeleniumLibrary
Resource            ../Resources/Common.robot
Resource            ../Resources/PageObjects/LoginKeywords.robot
Resource            ../Resources/Setups.robot

Suite Setup         Setups.Simple Setup
Suite Teardown      Close All Browsers
#Test Setup          Go To Parabank Login Page
#Test Teardown       Logout

*** Variables ***
*** Test Cases ***
TC-TEST-001
    #// This testcase is testing the nav keywords
    Login As Admin
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
