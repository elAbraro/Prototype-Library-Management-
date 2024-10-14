*** Settings ***
Documentation   Testing Add Student and View Students
Library    SeleniumLibrary

*** Variables ***
${SERVER}    http://127.0.0.1:8000
${BROWSER}   Chrome
${USERNAME}  user
${PASSWORD}  1234

*** Keywords ***
Login as Staff
    Open Browser    ${SERVER}/stafflogin/    ${BROWSER}
    Wait Until Page Contains Element    id=loginuname    timeout=15s
    Input Text      id=loginuname    ${USERNAME}
    Input Text      id=loginpassword    ${PASSWORD}
    Click Button    xpath=//input[@type='submit']
    Wait Until Page Contains Element    class=sidebar    timeout=15s
    ${error_message}=    Run Keyword And Return Status    Wait Until Page Contains    Error    timeout=5s
    Should Not Be True    ${error_message}    The login failed. Check the username and password.

Go to Add Student Page
    Go To    ${SERVER}/addstudent/

Go to View Students Page
    Go To    ${SERVER}/viewstudents/

Submit Student Form
    Input Text    id=sname    Mr Invincible
    Input Text    id=studentid    ST12345
    Click Button    xpath=//button[@type='submit']
    Wait Until Page Contains    Student added successfully    timeout=30s

Verify Student in List
    Wait Until Page Contains    Mr Invincible    timeout=30s

*** Test Cases ***
Test Add Student :: Add a new student after logging in
    Login as Staff
    Go to Add Student Page
    Submit Student Form
    Log    ${browser}.document.body.innerHTML   
    Wait Until Page Contains    Student added successfully    timeout=30s

Test View Students :: View added student in the student list
    Login as Staff
    Go to View Students Page
    Verify Student in List
