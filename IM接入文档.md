
[TOC]

#IM接入文档
## 说明
> 文档内说明【需要token】的接口均在请求的 header 头信息中带上token值

## 用户

### 短信验证码
> POST 请求 sms/send
> 接口说明 ：获取手机短信验证码

请求参数 | 内容 | 是否为空 |参数说明
---|---|---|---|
nation_code|string |N|国际编码 eg 中国大陆 86
phone|string |N|手机号 eg 198xxxxxxxx

> 请求示例  
```
curl -X POST \
	 -d "nation_code=86&phone=16522222222" \
	"http://127.0.0.1:18306/sms/send"

```

> 成功返回示例  

```json
{
    "code": 0,
    "message": "ok",
    "data": "ok",
    "request-id": ""
}
```

> 失败返回示例  

```json
{
    "code": 1,
    "message": "无效的号码",
    "data": null,
    "request-id": ""
}
```
> 返回说明
> code                   [错误码](#错误码)
> message      	 错误信息

### 短信登入
> POST 请求 accessuser/signinbysms
> 接口说明 ：创建并登录用户

请求参数 | 内容 | 是否为空 |参数说明
---|---|---|---|
nation_code|string |N|国际编码 eg 中国大陆 86
phone|string |N|手机号 eg 198xxxxxxxx
check_code|int |N|短信验证码
device|string |N|设备类型 目前可选 web h5 android ios
device_id|string |N|设备唯一ID（web,h5类型目前可不传）

> 请求示例  
```
curl -X POST \
	 -d "nation_code=86&phone=16522222222&check_code=123456&device=android&device_id=qbfkdvkjdckci" \
	"http://127.0.0.1:18306/accessuser/signinbysms"

```

> 成功返回示例  

```json
{
    "code": 0,
    "message": "ok",
    "data": {
        "nickname": "GLdKtM",
        "avatar": null,
        "user_id": 8,
        "token": "63d128f9a25196029526506804d1b0c9",
        "im_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1bmlxdWVfbmFtZSI6OCwiZXhwIjoxNjA5OTQxNjU4fQ.0qX1AldXlTpemeP5L8FReN6xEPFU9QacGszLuTviAiA",
        "is_first_login": 1
    },
    "request-id": ""
}
```
> 返回说明
```json
token    用户token，部分接口依赖此参数作为设备与服务器之间的用户识别
avatar   用户头像地址
nickname 用户昵称
user_id  用户id，部分接口依赖此参数作为设备与服务器之间的用户识别
im_token 登录IM需要的鉴权token
is_first_login 0 老用户 1 首次登入用户
```
> 失败返回示例  

```json
{
    "code": 1,
    "message": "无效的用户信息",
    "data": null,
    "request-id": ""
}
```
### 修改资料
> POST 请求 accessuser/updateuserinfo
> 接口说明 ：修改用户的相关信息

请求参数 | 内容 | 是否为空 |参数说明
---|---|---|---|
avatar|file |Y|头像
nickname|string |Y|昵称

> 请求示例  
```
curl -X POST \
	 -H "token: 17643cf1f3fce67acfe3e91b4aec7d01" \
	 -F "avatar=@/Users/Desktop/a.jpg;" \
	"https://127.0.0.1:18306/accessuser/updateuserinfo"
```

> 成功返回示例  

```json
{
    "code": 0,
    "message": "ok",
    "data": {
        "nickname": "ivan",
        "avatar": "https://demo.cdn.net/im-app/resource/avatar/eb160d/117_20200203210938.png",
        "user_id": "146382"
    },
    "request-id": "391895336f6cd42f7e018cee9ee5fcc5"
}
```

> 失败返回示例  

```json
{
    "code": 1,
    "message": "修改失败",
    "data": null,
    "request-id": ""
}
```

### IM签名
> POST 请求 accessuser/getimtoken
> 接口说明 ：获取IM鉴权签名【需要token】

请求参数 | 内容 | 是否为空 |参数说明
---|---|---|---|
act|string |Y|动作 参照IM文档 token
members|array or string |Y| 操作对象

> 请求示例  
```
curl -X POST \
	 -H "token: 63d128f9a25196029526506804d1b0c9" \
	 -d "act=conv.create&members[]=6&members[]=7" \
	"http://127.0.0.1:18306/accessuser/getimtoken"
```

> 成功返回示例  

```json
{
    "code": 0,
    "message": "ok",
    "data": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOjgsImFjdCI6ImNvbnYuY3JlYXRlIiwibWVtYmVycyI6IjRkYTMyMDNjMzU1MmRhYjFjMTgzZGE4OTNhNDgzZWRlIiwiZXhwIjoxNjA5ODMwNjQ3fQ.5YsDOiZnBMIDbC7b-8qHnJCblRtD_RPqaV2NnL3dnpQ",
    "request-id": ""
}
```
> 返回说明
```json
data  IM需要的鉴权token
```


### 关系处理
> POST 请求 relation/operation
> 接口说明 ：对好友进行关注，取消关注，拉黑，取消拉黑操作【需要token】

请求参数 | 内容 | 是否为空 |参数说明
---|---|---|---|
to_user_id|string |N|操作对象用户ID
type|string |N| 操作类型 follow 关注 unfollow 取关  block 拉黑 unblock 取消拉黑

> 请求示例  
```
curl -X POST \
	 -H "token: 63d128f9a25196029526506804d1b0c9" \
	 -d "to_user_id=12&type=follow" \
	"http://127.0.0.1:18306/relation/operation"
```

> 成功返回示例  

```json
{
    "code": 0,
    "message": "ok",
    "data": "ok",
    "request-id": ""
}
```
> 说明 执行拉黑默认取消用户好友关系，执行关注默认取消拉黑关系

### 联系人/黑名单
> POST 请求 relation/followlist
> 接口说明 ：暂无【需要token】

请求参数 | 内容 | 是否为空 |参数说明
---|---|---|---|
type|string |N|follow 联系人列表 black 黑名单
page|int |Y|默认1 页数
size|int |Y|默认20 每页数量

> 请求示例  
```
curl -X POST \
	 -H "token: 63d128f9a25196029526506804d1b0c9" \
	 -d "type=follow" \
	"http://127.0.0.1:18306/relation/followlist"
```

> 成功返回示例  

```json
{
    "code": 0,
    "message": "ok",
    "data": {
        "page_info": {
            "page": 1,
            "size": 20,
            "totalPage": 1,
            "totalCount": 1
        },
        "list": [
            {
                "nickname": "whaha12",
                "avatar": "https://demo.cdn.net/im-app/resource/avatar/12_20200108213453.jpeg",
                "user_id": 12
            }
        ]
    },
    "request-id": ""
}
```
> 说明 执行拉黑默认取消用户好友关系，执行关注默认取消拉黑关系

## 错误码



