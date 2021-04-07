
# 	WeBASE-Data-Fetcher接口说明

## 1 区块链管理模块

### 1.1 全量数据概览 

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/chain/general**
- 请求方式：GET
- 返回格式：JSON

#### 请求参数

***1）入参表***

无

***2）入参示例***

```
http://localhost:5010/WeBASE-Data-Fetcher/chain/general
```

#### 返回参数 

***1）出参表***

| 序号 | 输出参数      | 类型   |      | 备注                       |
| ---- | ------------- | ------ | ---- | -------------------------- |
| 1    | code          | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message       | String | 否   | 描述                       |
| 3    | data          | object | 否   | 返回信息实体               |
| 2.1  | chainCount    | Int    | 是   | 链数量                     |
| 2.2  | groupCount    | int    | 否   | 群组数量                   |
| 2.3  | blockCount    | int    | 否   | 区块数量                   |
| 2.4  | txnCount      | int    | 否   | 交易数量                   |
| 2.5  | userCount     | int    | 否   | 用户数量                   |
| 2.6  | contractCount | int    | 否   | 合约数量                   |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": {
    "chainCount": 1,
    "groupCount": 2,
    "blockCount": 360,
    "txnCount": 360,
    "userCount": 28,
    "contractCount": 77
  }
}
```

- 失败：

```
{
   "code": 110000,
   "message": "system exception",
   "data": {}
}
```

### 1.2 查询链列表 

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/chain/all**
- 请求方式：GET
- 返回格式：JSON

#### 请求参数

***1）入参表***

无

***2）入参示例***

```
http://localhost:5010/WeBASE-Data-Fetcher/chain/all
```

#### 返回参数 

***1）出参表***

| 序号  | 输出参数    | 类型          |      | 备注                           |
| ----- | ----------- | ------------- | ---- | ------------------------------ |
| 1     | code        | Int           | 否   | 返回码，0：成功 其它：失败     |
| 2     | message     | String        | 否   | 描述                           |
| 3     | totalCount  | Int           | 否   | 总记录数                       |
| 4     | data        | List          | 否   | 组织列表                       |
| 4.1   |             | Object        |      | 信息对象                       |
| 4.1.1 | chainId     | Int           | 否   | 链编号                         |
| 4.1.2 | chainName   | String        | 否   | 链名称                         |
| 4.1.3 | chainType   | Int           | 否   | 链类型（ 0-fisco 1-fabric）    |
| 4.1.4 | encryptType | Int           | 否   | 链加密类型（0-非国密，1-国密） |
| 4.1.5 | description | String        | 是   | 备注                           |
| 4.1.6 | createTime  | LocalDateTime | 否   | 落库时间                       |
| 4.1.7 | modifyTime  | LocalDateTime | 否   | 修改时间                       |

***2）出参示例***

- 成功：

```
{
    "code": 0,
    "message": "success",
    "data": [
        {
        "chainId": 1,
        "chainName": "链一",
        "chainType": 0,
        "encryptType": 0,
        "description": "test"
        "createTime": "2019-02-14 17:47:00",
        "modifyTime": "2019-03-15 11:14:29"
    	}
    ],
    "totalCount": 1
}
```

- 失败：

```
{
   "code": 110000,
   "message": "system exception",
   "data": {}
}
```

## 2 群组管理模块

### 2.1 查询群组列表

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/group/list**
- 请求方式：GET
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型 | 可为空 | 备注   |
| ---- | -------- | ---- | ------ | ------ |
| 1    | chainId  | Int  | 是     | 链编号 |

***2）入参示例***

```
http://localhost:5010/WeBASE-Data-Fetcher/group/list?chainId=1
```

#### 返回参数 

***1）出参表***

| 序号   | 输出参数         | 类型          |      | 备注                       |
| ------ | ---------------- | ------------- | ---- | -------------------------- |
| 1      | code             | Int           | 否   | 返回码，0：成功 其它：失败 |
| 2      | message          | String        | 否   | 描述                       |
| 3      | totalCount       | Int           | 否   | 总记录数                   |
| 4      | data             | List          | 否   | 列表                       |
| 4.1    |                  | Object        |      | 信息对象                   |
| 4.1.1  | chainId          | Int           | 否   | 链编号                     |
| 4.1.2  | groupId          | Int           | 否   | 群组编号                   |
| 4.1.3  | appName          | String        | 否   | 应用名称                   |
| 4.1.4  | appVersion       | String        | 是   | 应用版本号                 |
| 4.1.5  | appSummary       | String        | 是   | 应用概要介绍               |
| 4.1.6  | genesisBlockHash | String        | 否   | 创世块hash                 |
| 4.1.7  | groupStatus      | Int           | 否   | 群组状态                   |
| 4.1.8  | nodeCount        | Int           | 否   | 节点个数                   |
| 4.1.9  | description      | String        | 否   | 应用描述                   |
| 4.1.10 | createTime       | LocalDateTime | 否   | 落库时间                   |
| 4.1.11 | modifyTime       | LocalDateTime | 否   | 修改时间                   |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "chainId": 1,
      "groupId": 1,
      "appName": "APP1",
      "appVersion": "v1.0.0",
      "appSummary": "存证",
      "genesisBlockHash": "0x7bc361d7d8e078ea9e8f352f2b856d6ea76ab1b9522f4b09853c861d0ed0779f",
      "groupStatus": 1,
      "nodeCount": 2,
      "description": "test",
      "createTime": "2020-05-20 20:22:35",
      "modifyTime": "2020-05-20 20:31:38"
    },
    {
      "chainId": 1,
      "groupId": 2,
      "appName": "APP2",
      "appVersion": "v1.0.0",
      "appSummary": "供应链",
      "genesisBlockHash": "0x1208de0d47dcba9447d304039d1e4512dd4ce740ec408ef83c5f7ee2aefc7468",
      "groupStatus": 1,
      "nodeCount": 2,
      "description": "test",
      "createTime": "2020-05-20 20:22:36",
      "modifyTime": "2020-05-20 20:31:38"
    }
  ],
  "totalCount": 2
}
```

- 失败：

```
{
    "code": 110000,
    "message": "system exception",
    "data": {}
}
```

### 2.2 查询群组概况

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/group/general/{chainId}/{groupId}**
- 请求方式：GET
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型 | 可为空 | 备注   |
| ---- | -------- | ---- | ------ | ------ |
| 1    | chainId  | Int  | 否     | 链编号 |
| 2    | groupId  | int  | 否     | 群组id |

***2）入参示例***

```
http://localhost:5010/WeBASE-Data-Fetcher/group/general/1/1
```

#### 返回参数 

***1）出参表***

