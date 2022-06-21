*** Settings ***
Resource          ../common/basic_config.txt
Resource          ../common/service.txt

*** Test Cases ***
query_event
    [Documentation]    请求类型：GET
    ...    事件表-查询id
    ${token}    ${parkId}    ${code}    login    ${username}    ${password}
    #创建params参数
    ${params}    create dictionary    parkId=${parkId}    dealStatus=2
    #创建头
    ${headers}    create dictionary    X-Access-Token=${token}
    #创建会话
    create session    req    ${zhpt_api_url}
    #发送get请求
    ${res}    get on session    req    /jeecg-imp/api/imp/online/water/event/queryEventIdsList    params=${params}    headers=${headers}
    log    ${res.json()}
    ${code}    Get From Dictionary    ${res.json()}    code
    #断言
    should be equal as strings    ${code}    200
