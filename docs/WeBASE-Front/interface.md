
# 接口说明

## 1. 合约接口
### 1.1. 发送abi接口

#### 接口描述

> 根据abi内容判断合约是否已部署，未部署则生成对应abi文件

#### 接口URL

**http://localhost:5002/WeBASE-Front/contract/abiInfo**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**   | **类型**       | **最大长度** | **必填** | **说明**                           |
| -------- | -------- | ------------ | -------------- | ------------ | -------- | -------------- |
| 1        | 所属群组 | groupId | Integer         |              | 是        |                      |
| 2        | 合约名称 | contractName | String         |              | 是        |                      |
| 3        | 合约地址 | address      | String         |              | 是       |                        |
| 4        | 合约abi  | abiInfo      | List   |              | 是       | abi文件里面的内容，是一个JSONArray |
| 5        | 合约bin      | contractBin  | String         |              | 是       |  合约编译的runtime-bytecode(runtime-bin)       |


**2）数据格式**
```
{
    "groupId": 1,
    "contractName": "HelloWorld",
    "address": "0x31b26e43651e9371c88af3d36c14cfd938baf4fd",
    "contractBin": "608060405234801561001057600080fd5b5060405161031d38038061031d8339810180",
    "abiInfo": [
        {"inputs": [{"type": "string", "name": "n"}], "constant": false, "name": "set",
        "outputs": [], "payable": false, "type": "function"},
        {"inputs": [], "constant": true, "name": "get", "outputs": [{"type": "string",
        "name": ""}], "payable": false, "type": "function"},
        {"inputs": [], "constant": false, "name": "HelloWorld", "outputs": [],
        "payable": false, "type": "function"}
    ]
}
```
#### 响应参数

**1）数据格式** 

无

### 1.2. 合约部署接口

#### 接口描述

> 将合约部署到当前节点

构造方法参数（funcParam）为JSON数组，多个参数以逗号分隔（参数为数组时同理），示例：

```
constructor(string s) -> ["aa,bb\"cc"]  // 双引号要转义
constructor(uint n,bool b) -> [1,true]
constructor(bytes b,address[] a) -> ["0x1a",["0x7939E26070BE44E6c4Fc759Ce55C6C8b166d94BE","0xce867fD9afa64175bb50A4Aa0c17fC7C4A3C67D9"]]
```

#### 接口URL

**http://localhost:5002/WeBASE-Front/contract/deploy**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**   | **类型** | **最大长度** | **必填** | **说明**             |
| -------- | ------------ | ------------ | -------- | ------------ | -------- | -------------------- |
| 1        | 所属群组     | groupId      | int      |              | 是       |                      |
| 2        | 用户地址     | user         | String   |              | 是       | 用户地址，可通过`/privateKey`接口创建 |
| 3        | 合约名称     | contractName | String   |              | 是       |                      |
| 4        | 合约abi      | abiInfo      | List     |              | 是       |  合约编译后生成的abi文件内容  |
| 5        | 合约bin      | bytecodeBin  | String   |              | 是       |  合约编译的bytecode(bin)，用于部署合约|
| 6        | 构造函数参数 | funcParam    | List     |              | 否       |    合约构造函数所需参数 |
| 7        | 合约版本     | version     | String    |             |   否       |  用于指定合约在CNS中的版本    |

**2）数据格式**

```
{
    "user":"0x2db346f9d24324a4b0eac7fb7f3379a2422704db",
    "contractName":"HelloWorld",
    "abiInfo": [],
    "bytecodeBin":"",
    "funcParam":[]
}
```

#### 响应参数

**1）数据格式**

```
{
    "0x60aac015d5d41adc74217419ea77815ecb9a2192"
}
```

### 1.3. 合约部署接口（结合WeBASE-Sign）

#### 接口描述

> 将合约部署到当前节点。此接口需结合WeBASE-Sign使用，通过调用WeBASE-Sign服务的签名接口让相关用户对数据进行签名，拿回签名数据再发送上链。需要调用此接口时，工程配置文件application.yml中的配置"keyServer"需配置WeBASE-Sign服务的ip和端口，并保证WeBASE-Sign服务正常和存在相关用户。


构造方法参数（funcParam）为JSON数组，多个参数以逗号分隔（参数为数组时同理），示例：

```
constructor(string s) -> ["aa,bb\"cc"]  // 双引号要转义
constructor(uint n,bool b) -> [1,true]
constructor(bytes b,address[] a) -> ["0x1a",["0x7939E26070BE44E6c4Fc759Ce55C6C8b166d94BE","0xce867fD9afa64175bb50A4Aa0c17fC7C4A3C67D9"]]
```


#### 接口URL

**http://localhost:5002/WeBASE-Front/contract/deployWithSign**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**   | **类型** | **最大长度** | **必填** | **说明**             |
| -------- | ------------ | ------------ | -------- | ------------ | -------- | -------------------- |
| 1        | 所属群组     | groupId      | int      |              | 是       |                      |
| 2        | 用户编号     | signUserId    | String   |     64         | 是       | WeBASE-Sign中的用户编号，通过webase-sign创建私钥获取 |
| 3        | 合约名称     | contractName | String   |              | 是       |                      |
| 4        | 合约abi      | abiInfo      | List     |              | 是       |  合约编译后生成的abi文件内容  |
| 5        | 合约bin      | bytecodeBin  | String   |              | 是       |  合约编译的bytecode(bin)，用于部署合约|
| 6        | 构造函数参数 | funcParam    | List     |              | 否       |   合约构造函数所需参数                   |
| 7        | 合约版本     | version     | String    |             |   否       |  用于指定合约在CNS中的版本    |

**2）数据格式**

```
{
    "groupId":1,
    "signUserId": "458ecc77a08c486087a3dcbc7ab5a9c3",
    "bytecodeBin":"xxx",
    "abiInfo": [],
    "funcParam":[]
}
```

示例：

```
curl -X POST "http://localhost:5002/WeBASE-Front/contract/deployWithSign" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"contractAbi\": [ { \"outputs\": [], \"constant\": false, \"payable\": false, \"inputs\": [ { \"name\": \"n\", \"type\": \"string\" } ], \"name\": \"set\", \"stateMutability\": \"nonpayable\", \"type\": \"function\" }, { \"outputs\": [ { \"name\": \"\", \"type\": \"string\" } ], \"constant\": true, \"payable\": false, \"inputs\": [], \"name\": \"get\", \"stateMutability\": \"view\", \"type\": \"function\" }, { \"payable\": false, \"inputs\": [], \"stateMutability\": \"nonpayable\", \"type\": \"constructor\" }, { \"inputs\": [ { \"indexed\": false, \"name\": \"name\", \"type\": \"string\" } ], \"name\": \"nameEvent\", \"anonymous\": false, \"type\": \"event\" } ], \"bytecodeBin\": \"608060405234801561001057600080fd5b506040805190810160405280600681526020017f68656c6c6f2100000000000000000000000000000000000000000000000000008152506000908051906020019061005c92919061011c565b507f9645e7fb5eec05c0f156d4901a10663561199c6dd0401214a0b833fe0022d899600060405180806020018281038252838181546001816001161561010002031660029004815260200191508054600181600116156101000203166002900480156101095780601f106100de57610100808354040283529160200191610109565b820191906000526020600020905b8154815290600101906020018083116100ec57829003601f168201915b50509250505060405180910390a16101c1565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061015d57805160ff191683800117855561018b565b8280016001018555821561018b579182015b8281111561018a57825182559160200191906001019061016f565b5b509050610198919061019c565b5090565b6101be91905b808211156101ba5760008160009055506001016101a2565b5090565b90565b610391806101d06000396000f30060806040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff1680634ed3885e146100515780636d4ce63c146100ba575b600080fd5b34801561005d57600080fd5b506100b8600480360381019080803590602001908201803590602001908080601f016020809104026020016040519081016040528093929190818152602001838380828437820191505050505050919291929050505061014a565b005b3480156100c657600080fd5b506100cf61021e565b6040518080602001828103825283818151815260200191508051906020019080838360005b8381101561010f5780820151818401526020810190506100f4565b50505050905090810190601f16801561013c5780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b80600090805190602001906101609291906102c0565b507f9645e7fb5eec05c0f156d4901a10663561199c6dd0401214a0b833fe0022d8996000604051808060200182810382528381815460018160011615610100020316600290048152602001915080546001816001161561010002031660029004801561020d5780601f106101e25761010080835404028352916020019161020d565b820191906000526020600020905b8154815290600101906020018083116101f057829003601f168201915b50509250505060405180910390a150565b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156102b65780601f1061028b576101008083540402835291602001916102b6565b820191906000526020600020905b81548152906001019060200180831161029957829003601f168201915b5050505050905090565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061030157805160ff191683800117855561032f565b8280016001018555821561032f579182015b8281111561032e578251825591602001919060010190610313565b5b50905061033c9190610340565b5090565b61036291905b8082111561035e576000816000905550600101610346565b5090565b905600a165627a7a723058201be6d6e6936e66c64b93771f9bd7ee708553fb6faf82e0273336fac2b1c6d83d0029\", \"funcParam\": [ ], \"groupId\": 1, \"signUserId\": "458ecc77a08c486087a3dcbc7ab5a9c3"}"
```

#### 响应参数

**1）数据格式**

```
{
    "0x7571ff73f1a37ca07f678aebc4d8213e7ef5c266"
}
```

### 1.4. cns接口 


#### 接口描述

> 根据合约名及版本号查询合约地址

#### 接口URL

**http://localhost:5002/WeBASE-Front/contract/cns?groupId={groupId}&name={name}&version={version}**

#### 调用方法

HTTP GET

#### 请求参数

1. **参数表**

| **序号** | **中文**     | **参数名**   | **类型**       | **最大长度** | **必填** | **说明** |
| -------- | ------------ | ------------ | -------------- | ------------ | -------- | -------- |
| 1        | 所属群组     | groupId       | int            |            | 是       |          |
| 2        | 合约名称     | name       | String         |              | 是       |          |
| 3        | 合约版本     | version      | String |              | 是       |          |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/contract/cns?groupId=1&name=HelloWorld&version=2
```

#### 响应参

**1）数据格式**
```
{
    "0x31b26e43651e9371c88af3d36c14cfd938baf4fd"
}
```
### 1.5. java转译接口


#### 接口描述

> 将合约abi转成java文件

#### 接口URL

**http://localhost:5002/WeBASE-Front/contract/compile-java**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**   | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ------------ | -------- | ------------ | -------- | -------- |
| 1        | 合约名称     | contractName | String         |              | 是       |          |
| 2        | 合约abi      | abiInfo      | List |              | 是       |          |
| 3        | 合约bin      | contractBin  | String         |              | 是       |  合约编译的runtime-bytecode(runtime-bin)       |
| 4        | 所在目录      | packageName  | String         |              | 是       | 生成java所在的包名 |

**2）数据格式**

```
{
    "contractName": "HeHe",
    "abiInfo": [],
    "contractBin": "60806040526004361061004c576000357c0100000000000000000000029",
    "packageName": "com.webank"
}
```

#### 响应参数

**1）数据格式**
java文件

### 1.6. 保存合约接口

#### 接口描述

> 支持前置的控制台保存合约信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/contract/save**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**   | **类型**       | **最大长度** | **必填** | **说明** |
| -------- | ------------ | ------------ | -------------- | ------------ | -------- | -------- |
| 1        | 所属群组     | groupId       | int            |            | 是       |          |
| 2        | 合约编号     | contractId    | int          |            | 否       |  |
| 3        | 合约名称     | contractName | String         |              | 是       |          |
| 4        | 合约所在目录  | contractPath | String         |              | 是       |          |
| 5        | 合约abi      | contractAbi      | String |              | 否       |          |
| 6        | 合约bytecodeBin      | bytecodeBin  | String         |              | 否       |  合约编译的bytecode(bin)，用于部署合约        |
| 7        | 合约bin | contractBin    | String|              | 否       |   合约编译的runtime-bytecode(runtime-bin)，用于交易解析       |
| 8        | 合约源码 | contractSource    | String|              | 否       |          |

**2）数据格式**
```
{
    "groupId": "1",
    "contractName": "HeHe",
    "contractPath": "/",
    "contractSource": "cHJhZ21hIHNvbGlkaXR5IF4wLjQuMjsn0=",
    "contractAbi": “[]”
    "contractBin": "60806040526004361061004c576000357c0100000000000000000000000029",
    "bytecodeBin": "6080604052348015610010572269b80029",
    "contractId": 1
}
```

#### 响应参数
**1）参数表**

| **序号** | **中文** | **参数名**   | **类型**       | **最大长度** | **必填** | **说明**                           |
| -------- | -------- | ------------ | -------------- | ------------ | -------- | -------------- |
| 1        | 合约编号 | id            | Integer         |              | 是        |           |
| 2        | 所在目录  | contractPath | String         |     | 是       | |
| 3        | 合约名称 | contractName | String         |              | 是        |   |
| 4        | 合约状态 | contractStatus | Integer         |       | 是       |1未部署，2已部署  |
| 5        | 所属群组 | groupId | Integer         |              | 是        |                      |
| 6        | 合约源码 | contractSource | String         |      | 否       |           |
| 7        | 合约abi | contractAbi | String         |      | 否       |   合约编译后生成的abi文件内容 |
| 8        | 合约bin | contractBin | String         |      | 否       |  合约编译的runtime-bytecode(runtime-bin)，用于交易解析         |
| 9        | 合约bytecodeBin | bytecodeBin | String         |      | 否       |  合约编译的bytecode(bin)，用于部署合约        |
| 10        | 合约地址 | contractAddress | String         |      | 否       |           |
| 11        | 部署时间 | deployTime | String         |      | 否       |           |
| 12        | 修改时间 | modifyTime | String         |      | 是       |           |
| 13        | 创建时间 | createTime | String         |      | 是       |           |
| 14        | 备注 | description | String         |      | 否       |           |

**2）数据格式**
```
{
    "id": 1,
    "contractPath": "/",
    "contractName": "HeHe",
    "contractStatus": 1,
    "groupId": 1,
    "contractSource": "cHJhZ21hIHNvbGlkaXR5IF4wLjQuMjsKCmICB9Cn0=",
    "contractAbi": "[{\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"}]",
    "contractBin": "60806040526004361061004c5760003569b80029",
    "bytecodeBin": "608060405234801561001057600080fd5b506029",
    "contractAddress": null,
    "deployTime": null,
    "description": null,
    "createTime": "2019-06-10 11:48:51",
    "modifyTime": "2019-06-10 15:31:29"
}
```

### 1.7. 删除合约接口

#### 接口描述

> 支持前置的控制台通过群组编号和合约编号删除未部署的合约信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/contract/{groupId}/{contractId}**

#### 调用方法

HTTP DELETE

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**   | **类型**       | **最大长度** | **必填** | **说明** |
| -------- | ------------ | ------------ | -------------- | ------------ | -------- | -------- |
| 1        | 所属群组     | groupId       | int            |            | 是       |          |
| 2        | 合约编号     | contractId    | int          |            | 是       |  |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/contract/1/1
```

#### 响应参数
**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **必填** | **说明**              |
| -------- | -------- | ---------- | -------- | -------- | --------------------- |
| 1        | 返回码   | code       | String   | 是       | 返回码信息请参看附录1 |
| 2        | 提示信息 | message    | String   | 是       |                       |
| 3        | 返回数据 | data       | Object   |  否        |                       |

**2）数据格式**
```
{
    "code": 0,
    "message": "success",
    "data": null
}
```


### 1.8. 分页查询合约列表

#### 接口描述

> 支持前置的控制台分页查询合约列表

#### 接口URL

**http://localhost:5002/WeBASE-Front/contract/contractList**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**   | **类型**       | **最大长度** | **必填** | **说明** |
| -------- | ------------ | ------------ | -------------- | ------------ | -------- | -------- |
| 1        | 所属群组 | groupId | Integer         |              | 是        |                      |
| 2        | 合约名称 | contractName | String         |              | 否        |   |
| 3        | 合约状态 | contractStatus | Integer         |       | 否       |1未部署，2已部署  |
| 4        | 合约地址 | contractAddress | String         |      | 否       |           |
| 5        | 当前页码 | pageNumber | Integer         |       | 是       | 从0开始 |
| 6        | 每页记录数 | pageSize | Integer         |       | 是       |  |


**2）数据格式**
```
{
    "groupId": "1",
    "pageNumber": 0,
    "pageSize": 10,
    "contractName": "",
    "contractAddress": "",
    "contractStatus": 2
}
```

#### 响应参数
**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **必填** | **说明**              |
| -------- | -------- | ---------- | -------- | -------- | --------------------- |
| 1        | 返回码   | code       | String   | 是       | 返回码信息请参看附录1 |
| 2        | 提示信息 | message    | String   | 是       |                       |
| 3        | 返回数据 | data       | Object   |  否        |                       |
| 3.1        | 合约编号 | id            | Integer                      | 是        |           |
| 3.2        | 所在目录  | contractPath | String             | 是       | |
| 3.3        | 合约名称 | contractName | String                    | 是        |   |
| 3.4        | 合约状态 | contractStatus | Integer             | 是       |1未部署，2已部署  |
| 3.5        | 所属群组 | groupId | Integer                  | 是        |                      |
| 3.6        | 合约源码 | contractSource | String            | 否       |           |
| 3.7        | 合约abi | contractAbi | String          | 否       |   合约编译后生成的abi文件内容  |
| 3.8        | 合约bin | contractBin | String            | 否       |  合约编译的runtime-bytecode(runtime-bin)，用于交易解析         |
| 3.9        | bytecodeBin | bytecodeBin | String           | 否       |  合约编译的bytecode(bin)，用于部署合约     |
| 3.10        | 合约地址 | contractAddress | String           | 否       |           |
| 3.11        | 部署时间 | deployTime | String            | 否       |           |
| 3.12        | 修改时间 | modifyTime | String            | 是       |           |
| 3.13        | 创建时间 | createTime | String             | 是       |           |
| 3.14        | 备注 | description | String           | 否       |           |


