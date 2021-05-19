
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

<span id="deployWithSign"></span>
### 1.2. 合约部署接口（结合WeBASE-Sign）

#### 接口描述

> 将合约部署到当前节点。此接口需结合WeBASE-Sign使用，通过调用WeBASE-Sign服务的签名接口让相关用户对数据进行签名，拿回签名数据再发送上链。需要调用此接口时，工程配置文件application.yml中的配置"keyServer"需配置WeBASE-Sign服务的ip和端口，并保证WeBASE-Sign服务正常和存在相关用户。
>
> 构造方法参数（funcParam）为JSON数组，多个参数以逗号分隔（参数为数组时同理），示例：
>
> ```
> constructor(string s) -> ["aa,bb\"cc"]	// 双引号要转义
> constructor(uint n,bool b) -> [1,true]
> constructor(bytes b,address[] a) -> ["0x1a",["0x7939E26070BE44E6c4Fc759Ce55C6C8b166d94BE","0xce867fD9afa64175bb50A4Aa0c17fC7C4A3C67D9"]]
> ```


构造方法参数（funcParam）为JSON数组，多个参数以逗号分隔（参数为数组时同理），示例：

```
constructor(string s) -> ["aa,bb\"cc"]  // 双引号要转义
constructor(uint n,bool b) -> [1,true]
constructor(bytes b,address[] a) -> ["0x1a",["0x7939E26070BE44E6c4Fc759Ce55C6C8b166d94BE","0xce867fD9afa64175bb50A4Aa0c17fC7C4A3C67D9"]]
```

