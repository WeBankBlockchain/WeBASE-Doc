# 目录
[TOC]



# 1. 新增用户接口 

 [top](#目录)

## 接口描述

新增用户。

## 接口URL

http://localhost:8085/webase-sign/addUser

## 调用方法

HTTP POST

## 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**  | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ----------- | -------- | ------------ | -------- | -------- |
| 1        | 用户名   | userName    | String   | 32           | 是       |          |
| 2        | 描述     | description | String   | 128          | 否       |          |

**2）数据格式**

```
{
  "userName": "jack",
  "description": "test"
}
```

## 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明**          |
|----------|----------|------------|----------|--------------|----------|-------------------|
| 1        | 返回码   | code       | String   |              | 是       | 返回码信息请附录1 |
| 2        | 提示信息 | message    | String   |              | 是       |                   |
| 3        | 返回数据 | data       | Object   |              | 是       |       |
| 3.1 | 用户编号 | userId | Integer | | 是 | |
| 3.2 | 用户名 | userName | String |  | 是 | |
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
    "userId": 100002,
    "userName": "jack",
    "address": "0x3ba79c2cfdd1c5519c7b24722b8b32c5f6c78e1d",
    "publicKey": "0x58b358bd09d1b2da7eeefee32e6569f5d36b1b986d19a0333cb2475471e21652646d61a70b561b7e8a61162bd5bdbc0d7627686fadf24148022f9fdd532d2749",
    "description": "test"
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

# 2. 查询用户接口 
[top](#目录)

## 接口描述

根据用户名查询用户信息。

## 接口URL

http://localhost:8085/webase-sign/userInfo/{userName}

## 调用方法

HTTP GET

## 请求参数

**1）参数表**

| **序号** | **中文**   | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
|----------|------------|------------|----------|--------------|----------|----------|
| 1        | 用户名   | userName   | String | 32           | 是       |          |

**2）数据格式**

http://localhost:8082/webase-sign/userInfo/jack

## 响应参数

**1）参数表**

| **序号** | **中文** | **参数名**  | **类型** | **最大长度** | **必填** | **说明**          |
| -------- | -------- | ----------- | -------- | ------------ | -------- | ----------------- |
| 1        | 返回码   | code        | String   |              | 是       | 返回码信息请附录1 |
| 2        | 提示信息 | message     | String   |              | 是       |                   |
| 3        | 返回数据 | data        | Object   |              | 是       |                   |
| 3.1      | 用户编号 | userId      | Integer  |              | 是       |                   |
| 3.2      | 用户名   | userName    | String   |              | 是       |                   |
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
    "userId": 100002,
    "userName": "jack",
    "address": "0x3ba79c2cfdd1c5519c7b24722b8b32c5f6c78e1d",
    "publicKey": "0x58b358bd09d1b2da7eeefee32e6569f5d36b1b986d19a0333cb2475471e21652646d61a70b561b7e8a61162bd5bdbc0d7627686fadf24148022f9fdd532d2749",
    "description": "test"
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

# 3. 数据签名接口 

[top](#目录)

## 接口描述

对数据进行签名。

## 接口URL

http://localhost:8085/webase-sign/addSign

## 调用方法

HTTP POST

## 请求参数

**1）参数表**

| **序号** | **中文**   | **参数名**      | **类型**       | **最大长度** | **必填** | **说明**                                           |
|----------|------------|-----------------|----------------|--------------|----------|----------------------------------------------------|
| 1        | 用户名   | userName       | String | 32           | 是       |                                                    |
| 2        | 编码数据 | encodedDataStr | String         |              | 是       |                                                    |
| 3        | 数据描述 | desc    | String         | 64           | 否       |                                                    |

**2）数据格式**
```
{
  "desc": "test",
  "encodedDataStr": "encodedDataStr",
  "userName": "jack"
}
```
## 响应参数

**1）参数表**

| **序号** | **中文** | **参数名**  | **类型** | **最大长度** | **必填** | **说明**          |
| -------- | -------- | ----------- | -------- | ------------ | -------- | ----------------- |
| 1        | 返回码   | code        | String   |              | 是       | 返回码信息请附录1 |
| 2        | 提示信息 | message     | String   |              | 是       |                   |
| 3        | 返回数据 | data        | Object   |              | 是       |                   |
| 3.1      | 签名数据 | signDataStr | String   |              | 是       | 私钥签名后的数据  |
| 3.2      | 数据描述 | desc        | String   |              | 是       |                   |

**2）数据格式**

a.请求正常返回结果
```
{
  "code": 0,
  "message": "success",
  "data": {
    "signDataStr": "1c2fd4a9d5e2005d6eec77034e0e9fa492a93ef9208323d91e5665c158565c19051b8c24097f87d199a85678e11b6968be06b4347d22a7e4444299ac1b7339423f",
    "desc": "test"
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

# 附录 

## 1.返回码信息列表 

 [top](#目录)

| Code    | message                               | 描述                       |
|---------|---------------------------------------|----------------------------|
| 0       | success                               | 正常                       |
| 103001  | system error                          | 系统异常                   |
| 103002  | param valid fail                      | 参数校验异常               |
| 203001  | user name cannot be empty | 用户名不能为空        |
| 203002  | encoded data cannot be empty | 编码数据不能为空 |
| 303001 | user is already exists       | 用户已经存在     |
| 303001 | user does not exist          | 用户不存在       |
