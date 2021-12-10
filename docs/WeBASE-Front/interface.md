
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
| 1        | 所属群组 | groupId | String   |              | 是        |                      |
| 2        | 合约名称 | contractName | String         |  | 是        |                      |
| 3        | 合约地址 | address      | String         |              | 是       |                        |
| 4        | 合约abi  | abiInfo      | List   |              | 是       | abi文件里面的内容，是一个JSONArray |
| 5        | 合约bin      | contractBin  | String         |              | 是       |  合约编译的runtime-bytecode(runtime-bin)       |
| 6 | 所在目录 | packageName | String | | 是 | 生成java所在的包名 |


**2）数据格式**
```
{
  "abiInfo": [
    {
      "anonymous": true,
      "constant": true,
      "inputs": [
        {
          "components": [
            null
          ],
          "dynamic": true,
          "indexed": true,
          "internalType": "string",
          "name": "string",
          "type": "string",
          "typeAsString": "string"
        }
      ],
      "methodSignatureAsString": "string",
      "name": "string",
      "outputs": [
        {
          "components": [
            null
          ],
          "dynamic": true,
          "indexed": true,
          "internalType": "string",
          "name": "string",
          "type": "string",
          "typeAsString": "string"
        }
      ],
      "payable": true,
      "stateMutability": "string",
      "type": "string"
    }
  ],
  "address": "string",
  "contractBin": "string",
  "contractName": "string",
  "groupId": "string",
  "packageName": "string"
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
| 1        | 所属群组     | groupId      | String |              | 是       |                      |
| 2        | 用户编号     | signUserId    | String   |             | 是       | WeBASE-Sign中的用户编号，通过webase-sign创建私钥获取 |
| 3        | 合约名称     | contractName | String   |              | 否      |                      |
| 4        | 合约abi      | abiInfo      | List     |              | 是       |  合约编译后生成的abi内容  |
| 5        | 合约bytecodeBin | bytecodeBin  | String   |              | 是       |  合约编译的bytecode(bin)，用于部署合约|
| 6        | 构造函数参数 | funcParam    | List     |              | 否       | 合约构造函数所需参数，JSON数组，多个参数以逗号分隔（参数为数组时同理），如：["str1",["arr1","arr2"]] |
| 7        | 合约版本     | version     | String    |             |   否       |  用于指定合约在CNS中的版本    |
| 8 | 合约bin | contractBin | String | | 是 |  |
| 9 | 合约id | contractId | Long | | 是 | 合约唯一id |
| 10 | 合约路径 | contractPath | String | | 是 |  |
| 11 | 合约来源 | contractSource | String | | 是 |  |
| 12 | 是否aes | useAes | Boolean | | 是 |  |
| 13 | 用户 | user | String | | 是 |  |

**2）数据格式**

```
{
  "abiInfo": [
    {}
  ],
  "bytecodeBin": "string",
  "contractBin": "string",
  "contractId": 0,
  "contractName": "string",
  "contractPath": "string",
  "contractSource": "string",
  "funcParam": [
    {}
  ],
  "groupId": "string",
  "signUserId": "string",
  "useAes": true,
  "user": "string",
  "version": "string"
}
```

示例：

```
curl -X POST "http://localhost:5002/WeBASE-Front/contract/deployWithSign"  -H "accept: */*" -H "Content-Type: application/json" -d "{ \"abiInfo\":[{\t\t\"constant\": true,\t\t\"inputs\": [],\t\t\"name\": \"get\",\t\t\"outputs\": [{\t\t\t\"name\": \"\",\t\t\t\"type\": \"string\"\t\t}],\t\t\"payable\": false,\t\t\"stateMutability\": \"view\",\t\t\"type\": \"function\"\t}, {\t\t\"constant\": false,\t\t\"inputs\": [{\t\t\t\"name\": \"n\",\t\t\t\"type\": \"string\"\t\t}],\t\t\"name\": \"set\",\t\t\"outputs\": [],\t\t\"payable\": false,\t\t\"stateMutability\": \"nonpayable\",\t\t\"type\": \"function\"\t}, {\t\t\"inputs\": [],\t\t\"payable\": false,\t\t\"stateMutability\": \"nonpayable\",\t\t\"type\": \"constructor\"\t}, {\t\t\"anonymous\": false,\t\t\"inputs\": [{\t\t\t\"indexed\": false,\t\t\t\"name\": \"\",\t\t\t\"type\": \"string\"\t\t}],\t\t\"name\": \"Test\",\t\t\"type\": \"event\"\t}],\"bytecodeBin\": \"608060405234801561001057600080fd5b506040805190810160405280600d81526020017f48656c6c6f2c20576f726c6421000000000000000000000000000000000000008152506000908051906020019061005c929190610062565b50610107565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106100a357805160ff19168380011785556100d1565b828001600101855582156100d1579182015b828111156100d05782518255916020019190600101906100b5565b5b5090506100de91906100e2565b5090565b61010491905b808211156101005760008160009055506001016100e8565b5090565b90565b610373806101166000396000f30060806040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063299f7f9d146100515780633590b49f146100e1575b600080fd5b34801561005d57600080fd5b5061006661014a565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100a657808201518184015260208101905061008b565b50505050905090810190601f1680156100d35780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156100ed57600080fd5b50610148600480360381019080803590602001908201803590602001908080601f01602080910402602001604051908101604052809392919081815260200183838082843782019150505050505091929192905050506101ec565b005b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156101e25780601f106101b7576101008083540402835291602001916101e2565b820191906000526020600020905b8154815290600101906020018083116101c557829003601f168201915b5050505050905090565b80600090805190602001906102029291906102a2565b507f89737d892c26516d1f01db9c083272cfafd004b0c31c32b9b39dbe07037fca24816040518080602001828103825283818151815260200191508051906020019080838360005b8381101561026557808201518184015260208101905061024a565b50505050905090810190601f1680156102925780820380516001836020036101000a031916815260200191505b509250505060405180910390a150565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106102e357805160ff1916838001178555610311565b82800160010185558215610311579182015b828111156103105782518255916020019190600101906102f5565b5b50905061031e9190610322565b5090565b61034491905b80821115610340576000816000905550600101610328565b5090565b905600a165627a7a723058202a7dede15aee7c8148afdeb9f48a479ded2e2b0588f8ec9953145fe7cb15b52b0029\", \"groupId\": "group", \"signUserId\": \"ed54e13b0abf4c69b788bd83b8e3515e\"}"
```

#### 响应参数

**1）数据格式**

返回合约地址：
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

| **序号** | **中文**        | **参数名**     | **类型** | **最大长度** | **必填** | **说明**                                                     |
| -------- | --------------- | -------------- | -------- | ------------ | -------- | ------------------------------------------------------------ |
| 1        | 所属群组        | groupId        | String   |              | 是       |                                                              |
| 2        | 用户地址        | user           | String   |              | 是       | 用户地址，可通过`/privateKey`接口创建                        |
| 3        | 合约名称        | contractName   | String   |              | 否       |                                                              |
| 4        | 合约abi         | abiInfo        | List     |              | 是       | 合约编译后生成的abi文件内容                                  |
| 5        | 合约bytecodeBin | bytecodeBin    | String   |              | 是       | 合约编译的bytecode(bin)，用于部署合约                        |
| 6        | 构造函数参数    | funcParam      | List     |              | 否       | 合约构造函数所需参数，JSON数组，多个参数以逗号分隔（参数为数组时同理），如：["str1",["arr1","arr2"]] |
| 7        | 合约bin         | contractBin    | String   |              | 是       | 合约编译的runtime-bytecode(runtime-bin)                      |
| 8        | 合约id          | contractId     | Long     |              | 是       |                                                              |
| 9        | 合约路径        | contractPath   | String   |              | 是       |                                                              |
| 10       | 合约来源        | contractSource | String   |              | 是       |                                                              |
| 11       | 用户编号        | signUserId     | String   |              | 是       | WeBASE-Sign中的用户编号，通过webase-sign创建私钥获取         |
| 12       | 是否aes         | useAes         | Boolean  |              | 是       | true表示使用aes，false表示不使用aes                          |
| 13       | 用户            | user           | String   |              | 是       |                                                              |

**2）数据格式**

```
{
  "abiInfo": [
    {}
  ],
  "bytecodeBin": "string",
  "contractBin": "string",
  "contractId": 0,
  "contractName": "string",
  "contractPath": "string",
  "contractSource": "string",
  "funcParam": [
    {}
  ],
  "groupId": "string",
  "signUserId": "string",
  "useAes": true,
  "user": "string",
  "version": "string"
}
```

示例：

```
curl -X POST "http://127.0.0.1:5002/WeBASE-Front/contract/deploy" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"abiInfo\": [{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"}], \"bytecodeBin\": \"608060405234801561001057600080fd5b506040805190810160405280600d81526020017f48656c6c6f2c20576f726c6421000000000000000000000000000000000000008152506000908051906020019061005c929190610062565b50610107565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106100a357805160ff19168380011785556100d1565b828001600101855582156100d1579182015b828111156100d05782518255916020019190600101906100b5565b5b5090506100de91906100e2565b5090565b61010491905b808211156101005760008160009055506001016100e8565b5090565b90565b6102d7806101166000396000f30060806040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063299f7f9d146100515780633590b49f146100e1575b600080fd5b34801561005d57600080fd5b5061006661014a565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100a657808201518184015260208101905061008b565b50505050905090810190601f1680156100d35780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156100ed57600080fd5b50610148600480360381019080803590602001908201803590602001908080601f01602080910402602001604051908101604052809392919081815260200183838082843782019150505050505091929192905050506101ec565b005b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156101e25780601f106101b7576101008083540402835291602001916101e2565b820191906000526020600020905b8154815290600101906020018083116101c557829003601f168201915b5050505050905090565b8060009080519060200190610202929190610206565b5050565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061024757805160ff1916838001178555610275565b82800160010185558215610275579182015b82811115610274578251825591602001919060010190610259565b5b5090506102829190610286565b5090565b6102a891905b808211156102a457600081600090555060010161028c565b5090565b905600a165627a7a72305820748030e2b07f36768ce36d28f7d8dac238065a349c87ffd036d6009b2dcc10950029\", \"funcParam\": [ ], \"groupId\": 1, \"user\": \"0xe11dda6939ef947f9ef78f626e5c4fe0cbcbce1e\"}"
```
#### 响应参数

**1）数据格式**

返回合约地址：
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
| 2        | 合约abi      | abiInfo      | List |              | 是       | 合约编译后生成的abi文件内容 |
| 3        | 合约bin      | contractBin  | String         |              | 是       |  合约编译的runtime-bytecode(runtime-bin)       |
| 4        | 所在目录      | packageName  | String         |              | 是       | 生成java所在的包名 |
| 5 | 地址 | address | String | | 是 |  |
| 6 | 所属群组 | groupId | String | | 是 |  |

**2）数据格式**

```
{
  "abiInfo": [
    {
      "anonymous": true,
      "constant": true,
      "inputs": [
        {
          "components": [
            null
          ],
          "dynamic": true,
          "indexed": true,
          "internalType": "string",
          "name": "string",
          "type": "string",
          "typeAsString": "string"
        }
      ],
      "methodSignatureAsString": "string",
      "name": "string",
      "outputs": [
        {
          "components": [
            null
          ],
          "dynamic": true,
          "indexed": true,
          "internalType": "string",
          "name": "string",
          "type": "string",
          "typeAsString": "string"
        }
      ],
      "payable": true,
      "stateMutability": "string",
      "type": "string"
    }
  ],
  "address": "string",
  "contractBin": "string",
  "contractName": "string",
  "groupId": "string",
  "packageName": "string"
}
```

#### 响应参数

**1）数据格式**
返回Java合约类源码

```Java
package com.webank;

import java.util.Arrays;
...

@SuppressWarnings("unchecked")
public class HelloWorld extends Contract {
    public static final String[] BINARY_ARRAY = {""};

    public static final String BINARY = org.fisco.bcos.sdk.utils.StringUtils.joinAll("", BINARY_ARRAY);

    public static final String[] SM_BINARY_ARRAY = {""};

    public static final String SM_BINARY = org.fisco.bcos.sdk.utils.StringUtils.joinAll("", SM_BINARY_ARRAY);