| 序号 | 输出参数      | 类型   |      | 备注                       |
| ---- | ------------- | ------ | ---- | -------------------------- |
| 1    | code          | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message       | String | 否   | 描述                       |
| 3    | data          | object | 否   | 返回信息实体               |
| 2.1  | chainId       | Int    | 是   | 链编号                     |
| 2.2  | groupId       | int    | 否   | 群组id                     |
| 2.3  | nodeCount     | int    | 否   | 节点数量                   |
| 2.4  | userCount     | int    | 否   | 用户数量                   |
| 2.5  | contractCount | int    | 否   | 已部署智能合约数量         |
| 2.6  | txnCount      | int    | 否   | 交易数量                   |
| 2.7  | blockNumber   | int    | 否   | 当前块高                   |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": {
    "chainId": 1,
    "groupId": 1,
    "nodeCount": 3,
    "userCount": 22,
    "contractCount": 58,
    "txnCount": 237,
    "blockNumber": 237
  }
}
```

- 失败：

```
{
    "code": 110000,
    "message": "system exception",
    "data": {}
}
```

### 2.3 查询近七日交易数据

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/group/txnDaily/{chainId}/{groupId}**
- 请求方式：GET
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型 | 可为空 | 备注   |
| ---- | -------- | ---- | ------ | ------ |
| 1    | chainId  | Int  | 否     | 链编号 |
| 2    | groupId  | int  | 否     | 群组id |

***2）入参示例***

```
http://localhost:5010/WeBASE-Data-Fetcher/group/txnDaily/1/1
```

#### 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data     | list   | 否   | 返回信息列表               |
| 4    |          | object |      | 返回信息实体               |
| 4.1  | statDate | string | 否   | 日期YYYY-MM-DD             |
| 4.2  | chainId  | Int    | 是   | 链编号                     |
| 4.3  | groupId  | int    | 否   | 群组编号                   |
| 4.4  | txn      | int    | 否   | 交易数量                   |

***2）出参示例***

- 成功：

```
{
    "code": 0,
    "data": [
        {
            "statDate": "2018-11-22",
            "chainId": "1",
            "groupId": "1",
            "txn": 10
        },
        {
            "statDate": "2018-11-21",
            "chainId": "1",
            "groupId": "1",
            "txn": 5
        }
    ],
    "message": "Success"
}
```

- 失败：

```
{
    "code": 110000,
    "message": "system exception",
    "data": {}
}
```

### 2.4 查询群组节点列表

#### 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址：**/group/nodeList/{chainId}/{groupId}/{pageNumber}/{pageSize}**
- 请求方式：GET
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型 | 可为空 | 备注       |
| ---- | ---------- | ---- | ------ | ---------- |
| 1    | chainId    | int  | 否     | 链编号     |
| 2    | groupId    | int  | 否     | 群组编号   |
| 3    | pageSize   | Int  | 否     | 每页记录数 |
| 4    | pageNumber | Int  | 否     | 当前页码   |

***2）入参示例***

```
http://localhost:5010/WeBASE-Data-Fetcher/group/nodeList/100001/300001/1/10
```

#### 返回参数 

***1）出参表***

| 序号   | 输出参数    | 类型          |      | 备注                       |
| ------ | ----------- | ------------- | ---- | -------------------------- |
| 1      | code        | Int           | 否   | 返回码，0：成功 其它：失败 |
| 2      | message     | String        | 否   | 描述                       |
| 3      | totalCount  | Int           | 否   | 总记录数                   |
| 4      | data        | List          | 是   | 节点列表                   |
| 4.1    |             | Object        |      | 信息对象                   |
| 4.1.1  | chainId     | int           | 否   | 链编号                     |
| 4.1.2  | nodeId      | String        | 否   | 节点编号                   |
| 4.1.3  | nodeName    | string        | 否   | 节点名称                   |
| 4.1.4  | groupId     | int           | 否   | 所属群组编号               |
| 4.1.5  | orgName     | string        | 是   | 机构名称                   |
| 4.1.6  | nodeActive  | int           | 否   | 共识状态（1正常，2不正常） |
| 4.1.7  | nodeIp      | string        | 是   | 节点ip                     |
| 4.1.8  | P2pPort     | int           | 是   | 节点p2p端口                |
| 4.1.9  | description | String        | 是   | 备注                       |
| 4.1.10 | blockNumber | BigInteger    | 否   | 节点块高                   |
| 4.1.11 | pbftView    | BigInteger    | 否   | Pbft view                  |
| 4.1.12 | createTime  | LocalDateTime | 否   | 落库时间                   |
| 4.1.13 | modifyTime  | LocalDateTime | 否   | 修改时间                   |

***2）出参示例***

- 成功：

```
{
    "code": 0,
    "message": "success",
    "totalCount": 1,
    "data": [
        {
            "chainId": 100001,
            "nodeId": "78e467957af3d0f77e19b952a740ba8c53ac76913df7dbd48d7a0fe27f4c902b55e8543e1c4f65b4a61695c3b490a5e8584149809f66e9ffc8c05b427e9d3ca2,
            "nodeName": "1_78e467957af3d0f77e19b952a740ba8c53ac76913df7dbd48d7a0fe27f4c902b55e8543e1c4f65b4a61695c3b490a5e8584149809f66e9ffc8c05b",
            "groupId": 1,
            "orgName": "org",
            "nodeIp": "127.0.0.1",
            "p2pPort": 10303,
            "description": null,
            "blockNumber": 133,
            "pbftView": 5852,
            "nodeActive": 1,
            "createTime": "2019-02-14 17:47:00",
            "modifyTime": "2019-03-15 11:14:29"
        }
    ]
}
```

- 失败：

```
{
    "code": 110000,
    "message": "system exception",
    "data": {}
}
```

### 2.5 查询机构节点列表

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/group/orgList/{chainId}/{pageNumber}/{pageSize}**
- 请求方式：GET
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型 | 可为空 | 备注       |
| ---- | ---------- | ---- | ------ | ---------- |
| 1    | chainId    | int  | 否     | 链编号     |
| 2    | pageSize   | Int  | 否     | 每页记录数 |
| 3    | pageNumber | Int  | 否     | 当前页码   |

***2）入参示例***

```
http://localhost:5010/WeBASE-Data-Fetcher/group/orgList/100001/1/10
```

#### 返回参数 

***1）出参表***

| 序号  | 输出参数    | 类型   |      | 备注                       |
| ----- | ----------- | ------ | ---- | -------------------------- |
| 1     | code        | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2     | message     | String | 否   | 描述                       |
| 3     | totalCount  | Int    | 否   | 总记录数                   |
| 4     | data        | List   | 是   | 节点列表                   |
| 4.1   |             | Object |      | 信息对象                   |
| 4.1.1 | chainId     | Int    | 否   | 链编号                     |
| 4.1.2 | nodeId      | String | 否   | 节点编号                   |
| 4.1.3 | orgName     | String | 是   | 机构名称                   |
| 4.1.4 | description | String | 是   | 备注                       |

***2）出参示例***

- 成功：

```
{
    "code": 0,
    "message": "success",
    "totalCount": 1,
    "data": [
        {
            "chainId": 100001,
            "nodeId": "78e467957af3d0f77e19b952a740ba8c53ac76913df7dbd48d7a0fe27f4c902b55e8543e1c4f65b4a61695c3b490a5e8584149809f66e9ffc8c05b427e9d3ca2,
            "orgName": "org",
            "description": "test"
        }
    ]
}
```

- 失败：

```
{
    "code": 110000,
    "message": "system exception",
    "data": {}
}
```

### 2.6 查询区块列表

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/group/blockList/{chainId}/{groupId}/{pageNumber}/{pageSize}}?blockHash={blockHash}&blockNumber={blockNumber}**
- 请求方式：GET
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型       | 可为空 | 备注       |
| ---- | ----------- | ---------- | ------ | ---------- |
| 1    | chainId     | Int        | 否     | 链编号     |
| 2    | groupId     | Int        | 否     | 群组编号   |
| 3    | pageSize    | Int        | 否     | 每页记录数 |
| 4    | pageNumber  | Int        | 否     | 当前页码   |
| 5    | blockHash   | String     | 是     | 区块hash   |
| 6    | blockNumber | BigInteger | 是     | 块高       |

***2）入参示例***

```
http://localhost:5010/WeBASE-Data-Fetcher/group/blockList/1/1/1/2?blockHash=
```

#### 返回参数 

***1）出参表***

| 序号  | 输出参数       | 类型          |      | 备注                       |
| ----- | -------------- | ------------- | ---- | -------------------------- |
| 1     | code           | Int           | 否   | 返回码，0：成功 其它：失败 |
| 2     | message        | String        | 否   | 描述                       |
| 3     | totalCount     | Int           | 否   | 总记录数                   |
| 4     | data           | List          | 是   | 区块列表                   |
| 4.1   |                | Object        |      | 区块信息对象               |
| 4.1.1 | blockHash      | String        | 否   | 块hash                     |
| 4.1.2 | blockNumber    | BigInteger    | 否   | 块高                       |
| 4.1.3 | blockTimestamp | LocalDateTime | 否   | 出块时间                   |
| 4.1.4 | transCount     | Int           | 否   | 交易数                     |
| 4.1.5 | sealerIndex    | Int           | 否   | 打包节点索引               |
| 4.1.6 | sealer         | String        | 否   | 打包节点                   |
| 4.1.7 | blockDetail    | String        | 否   | 区块详情                   |
| 4.1.8 | createTime     | LocalDateTime | 否   | 创建时间                   |
| 4.1.9 | modifyTime     | LocalDateTime | 否   | 修改时间                   |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "id": 26,
      "blockHash": "0x1d0a57a6ee2b73e537ef6d929c8d0bdb2a9799dd6357f04dc5f38e4e0c6c5ac2",
      "blockNumber": 35,
      "blockTimestamp": "2020-05-13 19:47:37",
      "transCount": 1,
      "sealerIndex": 0,
      "sealer": "944607f7e83efe2ba72476dc39a269a910811db8caac34f440dd9c9dd8ec2490b8854b903bd6c9b95c2c79909649977b8e92097c2f3ec32232c4f655b5a01850",
      "blockDetail": "",
      "createTime": "2020-05-20 20:22:41",
      "modifyTime": "2020-05-20 20:22:41"
    },
    {
      "id": 8,
      "blockHash": "0x4c29bb921f4bf346ad1f92704e225f6323c85f16f2fa4eb0e3f126355ff9fa12",
      "blockNumber": 34,
      "blockTimestamp": "2020-05-13 19:12:20",
      "transCount": 1,
      "sealerIndex": 0,
      "sealer": "944607f7e83efe2ba72476dc39a269a910811db8caac34f440dd9c9dd8ec2490b8854b903bd6c9b95c2c79909649977b8e92097c2f3ec32232c4f655b5a01850",
      "blockDetail": "",
      "createTime": "2020-05-20 20:22:41",
      "modifyTime": "2020-05-20 20:22:41"
    }
  ],
  "totalCount": 36
}
```

