*** Settings ***
Documentation    A resource file with reusable keywords and variables
...
...              The system specific keywords created here form our own
...              domain specific language. They utilize keywords provided
...              by the imported SeleniumLibrary.
Library          SeleniumLibrary


*** Variables ***
${url}                  https://rahulshettyacademy.com/loginpagePractise/
${browser}              Chrome

*** Keywords ***
open the browser
    IF    "${browser}" == "Chrome"
        ${options}=    Evaluate    __import__('selenium.webdriver', fromlist=['ChromeOptions']).ChromeOptions()
        Call Method    ${options}    add_argument    --disable-features\=PasswordLeakDetection

        ${prefs}=    Create Dictionary
        ...    credentials_enable_service=${False}
        ...    profile.password_manager_enabled=${False}
        ...    profile.password_manager_leak_detection=${False}

        Call Method    ${options}    add_experimental_option    prefs    ${prefs}

        Create Webdriver    ${browser}    options=${options}
        Go To    ${url}
    ELSE
        Create Webdriver    ${browser}
        Go To    ${url}
    END

close browser session
    Close Browser

wait until it checks
    [Arguments]    ${page_locator}
    Wait Until Element Is Visible    ${page_locator}