**2）数据格式**
```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "id": 2,
            "contractPath": "/",
            "contractName": "HeHe",
            "contractStatus": 1,
            "groupId": 1,
            "contractSource": "cHJhZ21hIHNvbGlkaXR5IICB9Cn0=",
            "contractAbi": "",
            "contractBin": "",
            "bytecodeBin": null,
            "contractAddress": null,
            "deployTime": null,
            "description": null,
            "createTime": "2019-06-10 16:42:50",
            "modifyTime": "2019-06-10 16:42:52"
        }
    ],
    "totalCount": 1
}
```

### 1.9. 合约是否被修改接口

#### 接口描述

> 校验已部署的合约是否被修改了，返回true或false

#### 接口URL

**http://localhost:5002/WeBASE-Front/contract/ifChanged/{groupId}/{contractId}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 所属群组 | groupId    | int      |              | 是       |          |
| 2        | 合约编号 | contractId | int      |              | 是       |          |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/contract/ifChanged/1/10
```

#### 响应参数

**1）数据格式**

```
true
```

### 1.10. 后台编译合约

#### 接口描述

> 通过后台的solcJ对solidity合约进行编译，返回合约的BIN与ABI

#### 接口URL

**http://localhost:5002/WeBASE-Front/contract/contractCompile**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**   | **类型**       | **最大长度** | **必填** | **说明** |
| -------- | ------------ | ------------ | -------------- | ------------ | -------- | -------- |
| 1        | 合约名称     | contractName     | String            |            | 是       |          |
| 2        | 合约源码     | solidityBase64    | String          |            | 是       |    经过Base64编码的合约源码内容 |

**2）数据格式**
```
{
    "contractName": "HelloWorld",
    "solidityBase64": "cHJhZ21hIHNvbGlkaXR5IF4wLjQuMjsKCmICB9Cn0"
}
```

#### 响应参数
**1）参数表**

| **序号** | **中文** | **参数名**   | **类型**       | **最大长度** | **必填** | **说明**                           |
| -------- | -------- | ------------ | -------------- | ------------ | -------- | -------------- |
| 1        | 合约名称 | contractName        | String         |              | 是        |           |
| 3        | 合约bin  | bytecodeBin | String         |     | 是       | |   合约编译的bytecode(bin)，用于部署合约
| 4        | 合约abi | contractAbi | String         |              | 是        |   |

**2）数据格式**
```
{
    "contractName": "HeHe",
    "contractSource": "cHJhZ21hIHNvbGlkaXR5IF4wLjQuMjsKCmICB9Cn0=",
    "bytecodeBin": "608060405234801561001057600080fd5b506029",
    "contractAbi": "[{\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"}]",
}
```


## 2. 密钥接口

### 2.1. 获取公私钥接口

#### 接口描述

> 通过调用此接口获取公私钥对和对应账户信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/privateKey?type={type}&userName={userName}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**   | **类型**       | **最大长度** | **必填** | **说明** |
| -------- | ------------ | ------------ | -------------- | ------------ | -------- | -------- |
| 1 | 私钥类型 | type | int | | 否 | 0-本地用户；1-本地随机；2-外部用户 |
| 2        | 用户名 | userName | String        |             | 否   | 类型为本地用户时必填 |

**2）数据格式** 

```
http://localhost:5002/WeBASE-Front/privateKey?type=0&userName=test
```

#### 响应参数

**1）数据格式**
本地用户时：
```
{
  "address": "0x2007e1430f41f75c850464307c0994472bd92ee0",
  "publicKey": "0x9bd35211855f9f8de22d8a8da7f30d35d62ab2c3d36ea5162008fcbb9faff4d83809f7033deb20049bf51e081105076ec7a09a847f852530f81e978b1eda0392",
  "privateKey": "42caa160cadcb635381b980ddd981171c862d3105981fe92d6db330f30615f21",
  "userName": "test",
  "type": 0,
  "signUserId": null, // 本地用户则为空
  "appId": null // 本地用户则为空
}
```

外部用户时（来自WeBASE-Sign）：
```
{
  "address": "0x2007e1430f41f75c850464307c0994472bd92ee0",
  "publicKey": "0x9bd35211855f9f8de22d8a8da7f30d35d62ab2c3d36ea5162008fcbb9faff4d83809f7033deb20049bf51e081105076ec7a09a847f852530f81e978b1eda0392",
  "userName": "test",
  "type": 0,
  "signUserId": "458ecc77a08c486087a3dcbc7ab5a9c3",
  "appId": "458ecc77a08c486087a3dcbc7ab5a9c3"
}
```
### 2.2. 导入私钥接口

#### 接口描述

> 导入私钥信息，并返回对应的公钥及用户地址

#### 接口URL

**http://localhost:5002/WeBASE-Front/privateKey/import?privateKey={privateKey}&userName={userName}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 私钥信息 | privateKey | String   |              | 是       |          |
| 2        | 用户名   | userName   | String   |              | 是       |          |

**2）数据格式** 

```
http://localhost:5002/WeBASE-Front/privateKey/import?privateKey=8cf98bd0f37fb0984ab43ed6fc2dcdf58811522af7e4a3bedbe84636a79a501c&userName=lili
```

#### 响应参数

**1）数据格式**

```
{
  "address": "0x2e8ff65fb1b2ce5b0c9476b8f8beb221445f42ee",
  "publicKey": "0x1c7073dc185af0644464b178da932846666a858bc492450e9e94c77203428ed54e2ce45679dbb36bfed714dbe055a215dc1aaf4a75faeddce6a62b39c0158e1e",
  "privateKey": "8cf98bd0f37fb0984ab43ed6fc2dcdf58811522af7e4a3bedbe84636a79a501c",
  "userName": "lili",
  "type": 0
}
```

### 2.3. 获取本地公私钥列表接口

#### 接口描述

> 返回本地公私钥信息列表

#### 接口URL

**http://localhost:5002/WeBASE-Front/privateKey/localKeyStores**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

无

**2）数据格式** 

```
http://localhost:5002/WeBASE-Front/privateKey/localKeyStores
```

#### 响应参数

**1）数据格式**

```
[
  {
    "address": "0x2007e1430f41f75c850464307c0994472bd92ee0",
    "publicKey": "0x9bd35211855f9f8de22d8a8da7f30d35d62ab2c3d36ea5162008fcbb9faff4d83809f7033deb20049bf51e081105076ec7a09a847f852530f81e978b1eda0392",
    "privateKey": "42caa160cadcb635381b980ddd981171c862d3105981fe92d6db330f30615f21",
    "userName": "test",
    "type": 0
  },
  {
    "address": "0x2e8ff65fb1b2ce5b0c9476b8f8beb221445f42ee",
    "publicKey": "0x1c7073dc185af0644464b178da932846666a858bc492450e9e94c77203428ed54e2ce45679dbb36bfed714dbe055a215dc1aaf4a75faeddce6a62b39c0158e1e",
    "privateKey": "8cf98bd0f37fb0984ab43ed6fc2dcdf58811522af7e4a3bedbe84636a79a501c",
    "userName": "lili",
    "type": 0
  }
]
```

### 2.4. 删除公私钥接口

#### 接口描述

> 支持前置的控制台通过用户地址删除公私钥信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/privateKey/{address}**

#### 调用方法

HTTP DELETE

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 用户地址 | address    | String   |              | 是       |          |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/privateKey/0x2e8ff65fb1b2ce5b0c9476b8f8beb221445f42ee
```

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **必填** | **说明**              |
| -------- | -------- | ---------- | -------- | -------- | --------------------- |
| 1        | 返回码   | code       | String   | 是       | 返回码信息请参看附录1 |
| 2        | 提示信息 | message    | String   | 是       |                       |
| 3        | 返回数据 | data       | Object   | 否       |                       |

**2）数据格式**

```
{
    "code": 0,
    "message": "success",
    "data": null
}
```


### 2.5. 导入.pem私钥用户

#### 接口描述

导入.pem格式的私钥

#### 接口URL

**http://localhost:5002/WeBASE-Front/privateKey/importPem**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | pem文件内容 | pemContent    | String   |              | 是       | 必须以`-----BEGIN PRIVATE KEY-----\n`开头，以`\n-----END PRIVATE KEY-----\n`结尾的格式         |
| 2        | 用户名 | userName    | String   |              | 是       |          |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/privateKey/importPem
```

```
{
    "pemContent":"-----BEGIN PRIVATE KEY-----\nMIGEAgEAMBAGByqGSM49AgEGBSuBBAAKBG0wawIBAQQgC8TbvFSMA9y3CghFt51/\nXmExewlioX99veYHOV7dTvOhRANCAASZtMhCTcaedNP+H7iljbTIqXOFM6qm5aVs\nfM/yuDBK2MRfFbfnOYVTNKyOSnmkY+xBfCR8Q86wcsQm9NZpkmFK\n-----END PRIVATE KEY-----\n",
    "userName":"test222"
}
```

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **必填** | **说明**              |
| -------- | -------- | ---------- | -------- | -------- | --------------------- |
| 1        | 返回码   | code       | String   | 是       | 返回码信息请参看附录1 |
| 2        | 提示信息 | message    | String   | 是       |                       |
| 3        | 返回数据 | data       | Object   | 否       |                       |

**2）数据格式**

```
{
    "code": 0,
    "message": "success",
    "data": null
}
```



### 2.6. 导入.p12私钥用户

#### 接口描述

导入.p12格式的私钥

#### 接口URL

**http://localhost:5002/WeBASE-Front/privateKey/importP12**

#### 调用方法

HTTP POST | Content-type: form-data

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | p12文件 | p12File    | MultipartFile   |              | 是       |          |
| 2        | p12文件密码 | p12Password    | String   |              | 否       | 缺省时默认为""，即空密码；p12无密码时，可传入空值或不传；不包含中文          |
| 2        | 用户名 | userName    | String   |              | 是       |          |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/privateKey/importP12
```

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **必填** | **说明**              |
| -------- | -------- | ---------- | -------- | -------- | --------------------- |
| 1        | 返回码   | code       | String   | 是       | 返回码信息请参看附录1 |
| 2        | 提示信息 | message    | String   | 是       |                       |
| 3        | 返回数据 | data       | Object   | 否       |                       |

**2）数据格式**

```
{
    "code": 0,
    "message": "success",
    "data": null
}
```


### 2.7. 导入私钥到WeBASE-Sign

#### 接口描述

导入私钥到WeBASE-Sign，其中privateKey经过Base64加密

#### 接口URL

**http://localhost:5002/WeBASE-Front/privateKey/importWithSign**

#### 调用方法

HTTP POST | Content-type: form-data

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 用户编号 | signUserId    | String   |   64           | 是       |          |
| 2        | 应用编号 | appId    | String   |     64         | 是       |           |
| 2        | 私钥 | privateKey    | String   |              | 是       |  经过Base64加密后的内容        |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/privateKey/importWithSign
```

```
{
    "privateKey": "OGFmNWIzMzNmYTc3MGFhY2UwNjdjYTY3ZDRmMzE4MzU4OWRmOThkMjVjYzEzZGFlMGJmODhkYjhlYzVhMDcxYw==",
    "appId": "app_001",
    "signUserId": "user_001"
}
```

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **必填** | **说明**              |
| -------- | -------- | ---------- | -------- | -------- | --------------------- |
| 1        | 返回码   | code       | String   | 是       | 返回码信息请参看附录1 |
| 2        | 提示信息 | message    | String   | 是       |                       |
| 3        | 返回数据 | data       | Object   | 否       |                       |

**2）数据格式**

```
{
    "code": 0,
    "message": "success",
    "data": null
}
```



## 3. web3接口

### 3.1. 获取块高接口 


#### 接口描述

> 获取节点最新块高

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/blockNumber**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**   | **类型**       | **最大长度** | **必填** | **说明** |
| -------- | ------------ | ------------ | -------------- | ------------ | -------- | -------- |
| 1        | 群组编号 | groupId | int      |             | 是        |                      |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/blockNumbe
```

#### 响应参数
**1）数据格式**
```
{
    8346
}
```


### 3.2. 根据块高获取块信息接口 


#### 接口描述

> 通过块高获取块信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/1/web3/blockByNumber/{blockNumber}**

#### 调用方法

HTTP GET

#### 请求参数

1. **参数表**

| **序号** | **中文** | **参数名**  | **类型**   | **最大长度** | **必填** | **说明** |
| -------- | -------- | ----------- | ---------- | ------------ | -------- | -------- |
| 1        | 群组编号 | groupId     | int        |              | 是       |          |
| 2        | 块高     | blockNumber | BigInteger |              | 是       |          |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/blockByNumber/100
```

#### 响应参数

**1）数据格式**
```
{
    "code": 0,
    "message": "success",
    "data": {
        "number": 100,
        "hash": "0xf27ff42d4be65329a1e7b11365e190086d92f9836168d0379e92642786db7ade",
        "parentHash": "0xc784a2af86e6726fcdc63b57ed1b91a40efc7d8b1b7285154d399ea78bd18754",
        "nonce": 0,
        "sha3Uncles": "0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347",
        "logsBloom": "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000000000000000040000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000800000000000000000000000000",
        "transactionsRoot": "0x27055bac669a67e8aaa1455ad9fd70b75dd86dc905c6bd0d111ed67ab182d1dc",
        "stateRoot": "0xa05ad5db11b8be6aed3b591f2f64fdbb241506cbe9ef591f3a4b946ca777f838",
        "receiptsRoot": "0xc1d4b43ed68d7263ddf50861feec26440e933a0b152917e938194f5079b48ce4",
        "author": "0x0000000000000000000000000000000000000000",
        "miner": "0x0000000000000000000000000000000000000000",
        "mixHash": null,
        "difficulty": 1,
        "totalDifficulty": 101,
        "extraData": "0xd98097312e332e302b2b302d524c696e75782f672b2b2f496e74",
        "size": 71,
        "gasLimit": 2000000000,
        "gasUsed": 121038,
        "timestamp": 1526437108478,
        "transactions": [
            {
                "hash": "0xb2c733b742045e61c0fd6e7e2bafece04d56262a4887de9f78dad2c5dd2f944b",
                "nonce": 9.1623055443573E+74,
                "blockHash": "0xf27ff42d4be65329a1e7b11365e190086d92f9836168d0379e92642786db7ade",
                "blockNumber": 100,
                "transactionIndex": 0,
                "from": "0x59bd3815f73b197d6ef327f2a45089f50aba942a",
                "to": "0x986278eb8e8b4ef98bdfc055c02d65865fc87ad2",
                "value": 0,
                "gasPrice": 30000000,
                "gas": 30000000,
                "input": "0x48f85bce000000000000000000000000000000000000000000000000000000000000001caf3fbec3675eabb85c0b25e2992d6f0a5e1546dad85c20733fdb27cfa4ca782a5fdfb621b416f3494c7d8ca436c12309884550d402ea79f03ef8ddfdd494f7a4",
                "creates": null,
                "publicKey": null,
                "raw": null,
                "r": null,
                "s": null,
                "v": 0,
                "valueRaw": "0x0",
                "gasPriceRaw": "0x1c9c380",
                "gasRaw": "0x1c9c380",
                "blockNumberRaw": "0x64",
                "transactionIndexRaw": "0x0",
                "nonceRaw": "0x2069170146129593df177e2c37f1b7fe74e2d0fda53dcbbca34a243d46e367a"
            }
        ],
        "uncles": [],
        "sealFields": null,
        "gasUsedRaw": "0x1d8ce",
        "totalDifficultyRaw": "0x65",
        "numberRaw": "0x64",
        "nonceRaw": null,
        "sizeRaw": "0x47",
        "gasLimitRaw": "0x77359400",
        "timestampRaw": "0x16366bddafe",
        "difficultyRaw": "0x1"
    }
}
```
### 3.3. 根据块hash获取块信息接口 


#### 接口描述

> 通过块hash获取块信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/blockByHash/{blockHash}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**  | **类型**   | **最大长度** | **必填** | **说明** |
| -------- | -------- | ----------- | ---------- | ------------ | -------- | -------- |
| 1        | 群组编号 | groupId | int      |             | 是        |                      |
| 2        | 区块hash     | blockByHash | String |       | 是       |          |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/blockByHash/0xf27ff42d4be65329a1e7b11365e190086d92f9836168d0379e92642786db7ade
```

#### 响应参数