- 失败：

```
{
    "code": 110000,
    "message": "system exception",
    "data": {}
}
```


### 2.7 查询交易列表

#### 传输协议

* 网络传输协议：使用HTTP协议
* 请求地址：
```
/group/transList/{chainId}/{groupId}/{pageNumber}/{pageSize}?transHash={transHash}&blockNumber={blockNumber}
```
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 可为空 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1 | chainId | Int | 否 | 链编号 |
| 2     | groupId         | Int           | 否     | 群组编号               |
| 3 | pageNumber | Int | 否 | 当前页码 |
| 4 | pageSize | Int | 否 | 每页记录数 |
| 5     | transHash   | String        | 是     | 交易hash                   |
| 6     | blockNumber     | BigInteger    | 是     | 块高                       |


***2）入参示例***

```
http://localhost:5010/WeBASE-Data-Fetcher/group/transList/1/1/1/2?transHash=0x4933b1e0a7d6913a2179b879cdf716096d8da1c162fe400a492b0d61259e2ab2
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | code            | Int           | 否     | 返回码，0：成功 其它：失败 |
| 2     | message         | String        | 否     | 描述                       |
| 3     | totalCount      | Int           | 否     | 总记录数                   |
| 4     | data            | List          | 否     | 交易信息列表               |
| 4.1   |                 | Object        |        | 交易信息对象               |
| 4.1.1 | transHash       | String        | 否     | 交易hash                   |
| 4.1.2 | blockNumber    | BigInteger    | 否   | 所属块高                         |
| 4.1.3 | blockTimestamp | LocalDateTime | 否   | 所属块出块时间                   |
| 4.1.4 | transDetail | String | 否     | 交易详情                 |
| 4.1.5 | receiptDetail  | String | 否 | 交易回执详情 |
| 4.1.6 | auditFlag | Int           | 否     | 是否已统计（1-未审计，2-已审计） |
| 4.1.7 | createTime      | LocalDateTime | 否     | 落库时间                   |
| 4.1.8 | modifyTime      | LocalDateTime | 否     | 修改时间                   |


***2）出参示例***
* 成功：
```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "id": 26,
      "transHash": "0x4933b1e0a7d6913a2179b879cdf716096d8da1c162fe400a492b0d61259e2ab2",
      "blockNumber": 35,
      "blockTimestamp": "2020-05-13 19:47:37",
      "transDetail": "{}",
      "receiptDetail": "{}",
      "auditFlag": 1,
      "createTime": "2020-05-20 20:22:41",
      "modifyTime": "2020-05-20 20:22:41"
    }
  ],
  "totalCount": 1
}
```

* 失败：
```
{
    "code": 110000,
    "message": "system exception",
    "data": {}
}
```

### 2.8 查询用户列表 

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/group/userList/{chainId}/{groupId}/{pageNumber}/{pageSize}?userParam={userParam}**
- 请求方式：GET
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型   | 可为空 | 备注               |
| ---- | ---------- | ------ | ------ | ------------------ |
| 1    | pageNumber | Int    | 否     | 当前页码           |
| 2    | pageSize   | Int    | 否     | 每页记录数         |
| 3    | chainId    | Int    | 否     | 链编号             |
| 4    | groupId    | Int    | 否     | 群组编号           |
| 5    | userParam  | String | 是     | 参数，用户名或地址 |

***2）入参示例***

```
http://localhost:5010/WeBASE-Data-Fetcher/group/userList/1/1/1/2
```

#### 返回参数 

***1）出参表***

| 序号  | 输出参数    | 类型   |      | 备注                       |
| ----- | ----------- | ------ | ---- | -------------------------- |
| 1     | code        | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2     | message     | String | 否   | 描述                       |
| 3     | totalCount  | Int    | 否   | 总记录数                   |
| 4     | data        | List   | 否   | 列表                       |
| 4.1   |             | Object |      | 对象                       |
| 4.1.1 | userName    | String | 否   | 用户名                     |
| 4.1.2 | userAddress | String | 否   | 用户地址                   |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "userName": "alice",
      "userAddress": "0x056a6b8bd27e861773ec2419a871ff245291a2d6"
    }
  ],
  "totalCount": 1
}
```

