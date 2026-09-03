*** Settings ***
Documentation    To validate the Login form
Library    SeleniumLibrary
Library    DataDriver    file=resources/data.csv    encoding=utf_8    dialect=unix
Test Teardown    Close Browser
Test Template    Validate Unsuccessful Login

*** Variables ***
${error_message_login}        css:.alert-danger
${error_message_text}         Incorrect username/password.
${valid_password}             Learning@830$3mK2
${valid_username}             rahulshettyacademy

#*** Test Cases ***    username                password
#Invalid username      asfdsf                  ${valid_password}
#Invalid password      ${valid_username}       safsdgsd
#Special characters    @#!                     ${valid_password}

*** Test Cases ***
# nazwy parametrów do zczytania ich z excela muszą być dokładnie takie same tutaj i w excelu
# można dodać domyślne argumenty gdyby plik został uszkodzony lub nie może go znalezc i wtedy uruchomi się
# z tymi parametrami
# jesli nie podamy nazwy TC to wygeneruje test o nazwie szablona zawartego ponizej
Login with user ${username} and password ${password}    xyz    12321

*** Keywords ***
Validate Unsuccessful Login
    [Arguments]    ${username}    ${password}
    open the browser
    fill the login form    ${username}    ${password}
    wait until it checks and display error message
    verify error message is correct

open the browser
    Create Webdriver    Chrome
    Go To    https://rahulshettyacademy.com/loginpagePractise/

fill the login form
    [Arguments]    ${username}    ${password}
    Input Text    id:username    ${username}
    Input Password      id:password     ${password}
    Click Button    signInBtn

wait until it checks and display error message
    Wait Until Element Is Visible    ${error_message_login}

verify error message is correct
    Element Text Should Be    ${error_message_login}    ${error_message_text}
