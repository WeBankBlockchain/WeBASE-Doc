# 接口说明

## 1. 新增用户接口

### 接口描述

新增用户。

### 接口URL

http://localhost:5004/WeBASE-Sign/user/newUser

### 调用方法

HTTP GET

### 请求参数

**1）参数表**

无

**2）数据格式**

```
http://localhost:5004/WeBASE-Sign/user/newUser
```

### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明**          |
|----------|----------|------------|----------|--------------|----------|-------------------|
| 1        | 返回码   | code       | String   |              | 是       | 返回码信息请附录1 |
| 2        | 提示信息 | message    | String   |              | 是       |                   |
| 3        | 返回数据 | data       | Object   |              | 是       |       |
| 3.1 | 用户编号 | userId | Integer | | 是 | |
| 3.2 | 私钥信息 | privateKey | String |  | 是 | |
| 3.3 | 账户地址 | address | String | | 是 | |
| 3.4 | 公钥 | publicKey | String | | 是 | |
| 3.5 | 描述 | description | String | | 是 | |

**2）数据格式**

a.请求正常返回结果
```
{
    "code": 0,
    "message": "success",
    "data": {
        "userId": 100001,
        "address": "0xaf7f9ad9560aa7cde37c693ba373707ab31d7823",
        "publicKey": "0x6efc55a03436057c4181160c195581e4f6b8a2135ea1030a326d5339a4f4a2a9bf2d603e020c77fa5b52af109f18955747bd0bcfa249955707d3932b544a9c65",
        "privateKey": "d3d8583b27bc5be0bca0ffb9d53db5a3324585148cd88e629a0b1084d2755bc8",
        "description": null
    }
}
```
b.异常返回结果示例（信息详情请参看附录1）
```
{
  "code": 103001,
  "message": "system error",
  "data": null
}
```

## 2. 查询用户接口

### 接口描述

根据用户编号查询用户信息。

### 接口URL

http://localhost:5004/WeBASE-Sign/user/{userId}/userInfo

### 调用方法

HTTP GET

### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 用户编号 | userId     | int      |              | 是       |          |

**2）数据格式**

```
http://localhost:5004/WeBASE-Sign/user/100001/userInfo
```

### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名**  | **类型** | **最大长度** | **必填** | **说明**          |
| -------- | -------- | ----------- | -------- | ------------ | -------- | ----------------- |
| 1        | 返回码   | code        | String   |              | 是       | 返回码信息请附录1 |
| 2        | 提示信息 | message     | String   |              | 是       |                   |
| 3        | 返回数据 | data        | Object   |              | 是       |                   |
| 3.1      | 用户编号 | userId      | Integer  |              | 是       |                   |
| 3.2      | 用户私钥 | privateKey  | String   |              | 是       |                   |
| 3.3      | 账户地址 | address     | String   |              | 是       | 链上地址          |
| 3.4      | 公钥     | publicKey   | String   |              | 是       |                   |
| 3.5      | 描述     | description | String   |              | 是       |                   |

**2）数据格式**

a.请求正常返回结果

```
{
    "code": 0,
    "message": "success",
    "data": {
        "userId": 100001,
        "address": "0xaf7f9ad9560aa7cde37c693ba373707ab31d7823",
        "publicKey": "0x6efc55a03436057c4181160c195581e4f6b8a2135ea1030a326d5339a4f4a2a9bf2d603e020c77fa5b52af109f18955747bd0bcfa249955707d3932b544a9c65",
        "privateKey": "d3d8583b27bc5be0bca0ffb9d53db5a3324585148cd88e629a0b1084d2755bc8",
        "description": null
    }
}
```

b.异常返回结果示例（信息详情请参看附录1）

```
{
  "code": 103001,
  "message": "system error",
  "data": null
}
```

## 3. 数据签名接口

### 接口描述

指定用户对数据进行签名。

### 接口URL

http://localhost:5004/WeBASE-Sign/sign

### 调用方法

HTTP POST

### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**     | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | -------------- | -------- | ------------ | -------- | -------- |
| 1        | 用户编号 | userId         | int      |              | 是       |          |
| 2        | 请求数据 | encodedDataStr | String   |              | 是       |          |

**2）数据格式**

```
{
  "userId":100001,
  "encodedDataStr":"XXX"
}
```

### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名**  | **类型** | **最大长度** | **必填** | **说明**          |
| -------- | -------- | ----------- | -------- | ------------ | -------- | ----------------- |
| 1        | 返回码   | code        | String   |              | 是       | 返回码信息请附录1 |
| 2        | 提示信息 | message     | String   |              | 是       |                   |
| 3        | 返回数据 | data        | Object   |              | 是       |                   |
| 3.1      | 签名数据 | signDataStr | String   |              | 是       |                   |

**2）数据格式**

a.请求正常返回结果

```
{
    "code": 0,
    "message": "success",
    "data": {
        "signDataStr": "xxx"
    }
}
```

b.异常返回结果示例（信息详情请参看附录1）

```
{
  "code": 103001,
  "message": "system error",
  "data": null
}
```

## 附录

### 1. 返回码信息列表

| Code    | message                               | 描述                       |
|---------|---------------------------------------|----------------------------|
| 0       | success                               | 正常                       |
| 103001  | system error                          | 系统异常                   |
| 203003  | param exception              | 参数校验异常               |
| 303001  | user is already exists                     | 用户已存在          |
| 303002  | user does not exist                     | 用户不存在          |
| 303003  | privateKey is null                     | 用户私钥为空          |
| 303004  | privateKey decode fail                   | 私钥解码失败          |
| 303005  | privateKey format error | 私钥格式错误 |
