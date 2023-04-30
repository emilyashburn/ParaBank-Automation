*** Settings ***
Library               RequestsLibrary

*** Keywords ***

API_Clean Database
	Create Session      clean		http://parabank.parasoft.com
    ${response}=        POST Request        clean		/parabank/services/bank/cleanDB
    Log To Console      \n\n\n response!!!! ${response}

API_Get Admin Info
    Create Session      login		http://parabank.parasoft.com
    ${data}=            Evaluate        {"username":"john", "password":"demo"}
    ${response}=        POST Request        login       /login/john/demo        data=${data}
    Log To Console      \n\n\n response!!!! ${response}

API_Get Bank Account
    Create Session      acc		http://parabank.parasoft.com
    ${response}=        POST Request        acc       /parabank/services/bank/accounts/13344
    Log To Console      \n\n\n response!!!! ${response}
