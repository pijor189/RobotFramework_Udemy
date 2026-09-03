*** Settings ***
Documentation    To validate the Login form
Library    SeleniumLibrary
Test Teardown    Close Browser

*** Variables ***
${error_message_login}    css:.alert-danger
${error_message_text}    Incorrect username/password.

*** Test Cases ***
Validate Unsuccessful Login
    open the browser
    fill the login form
    wait until it checks and display error message
    verify error message is correct

*** Keywords ***
open the browser
    Create Webdriver    Chrome
    Go To    https://rahulshettyacademy.com/loginpagePractise/

fill the login form
    Input Text    id:username    rahulshettyacademy
    Input Password      id:password     0000
    Click Button    signInBtn

wait until it checks and display error message
    Wait Until Element Is Visible    ${error_message_login}

verify error message is correct
#    ${result}=    Get Text    ${error_message_login}
#    Should Be Equal As Strings    ${result}    ${error_message_text}
    Element Text Should Be    ${error_message_login}    ${error_message_text}
