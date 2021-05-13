# 接口说明

## 1. 新增用户接口

### 1.1. 新增ECDSA/国密用户接口

#### 接口描述

根据传入的`encryptType`值，新增ECDSA或国密公私钥用户。

#### 接口URL

http://localhost:5004/WeBASE-Sign/user/newUser?signUserId={signUserId}&appId={appId}&encryptType={encryptType}

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明**          |
|----------|----------|------------|----------|--------------|----------|-------------------|
| 1        | 用户编号  | signUserId | String |  64           | 是       | 私钥用户的唯一业务编号，仅支持数字字母下划线  |
| 2        | 应用编号 | appId   | String |      64       | 是       | 用于标志用户的应用编号,仅支持数字字母下划线 |
| 3        | 加密类型  | encryptType  | Integer |              | 否       | 默认为0，0: ECDSA, 1: 国密  |
| 4 | 是否返回私钥 | returnPrivateKey | boolean | | 否 | 默认false，true时返回aes加密的私钥 |

**2）数据格式**

```
http://localhost:5004/WeBASE-Sign/user/newUser?signUserId={signUserId}&appId={appId}&encryptType=0
```

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明**          |
|----------|----------|------------|----------|--------------|----------|-------------------|
| 1        | 返回码   | code       | String   |              | 是       | 返回码信息请附录1 |
| 2        | 提示信息 | message    | String   |              | 是       |                   |
| 3        | 返回数据 | data       | Object   |              | 是       |                    |
| 3.1      | 用户编号 | signUserId | String  |              | 是        |                    |
| 3.2      | 应用编号 | appId      | String  |              | 是        |                    |
| 3.3      | 私钥信息 | privateKey | String   |              | 是        |                   |
| 3.4      | 账户地址 | address    | String   |              | 是        |                   |
| 3.5      | 公钥    | publicKey  | toHexString |           | 是        |                  |
| 3.6      | 描述    | description| String   |              | 是        |                  |
| 3.7      | 加密类型 |encryptType| Integer |               | 是        | 0: ECDSA, 1: guomi |

**2）数据格式**

a.请求正常返回结果

ECDSA用户：
```
{
    "code": 0,
    "message": "success",
    "data": {
        "signUserId": "user_111",
        "appId": "group_01",
        "address": "0x2df87ff79e8c85a318c00c82ee76e2581fbab0a8",
        "publicKey": "0x1befc9824623dfc2f1541d2fc1df4bc445d9dd26816b0884e24628881d5bb572bf7dfd69520d540adc2d16d295df954d9c34bef4381dbc207942fcbf43c7d622",
        "privateKey": "",
        "description": null,
        "encryptType": 0
    }
}
```

国密用户：
```
{
    "code": 0,
    "message": "success",
    "data": {
        "signUserId": "user_222",
        "appId": "group_02",
        "address": "0x0bc3465986845864fc1646dedf2dd892c0fe11be",
        "publicKey": "0xd09d4efe3c127898186c197ae6004a9b40d7c7805fc7e31f7c4a835a4b9cf4148155cbd6dfcf3e5fd84acf1ea55c26b5a9b05d118b456738be2becf0e667c0d6",
        "privateKey": "",
        "description": null,
        "encryptType": 1
    }
}
```

b.异常返回结果示例（信息详情请参看附录1）
```
{
    "code": 303001,
    "message": "user of this sign user id is already exists",
    "data": null
}
```

### 1.2. 导入私钥用户接口

#### 接口描述

导入私钥到Sign，与新增私钥类似

#### 接口URL

http://localhost:5004/WeBASE-Sign/sign

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明**          |
|----------|----------|------------|----------|--------------|----------|-------------------|
| 1        | 私钥  | privateKey | String     |             | 是       | 通过Base64加密后的私钥内容（编码前私钥为BigInteger的HexString十六进制字符串）  |
| 2        | 用户编号  | signUserId | String |  64           | 是       | 私钥用户的唯一业务编号，仅支持数字字母下划线  |
| 3        | 应用编号 | appId   | String |      64       | 是       | 用于标志用户的应用编号,仅支持数字字母下划线 |
| 4        | 加密类型  | encryptType  | Integer |              | 否       | 默认为0，0: ECDSA, 1: 国密  |

**2）数据格式**