**1）数据格式**
```
{
    "code": 0,
    "message": "success",
    "data": {
        "number": 100,
        "hash": "0xf27ff42d4be65329a1e7b11365e190086d92f9836168d0379e92642786db7ade",
        "parentHash": "0xc784a2af86e6726fcdc63b57ed1b91a40efc7d8b1b7285154d399ea78bd18754",
        "nonce": 0,
        "sha3Uncles": "0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347",
        "logsBloom": "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000000000000000040000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000800000000000000000000000000",
        "transactionsRoot": "0x27055bac669a67e8aaa1455ad9fd70b75dd86dc905c6bd0d111ed67ab182d1dc",
        "stateRoot": "0xa05ad5db11b8be6aed3b591f2f64fdbb241506cbe9ef591f3a4b946ca777f838",
        "receiptsRoot": "0xc1d4b43ed68d7263ddf50861feec26440e933a0b152917e938194f5079b48ce4",
        "author": "0x0000000000000000000000000000000000000000",
        "miner": "0x0000000000000000000000000000000000000000",
        "mixHash": null,
        "difficulty": 1,
        "totalDifficulty": 101,
        "extraData": "0xd98097312e332e302b2b302d524c696e75782f672b2b2f496e74",
        "size": 71,
        "gasLimit": 2000000000,
        "gasUsed": 121038,
        "timestamp": 1526437108478,
        "transactions": [
            {
                "hash": "0xb2c733b742045e61c0fd6e7e2bafece04d56262a4887de9f78dad2c5dd2f944b",
                "nonce": 9.1623055443573E+74,
                "blockHash": "0xf27ff42d4be65329a1e7b11365e190086d92f9836168d0379e92642786db7ade",
                "blockNumber": 100,
                "transactionIndex": 0,
                "from": "0x59bd3815f73b197d6ef327f2a45089f50aba942a",
                "to": "0x986278eb8e8b4ef98bdfc055c02d65865fc87ad2",
                "value": 0,
                "gasPrice": 30000000,
                "gas": 30000000,
                "input": "0x48f85bce000000000000000000000000000000000000000000000000000000000000001caf3fbec3675eabb85c0b25e2992d6f0a5e1546dad85c20733fdb27cfa4ca782a5fdfb621b416f3494c7d8ca436c12309884550d402ea79f03ef8ddfdd494f7a4",
                "creates": null,
                "publicKey": null,
                "raw": null,
                "r": null,
                "s": null,
                "v": 0,
                "valueRaw": "0x0",
                "gasPriceRaw": "0x1c9c380",
                "gasRaw": "0x1c9c380",
                "blockNumberRaw": "0x64",
                "transactionIndexRaw": "0x0",
                "nonceRaw": "0x2069170146129593df177e2c37f1b7fe74e2d0fda53dcbbca34a243d46e367a"
            }
        ],
        "uncles": [],
        "sealFields": null,
        "gasUsedRaw": "0x1d8ce",
        "totalDifficultyRaw": "0x65",
        "numberRaw": "0x64",
        "nonceRaw": null,
        "sizeRaw": "0x47",
        "gasLimitRaw": "0x77359400",
        "timestampRaw": "0x16366bddafe",
        "difficultyRaw": "0x1"
    }
}
```

### 3.4. 获取块中交易个数接口  


#### 接口描述

> 根据块高获取该块中的交易个数

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/blockTransCnt/{blockNumber}**

#### 调用方法

HTTP GET

#### 请求参数

1. **参数表**

| **序号** | **中文** | **参数名**  | **类型**   | **最大长度** | **必填** | **说明** |
| -------- | -------- | ----------- | ---------- | ------------ | -------- | -------- |
| 1 | 群组编号 | groupId | int | | 是 | |
| 2 | 块高 | blockNumber | BigInteger | | 是 | |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/blockTransCnt/100
```

#### 响应参数

**1）数据格式**
```
{
    1
}
```
### 3.5. 获取PbftView接口  


#### 接口描述

> 通过调用此接口获取PbftView

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/pbftView**

#### 调用方法

HTTP GET

#### 请求参数

1. **参数表**

| **序号** | **中文** | **参数名**  | **类型**   | **最大长度** | **必填** | **说明** |
| -------- | -------- | ----------- | ---------- | ------------ | -------- | --------       |
| 1        | 群组编号 | groupId       | int      |             | 是        |                |


**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/pbftView
```

#### 响应参数

**1）数据格式**
```
{
    160565
}
```

### 3.6. 获取交易回执接口 


#### 接口描述

> 根据交易hash获取交易回执

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/transactionReceipt/{transHash}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 群组编号 | groupId | int      |             | 是        |                      |
| 2        | 交易hash | transHash  | String   |              | 是       |          |


**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/transactionReceipt/0xb2c733b742045e61c0fd6e7e2bafece04d56262a4887de9f78dad2c5dd2f944b
```

#### 响应参数

**2）数据格式**

```
{
    "transactionHash": "0xb2c733b742045e61c0fd6e7e2bafece04d56262a4887de9f78dad2c5dd2f944b",
    "transactionIndex": 0,
    "blockHash": "0xf27ff42d4be65329a1e7b11365e190086d92f9836168d0379e92642786db7ade",
    "blockNumber": 100,
    "cumulativeGasUsed": 121038,
    "gasUsed": 121038,
    "contractAddress": "0x0000000000000000000000000000000000000000",
    "root": null,
    "from": null,
    "to": null,
    "logs": [
        {
            "removed": false,
            "logIndex": 0,
            "transactionIndex": 0,
            "transactionHash": "0xb2c733b742045e61c0fd6e7e2bafece04d56262a4887de9f78dad2c5dd2f944b",
            "blockHash": "0xf27ff42d4be65329a1e7b11365e190086d92f9836168d0379e92642786db7ade",
            "blockNumber": 100,
            "address": "0x986278eb8e8b4ef98bdfc055c02d65865fc87ad2",
            "data": "0x00000000000000000000000000000000000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000001200000000000000000000000000000000000000000000000000000000000000160000000000000000000000000000000000000000000000000000000000000001caf3fbec3675eabb85c0b25e2992d6f0a5e1546dad85c20733fdb27cfa4ca782a5fdfb621b416f3494c7d8ca436c12309884550d402ea79f03ef8ddfdd494f7a40000000000000000000000000000000000000000000000000000000000000040666164363863656230616530316530643731616635356331316561643031613532656638363435343866306134643133633836363164393664326461366239380000000000000000000000000000000000000000000000000000000000000002363000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000023630000000000000000000000000000000000000000000000000000000000000",
            "type": "mined",
            "topics": [
                "0xbf474e795141390215f4f179557402a28c562b860f7b74dce4a3c0e0604cd97e"
            ],
            "logIndexRaw": "0",
            "blockNumberRaw": "100",
            "transactionIndexRaw": "0"
        }
    ],
    "logsBloom": null,
    "gasUsedRaw": "0x1d8ce",
    "blockNumberRaw": "100",
    "transactionIndexRaw": "0",
    "cumulativeGasUsedRaw": "0x1d8ce",
    "message": null,
    "txProof": null,
    "receiptProof": null
}
```

### 3.7. 根据交易hash获取交易信息接口  


#### 接口描述

> 根据交易hash获取交易信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/transaction/{transHash}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 群组编号 | groupId | int      |             | 是        |                      |
| 2        | 交易hash | transHash  | String   |              | 是       |          |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/transaction/0xa6750b812b1a7e36313879b09f0c41fc583b463c15e57608416f3a32688b432b
```

#### 响应参数


**1）数据格式**
```
{
    "hash": "0xb2c733b742045e61c0fd6e7e2bafece04d56262a4887de9f78dad2c5dd2f944b",
    "nonce": 9.1623055443573E+74,
    "blockHash": "0xf27ff42d4be65329a1e7b11365e190086d92f9836168d0379e92642786db7ade",
    "blockNumber": 100,
    "transactionIndex": 0,
    "from": "0x59bd3815f73b197d6ef327f2a45089f50aba942a",
    "to": "0x986278eb8e8b4ef98bdfc055c02d65865fc87ad2",
    "value": 0,
    "gasPrice": 30000000,
    "gas": 30000000,
    "input": "0x48f85bce000000000000000000000000000000000000000000000000000000000000001caf3fbec3675eabb85c0b25e2992d6f0a5e1546dad85c20733fdb27cfa4ca782a5fdfb621b416f3494c7d8ca436c12309884550d402ea79f03ef8ddfdd494f7a4",
    "creates": null,
    "publicKey": null,
    "raw": null,
    "r": null,
    "s": null,
    "v": 0,
    "nonceRaw": "0x2069170146129593df177e2c37f1b7fe74e2d0fda53dcbbca34a243d46e367a",
    "blockNumberRaw": "0x64",
    "transactionIndexRaw": "0x0",
    "valueRaw": "0x0",
    "gasPriceRaw": "0x1c9c380",
    "gasRaw": "0x1c9c380"
}
```

### 3.8. 获取web3j版本接口  


#### 接口描述

> 获取web3j版本

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/clientVersion**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

无入参

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/clientVersion
```

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 群组编号 | groupId    | int      |              | 是       |          |

**2）数据格式**
```
{
    "Build Time": "20190318 10:56:37",
    "Build Type": "Linux/g++/RelWithDebInfo",
    "FISCO-BCOS Version": "2.0.0-rc1",
    "Git Branch": "master",
    "Git Commit Hash": "2467ddf73b091bc8e0ee611ccee85db7989ad389"
}
```


### 3.9. 获取合约二进制代码接口  


#### 接口描述

> 获取指定块高区块指定合约地址的二进制代码

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/code/{address}/{blockNumber}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**  | **类型**   | **最大长度** | **必填** | **说明** |
| -------- | -------- | ----------- | ---------- | ------------ | -------- | -------- |
| 1        | 群组编号 | groupId     | int        |              | 是       |          |
| 2        | 合约地址 | address     | String     |              | 是       |          |
| 3        | 块高     | blockNumber | BigInteger |              | 是       |          |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/code/0x0000000000000000000000000000000000000000/1
```

#### 响应参数

**1）数据格式**

```
{
    0xxxx
}
```
### 3.10. 获取总交易数  


#### 接口描述

> 获取总交易数量

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/transaction-total**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 群组编号 | groupId    | int      |              | 是       |          |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/transaction-total
```

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 总交易数 | txSum | int      |             | 是        |                      |
| 2        | 快高 | blockNumber  | int   |              | 是       |          |
| 3        |  | blockNumberRaw  | String   |              | 是       |          |
| 4        |  | txSumRaw  | String   |              | 是       |          |

**2）数据格式**
```
{
    "txSum": 125,
    "blockNumber": 125,
    "blockNumberRaw": "0x7d",
    "txSumRaw": "0x7d"
}
```

### 3.11. 根据块hash和交易index获取交易接口  


#### 接口描述

> 获取指定区块指定位置的交易信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/transByBlockHashAndIndex/{blockHash}/{transactionIndex}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**       | **类型**   | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------------- | ---------- | ------------ | -------- | -------- |
| 1        | 群组编号 | groupId          | int        |              | 是       |          |
| 2        | 块hash   | blockHash        | String     |              | 是       |          |
| 3        | 交易位置 | transactionIndex | BigInteger |              | 是       |          |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/transByBlockHashAndIndex/0xf27ff42d4be65329a1e7b11365e190086d92f9836168d0379e92642786db7ade/0
```

#### 响应参数

**1）数据格式**

```
{
    "hash": "0x7c503f202a5e275d8792dd2419ac48418dbec602038fb2a85c899403471f065d",
    "nonce": 1.26575985412899E+75,
    "blockHash": "0x0d9ed7b20645d5b8200347a72e7fb15347b83d74c6e1b6c3995cdb7a849f95d9",
    "blockNumber": 100,
    "transactionIndex": 0,
    "from": "0x6f00a620a61fd6b33e6076880fecc49959eaa4ea",
    "to": "0x9cb5641d991df690ed905c34f9aaf22370034220",
    "value": 0,
    "gasPrice": 1,
    "gas": 100000000,
    "input": "0x4ed3885e000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000016100000000000000000000000000000000000000000000000000000000000000",
    "creates": null,
    "publicKey": null,
    "raw": null,
    "r": null,
    "s": null,
    "v": 0,
    "blockNumberRaw": "0x64",
    "nonceRaw": "0x2cc650a5cbeb268577ac15c7dd2afee0680901de94f8543e86e906247e7edbf",
    "valueRaw": "0x0",
    "gasPriceRaw": "0x1",
    "gasRaw": "0x5f5e100",
    "transactionIndexRaw": "0x0"
}
```

### 3.12. 根据块高和交易index获取交易接口  


#### 接口描述

> 获取指定区块指定位置的交易信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/transByBlockNumberAndIndex/{blockNumber}/{transactionIndex}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**       | **类型**   | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------------- | ---------- | ------------ | -------- | -------- |
| 1        | 群组编号 | groupId | int      |             | 是        |                      |
| 2        | 块高     | blockNumber      | BigInteger |              | 是       |          |
| 3        | 交易位置 | transactionIndex | BigInteger |              | 是       |          |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/transByBlockNumberAndIndex/100/0
```

#### 响应参数

**1）数据格式**
```
{
    "hash": "0x7c503f202a5e275d8792dd2419ac48418dbec602038fb2a85c899403471f065d",
    "nonce": 1.26575985412899E+75,
    "blockHash": "0x0d9ed7b20645d5b8200347a72e7fb15347b83d74c6e1b6c3995cdb7a849f95d9",
    "blockNumber": 100,
    "transactionIndex": 0,
    "from": "0x6f00a620a61fd6b33e6076880fecc49959eaa4ea",
    "to": "0x9cb5641d991df690ed905c34f9aaf22370034220",
    "value": 0,
    "gasPrice": 1,
    "gas": 100000000,
    "input": "0x4ed3885e000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000016100000000000000000000000000000000000000000000000000000000000000",
    "creates": null,
    "publicKey": null,
    "raw": null,
    "r": null,
    "s": null,
    "v": 0,
    "blockNumberRaw": "0x64",
    "nonceRaw": "0x2cc650a5cbeb268577ac15c7dd2afee0680901de94f8543e86e906247e7edbf",
    "valueRaw": "0x0",
    "gasPriceRaw": "0x1",
    "gasRaw": "0x5f5e100",
    "transactionIndexRaw": "0x0"
}
```

### 3.13. 获取群组内的共识状态信息接口  


#### 接口描述

> 返回指定群组内的共识状态信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/consensusStatus**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**       | **类型**   | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------------- | ---------- | ------------ | -------- | -------- |
| 1        | 群组编号 | groupId | int      |             | 是        |                      |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/consensusStatus
```

#### 响应参数
**1）数据格式**

```
[
    {
        "accountType": 1,
        "allowFutureBlocks": true,
        "cfgErr": false,
        "connectedNodes": 3,
        "consensusedBlockNumber": 126,
        "currentView": 499824,
        "groupId": 1,
        "highestblockHash": "0x563d4ec57b597d5d81f0c1b0045c04e57ffebe3a02ff3fef402be56742dc8fd1",
        "highestblockNumber": 125,
        "leaderFailed": false,
        "max_faulty_leader": 1,
        "node index": 2,
        "nodeId": "d822165959a0ed217df6541f1a7dd38b79336ff571dd5f8f85ad76f3e7ec097e1eabd8b03e4a757fd5a9fb0eea905aded56aaf44df83c34b73acb9ab7ac65010",
        "nodeNum": 4,
        "omitEmptyBlock": true,
        "protocolId": 264,
        "sealer.0": "552398be0eef124c000e632b0b76a48c52b6cfbd547d92c15527c2d1df15fab2bcded48353db22526c3540e4ab2027630722889f20a4a614bb11a7887a85941b",
        "sealer.1": "adfa2f9116d7ff68e0deb75307fa1595d636bf097ad1de4fb55cff00e4fef40b453abb30388aa2112bf5cd4c987afe2e047250f7049791aa1ee7091c9e2ab7bb",
        "sealer.2": "d822165959a0ed217df6541f1a7dd38b79336ff571dd5f8f85ad76f3e7ec097e1eabd8b03e4a757fd5a9fb0eea905aded56aaf44df83c34b73acb9ab7ac65010",
        "sealer.3": "dde0bbf5eb3a731e6da861586e98e088e16e6fdd9afae2f2c213cead20a4f5eaa3910042b70d62266d2350d98a43c1f235c8e0da384448384893857873abdb75",
        "toView": 499824
    },
    [
        {
            "nodeId": "552398be0eef124c000e632b0b76a48c52b6cfbd547d92c15527c2d1df15fab2bcded48353db22526c3540e4ab2027630722889f20a4a614bb11a7887a85941b",
            "view": 499823
        },
        {
            "nodeId": "adfa2f9116d7ff68e0deb75307fa1595d636bf097ad1de4fb55cff00e4fef40b453abb30388aa2112bf5cd4c987afe2e047250f7049791aa1ee7091c9e2ab7bb",
            "view": 499820
        },
        {
            "nodeId": "d822165959a0ed217df6541f1a7dd38b79336ff571dd5f8f85ad76f3e7ec097e1eabd8b03e4a757fd5a9fb0eea905aded56aaf44df83c34b73acb9ab7ac65010",
            "view": 499824
        },
        {
            "nodeId": "dde0bbf5eb3a731e6da861586e98e088e16e6fdd9afae2f2c213cead20a4f5eaa3910042b70d62266d2350d98a43c1f235c8e0da384448384893857873abdb75",
            "view": 499822
        }
    ]
]
```

### 3.14. 获取节点状态列表接口  


#### 接口描述

