*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Resource   ../config/testdata.robot

*** Keywords ***

Create Payment Order
    [Documentation]    Create a new payment order in Cashfree sandbox.
    Create Session    cashfree    ${BASE_URL}    verify=False

    ${headers}=    Create Dictionary
    ...    Content-Type=application/json
    ...    Accept=application/json
    ...    x-api-version=${API_VERSION}
    ...    x-client-id=${CLIENT_ID}
    ...    x-client-secret=${CLIENT_SECRET}

    ${customer_details}=    Create Dictionary
    ...    customer_id=${CUSTOMER_ID}
    ...    customer_email=${CUSTOMER_EMAIL}
    ...    customer_phone=${CUSTOMER_PHONE}

    ${body}=    Create Dictionary
    ...    order_amount=${ORDER_AMOUNT}
    ...    order_currency=${ORDER_CURRENCY}
    ...    customer_details=${customer_details}

    Log To Console    \nRequest Headers: ${headers}
    Log To Console    \nRequest Body: ${body}

    ${response}=    POST On Session    cashfree    /orders    json=${body}    headers=${headers}
    Log To Console    \nOrder Creation Response: ${response.text}

    ${json}=    Set Variable    ${response.json()}
    Should Be Equal As Integers    ${response.status_code}    200
    Set Suite Variable    ${ORDER_ID}    ${json['order_id']}
    Log To Console    \nOrder ID: ${ORDER_ID}
    RETURN    ${ORDER_ID}


Get Payment Order Status
    [Documentation]    Retrieve order details for created order.
    [Arguments]    ${order_id}
    Create Session    cashfree    ${BASE_URL}    verify=False

    ${headers}=    Create Dictionary
    ...    Accept=application/json
    ...    x-api-version=${API_VERSION}
    ...    x-client-id=${CLIENT_ID}
    ...    x-client-secret=${CLIENT_SECRET}

    ${response}=    GET On Session    cashfree    /orders/${order_id}    headers=${headers}
    Log To Console    \nOrder Status Response: ${response.text}

    ${json}=    Set Variable    ${response.json()}
    Should Be Equal As Strings    ${json['order_id']}    ${order_id}
    Should Be Equal As Strings    ${json['order_currency']}    ${ORDER_CURRENCY}
    Should Be Equal As Numbers    ${json['order_amount']}    ${ORDER_AMOUNT}

    Log To Console    \nOrder Status: ${json['order_status']}
    [Return]    ${json['order_status']}