```
http://localhost:5004/WeBASE-Sign/user/newUser
```

```
{
    //privateKey编码前原文为: 3d1a470b2e7ae9d536c69af1cc5edf7830ece5b6a97df0e9441bab9f7a77b131
  "privateKey": "M2QxYTQ3MGIyZTdhZTlkNTM2YzY5YWYxY2M1ZWRmNzgzMGVjZTViNmE5N2RmMGU5NDQxYmFiOWY3YTc3YjEzMQ==",
  "signUserId": "user_222",
  "appId": "app_222",
  "encryptType": 0
}
```

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明**          |
|----------|----------|------------|----------|--------------|----------|-------------------|
| 1        | 返回码   | code       | String   |              | 是       | 返回码信息请附录1 |
| 2        | 提示信息 | message    | String   |              | 是       |                   |
| 3        | 返回数据 | data       | Object   |              | 是       |                    |
| 3.1      | 用户编号 | signUserId | String  |              | 是        |                    |
| 3.2      | 应用编号 | appId      | String  |              | 是        |                    |
| 3.3      | 私钥信息 | privateKey | String   |              | 否        |                   |
| 3.4      | 账户地址 | address    | String   |              | 是        |                   |
| 3.5      | 公钥    | publicKey  | toHexString |           | 是        |                  |
| 3.6      | 描述    | description| String   |              | 是        |                  |
| 3.7      | 加密类型 |encryptType| Integer |               | 是        | 0: ECDSA, 1: guomi |

**2）数据格式**

a.请求正常返回结果

ECDSA用户：
```
{
    "code": 0,
    "message": "success",
    "data": {
        "signUserId": "user_111",
        "appId": "group_01",
        "address": "0x2df87ff79e8c85a318c00c82ee76e2581fbab0a8",
        "publicKey": "0x1befc9824623dfc2f1541d2fc1df4bc445d9dd26816b0884e24628881d5bb572bf7dfd69520d540adc2d16d295df954d9c34bef4381dbc207942fcbf43c7d622",
        "privateKey": "", //不返回私钥
        "description": null,
        "encryptType": 0
    }
}
```


b.异常返回结果示例（信息详情请参看附录1）
```
{
    "code": 303001,
    "message": "user of this sign user id is already exists",
    "data": null
}
```

## 2. 查询用户接口

### 2.1 根据userId查询用户

####  接口描述

根据用户编号查询用户信息。

#### 接口URL

http://localhost:5004/WeBASE-Sign/user/{signUserId}/userInfo

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 用户编号  | signUserId | String |        64       | 是       | 私钥用户的唯一业务编号，仅支持数字字母下划线  |
| 2 | 是否返回私钥 | returnPrivateKey | boolean |  | 否 | 默认false，true时返回aes加密的私钥 |

**2）数据格式**

```
http://localhost:5004/WeBASE-Sign/user/{signUserId}/userInfo
```

#### 响应参数

**1）参数表**


| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明**          |
|----------|----------|------------|----------|--------------|----------|-------------------|
| 1        | 返回码   | code       | String   |              | 是       | 返回码信息请附录1 |
| 2        | 提示信息 | message    | String   |              | 是       |                   |
| 3        | 返回数据 | data       | Object   |              | 是       |                    |
| 3.1      | 用户编号 | signUserId | String  |              | 是        |                    |
| 3.2      | 应用编号 | appId      | String  |              | 是        |                    |
| 3.3      | 私钥信息 | privateKey | String   |              | 是        |                   |
| 3.4      | 账户地址 | address    | String   |              | 是        |                   |
| 3.5       | 公钥    | publicKey  | toHexString |           | 是        |                  |
| 3.6       | 描述    | description| String   |              | 是        |                  |
| 3.7       | 加密类型 |encryptType| Integer |               | 是        | 0: ECDSA, 1: guomi |


**2）数据格式**

a.请求正常返回结果

ECDSA用户：
```
{
    "code": 0,
    "message": "success",
    "data": {
        "signUserId": "user_111",
        "appId": "group_01",
        "address": "0x2df87ff79e8c85a318c00c82ee76e2581fbab0a8",
        "publicKey": "0x1befc9824623dfc2f1541d2fc1df4bc445d9dd26816b0884e24628881d5bb572bf7dfd69520d540adc2d16d295df954d9c34bef4381dbc207942fcbf43c7d622",
        "privateKey": "",
        "description": null,
        "encryptType": 0
    }
}
```


