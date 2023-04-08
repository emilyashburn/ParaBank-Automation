*** Settings ***
Library             SeleniumLibrary
Resource            ${EXEC_DIR}/libraries/common.robot

Suite Setup         TRAN Setup
#Suite Teardown      Close Browser

#Test Setup          Go To Parabank Login Page
#Test Teardown       Logout


*** Variables ***
${FILE_PATH}        ${EXEC_DIR}\\suites

*** Test Cases ***
TC-TRAN-001 Hello, World!
    Log To Console          \n\n Hello, world!
    log to console          \n\n learning PyCharm GIT

*** Keywords ***
TRAN Setup
    Open Chrome Browser        ${PARABANK_URL}
