*** Settings ***
Documentation       Data-driven tests to verify that invalid logins properly fail to verify credentials. Keep in mind,
...                 ParaBank is used by many people every day. This leads to incongruencies that are different everyday.
...                 This also includes this suite in particular.

...                 There is a scenario where all logins are suitable, which is not expected, as long as the input is
...                 non-empty. If tests fail, this is a possible root-cause.

Resource            ../Resources/PageObjects/LoginKeywords.robot
Resource            ../Resources/Common.robot
Resource            ../Resources/Setups.robot

Suite Setup         Setups.Simple Setup
Suite Teardown      Close All Browsers
Test Template       Login with Invalid Credentials Should Fail

*** Variables ***
${VALID_USERNAME}       john
${VALID_PASSWORD}       demo
*** Test Cases ***
#                                   USERNAME            PASSWORD
Invalid User Name                   invalid             ${VALID_PASSWORD}
Invalid Password                    ${VALID_USERNAME}   invalid
Invalid User Name and Password      invalid             invalid
Empty User Name                     ${EMPTY}            ${VALID_PASSWORD}
Empty Password                      ${VALID_USERNAME}   ${EMPTY}
Empty User Name and Password        ${EMPTY}            ${EMPTY}


*** Keywords ***
Login with Invalid Credentials Should Fail
    [Arguments]    ${username}    ${password}
    Login to Parabank    ${username}    ${password}
    User Should Not Be Logged In
