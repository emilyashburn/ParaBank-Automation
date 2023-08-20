*** Settings ***
Library         SeleniumLibrary
*** Variables ***
${header_accountsOverviewPageTitle}     xpath://h1[.='Accounts Overview']
${table_accountTable}                   xpath://*[@id='accountTable']//tr[1]//a

*** Keywords ***