> 返回节点的快高、pbftview及状态。（查看nodeHeartBeat

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/getNodeStatusList**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 群组编号 | groupId    | int      |              | 是       |          |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/getNodeStatusList
```

#### 响应参数

**1）参数表**

| **序号** | **中文**         | **参数名**             | **类型**   | **最大长度** | **必填** | **说明**                                               |
| -------- | ---------------- | ---------------------- | ---------- | ------------ | -------- | ------------------------------------------------------ |
| 1        | 节点Id           | nodeId                 | String     |              | 是       |                                                        |
| 2        | 节点块高         | blockNumber            | bigInteger |              | 是       |                                                        |
| 3        | 节点pbftView     | pbftView               | bigInteger |              | 是       |                                                        |
| 4        | 节点状态         | status                 | int        |              | 是       | 1正常，2异常                                           |
| 5        | 上次状态修改时间 | latestStatusUpdateTime | String     |              | 是       | 跟上次状态变更时间间隔至少大于三秒才会重新检测节点状态 |

**2）数据格式**

```
[
  {
    "nodeId": "2917803543bcb58ad91cdf67e7b576a5b0440b4f76e6f5440edb8b09dadee297174d25133e841a17e4f89aa59bbaf4c80896af9d6a978aae04b3d0b9cd9d5b84",
    "blockNumber": 3,
    "pbftView": 146093,
    "status": 1,
    "latestStatusUpdateTime": "2019-07-25 10:07:07"
  },
  {
    "nodeId": "8722cc018a79bc48b7408649fac4a45bd336a88959570ebba15eefb48fdc23b8a96f328d46852f3d12c4dde7346c573585386fadb5568ce1820144c106af1f72",
    "blockNumber": 3,
    "pbftView": 146095,
    "status": 1,
    "latestStatusUpdateTime": "2019-07-25 10:07:07"
  }
]
```

### 3.15. 获取群组列表接口  

#### 接口描述

> 返回群组列表

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/groupList**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 群组编号 | groupId    | int      |              | 是       |          |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/groupList
```

#### 响应参数

**1）数据格式**
```
[
  "1",
  "2"
]
```

### 3.16. 获取观察及共识节点列表

#### 接口描述

> 返回指定群组内的共识节点和观察节点列表

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/groupPeers**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**       | **类型**   | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------------- | ---------- | ------------ | -------- | -------- |
| 1        | 群组编号 | groupId | int      |             | 是        |                      |


**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/groupPeers
```

#### 响应参数

**1）数据格式**
```
[
    "d822165959a0ed217df6541f1a7dd38b79336ff571dd5f8f85ad76f3e7ec097e1eabd8b03e4a757fd5a9fb0eea905aded56aaf44df83c34b73acb9ab7ac65010",
 "adfa2f9116d7ff68e0deb75307fa1595d636bf097ad1de4fb55cff00e4fef40b453abb30388aa2112bf5cd4c987afe2e047250f7049791aa1ee7091c9e2ab7bb",
 "552398be0eef124c000e632b0b76a48c52b6cfbd547d92c15527c2d1df15fab2bcded48353db22526c3540e4ab2027630722889f20a4a614bb11a7887a85941b",
 "dde0bbf5eb3a731e6da861586e98e088e16e6fdd9afae2f2c213cead20a4f5eaa3910042b70d62266d2350d98a43c1f235c8e0da384448384893857873abdb75"
]
```



### 3.17. 获取群组内观察节点列表

#### 接口描述

> 返回指定群组内的观察节点列表

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/observerList**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**       | **类型**   | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------------- | ---------- | ------------ | -------- | -------- |
| 1        | 群组编号 | groupId | int      |             | 是        |                      |


**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/observerList
```

#### 响应参数

**1）数据格式**
```
[  "d822165959a0ed217df6541f1a7dd38b79336ff571dd5f8f85ad76f3e7ec097e1eabd8b03e4a757fd5a9fb0eea905aded56aaf44df83c34b73acb9ab7a165010"
]
```


### 3.18. 获取已连接的P2P节点信息

#### 接口描述

> 返回指定群组内已连接的P2P节点信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/peers**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**       | **类型**   | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------------- | ---------- | ------------ | -------- | -------- |
| 1        | 群组编号 | groupId | int      |             | 是        |                      |


**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/peers
```

#### 响应参数

**1）数据格式**
```
[
    {
        "ipandPort": "127.0.0.1:30301",
        "IPAndPort": "127.0.0.1:30301",
        "NodeID": "adfa2f9116d7ff68e0deb75307fa1595d636bf097ad1de4fb55cff00e4fef40b453abb30388aa2112bf5cd4c987afe2e047250f7049791aa1ee7091c9e2ab7bb",
        "Topic": []
    },
    {
        "ipandPort": "127.0.0.1:57678",
        "IPAndPort": "127.0.0.1:57678",
        "NodeID": "e28f3d7f5b82e21918a15639eac342dcf678ebb0efe7c65c76514b0ba6b28ace8e47b4a25c9b3f9763b79db847e250a19f827b132f230298980f3ca9779c2564",
        "Topic": []
    },
    {
        "ipandPort": "127.0.0.1:57608",
        "IPAndPort": "127.0.0.1:57608",
        "NodeID": "dde0bbf5eb3a731e6da861586e98e088e16e6fdd9afae2f2c213cead20a4f5eaa3910042b70d62266d2350d98a43c1f235c8e0da384448384893857873abdb75",
        "Topic": []
    },
    {
        "ipandPort": "127.0.0.1:57616",
        "IPAndPort": "127.0.0.1:57616",
        "NodeID": "552398be0eef124c000e632b0b76a48c52b6cfbd547d92c15527c2d1df15fab2bcded48353db22526c3540e4ab2027630722889f20a4a614bb11a7887a85941b",
        "Topic": []
    },
    {
        "ipandPort": "127.0.0.1:57670",
        "IPAndPort": "127.0.0.1:57670",
        "NodeID": "56edfaf60bcb09b9814ad31dcd959eb388f0314445db3deb92cedde97c0ecec210f713591a15f3a7168ba023290cfbe78656b57c37157e6ec74a85182630bd61",
        "Topic": []
    }
]
```

### 3.19. 获取群组内正在处理的交易数

#### 接口描述

> 获取群组内正在处理的交易数

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/pending-transactions-count**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**       | **类型**   | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------------- | ---------- | ------------ | -------- | -------- |
| 1        | 群组编号 | groupId | int      |             | 是        |                      |


**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/pending-transactions-count
```

#### 响应参数

**1）数据格式**
```
0
```


### 3.20. 获取共识节点接口

#### 接口描述

> 返回群组内共识节点列表

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/sealerList**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**       | **类型**   | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------------- | ---------- | ------------ | -------- | -------- |
| 1        | 群组编号 | groupId | int      |             | 是        |                      |


**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/sealerList
```

#### 响应参数

**1）数据格式**
```
[
    "d822165959a0ed217df6541f1a7dd38b79336ff571dd5f8f85ad76f3e7ec097e1eabd8b03e4a757fd5a9fb0eea905aded56aaf44df83c34b73acb9ab7ac65010",
 "adfa2f9116d7ff68e0deb75307fa1595d636bf097ad1de4fb55cff00e4fef40b453abb30388aa2112bf5cd4c987afe2e047250f7049791aa1ee7091c9e2ab7bb",
 "552398be0eef124c000e632b0b76a48c52b6cfbd547d92c15527c2d1df15fab2bcded48353db22526c3540e4ab2027630722889f20a4a614bb11a7887a85941b",
 "dde0bbf5eb3a731e6da861586e98e088e16e6fdd9afae2f2c213cead20a4f5eaa3910042b70d62266d2350d98a43c1f235c8e0da384448384893857873abdb75"
]
```


### 3.21. 区块/交易

#### 接口描述

> 如果输入块高就返回区块信息，如果输入交易hash就返回交易信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/search?input={inputValue}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**       | **类型**   | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------------- | ---------- | ------------ | -------- | -------- |
| 1        | 群组编号 | groupId | int      |             | 是        |                      |
| 2        | 查询参数 | inputValue | int/String | | 是 | 如果输入块高就返回区块信息，如果输入交易hash就返回交易信息|


**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/search?input=1
```

#### 响应参数

**1）数据格式**
```
{
    "number": 1,
    "hash": "0x3875dbec6e0ad0790dc0a0e8535b7c286ef7cee4149e5b1494f5c65631a9e321",
    "parentHash": "0xed3350d191d23cbc609c98e920baa583403b9a02fa934df868e7f425cd72f5c3",
    "nonce": 0,
    "sha3Uncles": null,
    "logsBloom": "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
    "transactionsRoot": "0xa3db8478e08931f8967023a60d260b182d828aad959433e0b77f097d7650b742",
    "stateRoot": "0xf32d3e504fc8813c139d1f6f61ae1c8e355502e10b9ea24e5ad5d3ada01ea400",
    "receiptsRoot": null,
    "author": null,
    "sealer": "0x0",
    "mixHash": null,
    "difficulty": 0,
    "totalDifficulty": 0,
    "extraData": [],
    "size": 0,
    "gasLimit": 0,
    "gasUsed": 0,
    "timestamp": 1557304350431,
    "transactions": [
        {
            "hash": "0x4145b921309fcaa92b05b782e0181d671b8e68fc6d61d939358ed558fa3489c9",
            "nonce": 1.47418536037145E+75,
            "blockHash": "0x3875dbec6e0ad0790dc0a0e8535b7c286ef7cee4149e5b1494f5c65631a9e321",
            "blockNumber": 1,
            "transactionIndex": 0,
            "from": "0x33a41878e78fb26735bf425f9328990e3a1a89df",
            "to": null,
            "value": 0,
            "gasPrice": 1,
            "gas": 100000000,
            "input": "0x6080604052348015600f57600080fd5b5060868061001e6000396000f300608060405260043610603f576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff16806335b09a6e146044575b600080fd5b348015604f57600080fd5b5060566058565b005b5600a165627a7a723058204aacdb57d6f2ae0f7f6c89c28236bba0205631183fd99785de220481566e683f0029",
            "creates": null,
            "publicKey": null,
            "raw": null,
            "r": null,
            "s": null,
            "v": 0,
            "nonceRaw": "0x3425bfe0f36e343686ccbe34a4fe8b05e0e0257ea7ee87417a6d898f0eb43ec",
            "transactionIndexRaw": "0x0",
            "blockNumberRaw": "0x1",
            "valueRaw": "0x0",
            "gasPriceRaw": "0x1",
            "gasRaw": "0x5f5e100"
        }
    ],
    "uncles": null,
    "sealFields": null,
    "nonceRaw": null,
    "numberRaw": "0x1",
    "difficultyRaw": null,
    "totalDifficultyRaw": null,
    "sizeRaw": null,
    "gasLimitRaw": "0x0",
    "gasUsedRaw": "0x0",
    "timestampRaw": "0x16a969296df"
}
```

### 3.22. 获取群组内同步状态信息

#### 接口描述

> 获取群组内同步状态信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/syncStatus**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**       | **类型**   | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------------- | ---------- | ------------ | -------- | -------- |
| 1        | 群组编号 | groupId | int      |             | 是        |                      |


**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/syncStatus
```

#### 响应参数

**1）数据格式**
```
{
    "blockNumber": 126,
    "genesisHash": "0xed3350d191d23cbc609c98e920baa583403b9a02fa934df868e7f425cd72f5c3",
    "isSyncing": false,
    "latestHash": "0x49ca6eb004f372c71ed900ec6992582cd107e4f3ea36aaa5a0a78829ebef1f14",
    "nodeId": "d822165959a0ed217df6541f1a7dd38b79336ff571dd5f8f85ad76f3e7ec097e1eabd8b03e4a757fd5a9fb0eea905aded56aaf44df83c34b73acb9ab7ac65010",
    "peers": [
        {
            "blockNumber": 126,
            "genesisHash": "0xed3350d191d23cbc609c98e920baa583403b9a02fa934df868e7f425cd72f5c3",
            "latestHash": "0x49ca6eb004f372c71ed900ec6992582cd107e4f3ea36aaa5a0a78829ebef1f14",
            "nodeId": "552398be0eef124c000e632b0b76a48c52b6cfbd547d92c15527c2d1df15fab2bcded48353db22526c3540e4ab2027630722889f20a4a614bb11a7887a85941b"
        },
        {
            "blockNumber": 126,
            "genesisHash": "0xed3350d191d23cbc609c98e920baa583403b9a02fa934df868e7f425cd72f5c3",
            "latestHash": "0x49ca6eb004f372c71ed900ec6992582cd107e4f3ea36aaa5a0a78829ebef1f14",
            "nodeId": "adfa2f9116d7ff68e0deb75307fa1595d636bf097ad1de4fb55cff00e4fef40b453abb30388aa2112bf5cd4c987afe2e047250f7049791aa1ee7091c9e2ab7bb"
        },
        {
            "blockNumber": 126,
            "genesisHash": "0xed3350d191d23cbc609c98e920baa583403b9a02fa934df868e7f425cd72f5c3",
            "latestHash": "0x49ca6eb004f372c71ed900ec6992582cd107e4f3ea36aaa5a0a78829ebef1f14",
            "nodeId": "dde0bbf5eb3a731e6da861586e98e088e16e6fdd9afae2f2c213cead20a4f5eaa3910042b70d62266d2350d98a43c1f235c8e0da384448384893857873abdb75"
        }
    ],
    "protocolId": 265,
    "txPoolSize": "0"
}
```

### 3.23. 刷新前置

#### 接口描述

> 刷新前置的群组列表，功能与`groupList`类似

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/refresh**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**       | **类型**   | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------------- | ---------- | ------------ | -------- | -------- |
| 1        | 群组编号 | groupId         | int           |             | 是        |         |


**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/refresh
```

#### 响应参数

**1）数据格式**
```
{
    "blockNumber": 126,
    "genesisHash": "0xed3350d191d23cbc609c98e920baa583403b9a02fa934df868e7f425cd72f5c3",
    "isSyncing": false,
    "latestHash": "0x49ca6eb004f372c71ed900ec6992582cd107e4f3ea36aaa5a0a78829ebef1f14",
    "nodeId": "d822165959a0ed217df6541f1a7dd38b79336ff571dd5f8f85ad76f3e7ec097e1eabd8b03e4a757fd5a9fb0eea905aded56aaf44df83c34b73acb9ab7ac65010",
    "peers": [
        {
            "blockNumber": 126,
            "genesisHash": "0xed3350d191d23cbc609c98e920baa583403b9a02fa934df868e7f425cd72f5c3",
            "latestHash": "0x49ca6eb004f372c71ed900ec6992582cd107e4f3ea36aaa5a0a78829ebef1f14",
            "nodeId": "552398be0eef124c000e632b0b76a48c52b6cfbd547d92c15527c2d1df15fab2bcded48353db22526c3540e4ab2027630722889f20a4a614bb11a7887a85941b"
        },
        {
            "blockNumber": 126,
            "genesisHash": "0xed3350d191d23cbc609c98e920baa583403b9a02fa934df868e7f425cd72f5c3",
            "latestHash": "0x49ca6eb004f372c71ed900ec6992582cd107e4f3ea36aaa5a0a78829ebef1f14",
            "nodeId": "adfa2f9116d7ff68e0deb75307fa1595d636bf097ad1de4fb55cff00e4fef40b453abb30388aa2112bf5cd4c987afe2e047250f7049791aa1ee7091c9e2ab7bb"
        },
        {
            "blockNumber": 126,
            "genesisHash": "0xed3350d191d23cbc609c98e920baa583403b9a02fa934df868e7f425cd72f5c3",
            "latestHash": "0x49ca6eb004f372c71ed900ec6992582cd107e4f3ea36aaa5a0a78829ebef1f14",
            "nodeId": "dde0bbf5eb3a731e6da861586e98e088e16e6fdd9afae2f2c213cead20a4f5eaa3910042b70d62266d2350d98a43c1f235c8e0da384448384893857873abdb75"
        }
    ],
    "protocolId": 265,
    "txPoolSize": "0"
}
```

### 3.24. 动态生成群组


#### 接口描述

在节点上动态生成新群组的配置文件与创世块文件

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/generateGroup**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| --- | --- | --- | --- | --- | --- | --- |
| 1        | 群组编号 | groupId         | int           |             | 是        |    此处groupId可填写任意已有群组     |
| 1        | 生成群组的编号 | generateGroupId         | int           |             | 是        |    待生成新群组的id     |
| 1        | 共识节点列表 | nodeList         | List<String>           |             | 是        |   新群组的共识节点列表，可通过getNodeIdList获取      |
| 1        | 群组时间戳 | timestamp         | BigInteger           |             | 是        |     新群组的创世块时间戳    |

**2）数据格式**

```
{
  "generateGroupId": 5,
  "nodeList": [
    "dd7a2964007d583b719412d86dab9dcf773c61bccab18cb646cd480973de0827cc94fa84f33982285701c8b7a7f465a69e980126a77e8353981049831b550f5c",
    "59db64100da70db9c2911f2925bcd0c2f9a1b84f4f8bfef0f6a7edf6d511b2a79203a486c268fb97bc19636f91f71ae9dca076973a4bd551b4a8cdf6d7e7710c"
  ],
  "timestamp": 1589286309000 
}
```

示例：

```
curl -X POST "http://localhost:5002/WeBASE-Front/{groupId}/web3/generateGroup" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"generateGroupId\": 8, \"nodeList\": [ \"dd7a2964007d583b719412d86dab9dcf773c61bccab18cb646cd480973de0827cc94fa84f33982285701c8b7a7f465a69e980126a77e8353981049831b550f5c\" ], \"timestamp\":1589286309000}"
```

#### 响应参数

a、成功：

```
{
    "code": 0,
    "message": "success"
}
```

b、失败：
```
{
  "code": 201128,
  "errorMessage": "group peers not connected"
}
```


### 3.25. 操作动态群组的状态

#### 接口描述

启动群组、停止群组、移除群组、恢复群组、查询群组状态等操作