*查看WeBASE-Front通过本地私钥（测试用户）部署合约的接口（非WeBASE-Sign签名交易），可查看[其他接口-合约部署接口（本地签名）](#deployNoSign)*

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
| 6        | 构造函数参数 | funcParam    | List     |              | 否       | 合约构造函数所需参数，JSON数组，多个参数以逗号分隔（参数为数组时同理），如：["str1",["arr1","arr2"]] |
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

<span id="deployNoSign"></span>

### 1.3. 合约部署接口(本地签名)

#### 接口描述

此接口为WeBASE-Front使用**本地私钥（页面中的测试用户）进行签名**

> 将合约部署到当前节点。
>
> 构造方法参数（funcParam）为JSON数组，多个参数以逗号分隔（参数为数组时同理），示例：
>
> ```
> constructor(string s) -> ["aa,bb\"cc"]    // 双引号要转义
> constructor(uint n,bool b) -> [1,true]
> constructor(bytes b,address[] a) -> ["0x1a",["0x7939E26070BE44E6c4Fc759Ce55C6C8b166d94BE","0xce867fD9afa64175bb50A4Aa0c17fC7C4A3C67D9"]]
> ```

构造方法参数（funcParam）为JSON数组，多个参数以逗号分隔（参数为数组时同理），示例：

```
constructor(string s) -> ["aa,bb\"cc"]  // 双引号要转义
constructor(uint n,bool b) -> [1,true]
constructor(bytes b,address[] a) -> ["0x1a",["0x7939E26070BE44E6c4Fc759Ce55C6C8b166d94BE","0xce867fD9afa64175bb50A4Aa0c17fC7C4A3C67D9"]]
```

*查看WeBASE-Front通过WeBASE-Sign部署合约的接口（非本地私钥签名交易），可查看[合约接口-合约部署接口（结合WeBASE-Sign）](#deployWithSign)*


#### 接口URL

**http://localhost:5002/WeBASE-Front/contract/deploy**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**   | **类型** | **最大长度** | **必填** | **说明**                                                     |
| -------- | ------------ | ------------ | -------- | ------------ | -------- | ------------------------------------------------------------ |
| 1        | 所属群组     | groupId      | int      |              | 是       |                                                              |
| 2        | 用户地址     | user         | String   |              | 是       | 用户地址，可通过`/privateKey`接口创建                        |
| 3        | 合约名称     | contractName | String   |              | 是       |                                                              |
| 4        | 合约abi      | abiInfo      | List     |              | 是       | 合约编译后生成的abi文件内容                                  |
| 5        | 合约bin      | bytecodeBin  | String   |              | 是       | 合约编译的bytecode(bin)，用于部署合约                        |
| 6        | 构造函数参数 | funcParam    | List     |              | 否       | 合约构造函数所需参数，JSON数组，多个参数以逗号分隔（参数为数组时同理），如：["str1",["arr1","arr2"]] |
| 7        | 合约版本     | version      | String   |              | 否       | 用于指定合约在CNS中的版本                                    |

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

### 1.4. java转译接口


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

### 1.5. 保存合约接口

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

### 1.6. 删除合约接口

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


### 1.7. 分页查询合约列表

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
| 5        | 当前页码 | pageNumber | Integer         |       | 是       | 从1开始 |
| 6        | 每页记录数 | pageSize | Integer         |       | 是       |  |
| 7        | 合约路径 | contractPath | String         |      | 否       |           |


**2）数据格式**
```
{
    "groupId": "1",
    "pageNumber": 1,
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

### 1.8. 合约是否被修改接口

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

### 1.9. 后台编译合约

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
| 3        | 合约bin  | bytecodeBin | String         |     | 是       | |   合约编译的bytecode(bin)，用于部署合约|
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

### 1.10. 多合约编译

#### 接口描述

> 接口参数为合约文件压缩成zip并Base64编码后的字符串。合约文件需要放在同级目录压缩，涉及引用请使用"./XXX.sol"。可参考测试类ContractControllerTest的testMultiContractCompile()方法。国密和非国密编译的bytecodeBin不一样，以下以国密为例。

#### 接口URL

**http://localhost:5002/WeBASE-Front/contract/multiContractCompile**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**        | **类型** | **最大长度** | **必填** | **说明**                        |
| -------- | -------- | ----------------- | -------- | ------------ | -------- | ------------------------------- |
| 1        | 合约源码 | contractZipBase64 | String   |              | 是       | 合约文件压缩成zip，并Base64编码 |

**2）数据格式**

```
{
    "contractZipBase64": "UEsDBBQAAAAIAIqMeFAi98KgkQAAAPwAAAAOAAAASGVsbG9Xb3JsZC5zb2xdjjELwjAQhfdC/8ON7VJE3Iq7k4uDmxDSMwSSi1yugkj/u7GJNPjGe/e+9x6sjFcQg7OTlRfcdsNh2I9towMJKy1wQufCNbCb3m0DSVHYkgFSHsd8wSeSwAXlnG5d5ffl4T6TFhsIDErXJ3QUlRKMMjPFkui//Kzi1B3LHykm0q+pTqK32xRaB2StsCNtuOUDUEsBAj8AFAAAAAgAiox4UCL3wqCRAAAA/AAAAA4AJAAAAAAAAAAgAAAAAAAAAEhlbGxvV29ybGQuc29sCgAgAAAAAAABABgA3EMdrL8B1gGPz3r5xAjWAX8gr5/Rr9UBUEsFBgAAAAABAAEAYAAAAL0AAAAAAA=="
}
```

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名**     | **类型** | **最大长度** | **必填** | **说明**               |
| -------- | -------- | -------------- | -------- | ------------ | -------- | ---------------------- |
| 1        | 合约名称 | contractName   | String   |              | 是       |                        |
| 2        | 合约bin  | bytecodeBin    | String   |              | 是       |                        |
| 3        | 合约abi  | contractAbi    | String   |              | 是       |                        |
| 4        | 合约内容 | contractSource | String   |              | 否       | 单个合约内容Base64编码 |

**2）数据格式**

```
[
    {
      "contractName": "HelloWorld",
      "contractAbi": "[{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"name\":\"name\",\"type\":\"string\"}],\"name\":\"SetName\",\"type\":\"event\"}]",
      "contractSource": "cHJhZ21hIHNvbGlkaXR5IF4wLjQuMjsNCmNvbnRyYWN0IEhlbGxvV29ybGR7DQogICAgc3RyaW5nIG5hbWU7DQogICAgZXZlbnQgU2V0TmFtZShzdHJpbmcgbmFtZSk7DQogICAgZnVuY3Rpb24gZ2V0KCljb25zdGFudCByZXR1cm5zKHN0cmluZyl7DQogICAgICAgIHJldHVybiBuYW1lOw0KICAgIH0NCiAgICBmdW5jdGlvbiBzZXQoc3RyaW5nIG4pew0KICAgICAgICBlbWl0IFNldE5hbWUobik7DQogICAgICAgIG5hbWU9bjsNCiAgICB9DQp9",
      "bytecodeBin": "608060405234801561001057600080fd5b50610373806100206000396000f30060806040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063299f7f9d146100515780633590b49f146100e1575b600080fd5b34801561005d57600080fd5b5061006661014a565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100a657808201518184015260208101905061008b565b50505050905090810190601f1680156100d35780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156100ed57600080fd5b50610148600480360381019080803590602001908201803590602001908080601f01602080910402602001604051908101604052809392919081815260200183838082843782019150505050505091929192905050506101ec565b005b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156101e25780601f106101b7576101008083540402835291602001916101e2565b820191906000526020600020905b8154815290600101906020018083116101c557829003601f168201915b5050505050905090565b7f05432a43e07f36a8b98100b9cb3631e02f8e796b0a06813610ce8942e972fb81816040518080602001828103825283818151815260200191508051906020019080838360005b8381101561024e578082015181840152602081019050610233565b50505050905090810190601f16801561027b5780820380516001836020036101000a031916815260200191505b509250505060405180910390a1806000908051906020019061029e9291906102a2565b5050565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106102e357805160ff1916838001178555610311565b82800160010185558215610311579182015b828111156103105782518255916020019190600101906102f5565b5b50905061031e9190610322565b5090565b61034491905b80821115610340576000816000905550600101610328565b5090565b905600a165627a7a72305820cff924cb0783dc84e2e107aae1fd09e1e04154b80834c9267a4eaa630997b2b90029"
    }
  ]
```

### 1.11. 获取全量合约列表（不包含abi/bin）

#### 接口描述

> 根据群组编号和合约状态获取全量合约

#### 接口URL

**http://localhost:5002/WeBASE-Front/contract/contractList/all/light?groupId={groupId}&contractStatus={contractStatus}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**   | **类型**       | **最大长度** | **必填** | **说明** |
| -------- | ------------ | ------------ | -------------- | ------------ | -------- | -------- |
| 1        | 所属群组 | groupId | Integer         |              | 是        |                      |
| 2        | 合约状态 | contractStatus | Integer         |       | 是       |1未部署，2已部署  |

**2）数据格式** 

```
http://localhost:5002/WeBASE-Front/contract/contractList/all/light?groupId=1&contractStatus=2
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
| 3.6        | 合约地址 | contractAddress | String           | 否       |           |
| 3.7        | 部署时间 | deployTime | String            | 否       |           |
| 3.8        | 修改时间 | modifyTime | String            | 是       |           |
| 3.9        | 创建时间 | createTime | String             | 是       |           |
| 3.10        | 备注 | description | String           | 否       |           |


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


### 1.12. 根据id获取单个合约

#### 接口描述

> 根据合约id获取单个合约

#### 接口URL

**http://localhost:5002/WeBASE-Front/contract/findOne/{contractId}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**   | **类型**       | **最大长度** | **必填** | **说明** |
| -------- | ------------ | ------------ | -------------- | ------------ | -------- | -------- |
| 1        | 合约编号 | contractId | Integer         |              | 是        |                      |

**2）数据格式** 

```
http://localhost:5002/WeBASE-Front/contract/findOne/1
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
            "id": 1,
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
    ]
}
```


### 1.13. 获取合约路径列表

#### 接口描述

获取合约路径列表

#### 接口URL

**http://localhost:5002/WeBASE-Front/contract/findPathList/{groupId}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**   | **类型**       | **最大长度** | **必填** | **说明** |
| -------- | ------------ | ------------ | -------------- | ------------ | -------- | -------- |
| 1        | 所属群组 | groupId | Integer         |              | 是        |                      |

**2）数据格式** 

```
http://localhost:5002/WeBASE-Front/contract/findPathList/1
```

#### 响应参数
**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **必填** | **说明**              |
| -------- | -------- | ---------- | -------- | -------- | --------------------- |
| 1       | 返回数据 | data       | List   |  否        |                       |
| 1.1        | 群组编号 | groupId            | Integer                      | 是        |           |
| 1.2        | 所在目录  | contractPath | String             | 是       | |
| 1.3        | 修改时间 | modifyTime | String            | 是       |           |
| 1.4        | 创建时间 | createTime | String             | 是       |           |


**2）数据格式**
```
[
    {
        "groupId": 1,
        "contractPath": "/",
        "createTime": "2019-06-10 16:42:50",
        "modifyTime": "2019-06-10 16:42:52"
    }
]

```


### 1.14. 保存合约路径

#### 接口描述

> 保存合约路径

#### 接口URL

**http://localhost:5002/WeBASE-Front/contract/addContractPath**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**   | **类型**       | **最大长度** | **必填** | **说明** |
| -------- | ------------ | ------------ | -------------- | ------------ | -------- | -------- |
| 1        | 所属群组 | groupId | Integer         |              | 是        |                      |
| 1        | 合约路径 | contractPath | String         |              | 是        |                      |

**2）数据格式** 

```
http://localhost:5002/WeBASE-Front/contract/addContractPath
```

#### 响应参数
**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **必填** | **说明**              |
| -------- | -------- | ---------- | -------- | -------- | --------------------- |
| 1        | 群组编号 | groupId            | Integer                      | 是        |           |
| 2        | 所在目录  | contractPath | String             | 是       | |
| 3        | 修改时间 | modifyTime | String            | 是       |           |
| 4        | 创建时间 | createTime | String             | 是       |           |


**2）数据格式**
```
{
    "groupId": 1,
    "contractPath": "/",
    "createTime": "2019-06-10 16:42:50",
    "modifyTime": "2019-06-10 16:42:52"
}
```


### 1.15. 删除合约路径

#### 接口描述

> 删除合约路径

#### 接口URL

**http://localhost:5002/WeBASE-Front/contract/deletePath/{groupId}/{contractPath}**

#### 调用方法

HTTP DELETE

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**   | **类型**       | **最大长度** | **必填** | **说明** |
| -------- | ------------ | ------------ | -------------- | ------------ | -------- | -------- |
| 1        | 所属群组 | groupId | Integer         |              | 是        |                      |
| 1        | 合约路径 | contractPath | String         |              | 是        |                      |

**2）数据格式** 

```
http://localhost:5002/WeBASE-Front/contract/deletePath/1/test
```

#### 响应参数
**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **必填** | **说明**              |
| -------- | -------- | ---------- | -------- | -------- | --------------------- |
| 1        | 返回码   | code       | String   | 是       | 返回码信息请参看附录1 |
| 2        | 提示信息 | message    | String   | 是       |                       |


**2）数据格式**
```
{
    "code": 0,
    "message": "success"
}
```


### 1.16. 根据合约路径批量删除合约

#### 接口描述

> 根据合约路径批量删除合约

#### 接口URL

**http://localhost:5002/WeBASE-Front/contract/batch/{groupId}/{contractPath}**

#### 调用方法

HTTP DELETE

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**   | **类型**       | **最大长度** | **必填** | **说明** |
| -------- | ------------ | ------------ | -------------- | ------------ | -------- | -------- |
| 1        | 所属群组 | groupId | Integer         |              | 是        |                      |
| 1        | 合约路径 | contractPath | String         |              | 是        |                      |

**2）数据格式** 

```
http://localhost:5002/WeBASE-Front/contract/batch/1/test
```

#### 响应参数
**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **必填** | **说明**              |
| -------- | -------- | ---------- | -------- | -------- | --------------------- |
| 1        | 返回码   | code       | String   | 是       | 返回码信息请参看附录1 |
| 2        | 提示信息 | message    | String   | 是       |                       |


**2）数据格式**
```
{
    "code": 0,
    "message": "success"
}
```

### 1.17. 注册cns接口

#### 接口描述

> 注册cns

#### 接口URL

**http://localhost:5002/WeBASE-Front/contract/registerCns**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                |
| -------- | ------------ | --------------- | -------- | ------------ | -------- | --------------------------------------- |
| 1        | 所属群组     | groupId         | Integer  |              | 是       |                                         |
| 2        | 合约名称     | contractName    | String   |              | 是       |                                         |
| 3        | cns名称      | cnsName         | String   |              | 是       |                                         |
| 4        | 合约地址     | contractAddress | String   |              | 是       |                                         |
| 5        | 合约abi      | abiInfo         | List     |              | 是       | abi文件里面的内容，是一个JSONArray      |
| 6        | cns版本      | version         | String   |              | 是       |                                         |
| 7        | 是否保存     | saveEnabled     | bool     |              | 是       | 前置控制台调用时传true，其他调用传false |
| 8        | 用户地址     | userAddress     | String   |              | 否       | saveEnabled为true时必填                 |
| 9        | 合约路径     | contractPath    | String   |              | 否       | saveEnabled为true时必填                 |
| 10       | 签名用户编号 | signUserId      | String   |              | 否       | saveEnabled为false时必填                |

**2）数据格式**

```
{
  "groupId": 1,
  "contractName": "Hello",
  "cnsName": "Hello",
  "contractPath": "/",
  "version": "v0.4",
  "contractAddress": "0xcaff8fdf1d461b91c7c8f0ff2af2f79a80bc189e",
  "abiInfo": [{"cons tant":false,"inputs":[{"name":"n","type":"string","type0":null,"indexed":false}],"name":"set","outputs":[{"name":"","type":"string","type0":null,"indexed":false}],"type":"function","payable":false,"stateMutability":"nonpayable"},{"co nstant":true,"inputs":[],"name":"get","outputs":[{"name":"","type":"string","type0":null,"indexed":false}],"type":"function","payable":false,"stateMutability":"view"},{"constant":false,"inputs":[{"name":"name","type":"string","type0":null,"indexed":false}],"name":"SetName","outputs":null,"type":"event","payable":false,"stateMutability":null}],
  "signUserId": null,
  "userAddress": "0x8c808ff5beee7b4cfb17f141f6237db93a668e46",
  "saveEnabled": true
}
```

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **必填** | **说明**              |
| -------- | -------- | ---------- | -------- | -------- | --------------------- |
| 1        | 返回码   | code       | String   | 是       | 返回码信息请参看附录1 |
| 2        | 提示信息 | message    | String   | 是       |                       |

**2）数据格式**

```
{
    "code": 0,
    "message": "success"
}
```

### 1.18. 根据合约地址获取cns信息

#### 接口描述

根据合约地址获取cns信息，返回改合约地址最新的cns信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/contract/findCns**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**      | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | --------------- | -------- | ------------ | -------- | -------- |
| 1        | 所属群组 | groupId         | Integer  |              | 是       |          |
| 2        | 合约地址 | contractAddress | String   |              | 是       |          |

**2）数据格式** 

```
http://localhost:5002/WeBASE-Front/contract/findCns
```

```
{
  "groupId": 1,
  "contractAddress": "0xe46c1a681811ee78079b48a956ead6d9dd10bf6a"
}
```

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名**      | **类型** | **必填** | **说明**              |
| -------- | -------- | --------------- | -------- | -------- | --------------------- |
| 1        | 返回码   | code            | String   | 是       | 返回码信息请参看附录1 |
| 2        | 提示信息 | message         | String   | 是       |                       |
| 3        | 返回数据 | data            | List     | 否       |                       |
| 3.1      | 群组编号 | groupId         | Integer  | 是       |                       |
| 3.2      | 合约路径 | contractPath    | String   | 是       |                       |
| 3.3      | 合约名   | contractName    | String   | 是       |                       |
| 3.4      | cns名    | cnsName         | String   | 是       |                       |
| 3.5      | cns版本  | version         | String   | 是       |                       |
| 3.6      | 合约地址 | contractAddress | String   | 是       |                       |
| 3.7      | 合约Abi  | contractAbi     | String   | 是       |                       |
| 3.8      | 修改时间 | modifyTime      | String   | 是       |                       |
| 3.9      | 创建时间 | createTime      | String   | 是       |                       |

**2）数据格式**

```
{
  "code": 0,
  "message": "success"
  "data": {
    "groupId": 1,
    "contractPath": "/",
    "contractName": "Hello",
    "cnsName": "Hello",
    "version": "v0.4",
    "contractAddress": "0xcaff8fdf1d461b91c7c8f0ff2af2f79a80bc189e",
    "contractAbi":"[{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\",\"type0\":null,\"indexed\":false}],\"type\":\"function\",\"payable\":false,\"stateMutability\":\"view\"},{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\",\"type0\":null,\"indexed\":false}],\"name\":\"set\",\"outputs\":[],\"type\":\"function\",\"payable\":false,\"stateMutability\":\"nonpayable\"},{\"constant\":false,\"inputs\":[{\"name\":\"name\",\"type\":\"string\",\"type0\":null,\"indexed\":false}],\"name\":\"SetName\",\"outputs\":null,\"type\":\"event\",\"payable\":false,\"stateMutability\":null}]",
    "createTime": "2020-12-30 16:32:28",
    "modifyTime": "2020-12-30 16:32:28"
  }
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
| 2        | p12文件密码 | p12Password    | String   |              | 否       | 使用base64编码的密码；缺省时默认为""，即空密码；p12无密码时，可传入空值或不传；不包含中文          |
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


### 2.8. 对哈希签名

#### 接口描述

计算HASH和签名值

#### 接口URL

**http://localhost:5002/WeBASE-Front/privateKey/signMessageHash**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明**                              |
| -------- | -------- | ---------- | -------- | ------------ | -------- | ------------------------------------- |
| 1        | Sign用户Id | signUserId       | String   |              | 是       | 在webase-sign创建的私钥的id |
| 2        | Hash值   | messageHash       | String   |              | 是       |                                       |

**2）数据格式**

```
{
  "messageHash": "0xa271b78b8e869d693f7cdfee7162d7bfb11ae7531fd50f73d86f73a05c84dd7c",
  "signUserId": "883cfa1d40117dd2d270aa8bb0bb33776409be8b"
}
```

#### 响应参数

**1）数据格式**

```
{
  "v": 0,
  "r": "0x2a76a45bcf1113615f796cc01b23c57f81f20ce79500080bb34c7994ed04de06",
  "s": "0x4f111eb37720e2618d8906368c825fd3cbe89b2781cb678efafb42399594a580",
  "p": "0x4405f9d5d6ccff709b6543bc8ac24cbb649d3267a66db19ab8f85f3b884a8505f086c581490e7e50558879abde9c4d07fc2daab92f81c0eb4b805af3c8895cfc"
}
```



### 2.9. 导出pem私钥

#### 接口描述

从本地或WeBASE-Sign导出pem私钥文件

#### 接口URL

**http://localhost:5002/WeBASE-Front/privateKey/exportPem**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | Sign用户编号 | signUserId    | String   |              | 否      |  非空时，导出sign的私钥        |
| 2        | 用户地址 | userAddress    | String   |              | 否     |    若signUserId为空，则地址不能为空，导出本地私钥       |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/privateKey/exportPem
```

```
{
    "userAddress": "0x883cfa1d40117dd2d270aa8bb0bb33776409be8b"
}
```

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **必填** | **说明**              |
| -------- | -------- | ---------- | -------- | -------- | --------------------- |
| 1        | 文件名  | ResponseEntity.header       | String   | 是       | 文件名在header中 |
| 2        | 文件流 | body  | InputStream   | 是       |    文件的流在body中，使用pcks12方式接收                   |

**2）数据格式**

```
headers: content-disposition: attachment;filename*=UTF-8''111_0x0421975cf4a5b27148f65de11cd9d8559a1bbbd9.pem 

{
-----BEGIN PRIVATE KEY-----
MIGNAgEAMBAGByqGSM49AgEGBSuBBAAKBHYwdAIBAQQg91Aha3x2UdpN2Sg5C5Wh
7Y8YwIYC5NTNtfQT1yp7hKWgBwYFK4EEAAqhRANCAAQ9SEdu1kLpLXVmayqax7N+
Pf/ATWx5jJIJIiQF6/BIiuORZrZb/M04FlxtGyVuQjQjbYVgyjNDUilj14OlZhXo
-----END PRIVATE KEY-----
}
```


### 2.10. 导出p12私钥

#### 接口描述

从本地或WeBASE-Sign导出p12私钥文件

#### 接口URL

**http://localhost:5002/WeBASE-Front/privateKey/exportP12**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | Sign用户编号 | signUserId    | String   |              | 否      |  非空时，导出sign的私钥        |
| 2        | 用户地址 | userAddress    | String   |              | 否     |    若signUserId为空，则地址不能为空，导出本地私钥       |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/privateKey/exportP12
```

```
{
    "userAddress": "0x883cfa1d40117dd2d270aa8bb0bb33776409be8b"
}
```

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **必填** | **说明**              |
| -------- | -------- | ---------- | -------- | -------- | --------------------- |
| 1        | 文件名  | ResponseEntity.header       | String   | 是       | 文件名在header中 |
| 2        | 文件流 | body  | InputStream   | 是       |    文件的流在body中，使用pcks12方式接收                   |

**2）数据格式**


```
headers:  content-disposition: attachment;filename*=UTF-8''111_0x0421975cf4a5b27148f65de11cd9d8559a1bbbd9.p12 

{
// 二进制流
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
http://localhost:5002/WeBASE-Front/1/web3/blockNumber
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
| 2        | 块高 | blockNumber  | int   |              | 是       |          |
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

> 返回节点的块高、pbftview及状态。（查看nodeHeartBeat）

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
<span id="dynamic_group_interface"></span>

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

创建群组后，需要对群组内每个节点分别调用`start`来启动群组，群组才算完全创建

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


### 3.27. 获取区块的时间戳与交易量

#### 接口描述

根据块高获取区块的时间戳与区块中的交易数

#### 接口URL


**http://localhost:5002/WeBASE-Front/{groupId}/web3/blockStat/{blockNumber}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|    1     | 群组id       | groupId           | int   |              |   是     |    操作的群组编号                        |
|    2     | 块高         | blockNumber            | BigInteger   |              | 是       |   |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front//1/web3/blockStat/5
```

#### 响应参数

**1）数据格式**

a、成功：

```
{
  "blockNumber": 5,
  "timestamp": 1617715398371,
  "txCount": 1
}
```


### 3.28. 获取前置所连节点的配置信息


#### 接口描述

> 返回节点的config.ini配置信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/nodeConfig**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**       | **类型**   | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------------- | ---------- | ------------ | -------- | -------- |
| 1        | 群组编号 | groupId | int      |             | 是        |                      |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/nodeConfig
```

#### 响应参数
**1）数据格式**

```
{
	"orgName": "null",
	"p2pip": "172.17.0.1",
	"listenip": "0.0.0.0",
	"rpcport": "8535",
	"p2pport": "30300",
	"channelPort": "20200",
	"groupDataPath": "data/",
	"enableStatistic": false
}
```


### 3.29. 获取前置所连节点信息


#### 接口描述

> 返回

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/nodeInfo**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**       | **类型**   | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------------- | ---------- | ------------ | -------- | -------- |
| 1        | 群组编号 | groupId | int      |             | 是        |                      |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/nodeInfo
```

#### 响应参数
**1）数据格式**

```
{
    "NodeID": "fe57d7b39ed104b4fb2770ae5aad7946bfd377d0eb91ab92a383447e834c3257dec56686551d08178f2d5f40d9fad615293e46c9f5fc23cf187258e121213b1d",
    "IPAndPort": "0.0.0.0:35310",
    "Agency": "agencyA_son",
    "Node": "node0",
    "Topic": ["_block_notify_1", "_block_notify_2"]
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

### 4.5. 获取节点监控信息

#### 接口描述

获取节点监控信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/chain**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**        | **类型**      | **最大长度** | **必填** | **说明** |
| -------- | ------------ | ----------------- | ------------- | ------------ | -------- | -------- |
| 1        | 开始日期     | beginDate         | LocalDateTime |              |          |          |
| 2        | 结束日期     | endDate           | LocalDateTime |              |          |          |
| 3        | 对比开始日期 | contrastBeginDate | LocalDateTime |              |          |          |
| 4        | 对比结束日期 | contrastEndDate   | LocalDateTime |              |          |          |
| 5        | 间隔         | gap               | int           |              |          |          |
| 6        | 群组编号     | groupId           | int           |              |          |          |

***2）入参示例***

```
localhost:5002/WeBASE-Front/chain?beginDate=2019-03-13T00:00:00&endDate=2019-03-13T14:34:22&contrastBeginDate=2019-03-13T00:00:00&contrastEndDate=2019-03-13T14:34:22&gap=60&groupId=1
```

#### 响应参数

**1）参数表**

| 序号      | 输出参数         | 类型            |      | 备注                                                         |
| --------- | ---------------- | --------------- | ---- | ------------------------------------------------------------ |
| 1         | data             | Array           | 否   | 返回信息列表                                                 |
| 1.1       |                  | Object          |      | 返回信息实体                                                 |
| 1.1.1     | metricType       | String          | 否   | 测量类型：blockHeight（块高）、pbftView（pbft视图）、pendingCount（待处理交易数量） |
| 1.1.2     | data             | Object          | 否   |                                                              |
| 1.1.2.1   | lineDataList     | Object          | 否   | 指定时间的数据                                               |
| 1.1.2.1.1 | timestampList    | List<String>  | 否   | 时间戳列表                                                   |
| 1.1.2.1.2 | valueList        | List<Integer> | 否   | 值列表                                                       |
| 1.1.2.2   | contrastDataList | Object          | 否   | 比对时间的数据                                               |
| 1.1.2.2.1 | timestampList    | List<String>  | 否   | 时间戳列表                                                   |
| 1.1.2.2.2 | valueList        | List<Integer> | 否   | 值列表                                                       |

***2）出参示例***

```
[
	{
		"metricType": "blockHeight",
		"data": {
			"lineDataList": {
				"timestampList": [
					1552406401042,
					1552406701001
				],
				"valueList": [
					747309,
					747309
				]
			},
			"contrastDataList": {
				"timestampList": [
					1552320005000,
					1552320301001
				],
				"valueList": [
					null,
					747309
				]
			}
		}
	},
	{
		"metricType": "pbftView",
		"data": {
			"lineDataList": {
				"timestampList": null,
				"valueList": [
					118457,
					157604
				]
			},
			"contrastDataList": {
				"timestampList": null,
				"valueList": [
					null,
					33298
				]
			}
		}
	}
]
```

### 4.6. 检查节点进程是否存活

#### 接口描述

检查节点进程是否存活

#### 接口URL

**http://localhost:5002/WeBASE-Front/chain/checkNodeProcess**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

无

#### 响应参数

**1）参数表** 

```
true
```

### 4.7. 获取节点所在群组物理大小信息

#### 接口描述

获取节点所在群组物理大小信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/chain/getGroupSizeInfos**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

无

#### 响应参数

**1）参数表** 

***1）出参表***

| 序号  | 输出参数  | 类型   |      | 备注             |
| ----- | --------- | ------ | ---- | ---------------- |
| 1     | data      | Array  | 否   | 返回信息列表     |
| 1.1   |           | Object |      | 返回信息实体     |
| 1.1.1 | groupId   | Int    | 否   | 群组id           |
| 1.1.2 | groupName | String | 否   | 群组名           |
| 1.1.3 | path      | String | 否   | 文件路径         |
| 1.1.4 | size      | Long   | 否   | 大小（单位：KB） |

***2）出参示例***

- 成功：

```
[
	{
	  "groupId": 31231,
	  "groupName": "group31231",
	  "path": "/data/app/nodes/127.0.0.1/node0/data/group31231",
	  "size": 27085
	},
	{
	  "groupId": 2,
	  "groupName": "group2",
	  "path": "/data/app/nodes/127.0.0.1/node0/data/group2",
	  "size": 23542
	},
	{
	  "groupId": 1,
	  "groupName": "group1",
	  "path": "/data/app/nodes/127.0.0.1/node0/data/group1",
	  "size": 25077
	},
	{
	  "groupId": 111,
	  "groupName": "group111",
	  "path": "/data/app/nodes/127.0.0.1/node0/data/group111",
	  "size": 21552
	}
]
```

## 5. 交易接口

<span id="transWithSign"></span>
### 5.1. 交易处理接口（结合WeBASE-Sign）

#### 接口描述

   通过此接口对合约进行调用，前置根据调用的合约方法是否是“constant”方法区分返回信息，“constant”方法为查询，返回要查询的信息。非“constant”方法为发送数据上链，返回块hash、块高、交易hash等信息。

   当合约方法为非“constant”方法，要发送数据上链时，此接口需结合WeBASE-Sign使用。通过调用WeBASE-Sign服务的签名接口让相关用户对数据进行签名，拿回签名数据再发送上链。需要调用此接口时，工程配置文件application.yml中的配置"keyServer"需配置WeBASE-Sign服务的ip和端口，并保证WeBASE-Sign服务正常和存在相关用户。

   方法入参（funcParam）为JSON数组，多个参数以逗号分隔（参数为数组时同理），示例：

```
function set(string s) -> ["aa,bb\"cc"]	// 双引号要转义
function set(uint n,bool b) -> [1,true]
function set(bytes b,address[] a) -> ["0x1a",["0x7939E26070BE44E6c4Fc759Ce55C6C8b166d94BE","0xce867fD9afa64175bb50A4Aa0c17fC7C4A3C67D9"]]
```

*查看WeBASE-Front通过本地私钥（测试用户）交易处理接口（非WeBASE-Sign签名交易），可查看[其他接口-交易处理接口（本地签名）](#transNoSign)*

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
| 5        | 合约编译后生成的abi文件内容 | contractAbi    | List |        | 是        | 合约中单个函数的ABI，若不存在同名函数可以传入整个合约ABI，格式：JSONArray |
| 6        | 方法参数       | funcParam       | List     |              | 否         | JSON数组，多个参数以逗号分隔（参数为数组时同理），如：["str1",["arr1","arr2"]] |
| 7        | 群组ID         | groupId         | int      |              |   是       |  默认为1                                          |
| 8 | 是否使用cns调用 | useCns | bool | | 是 |  |
| 9 | cns名称 | cnsName | String | | 否 | CNS名称，useCns为true时不能为空 |
| 10 | cns版本 | version | String | | 否 | CNS版本，useCns为true时不能为空 |


**2）数据格式**

```
{
    "groupId" :1,
    "signUserId": "458ecc77a08c486087a3dcbc7ab5a9c3",
    "contractAbi":[{"constant":true,"inputs":[],"name":"getVersion","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"getStorageCell","outputs":[{"name":"","type":"string"},{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"n","type":"string"}],"name":"setVersion","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[{"name":"storageHash","type":"string"},{"name":"storageInfo","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"}],
    "contractAddress":"0x14d5af9419bb5f89496678e3e74ce47583f8c166",
    "funcName":"set",
    "funcParam":["test"],
    "useCns":false
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

<span id="transNoSign"></span>

### 5.2. 交易处理接口（本地签名）

#### 接口描述

此接口为WeBASE-Front使用**本地私钥（页面中的测试用户）进行签名**

通过合约信息进行调用，前置根据调用的合约方法是否是“constant”方法区分返回信息，“constant”方法为查询，返回要查询的信息。非“constant”方法为发送数据上链，返回块hash、块高、交易hash等信息。

方法入参（funcParam）为JSON数组，多个参数以逗号分隔（参数为数组时同理），示例：

```
function set(string s) -> ["aa,bb\"cc"] // 双引号要转义
function set(uint n,bool b) -> [1,true]
function set(bytes b,address[] a) -> ["0x1a",["0x7939E26070BE44E6c4Fc759Ce55C6C8b166d94BE","0xce867fD9afa64175bb50A4Aa0c17fC7C4A3C67D9"]]
```

*查看WeBASE-Front通过WeBASE-Sign交易处理的接口（非本地私钥签名交易），可查看[合约接口-交易处理接口（结合WeBASE-Sign）](#transWithSign)*


#### 接口URL

**http://localhost:5002/WeBASE-Front/trans/handle**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**                    | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                                     |
| -------- | --------------------------- | --------------- | -------- | ------------ | -------- | ------------------------------------------------------------ |
| 1        | 用户地址                    | user            | String   |              | 是       | 用户地址，可通过`/privateKey`接口创建                        |
| 2        | 合约名称                    | contractName    | String   |              | 是       |                                                              |
| 3        | 合约地址                    | contractAddress | String   |              | 是       |                                                              |
| 4        | 方法名                      | funcName        | String   |              | 是       |                                                              |
| 5        | 合约编译后生成的abi文件内容 | contractAbi     | List     |              | 是       | 合约中单个函数的ABI，若不存在同名函数可以传入整个合约ABI，格式：JSONArray |
| 6        | 方法参数                    | funcParam       | List     |              | 否       | JSON数组，多个参数以逗号分隔（参数为数组时同理），如：["str1",["arr1","arr2"]]，根据所调用的合约方法判断是否必填 |
| 7        | 群组ID                      | groupId         | int      |              | 是       | 默认为1                                                      |
| 8        | 合约路径                    | contractPath    | int      |              | 否       |                                                              |
| 9        | 是否使用cns调用             | useCns          | bool     |              | 是       |                                                              |
| 10       | cns名称                     | cnsName         | String   |              | 否       | CNS名称，useCns为true时不能为空                              |
| 11       | cns版本                     | version         | String   |              | 否       | CNS版本，useCns为true时不能为空                              |

**2）数据格式**

示例：

```
curl -l -H "Content-type: application/json" -X POST -d '{"contractName":
"HelloWorld", "contractAbi": [{\"constant\":false,\"inputs\":[{\"indexed\":false,\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"}], funcName": "set", "funcParam": ["Hi,Welcome!"], "user": "0x2db346f9d24324a4b0eac7fb7f3379a2422704db", "contractAddress":"dasdfav23rf213vbcdvadf3bcdf2fc23rqde","groupId": 1,"useCns": false}' http://10.0.0.1:5002/WeBASE-Front/trans/handle
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
    "groupId" :"1",
    "useCns": false
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

### 5.3. 已签名交易发送

#### 接口描述

> 发送已签名的交易上链，返回交易收据；

#### 接口URL

**http://localhost:5002/WeBASE-Front/trans/signed-transaction**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | ------------ | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 已签名字符串 | signedStr  | String   |              | 是       |          |
| 2        | 是否同步发送 | sync       | bool     |              | 是       |          |
| 2        | 群组ID       | groupId    | int      |              | 否       |          |

**2）数据格式**

```
{
    "signedStr": "0xddd",
    "sync": 1,
    "groupId":1
}
```

#### 响应参数

**1）数据格式**

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


### 5.4. 已编码查询交易发送

#### 接口描述

> 发送已编码的查询交易，返回合约的返回值；

#### 接口URL

**http://localhost:5002/WeBASE-Front/trans/query-transaction**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**      | **类型** | **最大长度** | **必填** | **说明** |
| -------- | ------------ | --------------- | -------- | ------------ | -------- | -------- |
| 1        | 已编码字符串 | encodeStr       | String   |              | 是       |          |
| 2        | 合约地址     | contractAddress | String   |              | 是       |          |
| 3        | 群组ID       | groupId         | int      |              | 否       |          |
| 4        | 合约名       | funcName        | String   |              | 是       |          |
| 5        | 合约abi      | contractAbi     | String   |              | 是       |          |
| 6        | 用户地址     | userAddress     | String   |              | 否       |          |

**2）数据格式**

```
{
    "encodeStr": "0xddd",
    "contractAddress": "0x2b5ad5c4795c026514f8317c7a215e218dccd6cf",
    "groupId":1,
    "funcName": "get",
    "contractAbi": "[{\"constant\":false,\"inputs\":[{\"name\":\"num\",\"type\":\"uint256\"}],\"name\":\"trans\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"name\":\"num\",\"type\":\"uint256\"}],\"name\":\"TransEvent\",\"type\":\"event\"}]"
}
```

#### 响应参数

 Object返回类型

```
{"Hi,Welcome!"}
```

### 5.5. Hash计算

#### 接口描述

计算HASH和签名值


#### 接口URL

**http://localhost:5002/WeBASE-Front/trans/signMessageHash**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明**                              |
| -------- | -------- | ---------- | -------- | ------------ | -------- | ------------------------------------- |
| 1        | 用户地址 | user       | String   |              | 是       | 用户地址，可通过`/privateKey`接口创建 |
| 2        | Hash值   | hash       | String   |              | 是       |                                       |

**2）数据格式**

```
{
  "hash": "0xa271b78b8e869d693f7cdfee7162d7bfb11ae7531fd50f73d86f73a05c84dd7c",
  "user": "0x883cfa1d40117dd2d270aa8bb0bb33776409be8b"
}
```

#### 响应参数

**1）数据格式**

```
{
  "v": 0,
  "r": "0x2a76a45bcf1113615f796cc01b23c57f81f20ce79500080bb34c7994ed04de06",
  "s": "0x4f111eb37720e2618d8906368c825fd3cbe89b2781cb678efafb42399594a580",
  "p": "0x4405f9d5d6ccff709b6543bc8ac24cbb649d3267a66db19ab8f85f3b884a8505f086c581490e7e50558879abde9c4d07fc2daab92f81c0eb4b805af3c8895cfc"
}
```

## 6. 系统管理接口

使用FISCO BCOS v2.5.0 与 WeBASE-Front v1.4.1 (及)以上版本将使用预编译合约中的ChainGovernance接口(从本章节[接口6.13](#governance)开始)，详情可参考[FISCO BCOS基于角色的权限控制](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/manual/permission_control.html#id2)


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
| 3 | 分页大小 | pageSize | int | | 否 | 默认为10 |
| 4 | 分页页码 | pageNumber | int | | 否 | 默认为1 |
| 5 | 表名 | tableName | String | | 否 | 当`permissionType`为`userTable`时为**必填** |
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
| 2        | 权限类型       | permissionType    | String   |              | 是       |  分配权限的类型                                     |
| 3       | 表名       | tableName       | String     |              |     否     | 当permissionType为userTable时不可为空 |

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
| 5        | 表名       | tableName       | String     |              |     否     | 当permissionType为userTable时不可为空|

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
| 5        | 表名       | tableName       | String     |              |     否     | 当permissionType为userTable时不可为空 |

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
| 4        | 用户权限状态       | permissionState       | Object     |              |     是     | 使用{"permissionType": 1}格式，参照下文数据格式；1代表赋予，0代表去除；支持cns、deployAndCreate、sysConfig、node四种权限|

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
| 3        | 分页大小         | pageSize        | int   |           | 是       | 默认为10|
| 4        | 分页页码         | pageNumber        | int   |           | 是       |  默认为1            |

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
| 2        | 分页大小         | pageSize        | int   |           | 是       | 默认为10|
| 3        | 分页页码         | pageNumber        | int   |           | 是       |  默认为1            |

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
| 4        | 配置的值       | configValue       | String     |              |     是    | tx_gas_limit范围为 [100000, 2147483647]|

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
| 2        | 分页大小         | pageSize        | int   |           | 是       | 默认为10|
| 3        | 分页页码         | pageNumber        | int   |           | 是       |  默认为1            |

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
| 3        | 节点类型       | nodeType       | String     |              |     是    | 节点类型：observer,sealer,remove |
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
| 3        | SQL语句       | sql       | String     |              |     是    | 包含create, desc, insert, update, select, remove，小写|

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




### 6.11. 合约状态管理

#### 接口描述

> 冻结、解冻合约和授权用户操作权限，还可以查询合约状态和合约用户权限列表

#### 接口URL

**http://localhost:5002/WeBASE-Front/precompiled/contractStatusManage**

#### 调用方法

HTTP POST

#### 请求参数

***1）入参表***

| 序号 | 输入参数        | 类型   | 可为空 | 备注                                                         |
| ---- | --------------- | ------ | ------ | ------------------------------------------------------------ |
| 1    | groupId         | Int    | 否     | 群组编号                                                     |
| 2    | signUserId      | String | 否     | WeBASE-Sign签名用户编号，当`handleType`为`getStatus`或`listManager`时，可不传 |
| 3    | contractAddress | String | 否     | 已部署的合约地址                                             |
| 4    | handleType      | String | 否     | 操作类型：freeze-冻结；unfreeze-解冻；grantManager-授权；getStatus-查询合约状态；listManager-查询合约权限列表 |
| 5    | grantAddress    | String | 是     | 授权用户地址，操作类型为grantManager时需传入                 |

***2）入参示例***

```
{
  "contractAddress": "0x1d518bf3fb0edceb18519808edf7ad8adeeed792",
  "grantAddress": "",
  "groupId": 1,
  "handleType": "freeze",
  "signUserId": "user1001"
}
```

#### 响应参数

**1）数据格式**

```
{
  "code": 0,
  "message": "success",
  "data": null
}
```


### 6.12. 基于角色的权限管理
<span id="governance"></span>

使用FISCO BCOS v2.5.0 与 WeBASE-Front v1.4.1 (及)以上版本将使用预编译合约中的ChainGovernance接口(本章节[接口6.13](#governance))，详情可参考[FISCO BCOS基于角色的权限控制](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/manual/permission_control.html#id2)

包含链治理委员管理、链运维管理等功能

### 6.12.1. 查看链治理委员列表

#### 接口描述

委员的权限包括治理投票、增删节点、冻结解冻合约、冻结解冻账号、修改链配置和增删运维账号。

增加委员需要链治理委员会投票，有效票大于阈值才可以生效，且不重复计票
- 委员默认的投票权重为1，默认投票生效阈值50%，若有两个委员，则需要两个委员都投票增加/撤销的委员权限，`有效票/总票数=2/2=1>0.5`才满足条件。
- 投票有过期时间，根据块高，过期时间为块高超过blockLimit的10倍时过期；过期时间固定不可改。‘

#### 接口URL

**http://localhost:5002/WeBASE-Front/governance/committee/list**

#### 调用方法

HTTP GET

#### 请求参数

***1）入参表***

| 序号 | 输入参数        | 类型   | 可为空 | 备注                                                         |
| ---- | --------------- | ------ | ------ | ------------------------------------------------------------ |
| 1    | groupId         | Int    | 否     | 群组编号                                                     |

***2）入参示例***

```
http://localhost:5002/WeBASE-Front/governance/committee/list?groupId=1
```

#### 响应参数

**1）数据格式**

```
[
  {
    "address": "0xd031e61f6dc4dedd7d77f90128ed33caafbed0af",
    "enable_num": "2"
  }
]
```


### 6.12.2. 增加链治理委员

#### 接口描述

委员的权限包括治理投票、增删节点、冻结解冻合约、冻结解冻账号、修改链配置和增删运维账号。

增加委员需要链治理委员会投票，有效票大于阈值才可以生效，且不重复计票
- 委员默认的投票权重为1，默认投票生效阈值50%，若有两个委员，则需要两个委员都投票增加/撤销的委员权限，`有效票/总票数=2/2=1>0.5`才满足条件。
- 投票有过期时间，根据块高，过期时间为块高超过blockLimit的10倍时过期；过期时间固定不可改。‘

#### 接口URL

**http://localhost:5002/WeBASE-Front/governance/committee**

#### 调用方法

HTTP POST

#### 请求参数

***1）入参表***

| 序号 | 输入参数        | 类型   | 可为空 | 备注                                                         |
| ---- | --------------- | ------ | ------ | ------------------------------------------------------------ |
| 1    | groupId         | Int    | 否     | 群组编号                                                     |
| 2    | signUserId      | String | 否     | WeBASE-Sign签名用户编号                                      |
| 3    | address   | String           | 否     | 新的链治理委员地址         |

***2）入参示例***

```
{
  "groupId": 1,
  "signUserId": "user1001",
  "address": "0x2357ad9d97027cd71eea1d639f1e5750fbdfd38e"
}
```

#### 响应参数

**1）数据格式**

透传链上返回结果
```
{
    "code":0,
    "msg":"success"
}
```


### 6.12.3. 取消链治理委员

#### 接口描述

委员的权限包括治理投票、增删节点、冻结解冻合约、冻结解冻账号、修改链配置和增删运维账号。

增加委员需要链治理委员会投票，有效票大于阈值才可以生效，且不重复计票
- 委员默认的投票权重为1，默认投票生效阈值50%，若有两个委员，则需要两个委员都投票增加/撤销的委员权限，`有效票/总票数=2/2=1>0.5`才满足条件。
- 投票有过期时间，根据块高，过期时间为块高超过blockLimit的10倍时过期；过期时间固定不可改。‘

#### 接口URL

**http://localhost:5002/WeBASE-Front/governance/committee**

#### 调用方法

HTTP DELETE

#### 请求参数

***1）入参表***

| 序号 | 输入参数        | 类型   | 可为空 | 备注                                                         |
| ---- | --------------- | ------ | ------ | ------------------------------------------------------------ |
| 1    | groupId         | Int    | 否     | 群组编号                                                     |
| 2    | signUserId      | String | 否     | WeBASE-Sign签名用户编号                                      |
| 3    | address   | String           | 否     | 待取消的链治理委员地址         |

***2）入参示例***

```
{
  "groupId": 1,
  "signUserId": "user1001",
  "address": "0x2357ad9d97027cd71eea1d639f1e5750fbdfd38e"
}
```

#### 响应参数

**1）数据格式**

透传链上返回结果
```
{
    "code":0,
    "msg":"success"
}
```


### 6.12.4. 查看链治理委员投票权重

#### 接口描述

委员默认的投票权重为1

#### 接口URL

**http://localhost:5002/WeBASE-Front/governance/committee/weight**

#### 调用方法

HTTP GET

#### 请求参数

***1）入参表***

| 序号 | 输入参数        | 类型   | 可为空 | 备注                                                         |
| ---- | --------------- | ------ | ------ | ------------------------------------------------------------ |
| 1    | groupId         | Int    | 否     | 群组编号                                                     |
| 2    | address   | String           | 否     | 链治理委员地址         |

***2）入参示例***

```
http://localhost:5002/WeBASE-Front/governance/committee/weight?groupId=1&address=0x009fb217b6d7f010f12e7876d31a738389fecd51
```

#### 响应参数

**1）数据格式**

成功时：直接返回权重值
```
2
```

失败时，如查询非委员用户的权重值：

```
{
    "code": -52001,
    "msg": "address not committee"
}
```

### 6.12.5. 更新链治理委员投票权重

#### 接口描述

委员默认的投票权重为1

#### 接口URL

**http://localhost:5002/WeBASE-Front/governance/committee/weight**

#### 调用方法

HTTP PUT

#### 请求参数

***1）入参表***

| 序号 | 输入参数        | 类型   | 可为空 | 备注                                                         |
| ---- | --------------- | ------ | ------ | ------------------------------------------------------------ |
| 1    | groupId         | Int    | 否     | 群组编号                                                     |
| 2    | signUserId      | String | 否     | WeBASE-Sign签名用户编号                                      |
| 3    | address   | String           | 否     | 链治理委员地址         |
| 4    | weight         | Int    | 否     | 权重值                                                     |

***2）入参示例***

```
{
  "groupId": 1,
  "signUserId": "user1001",
  "address": "0x2357ad9d97027cd71eea1d639f1e5750fbdfd38e",
  "weight": 2
}
```

#### 响应参数

**1）数据格式**

透传链上返回结果
```
{
    "code":0,
    "msg":"success"
}
```



### 6.12.6. 查看链投票阈值

#### 接口描述

阈值默认为50，即票数>50%

#### 接口URL

**http://localhost:5002/WeBASE-Front/governance/threshold**

#### 调用方法

HTTP GET

#### 请求参数

***1）入参表***

| 序号 | 输入参数        | 类型   | 可为空 | 备注                                                         |
| ---- | --------------- | ------ | ------ | ------------------------------------------------------------ |
| 1    | groupId         | Int    | 否     | 群组编号                                                     |

***2）入参示例***

```
http://localhost:5002/WeBASE-Front/governance/threshold?groupId=1
```

#### 响应参数

**1）数据格式**

直接返回threshold值
```
50
```


### 6.12.7. 更新链投票阈值

#### 接口描述

阈值默认为50，即票数>50%

#### 接口URL

**http://localhost:5002/WeBASE-Front/governance/threshold**

#### 调用方法

HTTP PUT

#### 请求参数

***1）入参表***

| 序号 | 输入参数        | 类型   | 可为空 | 备注                                                         |
| ---- | --------------- | ------ | ------ | ------------------------------------------------------------ |
| 1    | groupId         | Int    | 否     | 群组编号                                                     |
| 2    | signUserId      | String | 否     | WeBASE-Sign签名用户编号                                      |
| 3    | address   | String           | 否     | 新的链治理委员地址         |
| 4    | threshold         | Int    | 否     | 群组投票阈值                                                     |

***2）入参示例***

```
{
  "groupId": 1,
  "signUserId": "user1001",
  "address": "0x2357ad9d97027cd71eea1d639f1e5750fbdfd38e",
  "threshold": 60
}
```

#### 响应参数

**1）数据格式**

透传链上返回结果
```
{
    "code":0,
    "msg":"success"
}
```


### 6.12.8. 查看运维列表

#### 接口描述

由链治理委员添加运维账号，运维账号可以部署合约、创建表、管理合约版本、冻结解冻本账号部署的合约。

#### 接口URL

**http://localhost:5002/WeBASE-Front/governance/operator/list**

#### 调用方法

HTTP GET

#### 请求参数

***1）入参表***

| 序号 | 输入参数        | 类型   | 可为空 | 备注                                                         |
| ---- | --------------- | ------ | ------ | ------------------------------------------------------------ |
| 1    | groupId         | Int    | 否     | 群组编号                                                     |

***2）入参示例***

```
http://localhost:5002/WeBASE-Front/governance/operator/list?groupId=1
```

#### 响应参数

**1）数据格式**

```
[
  {
    "address": "0x304852a7cc6511e62c37b6e189850861e41282b0",
    "enable_num": "3"
  }
]
```


### 6.12.9. 增加运维接口

#### 接口描述

由链治理委员添加运维账号，运维账号可以部署合约、创建表、管理合约版本、冻结解冻本账号部署的合约。

#### 接口URL

**http://localhost:5002/WeBASE-Front/governance/operator**

#### 调用方法

HTTP POST

#### 请求参数

***1）入参表***

| 序号 | 输入参数        | 类型   | 可为空 | 备注                                                         |
| ---- | --------------- | ------ | ------ | ------------------------------------------------------------ |
| 1    | groupId         | Int    | 否     | 群组编号                                                     |
| 2    | signUserId      | String | 否     | WeBASE-Sign签名用户编号                                      |
| 3    | address   | String           | 否     | 新的运维地址         |

***2）入参示例***

```
{
  "groupId": 1,
  "signUserId": "user1001",
  "address": "0x2357ad9d97027cd71eea1d639f1e5750fbdfd38e"
}
```

#### 响应参数

**1）数据格式**

透传链上返回结果
```
{
    "code":0,
    "msg":"success"
}
```

### 6.12.10. 取消运维接口

#### 接口描述

由链治理委员添加/取消运维账号；运维账号可以部署合约、创建表、管理合约版本、冻结解冻本账号部署的合约。
据块高，过期时间为块高超过blockLimit的10倍时过期；过期时间固定不可改。

#### 接口URL

**http://localhost:5002/WeBASE-Front/governance/operator**

#### 调用方法

HTTP DELETE

#### 请求参数

***1）入参表***

| 序号 | 输入参数        | 类型   | 可为空 | 备注                                                         |
| ---- | --------------- | ------ | ------ | ------------------------------------------------------------ |
| 1    | groupId         | Int    | 否     | 群组编号                                                     |
| 2    | signUserId      | String | 否     | WeBASE-Sign签名用户编号                                      |
| 3    | address   | String           | 否     | 待取消的运维地址         |

***2）入参示例***

```
{
  "groupId": 1,
  "signUserId": "user1001",
  "address": "0x2357ad9d97027cd71eea1d639f1e5750fbdfd38e"
}
```

#### 响应参数

**1）数据格式**

透传链上返回结果
```
{
    "code":0,
    "msg":"success"
}
```

## 7. 链上事件订阅接口

### 7.1. 获取出块事件的订阅信息列表

#### 接口描述

获取所有订阅的出块事件配置信息

将返回对应的id值, exchange, queue, routingKey等信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/event/newBlockEvent/list/{groupId}/{pageNumber}/{pageSize}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|     1    | 群组编号        | groupId            | int   |              | 是       | 群组编号                           |
|     2    | 页码         | pageNumber            | int   |              | 否       | 同时缺省则返回全量数据                           |
|     3    | 页大小       | pageSize            | int   |              | 否       |    同时缺省则返回全量数据                        |


**2）数据格式**

```
http://localhost:5002/WeBASE-Front/event/newBlockEvent/list/{groupId}/{pageNumber}/{pageSize}
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


​      
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

**http://localhost:5002/WeBASE-Front/event/contractEvent/list/{groupId}/{pageNumber}/{pageSize}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|     1    | 群组编号        | groupId            | int   |              | 是       | 群组编号                           |
|     2    | 页码         | pageNumber            | int   |              | 否       | 同时缺省则返回全量数据                           |
|     3    | 页大小       | pageSize            | int   |              | 否       |    同时缺省则返回全量数据                        |


**2）数据格式**

```
http://localhost:5002/WeBASE-Front/event/contractEvent/list/{groupId}/{pageNumber}/{pageSize}
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


### 7.9. 获取历史区块EventLog

#### 接口描述

同步获取历史区块中的EventLog

#### 接口URL

**http://localhost:5002/WeBASE-Front/event/eventLogs/list**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**   | **类型**       | **最大长度** | **必填** | **说明**                           |
| -------- | -------- | ------------ | -------------- | ------------ | -------- | -------------- |
| 1        | 所属群组 | groupId | Integer         |              | 是        |                      |
| 2        | 合约地址 | contractAddress      | String         |              | 是       |     已部署合约                   |
| 3        | 合约ABI | contractAbi      | List<Object>         |              | 是       |                        |
| 2        | Topic参数 | topics      | EventTopicParam         |              | 是       |  EventTopicParam包含`{String eventName,IndexedParamType indexed1,IndexedParamType indexed2,IndexedParamType indexed3}`,其中IndexedParamType包含`{String type,String value}`。eventName为包含参数类型的event名，如`SetEvent(uint256,string)`，IndexedParamType中type为indexed参数的类型，value为eventlog需要过滤的参数值 |
| 2        | 开始区块 | fromBlock      | Integer         |              | 是       |     始块高                   |
| 2        | 末区块 | toBlock      | Integer         |              | 是       |     末块高                   |


**2）数据格式**


```
{
    "groupId": "1",
    "contractAbi": [],
    "contractAddress": "0x19fb54101fef551187d3a79ea1c87de8d0ce754e",
    "fromBlock": 1,
    "toBlock": 1,
    "topics": {
        "eventName": "SetName",
        "indexed1": {
            "type": "bool",
            "value": true
        },
        "indexed2": {
            "type": "string",
            "value": null
        }
    }
}
```

#### 响应参数

**1）数据格式** 

成功：


```
{
	"code": 0,
	"message": "success",
	"data": [{
		"log": {
			"logIndex": 0,
			"transactionIndex": 0,
			"transactionHash": "0x67c8d9a1bc62586b9feb0c8b1127bf0030f649771db3e3d0d99cd99209851ed8",
			"blockHash": "0x0ca880c70a3f24dc5e6052cca4dbb50d9aa0ec973474e07d82e2f5281c54e582",
			"blockNumber": 71,
			"address": "0xd5d4fcf2a46831510f095bfb447bc945f99309f7",
			"data": "0x000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000033132330000000000000000000000000000000000000000000000000000000000",
			"topics": ["0x4df9dcd34ae35f40f2c756fd8ac83210ed0b76d065543ee73d868aec7c7fcf02"]
		}, // `org.fisco.bcos.sdk.model.EventLog`，可参考java sdk
		"data": ["123"]
	}, {
		"log": {
			"logIndex": 0,
			"transactionIndex": 0,
			"transactionHash": "0x7c27078b372cee951dd102edcbbeab6b3b799212e4337d6bfac7f723e487a1fb",
			"blockHash": "0x47f8456a656f226d5a4a7206790ae864ae4fb645bca625b87cf0378ecca7e742",
			"blockNumber": 72,
			"address": "0xd5d4fcf2a46831510f095bfb447bc945f99309f7",
			"data": "0x000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000033333330000000000000000000000000000000000000000000000000000000000",
			"topics": ["0x4df9dcd34ae35f40f2c756fd8ac83210ed0b76d065543ee73d868aec7c7fcf02"]
		},
		"data": ["333"]
	}],
	"totalCount": 1
}
```



### 7.10. 获取ABI与合约所有合约信息

#### 接口描述

获取导入的ABI与IDE中已部署合约所有合约的地址、合约名字信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/event/listAddress/{groupId}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**   | **类型**       | **最大长度** | **必填** | **说明**                           |
| -------- | -------- | ------------ | -------------- | ------------ | -------- | -------------- |
| 1        | 所属群组 | groupId | Integer         |              | 是        |                      |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/event/listAddress/{groupId}
```

#### 响应参数

**1）数据格式** 

成功：

```
{
    "code": 0,
    "message": "success",
    "data": [{
        "type": "contract",
        "contractAddress": "0x88156d500422a542435616e5a1e9d2df44c7fc70",
        "contractName": "Hello3"
    }, {
        "type": "contract",
        "contractAddress": "0xc2b3b552258b6016f80a070c1aa91bf9e3c48c53",
        "contractName": "Hello3"
    }, {
        "type": "abi",
        "contractAddress": "0x7a754bb46418c93b4cec7dcc6fef0676ae6a1e32",
        "contractName": "Hello3"
    }]
}
```


### 7.11. 根据地址获取ABI与合约的合约信息

#### 接口描述

根据合约地址、合约类型（`abi`或`contract`）获取导入的ABI与IDE中已部署合约的合约地址、合约名字信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/event/contractInfo/{groupId}/{type}/{contractAddress}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**   | **类型**       | **最大长度** | **必填** | **说明**                           |
| -------- | -------- | ------------ | -------------- | ------------ | -------- | -------------- |
| 1        | 所属群组 | groupId | Integer         |              | 是        |                      |
| 2        | 合约类型 | type | String         |              | 是        |    包含`contract`（IDE部署）和`abi`（ABI管理导入）两种类型                  |
| 3        | 合约地址 | contractAddress | String         |              | 是        |                      |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/event/contractInfo/{groupId}/{type}/{contractAddress}
```

#### 响应参数

**1）数据格式** 

成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "abiId": 1,
        "groupId": 1,
        "contractName": "Hello3",
        "contractAddress": "0x7a754bb46418c93b4cec7dcc6fef0676ae6a1e32",
        "contractAbi": "",
        "contractBin": "",
        "createTime": "2020-11-06 15:12:51",
        "modifyTime": "2020-11-06 15:12:51"
    }
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

## 9. 统计日志接口

### 9.1. 获取网络统计日志数据

#### 接口描述

​	统计日志数据存储在H2数据库，默认存储一万条，超过将不会从节点日志文件拉取新的数据。此时，获取完现有数据，可以调用**8.3 删除统计日志数据**进行删除，数据量少于一万条时，自动从节点日志文件拉取新的数据。

#### 接口URL

**http://localhost:5002/WeBASE-Front/charging/getNetWorkData?groupId={groupId}&pageSize={pageSize}&pageNumber={pageNumber}&beginDate={beginDate}&endDate={endDate}**

#### 调用方法

HTTP GET

#### 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型          | 可为空 | 备注                                                      |
| ---- | ---------- | ------------- | ------ | --------------------------------------------------------- |
| 1    | groupId    | Int           | 否     | 群组编号                                                  |
| 2    | pageSize   | Int           | 是     | 条数，默认10                                              |
| 3    | pageNumber | Int           | 是     | 页码，默认1                                               |
| 4    | beginDate  | LocalDateTime | 是     | 开始时间（yyyy-MM-dd'T'HH:mm:ss.SSS 2019-03-13T00:00:00） |
| 5    | endDate    | LocalDateTime | 是     | 结束时间                                                  |

***2）入参示例***

```
http://localhost:5002/WeBASE-Front/charging/getNetWorkData?groupId=1&pageSize=2&pageNumber=1&beginDate=2020-03-27T10:30:04&endDate=2020-03-27T17:30:04
```

#### 响应参数

***1）出参表***

| 序号  | 输出参数   | 类型   |      | 备注                                    |
| ----- | ---------- | ------ | ---- | --------------------------------------- |
| 1     | code       | Int    | 否   | 返回码，0：成功 其它：失败              |
| 2     | message    | String | 否   | 描述                                    |
| 3     | totalCount | Int    | 否   | 总记录数                                |
| 4     | data       | List   | 否   | 列表                                    |
| 4.1   |            | Object |      | 信息对象                                |
| 4.1.1 | id         | Long   | 否   | 主键                                    |
| 4.1.2 | groupId    | Int    | 否   | 群组编号                                |
| 4.1.3 | totalIn    | Long   | 否   | 总入流量（P2P_InBytes + SDK_InBytes）   |
| 4.1.4 | totalOut   | Long   | 否   | 总出流量（P2P_OutBytes + SDK_OutBytes） |
| 4.1.5 | timestamp  | Long   | 否   | 统计时间                                |

***2）出参示例***

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "id": 583,
      "totalIn": 53837,
      "totalOut": 54753,
      "groupId": 1,
      "timestamp": 1585277486000
    },
    {
      "id": 581,
      "totalIn": 55128,
      "totalOut": 55092,
      "groupId": 1,
      "timestamp": 1585277426000
    }
  ],
  "totalCount": 22
}
```

### 9.2. 获取交易Gas统计日志数据

#### 接口描述

​	统计日志数据存储在H2数据库，默认存储一万条，超过将不会从节点日志文件拉取新的数据。此时，获取完现有数据，可以调用**8.3 删除统计日志数据**进行删除，数据量少于一万条时，自动从节点日志文件拉取新的数据。

#### 接口URL

```
http://localhost:5002/WeBASE-Front/charging/getTxGasData?groupId={groupId}&pageSize={pageSize}&pageNumber={pageNumber}&beginDate={beginDate}&endDate={endDate}&transHash={transHash}
```

#### 调用方法

HTTP GET

#### 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型          | 可为空 | 备注                                                      |
| ---- | ---------- | ------------- | ------ | --------------------------------------------------------- |
| 1    | groupId    | Int           | 否     | 群组编号                                                  |
| 2    | pageSize   | Int           | 是     | 条数，默认10                                              |
| 3    | pageNumber | Int           | 是     | 页码，默认1                                               |
| 4    | beginDate  | LocalDateTime | 是     | 开始时间（yyyy-MM-dd'T'HH:mm:ss.SSS 2019-03-13T00:00:00） |
| 5    | endDate    | LocalDateTime | 是     | 结束时间                                                  |
| 6    | transHash  | String        | 是     | 交易hash，不为空时查询指定hash                            |

***2）入参示例***

```
http://localhost:5002/WeBASE-Front/charging/getTxGasData?groupId=1&pageSize=2&pageNumber=1&beginDate=2020-03-27T10:30:04&endDate=2020-03-27T17:30:04
```

#### 响应参数

***1）出参表***

| 序号  | 输出参数   | 类型   |      | 备注                       |
| ----- | ---------- | ------ | ---- | -------------------------- |
| 1     | code       | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2     | message    | String | 否   | 描述                       |
| 3     | totalCount | Int    | 否   | 总记录数                   |
| 4     | data       | List   | 否   | 列表                       |
| 4.1   |            | Object |      | 信息对象                   |
| 4.1.1 | id         | Long   | 否   | 主键                       |
| 4.1.2 | groupId    | Int    | 否   | 群组编号                   |
| 4.1.3 | transHash  | Long   | 否   | 交易hash                   |
| 4.1.4 | gasUsed    | Long   | 否   | 交易消耗的gas              |
| 4.1.5 | timestamp  | Long   | 否   | 统计时间                   |

***2）出参示例***

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "id": 5,
      "transHash": "c5e208ec70b899529e11311f1147b1ee24ab8f02301e6cdbe8252c77a89a0d4c",
      "gasUsed": 34949,
      "groupId": 1,
      "timestamp": 1585277499000
    },
    {
      "id": 4,
      "transHash": "d9d7800554b68c84a53e54eef8adceecca891dd0dd7e0069a3474a81d4eac440",
      "gasUsed": 44892,
      "groupId": 1,
      "timestamp": 1585277489000
    }
  ],
  "totalCount": 5
}
```

### 9.3. 删除统计日志数据

#### 接口描述

​	统计日志数据存储在H2数据库，默认存储一万条，超过将不会从节点日志文件拉取新的数据。此时，获取完现有数据，可以调用当前接口进行删除，数据量少于一万条时，自动从节点日志文件拉取新的数据。

#### 接口URL

**http://localhost:5002/WeBASE-Front/charging/deleteData?groupId={groupId}&type={type}&keepEndDate={keepEndDate}**

#### 调用方法

HTTP DELETE

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 可为空 | 备注                                                         |
| ---- | ----------- | ------------- | ------ | ------------------------------------------------------------ |
| 1    | groupId     | Int           | 否     | 群组编号                                                     |
| 2    | type        | Int           | 否     | 删除数据类型（1-网络统计数据；2-交易gas数据）                |
| 3    | keepEndDate | LocalDateTime | 否     | 保留截止时间（yyyy-MM-dd'T'HH:mm:ss.SSS 2019-03-13T00:00:00） |

***2）入参示例***

```
http://localhost:5002/WeBASE-Front/charging/deleteData?groupId=1&type=1&keepEndDate=2020-03-27T10:30:04
```

#### 响应参数

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data     | Int    | 否   | 处理条数                   |

***2）出参示例***

```
{
  "code": 0,
  "message": "success",
  "data": 5
}
```

## 10. 其他接口

### 10.1. 查询是否使用国密

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


### 10.2. 查询WeBASE-Front版本

#### 接口描述

获取WeBASE-Front的版本号

#### 接口URL

**http://localhost:5002/WeBASE-Front/version**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|          | -       | -            | -   |              |        |                            |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/version
```

#### 响应参数

**1）数据格式**

a、成功：

```
v1.4.0
```


### 10.3. 查询前置连接的WeBASE-Sign版本

#### 接口描述

获取WeBASE-Front的所连接的WeBASE-Sign的版本号

#### 接口URL

**http://localhost:5002/WeBASE-Front/version/sign**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|          | -       | -            | -   |              |        |                            |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/version/sign
```

#### 响应参数

**1）数据格式**

a、成功：

```
v1.4.0
```


### 10.4. 查询前置包含的solidity v0.6.10文件

#### 接口描述

获取WeBASE-Front的本地`conf/solcjs`中包含的solidity 0.6.10的js文件列表

*如需要使用solidity 0.6.10，则需要手动下载CDN中solidity的v0.6.10.js（国密v0.6.10-gm.js），并在WeBASE-Front的conf文件夹中创建solcjs文件夹，并将js文件复制到该文件夹。*

*注：使用webase-front.zip安装包直接部署则不需要手动放置js文件*

#### 接口URL

**http://localhost:5002/WeBASE-Front/solc/list**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|          | -       | -            | -   |              |        |                            |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/solc/list
```

#### 响应参数

**1）数据格式**

a、成功：

```
{
    "code":0,
    "message":"success",
    "data":["v0.6.10.js","v0.6.10-gm.js"]
}
```

## 11. 工具类接口


### 11.1. 解析Input/Output工具接口

#### 接口描述

根据合约ABI，解析交易回执中返回的input/output值

#### 接口URL

**http://localhost:5002/WeBASE-Front/tool/decode**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|  1        | 解析类型    | decodeType        | int      |              | 是       |   1-解析input，2-解析output                        |
|  2        | 返回类型    | returnType        | int      |              | 否       |   默认是1，1-实体类类型(`InputAndOutputResult.java`)，2-Json格式                        |
|  3        | 交易输入    | input        | String      |              | 否       |   交易输入值                        |
|  4        | 交易输出    | output        | String      |              | 否       |   交易输出值                        |
|  5        | 合约ABI    | abiList        | List<Object>|              | 是      |   合约ABI列表                        |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/tool/decode
```

解析output
```
{
    "abiList": [],
    "decodeType": 2,
    "input": "0x5d0d1f0a00000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000c0010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000001770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010100000000000000000000000000000000000000000000000000000000000000",
    "output": "0x00000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000001",
    "returnType": 2
}
```


#### 响应参数

**1）数据格式**

a、成功：

解析output，返回json
```
{
    "function": "set(uint256,uint256,bool,string,bytes1,bytes)",
    "methodID": "0x5d0d1f0a",
    "result": [{
        "name": "",
        "type": "uint256",
        "data": 1
    }, {
        "name": "",
        "type": "uint256",
        "data": 1
    }]
}
```

解析input，返回实体
```

{
  "function": "set(uint256,uint256,bool,string,bytes1,bytes)",
  "methodID": "0x5d0d1f0a",
  "result": [
    {
      "name": "n1",
      "type": "uint256",
      "data": 1
    },
    {
      "name": "n6",
      "type": "bytes",
      "data": ""
    }
  ]
}

```


### 11.2. 获取公私钥对

#### 接口描述

传入私钥时，返回对应的公私钥对；不传入私钥时，返回随机私钥对

#### 接口URL

**http://localhost:5002/WeBASE-Front/tool/keypair**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|  1        | 私钥值    | privateKey        | String      |              | 否       |   为空时，返回随机私钥对，BigInteger的HexString格式（十六进制）                        |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/tool/keypair
```

```
{
  "privateKey": "a81dfd0d3b1004d6635e099aeddd0e939481081372d791b0c477bb21c663105d"
}
```


#### 响应参数

**1）数据格式**

a、成功：

```
{
  "privateKey": "a81dfd0d3b1004d6635e099aeddd0e939481081372d791b0c477bb21c663105d",
  "publicKey": "0xaa95cfddb68f6e583a204e479536ac2d6f8fba254ef08cfad82aa48b1d9eadd58314d7cbd3c0a8461b68219577ee511e84c630a0df252afa35bd86aa12f1ebff",
  "address": "988f01939de8797789ea4889e39a7039af9f4c11",
  "encryptType": 0 // 0-ecdsa, 1-sm2
}
```



### 11.3. 根据公钥获取地址

#### 接口描述

根据公钥获取地址

#### 接口URL

**http://localhost:5002/WeBASE-Front/tool/address?publicKey={publicKey}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|  1        | 公钥值    | publicKey        | String      |              | 是       |   BigInteger的HexString格式（十六进制）                        |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/tool/address?publicKey=0xaa95cfddb68f6e583a204e479536ac2d6f8fba254ef08cfad82aa48b1d9eadd58314d7cbd3c0a8461b68219577ee511e84c630a0df252afa35bd86aa12f1ebff
```



#### 响应参数

**1）数据格式**

a、成功：

```
{
  "publicKey": "0xaa95cfddb68f6e583a204e479536ac2d6f8fba254ef08cfad82aa48b1d9eadd58314d7cbd3c0a8461b68219577ee511e84c630a0df252afa35bd86aa12f1ebff",
  "address": "988f01939de8797789ea4889e39a7039af9f4c11",
  "encryptType": 0 // 0-ecdsa, 1-sm2
}
```



### 11.4. 获取哈希值

#### 接口描述

获取哈希值

#### 接口URL

**http://localhost:5002/WeBASE-Front/tool/hash?input={123}&type={type}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|  1        | 输入值    | input        | String      |              | 是       |   待哈希的输入值                        |
|  2        | 入参类型    | type        | int      |              | 否      |   默认为1，1-hexString十六进制字符串，2-UTF8字符串                        |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/tool/hash??input=123&type=1
```



#### 响应参数

**1）数据格式**

a、成功：

type=1，入参为Hex String时：
```
{
  "hashValue": "0x667d3611273365cfb6e64399d5af0bf332ec3e5d6986f76bc7d10839b680eb58",
  "encryptType": 0
}
```

type=2，入参为UTF8类型时：
```
{
  "hashValue": "0x64e604787cbf194841e7b68d7cd28786f6c9a0a3ab9f8b0a0e87cb4387ab0107",
  "encryptType": 0
}
```



### 11.5. String转bytes32类型

#### 接口描述

UTF8字符串或HexString字符串转为solidity中的bytes32类型

#### 接口URL

**http://localhost:5002/WeBASE-Front/tool/convert2Bytes32?input={input}&type={type}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|  1        | 输入值    | input        | String      |              | 是       |   待转换的输入值                        |
|  2        | 入参类型    | type        | int      |              | 否      |   默认为1，1-hexString十六进制字符串，2-UTF8字符串                        |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/tool/utf8ToHexString??input=123&type=1
```


#### 响应参数

**1）数据格式**

a、成功：

type=1，入参为Hex String时：
```
0x0123000000000000000000000000000000000000000000000000000000000000
```

type=2，入参为UTF8类型时：
```
0x3132330000000000000000000000000000000000000000000000000000000000
```


### 11.6. UTF8字符串转十六进制

#### 接口描述

UTF8字符串转为HexString十六进制（无0x开头）

#### 接口URL

**http://localhost:5002/WeBASE-Front/tool/utf8ToHexString?input={input}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|  1        | 输入值    | input        | String      |              | 是       |   待转换的输入值                        |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/tool/utf8ToHexString??input=123
```


#### 响应参数

**1）数据格式**

a、成功：

``` 
313233
```


### 11.7. 获取指定私钥签名后的内容

#### 接口描述

UTF8字符串转为HexString十六进制（无0x开头）

#### 接口URL

**http://localhost:5002/WeBASE-Front/tool/signMsg**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|  1        | 私钥值   | privateKey        | String      |              | 是       |                           |
|  2        | 待签名的值    | rawData        | String      |              | 是       |                           |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/tool/signMsg
```

```
{ 
    "privateKey ": "1", 
    "rawData ": "123"
}
```

#### 响应参数

**1）数据格式**

a、成功：

``` 
{
  "signatureData": {
    "v": 28,
    "r": "igg6XONxOgnO5DBlbyZo2E12T13ZSMxdoiZBF06N6Vs=",
    "s": "G0mFLQfCH+5yKEEROkGLRH8FROTnSbYEYmpkEqsasxU=",
    "pub": null
  },
  "encryptType": 0
}
```


### 11.8. 获取.pem私钥的内容

#### 接口描述

传入.pem私钥，获取其值

#### 接口URL

**http://localhost:5002/WeBASE-Front/tool/decodePem**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|  1        | .pem私钥文件   | pemFile        | MultipartFile      |              | 是       |                           |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/tool/decodePem
```

form-data入参
```
{ 
    "pemFile ": 
}
```

#### 响应参数

**1）数据格式**

a、成功：

``` 
{
  "privateKey": "9b71fd37075dc2bb5d6c24145bfcbc12ae44df544cf67f067f3230ca22ccbd",
  "publicKey": "0x7bc349e6d8be4df636f09ece0290eb18fa3bc5fb37a79846894dcb414b5714eb50f522a6d7e9d762ad49d0718dbaca462bb4f44c81b27598b3ea6df1ef9b6fa0",
  "address": "4d400652406daabb315cece1e5f8b48020679aa2",
  "encryptType": 0
}
```


### 11.9. 获取.p12私钥的内容

#### 接口描述

传入.p12私钥，获取其值

#### 接口URL

**http://localhost:5002/WeBASE-Front/tool/decodeP12**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|  1        | .p12私钥文件   | p12File        | MultipartFile      |              | 是       |                           |
|  2        | .p12私钥密码   | p12Password        | String      |              | 是       | .p12私钥的密码默认""空字符串                           |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/tool/decodeP12
```

form-data入参
```
{ 
    "p12File ": ,
    "p12Password": ""
}
```

#### 响应参数

**1）数据格式**

a、成功：

``` 
{
  "privateKey": "9b71fd37075dc2bb5d6c24145bfcbc12ae44df544cf67f067f3230ca22ccbd",
  "publicKey": "0x7bc349e6d8be4df636f09ece0290eb18fa3bc5fb37a79846894dcb414b5714eb50f522a6d7e9d762ad49d0718dbaca462bb4f44c81b27598b3ea6df1ef9b6fa0",
  "address": "4d400652406daabb315cece1e5f8b48020679aa2",
  "encryptType": 0
}
```

## 12. 合约仓库

### 12.1. 获取合约仓库列表

#### 接口描述

> 返回合约仓库信息列表

#### 接口URL

**http://localhost:5002/WeBASE-Front/contractStore/getContractStoreList**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

无

**2）数据格式** 

```
http://localhost:5002/WeBASE-Front/contractStore/getContractStoreList
```

#### 响应参数

**1）数据格式**

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "storeId": 1,
      "storeName": "工具箱",
      "storeName_en": "Toolbox",
      "storeType": "1",
      "storeIcon": "toolboxId",
      "storeDesc": "工具箱中有常用的工具合约",
      "storeDetail": "工具箱中有常用的工具合约",
      "storeDesc_en": "Toolbox Contract suite",
      "storeDetail_en": "Toolbox Contract suite",
      "createTime": "2021-01-20 18:02:10",
      "modifyTime": "2021-01-20 18:02:10"
    },
    {
      "storeId": 2,
      "storeName": "存证应用",
      "storeName_en": "Evidence",
      "storeType": "2",
      "storeIcon": "evidenceId",
      "storeDesc": "一套区块链存证合约",
      "storeDetail": "一套区块链存证合约",
      "storeDesc_en": "Evidence Contract suite",
      "storeDetail_en": "Evidence Contract suite",
      "createTime": "2021-01-20 18:02:10",
      "modifyTime": "2021-01-20 18:02:10"
    },
    {
      "storeId": 3,
      "storeName": "积分应用",
      "storeName_en": "Points",
      "storeType": "3",
      "storeIcon": "pointsId",
      "storeDesc": "一套积分合约",
      "storeDetail": "一套积分合约",
      "storeDesc_en": "Points Contract suite",
      "storeDetail_en": "Points Contract suite",
      "createTime": "2021-01-20 18:02:10",
      "modifyTime": "2021-01-20 18:02:10"
    }
  ]
}
```

### 12.2. 根据仓库编号获取仓库信息

#### 接口描述

> 返回合约仓库信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/contractStore/getContractFolderById/{storeId}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 仓库编号 | storeId    | int      |              | 是       |          |

**2）数据格式** 

```
http://localhost:5002/WeBASE-Front/contractStore/getContractStoreById/1
```

#### 响应参数

**1）数据格式**

```
{
  "code": 0,
  "message": "success",
  "data": {
    "storeId": 1,
    "storeName": "工具箱",
    "storeName_en": "Toolbox",
    "storeType": "1",
    "storeIcon": "toolboxId",
    "storeDesc": "工具箱中有常用的工具合约",
    "storeDetail": "工具箱中有常用的工具合约",
    "storeDesc_en": "Toolbox Contract suite",
    "storeDetail_en": "Toolbox Contract suite",
    "createTime": "2021-01-20 18:02:10",
    "modifyTime": "2021-01-20 18:02:10"
  }
}
```

### 12.3. 根据仓库编号获取合约文件夹信息

#### 接口描述

> 返回合约文件夹信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/contractStore/getContractFolderById/{storeId}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 仓库编号 | storeId    | int      |              | 是       |          |

**2）数据格式** 

```
http://localhost:5002/WeBASE-Front/contractStore/getFolderItemListByStoreId/2
```

#### 响应参数

**1）数据格式**

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "contractFolderId": 2,
      "storeId": 2,
      "contractFolderName": "Evidence",
      "contractFolderDesc": "Evidence",
      "contractFolderDetail": "Evidence",
      "contractFolderDesc_en": "Evidence",
      "contractFolderDetail_en": "Evidence",
      "createTime": "2021-01-20 18:02:10",
      "modifyTime": "2021-01-20 18:02:10"
    }
  ]
}
```

### 12.4. 根据合约文件夹编号获取合约文件夹信息

#### 接口描述

> 返回合约文件夹信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/contractStore/getContractFolderById/{contractFolderId}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**       | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------------- | ---------------- | -------- | ------------ | -------- | -------- |
| 1        | 合约文件夹编号 | contractFolderId | int      |              | 是       |          |

**2）数据格式** 

```
http://localhost:5002/WeBASE-Front/contractStore/getContractFolderById/2
```

#### 响应参数

**1）数据格式**

```
{
  "code": 0,
  "message": "success",
  "data": {
    "contractFolderId": 2,
    "storeId": 2,
    "contractFolderName": "Evidence",
    "contractFolderDesc": "Evidence",
    "contractFolderDetail": "Evidence",
    "contractFolderDesc_en": "Evidence",
    "contractFolderDetail_en": "Evidence",
    "createTime": "2021-01-20 18:02:10",
    "modifyTime": "2021-01-20 18:02:10"
  }
}
```

### 12.5. 根据文件夹编号获取合约列表

#### 接口描述

> 返回合约信息列表

#### 接口URL

**http://localhost:5002/WeBASE-Front/contractStore/getContractItemByFolderId/{folderId}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**   | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | ---------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 文件夹编号 | folderId   | int      |              | 是       |          |

**2）数据格式** 

```
http://localhost:5002/WeBASE-Front/contractStore/getContractItemByFolderId/2
```

#### 响应参数

**1）数据格式**

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "contractId": 4,
      "contractFolderId": 2,
      "contractName": "Evidence",
      "contractDesc": "Evidence",
      "contractSrc": "cHJhZ21hIHNvbGlkaXR5IF4wLjQuNDsKY29udHJhY3QgRXZpZGVuY2VTaWduZXJzRGF0YUFCSXsgZnVuY3Rpb24gdmVyaWZ5KGFkZHJlc3MgYWRkcilwdWJsaWMgY29uc3RhbnQgcmV0dXJucyhib29sKXt9CmZ1bmN0aW9uIGdldFNpZ25lcih1aW50IGluZGV4KXB1YmxpYyBjb25zdGFudCByZXR1cm5zKGFkZHJlc3Mpe30gCmZ1bmN0aW9uIGdldFNpZ25lcnNTaXplKCkgcHVibGljIGNvbnN0YW50IHJldHVybnModWludCl7fQp9Cgpjb250cmFjdCBFdmlkZW5jZXsKICAgIAogICAgc3RyaW5nIGV2aWRlbmNlOwogICAgc3RyaW5nIGV2aWRlbmNlSW5mbzsKICAgIHN0cmluZyBldmlkZW5jZUlkOwogICAgdWludDhbXSBfdjsKICAgIGJ5dGVzMzJbXSBfcjsKICAgIGJ5dGVzMzJbXSBfczsKICAgIGFkZHJlc3NbXSBzaWduZXJzOwogICAgYWRkcmVzcyBwdWJsaWMgc2lnbmVyc0FkZHI7CiAgICAKICAgICAgICBldmVudCBhZGRTaWduYXR1cmVzRXZlbnQoc3RyaW5nIGV2aSwgc3RyaW5nIGluZm8sIHN0cmluZyBpZCwgdWludDggdiwgYnl0ZXMzMiByLCBieXRlczMyIHMpOwogICAgICAgIGV2ZW50IG5ld1NpZ25hdHVyZXNFdmVudChzdHJpbmcgZXZpLCBzdHJpbmcgaW5mbywgc3RyaW5nIGlkLCB1aW50OCB2LCBieXRlczMyIHIsIGJ5dGVzMzIgcyxhZGRyZXNzIGFkZHIpOwogICAgICAgIGV2ZW50IGVycm9yTmV3U2lnbmF0dXJlc0V2ZW50KHN0cmluZyBldmksIHN0cmluZyBpbmZvLCBzdHJpbmcgaWQsIHVpbnQ4IHYsIGJ5dGVzMzIgciwgYnl0ZXMzMiBzLGFkZHJlc3MgYWRkcik7CiAgICAgICAgZXZlbnQgZXJyb3JBZGRTaWduYXR1cmVzRXZlbnQoc3RyaW5nIGV2aSwgc3RyaW5nIGluZm8sIHN0cmluZyBpZCwgdWludDggdiwgYnl0ZXMzMiByLCBieXRlczMyIHMsYWRkcmVzcyBhZGRyKTsKICAgICAgICBldmVudCBhZGRSZXBlYXRTaWduYXR1cmVzRXZlbnQoc3RyaW5nIGV2aSwgc3RyaW5nIGluZm8sIHN0cmluZyBpZCwgdWludDggdiwgYnl0ZXMzMiByLCBieXRlczMyIHMpOwogICAgICAgIGV2ZW50IGVycm9yUmVwZWF0U2lnbmF0dXJlc0V2ZW50KHN0cmluZyBldmksIHN0cmluZyBpZCwgdWludDggdiwgYnl0ZXMzMiByLCBieXRlczMyIHMsIGFkZHJlc3MgYWRkcik7CgogICAgZnVuY3Rpb24gQ2FsbFZlcmlmeShhZGRyZXNzIGFkZHIpIHB1YmxpYyBjb25zdGFudCByZXR1cm5zKGJvb2wpIHsKICAgICAgICByZXR1cm4gRXZpZGVuY2VTaWduZXJzRGF0YUFCSShzaWduZXJzQWRkcikudmVyaWZ5KGFkZHIpOwogICAgfQoKICAgICAgIGZ1bmN0aW9uIEV2aWRlbmNlKHN0cmluZyBldmksIHN0cmluZyBpbmZvLCBzdHJpbmcgaWQsIHVpbnQ4IHYsIGJ5dGVzMzIgciwgYnl0ZXMzMiBzLCBhZGRyZXNzIGFkZHIsIGFkZHJlc3Mgc2VuZGVyKSBwdWJsaWMgewogICAgICAgc2lnbmVyc0FkZHIgPSBhZGRyOwogICAgICAgaWYoQ2FsbFZlcmlmeShzZW5kZXIpKQogICAgICAgewogICAgICAgICAgIGV2aWRlbmNlID0gZXZpOwogICAgICAgICAgIGV2aWRlbmNlSW5mbyA9IGluZm87CiAgICAgICAgICAgZXZpZGVuY2VJZCA9IGlkOwogICAgICAgICAgIF92LnB1c2godik7CiAgICAgICAgICAgX3IucHVzaChyKTsKICAgICAgICAgICBfcy5wdXNoKHMpOwogICAgICAgICAgIHNpZ25lcnMucHVzaChzZW5kZXIpOwogICAgICAgICAgIG5ld1NpZ25hdHVyZXNFdmVudChldmksaW5mbyxpZCx2LHIscyxhZGRyKTsKICAgICAgIH0KICAgICAgIGVsc2UKICAgICAgIHsKICAgICAgICAgICBlcnJvck5ld1NpZ25hdHVyZXNFdmVudChldmksaW5mbyxpZCx2LHIscyxhZGRyKTsKICAgICAgIH0KICAgIH0KCiAgICAgICAgZnVuY3Rpb24gZ2V0RXZpZGVuY2VJbmZvKCkgcHVibGljIGNvbnN0YW50IHJldHVybnMoc3RyaW5nKXsKICAgICAgICAgICAgcmV0dXJuIGV2aWRlbmNlSW5mbzsKICAgIH0KCiAgICBmdW5jdGlvbiBnZXRFdmlkZW5jZSgpIHB1YmxpYyBjb25zdGFudCByZXR1cm5zKHN0cmluZyxzdHJpbmcsc3RyaW5nLHVpbnQ4W10sYnl0ZXMzMltdLGJ5dGVzMzJbXSxhZGRyZXNzW10pewogICAgICAgIHVpbnQgbGVuZ3RoID0gRXZpZGVuY2VTaWduZXJzRGF0YUFCSShzaWduZXJzQWRkcikuZ2V0U2lnbmVyc1NpemUoKTsKICAgICAgICAgYWRkcmVzc1tdIG1lbW9yeSBzaWduZXJMaXN0ID0gbmV3IGFkZHJlc3NbXShsZW5ndGgpOwogICAgICAgICBmb3IodWludCBpPSAwIDtpPGxlbmd0aCA7aSsrKQogICAgICAgICB7CiAgICAgICAgICAgICBzaWduZXJMaXN0W2ldID0gKEV2aWRlbmNlU2lnbmVyc0RhdGFBQkkoc2lnbmVyc0FkZHIpLmdldFNpZ25lcihpKSk7CiAgICAgICAgIH0KICAgICAgICByZXR1cm4oZXZpZGVuY2UsZXZpZGVuY2VJbmZvLGV2aWRlbmNlSWQsX3YsX3IsX3Msc2lnbmVyTGlzdCk7CiAgICB9CgogICAgZnVuY3Rpb24gYWRkU2lnbmF0dXJlcyh1aW50OCB2LCBieXRlczMyIHIsIGJ5dGVzMzIgcykgcHVibGljIHJldHVybnMoYm9vbCkgewogICAgICAgIGZvcih1aW50IGk9IDAgO2k8c2lnbmVycy5sZW5ndGggO2krKykKICAgICAgICB7CiAgICAgICAgICAgIGlmKG1zZy5zZW5kZXIgPT0gc2lnbmVyc1tpXSkKICAgICAgICAgICAgewogICAgICAgICAgICAgICAgaWYoIF92W2ldID09IHYgJiYgX3JbaV0gPT0gciAmJiBfc1tpXSA9PSBzKQogICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAgIGFkZFJlcGVhdFNpZ25hdHVyZXNFdmVudChldmlkZW5jZSxldmlkZW5jZUluZm8sZXZpZGVuY2VJZCx2LHIscyk7CiAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICBlbHNlCiAgICAgICAgICAgICAgICB7CiAgICAgICAgICAgICAgICAgICAgIGVycm9yUmVwZWF0U2lnbmF0dXJlc0V2ZW50KGV2aWRlbmNlLGV2aWRlbmNlSWQsdixyLHMsbXNnLnNlbmRlcik7CiAgICAgICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgIGlmKENhbGxWZXJpZnkobXNnLnNlbmRlcikpCiAgICAgICB7CiAgICAgICAgICAgIF92LnB1c2godik7CiAgICAgICAgICAgIF9yLnB1c2gocik7CiAgICAgICAgICAgIF9zLnB1c2gocyk7CiAgICAgICAgICAgIHNpZ25lcnMucHVzaChtc2cuc2VuZGVyKTsKICAgICAgICAgICAgYWRkU2lnbmF0dXJlc0V2ZW50KGV2aWRlbmNlLGV2aWRlbmNlSW5mbyxldmlkZW5jZUlkLHYscixzKTsKICAgICAgICAgICAgcmV0dXJuIHRydWU7CiAgICAgICB9CiAgICAgICBlbHNlCiAgICAgICB7CiAgICAgICAgICAgZXJyb3JBZGRTaWduYXR1cmVzRXZlbnQoZXZpZGVuY2UsZXZpZGVuY2VJbmZvLGV2aWRlbmNlSWQsdixyLHMsbXNnLnNlbmRlcik7CiAgICAgICAgICAgcmV0dXJuIGZhbHNlOwogICAgICAgfQogICAgfQogICAgCiAgICBmdW5jdGlvbiBnZXRTaWduZXJzKClwdWJsaWMgY29uc3RhbnQgcmV0dXJucyhhZGRyZXNzW10pCiAgICB7CiAgICAgICAgIHVpbnQgbGVuZ3RoID0gRXZpZGVuY2VTaWduZXJzRGF0YUFCSShzaWduZXJzQWRkcikuZ2V0U2lnbmVyc1NpemUoKTsKICAgICAgICAgYWRkcmVzc1tdIG1lbW9yeSBzaWduZXJMaXN0ID0gbmV3IGFkZHJlc3NbXShsZW5ndGgpOwogICAgICAgICBmb3IodWludCBpPSAwIDtpPGxlbmd0aCA7aSsrKQogICAgICAgICB7CiAgICAgICAgICAgICBzaWduZXJMaXN0W2ldID0gKEV2aWRlbmNlU2lnbmVyc0RhdGFBQkkoc2lnbmVyc0FkZHIpLmdldFNpZ25lcihpKSk7CiAgICAgICAgIH0KICAgICAgICAgcmV0dXJuIHNpZ25lckxpc3Q7CiAgICB9Cn0=",
      "contractDesc_en": "Evidence",
      "createTime": "2021-01-20 18:02:10",
      "modifyTime": "2021-01-20 18:02:10"
    },
    {
      "contractId": 5,
      "contractFolderId": 2,
      "contractName": "EvidenceSignersData",
      "contractDesc": "EvidenceSignersData",
      "contractSrc": "cHJhZ21hIHNvbGlkaXR5IF4wLjQuNDsKaW1wb3J0ICJFdmlkZW5jZS5zb2wiOwoKY29udHJhY3QgRXZpZGVuY2VTaWduZXJzRGF0YXsKICAgICAgICBhZGRyZXNzW10gc2lnbmVyczsKCQlldmVudCBuZXdFdmlkZW5jZUV2ZW50KGFkZHJlc3MgYWRkcik7CiAgICAgICAgZnVuY3Rpb24gbmV3RXZpZGVuY2Uoc3RyaW5nIGV2aSwgc3RyaW5nIGluZm8sc3RyaW5nIGlkLHVpbnQ4IHYsIGJ5dGVzMzIgcixieXRlczMyIHMpcHVibGljIHJldHVybnMoYWRkcmVzcykKICAgICAgICB7CiAgICAgICAgICAgIEV2aWRlbmNlIGV2aWRlbmNlID0gbmV3IEV2aWRlbmNlKGV2aSwgaW5mbywgaWQsIHYsIHIsIHMsIHRoaXMsIG1zZy5zZW5kZXIpOwogICAgICAgICAgICBuZXdFdmlkZW5jZUV2ZW50KGV2aWRlbmNlKTsKICAgICAgICAgICAgcmV0dXJuIGV2aWRlbmNlOwogICAgICAgIH0KCiAgICAgICAgZnVuY3Rpb24gRXZpZGVuY2VTaWduZXJzRGF0YShhZGRyZXNzW10gZXZpZGVuY2VTaWduZXJzKXB1YmxpY3sKICAgICAgICAgICAgZm9yKHVpbnQgaT0wOyBpPGV2aWRlbmNlU2lnbmVycy5sZW5ndGg7ICsraSkgewogICAgICAgICAgICBzaWduZXJzLnB1c2goZXZpZGVuY2VTaWduZXJzW2ldKTsKCQkJfQoJCX0KCiAgICBmdW5jdGlvbiB2ZXJpZnkoYWRkcmVzcyBhZGRyKXB1YmxpYyBjb25zdGFudCByZXR1cm5zKGJvb2wpewogICAgZm9yKHVpbnQgaT0wOyBpPHNpZ25lcnMubGVuZ3RoOyArK2kpIHsKICAgICAgICBpZiAoYWRkciA9PSBzaWduZXJzW2ldKQogICAgICAgIHsKICAgICAgICAgICAgcmV0dXJuIHRydWU7CiAgICAgICAgfQogICAgfQogICAgcmV0dXJuIGZhbHNlOwp9CgogICAgZnVuY3Rpb24gZ2V0U2lnbmVyKHVpbnQgaW5kZXgpcHVibGljIGNvbnN0YW50IHJldHVybnMoYWRkcmVzcyl7CiAgICAgICAgdWludCBsaXN0U2l6ZSA9IHNpZ25lcnMubGVuZ3RoOwogICAgICAgIGlmKGluZGV4IDwgbGlzdFNpemUpCiAgICAgICAgewogICAgICAgICAgICByZXR1cm4gc2lnbmVyc1tpbmRleF07CiAgICAgICAgfQogICAgICAgIGVsc2UKICAgICAgICB7CiAgICAgICAgICAgIHJldHVybiAwOwogICAgICAgIH0KCiAgICB9CgogICAgZnVuY3Rpb24gZ2V0U2lnbmVyc1NpemUoKSBwdWJsaWMgY29uc3RhbnQgcmV0dXJucyh1aW50KXsKICAgICAgICByZXR1cm4gc2lnbmVycy5sZW5ndGg7CiAgICB9CgogICAgZnVuY3Rpb24gZ2V0U2lnbmVycygpIHB1YmxpYyBjb25zdGFudCByZXR1cm5zKGFkZHJlc3NbXSl7CiAgICAgICAgcmV0dXJuIHNpZ25lcnM7CiAgICB9Cgp9",
      "contractDesc_en": "EvidenceSignersData",
      "createTime": "2021-01-20 18:02:10",
      "modifyTime": "2021-01-20 18:02:10"
    }
  ]
}
```

### 12.6. 根据合约编号获取合约信息

#### 接口描述

> 返回合约信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/contractStore/getContractItemById/{contractId}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 合约编号 | contractId | int      |              | 是       |          |

**2）数据格式** 

```
http://localhost:5002/WeBASE-Front/contractStore/getContractItemById/2
```

#### 响应参数

**1）数据格式**

```
{
  "code": 0,
  "message": "success",
  "data": {
    "contractId": 2,
    "contractFolderId": 1,
    "contractName": "LibSafeMathForUint256Utils",
    "contractDesc": "LibSafeMathForUint256Utils",
    "contractSrc": "LyoKICogQ29weXJpZ2h0IDIwMTQtMjAxOSB0aGUgb3JpZ2luYWwgYXV0aG9yIG9yIGF1dGhvcnMuCiAqCiAqIExpY2Vuc2VkIHVuZGVyIHRoZSBBcGFjaGUgTGljZW5zZSwgVmVyc2lvbiAyLjAgKHRoZSAiTGljZW5zZSIpOwogKiB5b3UgbWF5IG5vdCB1c2UgdGhpcyBmaWxlIGV4Y2VwdCBpbiBjb21wbGlhbmNlIHdpdGggdGhlIExpY2Vuc2UuCiAqIFlvdSBtYXkgb2J0YWluIGEgY29weSBvZiB0aGUgTGljZW5zZSBhdAogKgogKiAgICAgIGh0dHA6Ly93d3cuYXBhY2hlLm9yZy9saWNlbnNlcy9MSUNFTlNFLTIuMAogKgogKiBVbmxlc3MgcmVxdWlyZWQgYnkgYXBwbGljYWJsZSBsYXcgb3IgYWdyZWVkIHRvIGluIHdyaXRpbmcsIHNvZnR3YXJlCiAqIGRpc3RyaWJ1dGVkIHVuZGVyIHRoZSBMaWNlbnNlIGlzIGRpc3RyaWJ1dGVkIG9uIGFuICJBUyBJUyIgQkFTSVMsCiAqIFdJVEhPVVQgV0FSUkFOVElFUyBPUiBDT05ESVRJT05TIE9GIEFOWSBLSU5ELCBlaXRoZXIgZXhwcmVzcyBvciBpbXBsaWVkLgogKiBTZWUgdGhlIExpY2Vuc2UgZm9yIHRoZSBzcGVjaWZpYyBsYW5ndWFnZSBnb3Zlcm5pbmcgcGVybWlzc2lvbnMgYW5kCiAqIGxpbWl0YXRpb25zIHVuZGVyIHRoZSBMaWNlbnNlLgogKiAqLwoKcHJhZ21hIHNvbGlkaXR5IF4wLjQuMjU7CgpsaWJyYXJ5IExpYlNhZmVNYXRoRm9yVWludDI1NlV0aWxzIHsKCiAgICBmdW5jdGlvbiBhZGQodWludDI1NiBhLCB1aW50MjU2IGIpIGludGVybmFsIHB1cmUgcmV0dXJucyAodWludDI1NikgewogICAgICAgIHVpbnQyNTYgYyA9IGEgKyBiOwogICAgICAgIHJlcXVpcmUoYyA+PSBhLCAiU2FmZU1hdGhGb3JVaW50MjU2OiBhZGRpdGlvbiBvdmVyZmxvdyIpOwogICAgICAgIHJldHVybiBjOwogICAgfQoKICAgIGZ1bmN0aW9uIHN1Yih1aW50MjU2IGEsIHVpbnQyNTYgYikgaW50ZXJuYWwgcHVyZSByZXR1cm5zICh1aW50MjU2KSB7CiAgICAgICAgcmVxdWlyZShiIDw9IGEsICJTYWZlTWF0aEZvclVpbnQyNTY6IHN1YnRyYWN0aW9uIG92ZXJmbG93Iik7CiAgICAgICAgdWludDI1NiBjID0gYSAtIGI7CiAgICAgICAgcmV0dXJuIGM7CiAgICB9CgogICAgZnVuY3Rpb24gbXVsKHVpbnQyNTYgYSwgdWludDI1NiBiKSBpbnRlcm5hbCBwdXJlIHJldHVybnMgKHVpbnQyNTYpIHsKICAgICAgICBpZiAoYSA9PSAwIHx8IGIgPT0gMCkgewogICAgICAgICAgICByZXR1cm4gMDsKICAgICAgICB9CgogICAgICAgIHVpbnQyNTYgYyA9IGEgKiBiOwogICAgICAgIHJlcXVpcmUoYyAvIGEgPT0gYiwgIlNhZmVNYXRoRm9yVWludDI1NjogbXVsdGlwbGljYXRpb24gb3ZlcmZsb3ciKTsKICAgICAgICByZXR1cm4gYzsKICAgIH0KCiAgICBmdW5jdGlvbiBkaXYodWludDI1NiBhLCB1aW50MjU2IGIpIGludGVybmFsIHB1cmUgcmV0dXJucyAodWludDI1NikgewogICAgICAgIHJlcXVpcmUoYiA+IDAsICJTYWZlTWF0aEZvclVpbnQyNTY6IGRpdmlzaW9uIGJ5IHplcm8iKTsKICAgICAgICB1aW50MjU2IGMgPSBhIC8gYjsKICAgICAgICByZXR1cm4gYzsKICAgIH0KCiAgICBmdW5jdGlvbiBtb2QodWludDI1NiBhLCB1aW50MjU2IGIpIGludGVybmFsIHB1cmUgcmV0dXJucyAodWludDI1NikgewogICAgICAgIHJlcXVpcmUoYiAhPSAwLCAiU2FmZU1hdGhGb3JVaW50MjU2OiBtb2R1bG8gYnkgemVybyIpOwogICAgICAgIHJldHVybiBhICUgYjsKICAgIH0KCiAgICBmdW5jdGlvbiBwb3dlcih1aW50MjU2IGEsIHVpbnQyNTYgYikgaW50ZXJuYWwgcHVyZSByZXR1cm5zICh1aW50MjU2KXsKCiAgICAgICAgaWYoYSA9PSAwKSByZXR1cm4gMDsKICAgICAgICBpZihiID09IDApIHJldHVybiAxOwoKICAgICAgICB1aW50MjU2IGMgPSAxOwogICAgICAgIGZvcih1aW50MjU2IGkgPSAwOyBpIDwgYjsgaSsrKXsKICAgICAgICAgICAgYyA9IG11bChjLCBhKTsKICAgICAgICB9CiAgICB9CgogICAgZnVuY3Rpb24gbWF4KHVpbnQyNTYgYSwgdWludDI1NiBiKSBpbnRlcm5hbCBwdXJlIHJldHVybnMgKHVpbnQyNTYpIHsKICAgICAgICByZXR1cm4gYSA+PSBiID8gYSA6IGI7CiAgICB9CgogICAgZnVuY3Rpb24gbWluKHVpbnQyNTYgYSwgdWludDI1NiBiKSBpbnRlcm5hbCBwdXJlIHJldHVybnMgKHVpbnQyNTYpIHsKICAgICAgICByZXR1cm4gYSA8IGIgPyBhIDogYjsKICAgIH0KCiAgICBmdW5jdGlvbiBhdmVyYWdlKHVpbnQyNTYgYSwgdWludDI1NiBiKSBpbnRlcm5hbCBwdXJlIHJldHVybnMgKHVpbnQyNTYpIHsKICAgICAgICByZXR1cm4gKGEgLyAyKSArIChiIC8gMikgKyAoKGEgJSAyICsgYiAlIDIpIC8gMik7CiAgICB9Cn0K",
    "contractDesc_en": "LibSafeMathForUint256Utils",
    "createTime": "2021-01-20 18:02:10",
    "modifyTime": "2021-01-20 18:02:10"
  }
}
```

## 13. 证书管理


### 13.1. 查询节点证书接口

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



### 13.2. 获取明文SDK证书与私钥

#### 接口描述

获取Front使用的sdk证书（包含链证书、sdk证书和sdk私钥）的内容


#### 接口URL


**http://localhost:5002/WeBASE-Front/cert/sdk**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|          | -       | -            | -   |              |        |                            |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/cert/sdk
```

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **必填** | **说明**              |
| -------- | -------- | ---------- | -------- | -------- | --------------------- |
| 1        |   | Map<String,String>       | Map   | 是       | key为文件名，value为文件内容 |