- 失败：

```
{
   "code": 110000,
   "message": "system exception",
   "data": {}
}
```

### 2.9 查询合约列表 

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/group/contractList/{chainId}/{groupId}/{pageNumber}/{pageSize}?contractParam={contractParam}**
- 请求方式：GET
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数      | 类型   | 可为空 | 备注         |
| ---- | ------------- | ------ | ------ | ------------ |
| 1    | chainId       | Int    | 否     | 链编号       |
| 2    | groupId       | Int    | 否     | 群组id       |
| 3    | pageSize      | Int    | 是     | 每页记录数   |
| 4    | pageNumber    | Int    | 是     | 当前页码     |
| 5    | contractParam | String | 是     | 合约名或地址 |

***2）入参示例***

```
http://localhost:5010/WeBASE-Data-Fetcher/group/contractList/1/1/1/2
```

#### 返回参数 

***1）出参表***

| 序号  | 输出参数        | 类型   |      | 备注                       |
| ----- | --------------- | ------ | ---- | -------------------------- |
| 1     | code            | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2     | message         | String | 否   | 描述                       |
| 3     | totalCount      | Int    | 否   | 总记录数                   |
| 4     | data            | List   | 是   | 列表                       |
| 5.1   |                 | Object |      | 返回信息实体               |
| 5.1.1 | contractName    | String | 否   | 合约名称                   |
| 5.1.2 | contractAddress | String | 否   | 合约地址                   |
| 5.1.3 | contractAbi     | String | 是   | 合约abi文件内容            |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "contractName": "ConsensusPrecompiled",
      "contractAddress": "0x0000000000000000000000000000000000001003",
      "contractAbi": "[{\"constant\":false,\"inputs\":[{\"name\":\"nodeID\",\"type\":\"string\"}],\"name\":\"addObserver\",\"outputs\":[{\"name\":\"\",\"type\":\"int256\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"nodeID\",\"type\":\"string\"}],\"name\":\"remove\",\"outputs\":[{\"name\":\"\",\"type\":\"int256\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"nodeID\",\"type\":\"string\"}],\"name\":\"addSealer\",\"outputs\":[{\"name\":\"\",\"type\":\"int256\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"}]"
    }
  ],
  "totalCount": 1
}
```

- 失败：

```
{
    "code": 110000,
    "message": "system exception",
    "data": {}
}
```

## 3 数据检索模块

### 3.1 普通检索

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/search/normal**
- 请求方式：POST
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数      | 类型   | 可为空 | 备注                                     |
| ---- | ------------- | ------ | ------ | ---------------------------------------- |
| 1    | chainId       | Int    | 否     | 链编号                                   |
| 2    | groupId       | Int    | 否     | 群组编号                                 |
| 3    | pageSize      | Int    | 否     | 每页记录数                               |
| 4    | pageNumber    | Int    | 否     | 当前页码                                 |
| 5    | searchType    | Int    | 否     | 检索类型：1-区块；2-交易；3-用户；4-合约 |
| 6    | blockParam    | String | 是     | 块高或区块Hash，检索类型为1时必填        |
| 7    | transHash     | String | 是     | 交易Hash，检索类型为2时必填              |
| 8    | userParam     | String | 是     | 用户名称或地址，检索类型为3时必填        |
| 9    | contractParam | String | 是     | 合约名称或地址，检索类型为4时必填        |

***2）入参示例***

```
http://localhost:5010/WeBASE-Data-Fetcher/search/normal
```

```
{
    "chainId": 1,
    "groupId": 1,
    "pageSize": 1,
    "pageNumber": 1,
    "searchType": 2,
    "transHash": "0x16dafe7f879f13d5fca6046e87022cdf71c9076b90c90b12403b82e1b68d3a22"
}
```

#### 返回参数 

***1）出参表***

| 序号   | 输出参数        | 类型          |      | 备注                                         |
| ------ | --------------- | ------------- | ---- | -------------------------------------------- |
| 1      | code            | Int           | 否   | 返回码，0：成功 其它：失败                   |
| 2      | message         | String        | 否   | 描述                                         |
| 3      | totalCount      | Int           | 否   | 总记录数                                     |
| 4      | data            | List          | 是   | 区块列表                                     |
| 4.1    |                 | Object        |      | 区块信息对象                                 |
| 4.1.1  | transHash       | String        | 否   | 块hash                                       |
| 4.1.2  | blockNumber     | BigInteger    | 否   | 块高                                         |
| 4.1.3  | blockTimestamp  | LocalDateTime | 否   | 出块时间                                     |
| 4.1.4  | userName        | String        | 否   | 用户名称                                     |
| 4.1.5  | userAddress     | String        | 否   | 用户地址                                     |
| 4.1.6  | userType        | Int           | 否   | 用户类型(0-正常，1-异常)                     |
| 4.1.7  | contractName    | String        | 否   | 合约名称                                     |
| 4.1.8  | contractAddress | String        | 否   | 合约地址                                     |
| 4.1.9  | interfaceName   | String        | 否   | 合约接口名                                   |
| 4.1.10 | transType       | Int           | 否   | 交易类型(0-合约部署，1-接口调用)             |
| 4.1.11 | transParserType | Int           | 否   | 交易解析类型(0-正常，1-异常合约，2-异常接口) |
| 4.1.12 | input           | String        | 是   | 交易输入信息                                 |
| 4.1.13 | output          | String        | 是   | 交易输出信息                                 |
| 4.1.14 | logs            | String        | 是   | 交易event信息                                |
| 4.1.15 | transDetail     | String        | 是   | 交易详情                                     |
| 4.1.16 | receiptDetail   | String        | 是   | 交易回执详情                                 |
| 4.1.17 | createTime      | LocalDateTime | 否   | 创建时间                                     |
| 4.1.18 | modifyTime      | LocalDateTime | 否   | 修改时间                                     |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "transHash": "0x16dafe7f879f13d5fca6046e87022cdf71c9076b90c90b12403b82e1b68d3a22",
      "blockNumber": 35,
      "blockTimestamp": "2020-05-13 19:47:37",
      "userName": "alice",
      "userAddress": "0x7939e26070be44e6c4fc759ce55c6c8b166d94be",
      "userType": 0,
      "contractName": "HelloWorld",
      "contractAddress": "0x970d7d42726e8f1069f6d9aa0aca10e950fcebf9",
      "interfaceName": "set(string)",
      "transType": 1,
      "transParserType": 0,
      "input":"[{\"name\":\"n\",\"type\":\"string\",\"data\":\"test\"}]",
      "output":"",
      "logs":"{\"SetName(string)\":[[{\"name\":\"name\",\"type\":\"string\",\"data\":\"test\",\"indexed\":false}]]}",
      "transDetail":"{}",
      "receiptDetail":"{}",
      "createTime": "2020-05-20 20:22:41",
      "modifyTime": "2020-05-20 20:22:41"
    }
  ],
  "totalCount": 1
}
```