创建群组后，需要对群组内每个节点分别调用`start`来启动群组，群组才是完全创建

#### 接口URL


**http://localhost:5002/WeBASE-Front/{groupId}/web3/operateGroup/{type}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|    1     | 群组id       | groupId           | int   |              |   是     |    操作的群组编号                        |
|    2     | 操作类型         | type            | String   |              | 是       |  start, stop, remove, recover, getStatus |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/5/web3/operateGroup/start
```

#### 响应参数

**1）数据格式**

a、成功：

```
{
  "code": 0,
  "message": "success"
}
```

b、失败：
```
{
  "code": 201123,
  "errorMessage": "group already running"
}
```


### 3.26. 获取当前节点的多个群组状态

#### 接口描述

传入多个群组编号，对单个节点查询多个群组的状态

包含五种群组状态：该节点不存在该群组"INEXISTENT"、正在停止群组"STOPPING"、群组运行中"RUNNING"、群组已停止"STOPPED"、群组已删除"DELETED"

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/queryGroupStatus**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|    1     | 群组id       | groupId           | int   |              |   是     |    该编号与所查询群组编号无关                        |
|    2     | 群组id列表         | groupIdList            | List<Integer>   |              | 是       |  传入多个群组id |

**2）数据格式**

```
{
  "groupIdList": [
    1,2,3,4,5
  ]
}
```

示例：

```
curl -X POST "http://localhost:5002/WeBASE-Front/{groupId}/web3/queryGroupStatus" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"groupIdList\": [ 1,2,3,4,5 ]}"
```

#### 响应参数


**1）参数表**

| **序号** | **中文**         | **参数名**             | **类型**   | **最大长度** | **必填** | **说明**                                               |
| -------- | ---------------- | ---------------------- | ---------- | ------------ | -------- | ------------------------------------------------------ |
| 1        | 群组与状态Map      | -                 | Map     |              | 是       |                                                        |
| 1.1        | 群组id         |             | String   |              | 是       |   群组id   |
| 1.2        | 群组状态         |             | String   |              | 是       |   包含五种状态："INEXISTENT"、"STOPPING"、"RUNNING"、"STOPPED"、"DELETED"   |

a、成功：

```
{
  "code": 0,
  "message": "success",
  "data": {
    "1": "RUNNING",
    "2": "RUNNING",
    "3": "INEXISTENT",
    "4": "INEXISTENT",
    "5": "INEXISTENT"
  }
}
```

## 4. 性能检测接口

### 4.1. 获取机器配置信息  

#### 接口描述

获取机器配置信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/performance/config**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

无入参

#### 响应参数
**1）参数表**
``` 
{
    "memoryTotalSize": "8010916",
    "cpuAmount": "4",
    "memoryUsedSize": "7818176",
    "cpuSize": "2599",
    "ip": "127.0.0.1",
    "diskUsedSize": "313811828",
    "diskTotalSize": "515928320"
}
```

### 4.2. 获取机器历史性能信息  


#### 接口描述

获取机器历史性能信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/performance**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | 开始日期 | beginDate | LocalDateTime |   |   |   |
| 2 | 结束日期 | endDate | LocalDateTime |   |   |   |
| 3 | 对比开始日期 | contrastBeginDate | LocalDateTime |   |   |   |
| 4 | 对比结束日期 | contrastEndDate | LocalDateTime |   |   |   |
| 5 | 间隔 | gap | int |   |   |   |

#### 响应参数
**1）参数表**
``` 
{
    [{
        "metricType": "cpu",
        "data": {
            "lineDataList": {
                "timestampList": [],
                "valueList": []
            },
            "contrastDataList": {
                "timestampList": [],
                "valueList": []
            }
        }
    }, {
        "metricType": "memory",
        "data": {
            "lineDataList": {
                "timestampList": null,
                "valueList": []
            },
            "contrastDataList": {
                "timestampList": null,
                "valueList": []
            }
        }
    }, {
        "metricType": "disk",
        "data": {
            "lineDataList": {
                "timestampList": null,
                "valueList": []
            },
            "contrastDataList": {
                "timestampList": null,
                "valueList": []
            }
        }
    }, {
        "metricType": "txbps",
        "data": {
            "lineDataList": {
                "timestampList": null,
                "valueList": []
            },
            "contrastDataList": {
                "timestampList": null,
                "valueList": []
            }
        }
    }, {
        "metricType": "rxbps",
        "data": {
            "lineDataList": {
                "timestampList": null,
                "valueList": []
            },
            "contrastDataList": {
                "timestampList": null,
                "valueList": []
            }
        }
    }]
}
}
```

### 4.3. 监测机器性能的启停状态


#### 接口描述

获取机器历史性能信息的开启或关闭状态

#### 接口URL

**http://localhost:5002/WeBASE-Front/performance/toggle**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| --- | --- | --- | --- | --- | --- | --- |
|   | - | - | - |   |   |   |

#### 响应参数
**1）参数表** 
``` 
{
    "code": 0,
    "message": "Sync Status is ON",
    "data": true
}
```

### 4.4. 管理监测机器性能的状态


#### 接口描述

管理监测机器历史性能信息的状态，开启或关闭；默认状态为开启，可通过修改配置文件中constant的monitorEnable值改变监测默认开关状态

#### 接口URL

**http://localhost:5002/WeBASE-Front/performance/toggle**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | 开关 | enable | boolean |     | 是  | 开启为"1", 关闭为"0"  |

**2）数据格式**

```
{
    "enable": 0
}
```

示例：

```
curl -l -H "Content-type: application/json" -X POST -d '{"enable": 0}' http://127.0.0.1:5002/WeBASE-Front/performance/toggle
```

#### 响应参数

a、关闭监测机器性能信息

```
{
    "code": 0,
    "message": "Sync Status is OFF",
    "data": false
}
```

b、开启监测机器性能信息

```
{
    "code": 0,
    "message": "Sync Status is ON",
    "data": true
}
```

## 5. 交易接口

### 5.1. 交易处理接口

#### 接口描述

通过合约信息进行调用，前置根据调用的合约方法是否是“constant”方法区分返回信息，“constant”方法为查询，返回要查询的信息。非“constant”方法为发送数据上链，返回块hash、块高、交易hash等信息。

方法入参（funcParam）为JSON数组，多个参数以逗号分隔（参数为数组时同理），示例：
```
function set(string s) -> ["aa,bb\"cc"] // 双引号要转义
function set(uint n,bool b) -> [1,true]
function set(bytes b,address[] a) -> ["0x1a",["0x7939E26070BE44E6c4Fc759Ce55C6C8b166d94BE","0xce867fD9afa64175bb50A4Aa0c17fC7C4A3C67D9"]]
```

#### 接口URL

**http://localhost:5002/WeBASE-Front/trans/handle**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
| 1        | 用户地址       | user            | String   |              | 是       | 用户地址，可通过`/privateKey`接口创建           |
| 2        | 合约名称       | contractName    | String   |              | 是       |                                                |
| 3        | 合约地址       | contractAddress | String   |              | 是       |                                                |
| 4        | 方法名         | funcName        | String   |              | 是       |                                                |
| 5        | 合约编译后生成的abi文件内容        | contractAbi     | List     |              | 是        | JSONArray，如果传入此字段，则使用这个abi。如果没有传入此字段，则从db或cns获取合约abi |
| 6        | 方法参数       | funcParam       | List     |              | 否         | JSONArray，对应合约方法参数，多个参数以“,”分隔，根据所调用的合约方法判断是否必填 |
| 7        | 群组ID         | groupId         | int      |              |   是       |  默认为1                                          |
| 8        | 合约版本       | version           | String      |         |   否       |                                            |
| 9        | 合约路径       | contractPath         | int      |         |   否       |                                                 |

**2）数据格式**

示例：

```
curl -l -H "Content-type: application/json" -X POST -d '{"contractName":
"HelloWorld", "contractAbi": [{\"constant\":false,\"inputs\":[{\"indexed\":false,\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"}], funcName": "set", "funcParam": ["Hi,Welcome!"], "user": "0x2db346f9d24324a4b0eac7fb7f3379a2422704db", "contractAddress":"dasdfav23rf213vbcdvadf3bcdf2fc23rqde","groupId": 1}' http://10.0.0.1:5002/WeBASE-Front/trans/handle
```

传入合约abi:
```
{
    "user":"0x2db346f9d24324a4b0eac7fb7f3379a2422704db",
    "contractName":"HelloWorld",
    "contractAddress":"dasdfav23rf213vbcdvadf3bcdf2fc23rqde",
    "funcName":"set",
    "contractAbi":[{"constant":true,"inputs":[],"name":"getVersion","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"getStorageCell","outputs":[{"name":"","type":"string"},{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"n","type":"string"}],"name":"setVersion","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[{"name":"storageHash","type":"string"},{"name":"storageInfo","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"}],
    "funcParam":["Hi,Welcome!"],
    "groupId" :"1"
}
```

#### 响应参数

a、正确查询交易返回值信息

```
{"Hi,Welcome!"}
```

b、正确发送数据上链返回值信息（交易收据）

```
{
    "code": 0,
    "message": "success",
    "data": {
        "blockHash":
        "0x1d8d8275aa116d65893291c140849be272dac1d4ca0a0a722f44404b2f2356c3",
        "gasUsed": 32798,
        "transactionIndexRaw": "0",
        "blockNumberRaw": "33",
        "blockNumber": 33,
        "contractAddress": "0x0000000000000000000000000000000000000000",
        "cumulativeGasUsed": 32798,
        "transactionIndex": 0,
        "gasUsedRaw": "0x801e",
        "logs": [],
        "cumulativeGasUsedRaw": "0x801e",
        "transactionHash":"0x0653a8e959771955330461456dd094a96d9071bfa31e6f43b68b30f10a85689c"
    }
}
```

### 5.2. 交易处理接口（结合WeBASE-Sign）

#### 接口描述

​   通过此接口对合约进行调用，前置根据调用的合约方法是否是“constant”方法区分返回信息，“constant”方法为查询，返回要查询的信息。非“constant”方法为发送数据上链，返回块hash、块高、交易hash等信息。

​   当合约方法为非“constant”方法，要发送数据上链时，此接口需结合WeBASE-Sign使用。通过调用WeBASE-Sign服务的签名接口让相关用户对数据进行签名，拿回签名数据再发送上链。需要调用此接口时，工程配置文件application.yml中的配置"keyServer"需配置WeBASE-Sign服务的ip和端口，并保证WeBASE-Sign服务正常和存在相关用户。


方法入参（funcParam）为JSON数组，多个参数以逗号分隔（参数为数组时同理），示例：
```
function set(string s) -> ["aa,bb\"cc"] // 双引号要转义
function set(uint n,bool b) -> [1,true]
function set(bytes b,address[] a) -> ["0x1a",["0x7939E26070BE44E6c4Fc759Ce55C6C8b166d94BE","0xce867fD9afa64175bb50A4Aa0c17fC7C4A3C67D9"]]
```

#### 接口URL

**http://localhost:5002/WeBASE-Front/trans/handleWithSign**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
| 1        | 用户编号       | signUserId      | String   |     64         | 是       | WeBASE-Sign用户编号（查询方法可不传）                          |
| 2        | 合约名称       | contractName    | String   |              | 是       |                                                |
| 3        | 合约地址       | contractAddress | String   |              | 是       |                                                |
| 4        | 方法名         | funcName        | String   |              | 是       |                                                |
| 5        | 合约编译后生成的abi文件内容 | contractAbi    | List |        | 否        | JSONArray，如果传入此字段，则使用这个abi。如果没有传入此字段，则从db或cns获取合约abi |
| 6        | 方法参数       | funcParam       | List     |              | 否         | JSONArray，对应合约方法参数，多个参数以“,”分隔，根据所调用的合约方法判断是否必填 |
| 7        | 群组ID         | groupId         | int      |              |   是       |  默认为1                                          |
| 8        | 合约版本       | version           | String      |         |   否       |        CNS中的合约版本，不传入contractAbi时可传入合约地址与版本获取CNS上存储的合约ABI                                    |


**2）数据格式**

```
{
    "groupId" :1,
    "signUserId": "458ecc77a08c486087a3dcbc7ab5a9c3",
    "contractAbi":[],
    "contractAddress":"0x14d5af9419bb5f89496678e3e74ce47583f8c166",
    "funcName":"set",
    "funcParam":["test"]
}
```

示例：

```
curl -X POST "http://localhost:5002/WeBASE-Front/trans/handleWithSign" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"contractAbi\": [ { \"outputs\": [], \"constant\": false, \"payable\": false, \"inputs\": [ { \"name\": \"n\", \"type\": \"string\" } ], \"name\": \"set\", \"stateMutability\": \"nonpayable\", \"type\": \"function\" }, { \"outputs\": [ { \"name\": \"\", \"type\": \"string\" } ], \"constant\": true, \"payable\": false, \"inputs\": [], \"name\": \"get\", \"stateMutability\": \"view\", \"type\": \"function\" }, { \"payable\": false, \"inputs\": [], \"stateMutability\": \"nonpayable\", \"type\": \"constructor\" }, { \"inputs\": [ { \"indexed\": false, \"name\": \"name\", \"type\": \"string\" } ], \"name\": \"nameEvent\", \"anonymous\": false, \"type\": \"event\" } ], \"contractAddress\": \"0x7571ff73f1a37ca07f678aebc4d8213e7ef5c266\", \"funcName\": \"set\", \"funcParam\": [ \"test\" ], \"groupId\": 1, \"signUserId\": "458ecc77a08c486087a3dcbc7ab5a9c3"}"
```

#### 响应参数

a、正确查询交易返回值信息

```
{"Hi,Welcome!"}
```

b、正确发送数据上链返回值信息（交易收据）

```
{
  "transactionHash": "0x0b426a58af8ba449742b937f1e9b2b225335638707b93d6b296dfd8107edddd7",
  "transactionIndex": 0,
  "blockHash": "0xc8eb7a983ecb8c2a0a64450a059d2cf3de8c8d786211dcec48ab9c47219ee8f7",
  "blockNumber": 36985,
  "gasUsed": 35400,
  "contractAddress": "0x0000000000000000000000000000000000000000",
  "root": null,
  "status": "0x0",
  "from": "0xb173ca9a2e07efe6007aee751a013849d53e7c29",
  "to": "0x7571ff73f1a37ca07f678aebc4d8213e7ef5c266",
  "input": "0x4ed3885e000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000047465737400000000000000000000000000000000000000000000000000000000",
  "output": "0x",
  "logs": [
    {
      "removed": false,
      "logIndex": null,
      "transactionIndex": null,
      "transactionHash": null,
      "blockHash": null,
      "blockNumber": null,
      "address": "0x7571ff73f1a37ca07f678aebc4d8213e7ef5c266",
      "data": "0x000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000047465737400000000000000000000000000000000000000000000000000000000",
      "type": null,
      "topics": [
        "0x9645e7fb5eec05c0f156d4901a10663561199c6dd0401214a0b833fe0022d899"
      ],
      "logIndexRaw": null,
      "blockNumberRaw": null,
      "transactionIndexRaw": null
    }
  ],
  "logsBloom": "0x00000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000000020000000000000000000000000000000000000000000000000000000004000000000000000000000000000000000",
  "gasUsedRaw": "0x8a48",
  "statusOK": true,
  "blockNumberRaw": "0x9079",
  "transactionIndexRaw": "0x0"
}
```

## 6. 系统管理接口

### 6.1. 查询权限接口

#### 6.1.1 查询权限接口

#### 接口描述


根据PermissionType权限类型，查询该类权限记录列表。共支持查看六种权限的管理员列表：权限管理权限permission, 用户表管理权限userTable, 部署合约和创建用户表权限deployAndCreate, 节点管理权限node, 使用CNS权限cns, 系统参数管理权限sysConfig  

#### 接口URL


**http://localhost:5002/WeBASE-Front/permission?groupId={groupId}&permissionType={permissionType}&pageSize={pageSize}&pageNumber={pageNumber}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
| 1        | 群组ID       | groupId            | int   |              | 是      | 节点所属群组ID，默认为1         |
| 2        | 权限类型       | permissionType    | String   |              | 是       |  分配权限的类型                                     |
| 3        | 分页大小         | pageSize        | int   |           | 否       | 默认为10
| 4        | 分页页码         | pageNumber        | int   |           | 否       |  默认为1             
5        | 表名       | tableName       | String     |              |     否     | 当`permissionType`为`userTable`时为**必填**

**2）数据格式**


```
http://localhost:5002/WeBASE-Front/permission?groupId=1&permissionType=cns&pageSize=5&pageNumber=1
```



#### 响应参数

**1）数据格式**
```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "address": "0x009fb217b6d7f010f12e7876d31a738389fecd51",
            "table_name": "_sys_table_access_",
            "enable_num": "84"
        }
    ],
    "totalCount": 1
}
```

#### 6.1.2 查询权限接口（不分页）

#### 接口URL


**http://localhost:5002/WeBASE-Front/permission/full?groupId={groupId}&permissionType={permissionType}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
| 1        | 群组ID       | groupId            | int   |              | 是       | 节点所属群组ID                           |
| 2        | 权限类型       | permissionType    | String   |              | 是       |  分配权限的类型                                     
| 3       | 表名       | tableName       | String     |              |     否     | 当permissionType为userTable时不可为空 

**2）数据格式**


```
http://localhost:5002/WeBASE-Front/permission/full?groupId=1&permissionType=cns&pageSize=5&pageNumber=1
```


#### 响应参数

**1）数据格式**
```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "address": "0x009fb217b6d7f010f12e7876d31a738389fecd51",
            "table_name": "_sys_table_access_",
            "enable_num": "84"
        }
    ],
    "totalCount": 1
}
```


#### 6.1.3 获取权限状态列表接口（不分页）

#### 接口URL


**http://localhost:5002/WeBASE-Front/permission/sorted/full?groupId={groupId}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
| 1        | 群组ID       | groupId            | int   |              | 是       | 节点所属群组ID                           |

**2）数据格式**


```
http://localhost:5002/WeBASE-Front/permission/sorted/full?groupId=1
```


#### 响应参数

**1）数据格式**
```
{
    "code": 0,
    "message": "success",
    "data": {
        "0x2cbca2910b650e5816b4731b097eb8985be39805": {
            "deployAndCreate": 1,
            "cns": 0,
            "sysConfig": 0,
            "node": 0
        },
        "0x79d3632a8bc9b3e823a8e475436d5aa6e0fb88a7": {
            "deployAndCreate": 1,
            "cns": 1,
            "sysConfig": 1,
            "node": 1
        },
        "0x202b4245087dbf797f954d8425459bfee3c790f8": {
            "deployAndCreate": 1,
            "cns": 1,
            "sysConfig": 1,
            "node": 1
        },
        "0x7db73896a6db5e86563af18f206405030bd569f8": {
            "deployAndCreate": 0,
            "cns": 1,
            "sysConfig": 0,
            "node": 0
        }
    },
    "totalCount": 4
}
```

### 6.2. 增加管理权限接口

#### 接口描述

由管理员赋予外部账户地址不同类型的权限，包含六种：权限管理权限permission, 用户表管理权限userTable, 部署合约和创建用户表权限deployAndCreate, 节点管理权限node, 使用CNS权限cns, 系统参数管理权限sysConfig

其中userTable权限还需传入相应的表明tableName

#### 接口URL

**http://localhost:5002/WeBASE-Front/permission**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**


| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
| 1        | 群组ID       | groupId            | int   |              | 是       | 节点所属群组ID                           |
| 2        | 权限类型       | permissionType    | String   |              | 是       |  分配权限的类型（六种：permission, userTable, deployAndCreate, node, cns, sysConfig)                                                |
| 3        | 管理员地址       | fromAddress | String   |              | 是       |                                                |
| 4        | 被授予权限地址         | address        | String   |           | 是       |                                                |
| 5        | 表名       | tableName       | String     |              |     否     | 当permissionType为userTable时不可为空 

**2）数据格式**

```
{
    "groupId": 1,
    "permissionType": "permission",
    "fromAddress": "0xd5bba8fe456fce310f529edecef902e4b63129b1",
    "address": "0x2357ad9d97027cd71eea1d639f1e5750fbdfd38e"
}
```

示例：

```
curl -l -H "Content-type: application/json" -X POST -d '{"groupId": 1, "permissionType": "permission", "fromAddress": "0xd5bba8fe456fce310f529edecef902e4b63129b1", "address": "0x2357ad9d97027cd71eea1d639f1e5750fbdfd38e"}' http://10.0.0.1:5002/WeBASE-Front/permission
```

#### 响应参数

a、成功：

```
{
    "code": 0,
    "message": "success"
}
```

b、失败：
```
{
    "code": -51000,
    "message": "table name and address already exist"
}
```


### 6.3. 去除管理权限接口

#### 接口描述

由管理员去除外部账户地址不同类型的权限，包含六种：权限管理权限permission, 用户表管理权限userTable, 部署合约和创建用户表权限deployAndCreate, 节点管理权限node, 使用CNS权限cns, 系统参数管理权限sysConfig

其中userTable权限还需传入相应的表明tableName

#### 接口URL

**http://localhost:5002/WeBASE-Front/permission**

#### 调用方法

HTTP DELETE

#### 请求参数

**1）参数表**


| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
| 1        | 群组ID       | groupId            | int   |              | 是       | 节点所属群组ID                           |
| 2        | 权限类型       | permissionType    | String   |              | 是       |  分配权限的类型（六种：permission, userTable, deployAndCreate, node, cns, sysConfig)                                                |
| 3        | 管理员地址       | fromAddress | String   |              | 是       |                                                |
| 4        | 被授予权限地址         | address        | String   |           | 是       |                                                |
| 5        | 表名       | tableName       | String     |              |     否     | 当permissionType为userTable时不可为空 

**2）数据格式**

```
{
    "groupId": 1,
    "permissionType": "permission",
    "fromAddress": "0xd5bba8fe456fce310f529edecef902e4b63129b1",
    "address": "0x2357ad9d97027cd71eea1d639f1e5750fbdfd38e"
}
```

示例：

```
curl -l -H "Content-type: application/json" -X DELETE -d '{"groupId": 1, "permissionType": "permission", "fromAddress": "0xd5bba8fe456fce310f529edecef902e4b63129b1", "address": "0x2357ad9d97027cd71eea1d639f1e5750fbdfd38e"}' http://10.0.0.1:5002/WeBASE-Front/permission
```

#### 响应参数

a、成功：

```
{
    "code": 0,
    "message": "success"
}
```

b、失败：
```
{
    "code": -51001,
    "message": "table name and address does not exist"
}
```


### 6.4. 管理用户权限状态接口

#### 接口描述

管理用户权限状态，批量修改用户权限

注：目前只支持cns、deployAndCreate、sysConfig、node四种权限管理

#### 接口URL

**http://localhost:5002/WeBASE-Front/permission/sorted**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**


| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
| 1        | 群组ID       | groupId            | int   |              | 是       | 节点所属群组ID                           |
| 2        | 管理员地址       | fromAddress | String   |              | 是       |                                                |
| 3        | 被授予权限地址         | address        | String   |           | 是       |                                                |
| 4        | 用户权限状态       | permissionState       | Object     |              |     是     | 使用{"permissionType": 1}格式，参照下文数据格式；1代表赋予，0代表去除；支持cns、deployAndCreate、sysConfig、node四种权限

**2）数据格式**

```
{
 "groupId": "2",
 "fromAddress": "0x09fb217b6d7f010f12e7876d31a738389fecd517",
 "address": "0x09fb217b6d7f010f12e7876d31a738389fecd517",
 "permissionState": {
      "deployAndCreate": 1,
      "node": 1,
      "sysConfig": 1,
      "cns": 1             
 }
}
```

示例：

```
curl -l -H "Content-type: application/json" -X POST -d '{"groupId": "2","fromAddress": "0x09fb217b6d7f010f12e7876d31a738389fecd517","address":"0x09fb217b6d7f010f12e7876d31a738389fecd517","permissionState": {"deployAndCreate": 1,"node": 1,"sysConfig": 1,"cns": 1}}'  http://localhost:5002/WeBASE-Front/permission/sorted
```

#### 响应参数

a、成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "node": 1,
        "sysConfig": 1,
        "cns": 1,
        "deployAndCreate": 1
    }
}
```

