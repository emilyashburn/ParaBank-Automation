*** Settings ***
Library             SeleniumLibrary
Resource            ${EXECDIR}/libraries/common.robot

Suite Setup         TRAN Setup
#Suite Teardown      Close Browser

#Test Setup          Go To Parabank Login Page
#Test Teardown       Logout


*** Variables ***
${FILE_PATH}        ${EXECDIR}\\suites

*** Test Cases ***
TC-TRAN-001 Login To Parabank
    Log To Console          \n\n Hello, world!
    #${url}=     Set Variable        https://parabank.parasoft.com/parabank/index.htm
    #Go To       ${url}

*** Keywords ***
TRAN Setup
    Open Chrome Browser        https://parabank.parasoft.com/parabank/index.htm
