*** Settings ***
Documentation          API tests
Library                SeleniumLibrary
Library                Collections
Library                RequestsLibrary


*** Variables ***
${base_url}        http://216.10.245.166


*** Test Cases ***
Play around with dictionary
    &{dict}=    Create Dictionary    name=krzysztof    course=robot    website=rahulshettyacademy.com
    Log    ${dict}
    Dictionary Should Contain Key    ${dict}    name
    Log    ${dict}[name]
    ${url}=    Get From Dictionary    ${dict}    website
    Log    ${url}

Add book into library database
    [Tags]    API
    &{input}=    Create Dictionary
    ...    name=Learn Appium Automation with Java
    ...    isbn=bcd    aisle=227    author=John foe
    Set Global Variable    ${input}
    ${response}=    POST    ${base_url}/Library/Addbook.php    json=${input}    expected_status=200
    Status Should Be    200    ${response}
    Log    ${response.text}
    Log    ${response.json()}
    ${response_json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${response_json}    ID
    ${book_id}=    Get From Dictionary    ${response_json}    ID
    Set Global Variable    ${book_id}
    Log    ${book_id}

Get the book details which got added
    [Tags]    API
    ${get_response}=    GET
    ...    ${base_url}/Library/GetBook.php    params=ID=${book_id}    expected_status=200
    Log    ${get_response.json()}
    ${book_name}=    Get From Dictionary    ${get_response.json()}[0]    book_name
    Should Be Equal As Strings    ${book_name}    Learn Appium Automation with Java

Delete the book from database
    [Tags]    API
    &{dict}=    Create Dictionary    ID=${book_id}
    ${response}=    POST    ${base_url}/Library/DeleteBook.php    json=${dict}    expected_status=200
    Status Should Be    200    ${response}
    Log    ${response.json()}
    Dictionary Should Contain Key    ${response.json()}    msg
    Should Be Equal As Strings    ${response.json()}[msg]    book is successfully deleted