b、失败：
```
{
    "code": 201202,
    "message": "permission denied, please check chain administrator permission"
}
```


### 6.5. 查询CNS接口

#### 接口描述


根据群组id和合约名（或合约名加版本）获取CNS的list列表。

#### 接口URL


**http://localhost:5002/WeBASE-Front/precompiled/cns/list?groupId={groupId}&contractNameAndVersion={contractNameAndVersion}&pageSize={pageSize}&pageNumber={pageNumber}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
| 1        | 群组ID       | groupId            | int   |              | 是       | 节点所属群组ID                           |
| 2        | 合约名与版本       | contractNameAndVersion    | String   |              | 是       |  版本非必填，合约名与版本中间用英文冒号":"连接，版本号最长为40，由字母数字与"."组成。无版本参数时返回全部版本                                     |
| 3        | 分页大小         | pageSize        | int   |           | 是       | 默认为10
| 4        | 分页页码         | pageNumber        | int   |           | 是       |  默认为1            
      
**2）数据格式**


```
http://localhost:5002/WeBASE-Front/precompiled/cns/list?groupId=1&contractNameAndVersion=HelloWorld&pageSize=5&pageNumber=1
```

#### 响应参数

**1）数据格式**
```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "name": "HelloWorld",
            "version": "2d36b8ed7ed12da01ed51cc0c85c3002085b17b6",
            "address": "0x2d36b8ed7ed12da01ed51cc0c85c3002085b17b6",
            "abi": "[{\"constant\":false,\"inputs\":[{\"indexed\":false,\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"indexed\":false,\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"},{\"constant\":false,\"inputs\":[{\"indexed\":false,\"name\":\"name\",\"type\":\"string\"}],\"name\":\"nameEvent\",\"payable\":false,\"type\":\"event\"}]"
        }
    ],
    "totalCount": 1
}
```

### 6.6. 查询系统配置接口

#### 接口描述

根据群组id获取系统配置SystemConfig的list列表，目前只支持tx_count_limit, tx_gas_limit两个参数。

#### 接口URL


**http://localhost:5002/WeBASE-Front/sys/config/list?groupId={groupId}&pageSize={pageSize}&pageNumber={pageNumber}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
| 1        | 群组ID       | groupId            | int   |              | 是       | 节点所属群组ID                           |
| 2        | 分页大小         | pageSize        | int   |           | 是       | 默认为10
| 3        | 分页页码         | pageNumber        | int   |           | 是       |  默认为1            
      
**2）数据格式**


```
http://localhost:5002/WeBASE-Front/sys/config/list?groupId=1&pageSize=5&pageNumber=1
```

#### 响应参数

**1）数据格式**
```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "id": 6,
            "groupId": 1,
            "fromAddress": "0x",
            "configKey": "tx_gas_limit",
            "configValue": "300000000"
        },
        {
            "id": 5,
            "groupId": 1,
            "fromAddress": "0xd0b56b4ce0e8ce5e064f896d9ad1c16b2603f285",
            "configKey": "tx_count_limit",
            "configValue": "10002"
        }
    ],
    "totalCount": 2
}
```

### 6.7. 设置系统配置接口

#### 接口描述

系统配置管理员设置系统配置，目前只支持tx_count_limit, tx_gas_limit两个参数。

#### 接口URL

**http://localhost:5002/WeBASE-Front/sys/config**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**


| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
| 1        | 群组ID       | groupId            | int   |              | 是       | 节点所属群组ID                           |                                             |
| 2        | 管理员地址       | fromAddress | String   |              | 是       |                                                |
| 3        | 配置的键         | configKey        | String   |           | 是       |   目前类型两种(tx_count_limit， tx_gas_limit，用户可自定义key如tx_gas_price                                             |
| 4        | 配置的值       | configValue       | String     |              |     是    | tx_gas_limit范围为 [100000, 2147483647]

**2）数据格式**

```
{
    "groupId": 1,
    "fromAddress": "0xd5bba8fe456fce310f529edecef902e4b63129b1",
    "configKey": "tx_count_limit",
    "configValue": "1001"
}
```

示例：

```
curl -l -H "Content-type: application/json" -X POST -d '{"groupId": 1, "fromAddress": "0xd5bba8fe456fce310f529edecef902e4b63129b1", "configKey": "tx_count_limit", "configValue": "1001"}' http://10.0.0.1:5002/WeBASE-Front/sys/config
```

#### 响应参数

a、成功：

```
{
    "code": 0,
    "message": "success"
}
```

b、失败：
```
{
    "code": -50000,
    "message": "permission denied"
}
```


### 6.8. 查询节点接口（节点管理）

#### 接口描述

获取节点的list列表，列表包含节点id，节点共识状态。

注：接口返回所有的共识/观察节点（无论运行或停止），以及正在运行的游离节点

#### 接口URL


**http://localhost:5002/WeBASE-Front/precompiled/consensus/list?groupId={groupId}&pageSize={pageSize}&pageNumber={pageNumber}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
| 1        | 群组ID       | groupId            | int   |              | 是       | 节点所属群组ID                           |
| 2        | 分页大小         | pageSize        | int   |           | 是       | 默认为10
| 3        | 分页页码         | pageNumber        | int   |           | 是       |  默认为1            
      
**2）数据格式**


```
http://localhost:5002/WeBASE-Front/precompiled/consensus/list?groupId=1&pageSize=5&pageNumber=1
```

#### 响应参数

**1）数据格式**
```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "nodeId": "13e0f2b94cbce924cc3737385a38587939e809fb786c4fc34a6ba3ea97693bccfa173b352ac41f1dbb97e9e4910ccbec1df38ad4020cef3b2044e833188adad9",
            "nodeType": "sealer"
        },
        {
            "nodeId": "bce4b2269c25c2cdba30155396bfe90af08c3c08cff205213477683117e4243ebe26588479519e636a5d5d93545cab778435cacacc41993f28f58f60fa5ceb72",
            "nodeType": "sealer"
        },
        {
            "nodeId": "e815cc5637cb8c3274c83215c680822e4a0110d0a8315fcf03e43e8e3944edd758c8b173c4e0076f599aa1f853fa207d47cc95d201ae8d0206b71ad5aa8c3f59",
            "nodeType": "sealer"
        }
    ],
    "totalCount": 3
}
```

### 6.9. 设置节点共识状态接口（节点管理）

#### 接口描述

节点管理相关接口，可用于节点三种共识状态的切换。分别是共识节点sealer, 观察节点observer, 游离节点remove

#### 接口URL

**http://localhost:5002/WeBASE-Front/precompiled/consensus**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**


| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
| 1        | 群组ID       | groupId            | int   |              | 是       | 节点所属群组ID                           |                                             |
| 2        | 管理员地址       | fromAddress | String   |              | 是       |                                                |
| 3        | 节点类型       | nodeType       | String     |              |     是    | 节点类型：observer,sealer,remove 
| 4      | 节点ID         | nodeId        | String   |           | 是       |   节点id，从节点根目录/conf/node.id获取                                             |

**2）数据格式**

```
{
    "groupId": 1,
    "fromAddress": "0xd5bba8fe456fce310f529edecef902e4b63129b1",
    "nodeType": "remove",
    "nodeId": "224e6ee23e8a02d371298b9aec828f77cc2711da3a981684896715a3711885a3177b3cf7906bf9d1b84e597fad1e0049511139332c04edfe3daddba5ed60cffa"
}
```

示例：

```
curl -l -H "Content-type: application/json" -X POST -d '{"groupId": 1, "fromAddress": "0xd5bba8fe456fce310f529edecef902e4b63129b1", "configKey": "tx_count_limit", "configValue": "1001"}' http://10.0.0.1:5002/WeBASE-Front/sys/config
```

#### 响应参数

a、成功：

```
{
    "code": 0,
    "message": "success"
}
```

b、失败：
```
{
    "code": -50000,
    "message": "permission denied"
}
```



### 6.10. CRUD表格操作接口

#### 接口描述

用于操作用户表的CRUD操作，包含create, desc, insert, update, select, remove。

具体sql要求语法参考Fisco-bcos技术文档的  [Precompiled Crud API](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/manual/console.html#create-sql)

#### 接口URL

**http://localhost:5002/WeBASE-Front/precompiled/crud**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**


| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
| 1        | 群组ID       | groupId            | int   |              | 是       | 节点所属群组ID                           |                                             |
| 2        | 管理员地址       | fromAddress | String   |              | 是       |                                                |
| 3        | SQL语句       | sql       | String     |              |     是    | 包含create, desc, insert, update, select, remove，小写

**2）数据格式**

```
{
    "groupId": 1,
    "fromAddress": "0xd5bba8fe456fce310f529edecef902e4b63129b1",
    "sql": "desc t_demo"
}
```

示例：

```
curl -l -H "Content-type: application/json" -X POST -d '{"groupId": 1, "fromAddress": "0xd5bba8fe456fce310f529edecef902e4b63129b1", "sql": "desc t_demo"}' http://10.0.0.1:5002/WeBASE-Front/precompiled/crud
```

#### 响应参数

a、成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "tableName": "t_demo",
        "key": "name",
        "valueFields": "item_id,item_name",
        "optional": "",
        "entry": {
            "fields": {}
        },
        "condition": {
            "conditions": {}
        }
    }
}
```

b、失败：
```
{
    "code": 2012228,
    "message": "table not exists",
    "data": "Table not exists "
}
```



### 6.11. 查询节点证书接口

#### 接口描述

获取Front对应节点的Fisco证书和sdk证书（包含链证书、机构证书和节点证书）的内容；

需要在项目配置文件中`constant-nodePath`配置Front连接节点的绝对路径；

**注：**
> 接口只返回了证书的文本(Base64编码)，未包含开头与结尾以及换行的格式文本；
> 如需将文本保存为一个证书文件，需要加上开头“-----BEGIN CERTIFICATE-----\n”和结尾“\n-----END CERTIFICATE-----\n”；

#### 接口URL


**http://localhost:5002/WeBASE-Front/cert**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|          | -       | -            | -   |              |        |                            |
      
**2）数据格式**

```
http://localhost:5002/WeBASE-Front/cert
```

#### 响应参数

**1）数据格式**

a、成功：

```
{
    "node": "MIICOTCCASGgAwIBAgIJAKHsAYI3TsAOMA0GCSqGSIb3DQEBCwUAMDgxEDAOBgNV\nBAMMB2FnZW5jeUExEzARBgNVBAoMCmZpc2NvLWJjb3MxDzANBgNVBAsMBmFnZW5j\neTAeFw0xOTA3MTIwMjA2MTZaFw0yOTA3MDkwMjA2MTZaMDIxDDAKBgNVBAMMA3Nk\nazETMBEGA1UECgwKZmlzY28tYmNvczENMAsGA1UECwwEbm9kZTBWMBAGByqGSM49\nAgEGBSuBBAAKA0IABJ79rSKIb97xZwByW58xH6tzoNKNLaKG7J5wxAEgAb03O2h4\nMkEMLtf/LB7tELOiyCiIEhLScprb1LjvDDt2RDGjGjAYMAkGA1UdEwQCMAAwCwYD\nVR0PBAQDAgXgMA0GCSqGSIb3DQEBCwUAA4IBAQC0u2lfclRmCszBTi2rtvMibZec\noalRC0sQPBPRb7UQhGCodxmsAT3dBUf+s4wLLrmN/cnNhq5HVObbWxzfu7gn3+IN\nyQEeqdbGdzlu1EDcaMgAz6p2W3+FG/tmx/yrNza29cYekWRL44OT5LOUPEKrJ4bJ\neOBRY4QlwZPFmM0QgP7DoKxHXldRopkmvqT4pbW51hWvPgj7KrdqwbVWzuWQuI3i\n3j3O96XZJsaDZ0+IGa5093+TsTNPfWUZzp5Kg+EyNR6Ea1evuMDNq9NAqqcd5bX9\nO9kgkb8+llO8I5ZhdnN0BuhGvv9wpsa9hW8BImOLzUBwfSVYouGCkoqlVq9X",
    "chain": "MIIDPTCCAiWgAwIBAgIJAMfvnu4d5fHdMA0GCSqGSIb3DQEBCwUAMDUxDjAMBgNV\nBAMMBWNoYWluMRMwEQYDVQQKDApmaXNjby1iY29zMQ4wDAYDVQQLDAVjaGFpbjAe\nFw0xOTA3MTIwMjA2MTZaFw0yOTA3MDkwMjA2MTZaMDUxDjAMBgNVBAMMBWNoYWlu\nMRMwEQYDVQQKDApmaXNjby1iY29zMQ4wDAYDVQQLDAVjaGFpbjCCASIwDQYJKoZI\nhvcNAQEBBQADggEPADCCAQoCggEBAMGsKT/S60cxvFS4tBLyfT0QKPLW1g3ZgMND\n03hrWp1FAnvE9htsDEgqvNLD5hKWaYcUhjQMq0WttiP/vPxkwwJkZhzWhXpdSxMR\nqKVX4BppnkT0ICm84jYSyJdNFjKvfWlBIptIfFuTUDMT+XqF/Ct756JksiUwKZRW\neRAVcYzFM4u4ZuKeaept/8Bv8Z/RlJzGI57qj5BELeA0meUagq2WoCgJrPyvbO0b\nLwogFWS4kEjv20IIdj3fTqeJlooEXtPnuegunSMQB6aIh2im74FfJ3sHuOjQDFuC\nb5ZUiyUHG6IOGCqs+Grk+/VYI16Mx+8OoGBD5koTpK8B+/aedsUCAwEAAaNQME4w\nHQYDVR0OBBYEFLTg2FsUFekx9XjIi01BrDpo0aPIMB8GA1UdIwQYMBaAFLTg2FsU\nFekx9XjIi01BrDpo0aPIMAwGA1UdEwQFMAMBAf8wDQYJKoZIhvcNAQELBQADggEB\nAJmuMLhWSld8G6i3Vw21TN/d2rSRg3hNqOyycPYtdVK1YXEj4Xm91qgL8An3Kui8\njSq1S9+PstGvyh14YUw43Y1VtEPGpNVTvDtkxQ/8rs1sGHbqUxshgFMbqruxp7WH\ns0fxgn5COHEnRC4jQn02wZAk8pIjFVZLkhqdIYBtC35buHr17mXNL0S4H5cJxzPN\nk3XtKBqXedkTrEsDhR/bZ6qDDq0BcduhtKiYVPiVw9z3moLuwDb0QDM59zCexpcz\nb/w7K4lIxWqpD5tbpKSmj/3v5TCqez0Mim8/j4q29bP913KQrngnVCdCezOsPWIH\nDDoihgeRQHuz1VuGGZ259Hc=",
    "agency": "MIIDADCCAeigAwIBAgIJAJUF2Dp1a9U6MA0GCSqGSIb3DQEBCwUAMDUxDjAMBgNV\nBAMMBWNoYWluMRMwEQYDVQQKDApmaXNjby1iY29zMQ4wDAYDVQQLDAVjaGFpbjAe\nFw0xOTA3MTIwMjA2MTZaFw0yOTA3MDkwMjA2MTZaMDgxEDAOBgNVBAMMB2FnZW5j\neUExEzARBgNVBAoMCmZpc2NvLWJjb3MxDzANBgNVBAsMBmFnZW5jeTCCASIwDQYJ\nKoZIhvcNAQEBBQADggEPADCCAQoCggEBANBT4CTciIYdSeEabgJzif+CFB0y3GzG\ny+XQYtWK+TtdJWduXqhnnZiYAZs7OPGEu79Yx/bEpjEXsu2cXH0D6BHZk+wvuxG6\nezXWq5MYjCw3fQiSRWkDYoxzWgulkRyYROF1xoZeNGQssReFmCgP+pcQwRxjcq8z\nIA9iT61YxyW5nrS7xnra9uZq/EE3tsJ0ae3ax6zixCT66aV49S27cMcisS+XKP/q\nEVPxhO7SUjnzZY69MgZzNSFxCzIbapnlmYAOS26vIT0taSkoKXmIsYssga45XPwI\n7YBVCc/34kHzW9xrNjyyThMWOgDsuBqZN9xvapGSQ82Lsh7ObN0dZVUCAwEAAaMQ\nMA4wDAYDVR0TBAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAQEAu3aHxJnCZnICpHbQ\nv1Lc5tiXtAYE9aEP5cxb/cO14xY8dS+t0wiLIvyrE2aTcgImzr4BYNBm1XDt5suc\nMpzha1oJytGv79M9/WnI/BKmgUqTaaXOV2Ux2yPX9SadNcsD9/IbrV0b/hlsPd6M\nK8w7ndowvBgopei+A1NQY6jTDUKif4RxD4u5HZFWUu7pByNLFaydU4qBKVkucXOq\nxmWoupL5XrDk5o490kiz/Zgufqtb4w6oUr3lrQASAbFB3lID/P1ipi0DwX7kZwVX\nECDLYvr+eX6GbTClzn0JGuzqV4OoRo1rrRv+0tp1aLZKpCYn0Lhf6s1iw/kCeM2O\nnP9l2Q=="
}
```

b、失败：
```
{
    "code": 201231,
    "message": "Cert file not found, please check cert path in config",
    "data": "FileNotFound, node cert(node.crt) path prefix error"
}
```

## 7. 链上事件订阅接口

### 7.1. 获取出块事件的订阅信息列表

#### 接口描述

获取所有订阅的出块事件配置信息

将返回对应的id值, exchange, queue, routingKey等信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/event/newBlockEvent/list/{pageNumber}/{pageSize}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|     1    | 页码         | pageNumber            | int   |              | 否       | 同时缺省则返回全量数据                           |
|     2    | 页大小       | pageSize            | int   |              | 否       |    同时缺省则返回全量数据                        |


**2）数据格式**

```
http://localhost:5002/WeBASE-Front/event/newBlockEvent/list/{pageNumber}/{pageSize}
```

#### 响应参数

**1）数据格式**

成功：

```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "id": "8aba82b570f22a750170f22bcab90000",
            "eventType": 1,
            "appId": "app2",
            "groupId": 1,
            "exchangeName": "group001",
            "queueName": "app2",
            "routingKey": "app2_block_b63",
            "createTime": "2020-03-19 17:42:01"
        }
    ],
    "totalCount": 1
}
```


### 7.2. 获取出块事件的订阅信息

#### 接口描述

根据群组编号，应用编号获取该应用订阅的出块事件配置信息

将返回对应的id值, exchange, queue, routingKey等信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/event/newBlockEvent/{groupId}/{appId}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|     1    | 群组编号       | groupId            | int   |              | 是       |                            |
|     2    | 应用编号       | appId            | String   |              | 是       |                            |


      
**2）数据格式**

```
http://localhost:5002/WeBASE-Front/event/newBlockEvent/{groupId}/{appId}
```

#### 响应参数

**1）数据格式**

成功：

```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "id": "8aba82b570f22a750170f22bcab90000",
            "eventType": 1,
            "appId": "app2",
            "groupId": 1,
            "exchangeName": "group001",
            "queueName": "app2",
            "routingKey": "app2_block_b63",
            "createTime": "2020-03-19 17:42:01"
        }
    ]
}
```

### 7.3. 订阅出块事件通知

#### 接口描述

订阅后将在消息队列中获取出块的事件通知

#### 接口URL

**http://localhost:5002/WeBASE-Front/event/newBlockEvent**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**   | **类型**       | **最大长度** | **必填** | **说明**                           |
| -------- | -------- | ------------ | -------------- | ------------ | -------- | -------------- |
| 1        | 应用编号 | appId | String         |              | 是        |   注册事件通知的应用的唯一编号，仅支持数字字母和下划线                   |
| 2        | 所属群组 | groupId | Integer         |              | 是        |                      |
| 3        | 交换机名字 | exchangeName      | String         |              | 是       |     队列所属交换机                   |
| 4        | 队列名  | queueName      | String   |              | 是       | 队列名，以appId作队列名  |


**2）数据格式**


```
{
    "appId": "app1",
    "groupId": 1,
    "exchangeName": "group001",
    "queueName": "app1"
}
```

#### 响应参数

**1）数据格式** 

成功：
```
{
    "code": 0,
    "message": "success"
}
```

失败（如：重复订阅）
```
{
    "code": 201242,
    "errorMessage": "This data is already in db."
}
```


### 7.4. 取消订阅出块事件通知

#### 接口描述

取消在消息队列中获取出块的事件通知的订阅

#### 接口URL

**http://localhost:5002/WeBASE-Front/event/newBlockEvent**

#### 调用方法

HTTP DELETE

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**   | **类型**       | **最大长度** | **必填** | **说明**                           |
| -------- | -------- | ------------ | -------------- | ------------ | -------- | -------------- |
| 1        | 数据编号 | id    | String         |              | 是        |   注册事件通知数据的唯一编号，可通过GET接口获取                  |
| 2        | 应用编号 | appId | String         |              | 是        |   注册事件通知的应用的唯一编号                   |
| 3        | 所属群组 | groupId | Integer         |              | 是        |                      |
| 4        | 交换机名字 | exchangeName      | String         |              | 是       |     队列所属交换机                   |
| 5        | 队列名  | queueName      | String   |              | 是       | 队列名，以appId作队列名  |


**2）数据格式**

```
{
    "id":"8aba82b5707a1f5701707a248c340000",
    "appId": "app1",
    "groupId": 1,
    "exchangeName": "group001",
    "queueName": "app1"
}
```

#### 响应参数

**1）数据格式** 

成功：
```
{
    "code": 0,
    "message": "success"
}
```


### 7.5. 获取合约Event事件订阅信息列表

#### 接口描述

获取所有订阅的合约Event事件配置信息

将返回对应的id值, exchange, queue, routingKey及合约Event配置内容(fromBlock, toBlock, contractAddress..)等信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/event/contractEvent/list/{pageNumber}/{pageSize}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|     1    | 页码         | pageNumber            | int   |              | 否       | 同时缺省则返回全量数据                           |
|     2    | 页大小       | pageSize            | int   |              | 否       |    同时缺省则返回全量数据                        |


**2）数据格式**

```
http://localhost:5002/WeBASE-Front/event/contractEvent/list/{pageNumber}/{pageSize}
```

#### 响应参数

**1）数据格式**

成功：

```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "id": "8aba82b57076ae09017076ae403a0001",
            "eventType": 2,
            "appId": "app1",
            "groupId": 1,
            "exchangeName": "group001",
            "queueName": "app1",
            "routingKey": "app1_event_b3c",
            "contractAbi": "[{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"name\":\"name\",\"type\":\"string\"}],\"name\":\"SetName\",\"type\":\"event\"}]",
            "fromBlock": "latest",
            "toBlock": "latest",
            "contractAddress": "0x657201d59ec41d1dc278a67916f751f86ca672f7",
            "topicList": "SetName(string)"
        }
    ],
    "totalCount":1
}
```



### 7.6. 获取合约Event事件订阅信息

#### 接口描述

根据群组编号，应用编号获取该应用订阅的合约Event事件配置信息

将返回对应的id值, exchange, queue, routingKey及合约Event配置内容(fromBlock, toBlock, contractAddress..)等信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/event/contractEvent/{groupId}/{appId}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|     1    | 群组编号       | groupId            | int   |              | 是       |                            |
|     2    | 应用编号       | appId            | String   |              | 是       |                            |

      
**2）数据格式**

```
http://localhost:5002/WeBASE-Front/event/contractEvent/{groupId}/{appId}
```

#### 响应参数

**1）数据格式**

成功：

```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "id": "8aba82b57076ae09017076ae403a0001",
            "eventType": 2,
            "appId": "app1",
            "groupId": 1,
            "exchangeName": "group001",
            "queueName": "app1",
            "routingKey": "app1_event_b3c",
            "contractAbi": "[{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"name\":\"name\",\"type\":\"string\"}],\"name\":\"SetName\",\"type\":\"event\"}]",
            "fromBlock": "latest",
            "toBlock": "latest",
            "contractAddress": "0x657201d59ec41d1dc278a67916f751f86ca672f7",
            "topicList": "SetName(string)",
            "createTime": "2020-02-26 16:21:12"
        }
    ]
}
```


### 7.7. 订阅合约event事件通知

#### 接口描述

订阅后将在消息队列中获取相应智能合约的event事件通知

#### 接口URL

**http://localhost:5002/WeBASE-Front/event/contractEvent**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**   | **类型**       | **最大长度** | **必填** | **说明**                           |
| -------- | -------- | ------------ | -------------- | ------------ | -------- | -------------- |
| 1        | 应用编号 | appId | String         |              | 是        |   注册事件通知的应用的唯一编号，仅支持数字字母和下划线                   |
| 2        | 所属群组 | groupId | Integer         |              | 是        |                      |
| 3        | 交换机名字 | exchangeName      | String         |              | 是       |     队列所属交换机                   |
| 4        | 队列名  | queueName      | String   |              | 是       | 队列名，以appId作队列名  |
| 5        | 合约abi  | contractAbi | List<Object>         |     |  是      | 合约的ABI，用于合约event解析 |
| 6        | event起始区块  | fromBlock | String         |     | 是       | 默认`latest`，表示一直监听最新区块，最小值为1|
| 7        | event末区块  | toBlock | String         |     | 是       |最小值为1，最大值为当前区块高度，需   要大于等于`fromBlock`；填写`latest`，表示一直监听最新区块|
| 8        | 合约地址  | contractAddress | String   |     | 是       |合约地址 |
| 9        | 合约event列表  | topicList | List<String>         |     |  是    | List类型，合约Event事件列表，Event参数之间不带空格|

**2）数据格式**


```
{
    "appId": "app2",
    "groupId": 1,
    "exchangeName": "group001",
    "queueName": "app2",
    "contractAbi": [{"constant":false,"inputs":[{"name":"n","type":"string"}],"name":"set","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"get","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"anonymous":false,"inputs":[{"indexed":false,"name":"name","type":"string"}],"name":"SetName","type":"event"}],
    "fromBlock": "latest",
    "toBlock": "latest",
    "contractAddress": "0x657201d59ec41d1dc278a67916f751f86ca672f7",
    "topicList": ["SetName(string)","TransferEvent(string,address)"],
    "createTime": "2020-02-26 16:21:12"
}
```
#### 响应参数

**1）数据格式** 

成功：
```
{
    "code": 0,
    "message": "success"
}
```

失败（如：重复订阅）
```
{
    "code": 201242,
    "errorMessage": "This data is already in db."
}
```

### 7.8. 取消合约Event事件通知的订阅

#### 接口描述

取消在消息队列中获取合约Event事件通知的订阅

#### 接口URL

**http://localhost:5002/WeBASE-Front/event/contractEvent**

#### 调用方法

HTTP DELETE

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**   | **类型**       | **最大长度** | **必填** | **说明**                           |
| -------- | -------- | ------------ | -------------- | ------------ | -------- | -------------- |
| 1        | 数据编号 | id    | String         |              | 是        |   注册事件通知数据的唯一编号，可通过GET接口获取                  |
| 2        | 应用编号 | appId | String         |              | 是        |   注册事件通知的应用的唯一编号                   |
| 3        | 所属群组 | groupId | Integer         |              | 是        |                      |
| 4        | 交换机名字 | exchangeName      | String         |              | 是       |     队列所属交换机                   |
| 5        | 队列名  | queueName      | String   |              | 是       | 队列名，以appId作队列名  |


**2）数据格式**


```
{
    "id": "8aba82b57076ae09017076ae403a0001",
    "appId": "app2",
    "groupId": 1,
    "exchangeName": "group001",
    "queueName": "app2"
}
```

#### 响应参数

**1）数据格式** 

成功则返回该app中剩余已订阅的合约Event事件通知：
```
{
    "code": 0,
    "message": "success",
    "data": []
}
```

## 8. Abi管理接口

### 8.1. 获取Abi信息

#### 接口描述

根据abiId获取abi信息

#### 接口URL


**http://localhost:5002/WeBASE-Front/abi/{abiId}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|    1     | abi编号       | abiId           | Long   |              |   是    |    abi编号                        |
      
**2）数据格式**

```
http://localhost:5002/WeBASE-Front/abi/{abiId}
```

#### 响应参数

**1）数据格式**

a、成功：

```
{
  "code": 0,
  "message": "success",
  "data": {
    "abiId": 1,
    "groupId": 1,
    "contractName": "TTT",
    "contractAddress": "0x3214227e87bccca63893317febadd0b51ade735e",
    "contractAbi": "[{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\"}],\"name\":\"setSender\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"name\":\"name\",\"type\":\"string\"}],\"name\":\"SetName\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"name\":\"\",\"type\":\"uint256[2]\"}],\"name\":\"EventList\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"name\":\"sender\",\"type\":\"address\"}],\"name\":\"SetSender\",\"type\":\"event\"}]",
    "contractBin": "608060405260043610610057576000357...",
    "createTime": "2020-05-18 10:59:02",
    "modifyTime": "2020-05-18 10:59:02"
  }
}
```

### 8.2. 获取Abi信息分页列表

#### 接口描述

获取abi信息的列表

#### 接口URL


**http://localhost:5002/WeBASE-Front/abi/list/{groupId}/{pageNumber}/{pageSize}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|    1     | 群组id       | groupId           | int   |              |   是     |    群组编号                        |
|    2     | 页码         | pageNumber            | int   |              | 是       |                            |
|    3     | 页大小       | pageSize            | int   |              | 是       |                            |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/abi/list/{groupId}/{pageNumber}/{pageSize}
```

