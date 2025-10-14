*** Settings ***
Resource    ../Resources/Payment_Keywords.robot
Resource    ../Resources/Webhook_Keywords.robot
Resource    ../config/testdata.robot

*** Test Cases ***
End-to-End Payment with Webhook Validation
    [Tags]    webhook
    Start Webhook Server

    Log To Console    \n🚀 Creating payment order...
    ${order_id}=    Create Payment Order

    Log To Console    \n⏳ Waiting for webhook (simulate or real Cashfree callback)...
    Sleep    5s

    Validate Webhook Data    ${order_id}    SUCCESS
    Stop Webhook Server
