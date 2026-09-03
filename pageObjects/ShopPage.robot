*** Settings ***
Documentation    All the page objects and keywords of shop page
Library          SeleniumLibrary
Library          Collections
Resource         Generic.robot

*** Variables ***
${second_page_message}        css:.btn-primary
${card_items}                 css:.card-title


*** Keywords ***
wait until it checks
    Generic.wait until it checks    ${second_page_message}

verify card titles in the shop page
    @{expectedList}=    Create List    iphone X    Samsung Note 8    Nokia Edge    Blackberry
    ${elements}=    Get WebElements    ${card_items}
    @{actualList}=    Create List
    FOR    ${element}    IN    @{elements}
        Log    ${element.text}
        Append To List    ${actualList}    ${element.text}
    END
    Lists Should Be Equal    ${actualList}    ${expectedList}

select the card
    [Arguments]    ${item}
    ${elements}=    Get WebElements    ${card_items}
    ${index}=    Set Variable    1
    FOR    ${element}    IN    @{elements}
        Exit For Loop If    '${item}' == '${element.text}'
        ${index}=    Evaluate    ${index} + 1
    END
    Click Button    xpath:(//*[@class='card-footer'])[${index}]/button