#### 响应参数

**1）数据格式**

a、成功：

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "abiId": 1,
      "groupId": 1,
      "contractName": "TTT",
      "contractAddress": "0x3214227e87bccca63893317febadd0b51ade735e",
      "contractAbi": "[{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\"}],\"name\":\"setSender\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"name\":\"name\",\"type\":\"string\"}],\"name\":\"SetName\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"name\":\"\",\"type\":\"uint256[2]\"}],\"name\":\"EventList\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"name\":\"sender\",\"type\":\"address\"}],\"name\":\"SetSender\",\"type\":\"event\"}]",
      "contractBin": "608060405260043610610057576000357c0100000000000000000000000000000000000000000000000000000000900463fffff...29",
      "createTime": "2020-05-18 10:59:02",
      "modifyTime": "2020-05-18 10:59:02"
    }
  ],
  "totalCount": 1
}
```

### 8.3. 导入已部署合约的abi

#### 接口描述

将其他平台已部署的合约导入到本平台进行管理

#### 接口URL

**http://localhost:5002/WeBASE-Front/abi**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**   | **类型**       | **最大长度** | **必填** | **说明**                           |
| -------- | -------- | ------------ | -------------- | ------------ | -------- | -------------- |
| 1        | 所属群组 | groupId | Integer         |              | 是        |                      |
| 2        | 合约地址 | contractAddress    | String         |              | 是       |     合约地址                   |
| 3        | 合约名  | contractName      | String   |              | 是       |   |
| 4        | 合约abi  | contractAbi | List<Object>         |     |  是      | 合约的ABI |

**2）数据格式**


```
{
    "groupId": 1,
    "contractAddress": "0x3214227e87bccca63893317febadd0b51ade735e",
    "contractName": "HelloWorld",
    "contractAbi": [{"constant":false,"inputs":[{"name":"n","type":"string"}],"name":"set","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"get","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"anonymous":false,"inputs":[{"indexed":false,"name":"name","type":"string"}],"name":"SetName","type":"event"}]
}
```
#### 响应参数

**1）数据格式** 

成功：
```
{
    "code": 0,
    "message": "success"
}
```

### 8.4. 修改已导入的合约abi

#### 接口描述

更新已导入的合约abi内容

#### 接口URL

**http://localhost:5002/WeBASE-Front/abi**

#### 调用方法

HTTP PUT

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**   | **类型**       | **最大长度** | **必填** | **说明**                           |
| -------- | -------- | ------------ | -------------- | ------------ | -------- | -------------- |
| 1        | abi编号 | abiId   | Long         |              | 是        |                      |
| 2        | 所属群组 | groupId | Integer         |              | 是        |                      |
| 3        | 合约地址 | contractAddress    | String         |              | 是       |     合约地址                   |
| 4        | 合约名  | contractName      | String   |              | 是       |   |
| 5        | 合约abi  | contractAbi | List<Object>         |     |  是      | 合约的ABI |

**2）数据格式**


```
{
    "abiId": 1,
    "groupId": 1,
    "contractAddress": "0x3214227e87bccca63893317febadd0b51ade735e",
    "contractName": "HelloWorld",
    "contractAbi": [{"constant":false,"inputs":[{"name":"n","type":"string"}],"name":"set","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"get","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"anonymous":false,"inputs":[{"indexed":false,"name":"name","type":"string"}],"name":"SetName","type":"event"}]
}
```
#### 响应参数

**1）数据格式** 

成功：
```
{
    "code": 0,
    "message": "success"
}
```

### 8.5. 修改合约abi

#### 接口描述

删除合约abi

#### 接口URL

**http://localhost:5002/WeBASE-Front/abi/{abiId}**

#### 调用方法

HTTP DELETE

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**   | **类型**       | **最大长度** | **必填** | **说明**                           |
| -------- | -------- | ------------ | -------------- | ------------ | -------- | -------------- |
| 1        | abi编号 | abiId   | Long         |              | 是        |                      |

**2）数据格式**


```
{
    "abiId": 1
}
```
#### 响应参数

**1）数据格式** 

成功：
```
{
    "code": 0,
    "message": "success"
}
```


## 9. 其他接口

### 9.1. 查询是否使用国密

#### 接口描述

获取WeBASE-Front的`encryptType`，即是否使用国密版；

#### 接口URL

**http://localhost:5002/WeBASE-Front/encrypt**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|          | -       | -            | -   |              |        |                            |
      
**2）数据格式**

```
http://localhost:5002/WeBASE-Front/encrypt
```

#### 响应参数

**1）数据格式**

a、成功：

```
{
    1 // 1: 国密版，0: 非国密
}
```


## 10. 附录

### 1. 返回码信息列表 


| code   | message                                      | 描述                       |
| ------ | -------------------------------------------- | -------------------------- |
| 0      | success                                      | 成功                       |
| 101001 | system error                                 | 系统异常                   |
| 101002 | param valid fail                             | 参数校验异常               |
| 101003 | web3jMap of groupId is null, please call /{groupId}/web3/refresh to refresh  | 连接当前群组失败，请调用/{groupId}/web3/refresh刷新群组               |
| 101004 | groupList error for no group, web3jMap is empty | 群组列表为空，请检查节点共识状态|
| 201001 | groupId cannot be empty                      | 群组编号不能为空           |
| 201002 | user cannot be empty                         | 用户地址不能为空               |
| 201003 | useAes cannot be empty                       | 是否为加密私钥不能为空      |
| 201004 | version cannot be empty                      | 合约版本不能为空           |
| 201005 | funcName cannot be empty                     | 方法名不能为空             |
| 201006 | abiInfo cannot be empty                      | abi内容不能为空            |
| 201007 | bytecodeBin cannot be empty                  | 合约bin不能为空            |
| 201008 | contract's current version has been deployed | 该合约版本已部署           |
| 201009 | contract is not deployed                     | 合约未部署                 |
| 201010 | save abi error                               | abi保存错误                |
| 201011 | contract funcParam is error                  | 请求的方法参数错误         |
| 201012 | requst blockNumber is greater than latest    | 请求块高大于最新块高       |
| 201013 | get abi from chain error                     | 获取合约abi错误            |
| 201014 | contract deploy error                        | 合约部署错误               |
| 201015 | user's privateKey is null                    | 用户私钥为空               |
| 201016 | file is not exist                            | 文件不存在                 |
| 201017 | failed to get node config                    | 获取节点配置失败           |
| 201018 | blockNumber and pbftView unchanged           | 块高和view没有变化         |
| 201019 | request function is error                    | 请求的方法错误             |
| 201020 | transaction query from chain failed          | 交易查询失败               |
| 201021 | transaction send to chain failed             | 交易上链失败               |
| 201022 | node request failed                          | 节点请求失败               |
| 201023 | contract already exists                      | 合约已经存在               |
| 201024 | contract name cannot be repeated             | 合约名不能重复             |
| 201025 | invalid contract id                          | 无效的合约编号             |
| 201026 | contract has been deployed                   | 合约已部署                 |
| 201027 | send abiInfo fail                            | 发送abi失败                |
| 201028 | bytecodeBin is null                          | 合约bin为空                |
| 201029 | contractAddress is null                      | 合约地址为空               |
| 201030 | contractAddress invalid                      | 合约地址无效               |
| 201031 | privateKey decode fail                       | 私钥编码失败               |
| 201032 | not found config of keyServer                | 密钥服务未配置             |
| 201033 | data request sign error                      | 数据请求签名异常           |
| 201034 | groupId not exist                            | 群组编号不存在             |
| 201035 | version and address cannot all be  null      | 合约版本和地址不能同时为空 |
| 201036 | compile fail                                 | 合约编译失败               |
| 201037 | user name is null                            | 用户名为空                 |
| 201038 | user name already exists                     | 用户名已存在               |
| 201039 | private key already exists                   | 私钥已存在                 |
| 201040 | private key not exists                       | 私钥不存在                 |
| 201041 | external user's appId and signUserId cannot be empty        | 外部用户的appId和signUserId不能为空  |
| 201042 | There is no sol files in source              | solidity文件不存在                 |
| 201043 | invalid group operate type                   | 群组操作类型不正确                 |
| 201044 | invalid data type                            | 不正确的数据类型                 |
| 201101  | groupId cannot be empty                   |    群组编号不能为空      | 
| 201102  | tableName cannot be empty         |    表名不能为空      |
| 201103  | permissionType cannot be empty             |    权限类型不能为空      |
| 201104  | permissionType not exists             |    权限类型不存在      |
| 201105  | from address cannot be empty             |    管理员地址不能为空      |
| 201106  | contract name cannot be empty             |    合约名不能为空      |
| 201107  | system config key cannot be empty    |  系统配置key值不能为空    |
| 201108  | system config value cannot be empty      |    系统配置value值不能为空 |
| 201109  | node id cannot be empty                 |    节点id不能为空      |
| 201110  | node type cannot be empty           |   节点类型（共识状态不能为空） |
| 201111  | Permission state cannot be all empty           |   更新的用户权限状态不能为空 |
| 201112  | contract address cannot be empty           |   合约地址不能为空 |
| 201113  | contract handle type cannot be empty          |   合约操作类型不能为空 |
| 201114  | grantAddress cannot be empty          |   赋值的地址不能为空 |
| 201115  | invalid contract handle type          |   不正确的合约操作类型 |
| 201116  | contract status handle fail         |   合约状态修改失败 |
| 201120  | group operate fail          |   群组操作失败 |
| 201121  | node internal error          |   节点内部错误 |
| 201122  | group already exists          |  群组已存在 |
| 201123  | group already running          |   群组已运行 |
| 201124  | group already stopped          |   群组已停止 |
| 201125  | group already deleted          |   群组已删除 |
| 201126  | group not found          |   未找到群组 |
| 201127  | group operate param error          |   群组操作入参错误 |
| 201128  | group peers not connected          |   群组内节点未连接 |
| 201129  | group genesis conf already exists          |   群组创世块文件已存在 |
| 201130  | group config.ini already exists          |   群组的配置文件已存在 |
| 201131  | group genesis conf not found          |   未找到群组创世块文件 |
| 201132  | group config.ini not found          |   未找到群组的配置文件 |
| 201133  | group is stopping          |   群组正在停止 |
| 201134  | group not deleted          |   群组未删除 |
| 201151  | Unsupported contract param type to encoded           |   不支持编码的合约参数类型 |
| 201152  | Unsupported contract param type to decoded           |   不支持解码的合约参数类型 |
| 201153  | unable to create instance of type, check input params           |  无法创建该合约参数类型的实例，请检查入参 |

| 201200  | params not fit             |    参数不符合要求      |
| 201201  | address is invalid           |    账户地址不正确      |
| 201202  | permission denied, please check chain administrator permission           |    权限不足，请检查用户 |

| 201208  | unsupported for this system config key     |    不支持设置该系统配置      |
| 201209  | provide value by positive integer mode, from 100000 to 2147483647              |    请输入正值或[100000, 2147483647]范围的值      |
| 201210  | set system config value fail for params error or permission denied               |    设置系统配置失败，请检查权限      |
| 201211  | query system config value list fail    |    获取系统配置列表失败      |
| 201216  | node id is invalid     |    节点id错误      |
| 201217  | invalid node type: sealer, observer, remove  |  节点类型（共识状态）错误：sealer, observer, remove    |
| 201218  | set node consensus type fail, check permission or node's group config file  |  节点类型（共识状态）修改失败，请检查权限或节点群组配置文件  |
| 201221  | Contract version should only contains 'A-Z' or 'a-z' or '0-9' or dot mark  |    CNS合约版本号应只包含大小写字母、数字和"."      |
| 201222  | version of contract is out of length |    合约版本号过长      |
| 201226  | sql syntax error              |    sql语句错误      |
| 201227  | crud sql fail              |    执行sql语句失败      |
| 201228  | table not exists              |    操作的表格不存在      |
| 201231  | Cert file not found, please check cert path in config |     配置文件中的证书地址错误，未找到证书文件     |
| 201232  | Pem file format error, must surrounded by -----XXXXX PRIVATE KEY----- |     pem证书格式错误，必须以"-----XXXXX PRIVATE KEY-----"开头结尾     |
| 201233  | Pem file content error |     pem证书内容错误     |
| 201235  | p12's password cannot be chinese |     p12证书密码不能是中文  |
| 201236  | p12's password not match |     p12证书密码错误     |
| 201237  | P12 file content error |     p12证书内容错误     |
| 201241  | Exchange or message queue not exists, please check mq server or mq configuration |     交换机或消息队列不存在，请检查mq-server运行状态及其配置     |
| 201242  | Database error: data already exists in db |     数据库错误：该数据记录已存在于数据库中     |
| 201243  | Block range error, from/toBlock must greater than 0, toBlock must be greater than fromBlock |  合约Event区块范围错误，from大于0，to大于from     |
| 201244  | Database error: data not exists in db, please check your params |     该数据记录不存在，请检查参数     |
| 201245  | Only support letter and digit, please check your params |     仅支持使用数字字母与下划线，请检查参数     |
| 201246  | Register contractEvent failed, please check your param |     订阅合约事件失败，请检查参数格式     |
| 201247  | Unregister event failed, please check mq server exchange |     取消订阅事件失败，请检查参数格式     |
| 201248  | Contract abi invalid, please check abi          |     合约ABI格式错误，请检查入参     |
| 201255  | contract address already exists          |     合约地址已存在 |
| 201256  | abi info of this id not exists          |     abi不存在     |
| 201257  | Abi Id cannot be empty          |   abi编号不能为空       |


### 2. Precompiled Service说明

对预编译合约接口的使用有疑惑，可以查看FISCO BCOS的[PreCompiledService API说明](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/sdk/java_sdk.html#precompiled-service-api)

查看预编译合约的solidity接口代码，可以查看FISCO BCOS的[web3sdk precompile模块](https://github.com/FISCO-BCOS/web3sdk/tree/master/src/main/java/org/fisco/bcos/web3j/precompile)，如crud/TableFactory.sol:

```
pragma solidity ^0.4.2;

contract TableFactory {
    function createTable(string tableName, string key, string valueField) public returns (int);
}
```

查看FISCO BCOS中实现的precompild合约列表、地址分配及源码：

| 地址   | 功能   | 源码([libprecompiled目录](https://github.com/FISCO-BCOS/FISCO-BCOS/tree/master/libprecompiled)) |
|--------|--------|---------|
| 0x1000 | 系统参数管理 | SystemConfigPrecompiled.cpp |
| 0x1001 | 表工厂合约 | TableFactoryPrecompiled.cpp |
| 0x1002 | CRUD合约 | CRUDPrecompiled.cpp |
| 0x1003 | 共识节点管理 | ConsensusPrecompiled.cpp |
| 0x1004 | CNS功能  | CNSPrecompiled.cpp |
| 0x1005 | 存储表权限管理 | AuthorityPrecompiled.cpp |
| 0x1006 | 并行合约配置 | ParallelConfigPrecompiled.cpp |


**Precompiled Service API 错误码**

| 错误码 | 消息内容                                          | 备注      |
| :----- | :----------------------------------------------  | :-----   |
| 0      | success                                          |          |
| -50000  | permission denied                               |          |
| -50001  | table name already exist                        |          |
| -50100  | unknow function call                            |          |
| -50101  | table does not exist                            |          |
| -51000  | table name and address already exist            |          |
| -51001  | table name and address does not exist           |          |
| -51100  | invalid node ID                                 | SDK错误码 |
| -51101  | the last sealer cannot be removed               |           |
| -51102  | the node is not reachable                       | SDK错误码 |
| -51103  | the node is not a group peer                    | SDK错误码 |
| -51104  | the node is already in the sealer list          | SDK错误码 |
| -51105  | the node is already in the observer list        | SDK错误码 |
| -51200  | contract name and version already exist         | SDK错误码 |
| -51201  | version string length exceeds the maximum limit | SDK错误码 |
| -51300  | invalid configuration entry                     |          |
| -51500  | contract name and version already exist         |          |
| -51501  | condition parse error                           |          |
| -51502  | condition operation undefined                   |          |

