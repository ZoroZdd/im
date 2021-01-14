

[TOC]

# IM文档

## 说明
请求头携带参数 request_id todo




## 请求格式
若无特别说明，对于 POST 和 PUT 请求，请求的主体必须是 JSON 格式，而且 HTTP Header 的 Content-Type 需要设置为 application/json。

## 鉴权
请求的鉴权是通过 HTTP Header 里面包含的键值对来进行的

* 若无特殊说明 请求header头信息 必须带上 IM-APP-ID （开发者向IM 注册的平台 app_id）
* 若开发者平台开启token验证，header 需带上 【Access Token：Bearer】类型 TOKEN 值

token 为JWT签名，加密方法是 HMAC SHA256（写成 HS256）。具体信息参看  [token](#token)

## USER


### 新增用户
> POST 请求 https://API_BASE_URL/im/conversations/{conv_id}/members

请求参数 | 约束 |参数说明
---|---|---|
where |Y|查询条件
update |Y|更新内容
> 请求示例  
```
curl -X POST \
  -H "app-id: 666666" \
  -H "app-key: master" \
  -H "Content-Type: application/json" \
  -d '{"client_ids": ["Tom", "Jerry"]}' \
  http://127.0.0.1/im/conversations/{conv_id}/members
```
> 返回示例  
```
{
    "code": 0,
    "message": "ok",
    "data": true,
    "request-id": null
}
```

### 查询用户
> GET 请求 https://API_BASE_URL/im/conversations/{conv_id}/members

请求参数 | 约束 |参数说明
---|---|---|

> 请求示例  
```
curl -X GET \
  -H "app-id: 666666" \
  -H "app-key: master" \
  http://127.0.0.1/im/conversations/{conv_id}/members
```
> 返回示例  

```
{
    "code": 0,
    "message": "ok",
    "data": [
        "Tom",
        "Alex",
        "Iron"
    ],
    "request-id": null
}
```


##IM

### 登录
> 请求
```
{
    "type": "login",
    "data": {
        "device_id": "1111",
        "app_id": "666666",
        "client_id": "1111",
        "ext": {
            "nickname": "liliSara"
        }
    }
}
```
> 返回
```
{
    "type": "login.success",
    "msg": "success",
    "data": {
        "time": 1599927082012
    }
}
```


### 创建会话
> POST 请求 https://API_BASE_URL/im/conversations

请求参数 | 约束 |参数说明
---|---|---|
client_id|Y|发起会话者
to_client_ids  |Y| 接受者
conv_type|Y| 1 私聊 2 临时会话 3 群会话
conv_extend |N| 会话扩展[json]
> 请求示例  
```
curl -X POST \
  -H "app-id: 666666" \
  -H "app-key: master" \
  -H "Content-Type: application/json" \
  -d '{"client_id":"1597500303","to_client_ids":["1597500304"],"conv_type":2,"conv_extend":{"conv_name":"just test"}}' \
  http://127.0.0.1/im/conversations

```

> 返回示例  
```
{
    "code": 0,
    "message": "ok",
    "data": {
        "conv_extend": null,
        "conv_id": "0e7ae8d24e2658e7fb4ecdfbb409249d"
    },
    "request-id": null
}

```

### 查询会话
> GET 请求 https://API_BASE_URL/im/conversations

请求参数 | 约束 |参数说明
---|---|---|
where |Y|查询条件
page |N|默认1
size |N|默认20
> 请求示例  
```
curl -X POST \
  -H "app-id: 666666" \
  -H "app-key: master" \
  -G \
  --data-urlencode 'where=[["conv_id","=","e7c42cf35bd47c216f4b8e205e1fc0ca"]]' \
  --data-urlencode 'page=1' \
  --data-urlencode 'size=20' \
  http://127.0.0.1/im/conversations

```

> 返回示例  
```
{
    "code": 0,
    "message": "ok",
    "data": {
        "current_page": 1,
        "data": [
            {
                "conv_id": "05df798f554739291589f521d0f0f5a1",
                "conv_type": 2,
                "client_num": 0,
                "app_id": "666666",
                "conv_extend": null,
                "conv_creater_id": "1597500303",
                "ctime": "2020-08-21 07:16:37",
                "mtime": null
            },
            {
                "conv_id": "581d849f088217f07139181c5ea8d05f",
                "conv_type": 1,
                "client_num": 0,
                "app_id": "666666",
                "conv_extend": null,
                "conv_creater_id": "1597500303",
                "ctime": "2020-08-21 07:16:37",
                "mtime": null
            }
        ],
        "last_page": 10,
        "per_page": "2",
        "total": 20
    },
    "request-id": null
}

```

### 更新会话
> PUT 请求 https://API_BASE_URL/im/conversations

* 目前仅支持更新会话扩展

请求参数 | 约束 |参数说明
---|---|---|
where |Y|查询条件
update |Y|更新内容
> 请求示例  
```
curl -X PUT \
  -H "app-id: 666666" \
  -H "app-key: master" \
  -H "Content-Type: application/json" \
  -d '{"where": [["conv_id","=","b0e5ec174bd477df4b43e664927f6e3a"]],
    "update": {"conv_extend":{"conv_name":"test2"}}}' \
  http://127.0.0.1/im/conversations
```
> 返回示例  
```

{
    "code": 0,
    "message": "ok",
    "data": true,
    "request-id": null
}

```

### 删除会话
> DELETE 请求 https://API_BASE_URL/im/conversations/{conv_id}

* 目前仅支持更新会话扩展

请求参数 | 约束 |参数说明
---|---|---|
where |Y|查询条件
update |Y|更新内容
> 请求示例  
```
curl -X DELETE \
  -H "app-id: 666666" \
  -H "app-key: master" \
  http://127.0.0.1/im/conversations/{conv_id}
```
> 返回示例  
```
{
    "code": 0,
    "message": "ok",
    "data": true,
    "request-id": null
}
```

### 发送信息
> POST 请求 https://API_BASE_URL/im/conversations/{conv_id}/message

请求参数 | 约束 |参数说明
---|---|---|
from_client|Y|用户id
type  |Y| 消息类型 type -1文本 -2图片 -3语音 -4视频 -5位置 -6文件
text|N| 文本内容 默认null 文本类型则强制不为空
attr |N| 消息扩展[json] 默认null
url |N| 资源地址 默认null
transient |N| 0非暂态1暂态 默认非暂态
no_sync |N| 是否同步其他端 0不同步1同步
mention_all |N| 是否当前会话群组内全员@ 0否1是 默认否
mention_client_ids |N| 需要@的用户列表[json]

> 请求示例  
```
curl -X POST \
  -H "app-id: 666666" \
  -H "app-key: master" \
  -H "Content-Type: application/json" \
  -d '{"from_client":2,"type":-1,"text":"HELLO !"}' \
  http://127.0.0.1/im/conversations/{conv_id}/message
```
> 返回示例  
```
{
    "code": 0,
    "message": "ok",
    "data": {
        "msg_id": "1228a6554433f500a034b3f8d0b93571",
        "time": 1608126111686
    },
    "request-id": null
}
```
*说明 当api调用成功则对方用户会收到如下socket信息*
```
{
    "type": "msg.new",
    "data": {
        "from_client": 2,
        "conv_id": "cd7fc5304f56f52488d5246b0ebbdbfb",
        "msg_id": "1228a6554433f500a034b3f8d0b93571",
        "ctime": 1608126111618,
        "type": -1,
        "text": "HELLO !",
        "attr": "null",
        "url": "null",
        "transient": "0",
        "mention_all": 0,
        "mention_client_ids": "null"
    }
}
```
### 信息列表
> GET 请求 https://API_BASE_URL/im/conversations/{conv_id}/message
> 
请求参数 | 约束 | 参数说明
---|---|---|
page|N|默认1
size|N|默认10

> 请求示例  
```
curl --location --request GET 'http://127.0.0.1/im/conversations/cd7fc5304f56f52488d5246b0ebbdbfb/message' \
--header 'app-id: 666666' \
--header 'Content-Type: application/json' \
--data-raw '{
    "page":3,
    "size":5
}'
```
> 返回示例  
```
{
    "code": 0,
    "message": "ok",
    "data": {
        "current_page": 3,
        "data": [
            {
                "msg_id": "84a2ab146df74c4d1306d13d000d2ff7",
                "conv_id": "cd7fc5304f56f52488d5246b0ebbdbfb",
                "type": -1,
                "text": "123323333211112321",
                "attr": null,
                "url": "null",
                "ctime": 1608298323027,
                "msg_status": 1,
                "no_sync": 0,
                "mention_all": 0,
                "mention_client_ids": "null",
                "transient": 0,
                "mtime": null,
                "client_id": "2"
            },
            {
                "msg_id": "ae8c6a1146432fcc88d69ad735e2d56f",
                "conv_id": "cd7fc5304f56f52488d5246b0ebbdbfb",
                "type": -1,
                "text": "12333333333",
                "attr": null,
                "url": "null",
                "ctime": 1608298317004,
                "msg_status": 1,
                "no_sync": 0,
                "mention_all": 0,
                "mention_client_ids": "null",
                "transient": 0,
                "mtime": null,
                "client_id": "2"
            }
        ],
        "last_page": 119,
        "per_page": 2,
        "total": 237
    },
    "request-id": null
}
```

## FILE


### 上传文件
> POST 请求 https://API_BASE_URL/im/file/upload

请求参数 | 约束 |参数说明
---|---|---|
file |Y|文件
> 请求示例  
```
curl --location --request POST 'http://127.0.0.1/im/file/upload' \
--header 'app-id: 666666' \
--form 'file=@/Users/zorozdd/Desktop/2020-04-28 16.25.13.jpg' \
```
> 返回示例  
```
{
    "code": 0,
    "message": "ok",
    "data": "http://127.0.0.1/storage/uploads/7de523065e29c5526b7f1f8b15030df3.jpg",
    "request-id": null
}
```


## SOCKET接入说明



## SOCKET消息类型
logout.kick 登出 同一设备相同账号



## 状态码
**0**
>信息 - success  
>含义 - 成功响应并且返回相关数据

**1**
>信息 - Internal server error. No information available   
>含义 - 服务器内部错误或者参数错误，一般是因为传入了错误的参数，或者没有在本文档里明确定义的运行时错误，都会以代码 1 指代

**211**
>信息 - 未知用户   
>含义 - 相关操作内携带了不存在的用户信息

**212**
>信息 - unique_id 不符合要求   
>含义 - 注册用户时，unique_id必须是字母或数字字符串，不可携带特殊符号等

**213**
>信息 - 账号封禁   
>含义 - 该用户被IM封禁

**4001**
>信息 - 参数缺失  
>含义 - 接口缺少必须参数

**4002**
>信息 - 头信息缺失  
>含义 - 缺失必要的头信息

**4405**
>信息 - 错误的会话类型  
>含义 - 目前可接受的类型为 1 单聊 2 临时会话 3 群聊 4 聊天室

**4406**
>信息 - 错误的参数格式  
>含义 - 接口参数格式异常