- 失败：

```
{
    "code": 110000,
    "message": "system exception",
    "data": {}
}
```

### 3.2 关键字检索

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/search/keyword/{pageNumber}/{pageSize}?keyword={keyword}**
- 请求方式：GET
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型   | 可为空 | 备注           |
| ---- | ---------- | ------ | ------ | -------------- |
| 1    | pageSize   | Int    | 否     | 每页记录数     |
| 2    | pageNumber | Int    | 否     | 当前页码       |
| 3    | keyword    | String | 否     | 要检索的关键字 |

***2）入参示例***

```
http://localhost:5010/WeBASE-Data-Fetcher/search/keyword/1/2?keyword="测试"
```

#### 返回参数 

***1）出参表***

| 序号   | 输出参数        | 类型          |      | 备注                                         |
| ------ | --------------- | ------------- | ---- | -------------------------------------------- |
| 1      | code            | Int           | 否   | 返回码，0：成功 其它：失败                   |
| 2      | message         | String        | 否   | 描述                                         |
| 3      | totalCount      | Int           | 否   | 总记录数                                     |
| 4      | data            | List          | 是   | 区块列表                                     |
| 4.1    |                 | Object        |      | 区块信息对象                                 |
| 4.1.1  | transHash       | String        | 否   | 块hash                                       |
| 4.1.2  | blockNumber     | BigInteger    | 否   | 块高                                         |
| 4.1.3  | blockTimestamp  | LocalDateTime | 否   | 出块时间                                     |
| 4.1.4  | userName        | String        | 否   | 用户名称                                     |
| 4.1.5  | userAddress     | String        | 否   | 用户地址                                     |
| 4.1.6  | userType        | Int           | 否   | 用户类型(0-正常，1-异常)                     |
| 4.1.7  | contractName    | String        | 否   | 合约名称                                     |
| 4.1.8  | contractAddress | String        | 否   | 合约地址                                     |
| 4.1.9  | interfaceName   | String        | 否   | 合约接口名                                   |
| 4.1.10 | transType       | Int           | 否   | 交易类型(0-合约部署，1-接口调用)             |
| 4.1.11 | transParserType | Int           | 否   | 交易解析类型(0-正常，1-异常合约，2-异常接口) |
| 4.1.12 | input           | String        | 是   | 交易输入信息                                 |
| 4.1.13 | output          | String        | 是   | 交易输出信息                                 |
| 4.1.14 | logs            | String        | 是   | 交易event信息                                |
| 4.1.15 | chainId         | Int           | 否   | 链编号                                       |
| 4.1.16 | groupId         | Int           | 否   | 群组编号                                     |
| 4.1.17 | createTime      | LocalDateTime | 否   | 创建时间                                     |
| 4.1.18 | modifyTime      | LocalDateTime | 否   | 修改时间                                     |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "transParserType": 0,
      "transHash": "0xd33a6343ecee98cd6804456d34299d893258e5e3ebc2b8d6d57dc1fdc9a34b43",
      "groupId": 1,
      "contractAddress": "0x513657158171fc69017b52ea997bdf49cd0260ba",
      "userName": "bob",
      "userAddress": "0x7939e26070be44e6c4fc759ce55c6c8b166d94be",
      "output": null,
      "input": "[{\"name\":\"n\",\"type\":\"string\",\"data\":\"试验\"}]",
      "modifyTime": "2020-07-14 17:51:26",
      "transType": 1,
      "chainId": 1,
      "createTime": "2020-07-14 17:51:26",
      "blockNumber": 312,
      "contractName": "HelloWorld",
      "blockTimestamp": "2020-07-14 17:51:12",
      "id": 312,
      "userType": 0,
      "interfaceName": "set(string)",
      "logs": "{\"SetName(string)\":[[{\"name\":\"name\",\"type\":\"string\",\"data\":\"试验\",\"indexed\":false}]]}"
    }
  ],
  "totalCount": 1
}
```

- 失败：

```
{
    "code": 110000,
    "message": "system exception",
    "data": {}
}
```

## 4 关键字管理模块

### 4.1 新增关键字

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址： **/keywords/add**
- 请求方式：POST
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型   | 可为空 | 备注   |
| ---- | -------- | ------ | ------ | ------ |
| 1    | keyword  | String | 否     | 关键字 |

***2）入参示例***

```
http://localhost:5010/WeBASE-Data-Fetcher/keywords/add
```

```
{
  "keyword": "禽流感"
}
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数   | 类型          | 可为空 | 备注                       |
| ---- | ---------- | ------------- | ------ | -------------------------- |
| 1    | code       | Int           | 否     | 返回码，0：成功 其它：失败 |
| 2    | message    | String        | 否     | 描述                       |
| 3    | data       | Object        |        | 信息对象                   |
| 3.1  | id         | Int           | 否     | 编号                       |
| 3.2  | keyword    | String        | 否     | 关键字                     |
| 3.3  | createTime | LocalDateTime | 是     | 落库时间                   |
| 3.2  | modifyTime | LocalDateTime | 是     | 修改时间                   |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": {
    "id": 1,
    "keyword": "禽流感",
    "createTime": "2020-07-30 20:14:38",
    "modifyTime": "2020-07-30 20:14:38"
  }
}
```

- 失败：

```
{
    "code": 110000,
    "message": "system exception",
    "data": {}
}
```

### 4.2 获取关键字列表 

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/keywords/list/{pageNumber}/{pageSize}**
- 请求方式：GET
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型 | 可为空 | 备注       |
| ---- | ---------- | ---- | ------ | ---------- |
| 1    | pageNumber | Int  | 否     | 当前页码   |
| 2    | pageSize   | Int  | 否     | 每页记录数 |

***2）入参示例***

```
http://localhost:5010/WeBASE-Data-Fetcher/keywords/list/1/2
```

#### 返回参数 

***1）出参表***

| 序号  | 输出参数   | 类型          |      | 备注                       |
| ----- | ---------- | ------------- | ---- | -------------------------- |
| 1     | code       | Int           | 否   | 返回码，0：成功 其它：失败 |
| 2     | message    | String        | 否   | 描述                       |
| 3     | totalCount | Int           | 否   | 总记录数                   |
| 4     | data       | List          | 否   | 列表                       |
| 4.1   |            | Object        |      | 对象                       |
| 4.1.1 | id         | Int           | 否   | 编号                       |
| 4.1.2 | keyword    | String        | 否   | 关键字                     |
| 4.1.3 | createTime | LocalDateTime | 否   | 落库时间                   |
| 4.1.4 | modifyTime | LocalDateTime | 否   | 修改时间                   |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "id": 1,
      "keyword": "禽流感",
      "createTime": "2020-07-30 20:14:38",
      "modifyTime": "2020-07-30 20:14:38"
    }
  ],
  "totalCount": 1
}
```

