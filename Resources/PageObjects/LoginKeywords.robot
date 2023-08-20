*** Settings ***
Library         SeleniumLibrary
Variables       TestData/Logins.py

*** Variables ***
${txt_loginUserName}        name:username
${txt_loginPassword}        name:password
${btn_login}                xpath://input[@type='submit']
${header_loginPageTitle}    xpath://h2[.='Customer Login']
${header_loginError}        xpath=//h1[contains(.,'Error')]
${btn_logout}               xpath://a[.='Log Out']
${header_mainTitle}         xpath://h2[.='Account Services']


*** Keywords ***

Login As Admin
    Wait Until Element Is Visible       ${header_loginPageTitle}
    Input Text                          ${txt_loginUserName}           ${adminUsername}
    Input Text                          ${txt_loginPassword}           ${adminPassword}
    Click Element                       ${btn_login}

Login to Parabank
    [Arguments]     ${username}     ${password}
    Wait Until Element Is Visible       ${header_loginPageTitle}
    Input Text                          ${txt_loginUserName}           ${username}
    Input Text                          ${txt_loginPassword}           ${password}
    Click Element                       ${btn_login}

Logout
    Run Keyword and Ignore Error        Wait Until Element Is Visible       ${btn_logout}
    Run Keyword and Ignore Error        Click Element                       ${btn_logout}
    Wait Until Element Is Visible       ${header_loginPageTitle}

User Should Be Logged In
    Wait Until Element Is Visible       ${header_mainTitle}     error=Unable to Login

User Should Not Be Logged In
    Wait Until Element Is Visible       ${header_loginPageTitle}     error=User is still logged in
