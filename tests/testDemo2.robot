*** Settings ***
Documentation    To validate the Login form
Library    SeleniumLibrary
Test Setup    open the browser
Test Teardown    close browser session
Resource       ../pageObjects/Generic.robot
Resource       ../pageObjects/LandingPage.robot
Resource       ../pageObjects/ShopPage.robot
Resource       ../pageObjects/ChildPage.robot


*** Test Cases ***
Validate unsuccessful login
    LandingPage.fill the login form    ${user_name}      ${invalid_password}
    LandingPage.wait until it checks
    LandingPage.verify message is correct

Validate cards display in the shopping page
    LandingPage.fill the login form    ${user_name}    ${valid_password}
    ShopPage.wait until it checks
    ShopPage.verify card titles in the shop page
    ShopPage.select the card        Blackberry

Select the form and navigate to child window
    LandingPage.fill the login form and select the user option    ${user_name}    ${valid_password}

Validate child window functionality
    LandingPage.select the link of child window
    ChildPage.switch to child window
    ChildPage.grab the email id in the child window
    ChildPage.switch to parent window and enter the email
