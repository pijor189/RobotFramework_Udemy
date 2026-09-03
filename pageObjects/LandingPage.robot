*** Settings ***
Documentation    All the page object and keywords of landing page
Library          SeleniumLibrary
Resource         Generic.robot


*** Variables ***
${user_name}            rahulshettyacademy
${invalid_password}     0000
${valid_password}       Learning@830$3mK2
${error_message_login}        css:.alert-danger
${error_message_text}         Incorrect username/password.


*** Keywords ***
fill the login form
    [Arguments]           ${username}     ${password}
    Input Text            id:username     ${username}
    Input Password        id:password     ${password}
    Click Button          signInBtn

wait until it checks
    Generic.wait until it checks    ${error_message_login}

verify message is correct
    Element Text Should Be    ${error_message_login}    ${error_message_text}

fill the login form and select the user option
    [Arguments]    ${username}    ${password}
    Input Text    id:username    ${username}
    Input Password      id:password     ${password}
    Click Element    xpath=//*[@id="login-form"]/div[4]/div/label[2]/span[2]
    Wait Until Element Is Visible    xpath=//*[@id="okayBtn"]
    Click Button    xpath=//*[@id="okayBtn"]
    Wait Until Element Is Not Visible    xpath=//*[@id="okayBtn"]
    Select From List By Value    xpath=//*[@id="login-form"]/div[5]/select    teach
    Element Should Contain    xpath=//*[@id="login-form"]/div[5]/select    Teacher
    Select Checkbox    xpath=//*[@id="terms"]
    Checkbox Should Be Selected    xpath=//*[@id="terms"]

select the link of child window
    Wait Until Element Is Visible    xpath=//a[contains(.,'Free Access')]
    Click Element    xpath=//a[contains(.,'Free Access')]
    Sleep    5