b.异常返回结果示例（信息详情请参看附录1）

```
{
    "code": 303002,
    "message": "user does not exist",
    "data": null
}
```


## 3. 私钥用户管理接口

### 3.1. 停用私钥用户

#### 接口描述

通过修改私钥用户的`status`状态值来停用私钥用户；停用后，其他接口将不返回被停用的私钥用户

#### 接口URL

http://localhost:5004/WeBASE-Sign/user

#### 调用方法

HTTP DELETE

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**     | **类型** | **最大长度** | **必填** | **说明**                                                     |
| -------- | -------- | -------------- | -------- | ------------ | -------- | ------------------------------------------------------------ |
| 1        | 用户编号  | signUserId | String |       64        | 是       | 私钥用户的唯一业务编号，仅支持数字字母下划线  |

**2）数据格式**

```
http://localhost:5004/WeBASE-Sign/user
```

```
{
  "signUserId": "user_111"
}
```

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名**  | **类型** | **最大长度** | **必填** | **说明**          |
| -------- | -------- | ----------- | -------- | ------------ | -------- | ----------------- |
| 1        | 返回码   | code        | String   |              | 是       | 返回码信息请附录1 |
| 2        | 提示信息 | message     | String   |              | 是       |                   |

**2）数据格式**

a.请求正常返回结果

```
{
    "code": 0,
    "message": "success"
}
```

b.异常返回结果示例（信息详情请参看附录1）

```
{
    "code": 303002,
    "message": "user does not exist",
    "data": null
}
```


### 3.2. 清除私钥用户缓存

#### 接口描述

私钥用户的缓存用于缓存私钥数据到内存中，提高私钥签名效率；此接口可删除所有用户缓存信息

#### 接口URL

http://localhost:5004/WeBASE-Sign/user/all

#### 调用方法

HTTP DELETE

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**     | **类型** | **最大长度** | **必填** | **说明**                                                     |
| -------- | -------- | -------------- | -------- | ------------ | -------- | ------------------------------------------------------------ |
| -        | -  | - | - |       -        | -       | -  |

**2）数据格式**

```
http://localhost:5004/WeBASE-Sign/user/all
```

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名**  | **类型** | **最大长度** | **必填** | **说明**          |
| -------- | -------- | ----------- | -------- | ------------ | -------- | ----------------- |
| 1        | 返回码   | code        | String   |              | 是       | 返回码信息请附录1 |
| 2        | 提示信息 | message     | String   |              | 是       |                   |

**2）数据格式**

a.请求正常返回结果

```
{
    "code": 0,
    "message": "success"
}
```


## 4. 用户列表接口

### 4.1. 根据appId查询用户列表（分页）

#### 接口描述

根据传入的`appId`值，查询所有所有属于该appId的用户信息列表。

#### 接口URL

http://localhost:5004/WeBASE-Sign/user/list/{appId}/{pageNumber}/{pageSize}

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明**          |
|----------|----------|------------|----------|------------|----------|-------------------|
| 1        | 应用编号 | appId     | String    |               | 是       | 用于标志用户的应用编号 |
| 2        | 页码     | pageNumber | Integer |              | 是       | 页码，同时为空则返回全部 |
| 3        | 页大小    | pageSize | Integer |              | 是       | 页大小，同时为空则返回全部 |
| 4 | 是否返回私钥 | returnPrivateKey | boolean | | 否 | 默认false，true时返回aes加密的私钥 |

**2）数据格式**

```
http://localhost:5004/WeBASE-Sign/user/list/group_01/1/5
```

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名**  | **类型** | **最大长度** | **必填** | **说明**          |
| -------- | -------- | ----------- | -------- | ------------ | -------- | ----------------- |
| 1        | 返回码   | code        | String   |              | 是       | 返回码信息请附录1 |
| 2        | 提示信息 | message     | String   |              | 是       |                   |
| 3        | 返回数据 | data        | List     |              | 是       |                   |
| 3.1      | 用户编号 | signUserId | String  |              | 是        |                    |
| 3.2      | 应用编号 | appId      | String  |              | 是        |                    |
| 3.3      | 私钥信息 | privateKey | String   |              | 是        |                   |
| 3.4      | 账户地址 | address    | String   |              | 是        |                   |
| 3.5       | 公钥    | publicKey  | toHexString |           | 是        |                  |
| 3.6       | 描述    | description| String   |              | 是        |                  |
| 3.7       | 加密类型 |encryptType| Integer |               | 是        | 0: ECDSA, 1: guomi |
| 4        | 总量    | totalCount   | Long      |             | 否       | 数据总量 |