- 失败：

```
{
   "code": 110000,
   "message": "system exception",
   "data": {}
}
```

### 4.3 修改关键字

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址： **/keywords/update**
- 请求方式：POST
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型   | 可为空 | 备注       |
| ---- | -------- | ------ | ------ | ---------- |
| 1    | id       | Int    | 否     | 关键字编号 |
| 2    | keyword  | String | 否     | 关键字     |

***2）入参示例***

```
http://localhost:5010/WeBASE-Data-Fetcher/keywords/update
```

```
{
    "id": 1,
    "keyword": "冠状病毒"
}
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数   | 类型          | 可为空 | 备注                       |
| ---- | ---------- | ------------- | ------ | -------------------------- |
| 1    | code       | Int           | 否     | 返回码，0：成功 其它：失败 |
| 2    | message    | String        | 否     | 描述                       |
| 3    | data       | Object        |        | 信息对象                   |
| 3.1  | id         | Int           | 否     | 编号                       |
| 3.2  | keyword    | String        | 否     | 关键字                     |
| 3.3  | createTime | LocalDateTime | 是     | 落库时间                   |
| 3.2  | modifyTime | LocalDateTime | 是     | 修改时间                   |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": {
    "id": 1,
    "keyword": "冠状病毒",
    "createTime": "2020-07-30 20:14:38",
    "modifyTime": "2020-07-30 20:15:35"
  }
}
```

- 失败：

```
{
    "code": 110000,
    "message": "system exception",
    "data": {}
}
```

### 4.4 删除关键字

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/keywords/{id}**
- 请求方式：DELETE
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型 | 可为空 | 备注       |
| ---- | -------- | ---- | ------ | ---------- |
| 1    | id       | Int  | 否     | 关键字编号 |

***2）入参示例***

```
http://localhost:5010/WeBASE-Data-Fetcher/keywords/1
```

#### 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data     | object | 是   | 返回信息实体（空）         |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": null
}
```

- 失败：

```
{
    "code": 110000,
    "message": "system exception",
    "data": {}
}
```

## 5 交易告警信息管理模块

### 5.1 新增告警信息

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址： **/transAudit/add**
- 请求方式：POST
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数  | 类型   | 可为空 | 备注                              |
| ---- | --------- | ------ | ------ | --------------------------------- |
| 1    | chainId   | Int    | 否     | 链编号                            |
| 2    | groupId   | Int    | 否     | 群组编号                          |
| 3    | type      | Int    | 否     | 信息来源类型，1-关键字 2-交易列表 |
| 4    | keyword   | String | 是     | 关键字，type为1是必填             |
| 5    | comment   | String | 否     | 监管意见                          |
| 6    | txHash    | String | 否     | 交易hash                          |
| 7    | address   | String | 否     | 用户地址                          |
| 8    | chainName | String | 是     | 链名称                            |
| 9    | appName   | String | 是     | 应用名称                          |

***2）入参示例***

```
http://localhost:5010/WeBASE-Data-Fetcher/transAudit/add
```

```
{
  "chainId": 1,
  "groupId": 1,
  "type": 1,
  "keyword": "禽流感",
  "comment": "停止售卖",
  "txHash": "0x8e8b15e87f09e35f4ce811fb61b0bbd730eab0cfe63a350e2bab6f7a2bfe36b0",
  "address": "0xd0332a67b2136ff5767c9ee7b775be83950da59c",
  "chainName": "存证链",
  "appName": "文件存证"
}
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数   | 类型          |      | 备注                              |
| ---- | ---------- | ------------- | ---- | --------------------------------- |
| 1    | code       | Int           | 否   | 返回码，0：成功 其它：失败        |
| 2    | message    | String        | 否   | 描述                              |
| 3    | data       | Object        |      | 信息对象                          |
| 3.1  | id         | Int           | 否   | 编号                              |
| 3.2  | chainId    | Int           | 否   | 链编号                            |
| 3.3  | groupId    | Int           | 否   | 群组编号                          |
| 3.4  | type       | Int           | 否   | 信息来源类型，1-关键字 2-交易列表 |
| 3.5  | keyword    | String        | 否   | 关键字                            |
| 3.6  | comment    | String        | 否   | 监管意见                          |
| 3.7  | txHash     | String        | 否   | 交易hash                          |
| 3.8  | address    | String        | 否   | 用户地址                          |
| 3.9  | status     | Int           | 否   | 状态（1-未处理， 2-已处理）       |
| 3.10 | chainName  | String        | 是   | 链名称                            |
| 3.11 | appName    | String        | 是   | 应用名称                          |
| 3.12 | createTime | LocalDateTime | 否   | 落库时间                          |
| 3.13 | modifyTime | LocalDateTime | 否   | 修改时间                          |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": {
    "id": 1,
    "chainId": 1,
    "groupId": 1,
    "type": 1,
    "keyword": "禽流感",
    "comment": "停止售卖",
    "txHash": "0x8e8b15e87f09e35f4ce811fb61b0bbd730eab0cfe63a350e2bab6f7a2bfe36b0",
    "address": "0xd0332a67b2136ff5767c9ee7b775be83950da59c",
    "status": 1,
    "chainName": "存证链",
    "appName": "文件存证",
    "createTime": "2020-07-30 20:19:39",
    "modifyTime": "2020-07-30 20:19:39"
  }
}
```

- 失败：

```
{
    "code": 110000,
    "message": "system exception",
    "data": {}
}
```

### 5.2 获取告警信息列表 

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/transAudit/list/{pageNumber}/{pageSize}?status={status}&chainId={chainId}&groupId={groupId}**
- 请求方式：GET
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型 | 可为空 | 备注                        |
| ---- | ---------- | ---- | ------ | --------------------------- |
| 1    | pageNumber | Int  | 否     | 当前页码                    |
| 2    | pageSize   | Int  | 否     | 每页记录数                  |
| 3    | status     | Int  | 是     | 状态（1-未处理， 2-已处理） |
| 4    | chainId    | Int  | 是     | 链编号                      |
| 5    | groupId    | Int  | 是     | 群组编号                    |

***2）入参示例***

```
http://localhost:5010/WeBASE-Data-Fetcher/transAudit/list/1/2
```

#### 返回参数 

***1）出参表***

| 序号   | 输出参数   | 类型          |      | 备注                              |
| ------ | ---------- | ------------- | ---- | --------------------------------- |
| 1      | code       | Int           | 否   | 返回码，0：成功 其它：失败        |
| 2      | message    | String        | 否   | 描述                              |
| 3      | totalCount | Int           | 否   | 总记录数                          |
| 4      | data       | List          | 否   | 列表                              |
| 4.1    |            | Object        |      | 对象                              |
| 4.1.1  | id         | Int           | 否   | 编号                              |
| 4.1.2  | chainId    | Int           | 否   | 链编号                            |
| 4.1.3  | groupId    | Int           | 否   | 群组编号                          |
| 4.1.4  | type       | Int           | 否   | 信息来源类型，1-关键字 2-交易列表 |
| 4.1.5  | keyword    | String        | 是   | 关键字                            |
| 4.1.6  | comment    | String        | 是   | 监管意见                          |
| 4.1.7  | txHash     | String        | 否   | 交易hash                          |
| 4.1.8  | address    | String        | 否   | 用户地址                          |
| 4.1.9  | status     | Int           | 否   | 状态（1-未处理， 2-已处理）       |
| 4.1.10 | chainName  | String        | 是   | 链名称                            |
| 4.1.11 | appName    | String        | 是   | 应用名称                          |
| 4.1.12 | createTime | LocalDateTime | 否   | 落库时间                          |
| 4.1.13 | modifyTime | LocalDateTime | 否   | 修改时间                          |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "id": 1,
      "chainId": 1,
      "groupId": 1,
      "type": 1,
      "keyword": "禽流感",
      "comment": "停止售卖",
      "txHash": "0x8e8b15e87f09e35f4ce811fb61b0bbd730eab0cfe63a350e2bab6f7a2bfe36b0",
      "address": "0xd0332a67b2136ff5767c9ee7b775be83950da59c",
      "status": 1,
      "chainName": "存证链",
      "appName": "文件存证",
      "createTime": "2020-07-30 20:19:39",
      "modifyTime": "2020-07-30 20:19:39"
    }
  ],
  "totalCount": 1
}
```

