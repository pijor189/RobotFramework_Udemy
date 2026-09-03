*** Settings ***
Documentation    All the page object and keywords of landing page
Library          SeleniumLibrary
Library          String
Library          Collections


*** Keywords ***
switch to child window
    Switch Window    NEW
    Element Text Should Be    css:h1    DOCUMENTS REQUEST

grab the email id in the child window
    ${text}=    Get Text    css:p.im-para.red
    @{words}=    Split String    ${text}    at
    Log    ${words}
    ${text_split}=    Get From List    ${words}    1
    @{words2}=    Split String    ${text_split}
    ${email}=    Get From List    ${words2}    0
    Set Global Variable    ${email}

switch to parent window and enter the email
    Switch Window    MAIN
    Title Should Be    LoginPage Practise | Rahul Shetty Academy
    Input Text    id:username    ${email}