**2）数据格式**

a.请求正常返回结果

ECDSA用户列表：
```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "signUserId": "user_111",
            "appId": "group_01",
            "address": "0x2df87ff79e8c85a318c00c82ee76e2581fbab0a8",
            "publicKey": "0x1befc9824623dfc2f1541d2fc1df4bc445d9dd26816b0884e24628881d5bb572bf7dfd69520d540adc2d16d295df954d9c34bef4381dbc207942fcbf43c7d622",
            "privateKey": "",
            "description": null,
            "encryptType": 0
        }
    ],
    "totalCount": 1
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


## 5. 数据签名接口

### 5.1. ECDSA/国密数据签名接口

#### 接口描述

指定用户通过ECDSA/国密SM2对数据进行签名。

#### 接口URL

http://localhost:5004/WeBASE-Sign/sign

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**     | **类型** | **最大长度** | **必填** | **说明**                                                     |
| -------- | -------- | -------------- | -------- | ------------ | -------- | ------------------------------------------------------------ |
| 1        | 用户编号  | signUserId | String |         64      | 是       | 私钥用户的唯一业务编号，仅支持数字字母下划线  |
| 2        | 请求数据 | encodedDataStr | String   |              | 是       | 十六进制String类型，使用java-sdk的Numeric.toHexString(byte[] input)方法将编码数据转换成HexString|

**2）数据格式**

```
http://localhost:5004/WeBASE-Sign/sign
```

```
{
  "signUserId": "user_111",
  "encodedDataStr": "0xba001"
}
```

#### 响应参数

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
        "signDataStr": "1c3f59a48593b66de4c57fe99f9c429811aa2dc9b495823cd99faa3e72b4a4d02e04bb7c3da6390a17adc00b0e740293c6306229a26a0c0cf2974581880d19e57b"
    }
}
```

b.异常返回结果示例（信息详情请参看附录1）

```
{
    "code": 203009,
    "message": "encoded data string must be hex string",
    "data": null
}
```



## 6. 其他接口

### 6.1. 查询WeBASE-Sign版本接口

#### 接口描述

获取WeBASE-Sign的版本号

#### 接口URL

**http://localhost:5004/WeBASE-Sign/version**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|          | -       | -            | -   |              |        |                            |

**2）数据格式**

```
http://localhost:5004/WeBASE-Sign/version
```

#### 响应参数

**1）数据格式**

a、成功：

```
v1.4.0
```


## 附录

### 1. 返回码信息列表
<span id="code"></span>

| Code    | message                               | 描述                       |
|---------|---------------------------------------|----------------------------|
| 0       | success                               | 正常                       |
| 103001  | system error                          | 系统异常                   |
| 103002  | param valid fail                      | 参数校验失败                   |
| 203003  | param exception                       | 参数校验异常               |
| 203004  | sign user id cannot be blank          | signUserId不可为空               |
| 203005  | invalid sign user id, only support letter and digit  | signUserId不正确，仅支持数字字母下划线               |
| 203006  | app id cannot be blank                | appId不可为空               |
| 203007  | app id invalid, only support letter and digit | appId不正确，仅支持数字字母下划线               |
| 203008  | encrypt type should be 0 (ecdsa) or 1 (guomi) | encryptType仅支持0或1               |
| 203009  | encoded data string must be hex string  | encodedDataStr仅支持十六进制String               |
| 303001  | user is already exists                | 用户已存在          |
| 303002  | user does not exist                   | 用户不存在          |
| 303003  | privateKey is null                    | 用户私钥为空          |
| 303004  | privateKey decode fail                | 私钥解码失败          |
| 303005  | privateKey format error | 私钥格式错误 |
| 303006 | privateKey not support transfer | 私钥不支持传输 |