    public static final String[] ABI_ARRAY = {"[{\"name\":\"get\",\"type\":\"function\",\"constant\":true,\"payable\":false,\"anonymous\":false,\"stateMutability\":\"view\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"string\",\"indexed\":false,\"components\":null,\"typeAsString\":\"string\"}],\"methodSignatureAsString\":\"get()\"},{\"name\":\"set\",\"type\":\"function\",\"constant\":false,\"payable\":false,\"anonymous\":false,\"stateMutability\":\"nonpayable\",\"inputs\":[{\"name\":\"n\",\"type\":\"string\",\"indexed\":false,\"components\":null,\"typeAsString\":\"string\"}],\"outputs\":[],\"methodSignatureAsString\":\"set(string)\"},{\"name\":null,\"type\":\"constructor\",\"constant\":false,\"payable\":false,\"anonymous\":false,\"stateMutability\":\"nonpayable\",\"inputs\":[],\"outputs\":null,\"methodSignatureAsString\":\"null()\"}]"};

    public static final String ABI = org.fisco.bcos.sdk.utils.StringUtils.joinAll("", ABI_ARRAY);

    public static final String FUNC_GET = "get";

    public static final String FUNC_SET = "set";

    protected HelloWorld(String contractAddress, Client client, CryptoKeyPair credential) {
        super(getBinary(client.getCryptoSuite()), contractAddress, client, credential);
    }

    public static String getBinary(CryptoSuite cryptoSuite) {
        return (cryptoSuite.getCryptoTypeConfig() == CryptoType.ECDSA_TYPE ? BINARY : SM_BINARY);
    }

    public String get() throws ContractException {
        final Function function = new Function(FUNC_GET, 
                Arrays.<Type>asList(), 
                Arrays.<TypeReference<?>>asList(new TypeReference<Utf8String>() {}));
        return executeCallWithSingleValueReturn(function, String.class);
    }

    public TransactionReceipt set(String n) {
        final Function function = new Function(
                FUNC_SET, 
                Arrays.<Type>asList(new org.fisco.bcos.sdk.abi.datatypes.Utf8String(n)), 
                Collections.<TypeReference<?>>emptyList());
        return executeTransaction(function);
    }

    public void set(String n, TransactionCallback callback) {
        final Function function = new Function(
                FUNC_SET, 
                Arrays.<Type>asList(new org.fisco.bcos.sdk.abi.datatypes.Utf8String(n)), 
                Collections.<TypeReference<?>>emptyList());
        asyncExecuteTransaction(function, callback);
    }

    public String getSignedTransactionForSet(String n) {
        final Function function = new Function(
                FUNC_SET, 
                Arrays.<Type>asList(new org.fisco.bcos.sdk.abi.datatypes.Utf8String(n)), 
                Collections.<TypeReference<?>>emptyList());
        return createSignedTransaction(function);
    }

    public Tuple1<String> getSetInput(TransactionReceipt transactionReceipt) {
        String data = transactionReceipt.getInput().substring(10);
        final Function function = new Function(FUNC_SET, 
                Arrays.<Type>asList(), 
                Arrays.<TypeReference<?>>asList(new TypeReference<Utf8String>() {}));
        List<Type> results = FunctionReturnDecoder.decode(data, function.getOutputParameters());
        return new Tuple1<String>(

                (String) results.get(0).getValue()
                );
    }

    public static HelloWorld load(String contractAddress, Client client, CryptoKeyPair credential) {
        return new HelloWorld(contractAddress, client, credential);
    }

