*** Settings ***
Documentation    To validate the Login form
Library    SeleniumLibrary
Library    ../customLibraries/Shop.py
Test Setup    open the browser
Test Teardown    close browser session
Resource       ../pageObjects/Generic.robot
Resource       ../pageObjects/LandingPage.robot
Resource       ../pageObjects/ShopPage.robot

*** Variables ***
@{listOfProducts}    Blackberry    Nokia Edge    iphone X

*** Test Cases ***
Validate cards display in the shopping page
    LandingPage.fill the login form    ${user_name}    ${valid_password}
    ShopPage.wait until it checks
    ShopPage.verify card titles in the shop page
    Hello World
    Add Items To Card And Checkout    ${listOfProducts}
