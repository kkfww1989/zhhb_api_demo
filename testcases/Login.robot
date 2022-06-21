*** Settings ***
Resource          ../common/basic_config.txt
Resource          ../common/service.txt
Library           execExcelLibrary
Library           parseExcelLibrary
Library           Collections
Library           RequestsLibrary
Resource          ../common/utils.txt
Resource          ../data/testDatas.xls

*** Variables ***
${testcaseDatas}    E:\\Code\\zhhb_api\\data\\testDatas.xls    # 测试用例数据

*** Test Cases ***
login_success
    [Tags]    ok
    ${token}    ${parkId}    ${code}    login    ${username}    ${password}
    should be equal as strings    ${code}    200

login_all
    [Documentation]    数据源：excel数据。
    [Tags]    all
    Comment    ${testcaseDatas}    Set Variable    ${file}
    ${rowNum}    getTestCaseNum    ${testcaseDatas}    login
    : FOR    ${i}    IN RANGE    1    ${rowNum}+1
    \    ${method}    getTestHttpMethod    ${testcaseDatas}    login    ${i}
    \    ${testCaseObj}    getOneTestCase    ${testcaseDatas}    login    ${i}
    \    ${code}    ${content}    sendRequest    ${testCaseObj.method}    ${zhpt_api_url}    ${testCaseObj.path_url}
    \    ...    ${testCaseObj.headers}    ${testCaseObj.params}    ${testCaseObj.body}
    \    ${json_content}    To JSon    ${content}
    \    ${code1}    Get From Dictionary    ${json_content}    code
    \    ${code1}    Evaluate    float(${code1})
    \    Should Be Equal As Strings    ${testCaseObj.expect_code}    ${code1}
    \    should contain    ${content}    ${testCaseObj.expect_content}
