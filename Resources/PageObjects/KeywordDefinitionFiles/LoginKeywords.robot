*** Settings ***
Library         SeleniumLibrary
Variables       ../TestData/Logins.py
Variables       ../Locators/LoginPage.py

*** Variables ***
*** Keywords ***

Login As Admin
    Wait Until Element Is Visible       //h2[.="Customer Login"]
    Input Text                          ${txt_loginUserName}           ${adminUsername}
    Input Text                          ${txt_loginPassword}           ${adminPassword}
    Click Element                       ${btn_login}
    Wait Until Element Is Visible       //h1[.="Accounts Overview"]     error=Login failed... Server may not be responding

Logout
    Wait Until Element Is Visible       ${btn_logout}
    Click Element                       ${btn_logout}
    Wait Until Element Is Visible       //h2[.="Customer Login"]