    public static HelloWorld deploy(Client client, CryptoKeyPair credential) throws ContractException {
        return deploy(HelloWorld.class, client, credential, getBinary(client.getCryptoSuite()), "");
    }
}
```



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
| 1        | 所属群组     | groupId       | string      |            | 是       |          |
| 2        | 合约编号     | contractId    | Long       |            | 否       |  |
| 3        | 合约名称     | contractName | String         |              | 是       |          |
| 4        | 合约所在目录  | contractPath | String         |              | 是       |          |
| 5        | 合约abi      | contractAbi      | String |              | 否       |  可保存合约ABI        |
| 6        | 合约bytecodeBin      | bytecodeBin  | String         |              | 否       |  合约编译的bytecode(bin)，用于部署合约        |
| 7        | 合约bin | contractBin    | String|              | 否       |   合约编译的runtime-bytecode(runtime-bin)，用于交易解析       |
| 8        | 合约源码 | contractSource    | String|              | 否       |          |
| 9 | 合约地址 | contractAddress | String | | 否 | |
| 10 | 合约版本 | version | String | | 否 | |

**2）数据格式**

```
{
  "bytecodeBin": "string",
  "contractAbi": "string",
  "contractAddress": "string",
  "contractBin": "string",
  "contractId": 0,
  "contractName": "string",
  "contractPath": "string",
  "contractSource": "string",
  "groupId": "string",
  "version": "string"
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
| 5        | 所属群组 | groupId | String    |              | 是        |                      |
| 6        | 合约源码 | contractSource | String         |      | 否       |           |
| 7        | 合约abi | contractAbi | String         |      | 否       |   合约编译后生成的abi文件内容 |
| 8        | 合约bin | contractBin | String         |      | 否       |  合约编译的runtime-bytecode(runtime-bin)，用于交易解析         |
| 9        | 合约bytecodeBin | bytecodeBin | String         |      | 否       |  合约编译的bytecode(bin)，用于部署合约        |
| 10        | 合约地址 | contractAddress | String         |      | 否       |           |
| 11        | 部署时间 | deployTime | String         |      | 否       |           |
| 12        | 修改时间 | modifyTime | String         |      | 是       |           |
| 13        | 创建时间 | createTime | String         |      | 是       |           |
| 14        | 备注 | description | String         |      | 否       |           |
| 15 | 合约版本 | version | String | | 否 | |

**2）数据格式**

```
{
    "id": 1,
    "contractPath": "/",
    "contractName": "HelloWorld",
    "contractStatus": 1,
    "groupId": 1,
    "contractSource": "cHJhZ21hIHNvbGlkaXR5ID49MC40LjI0IDwwLjYuMTE7Cgpjb250cmFjdCBIZWxsb1dvcmxkIHsKICAgIHN0cmluZyBuYW1lOwoKICAgIGNvbnN0cnVjdG9yKCkgcHVibGljIHsKICAgICAgICBuYW1lID0gIkhlbGxvLCBXb3JsZCEiOwogICAgfQoKICAgIGZ1bmN0aW9uIGdldCgpIHB1YmxpYyB2aWV3IHJldHVybnMgKHN0cmluZyBtZW1vcnkpIHsKICAgICAgICByZXR1cm4gbmFtZTsKICAgIH0KCiAgICBmdW5jdGlvbiBzZXQoc3RyaW5nIG1lbW9yeSBuKSBwdWJsaWMgewogICAgICAgIG5hbWUgPSBuOwogICAgfQp9",
    "contractAbi": "[{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"}]",
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
http://localhost:5002/WeBASE-Front/contract/group/1
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
| 1        | 所属群组 | groupId | String    |              | 是        |                      |
| 2        | 合约名称 | contractName | String         |              | 否        |   |
| 3        | 合约状态 | contractStatus | Integer         |       | 否       |1未部署，2已部署  |
| 4        | 合约地址 | contractAddress | String         |      | 否       |           |
| 5        | 当前页码 | pageNumber | Integer         |       | 是       | 从1开始 |
| 6        | 每页记录数 | pageSize | Integer         |       | 是       |  |
| 7        | 合约路径 | contractPath | String         |      | 否       |           |


**2）数据格式**
```
{
  "contractAddress": "string",
  "contractName": "string",
  "contractPath": "string",
  "contractStatus": 0,
  "groupId": "string",
  "pageNumber": 0,
  "pageSize": 0
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
| 1        | 所属群组 | groupId    | String   |              | 是       |          |
| 2        | 合约编号 | contractId | int      |              | 是       |          |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/contract/ifChanged/group/10
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
| 3 | 群组编号 | groupId | String | |  |  |

**2）数据格式**
```
{
  "contractName": "string",
  "groupId": "string",
  "solidityBase64": "string"
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
  "contractName": "HelloWorld",
  "contractAbi": "[{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"}]",
  "bytecodeBin": "608060405234801561001057600080fd5b506040805190810160405280600d81526020017f48656c6c6f2c20576f726c6421000000000000000000000000000000000000008152506000908051906020019061005c929190610062565b50610107565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106100a357805160ff19168380011785556100d1565b828001600101855582156100d1579182015b828111156100d05782518255916020019190600101906100b5565b5b5090506100de91906100e2565b5090565b61010491905b808211156101005760008160009055506001016100e8565b5090565b90565b6102d7806101166000396000f30060806040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063299f7f9d146100515780633590b49f146100e1575b600080fd5b34801561005d57600080fd5b5061006661014a565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100a657808201518184015260208101905061008b565b50505050905090810190601f1680156100d35780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156100ed57600080fd5b50610148600480360381019080803590602001908201803590602001908080601f01602080910402602001604051908101604052809392919081815260200183838082843782019150505050505091929192905050506101ec565b005b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156101e25780601f106101b7576101008083540402835291602001916101e2565b820191906000526020600020905b8154815290600101906020018083116101c557829003601f168201915b5050505050905090565b8060009080519060200190610202929190610206565b5050565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061024757805160ff1916838001178555610275565b82800160010185558215610275579182015b82811115610274578251825591602001919060010190610259565b5b5090506102829190610286565b5090565b6102a891905b808211156102a457600081600090555060010161028c565b5090565b905600a165627a7a72305820c4fdd0260810422a091a99fbd64edc672c6e498b69b9947f3e3066c074522dfa0029",
  "errors": ""
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
| 2        | 所属群组 | groupId           | String   |              | 是       |                                 |

**2）数据格式**

```
{
  "contractZipBase64": "string",
  "groupId": "string"
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
| 1        | 所属群组 | groupId | String    |              | 是        |                      |
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
            "groupId": "group",
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
| 3.5        | 所属群组 | groupId | String             | 是        |                      |
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
            "groupId": "group",
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
| 1        | 所属群组 | groupId | String    |              | 是        |                      |

**2）数据格式** 

```
http://localhost:5002/WeBASE-Front/contract/findPathList/group
```

#### 响应参数
**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **必填** | **说明**              |
| -------- | -------- | ---------- | -------- | -------- | --------------------- |
| 1       | 返回数据 | data       | List   |  否        |                       |
| 1.1        | 群组编号 | groupId            | String                 | 是        |           |
| 1.2        | 所在目录  | contractPath | String             | 是       | |
| 1.3        | 修改时间 | modifyTime | String            | 是       |           |
| 1.4        | 创建时间 | createTime | String             | 是       |           |


**2）数据格式**
```
[
  {
    "groupId": "group",
    "contractPath": "/",
    "createTime": null,
    "modifyTime": "2021-07-29 14:34:52"
  },
  {
    "groupId": "group",
    "contractPath": "Asset",
    "createTime": null,
    "modifyTime": "2021-07-27 10:43:59"
  },
  {
     "groupId": "group",
    "contractPath": "template",
    "createTime": "2021-07-20 11:31:18",
    "modifyTime": "2021-07-20 11:31:18"
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
| 1        | 所属群组 | groupId | String    |              | 是        |                      |
| 1        | 合约路径 | contractPath | String         |              | 是        |   若为空字符串，则保存`/`根目录路径                   |

**2）数据格式** 

```
http://localhost:5002/WeBASE-Front/contract/addContractPath
```

```
{
  "contractPath": "string",
  "groupId": "string"
}
```


#### 响应参数
**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **必填** | **说明**              |
| -------- | -------- | ---------- | -------- | -------- | --------------------- |
| 1        | 群组编号 | groupId            | String                 | 是        |           |
| 2        | 所在目录  | contractPath | String             | 是       | |
| 3        | 修改时间 | modifyTime | String            | 是       |           |
| 4        | 创建时间 | createTime | String             | 是       |           |


**2）数据格式**
```
{
  "groupId": "group",
  "contractPath": "test",
  "createTime": "2021-07-29 14:26:54",
  "modifyTime": "2021-07-29 14:26:54"
}
```


### 1.15. 删除合约路径

#### 接口描述

> 删除合约路径（不删除目录下合约）

#### 接口URL

**http://localhost:5002/WeBASE-Front/contract/deletePath/{groupId}/{contractPath}**

#### 调用方法

HTTP DELETE

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**   | **类型**       | **最大长度** | **必填** | **说明** |
| -------- | ------------ | ------------ | -------------- | ------------ | -------- | -------- |
| 1        | 所属群组 | groupId | String    |              | 是        |                      |
| 2       | 合约路径 | contractPath | String         |              | 是        |                      |

**2）数据格式** 

```
http://localhost:5002/WeBASE-Front/contract/deletePath/group/test
```

#### 响应参数
**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **必填** | **说明**              |
| -------- | -------- | ---------- | -------- | -------- | --------------------- |
| 1        | 返回码   | code       | String   | 是       | 返回码信息请参看附录1 |
| 2        | 提示信息 | message    | String   | 是       |                       |
| 3        | 返回数据 | data       |          |          |                       |


**2）数据格式**
```
{
    "code": 0,
    "data": {},
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
| 1        | 所属群组 | groupId | String   |              | 是        |                      |
| 1        | 合约路径 | contractPath | String         |              | 是        |                      |

**2）数据格式** 

```
http://localhost:5002/WeBASE-Front/contract/batch/group/test
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
    "data": {},
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
| 1        | 所属群组     | groupId         | String   |              | 是       |                                         |
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
  "abiInfo": [
    {
      "anonymous": true,
      "constant": true,
      "inputs": [
        {
          "components": [
            null
          ],
          "dynamic": true,
          "indexed": true,
          "internalType": "string",
          "name": "string",
          "type": "string",
          "typeAsString": "string"
        }
      ],
      "methodSignatureAsString": "string",
      "name": "string",
      "outputs": [
        {
          "components": [
            null
          ],
          "dynamic": true,
          "indexed": true,
          "internalType": "string",
          "name": "string",
          "type": "string",
          "typeAsString": "string"
        }
      ],
      "payable": true,
      "stateMutability": "string",
      "type": "string"
    }
  ],
  "cnsName": "string",
  "contractAddress": "string",
  "contractName": "string",
  "contractPath": "string",
  "groupId": "string",
  "saveEnabled": true,
  "signUserId": "string",
  "userAddress": "string",
  "version": "string"
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
| 1        | 所属群组 | groupId         | String   |              | 是       |          |
| 2        | 合约地址 | contractAddress | String   |              | 是       |          |

**2）数据格式** 

```
http://localhost:5002/WeBASE-Front/contract/findCns
```

```
{
  "groupId": "group",
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
    "groupId": "group",
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

### 2.1. 创建私钥接口

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
| 1 | 私钥类型 | type | int | | 否 | 0-本地用户；1-本地随机；2-外部用户；默认为2 |
| 2        | 用户名 | userName | String        |             | 是  | 用户名 |
| 3        | 签名服务用户编号 | signUserId | String        |    64         | 否   | WeBASE-Sign中的用户编号，一般设为UUID值；类型为2-外部用户时，必填；|
| 4        | 应用编号 | appId | String        |     64        | 否   | 记录私钥所属应用，可根据业务设置；类型为2-外部用户时，必填 |
| 5        | 是否返回私钥 | returnPrivateKey | Boolean        |             | 否   | 类型为2-外部用户时，选填；默认为false |
| 6 | 群组编号 | groupId | String | |  |  |

**2）数据格式** 

```
// 本地用户
http://localhost:5002/WeBASE-Front/privateKey?type=0&userName=test
// 外部用户
http://localhost:5002/WeBASE-Front/privateKey?type=2&signUserId=0x123&appId=2

```

#### 响应参数

**1）数据格式**
本地用户时：
```
{
  "groupId": "group",
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
  "groupId": "group",
  "address": "0xef5afe7d9a7516cd36b5b2471a3fbb05d3e8a846",
  "publicKey": "0461e78631ab8428c1be815a4543da8684db13cd2d9a0593e053184dbd29d08f38131e060bc8d1a1ef5f4290b26acca8cefbc16150155e57f4ea81dbed57cea0e8",
  "privateKey": null, // 默认不返回
  "userName": null, //外部用户则为空
  "type": 2,
  "signUserId": "0x123",
  "appId": "1"
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
| 3        | 群组编号 | groupId    | String   |              |          |          |

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
  "type": 0,
  "appId": "string",
  "signUserId": "string"
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
    "address": "string",
    "appId": "string",
    "privateKey": "string",
    "publicKey": "string",
    "signUserId": "string",
    "type": 0,
    "userName": "string"
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
| 3 | 群组编号 | groupId | String | | 是 | |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/privateKey/importPem
```

```
{
  "groupId": "string",
  "pemContent": "string",
  "userName": "string"
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
| 3       | 用户名 | userName    | String   |              | 是     |          |
| 4 | 群组编号 | groupId | String | | 是 | |

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

HTTP POST | Content-type: application/json

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 用户编号 | signUserId    | String   |   64           | 是       |   WeBASE-Sign中的用户编号，一般设为UUID值       |
| 2        | 应用编号 | appId    | String   |     64         | 是       |  记录私钥所属应用，可根据业务设置         |
| 3        | 私钥 | privateKey    | String   |              | 是       |  经过Base64加密后的内容        |
| 4 | 群组编号 | groupId | String | | 是 |  |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/privateKey/importWithSign
```

```
{
  "appId": "string",
  "groupId": "string",
  "privateKey": "string",
  "signUserId": "string"
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

HTTP POST | Content-type: application/json

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明**                              |
| -------- | -------- | ---------- | -------- | ------------ | -------- | ------------------------------------- |
| 1        | Sign用户Id | signUserId       | String   |      64        | 是       | 在webase-sign创建的私钥的id |
| 2        | Hash值   | messageHash       | String   |              | 是       |                                       |
| 3 | 群组编号 | groupId | String | | 是 | |

**2）数据格式**

```
{
  "groupId": "string",
  "messageHash": "string",
  "signUserId": "string"
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
| 1        | Sign用户编号 | signUserId    | String   |     64         | 否      |  非空时，导出sign的私钥        |
| 2        | 用户地址 | userAddress    | String   |              | 否     |    若signUserId为空，则地址不能为空，导出本地私钥       |
| 3 | 群组编号 | groupId | String | | 是 |  |
| 4 | p12文件密码 | p12Password | String | | 是 |  |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/privateKey/exportPem
```

```
{
  "groupId": "string",
  "p12Password": "string",
  "signUserId": "string",
  "userAddress": "string"
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
| 1        | Sign用户编号 | signUserId    | String   |     64         | 否      |  非空时，导出sign的私钥        |
| 2        | 用户地址 | userAddress    | String   |              | 否     |    若signUserId为空，则地址不能为空，导出本地私钥       |
| 3 | 群组编号 | groupId | String | | 是 |  |
| 4 | p12文件密码 | p12Password | String | | 是 |  |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/privateKey/exportP12
```

```
{
  "groupId": "string",
  "p12Password": "string",
  "signUserId": "string",
  "userAddress": "string"
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


### 2.11. 获取WeBASE-Sign私钥用户信息

#### 接口描述

从WeBASE-Sign获取私钥信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/privateKey/userInfoWithSign**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | Sign用户编号 | signUserId    | String   |     64         | 是      |  WeBASE-Sign中用户编号        |
| 2        | 是否导出秘钥 | returnPrivateKey    | Boolean   |              | 否     |    默认为false；true时将导出WeBASE-Sign对应私钥       |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/privateKey/userInfoWithSign?signUserId=d1edf538748b4d899f251b5d746ec62f&returnPrivateKey=false
```


#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **必填** | **说明**              |
| -------- | -------- | ---------- | -------- | -------- | --------------------- |
| 1        | 用户编号 | signUserId    | String   |         |   WeBASE-Sign中的用户编号，一般为UUID值       |
| 2        | 应用编号 | appId    | String   |            |  记录私钥所属应用         |
| 3        | 私钥原文 | privateKey    | String   |                |  若`returnPrivateKey`则不返回（要求WeBASE-Sign设置允许导出私钥配置）      |
| 4       | 私钥地址 | address    | String   |                |          |
| 5       | 公钥 | publicKey    | String   |                |          |
| 6       | 私钥类型 | encryptType    | int   |                |  0-ECDSA, 1-SM2国密        |
| 7       | 描述 | description    | String   |                |          |

**2）数据格式**


```
{
  "signUserId": "d1edf538748b4d899f251b5d746ec62f",
  "appId": "1",
  "address": "0x2b6e2f9d25bdeeca395bd743099ef50097043aaa",
  "publicKey": "044ddb8e92cf9dd96c1767b5e9c7e55e749304e88e28a8ec4fb7059c3388590ce83f2786510898464dfeb79771656a506e91cca6bd88c4291d5b9e284542651546",
  "privateKey": "",
  "description": null,
  "encryptType": 1
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
| 1        | 群组编号 | groupId | String |             | 是        |                      |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/group/web3/blockNumber
```

#### 响应参数
**1）数据格式**
```
232
```


### 3.2. 根据块高获取块信息接口 


#### 接口描述

> 通过块高获取块信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/group/web3/blockByNumber/{blockNumber}**

#### 调用方法

HTTP GET

#### 请求参数

1. **参数表**

| **序号** | **中文** | **参数名**  | **类型**   | **最大长度** | **必填** | **说明** |
| -------- | -------- | ----------- | ---------- | ------------ | -------- | -------- |
| 1        | 群组编号 | groupId     | String     |              | 是       |          |
| 2        | 块高     | blockNumber | BigInteger |              | 是       |          |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/group/web3/blockByNumber/2
```

#### 响应参数

**1）数据格式**
```
{
  "number": 2,
  "hash": "0xf58f4f43b3761f4863ad366c4a7e2a812ed68df9f7bcad6b502fd544665e7625",
  "parentHash": "0x489ee0c00527879f7e2470bde7b62e9ea30fadb242bcbd9ba582d0dee4958e2f",
  "logsBloom": "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
  "transactionsRoot": "0xade02313d3200f38dfc18cdc368241cf4c1cb7e72011edf847ec216efa43a99e",
  "receiptsRoot": "0xb7c4b856c9335bd345c0b022057567a2223218e7a7dab822981467b29ac1e326",
  "dbHash": "0x8cbc3f2c0e35a71738909e3b388efa6697084b05badd3a3bd3c64f0575c78c15",
  "stateRoot": "0x8cbc3f2c0e35a71738909e3b388efa6697084b05badd3a3bd3c64f0575c78c15",
  "sealer": "0x2",
  "sealerList": [
    "06269e130f8220ebaa78e67832df0de6b4c5ee3f1b14e64ab2bae26510a4bcf997454b35067c1685d4343e6ad84b45c3b8690a858f2831a9247a97a27166ce1f",
    "65bc44d398d99d95a9d404aa16e4bfbc2f9ebb40f20439ddef8575a139dc3a80310cfc98a035bd59a67cc5f659f519e3e99b855f3d27f21a889c23a14036d0c7",
    "95efafa5197796e7edf647191de83f4259d7cbb060f4bac5868be474037f49144d581c15d8aef9b07d78f18041a5f43c3c26352ebbf5583cd23070358c8fba39",
    "fe57d7b39ed104b4fb2770ae5aad7946bfd377d0eb91ab92a383447e834c3257dec56686551d08178f2d5f40d9fad615293e46c9f5fc23cf187258e121213b1d"
  ],
  "extraData": [],
  "gasLimit": "0",
  "gasUsed": "0",
  "timestamp": "1619424150450",
  "signatureList": [
    {
      "index": "0x1",
      "signature": "0xa05b5d220e41051fa80f212884d9cdda3a8973a4ac2d2dc74e42db32b459e5f595a61e30266f0e8bf7edb065ff107c6af5e6349f9ae518146dc686406ebbade165bc44d398d99d95a9d404aa16e4bfbc2f9ebb40f20439ddef8575a139dc3a80310cfc98a035bd59a67cc5f659f519e3e99b855f3d27f21a889c23a14036d0c7"
    },
    {
      "index": "0x3",
      "signature": "0x48bb622e24b18f4eb601137d44b5d86e2c287be3aa849dce1768e87e75308ba69391e62f90d76bf84b9b6eb1509d11409f9b784bc7b052458a4596b81961fac8fe57d7b39ed104b4fb2770ae5aad7946bfd377d0eb91ab92a383447e834c3257dec56686551d08178f2d5f40d9fad615293e46c9f5fc23cf187258e121213b1d"
    },
    {
      "index": "0x2",
      "signature": "0x3a3cc8c20c5cdbb6431ec1f749d94662670e87442debef119a4e6469ccb16a60a152d32754ab833efa513839b076c2aa1ceb7e536db3734b740e9192b10ee38695efafa5197796e7edf647191de83f4259d7cbb060f4bac5868be474037f49144d581c15d8aef9b07d78f18041a5f43c3c26352ebbf5583cd23070358c8fba39"
    }
  ],
  "transactions": [
    {
      "blockHash": "0xf58f4f43b3761f4863ad366c4a7e2a812ed68df9f7bcad6b502fd544665e7625",
      "blockNumber": 2,
      "from": "0x9d75e0ee66cfef16897b601624b60413d988ae7d",
      "gas": "0x419ce0",
      "hash": "0x69ced0162a0c3892e4eaa3091b831ac3aaeb772c062746b20891ceaf8a4fb429",
      "input": "0x608060405234801561001057600080fd5b506103e3806100206000396000f300608060405260043610610057576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063299f7f9d1461005c5780633590b49f146100ec57806362e8d6ce14610155575b600080fd5b34801561006857600080fd5b5061007161016c565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100b1578082015181840152602081019050610096565b50505050905090810190601f1680156100de5780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156100f857600080fd5b50610153600480360381019080803590602001908201803590602001908080601f016020809104026020016040519081016040528093929190818152602001838380828437820191505050505050919291929050505061020e565b005b34801561016157600080fd5b5061016a6102c4565b005b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156102045780601f106101d957610100808354040283529160200191610204565b820191906000526020600020905b8154815290600101906020018083116101e757829003601f168201915b5050505050905090565b7f5715c9562eaf8d524d564edb392acddefc81d8133e2fc3b8125a260b1b413fda816040518080602001828103825283818151815260200191508051906020019080838360005b83811015610270578082015181840152602081019050610255565b50505050905090810190601f16801561029d5780820380516001836020036101000a031916815260200191505b509250505060405180910390a180600090805190602001906102c0929190610312565b5050565b6040805190810160405280600d81526020017f48656c6c6f2c20576f726c6421000000000000000000000000000000000000008152506000908051906020019061030f929190610312565b50565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061035357805160ff1916838001178555610381565b82800160010185558215610381579182015b82811115610380578251825591602001919060010190610365565b5b50905061038e9190610392565b5090565b6103b491905b808211156103b0576000816000905550600101610398565b5090565b905600a165627a7a72305820f3088deb3d14c6893440e4769f2389e9335e04faa10e6de5b4c93af15d1a34e80029",
      "nonce": "0x3460c30bd3e4e88a31d6d033b3a172859bf003258e9606fd63fb0d91f91f4e6",
      "to": "0x0000000000000000000000000000000000000000",
      "transactionIndex": "0x0",
      "value": "0x0",
      "gasPrice": "0x51f4d5c00",
      "blockLimit": "0x1f5",
      "chainId": "0x1",
      "groupId": "0x1",
      "extraData": "0x",
      "signature": {
        "r": "0x3416723318505669cca91689b213ff08ffb96d538210a0f691cfcfa9d529462b",
        "s": "0xd3642f19c228e2e86689de9efc19ecbb68378a6bb7c219984431e93d60c89124",
        "v": "0xc7935c199b680452eb37911856282b9c820322fd5fdec8a06b48cc3df4e8ed7d3d66a5adcc134cca609146ec0aed12827c35df07eed96042763c0926cf4223b7",
        "signature": "0x3416723318505669cca91689b213ff08ffb96d538210a0f691cfcfa9d529462bd3642f19c228e2e86689de9efc19ecbb68378a6bb7c219984431e93d60c89124c7935c199b680452eb37911856282b9c820322fd5fdec8a06b48cc3df4e8ed7d3d66a5adcc134cca609146ec0aed12827c35df07eed96042763c0926cf4223b7"
      }
    }
  ]
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
| 1        | 群组编号 | groupId | String |             | 是        |                      |
| 2        | 区块hash     | blockByHash | String |       | 是       |          |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/group/web3/blockByHash/0xf58f4f43b3761f4863ad366c4a7e2a812ed68df9f7bcad6b502fd544665e7625
```

#### 响应参数

**1）数据格式**
```
{{
  "number": 2,
  "hash": "0xf58f4f43b3761f4863ad366c4a7e2a812ed68df9f7bcad6b502fd544665e7625",
  "parentHash": "0x489ee0c00527879f7e2470bde7b62e9ea30fadb242bcbd9ba582d0dee4958e2f",
  "logsBloom": "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
  "transactionsRoot": "0xade02313d3200f38dfc18cdc368241cf4c1cb7e72011edf847ec216efa43a99e",
  "receiptsRoot": "0xb7c4b856c9335bd345c0b022057567a2223218e7a7dab822981467b29ac1e326",
  "dbHash": "0x8cbc3f2c0e35a71738909e3b388efa6697084b05badd3a3bd3c64f0575c78c15",
  "stateRoot": "0x8cbc3f2c0e35a71738909e3b388efa6697084b05badd3a3bd3c64f0575c78c15",
  "sealer": "0x2",
  "sealerList": [
    "06269e130f8220ebaa78e67832df0de6b4c5ee3f1b14e64ab2bae26510a4bcf997454b35067c1685d4343e6ad84b45c3b8690a858f2831a9247a97a27166ce1f",
    "65bc44d398d99d95a9d404aa16e4bfbc2f9ebb40f20439ddef8575a139dc3a80310cfc98a035bd59a67cc5f659f519e3e99b855f3d27f21a889c23a14036d0c7",
    "95efafa5197796e7edf647191de83f4259d7cbb060f4bac5868be474037f49144d581c15d8aef9b07d78f18041a5f43c3c26352ebbf5583cd23070358c8fba39",
    "fe57d7b39ed104b4fb2770ae5aad7946bfd377d0eb91ab92a383447e834c3257dec56686551d08178f2d5f40d9fad615293e46c9f5fc23cf187258e121213b1d"
  ],
  "extraData": [],
  "gasLimit": "0",
  "gasUsed": "0",
  "timestamp": "1619424150450",
  "signatureList": [
    {
      "index": "0x1",
      "signature": "0xa05b5d220e41051fa80f212884d9cdda3a8973a4ac2d2dc74e42db32b459e5f595a61e30266f0e8bf7edb065ff107c6af5e6349f9ae518146dc686406ebbade165bc44d398d99d95a9d404aa16e4bfbc2f9ebb40f20439ddef8575a139dc3a80310cfc98a035bd59a67cc5f659f519e3e99b855f3d27f21a889c23a14036d0c7"
    },
    {
      "index": "0x3",
      "signature": "0x48bb622e24b18f4eb601137d44b5d86e2c287be3aa849dce1768e87e75308ba69391e62f90d76bf84b9b6eb1509d11409f9b784bc7b052458a4596b81961fac8fe57d7b39ed104b4fb2770ae5aad7946bfd377d0eb91ab92a383447e834c3257dec56686551d08178f2d5f40d9fad615293e46c9f5fc23cf187258e121213b1d"
    },
    {
      "index": "0x2",
      "signature": "0x3a3cc8c20c5cdbb6431ec1f749d94662670e87442debef119a4e6469ccb16a60a152d32754ab833efa513839b076c2aa1ceb7e536db3734b740e9192b10ee38695efafa5197796e7edf647191de83f4259d7cbb060f4bac5868be474037f49144d581c15d8aef9b07d78f18041a5f43c3c26352ebbf5583cd23070358c8fba39"
    }
  ],
  "transactions": [
    {
      "blockHash": "0xf58f4f43b3761f4863ad366c4a7e2a812ed68df9f7bcad6b502fd544665e7625",
      "blockNumber": 2,
      "from": "0x9d75e0ee66cfef16897b601624b60413d988ae7d",
      "gas": "0x419ce0",
      "hash": "0x69ced0162a0c3892e4eaa3091b831ac3aaeb772c062746b20891ceaf8a4fb429",
      "input": "0x608060405234801561001057600080fd5b506103e3806100206000396000f300608060405260043610610057576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063299f7f9d1461005c5780633590b49f146100ec57806362e8d6ce14610155575b600080fd5b34801561006857600080fd5b5061007161016c565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100b1578082015181840152602081019050610096565b50505050905090810190601f1680156100de5780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156100f857600080fd5b50610153600480360381019080803590602001908201803590602001908080601f016020809104026020016040519081016040528093929190818152602001838380828437820191505050505050919291929050505061020e565b005b34801561016157600080fd5b5061016a6102c4565b005b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156102045780601f106101d957610100808354040283529160200191610204565b820191906000526020600020905b8154815290600101906020018083116101e757829003601f168201915b5050505050905090565b7f5715c9562eaf8d524d564edb392acddefc81d8133e2fc3b8125a260b1b413fda816040518080602001828103825283818151815260200191508051906020019080838360005b83811015610270578082015181840152602081019050610255565b50505050905090810190601f16801561029d5780820380516001836020036101000a031916815260200191505b509250505060405180910390a180600090805190602001906102c0929190610312565b5050565b6040805190810160405280600d81526020017f48656c6c6f2c20576f726c6421000000000000000000000000000000000000008152506000908051906020019061030f929190610312565b50565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061035357805160ff1916838001178555610381565b82800160010185558215610381579182015b82811115610380578251825591602001919060010190610365565b5b50905061038e9190610392565b5090565b6103b491905b808211156103b0576000816000905550600101610398565b5090565b905600a165627a7a72305820f3088deb3d14c6893440e4769f2389e9335e04faa10e6de5b4c93af15d1a34e80029",
      "nonce": "0x3460c30bd3e4e88a31d6d033b3a172859bf003258e9606fd63fb0d91f91f4e6",
      "to": "0x0000000000000000000000000000000000000000",
      "transactionIndex": "0x0",
      "value": "0x0",
      "gasPrice": "0x51f4d5c00",
      "blockLimit": "0x1f5",
      "chainId": "0x1",
      "groupId": "0x1",
      "extraData": "0x",
      "signature": {
        "r": "0x3416723318505669cca91689b213ff08ffb96d538210a0f691cfcfa9d529462b",
        "s": "0xd3642f19c228e2e86689de9efc19ecbb68378a6bb7c219984431e93d60c89124",
        "v": "0xc7935c199b680452eb37911856282b9c820322fd5fdec8a06b48cc3df4e8ed7d3d66a5adcc134cca609146ec0aed12827c35df07eed96042763c0926cf4223b7",
        "signature": "0x3416723318505669cca91689b213ff08ffb96d538210a0f691cfcfa9d529462bd3642f19c228e2e86689de9efc19ecbb68378a6bb7c219984431e93d60c89124c7935c199b680452eb37911856282b9c820322fd5fdec8a06b48cc3df4e8ed7d3d66a5adcc134cca609146ec0aed12827c35df07eed96042763c0926cf4223b7"
      }
    }
  ]
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
| 1 | 群组编号 | groupId | String | | 是 | |
| 2 | 块高 | blockNumber | BigInteger | | 是 | |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/group/web3/blockTransCnt/100
```

#### 响应参数

**1）数据格式**
```
2
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
| 1        | 群组编号 | groupId       | String |             | 是        |                |


**2）数据格式**

```
http://localhost:5002/WeBASE-Front/group/web3/pbftView
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
| 1        | 群组编号 | groupId | String |             | 是        |                      |
| 2        | 交易hash | transHash  | String   |              | 是       |          |


**2）数据格式**

```
http://localhost:5002/WeBASE-Front/group/web3/transactionReceipt/0x69ced0162a0c3892e4eaa3091b831ac3aaeb772c062746b20891ceaf8a4fb429
```

#### 响应参数

**2）数据格式**

```
{
  "transactionHash": "0x69ced0162a0c3892e4eaa3091b831ac3aaeb772c062746b20891ceaf8a4fb429",
  "transactionIndex": "0x0",
  "root": "0x8cbc3f2c0e35a71738909e3b388efa6697084b05badd3a3bd3c64f0575c78c15",
  "blockNumber": "2",
  "blockHash": "0xf58f4f43b3761f4863ad366c4a7e2a812ed68df9f7bcad6b502fd544665e7625",
  "from": "0x9d75e0ee66cfef16897b601624b60413d988ae7d",
  "to": "0x0000000000000000000000000000000000000000",
  "gasUsed": "316449",
  "contractAddress": "0xa8af0ee580d8af674a60341030ddbc45431bc235",
  "logs": [],
  "logsBloom": "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
  "status": "0x0",
  "statusMsg": "None",
  "input": "0x608060405234801561001057600080fd5b506103e3806100206000396000f300608060405260043610610057576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063299f7f9d1461005c5780633590b49f146100ec57806362e8d6ce14610155575b600080fd5b34801561006857600080fd5b5061007161016c565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100b1578082015181840152602081019050610096565b50505050905090810190601f1680156100de5780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156100f857600080fd5b50610153600480360381019080803590602001908201803590602001908080601f016020809104026020016040519081016040528093929190818152602001838380828437820191505050505050919291929050505061020e565b005b34801561016157600080fd5b5061016a6102c4565b005b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156102045780601f106101d957610100808354040283529160200191610204565b820191906000526020600020905b8154815290600101906020018083116101e757829003601f168201915b5050505050905090565b7f5715c9562eaf8d524d564edb392acddefc81d8133e2fc3b8125a260b1b413fda816040518080602001828103825283818151815260200191508051906020019080838360005b83811015610270578082015181840152602081019050610255565b50505050905090810190601f16801561029d5780820380516001836020036101000a031916815260200191505b509250505060405180910390a180600090805190602001906102c0929190610312565b5050565b6040805190810160405280600d81526020017f48656c6c6f2c20576f726c6421000000000000000000000000000000000000008152506000908051906020019061030f929190610312565b50565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061035357805160ff1916838001178555610381565b82800160010185558215610381579182015b82811115610380578251825591602001919060010190610365565b5b50905061038e9190610392565b5090565b6103b491905b808211156103b0576000816000905550600101610398565b5090565b905600a165627a7a72305820f3088deb3d14c6893440e4769f2389e9335e04faa10e6de5b4c93af15d1a34e80029",
  "output": "0x",
  "txProof": null,
  "receiptProof": null,
  "message": null,
  "statusOK": true
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
| 1        | 群组编号 | groupId | String |             | 是        |                      |
| 2        | 交易hash | transHash  | String   |              | 是       |          |
| 3 |  | withProof | boolean | |  | |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/1/web3/transaction/0x69ced0162a0c3892e4eaa3091b831ac3aaeb772c062746b20891ceaf8a4fb429
```

#### 响应参数


**1）数据格式**
```
{
  "blockHash": "0xf58f4f43b3761f4863ad366c4a7e2a812ed68df9f7bcad6b502fd544665e7625",
  "blockNumber": 2,
  "from": "0x9d75e0ee66cfef16897b601624b60413d988ae7d",
  "gas": "4300000",
  "hash": "0x69ced0162a0c3892e4eaa3091b831ac3aaeb772c062746b20891ceaf8a4fb429",
  "input": "0x608060405234801561001057600080fd5b506103e3806100206000396000f300608060405260043610610057576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063299f7f9d1461005c5780633590b49f146100ec57806362e8d6ce14610155575b600080fd5b34801561006857600080fd5b5061007161016c565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100b1578082015181840152602081019050610096565b50505050905090810190601f1680156100de5780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156100f857600080fd5b50610153600480360381019080803590602001908201803590602001908080601f016020809104026020016040519081016040528093929190818152602001838380828437820191505050505050919291929050505061020e565b005b34801561016157600080fd5b5061016a6102c4565b005b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156102045780601f106101d957610100808354040283529160200191610204565b820191906000526020600020905b8154815290600101906020018083116101e757829003601f168201915b5050505050905090565b7f5715c9562eaf8d524d564edb392acddefc81d8133e2fc3b8125a260b1b413fda816040518080602001828103825283818151815260200191508051906020019080838360005b83811015610270578082015181840152602081019050610255565b50505050905090810190601f16801561029d5780820380516001836020036101000a031916815260200191505b509250505060405180910390a180600090805190602001906102c0929190610312565b5050565b6040805190810160405280600d81526020017f48656c6c6f2c20576f726c6421000000000000000000000000000000000000008152506000908051906020019061030f929190610312565b50565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061035357805160ff1916838001178555610381565b82800160010185558215610381579182015b82811115610380578251825591602001919060010190610365565b5b50905061038e9190610392565b5090565b6103b491905b808211156103b0576000816000905550600101610398565b5090565b905600a165627a7a72305820f3088deb3d14c6893440e4769f2389e9335e04faa10e6de5b4c93af15d1a34e80029",
  "nonce": "0x3460c30bd3e4e88a31d6d033b3a172859bf003258e9606fd63fb0d91f91f4e6",
  "to": "0x0000000000000000000000000000000000000000",
  "transactionIndex": "0x0",
  "value": "0x0",
  "gasPrice": "22000000000",
  "blockLimit": "0x1f5",
  "chainId": "0x1",
  "groupId": "1",
  "extraData": "0x",
  "signature": {
    "r": "0x3416723318505669cca91689b213ff08ffb96d538210a0f691cfcfa9d529462b",
    "s": "0xd3642f19c228e2e86689de9efc19ecbb68378a6bb7c219984431e93d60c89124",
    "v": "0xc7935c199b680452eb37911856282b9c820322fd5fdec8a06b48cc3df4e8ed7d3d66a5adcc134cca609146ec0aed12827c35df07eed96042763c0926cf4223b7",
    "signature": "0x3416723318505669cca91689b213ff08ffb96d538210a0f691cfcfa9d529462bd3642f19c228e2e86689de9efc19ecbb68378a6bb7c219984431e93d60c89124c7935c199b680452eb37911856282b9c820322fd5fdec8a06b48cc3df4e8ed7d3d66a5adcc134cca609146ec0aed12827c35df07eed96042763c0926cf4223b7"
  }
}
```


### 3.8. 获取合约二进制代码接口  


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
| 1        | 群组编号 | groupId     | String     |              | 是       |          |
| 2        | 合约地址 | address     | String     |              | 是       |          |
| 3        | 块高     | blockNumber | BigInteger |              | 是       |          |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/group/web3/code/0x0000000000000000000000000000000000000000/1
```

#### 响应参数

**1）数据格式**

```
{
    0xxxx
}
```
### 3.9. 获取总交易数  


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
| 1        | 群组编号 | groupId    | String   |              | 是       |          |

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

### 3.10. 获取群组内的共识状态信息接口  


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
| 1        | 群组编号 | groupId | String |             | 是        |                      |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/group/web3/consensusStatus
```

#### 响应参数
**1）数据格式**

```
{
  "baseConsensusInfo": {
    "nodeNum": "4",
    "consensusedBlockNumber": "233",
    "highestblockNumber": "232",
    "groupId": "1",
    "protocolId": "65544",
    "accountType": "1",
    "cfgErr": "false",
    "omitEmptyBlock": "true",
    "nodeId": "fe57d7b39ed104b4fb2770ae5aad7946bfd377d0eb91ab92a383447e834c3257dec56686551d08178f2d5f40d9fad615293e46c9f5fc23cf187258e121213b1d",
    "allowFutureBlocks": "true",
    "connectedNodes": "3",
    "currentView": "102303",
    "toView": "102303",
    "leaderFailed": "false",
    "highestblockHash": "0x7f0885a7188bd5c1b3f8c182e00be0e63a3b1653b12752cf8501ddac995e6efc",
    "leaderId": null,
    "leaderIdx": null,
    "node_index": "3",
    "node index": null,
    "max_faulty_leader": "1",
    "sealer.": [
      "06269e130f8220ebaa78e67832df0de6b4c5ee3f1b14e64ab2bae26510a4bcf997454b35067c1685d4343e6ad84b45c3b8690a858f2831a9247a97a27166ce1f",
      "65bc44d398d99d95a9d404aa16e4bfbc2f9ebb40f20439ddef8575a139dc3a80310cfc98a035bd59a67cc5f659f519e3e99b855f3d27f21a889c23a14036d0c7",
      "95efafa5197796e7edf647191de83f4259d7cbb060f4bac5868be474037f49144d581c15d8aef9b07d78f18041a5f43c3c26352ebbf5583cd23070358c8fba39",
      "fe57d7b39ed104b4fb2770ae5aad7946bfd377d0eb91ab92a383447e834c3257dec56686551d08178f2d5f40d9fad615293e46c9f5fc23cf187258e121213b1d"
    ]
  },
  "viewInfos": [
    {
      "nodeId": "06269e130f8220ebaa78e67832df0de6b4c5ee3f1b14e64ab2bae26510a4bcf997454b35067c1685d4343e6ad84b45c3b8690a858f2831a9247a97a27166ce1f",
      "view": "102300"
    },
    {
      "nodeId": "65bc44d398d99d95a9d404aa16e4bfbc2f9ebb40f20439ddef8575a139dc3a80310cfc98a035bd59a67cc5f659f519e3e99b855f3d27f21a889c23a14036d0c7",
      "view": "102301"
    },
    {
      "nodeId": "95efafa5197796e7edf647191de83f4259d7cbb060f4bac5868be474037f49144d581c15d8aef9b07d78f18041a5f43c3c26352ebbf5583cd23070358c8fba39",
      "view": "102302"
    },
    {
      "nodeId": "fe57d7b39ed104b4fb2770ae5aad7946bfd377d0eb91ab92a383447e834c3257dec56686551d08178f2d5f40d9fad615293e46c9f5fc23cf187258e121213b1d",
      "view": "102303"
    }
  ]
}
```

### 3.11. 获取群组列表接口  

#### 接口描述

> 返回群组列表

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/groupList**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

无

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/group/web3/groupList
```

#### 响应参数

**1）数据格式**
```
[
  "1",
  "2"
]
```

### 3.12. 获取观察及共识节点列表

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
| 1        | 群组编号 | groupId | String |             | 是        |                      |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/group/web3/groupPeers
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



### 3.13. 获取群组内观察节点列表

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
| 1        | 群组编号 | groupId | String |             | 是        |                      |


**2）数据格式**

```
http://localhost:5002/WeBASE-Front/group/web3/observerList
```

#### 响应参数

**1）数据格式**
```
[  "d822165959a0ed217df6541f1a7dd38b79336ff571dd5f8f85ad76f3e7ec097e1eabd8b03e4a757fd5a9fb0eea905aded56aaf44df83c34b73acb9ab7a165010"
]
```


### 3.14. 获取已连接的P2P节点信息

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
| 1        | 群组编号 | groupId | String |             | 是        |                      |


**2）数据格式**

```
http://localhost:5002/WeBASE-Front/group/web3/peers
```

#### 响应参数

**1）数据格式**
```
{
  "blockNumber": 0,
  "endPoint": "string",
  "genesisHash": "string",
  "groupNodeIDInfo": [
    {
      "group": "string",
      "nodeIDList": [
        "string"
      ]
    }
  ],
  "latestHash": "string",
  "nodeID": "string",
  "p2pNodeID": "string",
  "peers": [
    {
      "endPoint": "string",
      "groupNodeIDInfo": [
        {
          "group": "string",
          "nodeIDList": [
            "string"
          ]
        }
      ],
      "p2pNodeID": "string"
    }
  ]
}
```

### 3.15. 获取群组内正在处理的交易数

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
| 1        | 群组编号 | groupId | String |             | 是        |                      |


**2）数据格式**

```
http://localhost:5002/WeBASE-Front/group/web3/pending-transactions-count
```

#### 响应参数

**1）数据格式**
```
0
```


### 3.16. 获取共识节点接口

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
| 1        | 群组编号 | groupId | String |             | 是        |                      |


**2）数据格式**

```
http://localhost:5002/WeBASE-Front/group/web3/sealerList
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


### 3.17 区块/交易

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
| 1        | 群组编号 | groupId | String |             | 是        |                      |
| 2        | 查询参数 | inputValue | int/String | | 是 | 如果输入块高就返回区块信息，如果输入交易hash就返回交易信息|


**2）数据格式**

```
http://localhost:5002/WeBASE-Front/group/web3/search?input=123
```

#### 响应参数

**1）数据格式**
```
{
  "number": 123,
  "hash": "0xa12a4a8d26a15fcff6f67acf94a3fb2c08d4476806009be40fe4026fd622419d",
  "parentHash": "0x898c6b1657d4eb26307b39f248e471498975eb820671c7540fa516e6c7b411e8",
  "logsBloom": "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
  "transactionsRoot": "0xa94acacd692cf3b23e19b429ce89c2016020b2264854fd609ba2b16f0c7d5f73",
  "receiptsRoot": "0x9529b51c1f7ddd178ffd4a65d146b50cfc0beb405a808677dfddd694cf555a09",
  "dbHash": "0x3047354b6776fd1f02911f2c4fc4aa1b215b3df53cc7504a71b5f3bfe12eca3a",
  "stateRoot": "0x3047354b6776fd1f02911f2c4fc4aa1b215b3df53cc7504a71b5f3bfe12eca3a",
  "sealer": "0x1",
  "sealerList": [
    "06269e130f8220ebaa78e67832df0de6b4c5ee3f1b14e64ab2bae26510a4bcf997454b35067c1685d4343e6ad84b45c3b8690a858f2831a9247a97a27166ce1f",
    "65bc44d398d99d95a9d404aa16e4bfbc2f9ebb40f20439ddef8575a139dc3a80310cfc98a035bd59a67cc5f659f519e3e99b855f3d27f21a889c23a14036d0c7",
    "95efafa5197796e7edf647191de83f4259d7cbb060f4bac5868be474037f49144d581c15d8aef9b07d78f18041a5f43c3c26352ebbf5583cd23070358c8fba39",
    "fe57d7b39ed104b4fb2770ae5aad7946bfd377d0eb91ab92a383447e834c3257dec56686551d08178f2d5f40d9fad615293e46c9f5fc23cf187258e121213b1d"
  ],
  "extraData": [],
  "gasLimit": "0",
  "gasUsed": "0",
  "timestamp": "1621928850887",
  "signatureList": [
    {
      "index": "0x3",
      "signature": "0x8549a8adddb9ff2d8d472b7a65ca414a7f10519f59e11244b9e92fed2e30f29cc272938a695ebb1ead579bdaed401b6aa31395890139abe406518471efa55d6afe57d7b39ed104b4fb2770ae5aad7946bfd377d0eb91ab92a383447e834c3257dec56686551d08178f2d5f40d9fad615293e46c9f5fc23cf187258e121213b1d"
    },
    {
      "index": "0x1",
      "signature": "0x0ff480d6c3fe5908c554653376492cba23cfc938bc0847298c9c8b4c140b417be1990d25c0239f9b18e24276e864e1f2ac4beab47ddf5277a767bb7c93e143ed65bc44d398d99d95a9d404aa16e4bfbc2f9ebb40f20439ddef8575a139dc3a80310cfc98a035bd59a67cc5f659f519e3e99b855f3d27f21a889c23a14036d0c7"
    },
    {
      "index": "0x2",
      "signature": "0x50aa1513c390e5e61221418aa46f8dd45e3ce6e8c0a6fa5aa75650517560589590172b1e6cc64e9ba7ab45c964ff925524cecf6c2be0a28ea11426febb69305195efafa5197796e7edf647191de83f4259d7cbb060f4bac5868be474037f49144d581c15d8aef9b07d78f18041a5f43c3c26352ebbf5583cd23070358c8fba39"
    }
  ],
  "transactions": [
    {
      "blockHash": "0xa12a4a8d26a15fcff6f67acf94a3fb2c08d4476806009be40fe4026fd622419d",
      "blockNumber": 123,
      "from": "0x1cd8126354aa951dc8ed083ed91fd31fad1f50d8",
      "gas": "0x5f5e100",
      "hash": "0xbe858390cf0bd94f9d17c6ab5e04a7d354f9482f2568f067bdc2529a0af324db",
      "input": "0x25e85d16000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000803935656661666135313937373936653765646636343731393164653833663432353964376362623036306634626163353836386265343734303337663439313434643538316331356438616566396230376437386631383034316135663433633363323633353265626266353538336364323330373033353863386662613339",
      "nonce": "0x1479caf2ff5f1a6121beac93c85b59c36280ffe6a7f124cbc3d232021fa3307",
      "to": "0x0000000000000000000000000000000000001003",
      "transactionIndex": "0x0",
      "value": "0x0",
      "gasPrice": "0x1",
      "blockLimit": "0x26e",
      "chainId": "0x1",
      "groupId": "0x1",
      "extraData": "0x",
      "signature": {
        "r": "0x36edc104cc5c2c5c992f9804bd3415378f93c18ebc9cdeb7794c08b1c95fd7ad",
        "s": "0xed555fe3a192acc5ea01951f7286f93cff3471e84731a2942968a2fd9a9a14bc",
        "v": "0xd3a0fac51c66adf23bfccc6bb3aaa3d3623040912963ceb818ca2d8b1fb649c64bce64d99a8d9a39158b2c713101dbca10a478131dcae7e42d156e0e69455652",
        "signature": "0x36edc104cc5c2c5c992f9804bd3415378f93c18ebc9cdeb7794c08b1c95fd7aded555fe3a192acc5ea01951f7286f93cff3471e84731a2942968a2fd9a9a14bcd3a0fac51c66adf23bfccc6bb3aaa3d3623040912963ceb818ca2d8b1fb649c64bce64d99a8d9a39158b2c713101dbca10a478131dcae7e42d156e0e69455652"
      }
    }
  ]
}
```

### 3.18. 获取群组内同步状态信息

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
| 1        | 群组编号 | groupId | String |             | 是        |                      |


**2）数据格式**

```
http://localhost:5002/WeBASE-Front/group/web3/syncStatus
```

#### 响应参数

**1）数据格式**
```
{
  "isSyncing": "false",
  "protocolId": "65545",
  "genesisHash": "1caec77e0ff42af4f045af2ba5503c775c33430085b246374cdd23d1c9191173",
  "nodeId": "fe57d7b39ed104b4fb2770ae5aad7946bfd377d0eb91ab92a383447e834c3257dec56686551d08178f2d5f40d9fad615293e46c9f5fc23cf187258e121213b1d",
  "blockNumber": "232",
  "latestHash": "7f0885a7188bd5c1b3f8c182e00be0e63a3b1653b12752cf8501ddac995e6efc",
  "knownHighestNumber": "232",
  "txPoolSize": "0",
  "peers": [
    {
      "nodeId": "06269e130f8220ebaa78e67832df0de6b4c5ee3f1b14e64ab2bae26510a4bcf997454b35067c1685d4343e6ad84b45c3b8690a858f2831a9247a97a27166ce1f",
      "genesisHash": "1caec77e0ff42af4f045af2ba5503c775c33430085b246374cdd23d1c9191173",
      "blockNumber": "232",
      "latestHash": "7f0885a7188bd5c1b3f8c182e00be0e63a3b1653b12752cf8501ddac995e6efc"
    },
    {
      "nodeId": "65bc44d398d99d95a9d404aa16e4bfbc2f9ebb40f20439ddef8575a139dc3a80310cfc98a035bd59a67cc5f659f519e3e99b855f3d27f21a889c23a14036d0c7",
      "genesisHash": "1caec77e0ff42af4f045af2ba5503c775c33430085b246374cdd23d1c9191173",
      "blockNumber": "232",
      "latestHash": "7f0885a7188bd5c1b3f8c182e00be0e63a3b1653b12752cf8501ddac995e6efc"
    },
    {
      "nodeId": "95efafa5197796e7edf647191de83f4259d7cbb060f4bac5868be474037f49144d581c15d8aef9b07d78f18041a5f43c3c26352ebbf5583cd23070358c8fba39",
      "genesisHash": "1caec77e0ff42af4f045af2ba5503c775c33430085b246374cdd23d1c9191173",
      "blockNumber": "232",
      "latestHash": "7f0885a7188bd5c1b3f8c182e00be0e63a3b1653b12752cf8501ddac995e6efc"
    }
  ],
  "knownLatestHash": "7f0885a7188bd5c1b3f8c182e00be0e63a3b1653b12752cf8501ddac995e6efc"
}
```

### 3.19. 刷新前置

#### 接口描述

> 刷新前置的群组列表，功能与`groupList`类似

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/refresh**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

无


**2）数据格式**

```
http://localhost:5002/WeBASE-Front/group/web3/refresh
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


### 3.20. 获取区块的时间戳与交易量

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
|    1     | 群组id       | groupId           | String |              |   是     |    操作的群组编号                        |
|    2     | 块高         | blockNumber            | BigInteger   |              | 是       |   |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/group/web3/blockStat/5
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

### 3.21. 批量获取区块内交易回执接口 


#### 接口描述

> 根据块高批量获取区块交易回执

#### 接口URL

**http://localhost:5002/WeBASE-Front/{groupId}/web3/transactionReceipt/{transHash}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 群组编号 | groupId | String |             | 是        |                      |
| 2        | 交易哈希 | transHash | String |              | 是       |          |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/group/web3/transReceipt/batchByNumber/{blockNumber}?start={start}&count={count}
```

#### 响应参数

**2）数据格式**

```
{
  "blockNumber": "string",
  "contractAddress": "string",
  "from": "string",
  "gasUsed": "string",
  "hash": "string",
  "input": "string",
  "logEntries": [
    {
      "address": "string",
      "blockNumber": "string",
      "data": "string",
      "topic": [
        "string"
      ]
    }
  ],
  "message": "string",
  "output": "string",
  "receiptProof": [
    {
      "left": [
        "string"
      ],
      "right": [
        "string"
      ]
    }
  ],
  "status": 0,
  "statusOK": true,
  "to": "string",
  "transactionHash": "string",
  "transactionProof": [
    {
      "left": [
        "string"
      ],
      "right": [
        "string"
      ]
    }
  ],
  "version": "string"
}
```
## 4.链上信息接口

### 4.1. 查询链上信息

#### 接口描述

获取链上信息

#### 接口URL

**http://localhost:5002/WeBASE-Front/chain**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**        | **类型**      | **最大长度** | **必填** | **说明** |
| -------- | ------------ | ----------------- | ------------- | ------------ | -------- | -------- |
| 1        | 开始日期     | beginDate         | LocalDateTime |              | 是       |          |
| 2        | 结束日期     | endDate           | LocalDateTime |              | 是       |          |
| 3        | 对比开始日期 | contrastBeginDate | LocalDateTime |              | 否       |          |
| 4        | 对比结束日期 | contrastEndDate   | LocalDateTime |              | 否       |          |
| 5        | 间隔         | gap               | int           |              | 否       | 默认为1  |
| 6        | 群组编号     | groupId           | String        |              | 是       | 默认为1  |

***2）入参示例***

```
localhost:5002/WeBASE-Front/chain?beginDate=2019-03-13T00:00:00&endDate=2019-03-13T14:34:22&contrastBeginDate=2019-03-13T00:00:00&contrastEndDate=2019-03-13T14:34:22&gap=60&groupId=group
```

#### 响应参数

**1）参数表**

| 序号      | 输出参数         | 类型          |      | 备注                                                         |
| --------- | ---------------- | ------------- | ---- | ------------------------------------------------------------ |
| 1         | data             | Array         | 否   | 返回信息列表                                                 |
| 1.1       |                  | Object        |      | 返回信息实体                                                 |
| 1.1.1     | metricType       | String        | 否   | 测量类型：blockHeight（块高）、pbftView（pbft视图）、pendingCount（待处理交易数量） |
| 1.1.2     | data             | Object        | 否   |                                                              |
| 1.1.2.1   | lineDataList     | Object        | 否   | 指定时间的数据                                               |
| 1.1.2.1.1 | timestampList    | List<String>  | 否   | 时间戳列表                                                   |
| 1.1.2.1.2 | valueList        | List<Integer> | 否   | 值列表                                                       |
| 1.1.2.2   | contrastDataList | Object        | 否   | 比对时间的数据                                               |
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

### 4.2. 分页查询链上信息

#### 接口描述

获取链上信息

#### 接口URL

**[http://localhost:5002/WeBASE-Front/chain/pagingQuery]()**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 开始日期 | beginDate  | String   |              | 是       |          |
| 2        | 结束日期 | endDate    | String   |              | 是       |          |
| 3        | 分页页数 | pageNumber | int      |              | 否       |          |
| 4        | 分页大小 | pageSize   | int      |              | 否       |          |
| 5        | 群组编号 | groupId    | String   |              | 是       | 默认为1  |

***2）入参示例***

```
localhost:5002/WeBASE-Front/chain/pagingQuery?groupId=1&pageNumber=1&pageSize=10
```

#### 响应参数

```
{
  "code": 0,
  "message": "success",
  "data": [],
  "totalCount": 0
}
```

##  5. 交易接口

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
| 7        | 群组ID         | groupId         | String |              |   是       |  默认为1                                          |
| 8 | 是否使用cns调用 | useCns | bool | | 是 |  |
| 9 | cns名称 | cnsName | String | | 否 | CNS名称，useCns为true时不能为空 |
| 10 | cns版本 | version | String | | 否 | CNS版本，useCns为true时不能为空 |
| 11 | 合约路径 | contractPath | String | | 否 |  |


**2）数据格式**

```
{
  "cnsName": "string",
  "contractAbi": [
    {}
  ],
  "contractAddress": "string",
  "contractName": "string",
  "contractPath": "string",
  "funcName": "string",
  "funcParam": [
    {}
  ],
  "groupId": "string",
  "signUserId": "string",
  "useCns": true,
  "version": "string"
}
```

示例：

```
curl -X POST "http://localhost:5002/WeBASE-Front/trans/handleWithSign" -H "accept: */*" -H "Content-Type: application/json" -d "{\"groupId\":\"1\",\"signUserId\":\"f4975519b0274e6ca8283650a7e1bc07\",\"contractName\":\"HelloWorld\",\"contractPath\":\"/\",\"version\":\"\",\"funcName\":\"set\",\"funcParam\":[\"333\"],\"contractAddress\":\"0xe10441d9179cf0424aae808b51bc85dcbbfe1447\",\"contractAbi\":[{\"inputs\":[{\"internalType\":\"string\",\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\",\"funcId\":2}],\"useAes\":false,\"useCns\":false,\"cnsName\":\"\"}"
```

#### 响应参数

a、正确查询交易返回值信息

```
{"Hi,Welcome!"}
```

b、正确发送数据上链返回值信息（交易收据）

```
{
  "transactionHash": "0x69ced0162a0c3892e4eaa3091b831ac3aaeb772c062746b20891ceaf8a4fb429",
  "transactionIndex": "0x0",
  "root": "0x8cbc3f2c0e35a71738909e3b388efa6697084b05badd3a3bd3c64f0575c78c15",
  "blockNumber": "2",
  "blockHash": "0xf58f4f43b3761f4863ad366c4a7e2a812ed68df9f7bcad6b502fd544665e7625",
  "from": "0x9d75e0ee66cfef16897b601624b60413d988ae7d",
  "to": "0x0000000000000000000000000000000000000000",
  "gasUsed": "316449",
  "contractAddress": "0xa8af0ee580d8af674a60341030ddbc45431bc235",
  "logs": [],
  "logsBloom": "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
  "status": "0x0",
  "statusMsg": "None",
  "input": "0x608060405234801561001057600080fd5b506103e3806100206000396000f300608060405260043610610057576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063299f7f9d1461005c5780633590b49f146100ec57806362e8d6ce14610155575b600080fd5b34801561006857600080fd5b5061007161016c565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100b1578082015181840152602081019050610096565b50505050905090810190601f1680156100de5780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156100f857600080fd5b50610153600480360381019080803590602001908201803590602001908080601f016020809104026020016040519081016040528093929190818152602001838380828437820191505050505050919291929050505061020e565b005b34801561016157600080fd5b5061016a6102c4565b005b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156102045780601f106101d957610100808354040283529160200191610204565b820191906000526020600020905b8154815290600101906020018083116101e757829003601f168201915b5050505050905090565b7f5715c9562eaf8d524d564edb392acddefc81d8133e2fc3b8125a260b1b413fda816040518080602001828103825283818151815260200191508051906020019080838360005b83811015610270578082015181840152602081019050610255565b50505050905090810190601f16801561029d5780820380516001836020036101000a031916815260200191505b509250505060405180910390a180600090805190602001906102c0929190610312565b5050565b6040805190810160405280600d81526020017f48656c6c6f2c20576f726c6421000000000000000000000000000000000000008152506000908051906020019061030f929190610312565b50565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061035357805160ff1916838001178555610381565b82800160010185558215610381579182015b82811115610380578251825591602001919060010190610365565b5b50905061038e9190610392565b5090565b6103b491905b808211156103b0576000816000905550600101610398565b5090565b905600a165627a7a72305820f3088deb3d14c6893440e4769f2389e9335e04faa10e6de5b4c93af15d1a34e80029",
  "output": "0x",
  "txProof": null,
  "receiptProof": null,
  "message": null,
  "statusOK": true
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
| 7        | 群组ID                      | groupId         | String   |              | 是       |                                                              |
| 8        | 合约路径                    | contractPath    | int      |              | 否       |                                                              |
| 9        | 是否使用cns调用             | useCns          | boolean  |              | 是       |                                                              |
| 10       | cns名称                     | cnsName         | String   |              | 否       | CNS名称，useCns为true时不能为空                              |
| 11       | cns版本                     | version         | String   |              | 否       | CNS版本，useCns为true时不能为空                              |
| 12       | 是否使用aes                 | useAes          | boolean  |              | 是       |                                                              |

**2）数据格式**

```
{
  "cnsName": "string",
  "contractAbi": [
    {}
  ],
  "contractAddress": "string",
  "contractName": "string",
  "contractPath": "string",
  "funcName": "string",
  "funcParam": [
    {}
  ],
  "groupId": "string",
  "useAes": true,
  "useCns": true,
  "user": "string",
  "version": "string"
}
```

示例：

```
curl -l -H "Content-type: application/json" -X POST -d '{\"groupId\":\"1\",\"user\":\"0x7bfa3539c8761978f0a2a1f7f240bde97819fb03\",\"contractName\":\"HelloWorld\",\"contractPath\":\"/\",\"version\":\"\",\"funcName\":\"set\",\"funcParam\":[\"333\"],\"contractAddress\":\"0xe10441d9179cf0424aae808b51bc85dcbbfe1447\",\"contractAbi\":[{\"inputs\":[{\"internalType\":\"string\",\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\",\"funcId\":2}],\"useAes\":false,\"useCns\":false,\"cnsName\":\"\"}' http://10.0.0.1:5002/WeBASE-Front/trans/handle
```

传入合约abi:

```
{
	"groupId": "group",
	"user": "0x7bfa3539c8761978f0a2a1f7f240bde97819fb03",
	"contractName": "HelloWorld",
	"contractPath": "/",
	"version": "",
	"funcName": "set",
	"funcParam": ["333"],
	"contractAddress": "0xe10441d9179cf0424aae808b51bc85dcbbfe1447",
	"contractAbi": [{
		"inputs": [{
			"internalType": "string",
			"name": "n",
			"type": "string"
		}],
		"name": "set",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function",
		"funcId": 2
	}],
	"useAes": false,
	"useCns": false,
	"cnsName": ""
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
  "transactionHash": "0x69ced0162a0c3892e4eaa3091b831ac3aaeb772c062746b20891ceaf8a4fb429",
  "transactionIndex": "0x0",
  "root": "0x8cbc3f2c0e35a71738909e3b388efa6697084b05badd3a3bd3c64f0575c78c15",
  "blockNumber": "2",
  "blockHash": "0xf58f4f43b3761f4863ad366c4a7e2a812ed68df9f7bcad6b502fd544665e7625",
  "from": "0x9d75e0ee66cfef16897b601624b60413d988ae7d",
  "to": "0x0000000000000000000000000000000000000000",
  "gasUsed": "316449",
  "contractAddress": "0xa8af0ee580d8af674a60341030ddbc45431bc235",
  "logs": [],
  "logsBloom": "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
  "status": "0x0",
  "statusMsg": "None",
  "input": "0x608060405234801561001057600080fd5b506103e3806100206000396000f300608060405260043610610057576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063299f7f9d1461005c5780633590b49f146100ec57806362e8d6ce14610155575b600080fd5b34801561006857600080fd5b5061007161016c565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100b1578082015181840152602081019050610096565b50505050905090810190601f1680156100de5780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156100f857600080fd5b50610153600480360381019080803590602001908201803590602001908080601f016020809104026020016040519081016040528093929190818152602001838380828437820191505050505050919291929050505061020e565b005b34801561016157600080fd5b5061016a6102c4565b005b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156102045780601f106101d957610100808354040283529160200191610204565b820191906000526020600020905b8154815290600101906020018083116101e757829003601f168201915b5050505050905090565b7f5715c9562eaf8d524d564edb392acddefc81d8133e2fc3b8125a260b1b413fda816040518080602001828103825283818151815260200191508051906020019080838360005b83811015610270578082015181840152602081019050610255565b50505050905090810190601f16801561029d5780820380516001836020036101000a031916815260200191505b509250505060405180910390a180600090805190602001906102c0929190610312565b5050565b6040805190810160405280600d81526020017f48656c6c6f2c20576f726c6421000000000000000000000000000000000000008152506000908051906020019061030f929190610312565b50565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061035357805160ff1916838001178555610381565b82800160010185558215610381579182015b82811115610380578251825591602001919060010190610365565b5b50905061038e9190610392565b5090565b6103b491905b808211156103b0576000816000905550600101610398565b5090565b905600a165627a7a72305820f3088deb3d14c6893440e4769f2389e9335e04faa10e6de5b4c93af15d1a34e80029",
  "output": "0x",
  "txProof": null,
  "receiptProof": null,
  "message": null,
  "statusOK": true
}
```

### 5.3. 已签名交易发送
<span id="signed-transaction"></span>

#### 接口描述

发送已签名的交易上链，返回交易收据；可结合`/trans/convertRawTxStr/local`或`/trans/convertRawTxStr/withSign`接口组装已签名的交易

#### 接口URL

**http://localhost:5002/WeBASE-Front/trans/signed-transaction**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | ------------ | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 已签名交易编码值 | signedStr  | String   |              | 是       |  `/trans/convertRawTxStr/local`或`/trans/convertRawTxStr/withSign`接口组装已签名的交易        |
| 2        | 是否同步发送 | sync       | bool     |              | 是       |          |
| 2        | 群组ID       | groupId    | String |              | 是   |          |

**2）数据格式**

```
{
  "groupId": "string",
  "signedStr": "string",
  "sync": true
}
```

#### 响应参数

**1）数据格式**

```
{
	"transactionHash": "0xd1234cdb673447b654874d05d4ed98be89f3cb7c5a6c12bc51e1274a03af029c",
	"transactionIndex": "0x0",
	"root": "0xeecf2b6bbb028e38e704ca88fe1d9f5e3d43197b32c3336d3273d86fb3a135f0",
	"blockNumber": "0xa9",
	"blockHash": "0x906bdf0747ba68c03e6cf73463db62fdbd8ab8debc149f890475775d7c6a8af7",
	"from": "0x7bfa3539c8761978f0a2a1f7f240bde97819fb03",
	"to": "0xe10441d9179cf0424aae808b51bc85dcbbfe1447",
	"gasUsed": "0x710b",
	"contractAddress": "0x0000000000000000000000000000000000000000",
	"logs": [],
	"logsBloom": "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	"status": "0x0",
	"statusMsg": "None",
	"input": "0x3590b49f000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000033333330000000000000000000000000000000000000000000000000000000000",
	"output": "0x",
	"txProof": null,
	"receiptProof": null,
	"message": "Success",
	"statusOK": true
}
```


### 5.4. 已编码查询交易发送

#### 接口描述

发送已编码的查询交易，返回合约的返回值；其中`encodeStr`字段可通过`/trans/encodeFunction`接口获取合约函数的编码值

#### 接口URL

**http://localhost:5002/WeBASE-Front/trans/query-transaction**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**      | **类型** | **最大长度** | **必填** | **说明** |
| -------- | ------------ | --------------- | -------- | ------------ | -------- | -------- |
| 1        | 合约函数编码值 | encodeStr       | String   |              | 是       | 可通过`/trans/encodeFunction`接口获取合约函数的编码值         |
| 2        | 合约地址     | contractAddress | String   |              | 是       |          |
| 3        | 群组ID       | groupId         | String |              | 是       |          |
| 4        | 合约名       | funcName        | String   |              | 是       |          |
| 5        | 合约abi      | contractAbi     | String   |              | 是       |          |
| 6        | 用户地址     | userAddress     | String   |              | 否       |          |

**2）数据格式**

```
{
  "contractAbi": "string",
  "contractAddress": "string",
  "encodeStr": "string",
  "funcName": "string",
  "groupId": "string",
  "userAddress": "string"
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

| **序号** | **中文**   | **参数名** | **类型** | **最大长度** | **必填** | **说明**                              |
| -------- | ---------- | ---------- | -------- | ------------ | -------- | ------------------------------------- |
| 1        | 用户地址   | user       | String   |              | 是       | 用户地址，可通过`/privateKey`接口创建 |
| 2        | Hash值     | hash       | String   |              | 是       |                                       |
| 3        | 群组id     | groupId    | String   |              | 是       |                                       |
| 4        | 签名用户id | signUserId | String   |              | 是       |                                       |

**2）数据格式**

```
{
  "groupId": "string",
  "hash": "string",
  "signUserId": "string",
  "user": "string"
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


### 5.6. 获取签名后的交易体编码值（结合WeBASE-Sign）
<span id="convertRawTxStr_withSign"></span>

#### 接口描述

构造交易体RawTransaction并将交易体编码，通过传入的`signUserId`签名服务的用户ID，使用对应的私钥对交易提进行签名后，返回已签名的交易体编码值（十六进制字符串）

签名后的交易的编码值可以直接通过`/trans/signed-transaction`接口提交到链上

#### 接口URL

**http://localhost:5002/WeBASE-Front/trans/convertRawTxStr/withSign**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
| 1        | 用户编号       | signUserId      | String   |     64         | 是       | WeBASE-Sign用户编号，若为空则返回未签名交易提编码值                          |
| 2        | 合约名称       | contractName    | String   |              | 是       |                                                |
| 3        | 合约地址       | contractAddress | String   |              | 是       |                                                |
| 4        | 方法名         | funcName        | String   |              | 是       |                                                |
| 5        | 合约编译后生成的abi文件内容 | contractAbi    | List |        | 是        | 合约中单个函数的ABI，若不存在同名函数可以传入整个合约ABI，格式：JSONArray |
| 6        | 方法参数       | funcParam       | List     |              | 否         | JSON数组，多个参数以逗号分隔（参数为数组时同理），如：["str1",["arr1","arr2"]] |
| 7        | 群组ID         | groupId         | String |              |   是       |                                            |
| 8 | 是否使用cns调用 | useCns | bool | | 是 |  |
| 9 | cns名称 | cnsName | String | | 否 | CNS名称，useCns为true时不能为空 |
| 10 | cns版本 | version | String | | 否 | CNS版本，useCns为true时不能为空 |
| 11 | 合约路径 | contractPath | String | | 否 |  |


**2）数据格式**

```
{
  "cnsName": "string",
  "contractAbi": [
    {}
  ],
  "contractAddress": "string",
  "contractName": "string",
  "contractPath": "string",
  "funcName": "string",
  "funcParam": [
    {}
  ],
  "groupId": "string",
  "signUserId": "string",
  "useCns": true,
  "version": "string"
}
```

#### 响应参数

```
0xf9012da002c1442b6ce974291ec317db9859e8310de46f6636d105f19fee67f10ac60b2f018405f5e10082029e94e10441d9179cf0424aae808b51bc85dcbbfe144780b8643590b49f000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000033333330000000000000000000000000000000000000000000000000000000000010180b8407d3efe268051e49350d877eaba7bbe6369a44263aec6e47fcba2ac1aff849261e833361bc67befbf4566894478c011dcae3e06818a381401751d1bf8bceecedaa01605fb8fcb546b0dc79e1da004a8323b151d1f569e10cae85a3f62bad5d7150fa0d77282eb650e0f52956693177717eb31cfddcada0681973a6aed9c46f3d8eb4d
```


### 5.7. 获取签名后的交易体编码值（本地签名）
<span id="convertRawTxStr_local"></span>
#### 接口描述

构造交易体RawTransaction并将交易体编码，并通过传入的`user`地址的私钥对交易提进行签名后，返回已签名的交易体编码值（十六进制字符串）

签名后的交易的编码值可以直接通过`/trans/signed-transaction`接口提交到链上

#### 接口URL

**http://localhost:5002/WeBASE-Front/trans/convertRawTxStr/local**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**                    | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                                     |
| -------- | --------------------------- | --------------- | -------- | ------------ | -------- | ------------------------------------------------------------ |
| 1        | 用户地址                    | user            | String   |              | 是       | 用户地址，可通过`/privateKey`接口创建。*若user为空，则返回未签名交易编码值* |
| 2        | 合约名称                    | contractName    | String   |              | 是       |                                                              |
| 3        | 合约地址                    | contractAddress | String   |              | 是       |                                                              |
| 4        | 方法名                      | funcName        | String   |              | 是       |                                                              |
| 5        | 合约编译后生成的abi文件内容 | contractAbi     | List     |              | 是       | 合约中单个函数的ABI，若不存在同名函数可以传入整个合约ABI，格式：JSONArray |
| 6        | 方法参数                    | funcParam       | List     |              | 否       | JSON数组，多个参数以逗号分隔（参数为数组时同理），如：["str1",["arr1","arr2"]]，根据所调用的合约方法判断是否必填 |
| 7        | 群组ID                      | groupId         | String   |              | 是       |                                                              |
| 8        | 合约路径                    | contractPath    | int      |              | 否       |                                                              |
| 9        | 是否使用cns调用             | useCns          | bool     |              | 是       |                                                              |
| 10       | cns名称                     | cnsName         | String   |              | 否       | CNS名称，useCns为true时不能为空                              |
| 11       | cns版本                     | version         | String   |              | 否       | CNS版本，useCns为true时不能为空                              |
| 12       | 是否使用aes                 | useAes          | bool     |              | 是       |                                                              |

**2）数据格式**

```
{
  "cnsName": "string",
  "contractAbi": [
    {}
  ],
  "contractAddress": "string",
  "contractName": "string",
  "contractPath": "string",
  "funcName": "string",
  "funcParam": [
    {}
  ],
  "groupId": "string",
  "useAes": true,
  "useCns": true,
  "user": "string",
  "version": "string"
}
```

示例：

```
{
  "cnsName": "string",
  "contractAbi": [
    {}
  ],
  "contractAddress": "string",
  "contractName": "string",
  "contractPath": "string",
  "funcName": "string",
  "funcParam": [
    {}
  ],
  "groupId": "string",
  "useAes": true,
  "useCns": true,
  "user": "string",
  "version": "string"
}
```

#### 响应参数

**1）数据格式**

```
0xf9012da001071041dddc1b3c553b48c0fbefecc07f3812f5ce4004d47708f1c3342844db018405f5e10082029d94e10441d9179cf0424aae808b51bc85dcbbfe144780b8643590b49f000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000033333330000000000000000000000000000000000000000000000000000000000010180b84083bb5313e3dd7825b8b3e32d73aa8aedf9f9a8fcf435e5c37edfe4645c1af4211c12e1368024336a576f26ed624407da0b94e0bc5760514543c0b7a38fa03a7da0972843d0879ffdbdae733e8707896a532e5e1a3c7262cb84db657dd34f09111ba0786106465fe0fd2383588693cafef8934df62b188c6bb5a74eb6b9f23adaba32
```


### 5.8. 获取合约函数的编码值
<span id="encodeFunction"></span>

#### 接口描述

构造合约函数的编码值，适用于查询交易，合约函数的编码值可以直接通过`/trans/query-transaction`接口提交到链上

#### 接口URL

**http://localhost:5002/WeBASE-Front/trans/encodeFunction**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**                    | **参数名**  | **类型** | **最大长度** | **必填** | **说明**                                                     |
| -------- | --------------------------- | ----------- | -------- | ------------ | -------- | ------------------------------------------------------------ |
| 1        | 方法名                      | funcName    | String   |              | 是       |                                                              |
| 2        | 合约编译后生成的abi文件内容 | contractAbi | List     |              | 是       | 合约中单个函数的ABI，若不存在同名函数可以传入整个合约ABI，格式：JSONArray |
| 3        | 方法参数                    | funcParam   | List     |              | 是       | JSON数组，多个参数以逗号分隔（参数为数组时同理），如：["str1",["arr1","arr2"]]，根据所调用的合约方法判断是否必填，为空则使用`[]`空数组代替 |
| 4        | 群组编号                    | groupId     | String   |              |          |                                                              |

**2）数据格式**

```
{
  "contractAbi": [
    {}
  ],
  "funcName": "string",
  "funcParam": [
    {}
  ],
  "groupId": "string"
}
```

示例：



#### 响应参数

**1）数据格式**

```
0x299f7f9d
```


## 6. 系统管理接口

使用FISCO BCOS v2.5.0 与 WeBASE-Front v1.4.1 (及)以上版本将使用预编译合约中的ChainGovernance接口(从本章节[接口6.13](#governance)开始)，详情可参考[FISCO BCOS基于角色的权限控制](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/manual/permission_control.html#id2)

### 6.1. 查询系统配置接口

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
| 1        | 群组ID       | groupId            | String |              | 是       | 节点所属群组ID                           |
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

### 6.2. 设置系统配置接口

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
| 1        | 群组ID       | groupId            | String |              | 是       | 节点所属群组ID                           |
| 2        | 管理员地址       | fromAddress | String   |              | 是       |                                                |
| 3        | 配置的键         | configKey        | String   |           | 是       |   目前类型两种(tx_count_limit， tx_gas_limit，用户可自定义key如tx_gas_price                                             |
| 4        | 配置的值       | configValue       | String     |              |     是    | tx_gas_limit范围为 [100000, 2147483647]|
| 5 | 签名用户Id | signUserId | String | | 是 | |

**2）数据格式**

```
{
  "configKey": "string",
  "configValue": "string",
  "fromAddress": "string",
  "groupId": "string",
  "signUserId": "string"
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


### 6.3. 查询节点接口（节点管理）

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
| 1        | 群组ID       | groupId            | String |              | 是       | 节点所属群组ID                           |
| 2        | 分页大小         | pageSize        | int   |           | 是       | 默认为10|
| 3        | 分页页码         | pageNumber        | int   |           | 是       |  默认为1            |

**2）数据格式**


```
http://localhost:5002/WeBASE-Front/precompiled/consensus/list?groupId=group&pageSize=5&pageNumber=1
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

### 6.4. 设置节点共识状态接口（节点管理）

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
| 1        | 群组ID       | groupId            | String |              | 是       | 节点所属群组ID                           |
| 2        | 管理员地址       | fromAddress | String   |              | 是       |                                                |
| 3        | 节点类型       | nodeType       | String     |              |     是    | 节点类型：observer,sealer,remove |
| 4      | 节点ID         | nodeId        | String   |           | 是       |   节点id，从节点根目录/conf/node.id获取                                             |
| 5 | 签名用户Id | signUserId | String | | 是 |  |
| 6 | 权重 | weight | int | | 否 |  |

**2）数据格式**

```
{
  "fromAddress": "string",
  "groupId": "string",
  "nodeId": "string",
  "nodeType": "string",
  "signUserId": "string",
  "weight": 0
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


## 7. Abi管理接口

### 7.1. 获取Abi信息

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

### 7.2. 获取Abi信息分页列表

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
|    1     | 群组id       | groupId           | String |              |   是     |    群组编号                        |
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

### 7.3. 导入已部署合约的abi

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
| 1        | 所属群组 | groupId | String    |              | 是        |                      |
| 2        | 合约地址 | contractAddress    | String         |              | 是       |     合约地址                   |
| 3        | 合约名  | contractName      | String   |              | 是       |   |
| 4        | 合约abi  | contractAbi | List<Object>         |     |  是      | 合约的ABI |
| 5 | abi编号 | abiId | Long | |  |  |

**2）数据格式**


```
{
  "abiId": 0,
  "contractAbi": [
    {}
  ],
  "contractAddress": "string",
  "contractName": "string",
  "groupId": "string"
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

### 7.4. 修改已导入的合约abi

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
| 2        | 所属群组 | groupId | String    |              | 是        |                      |
| 3        | 合约地址 | contractAddress    | String         |              | 是       |     合约地址                   |
| 4        | 合约名  | contractName      | String   |              | 是       |   |
| 5        | 合约abi  | contractAbi | List<Object>         |     |  是      | 合约的ABI |

**2）数据格式**


```
{
  "abiId": 0,
  "contractAbi": [
    {}
  ],
  "contractAddress": "string",
  "contractName": "string",
  "groupId": "string"
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

### 7.5. 修改合约abi

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

## 8. 其他接口

### 8.1. 查询是否使用国密

#### 接口描述

获取WeBASE-Front的`encryptType`，即是否使用国密版；

#### 接口URL

[**http://localhost:5002/WeBASE-Front/{groupId}/web3/encrypt**]()

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
| 1 | 群组Id | groupId     | String |              |        |                            |

**2）数据格式**

```
http://localhost:5002/WeBASE-Front/group/web3/encrypt
```

#### 响应参数

**1）数据格式**

a、成功：

```
{
    1 // 1: 国密版，0: 非国密
}
```


### 8.2. 查询WeBASE-Front版本

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


### 8.3. 查询前置连接的WeBASE-Sign版本

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


### 8.4. 查询前置包含的solidity v0.6.10文件

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

## 9. 合约仓库

### 9.1. 获取合约仓库列表

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

### 9.2. 根据仓库编号获取仓库信息

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

### 9.3. 根据仓库编号获取合约文件夹信息

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

### 9.4. 根据合约文件夹编号获取合约文件夹信息

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

### 9.5. 根据文件夹编号获取合约列表

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

### 9.6. 根据合约编号获取合约信息

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

## 10. 证书管理


### 10.1. 查询节点证书接口

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



### 10.2. 获取明文SDK证书与私钥

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


### 10.3. 获取SDK证书与私钥压缩包

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


## 11. 附录

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

### 3.调用接口遇到问题&解决方式
Q1：合约方法入参byte32类型， java 通过HTTP+JSON调用，对应java bean 该如何对应数据类型？ 报错
```
{
    "code":201153,
    "data":null,
    "errorMessage":"unable to create instance of 	type:org.fisco.bcos.sdk.abi.datatypes.generated.Bytes32"
}
```
A1：java bean对应还是由String 存储，而非byte[]。 java工程引用如下依赖
```
<dependency>
	<groupId>org.fisco-bcos.java-sdk</groupId>
	<artifactId>fisco-bcos-java-sdk</artifactId>
	<version>2.7.2</version>
</dependency> 
```
java 代码处理
```
 String username = "hello";
 Bytes32 bytes32 = CommonUtils.utf8StringToBytes32(username);
 String bytes32Str = Numeric.toHexString(bytes32.getValue());
```

**注意**：Numeric 工具类是fisco-bcos-java-sdk 自带的，CommonUtils 是WEBASE Front 里面的