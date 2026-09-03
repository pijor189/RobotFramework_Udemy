*** Settings ***
Documentation    A resource file with reusable keywords and variables
...
...              The system specific keywords created here form our own
...              domain specific language. They utilize keywords provided
...              by the imported SeleniumLibrary.
Library          SeleniumLibrary


*** Variables ***
${url}                  https://rahulshettyacademy.com/loginpagePractise/


*** Keywords ***
open the browser
    Create Webdriver    Chrome
    Go To    ${url}

close browser session
    Close Browser

wait until it checks
    [Arguments]    ${page_locator}
    Wait Until Element Is Visible    ${page_locator}