- 失败：

```
{
   "code": 110000,
   "message": "system exception",
   "data": {}
}
```

### 5.3 确认处理状态

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址： **/transAudit/confirm/{id}**
- 请求方式：POST
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型 | 可为空 | 备注         |
| ---- | -------- | ---- | ------ | ------------ |
| 1    | id       | Int  | 否     | 告警信息编号 |

***2）入参示例***

```
http://localhost:5010/WeBASE-Data-Fetcher/transAudit/confirm/1
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数   | 类型          |      | 备注                              |
| ---- | ---------- | ------------- | ---- | --------------------------------- |
| 1    | code       | Int           | 否   | 返回码，0：成功 其它：失败        |
| 2    | message    | String        | 否   | 描述                              |
| 3    | data       | Object        |      | 信息对象                          |
| 3.1  | id         | Int           | 否   | 编号                              |
| 3.2  | chainId    | Int           | 否   | 链编号                            |
| 3.3  | groupId    | Int           | 否   | 群组编号                          |
| 3.4  | type       | Int           | 否   | 信息来源类型，1-关键字 2-交易列表 |
| 3.5  | keyword    | String        | 是   | 关键字                            |
| 3.6  | comment    | String        | 否   | 监管意见                          |
| 3.7  | txHash     | String        | 否   | 交易hash                          |
| 3.8  | address    | String        | 否   | 用户地址                          |
| 3.9  | status     | Int           | 否   | 状态（1-未处理， 2-已处理）       |
| 3.10 | chainName  | String        | 是   | 链名称                            |
| 3.11 | appName    | String        | 是   | 应用名称                          |
| 3.12 | createTime | LocalDateTime | 否   | 落库时间                          |
| 3.13 | modifyTime | LocalDateTime | 否   | 修改时间                          |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": {
    "id": 1,
    "chainId": 1,
    "groupId": 1,
    "type": 1,
    "keyword": "禽流感",
    "comment": "停止售卖",
    "txHash": "0x8e8b15e87f09e35f4ce811fb61b0bbd730eab0cfe63a350e2bab6f7a2bfe36b0",
    "address": "0xd0332a67b2136ff5767c9ee7b775be83950da59c",
    "status": 2,
    "chainName": "存证链",
    "appName": "文件存证",
    "createTime": "2020-07-30 20:19:39",
    "modifyTime": "2020-07-30 20:22:06"
  }
}
```

- 失败：

```
{
    "code": 110000,
    "message": "system exception",
    "data": {}
}
```

### 5.4 删除告警信息

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/transAudit/{id}**
- 请求方式：DELETE
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型 | 可为空 | 备注         |
| ---- | -------- | ---- | ------ | ------------ |
| 1    | id       | Int  | 否     | 告警信息编号 |

***2）入参示例***

```
http://localhost:5010/WeBASE-Data-Fetcher/transAudit/1
```