**1）数据格式**

a、成功：

```
{
  "sdk.key": "-----BEGIN PRIVATE KEY-----\nMIGEAgEAMBAGByqGSM49AgEGBSuBBAAKBG0wawIBAQQgxqr/d/VgQ0fAr/KvyAeW\nJ6bD1tqxZ5gYOdfIJiK7WOmhRANCAAT3g/OsuSAD2I/dKLWnZTbMGQ8l9WnkD/wr\npyoiQkMy1qI5/3Sj4WFKGcVu9vhsd0nLoP+y1QttYKM0m5QGcuhP\n-----END PRIVATE KEY-----\n",
  "ca.crt": "-----BEGIN CERTIFICATE-----\nMIIBsDCCAVagAwIBAgIJAPwQ7ISyofOIMAoGCCqGSM49BAMCMDUxDjAMBgNVBAMM\nBWNoYWluMRMwEQYDVQQKDApmaXNjby1iY29zMQ4wDAYDVQQLDAVjaGFpbjAgFw0y\nMTA0MDYxMjMwNDBaGA8yMTIxMDMxMzEyMzA0MFowNTEOMAwGA1UEAwwFY2hhaW4x\nEzARBgNVBAoMCmZpc2NvLWJjb3MxDjAMBgNVBAsMBWNoYWluMFYwEAYHKoZIzj0C\nAQYFK4EEAAoDQgAE6UcrK7ukGBVvBmWYwgIloM38ibqtxF2zBnM9zgU4bujjJU1Y\nCZsHGKVGuNstSOZYfYulnTtFUoHhUEyhddvql6NQME4wHQYDVR0OBBYEFBBSyZi8\nk/Hz/Q2SAin5bMnE1nOFMB8GA1UdIwQYMBaAFBBSyZi8k/Hz/Q2SAin5bMnE1nOF\nMAwGA1UdEwQFMAMBAf8wCgYIKoZIzj0EAwIDSAAwRQIgEpuPZypVImOtDty9p50X\njeD4wdgzHXpd3CDPui4CnZYCIQC4n+r97cCB51dPb+WjDNV5C18S2uI8LlNVj+xL\ndSweAg==\n-----END CERTIFICATE-----\n",
  "sdk.crt": "-----BEGIN CERTIFICATE-----\nMIIBeDCCAR+gAwIBAgIJAJoEtSMUsa8HMAoGCCqGSM49BAMCMDgxEDAOBgNVBAMM\nB2FnZW5jeUExEzARBgNVBAoMCmZpc2NvLWJjb3MxDzANBgNVBAsMBmFnZW5jeTAg\nFw0yMTA0MDYxMjMwNDBaGA8yMTIxMDMxMzEyMzA0MFowMTEMMAoGA1UEAwwDc2Rr\nMRMwEQYDVQQKDApmaXNjby1iY29zMQwwCgYDVQQLDANzZGswVjAQBgcqhkjOPQIB\nBgUrgQQACgNCAAT3g/OsuSAD2I/dKLWnZTbMGQ8l9WnkD/wrpyoiQkMy1qI5/3Sj\n4WFKGcVu9vhsd0nLoP+y1QttYKM0m5QGcuhPoxowGDAJBgNVHRMEAjAAMAsGA1Ud\nDwQEAwIF4DAKBggqhkjOPQQDAgNHADBEAiANbeRFiiS6mH+vcAOwV3wXd9YW/B2a\n+vrHMm6NwtliRAIgRH4gSF0XLmpVOEO21bJFDGWm9siIX0cnj0R3kNGZcB4=\n-----END CERTIFICATE-----\n-----BEGIN CERTIFICATE-----\nMIIBcTCCARegAwIBAgIJANrOZ+FrVNpIMAoGCCqGSM49BAMCMDUxDjAMBgNVBAMM\nBWNoYWluMRMwEQYDVQQKDApmaXNjby1iY29zMQ4wDAYDVQQLDAVjaGFpbjAeFw0y\nMTA0MDYxMjMwNDBaFw0zMTA0MDQxMjMwNDBaMDgxEDAOBgNVBAMMB2FnZW5jeUEx\nEzARBgNVBAoMCmZpc2NvLWJjb3MxDzANBgNVBAsMBmFnZW5jeTBWMBAGByqGSM49\nAgEGBSuBBAAKA0IABIqMDvvzvTq8WW1UtJrnnsifw9/OrPsMc9CrrYBsWdwOGhdx\nfNTJA1ss+vngjrhAmWHczvbh+E1WOlDGzpCumeqjEDAOMAwGA1UdEwQFMAMBAf8w\nCgYIKoZIzj0EAwIDSAAwRQIhALsAbAQ9BDeofk4VYzYx2ZAHB1HviDp9ndvXAkLN\nsfHZAiAjViK97dDr3gxP/qHg0e8BG9ptEv7Do8caOPj33F+yOQ==\n-----END CERTIFICATE-----\n-----BEGIN CERTIFICATE-----\nMIIBsDCCAVagAwIBAgIJAPwQ7ISyofOIMAoGCCqGSM49BAMCMDUxDjAMBgNVBAMM\nBWNoYWluMRMwEQYDVQQKDApmaXNjby1iY29zMQ4wDAYDVQQLDAVjaGFpbjAgFw0y\nMTA0MDYxMjMwNDBaGA8yMTIxMDMxMzEyMzA0MFowNTEOMAwGA1UEAwwFY2hhaW4x\nEzARBgNVBAoMCmZpc2NvLWJjb3MxDjAMBgNVBAsMBWNoYWluMFYwEAYHKoZIzj0C\nAQYFK4EEAAoDQgAE6UcrK7ukGBVvBmWYwgIloM38ibqtxF2zBnM9zgU4bujjJU1Y\nCZsHGKVGuNstSOZYfYulnTtFUoHhUEyhddvql6NQME4wHQYDVR0OBBYEFBBSyZi8\nk/Hz/Q2SAin5bMnE1nOFMB8GA1UdIwQYMBaAFBBSyZi8k/Hz/Q2SAin5bMnE1nOF\nMAwGA1UdEwQFMAMBAf8wCgYIKoZIzj0EAwIDSAAwRQIgEpuPZypVImOtDty9p50X\njeD4wdgzHXpd3CDPui4CnZYCIQC4n+r97cCB51dPb+WjDNV5C18S2uI8LlNVj+xL\ndSweAg==\n-----END CERTIFICATE-----\n"
}
```


