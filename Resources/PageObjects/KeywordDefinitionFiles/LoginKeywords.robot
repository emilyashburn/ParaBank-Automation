*** Settings ***
Library         SeleniumLibrary
Variables       ../Locators/LoginPage.py
Variables       ../Locators/Common.py

*** Variables ***
*** Keywords ***

Login to Parabank
    [Arguments]     ${username}     ${password}
    Wait Until Element Is Visible       ${header_loginPageTitle}
    Input Text                          ${txt_loginUserName}           ${username}
    Input Text                          ${txt_loginPassword}           ${password}
    Click Element                       ${btn_login}

Logout
    Wait Until Element Is Visible       ${btn_logout}
    Click Element                       ${btn_logout}
    Wait Until Element Is Visible       ${header_loginPageTitle}

User Should Be Logged In
    Wait Until Element Is Visible       ${header_mainTitle}     error=Unable to Login

User Should Not Be Logged In
    Wait Until Element Is Visible       ${header_loginPageTitle}     error=User is still logged in