#### 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data     | object | 是   | 返回信息实体（空）         |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": null
}
```

- 失败：

```
{
    "code": 110000,
    "message": "system exception",
    "data": {}
}
```

## 6 应用告警信息管理模块

### 6.1 新增告警信息

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址： **/appAudit/add**
- 请求方式：POST
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型   | 可为空 | 备注       |
| ---- | ---------- | ------ | ------ | ---------- |
| 1    | chainId    | Int    | 否     | 链编号     |
| 2    | groupId    | Int    | 否     | 群组编号   |
| 3    | comment    | String | 否     | 监管意见   |
| 4    | chainName  | String | 是     | 链名称     |
| 5    | appName    | String | 是     | 应用名称   |
| 6    | appVersion | String | 是     | 应用版本号 |

***2）入参示例***

```
http://localhost:5010/WeBASE-Data-Fetcher/appAudit/add
```

```
{
  "chainId": 1,
  "groupId": 1,
  "comment": "停止",
  "chainName": "存证链",
  "appName": "文件存证",
  "appVersion": "1.0.0"
}
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数   | 类型          |      | 备注                        |
| ---- | ---------- | ------------- | ---- | --------------------------- |
| 1    | code       | Int           | 否   | 返回码，0：成功 其它：失败  |
| 2    | message    | String        | 否   | 描述                        |
| 3    | data       | Object        |      | 信息对象                    |
| 3.1  | id         | Int           | 否   | 编号                        |
| 3.2  | chainId    | Int           | 否   | 链编号                      |
| 3.3  | groupId    | Int           | 否   | 群组编号                    |
| 3.4  | comment    | String        | 否   | 监管意见                    |
| 3.5  | chainName  | String        | 是   | 链名称                      |
| 3.6  | appName    | String        | 是   | 应用名称                    |
| 3.7  | appVersion | String        | 是   | 应用版本号                  |
| 3.8  | status     | Int           | 否   | 状态（1-未处理， 2-已处理） |
| 3.9  | createTime | LocalDateTime | 否   | 落库时间                    |
| 3.10 | modifyTime | LocalDateTime | 否   | 修改时间                    |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": {
    "id": 1,
    "chainId": 1,
    "groupId": 1,
    "comment": "停止",
    "chainName": "存证链",
    "appName": "文件存证",
    "appVersion": "1.0.0",
    "status": 1,
    "createTime": "2020-07-30 20:19:39",
    "modifyTime": "2020-07-30 20:19:39"
  }
}
```

- 失败：

```
{
    "code": 110000,
    "message": "system exception",
    "data": {}
}
```

### 6.2 获取告警信息列表 

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/appAudit/list/{pageNumber}/{pageSize}?chainId={chainId}**
- 请求方式：GET
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型 | 可为空 | 备注       |
| ---- | ---------- | ---- | ------ | ---------- |
| 1    | pageNumber | Int  | 否     | 当前页码   |
| 2    | pageSize   | Int  | 否     | 每页记录数 |
| 3    | chainId    | Int  | 是     | 链编号     |

***2）入参示例***

```
http://localhost:5010/WeBASE-Data-Fetcher/appAudit/list/1/2
```

#### 返回参数 

***1）出参表***

| 序号   | 输出参数   | 类型          |      | 备注                        |
| ------ | ---------- | ------------- | ---- | --------------------------- |
| 1      | code       | Int           | 否   | 返回码，0：成功 其它：失败  |
| 2      | message    | String        | 否   | 描述                        |
| 3      | totalCount | Int           | 否   | 总记录数                    |
| 4      | data       | List          | 否   | 列表                        |
| 4.1    |            | Object        |      | 对象                        |
| 4.1.1  | id         | Int           | 否   | 编号                        |
| 4.1.2  | chainId    | Int           | 否   | 链编号                      |
| 4.1.3  | groupId    | Int           | 否   | 群组编号                    |
| 4.1.4  | comment    | String        | 否   | 监管意见                    |
| 4.1.5  | chainName  | String        | 是   | 链名称                      |
| 4.1.6  | appName    | String        | 是   | 应用名称                    |
| 4.1.7  | appVersion | String        | 是   | 应用版本号                  |
| 4.1.8  | status     | Int           | 否   | 状态（1-未处理， 2-已处理） |
| 4.1.9  | createTime | LocalDateTime | 否   | 落库时间                    |
| 4.1.10 | modifyTime | LocalDateTime | 否   | 修改时间                    |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "id": 1,
      "chainId": 1,
      "groupId": 1,
      "comment": "停止",
      "chainName": "存证链",
      "appName": "文件存证",
      "appVersion": "1.0.0",
      "status": 1,
      "createTime": "2020-07-30 20:19:39",
      "modifyTime": "2020-07-30 20:19:39"
    }
  ],
  "totalCount": 1
}
```

- 失败：

```
{
   "code": 110000,
   "message": "system exception",
   "data": {}
}
```

### 6.3 确认处理状态

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址： **/appAudit/confirm/{id}**
- 请求方式：POST
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型 | 可为空 | 备注         |
| ---- | -------- | ---- | ------ | ------------ |
| 1    | id       | Int  | 否     | 告警信息编号 |

***2）入参示例***

```
http://localhost:5010/WeBASE-Data-Fetcher/appAudit/confirm/1
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数   | 类型          |      | 备注                        |
| ---- | ---------- | ------------- | ---- | --------------------------- |
| 1    | code       | Int           | 否   | 返回码，0：成功 其它：失败  |
| 2    | message    | String        | 否   | 描述                        |
| 3    | data       | Object        |      | 信息对象                    |
| 3.1  | id         | Int           | 否   | 编号                        |
| 3.2  | chainId    | Int           | 否   | 链编号                      |
| 3.3  | groupId    | Int           | 否   | 群组编号                    |
| 3.4  | comment    | String        | 否   | 监管意见                    |
| 3.5  | chainName  | String        | 是   | 链名称                      |
| 3.6  | appName    | String        | 是   | 应用名称                    |
| 3.7  | appVersion | String        | 是   | 应用版本号                  |
| 3.8  | status     | Int           | 否   | 状态（1-未处理， 2-已处理） |
| 3.9  | createTime | LocalDateTime | 否   | 落库时间                    |
| 3.10 | modifyTime | LocalDateTime | 否   | 修改时间                    |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": {
    "id": 1,
    "chainId": 1,
    "groupId": 1,
    "comment": "停止",
    "chainName": "存证链",
    "appName": "文件存证",
    "appVersion": "1.0.0",
    "status": 2,
    "createTime": "2020-07-30 20:19:39",
    "modifyTime": "2020-07-30 20:22:06"
  }
}
```

- 失败：

```
{
    "code": 110000,
    "message": "system exception",
    "data": {}
}
```

### 6.4 删除告警信息

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/appAudit/{id}**
- 请求方式：DELETE
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型 | 可为空 | 备注         |
| ---- | -------- | ---- | ------ | ------------ |
| 1    | id       | Int  | 否     | 告警信息编号 |

***2）入参示例***

```
http://localhost:5010/WeBASE-Data-Fetcher/appAudit/1
```

#### 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data     | object | 是   | 返回信息实体（空）         |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": null
}
```

- 失败：

```
{
    "code": 110000,
    "message": "system exception",
    "data": {}
}
```

## 附录 

### 1. 返回码信息列表

| Code   | message                         | 描述                    |
| ------ | ------------------------------- | ----------------------- |
| 0      | success                         | 正常                    |
| 110000 | system exception                | 系统异常                |
| 110001 | param exception                 | 请求参数错误            |
| 110002 | database exception              | 数据库异常              |
| 210101 | invalid group id                | 无效群组编号            |
| 210201 | searchType not exists           | 搜索类型不存在          |
| 210202 | search content can not be empty | 搜索内容不能为空        |
| 210203 | search index not exists         | 索引不存在              |
| 210204 | search fail                     | 搜索失败                |
| 210205 | elasticsearch's config is false | elasticsearch配置未启用 |
| 210301 | keyword id not exists           | 关键字不存在            |
| 210302 | keyword exists                  | 关键字已存在            |
| 210303 | save keyword fail               | 关键字保存失败          |
| 210401 | audit id not exists             | 告警信息不存在          |
| 210402 | audit inffo exists              | 告警信息已存在          |
| 210403 | save audit info fail            | 告警信息保存失败        |