### 13.2. 获取SDK证书与私钥压缩包

#### 接口描述

获取Front使用的sdk证书（包含链证书、sdk证书和sdk私钥）的zip压缩包


#### 接口URL


**http://localhost:5002/WeBASE-Front/cert/sdk/zip**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
|          | -       | -            | -   |              |        |                            |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/cert/sdk/zip
```

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **必填** | **说明**              |
| -------- | -------- | ---------- | -------- | -------- | --------------------- |
| 1        | 文件名  | ResponseEntity.header       | String   | 是       | 文件名在header中 |
| 2        | 文件流 | body  | InputStream   | 是       |    文件的流在body中   |


**1）数据格式**

a、成功：

```
headers:  content-disposition: attachment;filename*=UTF-8''conf.zip 

{
    // 二进制流
}
```


## 14. 附录

### 1. 返回码信息列表 
<span id="code"></span>

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
| 201045 | encode string can not be empty               | 已签名的参数内容不能为空                 |
| 201046 | transaction failed                           | 交易上链失败                 |
| 201050 | Fail to parse json                           | 链上返回值反序列化失败                 |
| 201051 | get consensus status fail                    | 交易上链失败                 |
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
| 201154 | contract path is exists. | 合约路径已存在 |
| 201155 | contract path cannot be empty | 合约路径不能为空 |
| 201156 | Write front's sdk cert and key fail | 导出SDK证书私钥文件失败，写入文件失败 |
| 201157 | Write private key file fail | 导出私钥文件失败，写入文件失败 |
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
| 201223 | cns register fail | cns注册失败 |
| 201224 | version not exists | 版本不存在 |
| 201225 | cns name cannot be empty | cns名不能为空 |
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
| 201301  | threshold must be greater than zero        |   链阈值必须大于0       |
| 201302  | committee weight must be greater than zero  |   链委员权重必须大于0       |
| 201303  | chain governance address cannot be blank      |   链管理委员/运维地址不能为空       |
| 201311  | get event callback fail for time out     |   获取event回调超时      |
| 201312  | get event callback error    |   获取event回调失败       |
| 201501  | sdk create key pair fail and return null    |   sdk创建私钥对失败并返回Null       |
| 201502  | pem/p12 manager get key pair error for input params    |   pem/p12证书获取私钥对失败，检查入参       |
| 201503  | pem/p12 manager get key pair error for bc dependency error    |    pem/p12证书获取私钥对失败，检查bc依赖包版本       |
| 201504  | sign service return error    |   签名服务并返回异常       |
| 201510  | transaction receipt status return error    |   交易回执状态码非0x0，交易执行失败       |
| 201511  | contract abi parse json error    |   合约ABI转JSON失败       |
| 201512  | call contract error for io exception    |   调用合约的交易上链失败       |
| 201513  | get transaction receipt fail for exec    |   获取交易回执失败，返回执行错误       |
| 201514  | get transaction receipt fail for time out    |   获取交易回执失败，链上链下请求超时      |
| 201515  | transaction receipt fail and parse output fail    |   转化交易回执中output输出值失败       |
| 201516  | transaction receipt fail and output is null    |   交易回执output为空       |
| 201517  | call contract constant method fail    |   合约状态异常，调用合约constant方法失败       |
| 201518  | get message's hash fail   |   获取哈希失败       |
| 201521  | get list of manager on chain fail    |   获取链上管理员列表失败       |
| 201522  | table key length error    |   用户表的键值长度大于最大值255       |
| 201523  | crud's param parse json error    |   CRUD方法的入参转Entry/Condition失败，请检查入参       |
| 201524  | precompiled common transfer to json fail    |   预编译错误码转JSON失败       |


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
| -51600  | invalid ciphers                                 |          |
| -51700  | group sig failed                                |          |
| -51800  | ring sig failed                                 |          |
| -51900  | contract frozen                              |          |
| -51901  | contract available                              |          |
| -51902  | contract repeat authorization                    |          |
| -51903  | invalid contract address                    |          |
| -51904  | table not exist                    |          |
| -51905  | no authorized                  |          |
| -52000  | committee member exist                    |          |
| -52001  | committee member not exist                |          |
| -52002  | invalid request permission denied         |          |
| -52003  | invalid threshold                    |          |
| -52004  | operator can't be committee member                    |          |
| -52005  | committee member can't be operator                    |          |
| -52006  | operator exist                    |          |
| -52007  | operator not exist                    |          |
| -52008  | account not exist                    |          |
| -52009  | invalid account address                    |          |
| -52010  | account already available                   |          |
| -52011  | account frozen                    |          |
| -52012  | current value is expected value              |          |
