# 接口说明
## 1. 合约接口

### 1.1. 合约编译接口 
#### 接口描述

调用此接口编译合约。上传合约文件zip压缩包（压缩包里的每个合约的文件名要和合约名一致，合约引用需使用“./xxx.sol”），返回合约编译信息。

注：合约编译默认使用ethereum solcj-0.4.25.jar，如需使用其他版本在/dist/lib中替换solcJ的jar包；
或将新的solcJ jar包放置在项目根目录的/lib文件夹中，在build.gradle中引入web3sdk处exclude去除ethereum的solcJ jar包，同时通过fileTree引入lib中的solcJ-gm jar包

下载其他版本或国密版合约编译包则到[下载合约编译jar包](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/manual/console.html#jar)下载

#### 接口URL

http://localhost:5003/WeBASE-Transaction/contract/compile

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明**        |
|----------|----------|------------|----------|--------------|----------|-----------------|
| 1        | 合约文件 | file       | zip      |              | 是       | 必须是zip压缩包 |

**2）数据格式**

压缩包文件

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明**          |
|----------|----------|------------|----------|--------------|----------|-------------------|
| 1        | 返回码   | code       | String   |              | 是       | 返回码信息请附录1 |
| 2        | 提示信息 | message    | String   |              | 是       |                   |
| 3        | 返回数据 | data       | Object   |              | 是       |       |

**2）数据格式**

a.请求正常返回结果
```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "contractName": "HelloWorld",
      "contractBin": "xxx",
      "contractAbi": []
    }
  ]
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

### 1.2. 合约部署接口 
#### 接口描述

调用此接口发送合约部署相关信息，交易服务子系统会将合约部署请求信息缓存到数据库，通过轮询服务向节点发送交易请求，确保合约成功部署。

#### 接口URL

http://localhost:5003/WeBASE-Transaction/contract/deploy

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**  | **类型**       | **最大长度** | **必填** | **说明**                                           |
|----------|--------------|-------------|----------------|--------------|----------|----------------------------------------------------|
| 1        | 群组编号     | groupId     | int            | 16           | 是       |                                                    |
| 2        | 部署业务流水号   | uuidDeploy        | String         | 64           | 是       |                                                    |
| 3        | 签名类型     | signType    | int            | 2            | 是       | 0-本地配置私钥签名，1-本地随机私钥签名，2-调用WeBASE-Sign签名 |
| 4        | 合约Bin      | contractBin | String         |              | 是       |                                                    |
| 5        | 合约Abi      | contractAbi | List\<Object\> |              | 是       | JSON数组                                           |
| 6        | 构造方法参数 | funcParam   | List\<Object\> |              | 否       | JSON数组                                           |
| 7 | 签名用户编号 | signUserId | int | | 否 | signType为2时必填 |

**2）数据格式**
```
{
  "groupId":1,
  "uuidDeploy":"XXX",
  "signType":0,
  "contractBin":"0xXXXXX",
  "contractAbi":[],
  "funcParam":["hello"],
  "signUserId":100001
}
```
#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明**          |
|----------|----------|------------|----------|--------------|----------|-------------------|
| 1        | 返回码   | code       | String   |              | 是       | 返回码信息请附录1 |
| 2        | 提示信息 | message    | String   |              | 是       |                   |
| 3        | 返回数据 | data       | Object   |              | 是       |           |

**2）数据格式**

a.请求正常返回结果

```
{
  "code": 0,
  "message": "success",
  "data": null
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

### 1.3. 合约地址查询接口 
#### 接口描述

根据群组编号和和部署业务流水号查询部署的合约地址。

#### 接口URL

http://localhost:5003/WeBASE-Transaction/contract/address/{groupId}/{uuidDeploy}

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**   | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
|----------|------------|------------|----------|--------------|----------|----------|
| 1        | 群组编号   | groupId    | int      | 16           | 是       |          |
| 2        | 部署业务流水号 | uuidDeploy       | String   | 64           | 是       |          |

**2）数据格式**

```
http://127.0.0.1:5003/WeBASE-Transaction/contract/address/1/10001
```

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明**          |
|----------|----------|------------|----------|--------------|----------|-------------------|
| 1        | 返回码   | code       | String   |              | 是       | 返回码信息请附录1 |
| 2        | 提示信息 | message    | String   |              | 是       |                   |
| 3        | 返回数据 | data       | Object   |              |          |  合约地址                 |

**2）数据格式**

a.请求正常返回结果
```
{
  "code": 0,
  "message": "success",
  "data": "0xXXXXX"
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

### 1.4. 部署event查询接口 
#### 接口描述

根据群组编号和和部署业务流水号查询部署的合约的构造函数的event信息。

#### 接口URL

http://localhost:5003/WeBASE-Transaction/contract/event/{groupId}/{uuidDeploy}

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**   | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
|----------|------------|------------|----------|--------------|----------|----------|
| 1        | 群组编号   | groupId    | int      | 16           | 是       |          |
| 2        | 部署业务流水号 | uuidDeploy       | String   | 64           | 是       |          |

**2）数据格式**

```
http://127.0.0.1:5003/WeBASE-Transaction/contract/event/1/10001
```

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明**          |
|----------|----------|------------|----------|--------------|----------|-------------------|
| 1        | 返回码   | code       | String   |              | 是       | 返回码信息请附录1 |
| 2        | 提示信息 | message    | String   |              | 是       |                   |
| 3        | 返回数据 | data       | Object   |              |          |                  |

**2）数据格式**

a.请求正常返回结果
```
{
  "code": 0,
  "message": "success",
  "data": {
    "constructorEvent1": [
        "hello!"
    ],
    "constructorEvent": [
        "test",
        8
    ]
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

### 1.5. 部署信息查询接口 

#### 接口描述

根据群组编号和和部署业务流水号查询部署的信息。

#### 接口URL

http://localhost:5003/WeBASE-Transaction/contract/deployInfo/{groupId}/{uuidDeploy}

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 群组编号       | groupId    | int      | 16           | 是       |          |
| 2        | 部署业务流水号 | uuidDeploy | String   | 64           | 是       |          |

**2）数据格式**

```
http://127.0.0.1:5003/WeBASE-Transaction/contract/deployInfo/1/10001
```

#### 响应参数

**1）参数表**

| **序号** | **中文**     | **参数名**      | **类型** | **最大长度** | **必填** | **说明**             |
| -------- | ------------ | --------------- | -------- | ------------ | -------- | -------------------- |
| 1        | 返回码       | code            | String   |              | 是       | 返回码信息请附录1    |
| 2        | 提示信息     | message         | String   |              | 是       |                      |
| 3        | 返回数据     | data            | Object   |              |          |                      |
| 3.1      | 编号         | id              | int      |              | 是       |                      |
| 3.2      | 群组编号     | groupId         | int      |              | 是       |                      |
| 3.3      | 流水号       | uuidDeploy      | String   |              | 是       |                      |
| 3.4      | 合约bin      | contractBin     | String   |              | 是       |                      |
| 3.5      | 合约abi      | contractAbi     | String   |              | 是       |                      |
| 3.6      | 合约地址     | contractAddress | String   |              | 是       |                      |
| 3.7      | 方法参数     | funcParam       | String   |              | 是       |                      |
| 3.8      | 签名类型     | signType        | int      |              | 是       |                      |
| 3.9      | 签名用户编号 | signUserId      | int      |              | 是       |                      |
| 3.10     | 请求上链次数 | requestCount    | int      |              | 是       |                      |
| 3.11     | 处理状态     | handleStatus    | int      |              | 是       | 0-待处理，1-处理成功 |
| 3.12     | 交易hash     | transHash       | String   |              | 是       |                      |
| 3.13     | 交易回执状态 | receiptStatus   | boolean  |              | 是       | 0-异常，1-正常       |
| 3.14     | 创建时间     | gmtCreate       | Date     |              | 是       |                      |

**2）数据格式**

a.请求正常返回结果

```
{
  "code": 0,
  "message": "success",
  "data": {
    "id": 1,
    "groupId": 1,
    "uuidDeploy": "10001",
    "contractBin": "XXX",
    "contractAbi": "XXX"
    "contractAddress": "XXX",
    "funcParam": "[]",
    "signType": 0,
    "signUserId": 0,
    "requestCount": 1,
    "handleStatus": 1,
    "transHash": "XXX",
    "receiptStatus": true,
    "gmtCreate": 1574853659000
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

## 2. keystore接口 

### 2.1. 查询账户地址接口 
#### 接口描述

查询本地配置私钥对应的账户地址 。

#### 接口URL

http://localhost:5003/WeBASE-Transaction/key/address

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

无

**2）数据格式**


#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明**          |
|----------|----------|------------|----------|--------------|----------|-------------------|
| 1        | 返回码   | code       | String   |              | 是       | 返回码信息请附录1 |
| 2        | 提示信息 | message    | String   |              | 是       |                   |
| 3        | 返回数据 | data       | Object   |              |          |                  |

**2）数据格式**

a.请求正常返回结果
```
{
  "code": 0,
  "message": "success",
  "data": {
    "0xfe12013103cf85f05b0862e5ef49da4fbdbd8f99"
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

## 3. 交易接口 

### 3.1. 交易请求接口 
#### 接口描述

调用此接口发送无状态交易请求，交易服务子系统会将交易请求信息缓存到数据库，通过轮询服务向节点发送交易请求，确保交易成功上链。当部署业务流水号为空时（即不是调用交易子系统部署合约），合约地址和abi不能为空。

#### 接口URL

http://localhost:5003/WeBASE-Transaction/trans/send

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**   | **参数名**      | **类型**       | **最大长度** | **必填** | **说明**                                           |
|----------|------------|-----------------|----------------|--------------|----------|----------------------------------------------------|
| 1        | 群组编号   | groupId         | int            | 16           | 是       |                                                    |
| 2        | 交易业务流水号 | uuidStateless            | String         | 64           | 是       |                                                    |
| 3        | 部署业务流水号   | uuidDeploy        | String         | 64           | 否       |                                                    |
| 4        | 签名类型   | signType        | int            | 2            | 是       | 0-本地配置私钥签名，1-本地随机私钥签名，2-调用WeBASE-Sign签名 |
| 5        | 合约地址   | contractAddress | String         |              | 否       |                                                    |
| 6        | 合约Abi    | contractAbi     | List\<Object\> |              | 否       | JSON数组                                           |
| 7        | 调用方法名 | funcName        | String         |              | 是       |                                                    |
| 8        | 方法参数   | funcParam       | List\<Object\> |              | 否       | JSON数组                                           |
| 9 | 签名用户编号 | signUserId | int | | 否 | signType为2时必填 |

**2）数据格式**
```
{
  "groupId":1,
  "uuidStateless":"XXX",
  "uuidDeploy":"XXX",
  "signType":0,
  "contractAddress":"0xXXXXX",
  "contractAbi":[],
  "funcName":"set",
  "funcParam":["hello"],
  "signUserId":100001
}
```
#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明**          |
|----------|----------|------------|----------|--------------|----------|-------------------|
| 1        | 返回码   | code       | String   |              | 是       | 返回码信息请附录1 |
| 2        | 提示信息 | message    | String   |              | 是       |                   |
| 3        | 返回数据 | data       | Object   |              |          |                   |

**2）数据格式**

a.请求正常返回结果
```
{
  "code": 0,
  "message": "success",
  "data": null
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

### 3.2. 交易查询接口 
#### 接口描述

调用此接口同步从节点查询交易信息。当部署业务流水号为空时（即不是调用交易子系统部署合约），合约地址和abi不能为空。

#### 接口URL

http://localhost:5003/WeBASE-Transaction/trans/call

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**   | **参数名**      | **类型**       | **最大长度** | **必填** | **说明** |
|----------|------------|-----------------|----------------|--------------|----------|----------|
| 1        | 群组编号   | groupId         | int            | 16           | 是       |          |
| 2        | 部署业务流水号   | uuidDeploy        | String         | 64           | 否       |                                                   |
| 3        | 合约地址   | contractAddress | String         |              | 否       |                                                    |
| 4        | 合约Abi    | contractAbi     | List\<Object\> |              | 否       | JSON数组 |
| 5        | 调用方法名 | funcName        | String         |              | 是       |          |
| 6        | 方法参数   | funcParam       | List\<Object\> |              | 否       | JSON数组 |

**2）数据格式**
```
{
  "groupId":1,
  "uuidDeploy":"XXX",
  "contractAbi":[],
  "funcName":"get",
  "funcParam":[]
}
```
#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明**          |
|----------|----------|------------|----------|--------------|----------|-------------------|
| 1        | 返回码   | code       | String   |              | 是       | 返回码信息请附录1 |
| 2        | 提示信息 | message    | String   |              | 是       |                   |
| 3        | 返回数据 | data       | Object   |              |          |                   |

**2）数据格式**

a.请求正常返回结果
```
{
  "code": 0,
  "message": "success",
  "data": [
    "hello"
  ]
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

### 3.3. 交易请求event查询接口 
#### 接口描述

根据群组编号和交易业务流水号查询交易请求的event信息。

#### 接口URL

http://localhost:5003/WeBASE-Transaction/trans/event/{groupId}/{uuidStateless}

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**   | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
|----------|------------|------------|----------|--------------|----------|----------|
| 1        | 群组编号   | groupId    | int      | 16           | 是       |          |
| 2        | 交易业务流水号 | uuidStateless       | String   | 64           | 是       |          |

**2）数据格式**

```
http://127.0.0.1:5003/WeBASE-Transaction/trans/event/1/20001
```

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明**          |
|----------|----------|------------|----------|--------------|----------|-------------------|
| 1        | 返回码   | code       | String   |              | 是       | 返回码信息请附录1 |
| 2        | 提示信息 | message    | String   |              | 是       |                   |
| 3        | 返回数据 | data       | Object   |              |          |                  |

**2）数据格式**

a.请求正常返回结果
```
{
  "code": 0,
  "message": "success",
  "data": {
    "setEvent": [
        "test"
    ],
    "setEvent1": [
        "test"
    ]
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

### 3.4. 交易请求output查询接口 
#### 接口描述

根据群组编号和交易业务流水号查询交易请求的output信息。

#### 接口URL

http://localhost:5003/WeBASE-Transaction/trans/output/{groupId}/{uuidStateless}

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**   | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
|----------|------------|------------|----------|--------------|----------|----------|
| 1        | 群组编号   | groupId    | int      | 16           | 是       |          |
| 2        | 交易业务流水号 | uuidStateless       | String   | 64           | 是       |          |

**2）数据格式**

```
http://127.0.0.1:5003/WeBASE-Transaction/trans/output/1/20001
```

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明**          |
|----------|----------|------------|----------|--------------|----------|-------------------|
| 1        | 返回码   | code       | String   |              | 是       | 返回码信息请附录1 |
| 2        | 提示信息 | message    | String   |              | 是       |                   |
| 3        | 返回数据 | data       | Object   |              |          |                  |

**2）数据格式**

a.请求正常返回结果
```
{
  "code": 0,
  "message": "success",
  "data": [
    "hello!"
  ]
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

### 3.5. 交易信息查询接口 

#### 接口描述

根据群组编号和交易业务流水号查询交易信息。

#### 接口URL

http://localhost:5003/WeBASE-Transaction/trans/transInfo/{groupId}/{uuidStateless}

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**    | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------------- | ------------- | -------- | ------------ | -------- | -------- |
| 1        | 群组编号       | groupId       | int      | 16           | 是       |          |
| 2        | 交易业务流水号 | uuidStateless | String   | 64           | 是       |          |

**2）数据格式**

```
http://127.0.0.1:5003/WeBASE-Transaction/trans/transInfo/1/20001
```

#### 响应参数

**1）参数表**

| **序号** | **中文**     | **参数名**      | **类型** | **最大长度** | **必填** | **说明**             |
| -------- | ------------ | --------------- | -------- | ------------ | -------- | -------------------- |
| 1        | 返回码       | code            | String   |              | 是       | 返回码信息请附录1    |
| 2        | 提示信息     | message         | String   |              | 是       |                      |
| 3        | 返回数据     | data            | Object   |              |          |                      |
| 3.1      | 编号         | id              | int      |              | 是       |                      |
| 3.2      | 群组编号     | groupId         | int      |              | 是       |                      |
| 3.3      | 交易流水号   | uuidStateless   | String   |              | 是       |                      |
| 3.4      | 部署流水号   | uuidDeploy      | String   |              | 是       |                      |
| 3.5      | 合约abi      | contractAbi     | String   |              | 是       |                      |
| 3.6      | 合约地址     | contractAddress | String   |              | 是       |                      |
| 3.7      | 方法名       | funcName        | String   |              | 是       |                      |
| 3.8      | 方法参数     | funcParam       | String   |              | 是       |                      |
| 3.9      | 签名类型     | signType        | int      |              | 是       |                      |
| 3.10     | 签名用户编号 | signUserId      | int      |              | 是       |                      |
| 3.11     | 请求上链次数 | requestCount    | int      |              | 是       |                      |
| 3.12     | 处理状态     | handleStatus    | int      |              | 是       | 0-待处理，1-处理成功 |
| 3.13     | 交易hash     | transHash       | String   |              | 是       |                      |
| 3.14     | 交易返回原文 | transOutput     | String   |              | 是       |                      |
| 3.15     | 交易回执状态 | receiptStatus   | boolean  |              | 是       | 0-异常，1-正常       |
| 3.16     | 创建时间     | gmtCreate       | Date     |              | 是       |                      |

**2）数据格式**

a.请求正常返回结果

```
{
  "code": 0,
  "message": "success",
  "data": {
    "id": 1,
    "groupId": 1,
    "uuidStateless": "20001",
    "uuidDeploy": "10001",
    "contractAbi": "XXX"
	"contractAddress": "XXX",
    "funcName": "set",
    "funcParam": "XXX",
    "signType": 0,
    "signUserId": 0,
    "requestCount": 1,
    "handleStatus": 1,
    "transHash": "XXX",
    "transOutput": "0x",
    "receiptStatus": true,
    "gmtCreate": 1574854118000
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

## 4. 其他接口

### 4.1. 获取EncryptType接口 
#### 接口描述

返回Transaction服务中web3sdk所使用的`encryptType`，0：标准，1：国密

#### 接口URL

http://localhost:5003/WeBASE-Transaction/encrypt

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**   | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
|----------|------------|------------|----------|--------------|----------|----------|
| 1        | -          | -         | -       | -           | -       |          |

**2）数据格式**

```
http://127.0.0.1:5003/WeBASE-Transaction/encrypt
```

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明**          |
|----------|----------|------------|----------|--------------|----------|-------------------|
| 1        | 返回码   | code       | String   |              | 是       | 返回码信息请附录1 |
| 2        | 提示信息 | message    | String   |              | 是       |                   |
| 3        | 返回数据 | data       | Integer   |              |          |  encryptType: 0:标准, 1:国密  |

**2）数据格式**

a.请求正常返回结果
```
{
  "code": 0,
  "message": "success",
  "data": 0
}
```

## 附录 

### 1. 返回码信息列表

| Code   | message                                                      | 描述                                        |
| ------ | ------------------------------------------------------------ | ------------------------------------------- |
| 0      | success                                                      | 正常                                        |
| 103001 | system error                                                 | 系统异常                                    |
| 103002 | param valid fail                                             | 参数校验异常                                |
| 203001 | group id cannot be empty                                     | 群组编号不能为空                            |
| 203002 | uuid cannot be empty                                         | 业务流水号不能为空                          |
| 203003 | sign type cannot be empty                                    | 签名类型不能为空                            |
| 203004 | contract bin cannot be empty                                 | 合约bin不能为空                             |
| 203005 | contract abi cannot be empty                                 | 合约abi不能为空                             |
| 203006 | contract address cannot be empty                             | 合约地址不能为空                            |
| 203007 | function name cannot be empty                                | 方法名不能为空                              |
| 303001 | uuid is already exists                                       | 业务流水号已经存在                          |
| 303002 | get sign data from sign service error                        | 调用签名服务签名错误                        |
| 303003 | contract funcParam is error                                  | 合约方法参数错误                            |
| 303004 | sign type is not exists                                      | 签名类型不存在                              |
| 303005 | contract abi is empty                                        | 合约abi不存在                               |
| 303006 | request function can not be constant                         | 交易上链不能为constant方法                  |
| 303007 | query function must be constant                              | 查询方法必须是constant                      |
| 303008 | query data from chain failed                                 | 查询链上数据失败                            |
| 303009 | file cannot be empty                                         | 文件不能为空                                |
| 303010 | it is not a zip file                                         | 文件不是zip格式                             |
| 303011 | contract has not been deployed                               | 合约还没有部署                              |
| 303012 | contract compile error                                       | 合约编译错误                                |
| 303013 | node request failed                                          | 节点请求失败                                |
| 303014 | there is not event                                           | 不存在event                                 |
| 303015 | trans has not been sent to the chain                         | 交易还没有上链                              |
| 303016 | if deploy uuid is empty, contract address and contract abi cannot be empty | 部署业务流水号为空时，合约地址和abi不能为空 |
| 303017 | trans output is empty                                        | 交易返回值为空                              |
| 303018 | trans is not exists                                          | 交易不存在                                  |
| 303019 | request group id has not been configured                     | 请求的群组编号未配置                        |
| 303020 | sign user id cannot be empty while sign type is 2            | 签名类型为2是签名用户编号不能为空           |
| 303021 | sign user id check failed                                    | 签名用户编号校验失败                        |
| 303022 | function is not exists                                       | 合约方法不存在                              |
| 303023 | data is not exists                                           | 数据不存在                                  |