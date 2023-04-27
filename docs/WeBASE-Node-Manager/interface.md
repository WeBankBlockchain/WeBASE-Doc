
# 接口说明


## 1 前置管理模块

### 1.1 新增节点前置信息


#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/front/new**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | frontIp     | string        | 是     | 前置ip                                     |
| 2    | frontPort   | int           | 是     | 前置服务端口                               |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/front/new
```

```
{
    "frontIp": "127.0.0.1",
    "frontPort": "5002"
}
```


#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述                                       |
| 3    | data        | Object        |        | 节点信息对象                               |
| 3.1  | frontId     | int           | 否     | 前置编号                        |
| 3.2  | frontIp     | string        | 否     | 前置ip                                    |
| 3.3  | frontPort   | int           | 否     | 前置端口                                   |
| 3.4  | agency      | string        | 否     | 所属机构                                   |
| 3.5  | createTime  | LocalDateTime | 否     | 落库时间                                   |
| 3.6  | modifyTime  | LocalDateTime | 否     | 修改时间                                   |

***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": {
        "frontId": 500001,
        "frontIp": "127.0.0.1",
        "frontPort": 8181,
        "agency": "abc",
        "createTime": "2019-02-14 17:47:00",
        "modifyTime": "2019-03-15 11:14:29"
    }
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


### 1.2 获取所有前置列表 

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/front/find?frontId={frontId}&groupId={groupId}&frontStatus={frontStatus}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                 |
|------|-------------|---------------|--------|-------------------------------|
| 1     | frontId       | Int           | 否     | 前置编号                  |
| 2     | groupId       | Int           | 否     | 所属群组编号                |
| 2     | frontStatus       | Int           | 否     | 所属群组编号                |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/front/find
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | code          | Int           | 否     | 返回码，0：成功 其它：失败 |
| 2     | message       | String        | 否     | 描述                       |
| 3     | totalCount    | Int           | 否     | 总记录数                   |
| 4     | data          | List          | 否     | 组织列表                   |
| 4.1   |               | Object        |        | 节点信息对象               |
| 4.1.1 | frontId       | int           | 否     | 前置编号                   |
| 4.1.2 | frontIp       | string        | 否     | 前置ip                     |
| 4.1.3 | frontPort     | int           | 否     | 前置端口                   |
| 4.1.4 | createTime    | LocalDateTime | 否     | 落库时间                   |
| 4.1.5 | modifyTime    | LocalDateTime | 否     | 修改时间                   |
| 4.1.6 | agency        | string        | 否     | 备注所属机构                   |
| 4.1.7 | frontVersion        | string        | 否     | 前置的后台版本，如: v1.4.0                |
| 4.1.8 | signVersion        | string        | 否     |  前置所连接签名服务的后台版本，如: v1.4.0                  |
| 4.1.9 | clientVersion        | string        | 否     | 链节点的版本，如: 2.5.0 gm      |
| 4.1.10| supportVersion        | string        | 否     | 链节点所支持的最高版本, 如: 2.5.0, (此处仅显示支持的最高版本，不显示是否为国密。若从2.4.0升级到2.5.0，此处将返回2.4.0)|
| 4.1.11 | status        | int        | 否     | 前置服务状态：0，未创建；1，停止；2，启动；                   |
| 4.1.12 | runType        | int        | 否     | 运行方式：0，命令行；1，Docker                   |
| 4.1.13 | agencyId        | int        | 否     | 所属机构 ID                   |
| 4.1.14 | agencyName        | string        | 否     | 所属机构名称                   |
| 4.1.15 | hostId        | int        | 否     | 所属主机                   |
| 4.1.16 | hostIndex        | int        | 否     | 一台主机可能有多个节点。表示在主机中的编号，从 0 开始编号                   |
| 4.1.17 | imageTag        | string        | 否     | 运行的镜像版本标签                   |
| 4.1.18 | containerName        | string        | 否     | Docker 启动的容器名称                   |
| 4.1.19 | jsonrpcPort        | int        | 否     | jsonrpc 端口                   |
| 4.1.20 | p2pPort        | int        | 否     | p2p 端口                   |
| 4.1.21 | channelPort        | int        | 否     | channel 端口                   |
| 4.1.22 | chainId        | int        | 否     | 所属链 ID                   |
| 4.1.23 | chainName        | string        | 否     | 所属链名称                   |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "frontId": 500001,
            "frontIp": "127.0.0.1",
            "frontPort": 5002,
            "agency": "aa",
            "frontVersion": "v1.4.0",
            "signVersion": "v1.4.0",
            "clientVersion": "2.5.0 gm",
            "supportVersion": "2.5.0",
            "createTime": "2019-06-04 20:49:42",
            "modifyTime": "2019-06-04 20:49:42",
            "status": 1,
            "runType": 1,
            "agencyId": 1,
            "agencyName": "AgencyA",
            "hostId": 1,
            "hostIndex": 0,
            "imageTag": "v2.5.0",
            "containerName": "rootfisconode0",
            "jsonrpcPort": 8545,
            "p2pPort": 30300,
            "channelPort": 20200,
            "chainId": 1,
            "chainName": "default_chain"
        }
    ],
    "totalCount": 1
}
```

* 失败：
```
{
   "code": 102000,
   "message": "system exception",
   "data": {}
}
```

### 1.3 删除前置信息

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/front/{frontId}**
* 请求方式：DELETE
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型 | 必填 | 备注     |
| ---- | -------- | ---- | ------ | -------- |
| 1    | frontId  | int  | 是     | 前置编号 |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/front/500001
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data     | object | 是   | 返回信息实体（空）         |


***2）出参示例***

* 成功：

```
{
    "code": 0,
    "data": {},
    "message": "Success"
}
```

* 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 1.4 刷新前置信息

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/front/refresh**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

无


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/front/refresh
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data     | object | 是   | 返回信息实体（空）         |


***2）出参示例***

* 成功：

```
{
    "code": 0,
    "data": {},
    "message": "Success"
}
```

* 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


### 1.5 获取前置所连节点的配置信息

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/front/nodeConfig?frontId={frontId}**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输出参数 | 类型   |  必填    | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | frontId     | Int    | 是   | 获取特定front的nodeConfig |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/front/nodeConfig?frontId=1
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data     | object | 是   | 返回信息实体（空）         |
| 3.1  | p2pip   | String | 是   | 节点的P2P IP         |
| 3.2  | listenip    | String | 是   | 节点监听IP         |
| 3.3  | rpcport     | String | 是   | 节点的RPC端口         |
| 3.4  | p2pport     | String | 是   | 节点P2P端口         |
| 3.5  | channelPort     | String | 是   | 节点channel连接所有端口         |
| 3.6  | groupDataPath     | String | 是   | 节点群组数据存储路径         |
| 3.6  | enableStatistic     | boolean | 是   | 是否启用统计         |


***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "Success",
    "data": {
        "p2pip": "172.17.0.1",
        "listenip": "0.0.0.0",
        "rpcport": "8535",
        "p2pport": "30300",
        "channelPort": "20200",
        "groupDataPath": "data/",
        "enableStatistic": false
    }
}
```

* 失败：
<span id="nodeConfig"></span>

**节点前置的application.yml中未配置nodePath，导致无法读取节点的配置信息**

```
{
    "code": 0,
    "message": "Success",
    "data": {
        "p2pip": "null",
        "listenip": "null",
        "rpcport": "null",
        "p2pport": "null",
        "channelPort": "null",
        "groupDataPath": "null",
        "enableStatistic": false
    }
}
```

## 2 交易信息模块


### 2.1 查询交易信息列表

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：
```
/transaction/transList/{groupId}/{pageNumber}/{pageSize}?transactionHash={transactionHash}&blockNumber={blockNumber}
```
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | groupId         | int           | 是     | 所属群组编号               |
| 2     | transactionHash | String        | 否    | 交易hash                   |
| 3     | blockNumber     | BigInteger    | 否    | 块高                       |
| 4     | pageSize        | int           | 是     | 每页记录数                 |
| 5     | pageNumber      | int           | 是     | 当前页码                   |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/transaction/transList/300001/1/10?transactionHash=0x303daa78ebe9e6f5a6d9761a8eab4bf5a0ed0b06c28764488e4716de42e1df01
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
| 4.1.2 | groupId         | Int           | 否     | 所属群组编号               |
| 4.1.3 | blockNumber     | BigInteger    | 否     | 所属块高                   |
| 4.1.4 | statisticsFlag  | Int           | 否     | 是否已经统计               |
| 4.1.5 | createTime      | LocalDateTime | 否     | 落库时间                   |
| 4.1.6 | modifyTime      | LocalDateTime | 否     | 修改时间                   |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "transHash": "0x303daa78ebe9e6f5a6d9761a8eab4bf5a0ed0b06c28764488e4716de42e1df01",
            "groupId": 300001,
            "blockNumber": 133,
            "statisticsFlag": 1,
            "createTime": "2019-03-15 09:36:17",
            "modifyTime": "2019-03-15 09:36:17"
        }
    ],
    "totalCount": 1
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 2.2 查询交易回执 

#### 2.2.1 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/transaction/transactionReceipt/{groupId}/{transHash}**
* 请求方式：GET
* 返回格式：JSON

#### 2.2.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | groupId         | int           | 是     | 所属群组编号               |
| 2     | transHash | String        | 是     | 交易hash                   |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/transaction/transactionReceipt/1/0x69ced0162a0c3892e4eaa3091b831ac3aaeb772c062746b20891ceaf8a4fb429
```


#### 2.2.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | code            | Int           | 否     | 返回码，0：成功 其它：失败 |
| 2     | message         | String        | 否     | 描述                       |
| 3     |                 | Object        |        | 交易信息对象               |
| 3.1 | transactionHash       | String        | 否     | 交易hash                   |
| 3.2 | transactionIndex         | Int           | 否     | 在区块中的索引               |
| 3.2 | blockHash         | String           | 否     | 区块hash               |
| 3.3 | blockNumber     | BigInteger    | 否     | 所属块高                   |
| 3.4 | cumulativeGasUsed  | Int           | 否     |                |
| 3.5 | gasUsed      | Int | 否     | 交易消耗的gas                   |
| 3.6 | contractAddress      | String | 否     | 合约地址                   |
| 3.7 | status      | String | 否     | 交易的状态值                   |
| 3.8 | from      | String | 否     | 交易发起者                   |
| 3.9 | to      | String | 否     | 交易目标                   |
| 3.10 | output      | String | 否     | 交易输出内容                   |
| 3.11 | logs      | String | 否     | 日志                   |
| 3.12 | logsBloom      | String | 否     | log的布隆过滤值                   |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": {
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
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 2.3 根据交易hash查询交易信息 

#### 2.3.1 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/transaction/transInfo/{groupId}/{transHash}**
* 请求方式：GET
* 返回格式：JSON

#### 2.3.2 参数信息详情

请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | groupId         | int           | 是     | 所属群组编号               |
| 2     | transHash       | String        | 是    | 交易hash                   |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/transaction/transInfo/1/0x69ced0162a0c3892e4eaa3091b831ac3aaeb772c062746b20891ceaf8a4fb429
```


#### 2.3.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | code            | Int           | 否     | 返回码，0：成功 其它：失败 |
| 2     | message         | String        | 否     | 描述                       |
| 3     |                 | Object        |        | 交易信息对象               |
| 3.1   | hash            | String        | 否     | 交易hash                   |
| 3.2   | transactionIndex         | Int           | 否     | 在区块中的索引               |
| 3.2   | blockHash         | String           | 否     | 区块hash               |
| 3.3   | blockNumber     | BigInteger    | 否     | 所属块高                   |
| 3.4   | cumulativeGasUsed  | Int           | 否     |                |
| 3.5   | gasUsed         | Int | 否     | 交易消耗的gas                   |
| 3.6   | contractAddress      | String | 否     | 合约地址                   |
| 3.7   | status          | String | 否     | 交易的状态值                   |
| 3.8   | from            | String | 否     | 交易发起者                   |
| 3.9   | to              | String | 否     | 交易目标                   |
| 3.10  | output          | String | 否     | 交易输出内容                   |
| 3.11  | logs            | String | 否     | 日志                   |
| 3.12  | logsBloom       | String | 否     | log的布隆过滤值      |
| 3.13  | nonce           | String | 否     |                    |
| 3.14  | value           | String | 否     |                    |
| 3.15  | gasPrice        | long | 否     |                    |
| 3.16  | gas             | long | 否     |                    |
| 3.17  | input           | String | 否     |                    |
| 3.18  | v               | int | 否     |                    |
| 3.19  | nonceRaw        | String | 否     |                    |
| 3.20  | blockNumberRaw  | String | 否     |                    |
| 3.21  | gasPriceRaw     | String | 否     |                    |
| 3.22  | gasRaw          | String | 否     |                    |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": {
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
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


## 3 帐号管理模块


### 3.1 新增帐号


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/account/accountInfo**
* 请求方式：post
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | account       | String        | 是     | 帐号名称                   |
| 2    | accountPwd    | String        | 是     | 登录密码（sha256）         |
| 3    | roleId        | int           | 是     | 所属角色：100001-管理员，100002-普通用户，100003-开发者                   |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/account/accountInfo
```

```
{
    "account": "testAccount",
    "accountPwd": "3f21a8490cef2bfb60a9702e9d2ddb7a805c9bd1a263557dfd51a7d0e9dfa93e",
    "roleId": 100001
}
```


#### 3.1.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code          | Int           | 否     | 返回码，0：成功 其它：失败   |
| 2    | message       | String        | 否     | 描述                      |
| 3    | data          | object        | 否     | 返回信息实体               |
| 3.1  | account       | String        | 否     | 帐号                       |
| 3.2  | roleId        | Integer       | 否     | 所属角色                   |
| 3.3  | roleName      | String        | 否     | 角色名称                   |
| 3.4  | roleNameZh    | String        | 否     | 角色中文名                 |
| 3.5  | loginFailTime | Integer       | 是     | 登录失败次数               |
| 3.6  | accountStatus | Integer       | 否     | 帐号状态                   |
| 3.7  | description   | String        | 是     | 备注                       |
| 3.8  | createTime    | LocalDateTime | 否     | 创建时间                   |
| 3.9  | modifyTime    | LocalDateTime | 否     | 修改时间                   |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": {
        "account": "testAccount",
        "roleId": 100001,
        "roleName": "visitor",
        "roleNameZh": "访客",
        "loginFailTime": 0,
        "accountStatus": 1,
        "description": null,
        "createTime": "2019-03-04 15:11:44",
        "modifyTime": "2019-03-04 15:11:44"
    }
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 3.2 修改帐号


#### 3.2.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/account/accountInfo**
* 请求方式：PUT
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 3.2.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | account       | String        | 是     | 帐号名称                   |
| 2    | accountPwd    | String        | 是     | 登录密码（sha256）         |
| 3    | roleId        | int           | 是     | 所属角色                   |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/account/accountInfo
```

```
{
    "account": "testAccount",
    "accountPwd": "82ca84cf0d2ae423c09a214cee2bd5a7ac65c230c07d1859b9c43b30c3a9fc80",
    "roleId": 100001
}
```


#### 3.2.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code          | Int           | 否     | 返回码，0：成功 其它：失败 |
| 2    | message       | String        | 否     | 描述                       |
| 3    | data          | object        | 否     | 返回信息实体               |
| 3.1  | account       | String        | 否     | 帐号                       |
| 3.2  | roleId        | Integer       | 否     | 所属角色                   |
| 3.3  | roleName      | String        | 否     | 角色名称                   |
| 3.4  | roleNameZh    | String        | 否     | 角色中文名                 |
| 3.5  | loginFailTime | Integer       | 是     | 登录失败次数               |
| 3.6  | accountStatus | Integer       | 否     | 帐号状态                   |
| 3.7  | description   | String        | 是     | 备注                       |
| 3.8  | createTime    | LocalDateTime | 否     | 创建时间                   |
| 3.9  | modifyTime    | LocalDateTime | 否     | 修改时间                   |

***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": {
        "account": "testAccount",
        "roleId": 100001,
        "roleName": "visitor",
        "roleNameZh": "访客",
        "loginFailTime": 0,
        "accountStatus": 1,
        "description": null,
        "createTime": "2019-03-04 15:11:44",
        "modifyTime": "2019-03-04 15:11:44"
    }
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


### 3.3 删除帐号


#### 3.3.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/account/{account}**
* 请求方式：DELETE
* 返回格式：JSON

#### 3.3.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | account  | String | 是     | 帐号名称                   |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/account/testAccount
```


#### 3.3.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code     | Int    | 否     | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否     | 描述                       |
| 3    | data     | object | 是     | 返回信息实体（空）         |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "data": {},
    "message": "Success"
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

###  3.4 查询帐号列表


#### 3.4.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/account/accountList/{pageNumber}/{pageSize}?account={account}**
* 请求方式：GET
* 返回格式：JSON

#### 3.4.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | pageSize      | Int           | 是     | 每页记录数                 |
| 2     | pageNumber    | Int           | 是     | 当前页码                   |
| 3     | account       | String        | 否     | 帐号                       |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/account/accountList/1/10?account=
```


#### 3.4.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | code          | Int           | 否     | 返回码，0：成功 其它：失败 |
| 2     | message       | String        | 否     | 描述                       |
| 3     | totalCount    | Int           | 否     | 总记录数                   |
| 4     | data          | List          | 是     | 信息列表                   |
| 4.1   |               | Object        |        | 信息对象               |
| 4.1.1 | account       | String        | 否     | 帐号                       |
| 4.1.2 | roleId        | Integer       | 否     | 所属角色                   |
| 4.1.3 | roleName      | String        | 否     | 角色名称                   |
| 4.1.4 | roleNameZh    | String        | 否     | 角色中文名                 |
| 4.1.5 | loginFailTime | Integer       | 是     | 登录失败次数               |
| 4.1.6 | accountStatus | Integer       | 否     | 帐号状态                   |
| 4.1.7 | description   | String        | 是     | 备注                       |
| 4.1.8 | createTime    | LocalDateTime | 否     | 创建时间                   |
| 4.1.9 | modifyTime    | LocalDateTime | 否     | 修改时间                   |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "account": "testAccount",
            "roleId": 100001,
            "roleName": "visitor",
            "roleNameZh": "访客",
            "loginFailTime": 0,
            "accountStatus": 1,
            "description": null,
            "createTime": "2019-03-04 15:11:44",
            "modifyTime": "2019-03-04 15:18:47"
        },
        {
            "account": "admin",
            "roleId": 100000,
            "roleName": "admin",
            "roleNameZh": "管理员",
            "loginFailTime": 0,
            "accountStatus": 2,
            "description": null,
            "createTime": "2019-02-14 17:33:50",
            "modifyTime": "2019-02-14 17:45:53"
        }
    ],
    "totalCount": 2
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


### 3.5 更新当前密码 


#### 3.5.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/account/passwordUpdate**
* 请求方式：put
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 3.5.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | oldAccountPwd | String | 是     | 旧密码（sha256）           |
| 2    | newAccountPwd | String | 是     | 新密码（sha256）           |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/account/passwordUpdate
```

```
{
    "oldAccountPwd": "dfdfgdg490cef2bfb60a9702erd2ddb7a805c9bd1arrrewefd51a7d0etttfa93e ",
    "newAccountPwd": "3f21a8490cef2bfb60a9702e9d2ddb7a805c9bd1a263557dfd51a7d0e9dfa93e"
}
```


#### 3.5.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code          | Int    | 否     | 返回码，0：成功 其它：失败 |
| 2    | message       | String | 否     | 描述                       |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success"
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


### 3.6 获取登录验证码 


#### 3.6.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/account/pictureCheckCode**
* 请求方式：get
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 3.6.2 请求参数

***1）入参表***
无


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/account/pictureCheckCode
```

#### 3.6.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code          | Int    | 否     | 返回码，0：成功 其它：失败   |
| 2    | message       | String | 否     | 描述                      |
| 3    | data       | Object | 否     | 图片信息实体                  |
| 3.1  | base64Image   | String | 否     | 图片的base64              |
| 3.2  | token   | String | 否     | token（登录接口需要用到此值）     |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": {
        "base64Image": "iVBORw0KGgoAAAANSUhEUgAAAJsAAAA8CAIAAAD+Gl+NAAAC3ElEQVR42u3cO04DMRAG4DkER6CFhoNwCgoq6DgQh0DiVJR0oUCKovWuPU977P2trZK1s/GnGb8g9PN7wbXSRReUtQpEIYoCURSIokAUBaIQTV2+P798r3mfnJbB69nXvmAnjdHm9+8ZgruNjI31mUQrvWPpPpeuH+43n2g9FOJyrOJmiMpQ+4fC0cdVniED6hzj6NjMdv3cZvJHjCpz70DazJY+oh2mBptmH+7um5eo/ff3F+mVENJHVDrMeEUGB1W0mFGgLrhnVI9OL1QdZ58wzTnVIMcA3X3FXTQP6tjJ7dFuBjnm29JgXlGXbazoubcs63K23JgSxu/MQXXpKd1IWS6XQ42b7ZOoH/lIZfp9ff7YXCuJHvX709sj87Jb1kQ5Ichp/XpPySmlra9hvCJAl3vr77qg8kO/h2idU4eaRJTTCXzRo9QtSuOkBuOjckQVriWqC7MIldnX6jD1OfF25NwNUP679X50n+4qljH2rMBJvNYY5QefDrWspZ4xRSxjOqMyh1I+arhoqbVbS4HK5IzebejAKUIlS/AlRL0OJ1OgShcwyvVotKjjLGmD2vSOXptGc3J63iSaBFUUx+oDmVSilf4/nWieMHURLRWsomrUnhvcOVEdRW8tyIIkuj9OtKmVUDSC01NUh9ozr2ZDdU+5jRPvIFHmEsUy3eVMeqP37jtwVk7uyCgkrcU5VtOFcsW1/2F4kCjnCLZxPqqI1Hot/mmMPVKDNgXdRflnMso9I07Aqc/abl+PWMOsispvmaRZVL3ru3vmF7EkdT+NWUq0kr5FO4Vl3U31iB0GL865UAV/Czj8X/tOUoxdhN9hyChqqQ7RpTghClEUiKJAFKIQBSpEF0aFKETX7cRsW1q6JyEoHh0qZABWfDqdnDPi5rGPSqflHLK06OBKiM7O1e0DRH1EIETn2HY4bMxffp31F5MHRmeQq3EW5vPrN2eOTq8h2X0u/d/aH4oBfftm+5EiAAAAAElFTkSuQmCC",
        "token": "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIzOGM0NjlhNC1kMTg3LTQyZDQtYWM1YS02OWU0OWM5MjMxNTkiLCJpYXQiOjE1NjAyNDY3MzksInN1YiI6ImU1RnoiLCJleHAiOjE1NjAyNDY3OTl9.FJYRZJSAhFjvO_P4AjMO6bnoOZJiu-AOSdO9ikb-30M"
    }
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 3.7 登录接口


#### 3.7.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/account/login?checkCode={checkCode}**
* 请求方式：get
* 请求头：Content-type: application/json;token:{token}
* 返回格式：JSON

#### 3.7.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | checkCode          | String    | 是     | 登录验证码   |
| 2    | account          | String    | 是     | 帐号   |
| 3    | accountPwd          | String    | 是     | 密码   |
| 4    | token          | String    | 是     | 随验证码返回的token   |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/account/login?checkCode=aege
```

```
{
    "account": "admin",
    "accountPwd": "Abcd1234"
}
```


#### 1.1.3 返回参数 

***1）出参表***

| 序号 | 输出参数      | 类型   |      | 备注                       |
| ---- | ------------- | ------ | ---- | -------------------------- |
| 1    | code          | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message       | String | 否   | 描述                       |
| 3    | data          | Object | 否   | 图片信息实体               |
| 3.1  | account       | String | 否   | 账户                       |
| 3.2  | roleName      | String | 否   | 角色                       |
| 3.3  | accountStatus | Int    | 否   | 状态                       |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "data": {
        "accountStatus": 2,
        "roleName": "admin",
        "account": "admin"
    },
    "message": "success"
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

## 4 区块管理模块


### 4.1 查询区块列表


#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/block/blockList/{groupId}/{pageNumber}/{pageSize}}?pkHash={pkHash}&blockNumber={blockNumber}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数


***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | groupId        | Int           | 是     | 当前所属链                 |
| 2     | pageSize       | Int           | 是     | 每页记录数                 |
| 3     | pageNumber     | Int           | 是     | 当前页码                   |
| 4     | pkHash         | String        | 否     | 区块hash                   |
| 5     | blockNumber    | BigInteger    | 否     | 块高                       |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/block/blockList/300001/1/10?pkHash=
```

#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | code           | Int           | 否     | 返回码，0：成功 其它：失败 |
| 2     | message        | String        | 否     | 描述                       |
| 3     | totalCount     | Int           | 否     | 总记录数                   |
| 4     | data           | List          | 是     | 区块列表                   |
| 4.1   |                | Object        |        | 区块信息对象               |
| 4.1.1 | pkHash         | String        | 否     | 块hash                     |
| 4.1.2 | blockNumber    | BigInteger    | 否     | 块高                       |
| 4.1.3 | blockTimestamp | LocalDateTime | 否     | 出块时间                   |
| 4.1.4 | transCount     | int           | 否     | 交易数                     |
| 4.1.5 | sealerIndex    | int           | 否     | 打包节点索引                     |
| 4.1.6 | sealer         | String        | 否     | 打包节点                     |
| 4.1.7 | createTime     | LocalDateTime | 否     | 创建时间                   |
| 4.1.8 | modifyTime     | LocalDateTime | 否     | 修改时间                   |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "pkHash": "0x10fb8485eebffbb2a0b0d4f22d58d5cd54df2ac53f974b6c731c954957f36dd7",
            "blockNumber": 127,
            "blockTimestamp": "2019-06-11 18:11:32",
            "transCount": 1,
            "sealerIndex": 2,
            "sealer": "552398be0eef124c000e632b0b76a48c52b6cfbd547d92c15527c2d1df15fab2bcded48353db22526c3540e4ab2027630722889f20a4a614bb11a7887a85941b",
            "createTime": "2019-06-11 18:11:36",
            "modifyTime": "2019-06-11 18:11:36"
        }
    ],
    "totalCount": 1
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


### 4.2 根据块高或hash查询区块信息


#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/block/blockByNumber/{groupId}/{blockNumber}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | groupId        | Int           | 是     | 当前所属链                 |
| 2     | pageSize       | Int           | 是     | 每页记录数                 |
| 3     | pageNumber     | Int           | 是     | 当前页码                   |
| 4     | pkHash         | String        | 否     | 区块hash                   |
| 5     | blockNumber    | BigInteger    | 否     | 块高                       |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/block/blockByNumber/1/2
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | code           | Int           | 否     | 返回码，0：成功 其它：失败 |
| 2     | message        | String        | 否     | 描述                       |
| 3     |                | Object        |        | 区块信息对象               |
| 3.1   | number         | BigInteger    | 否     | 块高                       |
| 3.2   | hash           | String        | 否     | 区块hsah                   |
| 3.3   | parentHash     | String        | 否     | 父块hash                   |
| 3.4   | nonce          | String        | 否     | 随机数                     |
| 3.5   | sealer         | String        | 否     | 打包节点索                 |
| 3.6   | logsBloom      | String        | 否     | log的布隆过滤值            |
| 3.7   | transactionsRoot        | String        | 否     |                    |
| 3.8   | stateRoot        | String        | 否     |                    |
| 3.9   | difficulty        | String        | 否     |                    |
| 3.10   | totalDifficulty        | String        | 否     |                    |
| 3.11   | extraData        | String        | 否     |                    |
| 3.12   | size        | int        | 否     |                    |
| 3.13   | gasLimit        | long        | 否     | 限制gas值                   |
| 3.14   | gasUsed        | long        | 否     | 已使用的gas值                 |
| 3.15   | timestamp        | String        | 否     | 出块时间                   |
| 3.16 | gasLimitRaw        | String        | 否     |                    |
| 3.17   | timestampRaw        | String        | 否     |                    |
| 3.18   | gasUsedRaw        | String        | 否     |                    |
| 3.19   | numberRaw        | String        | 否     |                    |
| 3.20   | transactions        | List        | 否     |                    |
| 3.20.1     |                 | Object        |        | 交易信息对象               |
| 3.20.1.1   | hash            | String        | 否     | 交易hash                   |
| 3.20.1.2   | blockHash         | String           | 否     | 区块hash               |
| 3.20.1.3   | blockNumber     | BigInteger    | 否     | 所属块高                   |
| 3.20.1.4   | cumulativeGasUsed  | Int           | 否     |                |
| 3.20.1.5   | gasUsed         | Int | 否     | 交易消耗的gas                   |
| 3.20.1.6   | contractAddress      | String | 否     | 合约地址                   |
| 3.20.1.7   | status          | String | 否     | 交易的状态值                   |
| 3.20.1.8   | from            | String | 否     | 交易发起者                   |
| 3.20.1.9   | to              | String | 否     | 交易目标                   |
| 3.20.1.10  | output          | String | 否     | 交易输出内容                   |
| 3.20.1.11  | logs            | String | 否     | 日志                   |
| 3.20.1.12  | logsBloom       | String | 否     | log的布隆过滤值                   |
| 3.20.1.13  | nonce           | String | 否     |                    |
| 3.20.1.14  | value           | String | 否     |                    |
| 3.20.1.15  | gasPrice        | long | 否     |                    |
| 3.20.1.16  | gas             | long | 否     |                    |
| 3.20.1.17  | input           | String | 否     |                    |
| 3.20.1.18  | v               | int | 否     |                    |
| 3.20.1.19  | nonceRaw        | String | 否     |                    |
| 3.20.1.20  | blockNumberRaw  | String | 否     |                    |
| 3.20.1.21  | gasPriceRaw     | String | 否     |                    |
| 3.20.1.22  | gasRaw          | String | 否     |                    |
| 3.20.1.23  | transactionIndex         | Int           | 否     | 在区块中的索引               |


***2）出参示例***
* 成功：
```
{
  "code": 0,
  "message": "success",
  "data": {
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
  },
  "attachment": null
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


### 4.5 根据块高获取区块头


#### 接口描述

> 返回

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/block/blockHeaderByNumber/{blockNumber}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**       | **类型**   | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------------- | ---------- | ------------ | -------- | -------- |
| 1        | 块高 | blockNumber | int      |             | 是        |                      |

**2）数据格式**

```
http://localhost:5001/WeBASE-Node-Manager/block/blockHeaderByNumber/2
```

#### 响应参数
**1）数据格式**

```
{
  "code": 0,
  "message": "success",
  "data": {
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
    ]
    }
}
```

### 4.4. 根据区块哈希获取区块头


#### 接口描述

> 返回

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/block/blockHeaderByHash/{blockHash}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**       | **类型**   | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------------- | ---------- | ------------ | -------- | -------- |
| 1        | 区块哈希 | blockHash | String      |             | 是        |                      |

**2）数据格式**

```
http://localhost:5001/WeBASE-Front/block/blockHeaderByHash/0xf58f4f43b3761f4863ad366c4a7e2a812ed68df9f7bcad6b502fd544665e7625
```

#### 响应参数
**1）数据格式**

```
{
  "code": 0,
  "message": "success",
  "data": {
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
    ]
    }
}
```

## 5 合约管理模块  

### 5.1 查询合约列表 


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/contract/contractList/{groupId}/{pageNumber}/{pageSize}**
* 请求方式：POST
* 返回格式：JSON

#### 请求参数


***1）入参表***

| 序号 | 输入参数        | 类型   | 必填 | 备注             |
| ---- | --------------- | ------ | ------ | ---------------- |
| 1    | groupId         | int    | 是     | 群组id           |
| 2    | contractName    | String | 否     | 合约名           |
| 3    | contractAddress | String | 否     | 合约地址         |
| 4    | pageSize        | int    | 是     | 每页记录数       |
| 5    | pageNumber      | int    | 是     | 当前页码         |
| 6    | contractStatus  | int    | 否     | 1未部署，2已部署 |
| 7    | account         | String | 否     | 关联账户         |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/contract/contractList
```

```
{"groupId":"1","pageNumber":1,"pageSize":500}
```

#### 返回参数 

***1）出参表***

| 序号   | 输出参数        | 类型          |      | 备注                                        |
| ------ | --------------- | ------------- | ---- | ------------------------------------------- |
| 1      | code            | Int           | 否   | 返回码，0：成功 其它：失败                  |
| 2      | message         | String        | 否   | 描述                                        |
| 3      | totalCount      | Int           | 否   | 总记录数                                    |
| 4      | data            | List          | 是   | 列表                                        |
| 5.1    |                 | Object        |      | 返回信息实体                                |
| 5.1.1  | contractId      | int           | 否   | 合约编号                                    |
| 5.1.2  | contractPath    | String        | 否   | 合约所在目录                                |
| 5.1.3  | contractName    | String        | 否   | 合约名称                                    |
| 5.1.4  | groupId         | Int           | 否   | 所属群组编号                                |
| 5.1.5  | contractStatus  | int           | 否   | 1未部署，2已部署                            |
| 5.1.6  | contractType    | Int           | 否   | 合约类型(0-普通合约，1-系统合约)            |
| 5.1.7  | contractSource  | String        | 否   | 合约源码base64                              |
| 5.1.8  | contractAbi     | String        | 是   | 合约编译后生成的abi文件内容                 |
| 5.1.9  | contractBin     | String        | 是   | 合约编译后生成的bin,可用于交易解析          |
| 5.1.10 | bytecodeBin     | String        | 是   | 合约编译后生成的bytecodeBin，可用于合约部署 |
| 5.1.11 | contractAddress | String        | 是   | 合约地址                                    |
| 5.1.12 | deployTime      | LocalDateTime | 是   | 部署时间                                    |
| 5.1.13 | contractVersion | String        | 否   | 合约版本（会去除该字段）                    |
| 5.1.14 | description     | String        | 是   | 备注                                        |
| 5.1.15 | account         | String        | 是   | 关联账户                                    |
| 5.1.16 | createTime      | LocalDateTime | 否   | 创建时间                                    |
| 5.1.17 | modifyTime      | LocalDateTime | 是   | 修改时间                                    |

***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "contractId": 200002,
            "contractPath": "hellos",
            "contractVersion": null,
            "contractName": "hellos",
            "contractStatus": 2,
            "groupId": 1,
            "contractType": 0,
            "contractSource": "cHJhZ21hIHNvbGlkaXgICAJbmFtZSA9IG47CiAgICB9Cn0=",
            "contractAbi": "[\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"}]",
            "contractBin": "608060405234801561001057600080004d4c",
            "bytecodeBin": "60806040526004361061004c576000398de7e4ddf5fdc9ccbcfd44565fed695cd960b0029",
            "deployTime": "2019-06-11 18:11:33",
            "description": null,
            "account": "admin",
            "createTime": "2019-06-05 16:40:40",
            "modifyTime": "2019-06-11 18:11:33"
        }
    ],
    "totalCount": 1
}
```

* 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


### 5.2 查询合约信息


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/contract/{contractId}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型 | 必填 | 备注     |
| ---- | ---------- | ---- | ------ | -------- |
| 1   | contractId | int  | 是     | 合约编号 |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/contract/200001
```

#### 返回参数 

***1）出参表***

| 序号 | 输出参数        | 类型          |      | 备注                                                  |
| ---- | --------------- | ------------- | ---- | ----------------------------------------------------- |
| 1    | code            | Int           | 否   | 返回码，0：成功 其它：失败                            |
| 2    | message         | String        | 否   | 描述                                                  |
| 3    |                 | Object        |      | 返回信息实体                                          |
| 3.1  | contractId      | int           | 否   | 合约编号                                              |
| 3.2  | contractPath    | String        | 否   | 合约所在目录                                          |
| 3.3  | contractName    | String        | 否   | 合约名称                                              |
| 3.4  | groupId         | Int           | 否   | 所属群组编号                                          |
| 3.5  | contractStatus  | int           | 否   | 1未部署，2已部署                                      |
| 3.6  | contractType    | Int           | 否   | 合约类型(0-普通合约，1-系统合约)                      |
| 3.7  | contractSource  | String        | 否   | 合约源码                                              |
| 3.8  | contractAbi     | String        | 是   | 编译合约生成的abi文件内容                             |
| 3.9  | contractBin     | String        | 是   | 合约编译的runtime-bytecode(runtime-bin)，用于交易解析 |
| 3.10 | bytecodeBin     | String        | 是   | 合约编译的bytecode(bin)，用于部署合约                 |
| 3.11 | contractAddress | String        | 是   | 合约地址                                              |
| 3.12 | deployTime      | LocalDateTime | 是   | 部署时间                                              |
| 3.13 | contractVersion | String        | 否   | 合约版本（会去除该字段）                              |
| 3.14 | description     | String        | 是   | 备注                                                  |
| 3.15 | account         | String        | 是   | 关联账户                                              |
| 3.16 | createTime      | LocalDateTime | 否   | 创建时间                                              |
| 3.17 | modifyTime      | LocalDateTime | 是   | 修改时间                                              |


***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "contractId": 200002,
        "contractPath": "hellos",
        "contractVersion": null,
        "contractName": "hellos",
        "contractStatus": 2,
        "groupId": 1,
        "contractType": 0,
        "contractSource": "cHJhZ21hIHNvbGlkaXgICAJbmFtZSA9IG47CiAgICB9Cn0=",
        "contractAbi": "[\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"}]",
        "bytecodeBin": "60806040526004361061004c576000398de7e4ddf5fdc9ccbcfd44565fed695cd960b0029",
        "contractBin": "608060405234801561001057600080004d4c",
        "deployTime": "2019-06-11 18:11:33",
        "description": null,
        "account": "admin",
        "createTime": "2019-06-05 16:40:40",
        "modifyTime": "2019-06-11 18:11:33"
    }
}
```

* 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 5.3 部署合约


1.5.5及以后版本：
> 构造方法参数（funcParam）为String数组，每个参数都使用String字符串表示，多个参数以逗号分隔（参数为数组时同理），示例：
> 
> ```
> constructor(string s) -> ["aa,bb\"cc"]	// 双引号要转义
> constructor(uint n,bool b) -> ["1","true"]
> constructor(bytes b,address[] a) -> ["0x1a","[\"0x7939E26070BE44E6c4Fc759Ce55C6C8b166d94BE\",\"0xce867fD9afa64175bb50A4Aa0c17fC7C4A3C67D9\"]"]
> ```


1.5.5以前的版本：
> 
> 构造方法参数（funcParam）为JSON数组，多个参数以逗号分隔（参数为数组时同理），示例：
>
> ```
> constructor(string s) -> ["aa,bb\"cc"]	// 双引号要转义
> constructor(uint n,bool b) -> [1,true]
> constructor(bytes b,address[] a) -> ["0x1a",["0x7939E26070BE44E6c4Fc759Ce55C6C8b166d94BE","0xce867fD9afa64175bb50A4Aa0c17fC7C4A3C67D9"]]
> ```

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/contract/deploy**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数          | 类型   | 必填 | 备注                                                  |
| ---- | ----------------- | ------ | ------ | ----------------------------------------------------- |
| 1    | groupId           | Int    | 是     | 所属群组编号                                          |
| 2    | contractName      | String | 是     | 合约名称                                              |
| 3    | contractSource    | String | 是     | 合约源码                                              |
| 4    | contractAbi       | String | 是     | 编译合约生成的abi文件内容                             |
| 5    | contractBin       | String | 是     | 合约编译的runtime-bytecode(runtime-bin)，用于交易解析 |
| 6    | bytecodeBin       | String | 是     | 合约编译的bytecode(bin)，用于部署合约                 |
| 7    | contractId        | String | 是     | 合约名称                                              |
| 8    | contractPath      | String | 是     | 合约所在目录                                          |
| 9    | user              | String | 是     | WeBASE的私钥用户的地址                                |
| 10   | account           | String | 是     | 关联账户                                              |
| 11   | constructorParams | List<String>   | 否     | 构造函数入参，根据合约构造函数决定。String数组，每个参数都通过String字符串表示，包括数组也需要括在双引号内，多个参数以逗号分隔（参数为数组时同理），如：set(string s, string[] l) -> ["str1","[\"arr1\",\"arr2\"]"]    |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/contract/deploy
```

```
{
	"groupId": "1",
	"contractBin": "60806040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063299f7f9d146100515780633590b49f146100e1575b600080fd5b34801561005d57600080fd5b5061006661014a565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100a657808201518184015260208101905061008b565b50505050905090810190601f1680156100d35780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156100ed57600080fd5b50610148600480360381019080803590602001908201803590602001908080601f01602080910402602001604051908101604052809392919081815260200183838082843782019150505050505091929192905050506101ec565b005b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156101e25780601f106101b7576101008083540402835291602001916101e2565b820191906000526020600020905b8154815290600101906020018083116101c557829003601f168201915b5050505050905090565b8060009080519060200190610202929190610206565b5050565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061024757805160ff1916838001178555610275565b82800160010185558215610275579182015b82811115610274578251825591602001919060010190610259565b5b5090506102829190610286565b5090565b6102a891905b808211156102a457600081600090555060010161028c565b5090565b905600a165627a7a72305820456bd30e517ce9633735d32413043bf33a2453c7f56e682b13e6125452d689dc0029",
	"bytecodeBin": "608060405234801561001057600080fd5b506040805190810160405280600d81526020017f48656c6c6f2c20576f726c6421000000000000000000000000000000000000008152506000908051906020019061005c929190610062565b50610107565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106100a357805160ff19168380011785556100d1565b828001600101855582156100d1579182015b828111156100d05782518255916020019190600101906100b5565b5b5090506100de91906100e2565b5090565b61010491905b808211156101005760008160009055506001016100e8565b5090565b90565b6102d7806101166000396000f30060806040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063299f7f9d146100515780633590b49f146100e1575b600080fd5b34801561005d57600080fd5b5061006661014a565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100a657808201518184015260208101905061008b565b50505050905090810190601f1680156100d35780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156100ed57600080fd5b50610148600480360381019080803590602001908201803590602001908080601f01602080910402602001604051908101604052809392919081815260200183838082843782019150505050505091929192905050506101ec565b005b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156101e25780601f106101b7576101008083540402835291602001916101e2565b820191906000526020600020905b8154815290600101906020018083116101c557829003601f168201915b5050505050905090565b8060009080519060200190610202929190610206565b5050565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061024757805160ff1916838001178555610275565b82800160010185558215610275579182015b82811115610274578251825591602001919060010190610259565b5b5090506102829190610286565b5090565b6102a891905b808211156102a457600081600090555060010161028c565b5090565b905600a165627a7a72305820456bd30e517ce9633735d32413043bf33a2453c7f56e682b13e6125452d689dc0029",
	"contractAbi": "[{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"}]",
	"contractSource": "cHJhZ21hIHNvbGlkaXR5ID49MC40LjI0IDwwLjYuMTE7Cgpjb250cmFjdCBIZWxsb1dvcmxkIHsKICAgIHN0cmluZyBuYW1lOwoKICAgIGNvbnN0cnVjdG9yKCkgcHVibGljIHsKICAgICAgICBuYW1lID0gIkhlbGxvLCBXb3JsZCEiOwogICAgfQoKICAgIGZ1bmN0aW9uIGdldCgpIHB1YmxpYyB2aWV3IHJldHVybnMgKHN0cmluZyBtZW1vcnkpIHsKICAgICAgICByZXR1cm4gbmFtZTsKICAgIH0KCiAgICBmdW5jdGlvbiBzZXQoc3RyaW5nIG1lbW9yeSBuKSBwdWJsaWMgewogICAgICAgIG5hbWUgPSBuOwogICAgfQp9",
	"user": "0xdccae56cef725605d0fa1e00fd553074a74091c5",
	"contractName": "HelloWorld",
	"contractId": 200306,
	"contractPath": "/",
	"account": "admin"
}
```

#### 返回参数 

***1）出参表***

| 序号 | 输出参数        | 类型          |      | 备注                                                  |
| ---- | --------------- | ------------- | ---- | ----------------------------------------------------- |
| 1    | code            | Int           | 否   | 返回码，0：成功 其它：失败                            |
| 2    | message         | String        | 否   | 描述                                                  |
| 3    |                 | Object        |      | 返回信息实体                                          |
| 3.1  | contractId      | int           | 否   | 合约编号                                              |
| 3.2  | contractPath    | String        | 否   | 合约所在目录                                          |
| 3.3  | contractName    | String        | 否   | 合约名称                                              |
| 3.4  | groupId         | Int           | 否   | 所属群组编号                                          |
| 3.5  | contractStatus  | int           | 否   | 1未部署，2已部署                                      |
| 3.6  | contractType    | Int           | 否   | 合约类型(0-普通合约，1-系统合约) （已弃用字段）             |
| 3.7  | contractSource  | String        | 否   | 合约源码                                              |
| 3.8  | contractAbi     | String        | 是   | 编译合约生成的abi文件内容                             |
| 3.9  | contractBin     | String        | 是   | 合约编译的runtime-bytecode(runtime-bin)，用于交易解析 |
| 3.10 | bytecodeBin     | String        | 是   | 合约编译的bytecode(bin)，用于部署合约                 |
| 3.11 | contractAddress | String        | 是   | 合约地址                                              |
| 3.12 | deployTime      | LocalDateTime | 是   | 部署时间                                              |
| 3.13 | contractVersion | String        | 否   | 合约版本（会去除该字段）                              |
| 3.14 | description     | String        | 是   | 备注                                                  |
| 3.15 | account         | String        | 是   | 关联账户                                              |
| 3.16 | createTime      | LocalDateTime | 否   | 创建时间                                              |
| 3.17 | modifyTime      | LocalDateTime | 是   | 修改时间                                              |


***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "contractId": 200008,
        "contractPath": "Hi",
        "contractVersion": null,
        "contractName": "HeHe",
        "contractStatus": 2,
        "groupId": 1,
        "contractType": null,
        "contractSource": "cHJhZ21hIHNvbGlkaXR5IF4wLjQuM0=",
        "contractAbi": "[]",
        "bytecodeBin": "60806040526004361061004c576000357c010274c87bff322ea2269b80029",
        "contractBin": "608060405234801561001057629",
        "contractAddress": "0xa2ea2280b3a08a3ae2e1785dff09561e13915fb2",
        "deployTime": "2019-06-11 18:58:33",
        "description": null,
        "account": "admin",
        "createTime": null,
        "modifyTime": null
    }
}
```

* 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


### 5.4 发送交易


1.5.5及以后版本：

方法参数（funcParam）为String数组，每个参数都使用String字符串表示，多个参数以逗号分隔（参数为数组时同理），示例：

```
function set(string s) -> ["aa,bb\"cc"]	// 双引号要转义
function set(uint n,bool b) -> ["1","true"]
function set(bytes b,address[] a) -> ["0x1a","[\"0x7939E26070BE44E6c4Fc759Ce55C6C8b166d94BE\",\"0xce867fD9afa64175bb50A4Aa0c17fC7C4A3C67D9\"]"]
```

1.5.5以前的版本：

方法入参（funcParam）为JSON数组，多个参数以逗号分隔（参数为数组时同理），示例：

```
function set(string s) -> ["aa,bb\"cc"]	// 双引号要转义
function set(uint n,bool b) -> [1,true]
function set(bytes b,address[] a) -> ["0x1a",["0x7939E26070BE44E6c4Fc759Ce55C6C8b166d94BE","0xce867fD9afa64175bb50A4Aa0c17fC7C4A3C67D9"]]
```


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/contract/transaction**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数


***1）入参表***

| 序号 | 输入参数        | 类型   | 必填 | 备注                                |
| ---- | --------------- | ------ | ------ | ----------------------------------- |
| 1    | groupId         | Int    | 是     | 所属群组编号                        |
| 2    | user            | String | 是     | 私钥用户的地址                      |
| 3    | contractName    | String | 是     | 合约名称                            |
| 4    | contractId      | Int    | 是     | 合约编号                            |
| 5    | funcName        | String | 是     | 合约方法名                          |
| 6    | contractAddress | String | 否     | 合约地址                            |
| 7    | funcParam       | List<String>   | 否     | 合约方法入参，String数组，每个参数都通过String字符串表示，包括数组也需要括在双引号内，多个参数以逗号分隔（参数为数组时同理），如：set(string s, string[] l) -> ["str1","[\"arr1\",\"arr2\"]"]                        |
| 8    | contractAbi     | List   | 是     | 合约abi/合约单个函数的abi           |
| 9    | useCns          | bool   | 否     | 是否使用cns调用，默认为false                     |
| 10   | cnsName         | String | 否     | CNS名称，useCns为true时不能为空     |
| 11   | version         | String | 否     | CNS合约版本，useCns为true时不能为空 |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/contract/transaction
```

```
{
    "groupId": 1,
    "user":"0xdccae56cef725605d0fa1e00fd553074a74091c5",
    "contractName":"HelloWorld",
    "funcName":"set",
    "funcParam":["gwes"],
    "contractAbi": [{"constant":true,"inputs":[],"name":"get","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"n","type":"string"}],"name":"set","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"}],
    "contractId":200306,
    "contractAddress":"0x4d1cbcc47b2558d818b9672df67f22f9a9645c87"
}
```

#### 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data     | object | 是   | 返回信息实体（空）         |


***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
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
}
```

* 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


### 5.5 根据包含bytecodeBin的字符串查询合约  


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址： **/contract/findByPartOfBytecodeBin**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数          | 类型   | 必填 | 备注                          |
| ---- | ----------------- | ------ | ------ | ----------------------------- |
| 1    | groupId           | int    | 是     | 所属群组编号                  |
| 2    | partOfBytecodeBin | String | 是     | 包含合约bytecodeBin的的字符串 |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/contract/findByPartOfBytecodeBin
```

```
{
    "groupId": "300001",
    "partOfBytecodeBin": "abc123455dev"
}
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数        | 类型          |      | 备注                                                  |
| ---- | --------------- | ------------- | ---- | ----------------------------------------------------- |
| 1    | code            | Int           | 否   | 返回码，0：成功 其它：失败                            |
| 2    | message         | String        | 否   | 描述                                                  |
| 3    |                 | Object        |      | 返回信息实体                                          |
| 3.1  | contractId      | int           | 否   | 合约编号                                              |
| 3.2  | contractName    | String        | 否   | 合约名称                                              |
| 3.3  | groupId         | Int           | 否   | 所属群组编号                                          |
| 3.4  | contractType    | Int           | 否   | 合约类型(0-普通合约，1-系统合约)                      |
| 3.5  | contractSource  | String        | 否   | 合约源码                                              |
| 3.6  | contractAbi     | String        | 是   | 编译合约生成的abi文件内容                             |
| 3.7  | contractBin     | String        | 是   | 合约编译的runtime-bytecode(runtime-bin)，用于交易解析 |
| 3.8  | bytecodeBin     | String        | 是   | 合约编译的bytecode(bin)，用于部署合约                 |
| 3.9  | contractAddress | String        | 是   | 合约地址                                              |
| 3.10 | deployTime      | LocalDateTime | 是   | 部署时间                                              |
| 3.11 | contractVersion | String        | 否   | 合约版本                                              |
| 3.12 | description     | String        | 是   | 备注                                                  |
| 3.13 | account         | String        | 是   | 关联账户                                              |
| 3.14 | createTime      | LocalDateTime | 否   | 创建时间                                              |
| 3.15 | modifyTime      | LocalDateTime | 是   | 修改时间                                              |


***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "contractId": 200002,
        "contractName": "Ok",
        "groupId": 2,
        "chainIndex": null,
        "contractType": 0,
        "contractSource": "cHJhZ21hIDQoNCg0KfQ==",
        "contractAbi": "[]",
        "contractBin": "60606040526000357c01000000000029",
        "bytecodeBin": "123455",
        "contractAddress": "0x19146d3a2f138aacb97ac52dd45dd7ba7cb3e04a",
        "deployTime": null,
        "contractVersion": "v6.0",
        "description": null,
        "account": "admin",
        "createTime": "2019-04-15 21:14:40",
        "modifyTime": "2019-04-15 21:14:40"
    }
}
```

* 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 5.6. 保存合约接口

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/contract/save**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数


***1）入参表***

| 序号 | 输入参数       | 类型   | 必填 | 备注                                        |
| ---- | -------------- | ------ | ------ | ------------------------------------------- |
| 1    | groupId        | int    | 是     | 所属群组编号                                |
| 2    | contractId     | int    | 否     | 合约编号，传入contractId表示更新，否则新增  |
| 3    | contractName   | String | 是     | 合约名称                                    |
| 4    | contractPath   | String | 是     | 合约所在目录                                |
| 5    | contractSource | String | 否     | 合约源码的base64                            |
| 6    | contractAbi    | String | 否     | 合约编译后生成的abi文件内容                 |
| 7    | contractBin    | String | 否     | 合约编译后生成的bin,可用于交易解析          |
| 8    | bytecodeBin    | String | 否     | 合约编译后生成的bytecodeBin，可用于合约部署 |
| 9    | account        | String | 否     | 关联账户，新建时不能为空                    |


***2）入参示例***

```
{
    "groupId": "1",
    "contractName": "HeHe",
    "contractPath": "/",
    "contractSource": "cHJhZ21hIHNvbGlkaXR5IF4wLjQuMjsn0=",
    "contractAbi": “[]”
    "contractBin": "60806040526004361061004c576000357c0100000000000000000000000029",
    "bytecodeBin": "6080604052348015610010572269b80029",
    "contractId": 1,
    "account": "admin"
}
```

#### 返回参数 

***1）出参表***

| 序号 | 输出参数        | 类型          |      | 备注                                        |
| ---- | --------------- | ------------- | ---- | ------------------------------------------- |
| 1    | code            | Int           | 否   | 返回码，0：成功 其它：失败                  |
| 2    | message         | String        | 否   | 描述                                        |
| 3    |                 | Object        |      | 返回信息实体                                |
| 3.1  | contractId      | int           | 否   | 合约编号                                    |
| 3.2  | contractPath    | String        | 否   | 合约所在目录                                |
| 3.3  | contractName    | String        | 否   | 合约名称                                    |
| 3.4  | groupId         | Int           | 否   | 所属群组编号                                |
| 3.5  | contractStatus  | int           | 否   | 1未部署，2已部署                            |
| 3.6  | contractType    | Int           | 否   | 合约类型(0-普通合约，1-系统合约)            |
| 3.7  | contractSource  | String        | 否   | 合约源码base64                              |
| 3.8  | contractAbi     | String        | 是   | 合约编译后生成的abi文件内容                 |
| 3.9  | contractBin     | String        | 是   | 合约编译后生成的bin,可用于交易解析          |
| 3.10 | bytecodeBin     | String        | 是   | 合约编译后生成的bytecodeBin，可用于合约部署 |
| 3.11 | contractAddress | String        | 是   | 合约地址                                    |
| 3.12 | deployTime      | LocalDateTime | 是   | 部署时间                                    |
| 3.13 | contractVersion | String        | 否   | 合约版本（会去除该字段）                    |
| 3.14 | description     | String        | 是   | 备注                                        |
| 3.15 | account         | String        | 是   | 关联账户                                    |
| 3.16 | createTime      | LocalDateTime | 否   | 创建时间                                    |
| 3.17 | modifyTime      | LocalDateTime | 是   | 修改时间                                    |


### 5.7 获取Abi信息  

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址： **/abi/{abiId}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型 | 必填 | 备注    |
| ---- | -------- | ---- | ------ | ------- |
| 1    | abiId    | Long | 是     | abi编号 |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/abi/1
```

#### 返回参数 

***1）出参表***

| 序号 | 输出参数        | 类型          |      | 备注                              |
| ---- | --------------- | ------------- | ---- | --------------------------------- |
| 1    | code            | Int           | 否   | 返回码，0：成功 其它：失败        |
| 2    | message         | String        | 否   | 描述                              |
| 3    |                 | Object        |      | 返回信息实体                      |
| 3.1  | abiId           | int           | 否   | 合约编号                          |
| 3.2  | contractName    | String        | 否   | 合约名称                          |
| 3.3  | groupId         | Int           | 否   | 所属群组编号                      |
| 3.4  | contractAddress | String        | 否   | 合约地址                          |
| 3.5  | contractAbi     | String        | 是   | 导入的abi文件内容                 |
| 3.6  | contractBin     | String        | 是   | 合约runtime-bytecode(runtime-bin) |
| 3.7  | account         | String        | 否   | 所属账号                          |
| 3.8  | createTime      | LocalDateTime | 否   | 创建时间                          |
| 3.9  | modifyTime      | LocalDateTime | 是   | 修改时间                          |


***2）出参示例***

* 成功：

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
    "account": "admin",
    "createTime": "2020-05-18 10:59:02",
    "modifyTime": "2020-05-18 10:59:02"
  }
}
```


### 5.8 获取Abi信息分页列表  


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址： **/abi/list/{groupId}/{pageNumber}/{pageSize}?account={account}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型   | 必填 | 备注          |
| ---- | ---------- | ------ | ------ | ------------- |
| 1    | groupId    | int    | 是     | 群组编号      |
| 2    | pageNumber | int    | 是     | 页码，从1开始 |
| 3    | pageSize   | int    | 是     | 页大小        |
| 4    | account    | String | 否     | 所属账号      |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/abi/list/1/1/5?account=
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数        | 类型          |      | 备注                              |
| ---- | --------------- | ------------- | ---- | --------------------------------- |
| 1    | code            | Int           | 否   | 返回码，0：成功 其它：失败        |
| 2    | message         | String        | 否   | 描述                              |
| 3    |                 | Object        |      | 返回信息实体                      |
| 3.1  | abiId           | int           | 否   | 合约编号                          |
| 3.2  | contractName    | String        | 否   | 合约名称                          |
| 3.3  | groupId         | Int           | 否   | 所属群组编号                      |
| 3.4  | contractAddress | String        | 否   | 合约地址                          |
| 3.5  | contractAbi     | String        | 是   | 导入的abi文件内容                 |
| 3.6  | contractBin     | String        | 是   | 合约runtime-bytecode(runtime-bin) |
| 3.7  | account         | String        | 否   | 所属账号                          |
| 3.8  | createTime      | LocalDateTime | 否   | 创建时间                          |
| 3.9  | modifyTime      | LocalDateTime | 是   | 修改时间                          |


***2）出参示例***

* 成功：

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "abiId": 1,
      "groupId": 1,
      "account": "admin",
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


### 5.9. 导入已部署合约的abi

> 将其他平台已部署的合约导入到本平台进行管理

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/abi**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数


***1）入参表***

| 序号 | 输入参数        | 类型   | 必填 | 备注                        |
| ---- | --------------- | ------ | ------ | --------------------------- |
| 1    | groupId         | int    | 是     | 所属群组编号                |
| 2    | contractAddress | String | 是     | 合约地址                    |
| 3    | contractName    | String | 是     | 合约名称                    |
| 4    | contractAbi     | List<Object> | 是     | 合约编译后生成的abi文件内容 |
| 5    | account         | String | 是     | 所属账号                    |


***2）入参示例***

```
{
    "groupId": 1,
    "account": "admin",
    "contractAddress": "0x3214227e87bccca63893317febadd0b51ade735e",
    "contractName": "HelloWorld",
    "contractAbi": [{"constant":false,"inputs":[{"name":"n","type":"string"}],"name":"set","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"get","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"anonymous":false,"inputs":[{"indexed":false,"name":"name","type":"string"}],"name":"SetName","type":"event"}]
}
```

#### 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data     | object | 是   | 返回信息实体（空）         |


***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success"
}
```


### 5.10. 修改已部署合约的abi

> 将其他平台已部署的合约导入到本平台进行管理

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/abi**
* 请求方式：PUT
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数


***1）入参表***

| 序号 | 输入参数        | 类型   | 必填 | 备注                        |
| ---- | --------------- | ------ | ------ | --------------------------- |
| 1    | abiId           | long   | 是     | abi编号                     |
| 2    | groupId         | int    | 是     | 所属群组编号                |
| 3    | contractAddress | String | 是     | 合约地址                    |
| 4    | contractName    | String | 是     | 合约名称                    |
| 5    | contractAbi     | List<Object> | 是     | 合约编译后生成的abi文件内容 |


***2）入参示例***

```
{
    "abiId": 1,
    "groupId": 1,
    "contractAddress": "0x3214227e87bccca63893317febadd0b51ade735e",
    "contractName": "HelloWorld",
    "contractAbi": [{"constant":false,"inputs":[{"name":"n","type":"string"}],"name":"set","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"get","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"anonymous":false,"inputs":[{"indexed":false,"name":"name","type":"string"}],"name":"SetName","type":"event"}]
}
```

#### 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data     | object | 是   | 返回信息实体（空）         |


***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success"
}
```



### 5.11. 获取全量合约列表（不包含abi/bin）

#### 接口描述

> 根据群组编号和合约状态获取全量合约

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/contract/contractList/all/light?groupId={groupId}&contractStatus={contractStatus}**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**   | **类型**       | **最大长度** | **必填** | **说明** |
| -------- | ------------ | ------------ | -------------- | ------------ | -------- | -------- |
| 1        | 所属群组 | groupId | Integer         |              | 是        |                      |
| 2        | 合约状态 | contractStatus | Integer         |       | 是       |1未部署，2已部署  |

**2）数据格式** 

```
http://127.0.0.1:5001/WeBASE-Node-Manager/contract/contractList/all/light?groupId=1&contractStatus=2
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
| 3.11        | 部署用户地址 | deployAddress | String           | 否       |           |
| 3.12       | 部署用户姓名 | deployUserName | String           | 否       |           |


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


### 5.12. 获取合约路径列表

#### 接口描述

获取合约路径列表

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/contract/findPathList/{groupId}**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**   | **类型**       | **最大长度** | **必填** | **说明** |
| -------- | ------------ | ------------ | -------------- | ------------ | -------- | -------- |
| 1        | 所属群组 | groupId | Integer         |              | 是        |                      |

**2）数据格式** 

```
http://127.0.0.1:5001/WeBASE-Node-Manager/contract/findPathList/1
```

#### 响应参数
**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **必填** | **说明**              |
| -------- | -------- | ---------- | -------- | -------- | --------------------- |
| 1        | 返回码   | code       | String   | 是       | 返回码信息请参看附录1 |
| 2        | 提示信息 | message    | String   | 是       |                       |
| 3        | 返回数据 | data       | Object   |  否        |                       |                       |
| 3.1        | 路径id | id            | Integer                      | 是        |           |
| 3.2        | 群组编号 | groupId            | Integer                      | 是        |           |
| 3.3        | 所在目录  | contractPath | String             | 是       | |
| 3.4        | 修改时间 | modifyTime | String            | 是       |           |
| 3.5        | 创建时间 | createTime | String             | 是       |           |


**2）数据格式**
```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "id": 1,
            "groupId": 1,
            "contractPath": "/",
            "createTime": "2019-06-10 16:42:50",
            "modifyTime": "2019-06-10 16:42:52"
        }
    ]
}
```


### 5.13. 保存合约路径

#### 接口描述

> 保存合约路径

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/contract/contractPath**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**   | **类型**       | **最大长度** | **必填** | **说明** |
| -------- | ------------ | ------------ | -------------- | ------------ | -------- | -------- |
| 1        | 所属群组 | groupId | Integer         |              | 是        |                      |
| 1        | 合约路径 | contractPath | String         |              | 是        |                      |

**2）数据格式** 

```
http://127.0.0.1:5001/WeBASE-Node-Manager/contract/contractPath
```

#### 响应参数
**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **必填** | **说明**              |
| -------- | -------- | ---------- | -------- | -------- | --------------------- |
| 1        | 返回码   | code       | String   | 是       | 返回码信息请参看附录1 |
| 2        | 提示信息 | message    | String   | 是       |                       |
| 3        | 返回数据 | data       | int   |  否        |    增加数                   |


**2）数据格式**
```
{
    "code": 0,
    "message": "success",
    "data": 1 
}
```


### 5.14. 删除合约路径并批量删除合约

#### 接口描述

> 删除合约路径并批量删除合约

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/contract/batch/path**
* 请求方式：DELETE
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**   | **类型**       | **最大长度** | **必填** | **说明** |
| -------- | ------------ | ------------ | -------------- | ------------ | -------- | -------- |
| 1        | 所属群组 | groupId | Integer         |              | 是        |                      |
| 1        | 合约路径 | contractPath | String         |              | 是        |                      |

**2）数据格式** 

```
http://127.0.0.1:5001/WeBASE-Node-Manager/contract/batch/path
```

```
{
    "groupId": 1,
    "contractPath": test
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

### 5.15. 注册cns接口

#### 接口描述

> 注册cns

#### 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址：**/contract/registerCns**
- 请求方式：POST
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                           |
| -------- | -------- | --------------- | -------- | ------------ | -------- | ---------------------------------- |
| 1        | 所属群组 | groupId         | Integer  |              | 是       |                                    |
| 2        | 合约路径 | contractPath    | String   |              | 是       |                                    |
| 3        | 合约名称 | contractName    | String   |              | 是       |                                    |
| 4        | cns名称  | cnsName         | String   |              | 是       |                                    |
| 5        | 合约地址 | contractAddress | String   |              | 是       |                                    |
| 6        | 合约abi  | contractAbi     | List     |              | 是       | abi文件里面的内容，是一个JSONArray |
| 7        | cns版本  | version         | String   |              | 是       |                                    |
| 8        | 用户地址 | userAddress     | String   |              | 是       |                                    |

**2）数据格式**

```
{
  "groupId": 1,
  "contractPath": "/",
  "contractName": "Hello",
  "cnsName": "Hello",
  "version": "v0.4",
  "contractAddress": "0xcaff8fdf1d461b91c7c8f0ff2af2f79a80bc189e",
  "contractAbi": [{"cons tant":false,"inputs":[{"name":"n","type":"string","type0":null,"indexed":false}],"name":"set","outputs":[{"name":"","type":"string","type0":null,"indexed":false}],"type":"function","payable":false,"stateMutability":"nonpayable"},{"co nstant":true,"inputs":[],"name":"get","outputs":[{"name":"","type":"string","type0":null,"indexed":false}],"type":"function","payable":false,"stateMutability":"view"},{"constant":false,"inputs":[{"name":"name","type":"string","type0":null,"indexed":false}],"name":"SetName","outputs":null,"type":"event","payable":false,"stateMutability":null}],
  "userAddress": "0x8c808ff5beee7b4cfb17f141f6237db93a668e46"
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

### 5.16. 根据合约地址获取cns信息

#### 接口描述

> 根据合约地址获取该合约地址最新的cns信息

#### 传输协议规范

- 网络传输协议：使用HTTP协议

- 请求地址：**/contract/findCns**

- 请求方式：POST

  请求头：Content-type: application/json

- 返回格式：JSON

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**      | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | --------------- | -------- | ------------ | -------- | -------- |
| 1        | 所属群组 | groupId         | Integer  |              | 是       |          |
| 2        | 合约地址 | contractAddress | String   |              | 是       |          |

**2）数据格式** 

```
http://127.0.0.1:5001/WeBASE-Node-Manager/contract/findCns
```

```
{
    "groupId": 1,
    "contractAddress": "0xcaff8fdf1d461b91c7c8f0ff2af2f79a80bc189e"
}
```

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名**      | **类型** | **必填** | **说明**              |
| -------- | -------- | --------------- | -------- | -------- | --------------------- |
| 1        | 返回码   | code            | String   | 是       | 返回码信息请参看附录1 |
| 2        | 提示信息 | message         | String   | 是       |                       |
| 3        | 返回数据 | data            | Object   | 否       |                       |
| 3.1      | 编号     | id              | Integer  | 是       |                       |
| 3.2      | 群组编号 | groupId         | Integer  | 是       |                       |
| 3.3      | 合约路径 | contractPath    | String   | 是       |                       |
| 3.4      | 合约名称 | contractName    | String   | 是       |                       |
| 3.5      | cns名称  | cnsName         | String   | 是       |                       |
| 3.6      | cns版本  | version         | String   | 是       |                       |
| 3.7      | 合约地址 | contractAddress | String   | 是       |                       |
| 3.8      | 修改时间 | modifyTime      | String   | 是       |                       |
| 3.9      | 创建时间 | createTime      | String   | 是       |                       |

**2）数据格式**

```
{
    "code": 0,
    "message": "success",
    "data": {
		"id": 1,
		"groupId": 1,
        "contractPath": "/",
		"contractName": "Hello",
		"cnsName": "Hello",
		"version": "v0.4",
		"contractAddress": "0xcaff8fdf1d461b91c7c8f0ff2af2f79a80bc189e",
		"createTime": "2020-12-30 16:32:28",
		"modifyTime": "2020-12-30 16:32:28"
	  }
}
```

### 5.17. 获取本地cns信息列表

#### 接口描述

> 获取本地cns信息列表

#### 传输协议规范

- 网络传输协议：使用HTTP协议

- 请求地址：**/contract/findCnsList**

- 请求方式：POST

  请求头：Content-type: application/json

- 返回格式：JSON

#### 请求参数

**1）参数表**

| **序号** | **中文**   | **参数名**      | **类型** | **最大长度** | **必填** | **说明** |
| -------- | ---------- | --------------- | -------- | ------------ | -------- | -------- |
| 1        | 所属群组   | groupId         | Integer  |              | 是       |          |
| 2        | 每页记录数 | pageSize        | Integer  |              | 是       |          |
| 3        | 当前页码   | pageNumber      | Integer  |              | 是       |          |
| 4        | cns名称    | cnsName         | String   |              | 否       |          |
| 5        | cns版本    | version         | String   |              | 否       |          |
| 6        | 合约地址   | contractAddress | String   |              | 否       |          |

**2）数据格式** 

```
http://127.0.0.1:5001/WeBASE-Node-Manager/contract/findCnsList
```

```
{
    "groupId": 1,
    "pageSize": 1,
    "pageNumber": 1
}
```

#### 响应参数

**1）参数表**

| **序号** | **中文**     | **参数名**      | **类型** | **必填** | **说明**              |
| -------- | ------------ | --------------- | -------- | -------- | --------------------- |
| 1        | 返回码       | code            | String   | 是       | 返回码信息请参看附录1 |
| 2        | 提示信息     | message         | String   | 是       |                       |
| 3        | 记录数       | totalCount      | Int      | 否       | 总记录数              |
| 4        | 返回数据     | data            | List     | 否       |                       |
| 4.1      | 返回信息实体 |                 | Object   | 否       |                       |
| 4.1.1    | 编号         | id              | Integer  | 是       |                       |
| 4.1.2    | 群组编号     | groupId         | Integer  | 是       |                       |
| 4.1.3    | 合约路径     | contractPath    | String   | 是       |                       |
| 4.1.4    | 合约名称     | contractName    | String   | 是       |                       |
| 4.1.5    | cns名称      | cnsName         | String   | 是       |                       |
| 4.1.6    | cns版本      | version         | String   | 是       |                       |
| 4.1.7    | 合约地址     | contractAddress | String   | 是       |                       |
| 4.1.8    | 合约Abi      | contractAbi     | String   | 是       |                       |
| 4.1.9    | 修改时间     | modifyTime      | String   | 是       |                       |
| 4.1.10   | 创建时间     | createTime      | String   | 是       |                       |

**2）数据格式**

```
{
    "code": 0,
    "message": "success",
    "data": [
	  {
		"id": 1,
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
	],
    "totalCount": 1
}
```



### 5.18 获取合约与导入ABI列表（分页）  


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址： **/abi/list/all/{groupId}/{pageNumber}/{pageSize}?account={account}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型   | 必填 | 备注          |
| ---- | ---------- | ------ | ------ | ------------- |
| 1    | groupId    | int    | 是     | 群组编号      |
| 2    | pageNumber | int    | 是     | 页码，从1开始 |
| 3    | pageSize   | int    | 是     | 页大小        |
| 4    | account    | String | 否     | 所属账号      |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/abi/list/all/1/1/5?account=
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数        | 类型          |      | 备注                              |
| ---- | --------------- | ------------- | ---- | --------------------------------- |
| 1    | code            | Int           | 否   | 返回码，0：成功 其它：失败        |
| 2    | message         | String        | 否   | 描述                              |
| 3  |        | Object        |      | 返回数据                      |
| 3.0  | contractId      | int        |      | 合约编号（contractId为空时，说明合约为外部导入的）                      |
| 3.1  | abiId           | int           | 否   | 合约编号                          |
| 3.2  | contractName    | String        | 否   | 合约名称                          |
| 3.3  | groupId         | Int           | 否   | 所属群组编号                      |
| 3.4  | contractAddress | String        | 否   | 合约地址                          |
| 3.5  | contractAbi     | String        | 是   | 导入的abi文件内容                 |
| 3.6  | contractBin     | String        | 是   | 合约runtime-bytecode(runtime-bin) |
| 3.7  | account         | String        | 否   | 所属账号                          |
| 3.8  | createTime      | LocalDateTime | 否   | 创建时间                          |
| 3.9  | modifyTime      | LocalDateTime | 是   | 修改时间                          |
| 3.10  | contractPath    | String | 是   | 合约路径                          |
| 3.11  | contractStatus   | int | 是   | 合约状态                         |
| 3.12   | deployAddress | String           | 否       |  部署用户地址       |
| 3.13  | deployUserName | String           | 否       |    部署用户名      |

***2）出参示例***

* 成功：

```
{
	"code": 0,
	"message": "success",
	"data": [{
		"contractId": null,
		"contractPath": null,
		"contractVersion": null,
		"contractName": "c",
		"account": null,
		"contractStatus": null,
		"groupId": 1,
		"contractType": null,
		"contractSource": null,
		"contractAbi": "[{\"constant\":false,\"inputs\":[{\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"register\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"}]",
		"contractBin": null,
		"bytecodeBin": null,
		"contractAddress": "0x4ac92d4d1680f426ac2da943b3ff67e82976d075",
		"deployTime": null,
		"description": null,
		"createTime": "2021-04-07 09:29:54",
		"modifyTime": "2021-04-07 09:29:54",
		"deployAddress": null,
		"deployUserName": null,
		"abiId": 8
	}, {
		"contractId": 200013,
		"contractPath": "weid_0xcde7c667528b6df1b61fd6483a0925ccc67931a02394acab1835254546e67d80",
		"contractVersion": null,
		"contractName": "SpecificIssuerController",
		"account": "admin",
		"contractStatus": 2,
		"groupId": 1,
		"contractType": 2,
		"contractSource": null,
		"contractAbi": "[{\"constant\":false,\"inputs\":[{\"name\":\"typeName\",\"type\":\"bytes32\"},{\"name\":\"addr\",\"type\":\"address\"}],\"name\":\"addIssuer\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"typeName\",\"type\":\"bytes32\"},{\"name\":\"addr\",\"type\":\"address\"}],\"name\":\"isSpecificTypeIssuer\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"typeName\",\"type\":\"bytes32\"},{\"name\":\"extraValue\",\"type\":\"bytes32\"}],\"name\":\"addExtraValue\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"typeName\",\"type\":\"bytes32\"}],\"name\":\"registerIssuerType\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"typeName\",\"type\":\"bytes32\"}],\"name\":\"getExtraValue\",\"outputs\":[{\"name\":\"\",\"type\":\"bytes32[]\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"typeName\",\"type\":\"bytes32\"}],\"name\":\"isIssuerTypeExist\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"typeName\",\"type\":\"bytes32\"},{\"name\":\"addr\",\"type\":\"address\"}],\"name\":\"removeIssuer\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"typeName\",\"type\":\"bytes32\"},{\"name\":\"startPos\",\"type\":\"uint256\"},{\"name\":\"num\",\"type\":\"uint256\"}],\"name\":\"getSpecificTypeIssuerList\",\"outputs\":[{\"name\":\"\",\"type\":\"address[]\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"name\":\"specificIssuerDataAddress\",\"type\":\"address\"},{\"name\":\"roleControllerAddress\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"name\":\"operation\",\"type\":\"uint256\"},{\"indexed\":false,\"name\":\"retCode\",\"type\":\"uint256\"},{\"indexed\":false,\"name\":\"typeName\",\"type\":\"bytes32\"},{\"indexed\":false,\"name\":\"addr\",\"type\":\"address\"}],\"name\":\"SpecificIssuerRetLog\",\"type\":\"event\"}]",
		"contractBin": "",
		"bytecodeBin": "",
		"contractAddress": "0xce1d576181e1d68899a3f2b86c8e274657c07fea",
		"deployTime": null,
		"description": null,
		"createTime": "2021-04-06 21:34:38",
		"modifyTime": "2021-04-06 21:34:38",
		"deployAddress": null,
		"deployUserName": null,
		"abiId": 6
	}],
	"totalCount": 2
}
```

### 5.17. 导入合约仓库到IDE

#### 接口描述

> 保存多个合约

#### 传输协议规范

* 网络传输协议：HTTP协议
* 请求地址：**/contract/copy**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

**1）参数表**

| **序号** | **中文**   | **参数名**      | **类型** | **最大长度** | **必填** | **说明** |
| -------- | ---------- | --------------- | -------- | ------------ | -------- | -------- |
| 1        | 所属群组   | groupId         | Integer  |              | 是       |          |
| 2        | 合约IDE路径 | contractPath     | String  |              | 是       | 默认为"/"         |
| 3        | 合约所属用户   | account      | String  |              | 是       |          |
| 4        | 合约内容    | contractItems         | List   |              | 是       |  RepCopyContractItem的List        |
| 4.1        | 合约名称   | contractName         | String   |              | 是       |          |
| 4.2        | 合约源码   | contractSource | String   |              | 是       |   Base64编码       |

**2）数据格式** 

```
http://127.0.0.1:5001/WeBASE-Node-Manager/contract/copy
```

```
{
	"contractItems": [{
		"contractName": "Evidence",
		"contractSource": "cHJhZ21hIHNvbGlkaXR5IF4wLjQuNDsKY29udHJhY3QgRXZpZGVuY2VTaWduZXJzRGF0YUFCSXsgZnVuY3Rpb24gdmVyaWZ5KGFkZHJlc3MgYWRkcilwdWJsaWMgY29uc3RhbnQgcmV0dXJucyhib29sKXt9CmZ1bmN0aW9uIGdldFNpZ25lcih1aW50IGluZGV4KXB1YmxpYyBjb25zdGFudCByZXR1cm5zKGFkZHJlc3Mpe30gCmZ1bmN0aW9uIGdldFNpZ25lcnNTaXplKCkgcHVibGljIGNvbnN0YW50IHJldHVybnModWludCl7fQp9Cgpjb250cmFjdCBFdmlkZW5jZXsKICAgIAogICAgc3RyaW5nIGV2aWRlbmNlOwogICAgc3RyaW5nIGV2aWRlbmNlSW5mbzsKICAgIHN0cmluZyBldmlkZW5jZUlkOwogICAgdWludDhbXSBfdjsKICAgIGJ5dGVzMzJbXSBfcjsKICAgIGJ5dGVzMzJbXSBfczsKICAgIGFkZHJlc3NbXSBzaWduZXJzOwogICAgYWRkcmVzcyBwdWJsaWMgc2lnbmVyc0FkZHI7CiAgICAKICAgICAgICBldmVudCBhZGRTaWduYXR1cmVzRXZlbnQoc3RyaW5nIGV2aSwgc3RyaW5nIGluZm8sIHN0cmluZyBpZCwgdWludDggdiwgYnl0ZXMzMiByLCBieXRlczMyIHMpOwogICAgICAgIGV2ZW50IG5ld1NpZ25hdHVyZXNFdmVudChzdHJpbmcgZXZpLCBzdHJpbmcgaW5mbywgc3RyaW5nIGlkLCB1aW50OCB2LCBieXRlczMyIHIsIGJ5dGVzMzIgcyxhZGRyZXNzIGFkZHIpOwogICAgICAgIGV2ZW50IGVycm9yTmV3U2lnbmF0dXJlc0V2ZW50KHN0cmluZyBldmksIHN0cmluZyBpbmZvLCBzdHJpbmcgaWQsIHVpbnQ4IHYsIGJ5dGVzMzIgciwgYnl0ZXMzMiBzLGFkZHJlc3MgYWRkcik7CiAgICAgICAgZXZlbnQgZXJyb3JBZGRTaWduYXR1cmVzRXZlbnQoc3RyaW5nIGV2aSwgc3RyaW5nIGluZm8sIHN0cmluZyBpZCwgdWludDggdiwgYnl0ZXMzMiByLCBieXRlczMyIHMsYWRkcmVzcyBhZGRyKTsKICAgICAgICBldmVudCBhZGRSZXBlYXRTaWduYXR1cmVzRXZlbnQoc3RyaW5nIGV2aSwgc3RyaW5nIGluZm8sIHN0cmluZyBpZCwgdWludDggdiwgYnl0ZXMzMiByLCBieXRlczMyIHMpOwogICAgICAgIGV2ZW50IGVycm9yUmVwZWF0U2lnbmF0dXJlc0V2ZW50KHN0cmluZyBldmksIHN0cmluZyBpZCwgdWludDggdiwgYnl0ZXMzMiByLCBieXRlczMyIHMsIGFkZHJlc3MgYWRkcik7CgogICAgZnVuY3Rpb24gQ2FsbFZlcmlmeShhZGRyZXNzIGFkZHIpIHB1YmxpYyBjb25zdGFudCByZXR1cm5zKGJvb2wpIHsKICAgICAgICByZXR1cm4gRXZpZGVuY2VTaWduZXJzRGF0YUFCSShzaWduZXJzQWRkcikudmVyaWZ5KGFkZHIpOwogICAgfQoKICAgICAgIGZ1bmN0aW9uIEV2aWRlbmNlKHN0cmluZyBldmksIHN0cmluZyBpbmZvLCBzdHJpbmcgaWQsIHVpbnQ4IHYsIGJ5dGVzMzIgciwgYnl0ZXMzMiBzLCBhZGRyZXNzIGFkZHIsIGFkZHJlc3Mgc2VuZGVyKSBwdWJsaWMgewogICAgICAgc2lnbmVyc0FkZHIgPSBhZGRyOwogICAgICAgaWYoQ2FsbFZlcmlmeShzZW5kZXIpKQogICAgICAgewogICAgICAgICAgIGV2aWRlbmNlID0gZXZpOwogICAgICAgICAgIGV2aWRlbmNlSW5mbyA9IGluZm87CiAgICAgICAgICAgZXZpZGVuY2VJZCA9IGlkOwogICAgICAgICAgIF92LnB1c2godik7CiAgICAgICAgICAgX3IucHVzaChyKTsKICAgICAgICAgICBfcy5wdXNoKHMpOwogICAgICAgICAgIHNpZ25lcnMucHVzaChzZW5kZXIpOwogICAgICAgICAgIG5ld1NpZ25hdHVyZXNFdmVudChldmksaW5mbyxpZCx2LHIscyxhZGRyKTsKICAgICAgIH0KICAgICAgIGVsc2UKICAgICAgIHsKICAgICAgICAgICBlcnJvck5ld1NpZ25hdHVyZXNFdmVudChldmksaW5mbyxpZCx2LHIscyxhZGRyKTsKICAgICAgIH0KICAgIH0KCiAgICAgICAgZnVuY3Rpb24gZ2V0RXZpZGVuY2VJbmZvKCkgcHVibGljIGNvbnN0YW50IHJldHVybnMoc3RyaW5nKXsKICAgICAgICAgICAgcmV0dXJuIGV2aWRlbmNlSW5mbzsKICAgIH0KCiAgICBmdW5jdGlvbiBnZXRFdmlkZW5jZSgpIHB1YmxpYyBjb25zdGFudCByZXR1cm5zKHN0cmluZyxzdHJpbmcsc3RyaW5nLHVpbnQ4W10sYnl0ZXMzMltdLGJ5dGVzMzJbXSxhZGRyZXNzW10pewogICAgICAgIHVpbnQgbGVuZ3RoID0gRXZpZGVuY2VTaWduZXJzRGF0YUFCSShzaWduZXJzQWRkcikuZ2V0U2lnbmVyc1NpemUoKTsKICAgICAgICAgYWRkcmVzc1tdIG1lbW9yeSBzaWduZXJMaXN0ID0gbmV3IGFkZHJlc3NbXShsZW5ndGgpOwogICAgICAgICBmb3IodWludCBpPSAwIDtpPGxlbmd0aCA7aSsrKQogICAgICAgICB7CiAgICAgICAgICAgICBzaWduZXJMaXN0W2ldID0gKEV2aWRlbmNlU2lnbmVyc0RhdGFBQkkoc2lnbmVyc0FkZHIpLmdldFNpZ25lcihpKSk7CiAgICAgICAgIH0KICAgICAgICByZXR1cm4oZXZpZGVuY2UsZXZpZGVuY2VJbmZvLGV2aWRlbmNlSWQsX3YsX3IsX3Msc2lnbmVyTGlzdCk7CiAgICB9CgogICAgZnVuY3Rpb24gYWRkU2lnbmF0dXJlcyh1aW50OCB2LCBieXRlczMyIHIsIGJ5dGVzMzIgcykgcHVibGljIHJldHVybnMoYm9vbCkgewogICAgICAgIGZvcih1aW50IGk9IDAgO2k8c2lnbmVycy5sZW5ndGggO2krKykKICAgICAgICB7CiAgICAgICAgICAgIGlmKG1zZy5zZW5kZXIgPT0gc2lnbmVyc1tpXSkKICAgICAgICAgICAgewogICAgICAgICAgICAgICAgaWYoIF92W2ldID09IHYgJiYgX3JbaV0gPT0gciAmJiBfc1tpXSA9PSBzKQogICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAgIGFkZFJlcGVhdFNpZ25hdHVyZXNFdmVudChldmlkZW5jZSxldmlkZW5jZUluZm8sZXZpZGVuY2VJZCx2LHIscyk7CiAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICBlbHNlCiAgICAgICAgICAgICAgICB7CiAgICAgICAgICAgICAgICAgICAgIGVycm9yUmVwZWF0U2lnbmF0dXJlc0V2ZW50KGV2aWRlbmNlLGV2aWRlbmNlSWQsdixyLHMsbXNnLnNlbmRlcik7CiAgICAgICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgIH0KICAgICAgIGlmKENhbGxWZXJpZnkobXNnLnNlbmRlcikpCiAgICAgICB7CiAgICAgICAgICAgIF92LnB1c2godik7CiAgICAgICAgICAgIF9yLnB1c2gocik7CiAgICAgICAgICAgIF9zLnB1c2gocyk7CiAgICAgICAgICAgIHNpZ25lcnMucHVzaChtc2cuc2VuZGVyKTsKICAgICAgICAgICAgYWRkU2lnbmF0dXJlc0V2ZW50KGV2aWRlbmNlLGV2aWRlbmNlSW5mbyxldmlkZW5jZUlkLHYscixzKTsKICAgICAgICAgICAgcmV0dXJuIHRydWU7CiAgICAgICB9CiAgICAgICBlbHNlCiAgICAgICB7CiAgICAgICAgICAgZXJyb3JBZGRTaWduYXR1cmVzRXZlbnQoZXZpZGVuY2UsZXZpZGVuY2VJbmZvLGV2aWRlbmNlSWQsdixyLHMsbXNnLnNlbmRlcik7CiAgICAgICAgICAgcmV0dXJuIGZhbHNlOwogICAgICAgfQogICAgfQogICAgCiAgICBmdW5jdGlvbiBnZXRTaWduZXJzKClwdWJsaWMgY29uc3RhbnQgcmV0dXJucyhhZGRyZXNzW10pCiAgICB7CiAgICAgICAgIHVpbnQgbGVuZ3RoID0gRXZpZGVuY2VTaWduZXJzRGF0YUFCSShzaWduZXJzQWRkcikuZ2V0U2lnbmVyc1NpemUoKTsKICAgICAgICAgYWRkcmVzc1tdIG1lbW9yeSBzaWduZXJMaXN0ID0gbmV3IGFkZHJlc3NbXShsZW5ndGgpOwogICAgICAgICBmb3IodWludCBpPSAwIDtpPGxlbmd0aCA7aSsrKQogICAgICAgICB7CiAgICAgICAgICAgICBzaWduZXJMaXN0W2ldID0gKEV2aWRlbmNlU2lnbmVyc0RhdGFBQkkoc2lnbmVyc0FkZHIpLmdldFNpZ25lcihpKSk7CiAgICAgICAgIH0KICAgICAgICAgcmV0dXJuIHNpZ25lckxpc3Q7CiAgICB9Cn0="
	}, {
		"contractName": "EvidenceSignersData",
		"contractSource": "cHJhZ21hIHNvbGlkaXR5IF4wLjQuNDsKaW1wb3J0ICJFdmlkZW5jZS5zb2wiOwoKY29udHJhY3QgRXZpZGVuY2VTaWduZXJzRGF0YXsKICAgICAgICBhZGRyZXNzW10gc2lnbmVyczsKCQlldmVudCBuZXdFdmlkZW5jZUV2ZW50KGFkZHJlc3MgYWRkcik7CiAgICAgICAgZnVuY3Rpb24gbmV3RXZpZGVuY2Uoc3RyaW5nIGV2aSwgc3RyaW5nIGluZm8sc3RyaW5nIGlkLHVpbnQ4IHYsIGJ5dGVzMzIgcixieXRlczMyIHMpcHVibGljIHJldHVybnMoYWRkcmVzcykKICAgICAgICB7CiAgICAgICAgICAgIEV2aWRlbmNlIGV2aWRlbmNlID0gbmV3IEV2aWRlbmNlKGV2aSwgaW5mbywgaWQsIHYsIHIsIHMsIHRoaXMsIG1zZy5zZW5kZXIpOwogICAgICAgICAgICBuZXdFdmlkZW5jZUV2ZW50KGV2aWRlbmNlKTsKICAgICAgICAgICAgcmV0dXJuIGV2aWRlbmNlOwogICAgICAgIH0KCiAgICAgICAgZnVuY3Rpb24gRXZpZGVuY2VTaWduZXJzRGF0YShhZGRyZXNzW10gZXZpZGVuY2VTaWduZXJzKXB1YmxpY3sKICAgICAgICAgICAgZm9yKHVpbnQgaT0wOyBpPGV2aWRlbmNlU2lnbmVycy5sZW5ndGg7ICsraSkgewogICAgICAgICAgICBzaWduZXJzLnB1c2goZXZpZGVuY2VTaWduZXJzW2ldKTsKCQkJfQoJCX0KCiAgICBmdW5jdGlvbiB2ZXJpZnkoYWRkcmVzcyBhZGRyKXB1YmxpYyBjb25zdGFudCByZXR1cm5zKGJvb2wpewogICAgZm9yKHVpbnQgaT0wOyBpPHNpZ25lcnMubGVuZ3RoOyArK2kpIHsKICAgICAgICBpZiAoYWRkciA9PSBzaWduZXJzW2ldKQogICAgICAgIHsKICAgICAgICAgICAgcmV0dXJuIHRydWU7CiAgICAgICAgfQogICAgfQogICAgcmV0dXJuIGZhbHNlOwp9CgogICAgZnVuY3Rpb24gZ2V0U2lnbmVyKHVpbnQgaW5kZXgpcHVibGljIGNvbnN0YW50IHJldHVybnMoYWRkcmVzcyl7CiAgICAgICAgdWludCBsaXN0U2l6ZSA9IHNpZ25lcnMubGVuZ3RoOwogICAgICAgIGlmKGluZGV4IDwgbGlzdFNpemUpCiAgICAgICAgewogICAgICAgICAgICByZXR1cm4gc2lnbmVyc1tpbmRleF07CiAgICAgICAgfQogICAgICAgIGVsc2UKICAgICAgICB7CiAgICAgICAgICAgIHJldHVybiAwOwogICAgICAgIH0KCiAgICB9CgogICAgZnVuY3Rpb24gZ2V0U2lnbmVyc1NpemUoKSBwdWJsaWMgY29uc3RhbnQgcmV0dXJucyh1aW50KXsKICAgICAgICByZXR1cm4gc2lnbmVycy5sZW5ndGg7CiAgICB9CgogICAgZnVuY3Rpb24gZ2V0U2lnbmVycygpIHB1YmxpYyBjb25zdGFudCByZXR1cm5zKGFkZHJlc3NbXSl7CiAgICAgICAgcmV0dXJuIHNpZ25lcnM7CiAgICB9Cgp9"
	}],
	"contractPath": "Evidence1",
	"groupId": "1",
	"account": "mars"
}
```

#### 响应参数

**1）参数表**

| **序号** | **中文**     | **参数名**      | **类型** | **必填** | **说明**              |
| -------- | ------------ | --------------- | -------- | -------- | --------------------- |
| 1        | 返回码       | code            | String   | 是       | 返回码信息请参看附录1 |
| 2        | 提示信息     | message         | String   | 是       |                       |
| 3        | 数据       | data      | Int      | 否       | copy合约数              |


**2）数据格式**

```
{
    "code": 0,
    "message": "success",
    "data": 2
}
```



### 5.19. 获取合约仓库列表

#### 接口描述

> 返回合约仓库信息列表

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/warehouse/list**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

无

**2）数据格式** 

```
http://localhost:5001/WeBASE-Node-Manager/warehouse/list
```

#### 响应参数

**1）数据格式**

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "id": 1,
      "warehouseName": "工具箱",
      "warehouseNameEn": "Toolbox",
      "type": "1",
      "warehouseIcon": "toolboxId",
      "description": "工具箱中有常用的工具合约",
      "warehouseDetail": "工具箱中有常用的工具合约",
      "descriptionEn": "Toolbox Contract suite",
      "warehouseDetailEn": "Toolbox Contract suite",
      "createTime": "2021-01-20 18:02:10",
      "modifyTime": "2021-01-20 18:02:10"
    },
    {
      "id": 2,
      "warehouseName": "存证应用",
      "warehouseNameEn": "Evidence",
      "type": "2",
      "warehouseIcon": "evidenceId",
      "description": "一套区块链存证合约",
      "warehouseDetail": "一套区块链存证合约",
      "descriptionEn": "Evidence Contract suite",
      "warehouseDetailEn": "Evidence Contract suite",
      "createTime": "2021-01-20 18:02:10",
      "modifyTime": "2021-01-20 18:02:10"
    },
    {
      "id": 3,
      "warehouseName": "积分应用",
      "warehouseNameEn": "Points",
      "type": "3",
      "warehouseIcon": "pointsId",
      "description": "一套积分合约",
      "warehouseDetail": "一套积分合约",
      "descriptionEn": "Points Contract suite",
      "warehouseDetailEn": "Points Contract suite",
      "createTime": "2021-01-20 18:02:10",
      "modifyTime": "2021-01-20 18:02:10"
    }
  ]
}
```

### 5.20. 根据仓库编号获取仓库信息

#### 接口描述

> 返回合约仓库信息

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/warehouse?warehouseId={warehouseId}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 仓库编号 | warehouseId    | int      |              | 是       |          |

**2）数据格式** 

```
http://localhost:5001/WeBASE-Node-Manager/warehouse?warehouseId=1
```

#### 响应参数

**1）数据格式**

```
{
  "code": 0,
  "message": "success",
  "data": {
    "id": 1,
    "warehouseName": "工具箱",
    "warehouseNameEn": "Toolbox",
    "type": "1",
    "warehouseIcon": "toolboxId",
    "description": "工具箱中有常用的工具合约",
    "warehouseDetail": "工具箱中有常用的工具合约",
    "descriptionEn": "Toolbox Contract suite",
    "warehouseDetailEn": "Toolbox Contract suite",
    "createTime": "2021-01-20 18:02:10",
    "modifyTime": "2021-01-20 18:02:10"
  }
}
```

### 5.21. 根据仓库编号获取合约文件夹信息

#### 接口描述

> 返回合约文件夹信息

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/warehouse/folder/list?warehouseId={warehouseId}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 仓库编号 | warehouseId    | int      |              | 是       |          |

**2）数据格式** 

```
http://localhost:5001/WeBASE-Node-Manager/warehouse/folder/list?warehouseId=1
```

#### 响应参数

**1）数据格式**

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "id": 2,
      "folderName": "Evidence",
      "folderDesc": "Evidence",
      "folderDetail": "Evidence",
      "folderDescEn": "Evidence",
      "folderDetailEn": "Evidence",
      "createTime": "2021-01-20 18:02:10",
      "modifyTime": "2021-01-20 18:02:10"
    }
  ]
}
```

### 5.22. 根据合约文件夹编号获取合约文件夹信息

#### 接口描述

> 返回合约文件夹信息

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/warehouse/folder?folderId={folderId}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**       | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------------- | ---------------- | -------- | ------------ | -------- | -------- |
| 1        | 合约文件夹编号 | folderId | int      |              | 是       |          |

**2）数据格式** 

```
http://localhost:5001/WeBASE-Node-Manager/warehouse/folder?folderId=2
```

#### 响应参数

**1）数据格式**

```
{
  "code": 0,
  "message": "success",
  "data": {
    "id": 2,
    "folderName": "Evidence",
    "folderDesc": "Evidence",
    "folderDetail": "Evidence",
    "folderDescEn": "Evidence",
    "folderDetailEn": "Evidence",
    "createTime": "2021-01-20 18:02:10",
    "modifyTime": "2021-01-20 18:02:10"
  }
}
```

### 5.23. 根据文件夹编号获取合约列表

#### 接口描述

> 返回合约信息列表

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/warehouse/item/list?folderId={folderId}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文**   | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | ---------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 文件夹编号 | folderId   | int      |              | 是       |          |

**2）数据格式** 

```
http://localhost:5001/WeBASE-Node-Manager/warehouse/item/list?folderId=2
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
      "contractDescEn": "Evidence",
      "createTime": "2021-01-20 18:02:10",
      "modifyTime": "2021-01-20 18:02:10"
    },
    {
      "contractId": 5,
      "contractFolderId": 2,
      "contractName": "EvidenceSignersData",
      "contractDesc": "EvidenceSignersData",
      "contractSrc": "cHJhZ21hIHNvbGlkaXR5IF4wLjQuNDsKaW1wb3J0ICJFdmlkZW5jZS5zb2wiOwoKY29udHJhY3QgRXZpZGVuY2VTaWduZXJzRGF0YXsKICAgICAgICBhZGRyZXNzW10gc2lnbmVyczsKCQlldmVudCBuZXdFdmlkZW5jZUV2ZW50KGFkZHJlc3MgYWRkcik7CiAgICAgICAgZnVuY3Rpb24gbmV3RXZpZGVuY2Uoc3RyaW5nIGV2aSwgc3RyaW5nIGluZm8sc3RyaW5nIGlkLHVpbnQ4IHYsIGJ5dGVzMzIgcixieXRlczMyIHMpcHVibGljIHJldHVybnMoYWRkcmVzcykKICAgICAgICB7CiAgICAgICAgICAgIEV2aWRlbmNlIGV2aWRlbmNlID0gbmV3IEV2aWRlbmNlKGV2aSwgaW5mbywgaWQsIHYsIHIsIHMsIHRoaXMsIG1zZy5zZW5kZXIpOwogICAgICAgICAgICBuZXdFdmlkZW5jZUV2ZW50KGV2aWRlbmNlKTsKICAgICAgICAgICAgcmV0dXJuIGV2aWRlbmNlOwogICAgICAgIH0KCiAgICAgICAgZnVuY3Rpb24gRXZpZGVuY2VTaWduZXJzRGF0YShhZGRyZXNzW10gZXZpZGVuY2VTaWduZXJzKXB1YmxpY3sKICAgICAgICAgICAgZm9yKHVpbnQgaT0wOyBpPGV2aWRlbmNlU2lnbmVycy5sZW5ndGg7ICsraSkgewogICAgICAgICAgICBzaWduZXJzLnB1c2goZXZpZGVuY2VTaWduZXJzW2ldKTsKCQkJfQoJCX0KCiAgICBmdW5jdGlvbiB2ZXJpZnkoYWRkcmVzcyBhZGRyKXB1YmxpYyBjb25zdGFudCByZXR1cm5zKGJvb2wpewogICAgZm9yKHVpbnQgaT0wOyBpPHNpZ25lcnMubGVuZ3RoOyArK2kpIHsKICAgICAgICBpZiAoYWRkciA9PSBzaWduZXJzW2ldKQogICAgICAgIHsKICAgICAgICAgICAgcmV0dXJuIHRydWU7CiAgICAgICAgfQogICAgfQogICAgcmV0dXJuIGZhbHNlOwp9CgogICAgZnVuY3Rpb24gZ2V0U2lnbmVyKHVpbnQgaW5kZXgpcHVibGljIGNvbnN0YW50IHJldHVybnMoYWRkcmVzcyl7CiAgICAgICAgdWludCBsaXN0U2l6ZSA9IHNpZ25lcnMubGVuZ3RoOwogICAgICAgIGlmKGluZGV4IDwgbGlzdFNpemUpCiAgICAgICAgewogICAgICAgICAgICByZXR1cm4gc2lnbmVyc1tpbmRleF07CiAgICAgICAgfQogICAgICAgIGVsc2UKICAgICAgICB7CiAgICAgICAgICAgIHJldHVybiAwOwogICAgICAgIH0KCiAgICB9CgogICAgZnVuY3Rpb24gZ2V0U2lnbmVyc1NpemUoKSBwdWJsaWMgY29uc3RhbnQgcmV0dXJucyh1aW50KXsKICAgICAgICByZXR1cm4gc2lnbmVycy5sZW5ndGg7CiAgICB9CgogICAgZnVuY3Rpb24gZ2V0U2lnbmVycygpIHB1YmxpYyBjb25zdGFudCByZXR1cm5zKGFkZHJlc3NbXSl7CiAgICAgICAgcmV0dXJuIHNpZ25lcnM7CiAgICB9Cgp9",
      "contractDescEn": "EvidenceSignersData",
      "createTime": "2021-01-20 18:02:10",
      "modifyTime": "2021-01-20 18:02:10"
    }
  ]
}
```

### 5.24. 根据合约编号获取合约信息

#### 接口描述

> 返回合约信息

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/warehouse/item?contractId={contractId}**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 合约编号 | contractId | int      |              | 是       |          |

**2）数据格式** 

```
http://localhost:5001/WeBASE-Node-Manager/warehouse/item?contractId=2
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
    "contractDescEn": "LibSafeMathForUint256Utils",
    "createTime": "2021-01-20 18:02:10",
    "modifyTime": "2021-01-20 18:02:10"
  }
}
```


### 5.25. 查询合约管理者列表

根据群组ID和合约地址，返回在WeBASE拥有私钥的合约部署者或链委员（若链委员非空）私钥用户

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/contract/listManager/{groupId}/{contractAddress}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数


***1）入参表***

| 序号 | 输入参数        | 类型   | 必填 | 备注             |
| ---- | --------------- | ------ | ------ | ---------------- |
| 1    | groupId         | int    | 是     | 群组id           |
| 2    | contractAddress | String | 否     | 合约地址         |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/contract/listManager/1/0x622ca15aa841e92eb65da1a0e59c1b6bb61e3ecb
```


#### 返回参数 

***1）出参表***

| 序号   | 输出参数        | 类型          |      | 备注                                        |
| ------ | --------------- | ------------- | ---- | ------------------------------------------- |
| 1      | code            | Int           | 否   | 返回码，0：成功 其它：失败                  |
| 2      | message         | String        | 否   | 描述                                        |
| 3      | totalCount      | Int           | 否   | 总记录数                                    |
| 4      | data        | List          | 是   | 用户列表                           |
| 4.1    |             | Object        |      | 用户信息对象                       |
| 4.1.1  | userId      | int           | 否   | 用户编号                           |
| 4.1.2  | userName    | string        | 否   | 用户名称                           |
| 4.1.3  | groupId     | int           | 否   | 所属群组编号                       |
| 4.1.4  | description | String        | 是   | 备注                               |
| 4.1.5  | userStatus  | int           | 否   | 状态（1-正常 2-停用） 默认1        |
| 4.1.6  | publicKey   | String        | 否   | 公钥信息                           |
| 4.1.7  | address     | String        | 是   | 在链上位置的hash                   |
| 4.1.8  | hasPk       | Int           | 否   | 是否拥有私钥信息(1-拥有，2-不拥有) |
| 4.1.9  | account     | string        | 否   | 关联账户                           |
| 4.1.10 | createTime  | LocalDateTime | 否   | 创建时间                           |
| 4.1.11 | modifyTime  | LocalDateTime | 否   | 修改时间                           |
| 4.1.12 | signUserId  | String        | 否   | 用户在WeBASE-Sign中的编号          |


***2）出参示例***

* 成功：

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "userId": 700015,
      "userName": "mars2",
      "account": "admin",
      "groupId": 1,
      "publicKey": "04476580a6044f3bb25a26d40ba0bafe3ed0c8e98ff50271e20ded684cfa38e02b9c3eaf1de114121f910d8bea26b5e4434f522712c9b8347a777b738dd74b706b",
      "privateKey": null,
      "userStatus": 1,
      "chainIndex": null,
      "userType": 1,
      "address": "0xdccae56cef725605d0fa1e00fd553074a74091c5",
      "signUserId": "ed54e13b0abf4c69b788bd83b8e3515e",
      "appId": "1",
      "hasPk": 1,
      "description": "supplychain_mars2",
      "createTime": "2021-07-02 17:54:24",
      "modifyTime": "2021-07-02 17:54:24"
    }
  ],
  "attachment": null
}
```

* 失败：

```
{
    "code": 202542,
    "message": "No private key of contract manager address in webase"
}
```



## 6 服务器监控相关

### 6.1 获取节点监控信息  


#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/chain/monitorInfo/{nodeId}?beginDate={beginDate}&endDate={endDate}&contrastBeginDate={contrastBeginDate}&contrastEndDate={contrastEndDate}&gap={gap}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1         | nodeId            | int             | 是     | 群组id                                                         |
| 2         | beginDate         | LocalDateTime   | 是     | 显示时间（开始） yyyy-MM-dd'T'HH:mm:ss.SSS 2019-03-13T00:00:00 |
| 3         | endDate           | LocalDateTime   | 是     | 显示时间（结束）                                               |
| 4         | contrastBeginDate | LocalDateTime   | 否     | 对比时间（开始）                                               |
| 5         | contrastEndDate   | LocalDateTime   | 否     | 对比时间（结束）                                               |
| 6         | gap               | Int             | 否    | 数据粒度，默认为1                                                       |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/chain/mointorInfo/500001?gap=60&beginDate=2019-03-13T00:00:00&endDate=2019-03-13T14:34:22&contrastBeginDate=2019-03-13T00:00:00&contrastEndDate=2019-03-13T14:34:22
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1         | code              | int             | 否     | 返回码                                                         |
| 2         | message           | String          | 否     | 描述信息                                                       |
| 3         | data              | Array           | 否     | 返回信息列表                                                   |
| 3.1       |                   | Object           |        | 返回信息实体                                                   |
| 3.1.1     | metricType        | String          | 否     | 测量类型：blockHeight、pbftView                                |
| 3.1.2     | data              | Object           | 否     |                                                                |
| 3.1.2.1   | lineDataList      | Object           | 否     |                                                                |
| 3.1.2.1.1 | timestampList     | List\<String\>  | 否     | 时间戳列表                                                     |
| 3.1.2.1.2 | valueList         | List\<Integer\> | 否     | 值列表                                                         |
| 3.1.2.2   | contrastDataList  | Object           | 否     |                                                                |
| 3.1.2.2.1 | timestampList     | List\<String\>  | 否     | 时间戳列表                                                     |
| 3.1.2.2.2 | valueList         | List\<Integer\> | 否     | 值列表                                                         |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": [
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
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 6.2 获取服务器监控信息 


#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：
```
performance/ratio/{nodeId}?gap={gap}&beginDate={beginDate}&endDate={endDate}&contrastBeginDate={contrastBeginDate}&contrastEndDate={contrastEndDate}
```

* 请求方式：GET
* 返回格式：JSON

#### 请求参数


***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1         | nodeId            | int             | 是     | 群组id                                                         |
| 2         | beginDate         | LocalDateTime   | 是     | 显示时间（开始） yyyy-MM-dd'T'HH:mm:ss.SSS 2019-03-13T00:00:00 |
| 3         | endDate           | LocalDateTime   | 是     | 显示时间（结束）                                               |
| 4         | contrastBeginDate | LocalDateTime   | 否     | 对比时间（开始）                                               |
| 5         | contrastEndDate   | LocalDateTime   | 否     | 对比时间（结束）                                               |
| 6         | gap               | Int             | 否     | 数据粒度，默认为1                                                       |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/performance/ratio/500001?gap=1&beginDate=2019-03-15T00:00:00&endDate=2019-03-15T15:26:55&contrastBeginDate=2019-03-15T00:00:00&contrastEndDate=2019-03-15T15:26:55
```

#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1         | code              | int             | 否     | 返回码                                                         |
| 2         | message           | String          | 否     | 描述信息                                                       |
| 3         | data              | Array           | 否     | 返回信息列表                                                   |
| 3.1       |                   | Object           |        | 返回信息实体                                                   |
| 3.1.1     | metricType        | String          | 否     | 测量类型: cpu、memory、disk、txbps、rxbps                      |
| 3.1.2     | data              | Object           | 否     |                                                                |
| 3.1.2.1   | lineDataList      | Object           | 否     |                                                                |
| 3.1.2.1.1 | timestampList     | List\<String\>  | 否     | 时间戳列表                                                     |
| 3.1.2.1.2 | valueList         | List\<Integer\> | 否     | 值列表                                                         |
| 3.1.2.2   | contrastDataList  | Object           | 否     |                                                                |
| 3.1.2.2.1 | timestampList     | List\<String\>  | 否     | 时间戳列表                                                     |
| 3.1.2.2.2 | valueList         | List\<Integer\> | 否     | 值列表                                                         |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "metricType": "txbps",
            "data": {
                "lineDataList": {
                    "timestampList": [
                        1552406401042,
                        1552406701001
                    ],
                    "valueList": [
                        12.24,
                        54.48
                    ]
                },
                "contrastDataList": {
                    "timestampList": [
                        1552320005000,
                        1552320301001
                    ],
                    "valueList": [
                        22.24,
                        24.48
                    ]
                }
            }
        },
        {
            "metricType": "cpu",
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
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


### 6.3 获取邮件告警配置

配置邮件告警的邮件服务器的相关参数，包含协议类型`protocol`、邮件服务器地址`host`、端口`port`、用户邮箱地址`username`、用户邮箱授权码`password`；包含Authentication验证开关（默认开启）`authentication`，以及邮件告警模块的开关`enable`；

注：邮件告警的邮箱协议类型默认使用SMTP协议，使用25默认端口，默认使用username/password进行用户验证，目前仅支持通过TLS/SSL连接邮件服务器；

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/mailServer/config/{serverId}**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
|  1   | serverId     | Int       |   是   | 邮件服务的编号


***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/mailServer/config/1
```


#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    
| 3    |  data    | Object        | 否     | 成功时返回                           
| 3.1       |                   | Object           |        |返回信息实体          |
| 3.1.1     | serverId        | Int          | 否     |    邮件服务器的编号      |
| 3.1.2     | serverName      | String           | 否     |  邮件服务器的名字      |
| 3.1.3     | host      | String           | 否     |  邮件服务器的主机地址      |
| 3.1.4     | port      | Int           | 否     |  邮件服务器的端口号      |
| 3.1.5     | username      | String           | 否     |  邮件服务器的用户地址      |
| 3.1.6     | password      | String           | 否     |  邮件服务器的用户授权码      |
| 3.1.7     | protocol      | String           | 否     |  邮件服务器的协议      |
| 3.1.8     | defaultEncoding      | String           | 否     |  邮件服务器的编码      |
| 3.1.9     | authentication      | Int           | 否     |  开启验证：0-关闭，1-开启      |
| 3.1.10    | starttlsEnable      | Int           | 否     |  开启优先使用STARTTLS：0-关闭，1-开启      |
| 3.1.11    | enable      | Int           | 否     |  开启邮件服务器：0-关闭，1-开启      |
| 3.1.12    | starttlsRequired      | Int           | 否     |  必须使用STARTTLS：0-关闭，1-开启      |
| 3.1.13    | socketFactoryPort      | Int           | 否     |  TLS使用的端口号      |
| 3.1.14    | socketFactoryClass      | String           | 否     |  TLS使用的java类      |
| 3.1.15    | socketFactoryFallback      | Int           | 否     |  开启TLS Fallback函数：0-关闭，1-开启      |
| 3.1.16    | timeout      | Int           | 否     |  从邮箱服务器读取超时时间      |
| 3.1.17    | connectionTimeout      | Int           | 否     |  邮箱服务器连接超时时间      |
| 3.1.18    | writeTimeout      | Int           | 否     |  从邮箱服务器写超时时间      |
| 3.1.19    | createTime  | LocalDateTime           | 否     |  创建时间      |
| 3.1.20    | modifyTime      | LocalDateTime           | 否     |  修改时间      |

***2）出参示例***
* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "serverId": 1,
        "serverName": "Default config",
        "host": "smtp.qq.com",
        "port": 25,
        "username": "yourmail@qq.com",
        "password": "yourpassword",
        "protocol": "smtp",
        "defaultEncoding": "UTF-8",
        "createTime": "2019-10-29 20:02:30",
        "modifyTime": "2019-10-29 20:02:30",
        "authentication": 1,
        "starttlsEnable": 1,
        "starttlsRequired": 0,
        "socketFactoryPort": 465,
        "socketFactoryClass": "javax.net.ssl.SSLSocketFactory",
        "socketFactoryFallback": 0,
        "enable": 0,
        "timeout": 5000,
        "connectionTimeout": 5000,
        "writeTimeout": 5000
    }
}
```


### 6.4 获取全部邮件告警配置

返回所有的邮件告警的邮件服务配置

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/mailServer/config/list**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| -    | -     | -        | -     | -  |

​         

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/mailServer/config/list
```


#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    
| 3    |  data    | List        | 否     | 成功时返回                           
| 3.1       |                   | Object           |        |返回信息实体          |
| 3.1.1     | serverId        | Int          | 否     |    邮件服务器的编号      |
| 3.1.2     | serverName      | String           | 否     |  邮件服务器的名字      |
| 3.1.3     | host      | String           | 否     |  邮件服务器的主机地址      |
| 3.1.4     | port      | Int           | 否     |  邮件服务器的端口号      |
| 3.1.5     | username      | String           | 否     |  邮件服务器的用户地址      |
| 3.1.6     | password      | String           | 否     |  邮件服务器的用户授权码      |
| 3.1.7     | protocol      | String           | 否     |  邮件服务器的协议      |
| 3.1.8     | defaultEncoding      | String           | 否     |  邮件服务器的编码      |
| 3.1.9     | authentication      | Int           | 否     |  开启验证：0-关闭，1-开启      |
| 3.1.10    | starttlsEnable      | Int           | 否     |  开启优先使用STARTTLS：0-关闭，1-开启      |
| 3.1.11    | enable      | Int           | 否     |  开启邮件服务器：0-关闭，1-开启      |
| 3.1.12    | starttlsRequired      | Int           | 否     |  必须使用STARTTLS：0-关闭，1-开启      |
| 3.1.13    | socketFactoryPort      | Int           | 否     |  TLS使用的端口号      |
| 3.1.14    | socketFactoryClass      | String           | 否     |  TLS使用的java类      |
| 3.1.15    | socketFactoryFallback      | Int           | 否     |  开启TLS Fallback函数：0-关闭，1-开启      |
| 3.1.16    | timeout      | Int           | 否     |  从邮箱服务器读取超时时间      |
| 3.1.17    | connectionTimeout      | Int           | 否     |  邮箱服务器连接超时时间      |
| 3.1.18    | writeTimeout      | Int           | 否     |  从邮箱服务器写超时时间      |
| 3.1.19    | createTime  | LocalDateTime           | 否     |  创建时间      |
| 3.1.20    | modifyTime      | LocalDateTime           | 否     |  修改时间      |



***2）出参示例***
* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "serverId": 1,
            "serverName": "Default config",
            "host": "smtp.qq.com",
            "port": 25,
            "username": "yourmail@qq.com",
            "password": "yourpassword",
            "protocol": "smtp",
            "defaultEncoding": "UTF-8",
            "createTime": "2019-10-29 20:02:30",
            "modifyTime": "2019-10-29 20:02:30",
            "authentication": 1,
            "starttlsEnable": 1,
            "starttlsRequired": 0,
            "socketFactoryPort": 465,
            "socketFactoryClass": "javax.net.ssl.SSLSocketFactory",
            "socketFactoryFallback": 0,
            "enable": 0,
            "timeout": 5000,
            "connectionTimeout": 5000,
            "writeTimeout": 5000
        }
    ]
}
```

### 6.5 更新邮件告警配置

更新邮件告警的配置内容；目前仅支持单个邮件服务器配置，不支持新增配置；

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/mailServer/config**
* 请求方式：PUT
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | serverId     | int        | 是     |  邮件告警配置的编号 |
| 2    | protocol     | String        | 是     |  邮件服务的协议类型，小写（发件服务器默认使用smtp）|
| 3    | host         | String        | 是     |  邮件服务的地址|
| 4    | port         | int        | 是     |  邮件服务使用的端口，默认25|
| 5    | username     | String        | 否     |  邮件服务的用户邮箱地址，authentication开启时为必填|
| 6    | password     | String        | 否     |  邮件服务的用户邮箱授权码，**使用base64编码**，authentication开启时为必填|
| 7    | authentication | int        | 是     |  是否启用验证，默认使用username/password验证：0-关闭，1-开启|
| 8    | enable       | int        | 是     |  是否启用邮件服务：0-关闭，1-开启|

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/mailServer/config
```

```
{
    "serverId": 1,
    "host": "smtp.qq.com",
    "port": 25,
    "username": "yourmail@qq.com",
    "password": "eW91cnBhc3N3b3Jk", // 原文：yourpassword
    "protocol": "smtp",
    "authentication": 1,
    "enable": 1
}
```


#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    |
| 3    |  data    | Object        | 否     | 返回邮件服务配置的具体内容                          |
| 3.1  |      | Object        | 否     |  参数含义参考上文GET接口出参表                          |



***2）出参示例***
* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "serverId": 1,
        "serverName": "Default config",
        "host": "smtp.qq.com",
        "port": 25,
        "username": "yourmail@qq.com",
        "password": "yourpassword",
        "protocol": "smtp",
        "defaultEncoding": "UTF-8",
        "createTime": "2019-10-29 20:02:30",
        "modifyTime": "2019-11-07 10:04:47",
        "authentication": 1,
        "starttlsEnable": 1,
        "starttlsRequired": 0,
        "socketFactoryPort": 465,
        "socketFactoryClass": "javax.net.ssl.SSLSocketFactory",
        "socketFactoryFallback": 0,
        "enable": 1,
        "timeout": 5000,
        "connectionTimeout": 5000,
        "writeTimeout": 5000
    }
}
```

* 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 6.6 发送测试邮件

使用当前的邮件服务配置，向指定的邮箱地址发送测试邮件，如果配置错误将发送失败；

注：需要确保配置正确才能使用后续的邮件告警功能；返回成功信息后，需要用户到自己的邮箱查看是否收到邮测试邮件；

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/alert/mail/test/{toMailAddress}**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                      |
|------|-------------|---------------|--------|-------------------------------|
| 1    | {toMailAddress} | String        | 是     |  接收测试邮件的邮箱地址 |
| 2    | host         | String        | 否     |  邮件服务的地址 |
| 3    | port         | int        | 是否     |  邮件服务使用的端口，默认25|
| 4    | protocol     | String        | 否     |  邮件服务的协议类型，默认使用smtp|
| 5    | defaultEncoding  | String        | 否     | 邮件服务的邮件编码格式，默认为UTF-8编码|
| 6    | username     | String        | 是     |  邮件服务的用户邮箱地址，authentication开启时为必填|
| 7    | password     | String        | 是     |  邮件服务的用户邮箱授权码，authentication开启时为必填|
| 8    | authentication | int        | 是     |  开启鉴权验证，默认开启（使用username/password验证）0-关闭，1-开启|
| 9    | starttlsEnable | int        | 否     |  开启优先使用STARTTLS，默认开启 0-关闭，1-开启|
| 10   | starttlsRequired | int        | 否     |  开启必须使用STARTTLS，默认关闭，开启时需要配置socketFactoryPort, socketFactoryClass, socketFactoryFallback 0-关闭，1-开启|
| 11   | socketFactoryPort | String        | 否     |  TLS/SSL的Socket端口，默认465|
| 12   | socketFactoryClass | String        | 否     |  TLS/SSL的Socket工厂类|
| 13   | socketFactoryFallback | int        | 否     |  开启Socket的Fallback函数，默认关闭 0-关闭，1-开启|
| 14   | timeout | int        | 否     |  读超时时间值，默认5000ms|
| 15   | connectionTimeout | int        | 否     |  连接超时时间值，默认5000ms|
| 16   | writeTimeout | int        | 否是     |  写超时时间值，默认5000ms|

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/alert/mail/test/yourmail@qq.com
```

```
{
    "host": "smtp.qq.com",
    "port": 25,
    "username": "yourmail@qq.com",
    "password": "yourpassword",
    "protocol": "smtp",
    "defaultEncoding": "UTF-8",
    "authentication": 1,
    "starttlsEnable": 1,
    "starttlsRequired": 0,
    "socketFactoryPort": 465,
    "socketFactoryClass": "javax.net.ssl.SSLSocketFactory",
    "socketFactoryFallback": 0,
    "timeout": 5000,
    "connectionTimeout": 5000,
    "writeTimeout": 5000
}
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    |
| 3    |  data    | Object        | 否     | 错误时返回错误原因                          |



***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": null
}
```

* 失败：
```
{
    "code": 202080,
    "message": "Send mail error, please check mail server configuration.",
    "data": "Failed messages: javax.mail.SendFailedException: No recipient addresses"
}
```


### 6.7 获取告警类型配置

获取单个告警配置的内容；告警类型配置是对不同告警类型下的不同内容，包含告警邮件标题`ruleName`，告警邮件内容`alertContent`，告警邮件发送时间间隔`alertIntervalSeconds`，上次告警时间`lastAlertTime`，目标告警邮箱地址列表`userList`，是否启用该类型的邮件告警`enable`，告警等级`alertLevel`等；


#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/alert/{ruleId}**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
|  1   | ruleId     | Int       |   是   | 告警配置的编号 |


***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/alert/1
```


#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                         |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败             |
| 2    | message     | String        | 否     | 描述    |
| 3    |  data    | Object        | 否     | 成功时返回   |
| 3.1       |                   | Object           |        |返回信息实体          |
| 3.1.1     | ruleId        | Int          | 否     |    告警类型配置的编号      |
| 3.1.2     | ruleName      | String           | 否     |  告警类型的名字/告警邮件标题    |
| 3.1.3     | enable      | Int           | 否     |  是否开启该告警：0-关闭，1-开启     |
| 3.1.4     | alertType      | Int           | 否     |  告警类型：1-节点状态告警，2-审计告警，3-证书有效期      |
| 3.1.5     | alertLevel      | Int           | 否     |  告警等级：1-高，2-中，3-低      |
| 3.1.6     | alertIntervalSeconds      | Long           | 否     |  告警邮件发送时间间隔      |
| 3.1.7     | alertContent      | String           | 否     |  告警邮件内容，其中包含{}括起来的变量      |
| 3.1.8     | contentParamList      | String           | 否     |  告警邮件内容中变量的列表，由`List<String>`序列化为String      |
| 3.1.9     | description      | String           | 否     |  告警描述      |
| 3.1.10    | userList      | Int           | 否     |  目标告警邮箱地址列表，由`List<String>`序列化为String      |
| 3.1.11    | lastAlertTime      | LocalDateTime           | 否     |  上次告警时间      |
| 3.1.12    | isAllUser      | Int           | 否     |  发送给所有用户：0-关闭，1-开启      |
| 3.1.13    | createTime  | LocalDateTime           | 否     |  创建时间      |
| 3.1.14    | modifyTime      | LocalDateTime           | 否     |  修改时间      |



***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "ruleId": 1,
        "ruleName": "节点异常告警",
        "enable": 0,
        "alertType": 1,
        "alertLevel": 1,
        "alertIntervalSeconds": 3600,
        "alertContent": "{nodeId}节点异常，请到\"节点管理\"页面查看具体信息",
        "contentParamList": "[\"{nodeId}\"]",
        "description": null,
        "createTime": "2019-10-29 20:02:30",
        "modifyTime": "2019-10-29 20:02:30",
        "isAllUser": 0,
        "userList": "[\"targetmail@qq.com\"]",
        "lastAlertTime": null
    }
}

```

### 6.8 获取全部告警类型配置列表

返回所有的告警类型配置

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/alert/list**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| -    | -     | -        | -     | -  |

​         

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/alert/list
```


#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    
| 3    |  data    | List        | 否     | 成功时返回                           
| 3.1       |                   | Object           |        |返回信息实体          |
| 3.1.1     | ruleId        | Int          | 否     |    告警类型配置的编号      |
| 3.1.2     | ruleName      | String           | 否     |  告警类型的名字/告警邮件标题      |
| 3.1.3     | enable      | Int           | 否     |  是否开启该告警：0-关闭，1-开启     |
| 3.1.4     | alertType      | Int           | 否     |  告警类型：1-节点状态告警，2-审计告警，3-证书有效期      |
| 3.1.5     | alertLevel      | Int           | 否     |  告警等级：1-高，2-中，3-低      |
| 3.1.6     | alertIntervalSeconds      | Long           | 否     |  告警邮件发送时间间隔      |
| 3.1.7     | alertContent      | String           | 否     |  告警邮件内容，其中包含{}括起来的变量      |
| 3.1.8     | contentParamList      | String           | 否     |  告警邮件内容中变量的列表，由`List<String>`序列化为String      |
| 3.1.9     | description      | String           | 否     |  告警描述      |
| 3.1.10    | userList      | Int           | 否     |  目标告警邮箱地址列表，由`List<String>`序列化为String      |
| 3.1.11    | lastAlertTime      | LocalDateTime           | 否     |  上次告警时间      |
| 3.1.12    | isAllUser      | Int           | 否     |  发送给所有用户：0-关闭，1-开启      |
| 3.1.13    | createTime  | LocalDateTime           | 否     |  创建时间      |
| 3.1.14    | modifyTime      | LocalDateTime           | 否     |  修改时间      |



***2）出参示例***
* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "ruleId": 1,
            "ruleName": "节点异常告警",
            "enable": 0,
            "alertType": 1,
            "alertLevel": 1,
            "alertIntervalSeconds": 3600,
            "alertContent": "{nodeId}节点异常，请到\"节点管理\"页面查看具体信息",
            "contentParamList": "[\"{nodeId}\"]",
            "description": null,
            "createTime": "2019-10-29 20:02:30",
            "modifyTime": "2019-10-29 20:02:30",
            "isAllUser": 0,
            "userList": "[\"targetmail@qq.com\"]",
            "lastAlertTime": null
        },
        {
            "ruleId": 2,
            "ruleName": "审计异常",
            "enable": 0,
            "alertType": 2,
            "alertLevel": 1,
            "alertIntervalSeconds": 3600,
            "alertContent": "审计异常：{auditType}，请到\"交易审计\"页面查看具体信息",
            "contentParamList": "[\"{auditType}\"]",
            "description": null,
            "createTime": "2019-10-29 20:02:30",
            "modifyTime": "2019-10-29 20:02:30",
            "isAllUser": 0,
            "userList": "[\"targetmail@qq.com\"]",
            "lastAlertTime": null
        },
        {
            "ruleId": 3,
            "ruleName": "证书有效期告警",
            "enable": 0,
            "alertType": 3,
            "alertLevel": 1,
            "alertIntervalSeconds": 3600,
            "alertContent": "证书将在{time}过期，请到\"证书管理\"页面查看具体信息",
            "contentParamList": "[\"{time}\"]",
            "description": null,
            "createTime": "2019-10-29 20:02:30",
            "modifyTime": "2019-10-29 20:02:30",
            "isAllUser": 0,
            "userList": "[\"targetmail@qq.com\"]",
            "lastAlertTime": null
        }
    ]
}
```


### 6.9 更新告警类型配置

更新告警类型配置的内容；目前仅支持更新原有的三个邮件告警的配置，不支持新增配置；

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/alert**
* 请求方式：PUT
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | ruleId     | int        | 是     |  告警类型配置编号 |
| 2    | ruleName     | String        | 否     |  告警邮件的标题|
| 3    | enable         | int        | 是     |  是否启用该类型的告警：0-关闭，1-开启|
| 4    | alertType         | int        | 否     |  告警类型：1-节点状态告警，2-审计告警，3-证书有效期告警|
| 6    | alertIntervalSeconds     | int        | 否     |  告警邮件的发送间隔时间（秒），默认3600s|
| 7    | alertContent | String        | 否     |  告警邮件的内容，其中大括号`{}`及里面的英文变量不可去除|
| 8    | userList       | String        | 是     |  接收告警邮件的邮箱列表，以`List<String>`序列化得到的字符串|
| 9    | alertLevel      | Int           | 否     |  告警等级：1-高，2-中，3-低      |


***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/mailServer/config
```

```
{
    "ruleId": 3,
    "ruleName": "证书有效期告警",
    "enable": 0,
    "alertType": 3,
    "alertIntervalSeconds": 1800,
    "alertContent": "证书将在{time}过期，请到\"证书管理\"页面查看具体信息",
    "userList": "[\"targetmail@qq.com\"]",
    "alertLevel": 1
}
```


#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    |
| 3    |  data    | Object        | 否     | 返回邮件服务配置的具体内容                          |
| 3.1  |      | Object        | 否     |  参数含义参考上文GET接口出参表                          |



***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": {
        "ruleId": 3,
        "ruleName": "证书有效期告警",
        "enable": 0,
        "alertType": 3,
        "alertLevel": 1,
        "alertIntervalSeconds": 1800,
        "alertContent": "证书将在{time}过期，请到\"证书管理\"页面查看具体信息",
        "contentParamList": "[\"{time}\"]",
        "description": null,
        "createTime": "2019-10-29 20:02:30",
        "modifyTime": "2019-11-07 10:35:03",
        "isAllUser": 0,
        "userList": "[\"targetmail@qq.com\"]",
        "lastAlertTime": null
    }
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


### 6.9 开启/关闭 告警类型

修改告警类型配置中的`enable`，0-关闭，1-开启；

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/alert/toggle**
* 请求方式：PUT
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | ruleId     | int        | 是     |  告警类型配置编号 |
| 2    | enable         | int        | 是     |  是否启用该类型的告警：0-关闭，1-开启|



***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/alert/toggle
```

```
{
   "ruleId": 3,
   "enable": 1
}
```


#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    |
| 3    |  data    | Object        | 否     | 返回邮件服务配置的具体内容                          |
| 3.1  |      | Object        | 否     |  参数含义参考上文GET接口出参表                          |



***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": {
        "ruleId": 3,
        "ruleName": "证书有效期告警",
        "enable": 1,
        "alertType": 3,
        "alertLevel": 1,
        "alertIntervalSeconds": 1800,
        "alertContent": "证书将在{time}过期，请到\"证书管理\"页面查看具体信息",
        "contentParamList": "[\"{time}\"]",
        "description": null,
        "createTime": "2019-10-29 20:02:30",
        "modifyTime": "2019-11-07 10:35:03",
        "isAllUser": 0,
        "userList": "[\"targetmail@qq.com\"]",
        "lastAlertTime": null
    }
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


### 6.10 获取出块监控信息  

获取出块周期、块大小、平均TPS的监控数据

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/stat?groupId={groupId}&beginDate={beginDate}&endDate={endDate}&contrastBeginDate={contrastBeginDate}&contrastEndDate={contrastEndDate}&gap={gap}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1         | nodeId            | int   | 是     | 群组id  |
| 2         | beginDate         | long   | 是     | 显示时间（开始） 时间戳  |
| 3         | endDate           | long   | 是     | 显示时间（结束）时间戳 |
| 4         | contrastBeginDate | long   | 否     | 对比时间（开始）时间戳 |
| 5         | contrastEndDate   | long   | 否     | 对比时间（结束）时间戳  |
| 6         | gap               | Int             | 否     | 数据粒度，默认是1  |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/stat?groupId=1&gap=60eginDate=1617811200000&endDate=1617871955000&contrastBeginDate=&contrastEndDate=
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1         | code              | int             | 否     | 返回码                                                         |
| 2         | message           | String          | 否     | 描述信息                                                       |
| 3         | data              | Array           | 否     | 返回信息列表                                                   |
| 3.1       |                   | Object           |        | 返回信息实体                                                   |
| 3.1.1     | metricType        | String          | 否     | 测量类型：blockSize, blockCycle, tps                               |
| 3.1.2     | data              | Object           | 否     |                                                                |
| 3.1.2.1   | lineDataList      | Object           | 否     |                                                                |
| 3.1.2.1.1 | timestampList     | List\<String\>  | 否     | 时间戳列表                                                     |
| 3.1.2.1.2 | valueList         | List\<Integer\> | 否     | 值列表                                                         |
| 3.1.2.2   | contrastDataList  | Object           | 否     |                                                                |
| 3.1.2.2.1 | timestampList     | List\<String\>  | 否     | 时间戳列表                                                     |
| 3.1.2.2.2 | valueList         | List\<Integer\> | 否     | 值列表                                                         |


***2）出参示例***
* 成功：
```
{
	"code": 0,
	"message": "success",
	"data": [{
		"metricType": "blockSize",
		"data": {
			"lineDataList": {
				"timestampList": [1617866162706, 1617866462706, 1617866762706, 1617867062706, 1617867362706, 1617867662706, 1617867962706, 1617868262706, 1617868562706, 1617868862706, 1617869162706, 1617869462706, 1617869762706, 1617870062706, 1617870362706, 1617870664184, 1617870964184],
				"valueList": [null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
			},
			"contrastDataList": {
				"timestampList": [],
				"valueList": []
			}
		}
	}, {
		"metricType": "blockCycle",
		"data": {
			"lineDataList": {
				"timestampList": null,
				"valueList": [null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
			},
			"contrastDataList": {
				"timestampList": null,
				"valueList": []
			}
		}
	}, {
		"metricType": "tps",
		"data": {
			"lineDataList": {
				"timestampList": null,
				"valueList": [null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
			},
			"contrastDataList": {
				"timestampList": null,
				"valueList": []
			}
		}
	}],
	"attachment": null
}
```



## 7 审计相关模块


### 7.1 获取用户交易监管信息列表


#### 7.1.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/monitor/userList/{groupId}**
* 请求方式：GET
* 返回格式：JSON

#### 7.1.2 请求参数


***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1      | groupId        | int           | 是     | 所属群组编号                                  |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/monitor/userList/300001
```

#### 7.1.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1      | code             | Int           | 否     | 返回码，0：成功 其它：失败                    |
| 2      | message          | String        | 否     | 描述                                          |
| 3      | data             | List          | 是     | 信息列表                                      |
| 3.1    |                  | Object        | 是     | 监管信息对象                                  |
| 3.1.1  | userName         | String        | 是     | 用户名称                                      |
| 3.1.2  | userType         | Int           | 是     | 用户类型(0-正常，1-异常)                      |
| 3.1.3  | groupId        | Int           | 是     | 所属群组                                      |
| 3.1.4  | contractName     | String        | 是     | 合约名称                                      |
| 3.1.5  | contractAddress  | String        | 是     | 合约地址                                      |
| 3.1.6  | interfaceName    | String        | 是     | 合约接口名                                    |
| 3.1.7  | transType        | Int           | 是     | 交易类型(0-合约部署，1-接口调用)              |
| 3.1.8  | transUnusualType | Int           | 是     | 交易异常类型 (0-正常，1-异常合约，2-异常接口) |
| 3.1.9  | transCount       | Int           | 是     | 交易量                                        |
| 3.1.10 | transHashs       | String        | 是     | 交易hashs(最多5个)                            |
| 3.1.11 | transHashLastest | String        | 是     | 最新交易hash                                  |
| 3.1.12 | createTime       | LocalDateTime | 是     | 落库时间                                      |
| 3.1.13 | modifyTime       | LocalDateTime | 是     | 修改时间                                      |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "userName": "SYSTEMUSER",
            "userType": 0,
            "groupId": null,
            "contractName": null,
            "contractAddress": null,
            "interfaceName": null,
            "transType": null,
            "transUnusualType": null,
            "transCount": null,
            "transHashs": null,
            "transHashLastest": null,
            "createTime": null,
            "modifyTime": null
        },
        {
            "userName": "asdf",
            "userType": 0,
            "groupId": null,
            "contractName": null,
            "contractAddress": null,
            "interfaceName": null,
            "transType": null,
            "transUnusualType": null,
            "transCount": null,
            "transHashs": null,
            "transHashLastest": null,
            "createTime": null,
            "modifyTime": null
        }
    ]
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 7.2 获取合约方法监管信息列表


#### 7.2.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/monitor/interfaceList/{groupId}?userName={userName}**
* 请求方式：GET
* 返回格式：JSON

#### 7.2.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1      | groupId        | int           | 是     | 所属群组编号      |
| 2      | userName         | String        | 否     | 用户名             |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/monitor/interfaceList/300001
```


#### 7.2.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1      | code             | Int           | 否     | 返回码，0：成功 其它：失败                    |
| 2      | message          | String        | 否     | 描述                                          |
| 3      | data             | List          | 是     | 信息列表                                      |
| 3.1    |                  | Object        | 是     | 监管信息对象                                  |
| 3.1.1  | userName         | String        | 是     | 用户名称                                      |
| 3.1.2  | userType         | Int           | 是     | 用户类型(0-正常，1-异常)                      |
| 3.1.3  | groupId        | Int           | 是     | 所属群组                                      |
| 3.1.4  | contractName     | String        | 是     | 合约名称                                      |
| 3.1.5  | contractAddress  | String        | 是     | 合约地址                                      |
| 3.1.6  | interfaceName    | String        | 是     | 合约接口名                                    |
| 3.1.7  | transType        | Int           | 是     | 交易类型(0-合约部署，1-接口调用)              |
| 3.1.8  | transUnusualType | Int           | 是     | 交易异常类型 (0-正常，1-异常合约，2-异常接口) |
| 3.1.9  | transCount       | Int           | 是     | 交易量                                        |
| 3.1.10 | transHashs       | String        | 是     | 交易hashs(最多5个)                            |
| 3.1.11 | transHashLastest | String        | 是     | 最新交易hash                                  |
| 3.1.12 | createTime       | LocalDateTime | 是     | 落库时间                                      |
| 3.1.13 | modifyTime       | LocalDateTime | 是     | 修改时间                                      |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "userName": "SYSTEMUSER",
            "userType": 0,
            "groupId": null,
            "contractName": null,
            "contractAddress": null,
            "interfaceName": null,
            "transType": null,
            "transUnusualType": null,
            "transCount": null,
            "transHashs": null,
            "transHashLastest": null,
            "createTime": null,
            "modifyTime": null
        },
        {
            "userName": "asdf",
            "userType": 0,
            "groupId": null,
            "contractName": null,
            "contractAddress": null,
            "interfaceName": null,
            "transType": null,
            "transUnusualType": null,
            "transCount": null,
            "transHashs": null,
            "transHashLastest": null,
            "createTime": null,
            "modifyTime": null
        }
    ]
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


### 7.3 获取交易hash监管信息列表


#### 7.3.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/monitor/transList/{groupId}**
* 请求方式：GET
* 返回格式：JSON

#### 7.3.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1       | groupId     | int            | 是     | 所属群组编号               |
| 2       | userName      | String         | 否     | 用户名                     |
| 3       | startDate     | String         |    是    | 开始时间                   |
| 4       | endDate       | String         |  是      | 结束时间                   |
| 5       | interfaceName | String         |   否     | 接口名称                   |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/monitor/transList/300001?userName=0x5d97f8d41638a7b1b669b70b307bab6d49df8e2c&interfaceName=0x4ed3885e
```


#### 7.3.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1       | code          | Int            | 否     | 返回码，0：成功 其它：失败 |
| 2       | message       | String         | 否     | 描述                       |
| 3       | data          | Object         | 否     | 返回结果实体               |
| 3.1     | groupId     | Int            | 否     | 所属群组编号               |
| 3.2     | userName      | String         | 否     | 用户名                     |
| 3.3     | interfaceName | String         | 否     | 接口名                     |
| 3.4     | totalCount    | Int            | 否     | 总记录数                   |
| 3.5     | transInfoList | List\<Object\> | 是     | 交易信息列表               |
| 3.5.1   |               | Object         | 是     | 交易信息实体               |
| 3.5.1.1 | transCount    | Int            | 是     | 交易记录数                 |
| 3.5.1.2 | time          | LcalDateTime   | 是     | 时间                       |


***2）出参示例***
* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "groupId": 300001,
        "userName": "0x5d97f8d41638a7b1b669b70b307bab6d49df8e2c",
        "interfaceName": "0x4ed3885e",
        "totalCount": 1,
        "transInfoList": [
            {
                "transCount": 1,
                "time": "2019-03-13 15:41:56"
            }
        ]
    }
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


### 7.4 获取异常用户信息列表


#### 7.4.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/unusualUserList/{groupId}/{pageNumber}/{pageSize}?userName={userName}**
* 请求方式：GET
* 返回格式：JSON

#### 7.4.2 参数信息详情
请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | groupId  | int           | 是     | 所属群组编号               |
| 2     | userName   | String        | 否     | 用户名                     |
| 3     | pageNumber | int           | 是     | 当前页码                   |
| 4     | pageSize   | int           | 是     | 页面大小                   |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/monitor/unusualUserList/300001/1/10?userName=
```

#### 7.4.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | code       | Int           | 否     | 返回码，0：成功 其它：失败 |
| 2     | message    | String        | 否     | 描述                       |
| 3     | totalCount | Int           | 否     | 总记录数                   |
| 4     | data       | List          | 否     | 返回信息列表               |
| 4.1   |            | object        | 是     | 返回信息实体               |
| 4.1.1 | userName   | String        | 是     | 用户名                     |
| 4.1.2 | transCount | int           | 是     | 交易数                     |
| 4.1.3 | hashs      | String        | 是     | 交易hash                   |
| 4.1.4 | time       | LocalDateTime | 是     | 时间                       |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "userName": "0x08b52f85638a925929cf62a3ac77c67415012c24",
            "transCount": 1,
            "hashs": "0x43b50faa3f007c22cf5dd710c3561c5cde516e01a55b5b4acffd7d94cf61fc57",
            "time": "2019-03-13 22:28:29"
        }
    ],
    "totalCount": 1
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```



### 7.5 获取异常合约信息列表

#### 7.5.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/unusualContractList/{groupId}/{pageNumber}/{pageSize}?contractAddress={contractAddress}**
* 请求方式：GET
* 返回格式：JSON

#### 7.5.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | groupId       | int           | 是     | 所属群组编号               |
| 2     | contractAddress | String        | 否     | 合约地址                   |
| 3     | pageNumber      | int           | 是     | 当前页码                   |
| 4     | pageSize        | int           | 是     | 页面大小                   |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/monitor/unusualContractList/300001/1/10?contractAddress=
```

#### 7.5.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注             |
|------|-------------|---------------|--------|-------------------------------|
| 1     | code            | Int           | 否     | 返回码，0：成功 其它：失败 |
| 2     | message         | String        | 否     | 描述                       |
| 3     | totalCount      | Int           | 否     | 总记录数                   |
| 4     | data            | List          | 否     | 返回信息列表               |
| 4.1   |                 | object        | 是     | 返回信息实体               |
| 4.1.1 | contractName    | String        | 是     | 合约名称                   |
| 4.1.2 | contractAddress | String        | 是     | 合约地址                   |
| 4.1.3 | transCount      | int           | 是     | 交易数                     |
| 4.1.4 | hashs           | String        | 是     | 交易hash                   |
| 4.1.5 | time            | LocalDateTime | 是     | 时间                       |

***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "totalCount": 1,
    "data": [
        {
            "contractName": "0x00000000",
            "contractAddress": "0x0000000000000000000000000000000000000000",
            "transCount": 3,
            "hashs": "0xc87e306db85740895369cc2a849984fe544a6e9b0ecdbd2d898fc0756a02a4ce",
            "time": "2019-03-13 15:41:56"
        }
    ]
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


## 8 群组信息模块


### 8.1 获取群组概况


####  传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/group/general/{groupId}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId          | int    | 是     | 群组id                     |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/group/300001
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code             | Int    | 否     | 返回码，0：成功 其它：失败 |
| 2    | message          | String | 否     | 描述                       |
| 3    | data             | object | 否     | 返回信息实体               |
| 3.1  | groupId          | int    | 否     | 群组id                     |
| 3.2  | nodeCount        | int    | 否     | 节点数量                   |
| 3.3  | contractCount    | int    | 否     | 已部署智能合约数量         |
| 3.4  | transactionCount | int    | 否     | 交易数量                   |
| 3.5  | latestBlock      | int    | 否     | 当前块高                   |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "data": {
        "latestBlock": 7156,
        "contractCount": 0,
        "groupId": "300001",
        "nodeCount": 2,
        "transactionCount": 7131
    },
    "message": "Success"
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


### 8.2 获取所有群组列表

默认只返回groupStatus为1的群组ID，可传入groupStatus筛选群组 (1-normal, 2-maintaining, 3-conflict-genesisi, 4-conflict-data)

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/group/all**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupStatus   | int    | 否    | 群组状态，1-normal, 2-maintaining, 3-conflict-genesisi, 4-conflict-data|


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/group/all
http://127.0.0.1:5001/WeBASE-Node-Manager/group/all/{groupStatus}
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | code          | Int           | 否     | 返回码，0：成功 其它：失败 |
| 2     | message       | String        | 否     | 描述                       |
| 3     | totalCount    | Int           | 否     | 总记录数                   |
| 4     | data          | List          | 否     | 组织列表                   |
| 4.1   |               | Object        |        | 组织信息对象               |
| 4.1.1 | groupId       | Integer           | 否     | 群组编号                   |
| 4.1.2 | groupName     | String        | 否     | 群组名称                   |
| 4.1.2 | groupStatus   | Integer        | 否     | 群组状态：1-正常, 2-维护中, 3-脏数据, 4-创世块冲突                  |
| 4.1.2 | nodeCount     | Integer        | 否     | 群组节点数                  |
| 4.1.3 | latestBlock   | BigInteger    | 否     | 最新块高                   |
| 4.1.4 | transCount    | BigInteger    | 否     | 交易量                     |
| 4.1.5 | createTime    | LocalDateTime | 否     | 落库时间                   |
| 4.1.6 | modifyTime    | LocalDateTime | 否     | 修改时间                   |
| 4.1.2 | description     | String        | 否     | 群组描述                   |
| 4.1.2 | groupType     | Integer        | 否     | 群组类别：1-同步，2-动态创建  |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "totalCount": 1,
    "data": [
        {
            "groupId":1,
            "groupName":"group1",
            "groupStatus":1,
            "nodeCount":4,
            "latestBlock":0,
            "transCount":0,
            "createTime":"2020-05-07 16:32:02",
            "modifyTime":"2020-05-08 10:50:13",
            "description":"synchronous",
            "groupType":1
        }
    ]
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


### 8.3 查询每日交易数据


#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/group/transDaily/{groupId}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId    | int    | 是     | 群组id                     |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/group/transDaily/300001
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code       | Int    | 否     | 返回码，0：成功 其它：失败 |
| 2    | message    | String | 否     | 描述                       |
| 3    | data       | list   | 否     | 返回信息列表               |
| 3.1  |            | object |        | 返回信息实体               |
| 4.1  | day        | string | 否     | 日期YYYY-MM-DD             |
| 4.2  | groupId    | int    | 否     | 群组编号                   |
| 4.3  | transCount | int    | 否     | 交易数量                   |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "data": [
        {
            "day": "2018-11-21",
            "groupId": "300001",
            "transCount": 12561
        },
        {
            "day": "2018-11-22",
            "groupId": "300001",
            "transCount": 1251
        }
    ],
    "message": "Success"
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 8.4 向单个节点生成新群组
<span id="dynamic_group_interface"></span>
​向单个节点的前置发起请求，以当前时间生成`timestamp`时间戳，`nodeList`为群组创世块的**共识节点列表**，生成新群组配置信息；节点和前置一一对应，节点编号可以从前置列表获取。   

`nodeList`需要填入新群组中所有的nodeId，通过本接口分别请求每个节点，在每个节点生成群组配置信息。

**群组生成后，需对应调用新群组启动的接口，并确保新节点加入新群组的共识节点/观察节点**

节点加入已存在群组并启动后，可调用`POST /precompiled/consensus`接口将该节点加入到新加入群组的共识节点或观察节点中

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/group/generate/{nodeId}**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | nodeId    | String        | 是     | 路径变量：节点id                           |
| 2    | generateGroupId    | Integer        | 是     | 新群组编号                           |
| 3    | timestamp      | Integer        | 是     | 群组创世块时间戳                               |
| 4    | nodeList     | List<String>           | 是     | 新群组中所有共识节点 |
| 5    | description     | String           | 否    | 群组描述                           |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/group/generate/78e467957af3d0f77e19b952a740ba8c53ac76913df7dbd48d7a0fe27f4c902b55e8543e1c4f65b4a61695c3b490a5e8584149809f66e9ffc8c05b427e9d3ca2
```

```
{
    "generateGroupId": 2,
    "timestamp": 1574853659000,
    "nodeList": [
       "78e467957af3d0f77e19b952a740ba8c53ac76913df7dbd48d7a0fe27f4c902b55e8543e1c4f65b4a61695c3b490a5e8584149809f66e9ffc8c05b427e9d3ca2",
       "dd7a2964007d583b719412d86dab9dcf773c61bccab18cb646cd480973de0827cc94fa84f33982285701c8b7a7f465a69e980126a77e8353981049831b550f5c"
    ],
    "description": "test"
}
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | code          | Int           | 否     | 返回码，0：成功 其它：失败 |
| 2     | message       | String        | 否     | 描述                       |
| 3     | data          | List          | 否     | 组织列表                   |
| 3.1   |               | Object        |        | 组织信息对象               |
| 3.1.1 | groupId       | int           | 否     | 群组编号                   |
| 3.1.2 | groupName     | String        | 否     | 群组名称                   |
| 3.1.3 | groupStatus   | Integer    | 否         | 群组状态：1-正常, 2-维护中, 3-脏数据, 4-创世块冲突 |
| 3.1.4 | nodeCount    | Integer    | 否     | 群组节点数                     |
| 3.1.5 | description   | String | 否     | 描述                   |
| 3.1.6 | groupType    | Integer | 否     | 群组类型：  1-同步 2-动态创建|
| 3.1.7 | createTime    | LocalDateTime | 否     | 落库时间                   |
| 3.1.8 | modifyTime    | LocalDateTime | 否     | 修改时间                   |

***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": {
        "groupId": 2,
        "groupName": "group2",
        "nodeCount": 2,
        "groupStatus": 2,
        "groupType": 2,
        "description": "test",
        "createTime": "2019-02-14 17:33:50",
        "modifyTime": "2019-03-15 09:36:17"
    }
}
```

* 失败：
```
{
    "code": 202301,
    "message": "node's front not exists",
    "data": {}
}
```


### 8.5 向多个节点生成新群组

向`nodeList`中所有节点的前置发起请求，以当前时间生成`timestamp`时间戳，以`nodeList`为创世块的**共识节点列表**，生成新群组配置信息；节点和前置一一对应，节点编号可以从前置列表获取。   

**群组生成后，需对应调用新群组启动的接口，并确保新节点加入新群组的共识节点/观察节点**

节点加入已存在群组并启动后，可调用`POST /precompiled/consensus`接口将该节点加入到新加入群组的共识节点或观察节点中


#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/group/generate**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | generateGroupId    | Integer        | 是     | 新群组编号                           |
| 2    | timestamp      | Integer        | 是     | 群组创世块时间戳                               |
| 3    | nodeList     | List<String>           | 是     | 新群组中所有共识节点 |
| 4    | description     | String           | 否    | 群组描述                           |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/group/generate
```

```
{
    "generateGroupId": 2,
    "timestamp": 1574853659000,
    "nodeList": [
       "78e467957af3d0f77e19b952a740ba8c53ac76913df7dbd48d7a0fe27f4c902b55e8543e1c4f65b4a61695c3b490a5e8584149809f66e9ffc8c05b427e9d3ca2",
       "dd7a2964007d583b719412d86dab9dcf773c61bccab18cb646cd480973de0827cc94fa84f33982285701c8b7a7f465a69e980126a77e8353981049831b550f5c"
    ],
    "description": "test"
}
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | code          | Int           | 否     | 返回码，0：成功 其它：失败 |
| 2     | message       | String        | 否     | 描述                       |
| 3     | data       | List        | 否     | 群组操作结果                       |
| 3.1     | frontId       | Integer        | 否     | 群组操作请求的节点前置编号 |
| 3.2     | code       | Integer        | 否     | 群组操作结果，0-成功，其他：失败  |

***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": [{
        "frontId": 500011,
        "code": 0
    }, {
        "frontId": 500013,
        "code": 1
    }]
}
```

* 失败：
```
{
    "code": 202301,
    "message": "node's front not exists",
    "data": {}
}
```



### 8.6 动态操作群组

可以对已存在的群组或新生成的群组进行动态操作，包括启动、停止、删除、恢复、状态查询。

**说明：** 生成新群组后，需要向每个前置调用启动群组的操作，并确保新节点是新群组中的共识节点/观察节点

节点加入已存在群组并启动后，可调用`POST /precompiled/consensus`接口将该节点加入到新加入群组的共识节点或观察节点中

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/group/operate/{nodeId}**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | nodeId    | String        | 是     | 路径变量：节点id                           |
| 2    | generateGroupId    | Integer        | 是     | 新群组编号                           |
| 3    | type      | String        | 是     | 操作类型： start, stop, remove, recover, getStatus|

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/group/operate/78e467957af3d0f77e19b952a740ba8c53ac76913df7dbd48d7a0fe27f4c902b55e8543e1c4f65b4a61695c3b490a5e8584149809f66e9ffc8c05b427e9d3ca2
```

```
{
    "generateGroupId": 2,
    "type": "start"
}
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | code          | Int           | 否     | 返回码，0：成功 其它：失败 |
| 2     | message       | String        | 否     | 描述                       |

***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": {}
}
```

* 失败：
```
{
  "code": 205032,
  "message": "Group 2 is already running",
  "data": null
}
```


### 8.7 批量启动群组

批量启动多个节点的群组，向`nodeList`中所有节点批量发起启动群组的请求；nodeId可以从前置列表获取。


#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/group/batchStart**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | generateGroupId    | Integer        | 是     | 新群组编号                           |
| 2    | nodeList      | List<String>        | 是     | 新群组中所有需要启动的节点nodeId |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/group/batchStart
```

```
{
    "generateGroupId": 2,
    "nodeList": [
       "78e467957af3d0f77e19b952a740ba8c53ac76913df7dbd48d7a0fe27f4c902b55e8543e1c4f65b4a61695c3b490a5e8584149809f66e9ffc8c05b427e9d3ca2",
       "dd7a2964007d583b719412d86dab9dcf773c61bccab18cb646cd480973de0827cc94fa84f33982285701c8b7a7f465a69e980126a77e8353981049831b550f5c"
    ]
}
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | code          | Int           | 否     | 返回码，0：成功 其它：失败 |
| 2     | message       | String        | 否     | 描述                       |
| 3     | data       | List        | 否     | 群组操作结果                       |
| 3.1     | frontId       | Integer        | 否     | 群组操作请求的节点前置编号 |
| 3.2     | code       | Integer        | 否     | 群组操作结果，0-成功，其他：失败                       |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": [{
        "frontId": 500011,
        "code": 0  // 启动成功
    }, {
        "frontId": 500013,
        "code": 1 // 启动失败
    }]
}
```

* 失败：
```
{
  "code": 205032,
  "message": "Group 2 is already running",
  "data": null
}
```



### 8.8 多个节点获取该节点的多个群组状态

向多个节点获取该**节点视角下**`groupIdList`中所有群组的状态；nodeId可以从前置列表获取。

群组状态包含：群组不存在"INEXISTENT"、群组正在停止"STOPPING"、群组运行中"RUNNING"、群组已停止"STOPPED"、群组已删除"DELETED"

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/group/queryGroupStatus/list**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | nodeIdList    | List<String>        | 是     | 需要获取群组状态的节点编号列表    |
| 2    | groupIdList      | List<Integer>        | 是     | 需要查询群组状态的群组编号列表 |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/group/queryGroupStatus/list
```

```
{
    "nodeIdList": [
        "02ad41a54e5403293855624e6088a1ac6c0a391d6381175bb9c9881f2ae83de6db54fc95a772f22b9e62109393c1a4229dc6d99536548db693e43b244a5b9d84",
        "3fc60c4dddcb8f64c910b7afc4bd400339a007eff9be22012c5ae2f7eebef67a4b770094bf7564dd100e1456d85a72f3488457e9f4d44d51e289071d995285d7"
    ]
    "groupIdList": [2]
}
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | code          | Integer           | 否     | 返回码，0：成功 其它：失败 |
| 2     | message       | String        | 否     | 描述                       |
| 3     | data          | List          | 否     |  GroupStatusInfo的列表                |
| 3.1   | nodeId    | String        |        | 包含groupId和GroupStatus的Map<Integer,String>, 如`{"1": "RUNNING","20","INEXISTENT"}`       |
| 3.2   | groupStatusMap    | Map        |        | 包含groupId和GroupStatus的`Map<String,String>`, 如`{"1": "RUNNING","20","INEXISTENT"}`       |
| 3.2.1 | groupId       |  String       | 否     | 群组编号，如果获取失败，则显示为`<nodeId, "FAIL">`，如下所示                   |
| 3.2.2 | groupStatus   | String    | 否         | 链上的群组状态："INEXISTENT"、"STOPPING"、"RUNNING"、"STOPPED"、"DELETED", 获取失败为"FAIL" |

***2）出参示例***

* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": [{
        "nodeId": "02ad41a54e5403293855624e6088a1ac6c0a391d6381175bb9c9881f2ae83de6db54fc95a772f22b9e62109393c1a4229dc6d99536548db693e43b244a5b9d84",
        "groupStatusMap": {
            // 当前nodeId获取群组2状态成功
            "2": "RUNNING" 
        }
    }, {
        "nodeId": "3fc60c4dddcb8f64c910b7afc4bd400339a007eff9be22012c5ae2f7eebef67a4b770094bf7564dd100e1456d85a72f3488457e9f4d44d51e289071d995285d7",
        "groupStatusMap": {
            // 当前nodeId获取群组2状态成功
            "2": "RUNNING"
        }
    }]
}
```

* 获取群组状态成功，但某个节点的获取请求失败：
```
{
    "code": 0,
    "message": "success",
    "data": [{
        "nodeId": "02ad41a54e5403293855624e6088a1ac6c0a391d6381175bb9c9881f2ae83de6db54fc95a772f22b9e62109393c1a4229dc6d99536548db693e43b244a5b9d84",
        "groupStatusMap": {
            "2": "RUNNING"
        }
    }, {
        "nodeId": "3fc60c4dddcb8f64c910b7afc4bd400339a007eff9be22012c5ae2f7eebef67a4b770094bf7564dd100e1456d85a72f3488457e9f4d44d51e289071d995285d7",
        "groupStatusMap": {
            // 3fc6..节点的状态获取失败
            "3fc60c4dddcb8f64c910b7afc4bd400339a007eff9be22012c5ae2f7eebef67a4b770094bf7564dd100e1456d85a72f3488457e9f4d44d51e289071d995285d7": "FAIL"
        }
    }]
}
```

* 失败：
```
{
    "code": 202301,
    "message": "node's front not exists"
}
```



### 8.9 刷新群组列表

刷新节点管理服务的群组列表，检查本地群组数据与链上群组数据是否有冲突，检查多个节点之间的创世块是否一致，并从链上拉取最新的群组列表

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/group/update**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | -    | -    | -     | -                     |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/group/update
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code       | Int    | 否     | 返回码，0：成功 其它：失败 |
| 2    | message    | String | 否     | 描述                       |
| 3    | data       | list   | 否     | 返回信息列表               |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": {}
}
```

### 8.10 获取所有群组列表（包含异常群组）

返回所有群组，包含正常运行、维护中、脏数据冲突、创世块冲突4种状态的群组

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/group/all/invalidIncluded**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***
| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1      | pageSize    | Integer           | 是     | 每页记录数                                 |
| 2      | pageNumber  | Integer           | 是     | 当前页码                                   |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/group/all/invalidIncluded/{pageNumber}/{pageSize}
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | code          | Integer           | 否     | 返回码，0：成功 其它：失败 |
| 2     | message       | String        | 否     | 描述                       |
| 3     | totalCount    | Integer           | 否     | 总记录数                   |
| 4     | data          | List          | 否     | 组织列表                   |
| 4.1   |               | Object        |        | 组织信息对象               |
| 4.1.1 | groupId       | Integer           | 否     | 群组编号                   |
| 4.1.2 | groupName     | String        | 否     | 群组名称                   |
| 4.1.2 | groupStatus   | Integer        | 否     | 群组状态：1-正常, 2-维护中, 3-脏数据, 4-创世块冲突|
| 4.1.2 | nodeCount     | Integer        | 否     | 群组节点数                  |
| 4.1.3 | latestBlock   | BigInteger    | 否     | 最新块高                   |
| 4.1.4 | transCount    | BigInteger    | 否     | 交易量                     |
| 4.1.5 | createTime    | LocalDateTime | 否     | 落库时间                   |
| 4.1.6 | modifyTime    | LocalDateTime | 否     | 修改时间                   |
| 4.1.7 | description     | String        | 否     | 群组描述                   |
| 4.1.8 | groupType     | Integer        | 否     | 群组类别：1-同步，2-动态创建  |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "totalCount": 1,
    "data": [
        {
            "groupId":1,
            "groupName":"group1",
            "groupStatus":1,
            "nodeCount":4,
            "latestBlock":0,
            "transCount":0,
            "createTime":"2020-05-07 16:32:02",
            "modifyTime":"2020-05-08 10:50:13",
            "description":"synchronous",
            "groupType":1
        },
         {
            "groupId":2020,
            "groupName":"group2020",
            "groupStatus":2,
            "nodeCount":2,
            "latestBlock":0,
            "transCount":0,
            "createTime":"2020-05-07 16:32:02",
            "modifyTime":"2020-05-08 10:50:13",
            "description":"",
            "groupType":2
        }
    ]
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


### 8.11 删除群组所有数据

删除指定群组编号的群组的所有数据，包含节点数据、交易数据、交易审计数据等等。

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/group/{groupId}**
* 请求方式：DELETE
* 返回格式：JSON

#### 请求参数

***1）入参表***
| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1      | groupId    | Integer           | 是     | 群组编号                                 |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/group/{groupId}
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | code          | Integer           | 否     | 返回码，0：成功 其它：失败 |
| 2     | message       | String        | 否     | 描述                       |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success"
}
```

* 失败：
```
{
    "code": 202006,
    "message": "invalid group id"
}
```


### 8.12 配置群组备注信息

配置群组的备注信息，用于数据大屏中大标题的展示。（默认备注为"synchronous"）

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/group/description**
* 请求方式：PUT
* 返回格式：JSON

#### 请求参数


***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1      | groupId   | int           | 是     |  群组ID                                    |
| 1      | description   | String           | 否     | 群组备注                                  |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/group/description
```

{
  "description": "溯源存证应用",
  "groupId": 1
}

#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1      | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2      | message     | String        | 否     | 描述                                       |

***2）出参示例***

* 成功：
```
{
  "code": 0,
  "message": "success",
  "data": 1,
  "attachment": null
}
```



### 8.13 获取单个群组详细信息


#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/group/detail/{groupId}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数


***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1      | groupId   | int           | 是     |  群组ID                                    |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/group/detail/{groupId}
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1      | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2      | message     | String        | 否     | 描述                                       |
| 3     | data          | List          | 否     | 组织列表                   |
| 3.1   |               | Object        |        | 组织信息对象               |
| 3.1.1 | groupId       | Integer           | 否     | 群组编号                   |
| 3.1.2 | groupName     | String        | 否     | 群组名称                   |
| 3.1.2 | groupStatus   | Integer        | 否     | 群组状态：1-正常, 2-维护中, 3-脏数据, 3-创世块冲突|
| 3.1.2 | nodeCount     | Integer        | 否     | 群组节点数                  |
| 3.1.3 | latestBlock   | BigInteger    | 否     | 最新块高                   |
| 3.1.4 | transCount    | BigInteger    | 否     | 交易量                     |
| 3.1.5 | createTime    | LocalDateTime | 否     | 落库时间                   |
| 3.1.6 | modifyTime    | LocalDateTime | 否     | 修改时间                   |
| 3.1.7 | description     | String        | 否     | 群组描述                   |
| 3.1.8 | groupType     | Integer        | 否     | 群组类别：1-同步，2-动态创建  |

***2）出参示例***

* 成功：
```
{
  "code": 0,
  "message": "success",
  "data": {
    "groupId": 1,
    "groupName": "group1",
    "groupStatus": 1,
    "nodeCount": 4,
    "latestBlock": 0,
    "transCount": 0,
    "createTime": "2021-07-29 14:44:59",
    "modifyTime": "2021-09-29 16:42:05",
    "description": "溯源存证应用",
    "groupType": 1,
    "groupTimestamp": null,
    "nodeIdList": null,
    "chainId": 0,
    "chainName": "default"
  },
  "attachment": null
}
```


## 9 节点管理模块


### 9.1 查询节点列表

查询WeBASE本地保存的节点列表

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/node/nodeList/{groupId}/{pageNumber}/{pageSize}?nodeName={nodeName}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数


***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1      | groupId   | int           | 是     | 群组id                                     |
| 2      | pageSize    | Int           | 是     | 每页记录数                                 |
| 3      | pageNumber  | Int           | 是     | 当前页码                                   |
| 4      | nodeName    | String        | 否     | 节点名称                                   |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/node/nodeList/300001/1/10?nodeName=
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1      | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2      | message     | String        | 否     | 描述                                       |
| 3      | totalCount  | Int           | 否     | 总记录数                                   |
| 4      | data        | List          | 是     | 节点列表                                   |
| 4.1    |             | Object        |        | 节点信息对象                               |
| 4.1.1  | nodeId      | int           | 否     | 节点编号                                   |
| 4.1.2  | nodeName    | string        | 否     | 节点名称                                   |
| 4.1.3  | groupId     | int           | 否     | 所属群组编号                               |
| 4.1.4  | nodeActive  | int           | 否     | 状态                                       |
| 4.1.5  | nodeIp      | string        | 否     | 节点ip                                     |
| 4.1.6  | P2pPort     | int           | 否     | 节点p2p端口                                |
| 4.1.7 | description | String        | 否     | 备注                                       |
| 4.1.8 | blockNumber | BigInteger    | 否     | 节点块高                                   |
| 4.1.9 | pbftView    | BigInteger    | 否     | Pbft view                                  |
| 4.1.10 | createTime  | LocalDateTime | 否     | 落库时间                                   |
| 4.1.11 | modifyTime  | LocalDateTime | 否     | 修改时间                                   |
| 4.1.12 | city        | String | 否     | 节点所在城市                                   |
| 4.1.13 | agency      | String | 否     | 节点所属机构                                  |

***2）出参示例***

* 成功：
```
{
    "code": 0,
    "message": "success",
    "totalCount": 1,
    "data": [
        {
            "nodeId": "06269e130f8220ebaa78e67832df0de6b4c5ee3f1b14e64ab2bae26510a4bcf997454b35067c1685d4343e6ad84b45c3b8690a858f2831a9247a97a27166ce1f",
            "nodeName": "1_06269e130f8220ebaa78e67832df0de6b4c5ee3f1b14e64ab2bae26510a4bcf997454b35067c1685d4343e6ad84b45c3b8690a858f2831a9247a97",
            "groupId": 1,
            "nodeIp": "127.0.0.1",
            "p2pPort": null,
            "description": null,
            "blockNumber": 589,
            "pbftView": 11,
            "nodeActive": 1,
            "createTime": "2021-07-29 14:44:59",
            "modifyTime": "2021-09-29 16:17:38",
            "city": "430500",
            "agency": "GZ"
        },
    ]
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


### 9.2 查询节点信息


#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/node/nodeInfo/{groupId}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | int           | 是     | 群组id                                     |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/node/nodeInfo/1
```

#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述                                       |
| 3    | data        | Object        |        | 节点信息对象                               |
| 3.1  | nodeId      | int           | 否     | 节点编号                                   |
| 3.2  | nodeName    | string        | 否     | 节点名称                                   |
| 3.3  | groupId     | int           | 否     | 所属群组编号                               |
| 3.4  | nodeActive  | int           | 否     | 状态                                       |
| 3.5  | nodeIp      | string        | 否     | 节点ip                                     |
| 3.6  | P2pPort     | int           | 否     | 节点p2p端口                                |
| 3.7 | description | String        | 否     | 备注                                       |
| 3.8 | blockNumber | BigInteger    | 否     | 节点块高                                   |
| 3.9 | pbftView    | BigInteger    | 否     | Pbft view                                  |
| 3.10 | createTime  | LocalDateTime | 否     | 落库时间                                   |
| 3.11 | modifyTime  | LocalDateTime | 否     | 修改时间                                   |
| 3.12 | city        | String | 否     | 节点所在城市                                   |
| 3.13 | agency      | String | 否     | 节点所属机构                                  |

***2）出参示例***

* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": {
        "nodeId": "06269e130f8220ebaa78e67832df0de6b4c5ee3f1b14e64ab2bae26510a4bcf997454b35067c1685d4343e6ad84b45c3b8690a858f2831a9247a97a27166ce1f",
        "nodeName": "1_06269e130f8220ebaa78e67832df0de6b4c5ee3f1b14e64ab2bae26510a4bcf997454b35067c1685d4343e6ad84b45c3b8690a858f2831a9247a97",
        "groupId": 1,
        "nodeIp": "127.0.0.1",
        "p2pPort": null,
        "description": null,
        "blockNumber": 589,
        "pbftView": 11,
        "nodeActive": 1,
        "createTime": "2021-07-29 14:44:59",
        "modifyTime": "2021-09-29 16:17:38",
        "city": "430500",
        "agency": "GZ"
    },
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


### 9.3 查询群组下的节点ID列表


#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/node/nodeIdList/{groupId}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数


***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1      | groupId   | int           | 是     | 群组id                                     |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/node/nodeIdList/1
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1      | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2      | message     | String        | 否     | 描述                                       |
| 3      | totalCount  | Int           | 否     | 总记录数                                   |
| 4      | data        | List<String>          | 是     | 节点ID列表                                   |

***2）出参示例***

* 成功：
```
{
  "code": 0,
  "message": "success",
  "data": [
    "fe57d7b39ed104b4fb2770ae5aad7946bfd377d0eb91ab92a383447e834c3257dec56686551d08178f2d5f40d9fad615293e46c9f5fc23cf187258e121213b1d",
    "65bc44d398d99d95a9d404aa16e4bfbc2f9ebb40f20439ddef8575a139dc3a80310cfc98a035bd59a67cc5f659f519e3e99b855f3d27f21a889c23a14036d0c7",
    "95efafa5197796e7edf647191de83f4259d7cbb060f4bac5868be474037f49144d581c15d8aef9b07d78f18041a5f43c3c26352ebbf5583cd23070358c8fba39",
    "06269e130f8220ebaa78e67832df0de6b4c5ee3f1b14e64ab2bae26510a4bcf997454b35067c1685d4343e6ad84b45c3b8690a858f2831a9247a97a27166ce1f"
  ],
  "attachment": null
}
```


### 9.4 配置节点备注信息

可配置节点的IP、机构、城市信息，可用于数据监控大屏展示

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/node/description**
* 请求方式：PUT
* 返回格式：JSON

#### 请求参数


***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1      | nodeId   | String           | 是     |  节点ID                                    |
| 1      | nodeIp   | String           | 否     | 节点备注IP                                     |
| 1      | agency   | String           | 否     | 节点备注机构名                                  |
| 1      | city     | String           | 否     | 节点备注城市                              |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/node/description
```

{
  "agency": "org1",
  "city": "GZ",
  "nodeId": "06269e130f8220ebaa78e67832df0de6b4c5ee3f1b14e64ab2bae26510a4bcf997454b35067c1685d4343e6ad84b45c3b8690a858f2831a9247a97a27166ce1f",
  "nodeIp": "127.0.0.1"
}

#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1      | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2      | message     | String        | 否     | 描述                                       |

***2）出参示例***

* 成功：
```
{
  "code": 0,
  "message": "success"
}
```


### 9.5 查询节点的城市列表


#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/node/city/list**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数


***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1      | groupId   | int           | 是     | 群组id                                     |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/node/city/list
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1      | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2      | message     | String        | 否     | 描述                                       |
| 3      | data        | List          | 是     |                                    |
| 3.1      | city        | String          | 是     |   城市名                                 |
| 3.2      | count        | Int          | 是     |   节点数                                 |

***2）出参示例***

* 成功：
```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "city": "110100", // 此处为城市ID
      "count": 2
    },
    {
      "city": "430500",
      "count": 1
    },
    {
      "city": "440300",
      "count": 1
    }
  ],
  "attachment": null
}
```


## 10 角色管理模块


### 10.1 查询角色列表


### 10.1.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**role/roleList**
* 请求方式：GET
* 返回格式：JSON

### 10.1.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | roleId      | int           | 是     | 角色id                     |
| 2     | roleName    | String        | 否     | 角色名称                   |
| 3     | pageSize    | int           | 是     | 每页记录数                 |
| 4     | pageNumber  | int           | 是     | 当前页码                   |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/role/roleList?groupId=300001&pageNumber=&pageSize=&roleId=&roleName=
```

#### 10.1.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | code        | Int           | 否     | 返回码，0：成功 其它：失败 |
| 2     | message     | String        | 否     | 描述                       |
| 3     | totalCount  | Int           | 否     | 总记录数                   |
| 4     | data        | List          | 否     | 组织列表                   |
| 4.1   |             | Object        |        | 组织信息对象               |
| 4.1.1 | roleId      | Int           | 否     | 角色编号                   |
| 4.1.2 | roleName    | String        | 否     | 角色名称                   |
| 4.1.3 | roleNameZh  | String        | 否     | 角色中文名称               |
| 4.1.4 | roleStatus  | Int           | 否     | 状态（1-正常2-无效） 默认1 |
| 4.1.5 | description | String        | 否     | 备注                       |
| 4.1.6 | createTime  | LocalDateTime | 否     | 创建时间                   |
| 4.1.7 | modifyTime  | LocalDateTime | 否     | 修改时间                   |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "totalCount": 2,
    "data": [
        {
            "roleId": 100000,
            "roleName": "admin",
            "roleNameZh": "管理员",
            "roleStatus": 1,
            "description": null,
            "createTime": "2019-02-14 17:33:50",
            "modifyTime": "2019-02-14 17:33:50"
        },
        {
            "roleId": 100001,
            "roleName": "visitor",
            "roleNameZh": "访客",
            "roleStatus": 1,
            "description": null,
            "createTime": "2019-02-14 17:33:50",
            "modifyTime": "2019-02-14 17:33:50"
        }
    ]
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


## 11 用户管理模块 

### 11.1 新增私钥用户


#### 11.1.1 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/user/userInfo**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 11.1.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型   | 必填 | 备注     |
| ---- | ----------- | ------ | ------ | -------- |
| 1    | userName    | string | 是     | 用户名称 |
| 2    | description | string | 否     | 备注     |
| 3    | groupId     | Int    | 是     | 所属群组 |
| 4    | account     | string | 是     | 关联账户 |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/user/userInfo
```

```
{
    "groupId": "300001",
    "description": "密钥拥有者",
    "userName": "user1",
    "account": "admin"
}
```


#### 11.1.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |      | 备注                               |
| ---- | ----------- | ------------- | ---- | ---------------------------------- |
| 1    | code        | Int           | 否   | 返回码，0：成功 其它：失败         |
| 2    | message     | String        | 否   | 描述                               |
| 3    | data        | object        | 是   | 返回信息实体（成功时不为空）       |
| 3.1  | userId      | int           | 否   | 用户编号                           |
| 3.2  | userName    | string        | 否   | 用户名称                           |
| 3.3  | groupId     | int           | 否   | 所属群组编号                       |
| 3.4  | description | String        | 是   | 备注                               |
| 3.5  | userStatus  | int           | 否   | 状态（1-正常 2-停用） 默认1        |
| 3.6  | publicKey   | String        | 否   | 公钥信息                           |
| 3.7  | address     | String        | 是   | 在链上位置的hash                   |
| 3.8  | hasPk       | Int           | 否   | 是否拥有私钥信息(1-拥有，2-不拥有) |
| 3.9  | account     | string        | 否   | 关联账户                           |
| 3.10 | createTime  | LocalDateTime | 否   | 创建时间                           |
| 3.11 | modifyTime  | LocalDateTime | 否   | 修改时间                           |


***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "userId": 700007,
        "userName": "asdfvw",
        "groupId": 300001,
        "publicKey": "0x4189fdacff55fb99172e015e1adc360777bee6682fcc975238aabf144fbf610a3057fd4b5",
        "userStatus": 1,
        "userType": 1,
        "address": "0x40ec3c20b5178401ae14ad8ce9c9f94fa5ebb86a",
        "hasPk": 1,
        "description": "sda",
        "account": "admin",
        "createTime": "2019-03-15 18:00:27",
        "modifyTime": "2019-03-15 18:00:27"
    }
}
```

* 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


### 11.2 绑定公钥用户


#### 11.2.1 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/user/bind**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 11.2.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型   | 必填 | 备注     |
| ---- | ----------- | ------ | ------ | -------- |
| 1    | userName    | string | 是     | 用户名称 |
| 2    | description | string | 否     | 备注     |
| 3    | groupId     | Int    | 是     | 所属群组 |
| 4    | account     | string | 是     | 关联账户 |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/user/userInfo
```

```
{
    "userName": "sdfasd",
    "publicKey": "0x4189fdacff55fb99172e015e1adb96dc77b0cae1619b1a41cc360777bee6682fcc9752d8aabf144fbf610a3057fd4b5",
    "groupId": "300001",
    "description": "sdfa",
    "account": "admin"
}
```


#### 11.2.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |      | 备注                               |
| ---- | ----------- | ------------- | ---- | ---------------------------------- |
| 1    | code        | Int           | 否   | 返回码，0：成功 其它：失败         |
| 2    | message     | String        | 否   | 描述                               |
| 3    | data        | object        | 是   | 返回信息实体（成功时不为空）       |
| 3.1  | userId      | int           | 否   | 用户编号                           |
| 3.2  | userName    | string        | 否   | 用户名称                           |
| 3.3  | groupId     | int           | 否   | 所属群组编号                       |
| 3.4  | description | String        | 是   | 备注                               |
| 3.5  | userStatus  | int           | 否   | 状态（1-正常 2-停用） 默认1        |
| 3.6  | publicKey   | String        | 否   | 公钥信息                           |
| 3.7  | address     | String        | 是   | 在链上位置的hash                   |
| 3.8  | hasPk       | Int           | 否   | 是否拥有私钥信息(1-拥有，2-不拥有) |
| 3.9  | account     | string        | 否   | 关联账户                           |
| 3.10 | createTime  | LocalDateTime | 否   | 创建时间                           |
| 3.11 | modifyTime  | LocalDateTime | 否   | 修改时间                           |


***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "userId": 700007,
        "userName": "asdfvw",
        "groupId": 300001,
        "publicKey": "0x4189fdacff55fb99172e015e1adb96dc77b0cae1619b1a41cc360777bee6682fcc9752d8aabf144fbf610a3057fd4b5",
        "userStatus": 1,
        "userType": 1,
        "address": "0x40ec3c20b5178401ae14ad8ce9c9f94fa5ebb86a",
        "hasPk": 1,
        "description": "sda",
        "account": "admin",
        "createTime": "2019-03-15 18:00:27",
        "modifyTime": "2019-03-15 18:00:27"
    }
}
```

* 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


### 11.3 修改用户备注


#### 11.3.1 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/user/userInfo**
* 请求方式：PUT
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 11.3.2 请求参数


***1）入参表***

| 序号 | 输入参数    | 类型   | 必填 | 备注     |
| ---- | ----------- | ------ | ------ | -------- |
| 1    | userId      | int    | 是     | 用户编号 |
| 2    | description | String | 否     | 备注     |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/user/userInfo
```

```
{
    "userId": "400001",
    "description": "newDescription"
}
```


#### 11.3.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |      | 备注                               |
| ---- | ----------- | ------------- | ---- | ---------------------------------- |
| 1    | code        | Int           | 否   | 返回码，0：成功 其它：失败         |
| 2    | message     | String        | 否   | 描述                               |
| 3    | data        | object        | 是   | 返回信息实体（成功时不为空）       |
| 3.1  | userId      | int           | 否   | 用户编号                           |
| 3.2  | userName    | string        | 否   | 用户名称                           |
| 3.3  | groupId     | int           | 否   | 所属群组编号                       |
| 3.4  | description | String        | 是   | 备注                               |
| 3.5  | userStatus  | int           | 否   | 状态（1-正常 2-停用） 默认1        |
| 3.6  | publicKey   | String        | 否   | 公钥信息                           |
| 3.7  | address     | String        | 是   | 在链上位置的hash                   |
| 3.8  | hasPk       | Int           | 否   | 是否拥有私钥信息(1-拥有，2-不拥有) |
| 3.9  | account     | string        | 否   | 关联账户                           |
| 3.10 | createTime  | LocalDateTime | 否   | 创建时间                           |
| 3.11 | modifyTime  | LocalDateTime | 否   | 修改时间                           |


***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "userId": 400001,
        "userName": "asdfvw",
        "groupId": 300001,
        "publicKey": "0x4189fdacff55fb99172e015e1682fcc9752d8aabf144fbf610a3057fd4b5",
        "userStatus": 1,
        "userType": 1,
        "address": "0x40ec3c20b5178401ae14ad8ce9c9f94fa5ebb86a",
        "hasPk": 1,
        "description": "newDescription",
        "account": "admin",
        "createTime": "2019-03-15 18:00:27",
        "modifyTime": "2019-03-15 18:00:27"
    }
}
```

* 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 11.4 查询私钥（1.3.0已移除）


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/user/privateKey/{userId}**
* 请求方式：GET
* 返回格式：json

#### 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型 | 必填 | 备注     |
| ---- | -------- | ---- | ------ | -------- |
| 1    | userId   | int  | 是     | 用户编号 |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/user/privateKey/4585
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数   | 类型   |      | 备注                       |
| ---- | ---------- | ------ | ---- | -------------------------- |
| 1    | code       | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message    | String | 否   | 描述                       |
| 3    | data       | Object | 否   | 返回私钥信息实体           |
| 3.1  | privateKey | String | 否   | 私钥                       |
| 3.2  | address    | String | 否   | 用户链上地址               |


***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "privateKey": 123456,
        "address": "asfsafasfasfasfasfas"
    }
}
```

* 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 11.5 查询用户列表


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/user/userList/{groupId}/{pageNumber}/{pageSize}?userParam={userName}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型   | 必填 | 备注                         |
| ---- | ---------- | ------ | ------ | ---------------------------- |
| 1    | groupId    | int    | 是     | 所属群组id                   |
| 2    | pageSize   | Int    | 是     | 每页记录数                   |
| 3    | pageNumber | Int    | 是     | 当前页码                     |
| 4    | userParam  | String | 否     | 查询参数（用户名或公钥地址） |
| 5    | account    | string | 否     | 关联账户                     |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/user/userList/300001/1/10?userParam=asdfvw
```


#### 返回参数 

***1）出参表***

| 序号   | 输出参数    | 类型          |      | 备注                               |
| ------ | ----------- | ------------- | ---- | ---------------------------------- |
| 1      | code        | Int           | 否   | 返回码，0：成功 其它：失败         |
| 2      | message     | String        | 否   | 描述                               |
| 3      | totalCount  | Int           | 否   | 总记录数                           |
| 4      | data        | List          | 是   | 用户列表                           |
| 4.1    |             | Object        |      | 用户信息对象                       |
| 4.1.1  | userId      | int           | 否   | 用户编号                           |
| 4.1.2  | userName    | string        | 否   | 用户名称                           |
| 4.1.3  | groupId     | int           | 否   | 所属群组编号                       |
| 4.1.4  | description | String        | 是   | 备注                               |
| 4.1.5  | userStatus  | int           | 否   | 状态（1-正常 2-停用） 默认1        |
| 4.1.6  | publicKey   | String        | 否   | 公钥信息                           |
| 4.1.7  | address     | String        | 是   | 在链上位置的hash                   |
| 4.1.8  | hasPk       | Int           | 否   | 是否拥有私钥信息(1-拥有，2-不拥有) |
| 4.1.9  | account     | string        | 否   | 关联账户                           |
| 4.1.10 | createTime  | LocalDateTime | 否   | 创建时间                           |
| 4.1.11 | modifyTime  | LocalDateTime | 否   | 修改时间                           |
| 4.1.12 | signUserId  | String        | 否   | 用户在WeBASE-Sign中的编号          |


***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success",
    "totalCount": 1,
    "data": [
        {
            "userId": 700007,
            "userName": "asdfvw",
            "groupId": 300001,
            "publicKey": "0x4189fdacff55fb99172e015e1adb96dc71cc360777bee6682fcc975238aabf144fbf610a3057fd4b5",
            "userStatus": 1,
            "userType": 1,
            "address": "0x40ec3c20b5178401ae14ad8ce9c9f94fa5ebb86a",
            "hasPk": 1,
            "description": "sda",
            "account": "admin",
            "createTime": "2019-03-15 18:00:27",
            "modifyTime": "2019-03-15 18:00:28"
        }
    ]
}
```

* 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


### 11.6 导入私钥用户

可在页面导入WeBASE-Front所导出的私钥txt文件

其中私钥字段用Base64加密

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/user/import**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型   | 必填 | 备注                   |
| ---- | ----------- | ------ | ------ | ---------------------- |
| 1    | privateKey  | string | 是     | Base64加密后的私钥内容 |
| 2    | userName    | string | 是     | 用户名称               |
| 3    | description | string | 否     | 备注                   |
| 4    | groupId     | Int    | 是     | 所属群组               |
| 5    | account     | string | 是     | 关联账户               |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/user/import
```

```
{
    "privateKey": "OGFmNWIzMzNmYTc3MGFhY2UwNjdjYTY3ZDRmMzE4MzU4OWRmOThkMjVjYzEzZGFlMGJmODhkYjhlYzVhMDcxYw==",
    "groupId": "300001",
    "description": "密钥拥有者",
    "userName": "user1",
    "account": "admin"
}
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |


***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success"
}
```

* 失败：

```
{
    "code": 201031,
    "message": "privateKey decode fail",
    "data": null
}
```


### 11.7 导入.pem私钥

可导入控制台所生成的私钥.pem文件

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/user/importPem**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型   | 必填 | 备注                                                         |
| ---- | ----------- | ------ | ------ | ------------------------------------------------------------ |
| 1    | pemContent  | string | 是     | pem文件的内容，必须以`-----BEGIN PRIVATE KEY-----\n`开头，以`\n-----END PRIVATE KEY-----\n`结尾的格式 |
| 2    | userName    | string | 是     | 用户名称                                                     |
| 3    | description | string | 否     | 备注                                                         |
| 4    | groupId     | Int    | 是     | 所属群组                                                     |
| 5    | account     | string | 是     | 关联账户                                                     |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/user/importPem
```

```
{
    "pemContent":"-----BEGIN PRIVATE KEY-----\nMIGEAgEAMBAGByqGSM49AgEGBSuBBAAKBG0wawIBAQQgC8TbvFSMA9y3CghFt51/\nXmExewlioX99veYHOV7dTvOhRANCAASZtMhCTcaedNP+H7iljbTIqXOFM6qm5aVs\nfM/yuDBK2MRfFbfnOYVTNKyOSnmkY+xBfCR8Q86wcsQm9NZpkmFK\n-----END PRIVATE KEY-----\n",
    "groupId": "1",
    "description": "密钥拥有者",
    "userName": "user2",
    "account": "admin"
}
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |


***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success"
}
```

* 失败：

```
{
    "code": 201232,
    "message": "Pem file format error, must surrounded by -----XXXXX PRIVATE KEY-----"",
    "data": null
}
```


### 11.8 导入.p12私钥

可导入控制台生成的私钥.p12文件

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/user/importP12**
* 请求方式：POST
* 请求头：Content-type: **form-data**
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                                         |
| ---- | ----------- | ------------- | ------ | ------------------------------------------------------------ |
| 1    | p12File     | MultipartFile | 是     | .p12文件                                                     |
| 2    | p12Password | string        | 否     | 使用base64编码的密码；.p12文件的密码，缺省时默认为""，即空密码；p12无密码时，可传入空值或不传；不包含中文 |
| 3    | userName    | string        | 是     | 用户名称                                                     |
| 4    | description | string        | 否     | 备注                                                         |
| 5    | groupId     | Int           | 是     | 所属群组                                                     |
| 6    | account     | string        | 是     | 关联账户                                                     |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/user/importP12
```

> 使用form-data传参

#### 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |


***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success"
}
```

* 失败：（p12文件的密码错误）

```
{
    "code": 201236,
    "message": "p12's password not match",
    "data": null
}
```


### 11.9 导出明文私钥

可在页面导入WeBASE-Front所导出的私钥txt文件

其中私钥字段用Base64加密

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/user/export/{userId}**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型   | 必填 | 备注                   |
| ---- | ----------- | ------ | ------ | ---------------------- |
| 1    | privateKey  | string | 是     | Base64加密后的私钥内容 |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/user/export/300001
```

```
{
    "privateKey": "OGFmNWIzMzNmYTc3MGFhY2UwNjdjYTY3ZDRmMzE4MzU4OWRmOThkMjVjYzEzZGFlMGJmODhkYjhlYzVhMDcxYw==",
    "groupId": "1",
    "description": "密钥拥有者",
    "userName": "user1",
    "account": "admin"
}
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data        | object        | 是   | 返回信息实体（成功时不为空）       |
| 3.1  | userId      | int           | 否   | 用户编号                           |
| 3.2  | userName    | string        | 否   | 用户名称                           |
| 3.3  | groupId     | int           | 否   | 所属群组编号                       |
| 3.4  | description | String        | 是   | 备注                               |
| 3.5  | userStatus  | int           | 否   | 状态（1-正常 2-停用） 默认1        |
| 3.6  | publicKey   | String        | 否   | 公钥信息                           |
| 3.7  | address     | String        | 是   | 在链上位置的hash                   |
| 3.8  | hasPk       | Int           | 否   | 是否拥有私钥信息(1-拥有，2-不拥有) |
| 3.9  | account     | string        | 否   | 关联账户                           |
| 3.10 | createTime  | LocalDateTime | 否   | 创建时间                           |
| 3.11 | modifyTime  | LocalDateTime | 否   | 修改时间                           |
| 3.12  | privateKey   | String        | 否   | 私钥，用base64编码                           |

***2）出参示例***

* 成功：

```
{
	"code": 0,
	"message": "success",
	"data": {
		"userId": 700003,
		"userName": "vivi_d",
		"account": "xyzshen",
		"groupId": 1,
		"publicKey": "04d01115d548e7561b15c38f004d734633687cf4419620095bc5b0f47070afe85aa9f34ffdc815e0d7a8b64537e17bd81579238c5dd9a86d526b051b13f4062327",
		"privateKey": "MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwYw==",
		"userStatus": 1,
		"chainIndex": null,
		"userType": 1,
		"address": "0xdbc23ae43a150ff8884b02cea117b22d1c3b9796",
		"signUserId": "b751efc5d0cc4e12b90908b1f2670258",
		"appId": "1",
		"hasPk": 1,
		"description": "",
		"createTime": "2021-04-06 21:24:12",
		"modifyTime": "2021-04-06 21:24:12"
	},
	"attachment": null
}
```


### 11.10 导出.pem私钥

导出pem格式的私钥文件

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/user/exportPem**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                                         |
| ---- | ----------- | ------------- | ------ | ------------------------------------------------------------ |
| 1    | groupId     | int | 是     | 群组id                                                     |
| 2    | signUserId | string        | 是     | 用户的signUserId |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/user/exportPem
```

#### 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| -    | -     | InputStream    | 否   | 返回文件的二进制流 |


***2）出参示例***

* 成功：

```
-----BEGIN PRIVATE KEY-----
MIGNAgEAMBAGByqGSM49AgEGBSuBBAAKBHYwdAIBAQQgnAXS1DYA90nML3Kge4Qd
IgMXiQ9cojmRgyjo1BLYXOqgBwYFK4EEAAqhRANCAATLPOzgUzNbo6UeCAjYv2++
FwlBmT1Sa7goXELaazyJEJLbAlAFGB6qvjdA9m2nx5+rTmfGoSuQK9T2hC/vWJfq
-----END PRIVATE KEY-----


```


### 11.11 导出.p12私钥

导出pem格式的私钥文件

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/user/exportP12**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                                         |
| ---- | ----------- | ------------- | ------ | ------------------------------------------------------------ |
| 1    | groupId     | int | 是     | 群组id                                                     |
| 2    | signUserId | string        | 是     | 用户的signUserId |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/user/exportP12
```

#### 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| -    | -     | InputStream    | 否   | 返回文件的二进制流 |


***2）出参示例***

* 成功：

```
// 二进制流

```


## 12 合约方法管理模块 


### 12.1 新增合约方法 


#### 12.1.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/method/add**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 12.1.2 请求参数


***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | Int           | 是     | 所属群组                           |
| 2    | methodList  | List           | 是     | 方法列表                           |
| 2.1  |             | Object           | 是     | 方法实体                           |
| 2.1.1 | abiInfo    | String        | 是     | 合约abi信息                           |
| 2.1.2 | methodId   | String        | 是     | 方法编号                           |
| 2.1.3 | methodType | String        | 是     | 方法类型                           |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/method/add
```

```
{
    "groupId": 2,
    "methodList": [
        {
            "abiInfo": "fsdabiTestfd232222",
            "methodId": "methodIasdfdttttt",
            "methodType": "function"
        }
    ]
}
```


#### 1.1.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败         |
| 2    | message     | String        | 否     | 描述                               |
| 3    | data        | object        | 是     | 返回信息实体（空）       |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": null
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 12.2 根据方法编号查询


#### 12.1.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/method/findById/{groupId}/{methodId}**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 12.1.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | Int           | 是     | 所属群组                           |
| 2    | methodId    | String        | 是     | 方法编号                           |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/method/findById/2/methodIasdfdttttt
```


#### 1.1.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败            |
| 2    | message     | String        | 否     | 描述                               |
| 3  |             | Object           | 否     | 方法实体                           |
| 3.1 | abiInfo    | String        | 否     | 合约abi信息                           |
| 3.2 | methodId   | String        | 否     | 方法编号                           |
| 3.3 | methodType | String        | 否     | 方法类型                           |
| 3.4  | createTime  | LocalDateTime | 否     | 创建时间                           |
| 3.5 | modifyTime  | LocalDateTime | 否     | 修改时间                           |

***2）出参示例***

* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": {
        "methodId": "methodIasdfdttttt",
        "groupId": 2,
        "abiInfo": "fsdabiTestfd232222",
        "methodType": "function",
        "createTime": "2019-04-16 16:59:27",
        "modifyTime": "2019-04-16 16:59:27"
    }
}
```

* 失败：
```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


## 13 系统管理模块

系统管理中的权限管理接口
- 使用FISCO BCOS v2.5.0 与 WeBASE-Node-Manager v1.4.1 (及)以上版本将使用预编译合约中的ChainGovernance接口(本章节[接口13.14](#governance)开始)，详情可参考[FISCO BCOS基于角色的权限控制](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/manual/permission_control.html#id2)
- 使用低于FISCO BCOS v2.5.0 与 WeBASE-Node-Manager v1.4.1版本，则使用接口13.1至13.4接口

### 13.1 查看权限管理

根据PermissionType权限类型，查询该类权限记录列表。共支持查看六种权限的管理员列表：权限管理权限permission, 用户表管理权限userTable, 部署合约和创建用户表权限deployAndCreate, 节点管理权限node, 使用CNS权限cns, 系统参数管理权限sysConfig

#### 13.1.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/permission**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.1.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | int        | 是     | 群组id                                     
| 2    | permissionType      | String           | 是     | 查看拥有某个权限的address list|
| 3    | tableName   | String           | 否     |  type=UserTable的时候不能为空。查看某个表的管理员list
| 4   | pageSize   | int           | 是     |
| 5    | pageNumber   | int           | 是     |
                         

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/permission?groupId=1&permissionType=cns&pageSize=5&pageNumber=1
```



#### 13.1.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           |      | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        |      | 描述    
| 3   | data     | List数组        |      | 直接返回数组                     
| 4   | totalCount     | int        |      | 总数目                          
      


***2）出参示例***
* 成功：
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

* 失败：
```
{
    "code": 400,
    "message": "Required String parameter 'tableName' is not present"
}
```

### 13.2 查看权限管理列表（不分页）

根据PermissionType权限类型，查询该类权限记录列表。共支持查看六种权限的管理员列表：权限管理权限permission, 用户表管理权限userTable, 部署合约和创建用户表权限deployAndCreate, 节点管理权限node, 使用CNS权限cns, 系统参数管理权限sysConfig


#### 13.2.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/permission/full**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.2.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | int        | 是     | 群组id                                     
| 2    | permissionType      | String           | 是     | 查看拥有某个权限的address list|
| 3    | tableName   | String           | 否     |
                     

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/permission/full?groupId=1&permissionType=cns
```


#### 13.2.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           |      | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        |      | 描述    
| 3   | data     | List数组        |      | 直接返回数组                     
| 4   | totalCount     | int        |      | 总数目                          
      


***2）出参示例***
* 成功：
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

* 失败：
```
{
    "code": 400,
    "message": "Required String parameter 'tableName' is not present"
}
```


### 13.3 增加管理权限接口

由管理员赋予外部账户地址不同类型的权限，包含六种：权限管理权限permission, 用户表管理权限userTable, 部署合约和创建用户表权限deployAndCreate, 节点管理权限node, 使用CNS权限cns, 系统参数管理权限sysConfig

其中userTable权限还需传入相应的表明tableName



#### 13.3.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/permission**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.3.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | int        | 是     | 群组id      
| 2    | permissionType     | String        | 是     | 分配权限的类型（六种：permission, userTable, deployAndCreate, node, cns, sysConfig)  
| 3    | fromAddress     | String        | 是     | 管理员自己的地址                                     |
| 4    | address   | String           | 是     | 分配链管理员的用户地址         
| 5    | tableName   | String           | 否     | 当permissionType为userTable时不可为空      
| 6    | useAes     | Boolean        | 否     | 发交易的私钥是否为加密私钥，默认为false  
          

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/permission
```

```
{
    "groupId": 1,
    "permissionType": "permission",
    "fromAddress": "0xd5bba8fe456fce310f529edecef902e4b63129b1",
    "address": "0x2357ad9d97027cd71eea1d639f1e5750fbdfd38e"
}
```


#### 13.3.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述                           


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success"
}
```

* 失败：
```
{
    "code": -51000,
    "message": "table name and address already exist"
}
```


### 13.4 去除管理权限接口

由管理员去除外部账户地址不同类型的权限，包含六种：权限管理权限permission, 用户表管理权限userTable, 部署合约和创建用户表权限deployAndCreate, 节点管理权限node, 使用CNS权限cns, 系统参数管理权限sysConfig

其中userTable权限还需传入相应的表明tableName

#### 13.4.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/permission**
* 请求方式：DELETE
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.4.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | int        | 是     | 群组id      
| 2    | permissionType     | String        | 是     | 分配权限的类型（六种：permission, userTable, deployAndCreate, node, cns, sysConfig)  
| 3    | fromAddress     | String        | 是     | 管理员自己的地址                                     |
| 4    | address   | String           | 是     | 分配链管理员的用户地址         
| 5    | tableName   | String           | 否     | 当permissionType为userTable时不可为空      
| 6    | useAes     | Boolean        | 否     | 发交易的私钥是否为加密私钥，默认为false  
                    

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/permission
```

```
{
    "groupId": 1,
    "permissionType": "permission",
    "fromAddress": "0xd5bba8fe456fce310f529edecef902e4b63129b1",
    "address": "0x2357ad9d97027cd71eea1d639f1e5750fbdfd38e"
}
```


#### 13.4.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述                           


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success"
}
```

* 失败：
```
{
    "code": -51001,
    "message": "table name and address does not exist"
}
```


### 13.5 获取用户权限状态列表

获取所有用户的权限状态列表，权限状态包含有四种权限： 部署合约和创建用户表权限deployAndCreate, 节点管理权限node, 使用CNS权限cns, 系统参数管理权限sysConfig


#### 13.5.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/permission/sorted**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.5.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | int        | 是     | 群组id                                     
| 2    | pageSize      | int           | 否     |  分页大小  |
| 3    | pageNumber   | int           | 否     |    分页页码
                     

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/permission/sorted?groupId=1&pageSize=3&pageNumber=1
```


#### 13.5.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           |      | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        |      | 描述    
| 3   | data     | List数组        |      |  返回权限状态数组               
| 3.1   |      | Object        |      |  以用户地址为key，以用户的权限状态为value的<address, PermissionState>的Map结构体，1为赋予，0为去除                     
| 3.1.1 | deployAndCreate    | Int    |      |  用户的部署与建表权限状态：0-已去除，1-已赋予
| 3.1.2 | cns    | Int    |      |  用户的CNS管理权限状态：0-已去除，1-已赋予
| 3.1.3 | sysConfig    | Int    |      |  用户的系统配置管理权限状态：0-已去除，1-已赋予
| 3.1.4 | node    | Int    |      |  用户的节点共识管理权限状态：0-已去除，1-已赋予
| 4   | totalCount     | Int        |      | 总数目                          
      


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "0x17de6cd8e173bac6f457f3f73d8d9a1b1dd33451": {
                "deployAndCreate": 0,
                "cns": 1,
                "sysConfig": 0,
                "node": 0
            }
        },
        {
            "0x202b4245087dbf797f954d8425459bfee3c790f8": {
                "deployAndCreate": 1,
                "cns": 1,
                "sysConfig": 1,
                "node": 1
            }
        },
        {
            "0x99af2eb68db52ba21a033af235e680feb0ca7ae5": {
                "deployAndCreate": 0,
                "cns": 0,
                "sysConfig": 0,
                "node": 0
            }
        }
    ],
    "totalCount": 11
}
```


### 13.6 管理用户权限状态接口

管理用户的权限状态，权限状态包含有四种权限： 部署合约和创建用户表权限deployAndCreate, 节点管理权限node, 使用CNS权限cns, 系统参数管理权限sysConfig；1代表赋予权限，0代表去除权限

#### 13.6.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/permission/sorted**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.6.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | int        | 是     | 群组id      
| 2    | fromAddress     | String        | 是     | 管理员自己的地址                                     |
| 3    | address   | String           | 是     | 分配链管理员的用户地址         
| 4        | permissionState       | Object |      是   |   使用{"permissionType": 1}的结构格式，1代表赋予，0代表去除；支持cns、deployAndCreate、sysConfig、node四种权限     
                      

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/permission/sorted
```

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


#### 13.6.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述                           
| 3   | data     | List数组        |      |  返回权限状态数组               
| 3.1   |      | Object        |      |  以用户地址为key，以用户的权限状态为value的<address, PermissionState>的Map结构体，1为赋予，0为去除                     
| 3.1.1 | deployAndCreate    | Int    |      |  用户的部署与建表权限状态：0-已去除，1-已赋予
| 3.1.2 | cns    | Int    |      |  用户的CNS管理权限状态：0-已去除，1-已赋予
| 3.1.3 | sysConfig    | Int    |      |  用户的系统配置管理权限状态：0-已去除，1-已赋予
| 3.1.4 | node    | Int    |      |  用户的节点共识管理权限状态：0-已去除，1-已赋予

***2）出参示例***
* 成功：
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

* 失败：
```
{
    "code": 201202,
    "message": "permission denied, please check chain administrator permission"
}
```





### 13.7 查询CNS接口

根据群组id和合约名（或合约名加版本）获取CNS的list列表。

#### 13.7.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/precompiled/cns/list**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.7.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | int        | 是     | 群组id                                     |
| 2    | contractNameAndVersion   | String           | 是     | 只需要合约名,version缺乏时返回所有版本，version与contractName用英文冒号":"连接                             |
| 4   | pageSize   | int           | 是     |
| 5    | pageNumber   | int           | 是     |

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/precompiled/cns/list?groupId=1&contractNameAndVersion=HelloWorld&pageSize=10&pageNumber=1
```



#### 13.7.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述       
| 3    | data     | List数组        | 否     | 描述                           
| 4   | totalCount     | int        |      | 总数目                          



***2）出参示例***
* 成功：

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


### 13.8 获取系统配置

根据群组id获取系统配置SystemConfig的list列表，目前只支持tx_count_limit, tx_gas_limit两个参数。


#### 13.8.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/sys/config/list**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.8.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | int        | 是     | 群组id      
| 2   | pageSize   | int           | 是     |
| 3    | pageNumber   | int           | 是     |

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/sys/config/list?groupId=1&pageSize=10&pageNumber=1
```


#### 13.8.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    
| 3    | data    | 数组        | 否     | list包含数据库存储的配置key与对应value                           



***2）出参示例***
* 成功：
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


### 13.9 设置系统配置

系统配置管理员设置系统配置，目前只支持tx_count_limit, tx_gas_limit两个参数。


#### 13.9.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/sys/config**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.9.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | int        | 是     | 群组id      
| 2    | fromAddress     | String        | 是     | 管理员自己的地址
| 3    | configKey     | String        | 是     | 目前类型两种(tx_count_limit， tx_gas_limit，用户可自定义key如tx_gas_price
 | 4    | configValue     | String        | 是     |  

​                          

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/sys/config
```

```
{
    "groupId": 1,
    "fromAddress": "0xd5bba8fe456fce310f529edecef902e4b63129b1",
    "configKey": "tx_count_limit",
    "configValue": "1001"
}
```


#### 13.9.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    



***2）出参示例***
* 成功：
```
{
  "code": 0,
  "message": "success"
 }
```

* 失败：
```
{
    "code": -50000,
    "message": "permission denied"
}
```




### 13.10 获取节点列表(节点管理)

获取节点的list列表，包含节点id，节点共识状态。

注：接口返回所有的共识/观察节点（无论运行或停止），以及正在运行的游离节点

#### 13.10.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/precompiled/consensus/list**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.10.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | int        | 是     | 群组id    
| 2   | pageSize   | int           | 是     |
| 3    | pageNumber   | int           | 是     |

​         

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/precompiled/consensus/list?groupId=1&pageSize=10&pageNumber=1
```


#### 13.10.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    
| 3    |  data    | List        | 否     | 成功时返回                           



***2）出参示例***
* 成功：
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

### 13.11 设置节点共识状态接口（节点管理）

节点管理相关接口，可用于节点三种共识状态的切换。分别是共识节点sealer, 观察节点observer, 游离节点remove


#### 13.11.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/precompiled/consensus**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.11.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | int        | 否     | 群组id    
| 2    | fromAddress     | String        | 否     | 管理员的地址    
| 3    | nodeType     | String        | 否     | 节点类型：observer,sealer,remove  
| 4    | nodeId     | String        | 否     | 节点id    
| 5    | useAes     | Boolean        | 是     | 发交易的私钥是否为加密私钥，默认为false  
                

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/precompiled/consensus
```

```
{
    "groupId": 1,
    "fromAddress": "0xd5bba8fe456fce310f529edecef902e4b63129b1",
    "nodeType": "remove",
    "nodeId": "224e6ee23e8a02d371298b9aec828f77cc2711da3a981684896715a3711885a3177b3cf7906bf9d1b84e597fad1e0049511139332c04edfe3daddba5ed60cffa"
}
```


#### 13.12.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    ｜



***2）出参示例***
* 成功：

```
[
    {
      "code": 0,
      "message": "success"
     }

]
```

* 失败：

```
{
    "code": -51000,
    "message": "nodeId already exist"
}
```



### 13.13 CRUD表格操作接口

用于操作用户表的CRUD操作，包含create, desc, insert, update, select, remove。

具体sql要求语法参考Fisco-bcos技术文档的  [Precompiled Crud API](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/manual/console.html#create-sql)


#### 13.13.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/precompiled/crud**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.13.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | int        | 是     | 群组id      
| 2    | fromAddress     | String        | 是     | UserTable管理员的地址  
| 3    | sql     | String        | 是     | 需要调用的sql语句  


***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/precompiled/crud
```

```
{
    "groupId": 1,
    "fromAddress": "0xd5bba8fe456fce310f529edecef902e4b63129b1",
    "sql": "desc t_demo"
}
```


#### 13.13.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    
| 3    |  data    | String        | 否     | 调用结果                           



***2）出参示例***
* 成功：

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

或者

```
{
    "code": 0,
    "message": "success",
    "data": {
        "Insert OK, 1 row effected"
    }
}
```

* 失败：

```
{
    "code": 201228,
    "message": "table not exists",
    "data": "Table not exists "
}
```



### 13.14 获取链治理委员列表
<span id="governance"></span>

使用FISCO BCOS v2.5.0 与 WeBASE-Node-Manager v1.4.1 (及)以上版本将使用预编译合约中的ChainGovernance接口(本章节[接口13.14](#governance)开始)，详情可参考[FISCO BCOS基于角色的权限控制](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/manual/permission_control.html#id2)

委员的权限包括治理投票、增删节点、冻结解冻合约、冻结解冻账号、修改链配置和增删运维账号。

增加委员需要链治理委员会投票，有效票大于阈值才可以生效，且不重复计票
- 委员默认的投票权重为1，默认投票生效阈值50%，若有两个委员，则需要两个委员都投票增加/撤销的委员权限，`有效票/总票数=2/2=1>0.5`才满足条件。
- 投票有过期时间，根据块高，过期时间为块高超过blockLimit的10倍时过期；过期时间固定不可改。
- 一个用户不能同时作为委员和运维

#### 13.14.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/governance/committee/list**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.14.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | int        | 是     | 群组id                                     
| 2   | pageSize   | int           | 是     |
| 3    | pageNumber   | int           | 是     |
                         

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/governance/committee/list?groupId=1&pageSize=5&pageNumber=1
```

#### 13.14.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           |      | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        |      | 描述    
| 3   | data     | List数组        |      | 直接返回数组                     
| 4   | totalCount     | int        |      | 总数目                          
      


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "address": "0x009fb217b6d7f010f12e7876d31a738389fecd51",
            "enable_num": "84"
        }
    ],
    "totalCount": 1
}
```


### 13.15 增加链治理委员

增加委员需要链治理委员会投票，有效票大于阈值才可以生效，且不重复计票
- 委员默认的投票权重为1，默认投票生效阈值50%，若有两个委员，则需要两个委员都投票增加/撤销的委员权限，`有效票/总票数=2/2=1>0.5`才满足条件。
- 投票有过期时间，根据块高，过期时间为块高超过blockLimit的10倍时过期；过期时间固定不可改。

#### 13.15.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/governance/committee**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.15.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | int        | 是     | 群组id      
| 2    | fromAddress     | String        | 是     | 链治理委员地址                                     |
| 3    | address   | String           | 是     | 新的链治理委员地址         
          

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/governance/committee
```

```
{
    "groupId": 1,
    "fromAddress": "0xd5bba8fe456fce310f529edecef902e4b63129b1",
    "address": "0x2357ad9d97027cd71eea1d639f1e5750fbdfd38e"
}
```


#### 13.15.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述                           


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success"
}
```

* 失败：
```
{
    "code": -52000,
    "message": "committee member already exist"
}
```


### 13.16 去除链管理委员接口

增加委员需要链治理委员会投票，有效票大于阈值才可以生效，且不重复计票
- 委员默认的投票权重为1，默认投票生效阈值50%，若有两个委员，则需要两个委员都投票增加/撤销的委员权限，`有效票/总票数=2/2=1>0.5`才满足条件。
- 投票有过期时间，根据块高，过期时间为块高超过blockLimit的10倍时过期；过期时间固定不可改。

#### 13.16.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/governance/committee**
* 请求方式：DELETE
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.16.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | int        | 是     | 群组id      
| 2    | fromAddress     | String        | 是     | 链治理委员地址                                     |
| 3    | address   | String           | 是     | 待取消的链治理委员地址         
          

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/governance/committee
```

```
{
    "groupId": 1,
    "fromAddress": "0xd5bba8fe456fce310f529edecef902e4b63129b1",
    "address": "0x2357ad9d97027cd71eea1d639f1e5750fbdfd38e"
}
```


#### 13.16.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述                           


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success"
}
```

* 失败：
```
{
    "code": -52001,
    "message": "committee member not exist"
}
```


### 13.17 获取链治理委员投票权重

委员默认的投票权重为1

#### 13.17.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/governance/committee/weight**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.17.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | int        | 是     | 群组id                                     
| 2   | address   | String           | 是     |
                         

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/governance/committee/weight?groupId=1&address=0x009fb217b6d7f010f12e7876d31a738389fecd51
```

#### 13.17.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           |      | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        |      | 描述    
| 3   | data     | Integer        |      | 权重值                     
      


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": 2
}
```

### 13.18 更新链治理委员投票权重值

委员默认的投票权重为1

#### 13.18.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/governance/committee/weight**
* 请求方式：PUT
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.18.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | int        | 是     | 群组id      
| 2    | fromAddress     | String        | 是     | 链治理委员地址                                     |
| 3    | address   | String           | 是     | 新的链治理委员地址         
| 4    | weight     | int        | 是     | 投票权重值      


***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/governance/committee/weight
```

```
{
    "groupId": 1,
    "fromAddress": "0xd5bba8fe456fce310f529edecef902e4b63129b1",
    "address": "0x2357ad9d97027cd71eea1d639f1e5750fbdfd38e",
    "weight": 2
}
```


#### 13.18.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述                           


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success"
}
```

* 失败：
```
{
    "code": -52001,
    "message": "committee member not exist"
}
```


### 13.19 获取链治理投票阈值

默认投票阈值为50，即超过(不包括)50%的票数权重即可通过

#### 13.19.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/governance/threshold**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.19.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | int        | 是     | 群组id                                     
                         

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/governance/threshold?groupId=1
```

#### 13.19.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           |      | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        |      | 描述    
| 3   | data     | Integer        |      | 阈值                     
      


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": 50
}
```

### 13.19 更新链治理投票阈值

委员默认的投票权重为1

#### 13.19.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/governance/threshold**
* 请求方式：PUT
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.19.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | int        | 是     | 群组id      
| 2    | fromAddress     | String        | 是     | 链治理委员地址                                     |
| 3    | threshold     | int        | 是     | 投票阈值      


***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/governance/threshold
```

```
{
    "groupId": 1,
    "fromAddress": "0xd5bba8fe456fce310f529edecef902e4b63129b1",
    "threshold": 60
}
```


#### 13.19.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述                           


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success"
}
```

* 失败，如非委员更新阈值：
```
{
    "code": -52001,
    "message": "committee member not exist"
}
```


### 13.20 查看运维列表
<span id="operator"></span>
由链治理委员添加运维账号，运维账号可以部署合约、创建表、管理合约版本、冻结解冻本账号部署的合约。

#### 13.20.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/governance/operator/list**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.20.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | int        | 是     | 群组id                                     
| 2   | pageSize   | int           | 是     |
| 3    | pageNumber   | int           | 是     |
                         

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/governance/operator/list?groupId=1&pageSize=5&pageNumber=1
```

#### 13.20.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           |      | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        |      | 描述    
| 3   | data     | List数组        |      | 直接返回数组                     
| 4   | totalCount     | int        |      | 总数目                          
      


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "address": "0x009fb217b6d7f010f12e7876d31a738389fecd51",
            "enable_num": "4"
        }
    ],
    "totalCount": 1
}
```


### 13.21 增加运维接口

由链治理委员添加/去除运维账号，运维账号可以部署合约、创建表、管理合约版本、冻结解冻本账号部署的合约。

#### 13.21.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/governance/operator**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.21.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | int        | 是     | 群组id      
| 3    | fromAddress     | String        | 是     | 链治理委员地址                                     |
| 4    | address   | String           | 是     | 运维地址         
          

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/governance/operator
```

```
{
    "groupId": 1,
    "fromAddress": "0xd5bba8fe456fce310f529edecef902e4b63129b1",
    "address": "0x2357ad9d97027cd71eea1d639f1e5750fbdfd38e"
}
```


#### 13.21.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述                           


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success"
}
```

* 失败：
```
{
    "code": -52001,
    "message": "committee member not exist"
}
```

或

```
{
    "code": -52005,
    "message": "committee member cannot be operator"
}
```


### 13.22 去除运维接口

由链治理委员添加/去除运维账号，运维账号可以部署合约、创建表、管理合约版本、冻结解冻本账号部署的合约。

#### 13.22.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/governance/operator**
* 请求方式：DELETE
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.22.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | int        | 是     | 群组id      
| 3    | fromAddress     | String        | 是     | 链治理委员地址                                     |
| 4    | address   | String           | 是     | 运维地址         
          

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/governance/operator
```

```
{
    "groupId": 1,
    "fromAddress": "0xd5bba8fe456fce310f529edecef902e4b63129b1",
    "address": "0x2357ad9d97027cd71eea1d639f1e5750fbdfd38e"
}
```


#### 13.22.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述                           


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success"
}
```

* 失败：
```
{
    "code": -52001,
    "message": "committee member not exist"
}
```


### 13.23 合约状态管理

由**合约部署者**（一般由运维所部属）与链治理委员共同管理合约的状态，包含冻结/解冻合约、查询合约状态功能

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/precompiled/contract/status**
* 请求方式： POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | int        | 是     | 群组id      
| 2    | fromAddress     | String   | 是     | 合约管理者地址                                     |
| 3    | contractAddress | String | 是     | 已部署的合约地址                                             |
| 4    | handleType      | String | 是     | 操作类型：freeze-冻结；unfreeze-解冻；getStatus-查询合约状态； |


***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/precompiled/contract/status
```

```
{
    "groupId": 1,
    "fromAddress": "0xd5bba8fe456fce310f529edecef902e4b63129b1",
    "contractAddress": "0x2357ad9d97027cd71eea1d639f1e5750fbdfd38e",
    "handleType": "freeze"
}
```


#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述                           


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success"
}
```

* 失败：
```
{
    "code": -52007,
    "message": "operator member not exist"
}
```


### 13.24 批量查看合约冻结状态

传入多个合约地址的List，查看该合约地址的冻结状态

#### 13.24.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/precompiled/contract/status/list**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.24.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | int        | 是     | 群组id                                     
| 2   | addressList   | List<String>           | 是     | 多个合约地址的列表
                         

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/precompiled/contract/status/list
```

```
{
    "groupId": 1,
    "addressList": ["0x009fb217b6d7f010f12e7876d31a738389fecd51", "0x6b9fb217b6d7f010f12e7876d31a738389feef62"]
}
```

#### 13.24.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           |      | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        |      | 描述    
| 3   | data     | Map        |      | 直接返回Map, 0-正常，1-冻结 如：["0x009fb217b6d7f010f12e7876d31a738389fecd51": 0, "0x6b9fb217b6d7f010f12e7876d31a738389feef62": 1]                     
      


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": [
        "0x009fb217b6d7f010f12e7876d31a738389fecd51": 0,
        "0x6b9fb217b6d7f010f12e7876d31a738389feef62": 1
    ],
    "totalCount": 1
}
```



### 13.25 获取链委员会投票记录列表  

当链委员会发起一笔交易时会产生一条投票记录，此接口返回某群组下的修改记录列表

#### 13.25.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/vote/record/list**
* 请求方式：GET
* 返回格式：JSON

#### 13.25.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId         | int           | 是     | 群组编号                                        |
| 2    | pageNumber         | int           | 是     | 页码，从1开始                                        |
| 3    | pageSize         | int           | 是     | 页大小                                        |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/vote/record/list?groupId=1&pageNumber=1&pageSize=10
```


#### 13.25.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code            | Int           | 否     | 返回码，0：成功 其它：失败                      |
| 2    | message         | String        | 否     | 描述                                            |
| 3    |                 | Object         |        | 返回信息实体                                    |
| 3.1  | id        | int           | 否     | 合约记录编号                                        |
| 3.2  | groupId       | Int           | 否     | 所属群组编号                                      |
| 3.3  | timeLimit    | Long        | 否     | 投票块高限制范围                                        |
| 3.4  | fromAddress  | String        | 否     | 链委员的地址                                        |
| 3.5  | type     | Int        | 否     |          投票类型，1-增加委员，2-去除委员，3-更新委员权重，4-更新阈值  |
| 3.6  | toAddress  | String        | 否     | 被修改的外部账户地址，当类型为1,2,3时为非空                                        |
| 3.7  | detail     | String        | 否     |         投票内容详情，当类型为3,4时为非空；3-`{weight: 2}`，4-`{threshold: 2}`   |
| 3.8 | createTime      | LocalDateTime | 否     | 创建时间                                        |
| 3.9 | modifyTime      | LocalDateTime | 是     | 修改时间                                        |
| 4    |  totalCount    | Int         |        | 总数                                    |


***2）出参示例***
* 成功：
```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "id": 1,
      "groupId": 1,
      "timeLimit": 200,      
      "fromAddress": "0x2ac4227e87bccca63893317febadd0b51ad33e1",
      "type": 3,
      "toAddress": "0x3214227e87bccca63893317febadd0b51ade735e",
      "detail": "{weight: 2}",
      "createTime": "2020-09-18 10:59:02",
      "modifyTime": "2020-09-18 10:59:02"
    }
  ],
  "totalCount": 1
}
```


### 13.26 删除链委员会投票记录  

删除投票记录

#### 13.26.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/vote/record/{voteId}**
* 请求方式：DELETE
* 返回格式：JSON

#### 13.26.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | voteId         | int           | 是     | 投票记录编号                                        |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/vote/record/{voteId}
```


#### 13.26.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code            | Int           | 否     | 返回码，0：成功 其它：失败                      |
| 2    | message         | String        | 否     | 描述                                            |


***2）出参示例***
* 成功：
```
{
  "code": 0,
  "message": "success"
}
```



### 13.27 获取链治理委员列表(包含权重)  

获取链治理委员列表，同时返回委员投票的权重值

#### 13.27.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/governance/committee/list/sorted**
* 请求方式：GET
* 返回格式：JSON

#### 13.27.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId         | int           | 是     | 群组编号                                        |
| 2    | pageNumber         | int           | 是     | 页码，从1开始                                        |
| 3    | pageSize         | int           | 是     | 页大小                                        |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/governance/committee/list/sorted?groupId=1&pageNumber=1&pageSize=10
```


#### 13.27.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code            | Int           | 否     | 返回码，0：成功 其它：失败                      |
| 2    | message         | String        | 否     | 描述                                            |
| 3    |                 | Object         |        | 返回信息实体                                    |
| 3.1  | weight        | Int           | 否     | 委员投票权重值                                        |
| 3.2  | weightRate    | BigDecimal           | 否     | 权重比                                      |
| 3.3  | address       | String           | 否     | 委员的用户地址                                      |
| 3.4  | enable_num    | Int           | 否     | 委员生效块高                                      |
| 4    |  totalCount    | Int         |        | 总数                                    |


***2）出参示例***
* 成功：
```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "weight": 1,
      "weightRate": 33.3
      "address": "0x2ac4227e87bccca63893317febadd0b51ad33e1",
      "enable_num": 3
    }
  ],
  "totalCount": 1
}
```



## 14 证书管理模块

### 14.1 获取证书列表接口

获取证书的list列表，返回的列表包含证书指纹、证书内容、证书名字、证书的父证书、证书对应nodeid（节点证书）、证书有效期

注：首次启动项目会自动拉取每一个Front的证书

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/cert/list**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
|     | -     | -        |      |

​         

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/cert/list
```


#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    
| 3    |  data    | List        | 否     | 成功时返回证书相关信息的列表                          
| 3    |      | Object        | 否     | 单个证书相关信息                           
| 3.1    |  fingerPrint    | String        | 否     | 证书的指纹                           
| 3.1    |  certName    | String        | 否     | 证书名字                           
| 3.1    |  content    | String        | 否     | 证书文件的内容                           
| 3.1    |  certType    | String        | 否     | 证书类型：chain, agency, node, sdk等，国密版中node证书分为加密ennode证书与签名gmnode证书                           
| 3.1    |  publicKey    | String        | 否     | 证书对应nodeid（仅限节点证书公钥）                           
| 3.1    |  address    | String        | 否     | 证书对应地址（仅限节点证书公钥）                         
| 3.1    |  father    | String        | 否     | 证书的父证书指纹                           
| 3.1    |  validityFrom    | Date        | 否     | 证书有效期开始时间                           
| 3.1    |  validityTo    | Date        | 否     | 证书有效期结束时间                           
| 3.1    |  createTime    | LocalDateTime        | 否     | 导入创建时间                          


***2）出参示例***
* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "fingerPrint": "814D51FB7CBAB33676FE73E8FBBFECB3D3B1301A",
            "certName": "sdk",
            "content": "-----BEGIN CERTIFICATE-----\nMIICOTCCASGgAwIBAgIJAKHsAYI3TsAOMA0GCSqGSIb3DQEBCwUAMDgxEDAOBgNV\nBAMMB2FnZW5jeUExEzARBgNVBAoMCmZpc2NvLWJjb3MxDzANBgNVBAsMBmFnZW5j\neTAeFw0xOTA3MTIwMjA2MTZaFw0yOTA3MDkwMjA2MTZaMDIxDDAKBgNVBAMMA3Nk\nazETMBEGA1UECgwKZmlzY28tYmNvczENMAsGA1UECwwEbm9kZTBWMBAGByqGSM49\nAgEGBSuBBAAKA0IABJ79rSKIb97xZwByW58xH6tzoNKNLaKG7J5wxAEgAb03O2h4\nMkEMLtf/LB7tELOiyCiIEhLScprb1LjvDDt2RDGjGjAYMAkGA1UdEwQCMAAwCwYD\nVR0PBAQDAgXgMA0GCSqGSIb3DQEBCwUAA4IBAQC0u2lfclRmCszBTi2rtvMibZec\noalRC0sQPBPRb7UQhGCodxmsAT3dBUf+s4wLLrmN/cnNhq5HVObbWxzfu7gn3+IN\nyQEeqdbGdzlu1EDcaMgAz6p2W3+FG/tmx/yrNza29cYekWRL44OT5LOUPEKrJ4bJ\neOBRY4QlwZPFmM0QgP7DoKxHXldRopkmvqT4pbW51hWvPgj7KrdqwbVWzuWQuI3i\n3j3O96XZJsaDZ0+IGa5093+TsTNPfWUZzp5Kg+EyNR6Ea1evuMDNq9NAqqcd5bX9\nO9kgkb8+llO8I5ZhdnN0BuhGvv9wpsa9hW8BImOLzUBwfSVYouGCkoqlVq9X\n-----END CERTIFICATE-----\n",
            "certType": "node",
            "publicKey": "9efdad22886fdef16700725b9f311fab73a0d28d2da286ec9e70c4012001bd373b687832410c2ed7ff2c1eed10b3a2c828881212d2729adbd4b8ef0c3b764431",
            "address": "5cb81b06ef0734fff99929c5deae4a5b25e800cc",
            "father": "EEBAAB2F674D05CF1EAD70367B4D2A928D894EF8",
            "validityFrom": 1562860800000,
            "validityTo": 1878220800000,
            "createTime": 1569686400000
        }
    ],
    "totalCount": 1
}

```


### 14.2 根据指纹获取证书接口

根据指纹获取单个证书


#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/cert**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | fingerPrint     | String        | 是     | 证书指纹，证书唯一标识   |

​         

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/cert?fingerPrint=814D51FB7CBAB33676FE73E8FBBFECB3D3B1301A
```


#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    
| 3    |  data    | List        | 否     | 成功时返回                           
| 3    |      | Object        | 否     | 单个证书相关信息                           
| 3.1    |  fingerPrint    | String        | 否     | 证书的指纹                           
| 3.1    |  certName    | String        | 否     | 证书名字                           
| 3.1    |  content    | String        | 否     | 证书文件的内容                           
| 3.1    |  certType    | String        | 否     | 证书类型：chain, agency, node, sdk等，国密版node证书分为加密ennode证书与签名gmnode证书                          
| 3.1    |  publicKey    | String        | 否     | 证书对应nodeid（仅限节点证书公钥）                           
| 3.1    |  address    | String        | 否     | 证书对应地址（仅限节点证书公钥）                         
| 3.1    |  father    | String        | 否     | 证书的父证书指纹                           
| 3.1    |  validityFrom    | Date        | 否     | 证书有效期开始时间                           
| 3.1    |  validityTo    | Date        | 否     | 证书有效期结束时间                           
| 3.1    |  createTime    | LocalDateTime        | 否     | 导入创建时间 


***2）出参示例***
* 成功：'

```
{
    "code": 0,
    "message": "success",
    "data": {
        "fingerPrint": "EEBAAB2F674D05CF1EAD70367B4D2A928D894EF8",
        "certName": "agencyA",
        "content": "-----BEGIN CERTIFICATE-----\nMIIDADCCAeigAwIBAgIJAJUF2Dp1a9U6MA0GCSqGSIb3DQEBCwUAMDUxDjAMBgNV\nBAMMBWNoYWluMRMwEQYDVQQKDApmaXNjby1iY29zMQ4wDAYDVQQLDAVjaGFpbjAe\nFw0xOTA3MTIwMjA2MTZaFw0yOTA3MDkwMjA2MTZaMDgxEDAOBgNVBAMMB2FnZW5j\neUExEzARBgNVBAoMCmZpc2NvLWJjb3MxDzANBgNVBAsMBmFnZW5jeTCCASIwDQYJ\nKoZIhvcNAQEBBQADggEPADCCAQoCggEBANBT4CTciIYdSeEabgJzif+CFB0y3GzG\ny+XQYtWK+TtdJWduXqhnnZiYAZs7OPGEu79Yx/bEpjEXsu2cXH0D6BHZk+wvuxG6\nezXWq5MYjCw3fQiSRWkDYoxzWgulkRyYROF1xoZeNGQssReFmCgP+pcQwRxjcq8z\nIA9iT61YxyW5nrS7xnra9uZq/EE3tsJ0ae3ax6zixCT66aV49S27cMcisS+XKP/q\nEVPxhO7SUjnzZY69MgZzNSFxCzIbapnlmYAOS26vIT0taSkoKXmIsYssga45XPwI\n7YBVCc/34kHzW9xrNjyyThMWOgDsuBqZN9xvapGSQ82Lsh7ObN0dZVUCAwEAAaMQ\nMA4wDAYDVR0TBAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAQEAu3aHxJnCZnICpHbQ\nv1Lc5tiXtAYE9aEP5cxb/cO14xY8dS+t0wiLIvyrE2aTcgImzr4BYNBm1XDt5suc\nMpzha1oJytGv79M9/WnI/BKmgUqTaaXOV2Ux2yPX9SadNcsD9/IbrV0b/hlsPd6M\nK8w7ndowvBgopei+A1NQY6jTDUKif4RxD4u5HZFWUu7pByNLFaydU4qBKVkucXOq\nxmWoupL5XrDk5o490kiz/Zgufqtb4w6oUr3lrQASAbFB3lID/P1ipi0DwX7kZwVX\nECDLYvr+eX6GbTClzn0JGuzqV4OoRo1rrRv+0tp1aLZKpCYn0Lhf6s1iw/kCeM2O\nnP9l2Q==\n-----END CERTIFICATE-----\n",
        "certType": "agency",
        "publicKey": "",
        "address": "",
        "father": "",
        "validityFrom": 1562860800000,
        "validityTo": 1878220800000,
        "createTime": 1569686400000
    }
}
```


### 14.3 导入证书接口

导入保存证书文件

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/cert**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 14.3.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | content     | String        | 是     | 证书文件的内容，需保留开头与结尾以及证书原有的回车\n的格式文本；证书中包含多个证书亦可 


***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/cert
```

```
{
    "content": "-----BEGIN CERTIFICATE-----\nMIICOzCCASOgAwIBAgIJANJZtoFLZsGcMA0GCSqGSIb3DQEBCwUAMDgxEDAOBgNVBAMMB2FnZW5jeUExEzARBgNVBAoMCmZpc2NvLWJjb3MxDzANBgNVBAsMBmFnZW5jeTAeFw0xOTA5MDUwNzQ3NDdaFw0yOTA5MDIwNzQ3NDdaMDQxDjAMBgNVBAMMBW5vZGUzMRMwEQYDVQQKDApmaXNjby1iY29zMQ0wCwYDVQQLDARub2RlMFYwEAYHKoZIzj0CAQYFK4EEAAoDQgAE9CwTicQwi5Gx1gckJ0ibZbcIoL13IHyLK7z4xuzkAi+PbgI9M3vKDuMzZ73IFKCYOwzfhvqM8ksFonpBZqT0NqMaMBgwCQYDVR0TBAIwADALBgNVHQ8EBAMCBeAwDQYJKoZIhvcNAQELBQADggEBAIv+PE8bQlxxVDxfUlevf3jJeaK97U5tmP8Tx1pesblzcMWTC8OxfUtYP0zy4CQL0zo6OjmSn4FYvTyDUSVqj5BXXDXiZQwtWxnPgLD75tqSTlFcR2jB+amhmzWQ7mXgfepvL+RV+1OL8WXJy7Xl01fL0nCwHaWCCwaBg+KnUgbc9YXhhyH8X8aqDDpjz9oYpZcbLITGI0V8lvr1EU3NII6LudgGp/xNolQDBOYZX1E0XtUwMUp6Az2xbmSH/7S3sXJCwgHZrtoiKkcFLbss1TDk/UdUya4n/dz4BcH3OzR2MvMHenA8kh4yaofJNsJeXFqPHAbI5+yUVK2+VK2hI0o=\n-----END CERTIFICATE-----\n-----BEGIN CERTIFICATE-----\nMIIDPTCCAiWgAwIBAgIJAKUGxOHHqV05MA0GCSqGSIb3DQEBCwUAMDUxDjAMBgNVBAMMBWNoYWluMRMwEQYDVQQKDApmaXNjby1iY29zMQ4wDAYDVQQLDAVjaGFpbjAeFw0xOTA5MDUwNzI2MTJaFw0yOTA5MDIwNzI2MTJaMDUxDjAMBgNVBAMMBWNoYWluMRMwEQYDVQQKDApmaXNjby1iY29zMQ4wDAYDVQQLDAVjaGFpbjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAM9LlTwIAKp36uB8sjoai2O3R+3KPMN9xAt8/k5+B943CUPF/RDxZ8/7Q2v6Z+t+1v3Dc81aszMr/8YyyCQWh0I3EdWyInsocZ2pBkjymetyE5VOSd+p7I8qc9PpHJKZjy2M9J5bePVjHJxleHP2u6I4QctjZoE8PJnZYT5Q0On0MJATpY856vHbF3Amvxj9dmeLKjF62T/KtyDKlyPTETXOFGMiLerWusXZxFgj0K0xhuXaNkbJI6AdhQnywgn755ugfBDzi24rfsk/BkUf5DVitfWePh4C7zaCZIeTTr8whV3twE2BTv4LENdidxCVUHN1JBvZNGyHaH4gIbwtsZcCAwEAAaNQME4wHQYDVR0OBBYEFNTCWbm1EzCYIXyoF7j3l6IXX3BoMB8GA1UdIwQYMBaAFNTCWbm1EzCYIXyoF7j3l6IXX3BoMAwGA1UdEwQFMAMBAf8wDQYJKoZIhvcNAQELBQADggEBAIjYTyxP5ikaGYdwYzQZdF4aqx+7UL3Wo/6LNJa8w2m+pAvC3ILIBcvpDe6lH3cMOz2HwCzFkKlT8Ji1HwsKPywx/9fmO60RvEoPIBanziqONLb8HDUT0QHz3jgCTj46URM6hXIEhFwg4KekpzvqaLPRHHtoCrcebUAmySOlNvlwkSnxJnufp0zFpdNu+kSl1/r21ZRMeu/hNaUb1gOzP06NOB7NodOQ5MR7ItVXyN9rl3fABP3rUFIJ+Z11WmSldaCRCQMlEOkdD8LGFYVj4Q5fx06hcJlPd2arnxALWrZUl2cs+K+MW9qQUUKAQ+7FirdRRk6ZfZtlpHMdlTfAVWA=\n-----END CERTIFICATE-----\n"
}
```


#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    
| 3    |  data    | String        | 否     | 成功保存证书的个数或错误信息                          



***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": 2
}
```

* 失败：

```
{
    "code": 202060,
    "message": "cert handle error",
    "data": "Could not parse certificate: java.io.IOException: Empty input"
}
```



### 14.4 删除证书接口

根据证书指纹删除一个证书

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/cert**
* 请求方式：DELETE
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | fingerPrint     | String        | 是     | 证书指纹，证书的唯一标识


***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/cert
```

```
{
    "fingerPrint": "F588C511F5471860120F7BE8127DE026ADD8378C"
}
```


#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    
| 3    |  data    | String        | 否     | 成功删除证书的个数或错误信息                          



***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": 1
}
```



### 14.5. 获取明文SDK证书与私钥

获取Front使用的sdk证书（包含链证书、sdk证书和sdk私钥）的内容

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/cert/sdk//{frontId}**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
| 1     | frontId       | Int           | 是     | 前置编号                  |

**2）数据格式**

```
http://localhost:5001/WeBASE-Node-Manager/cert/sdk/1
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


### 14.6. 获取SDK证书与私钥压缩包

获取Front使用的sdk证书（包含链证书、sdk证书和sdk私钥）的zip压缩包

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/cert/sdk/zip/{frontId}**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

**1）参数表**

| **序号** | **中文**       | **参数名**      | **类型** | **最大长度** | **必填** | **说明**                                       |
| -------- | -------------- | --------------- | -------- | ------------ | -------- | ---------------------------------------------- |
| 1     | frontId       | Int           | 是     | 前置编号                  |

**2）数据格式**

```
http://localhost:5001/WeBASE-Node-Manager/cert/sdk/zip/1
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



## 15 订阅事件管理

### 15.1 获取已订阅的出块事件列表

获取所有前置中已订阅的节点出块事件列表

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/event/newBlockEvent/list/{groupId}**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                           |
|------|-------------|--------------|--------|-------------------------------|
| 1    | groupId     | Integer      | 是     | 群组编号                       |
| 2    | pageNumber  | Integer      | 是     | 页码，从1开始                       |
| 3    | pageSize    | Integer      | 是     | 页容量                       |

​         

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/event/newBlockEvent/list/{groupId}/{pageNumber}/{pageSize}
```


#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Integer       | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    
| 3    | data        | List        | 否       | newBlockEvent info                         
| 3.1  | frontInfo   | String        | 否       | 前置对应IP                         
| 3.1  | id          | String        | 否       | 订阅信息的id     
| 3.1  | eventType   | Integer        | 否       | 事件通知类型，1: newBlockEvent, 2: contractEvent, 3: others                          
| 3.1  | appId       | String        | 否       |  事件通知对应的应用Id 
| 3.1  | groupId   | Integer        | 否       |    群组编号                       
| 3.1  | exchangeName  | String        | 否       |   exchange名    
| 3.1  | queueName   | String        | 否       |     队列名                 
| 3.1  | routingKey   | String        | 否       |   路由键值
| 3.1  | createTime   | String        | 否       |       订阅信息创建时间                 
| 4    | totalCount  | Integer       | 否     | 1: 国密，0：非国密                           


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "frontInfo": "127.0.0.1",
            "id": "8aba82b570f22a750170f22bcab90000",
            "eventType": 1,
            "appId": "app2",
            "groupId": 1,
            "exchangeName": "group001",
            "queueName": "user1",
            "routingKey": "app2_block_b63",
            "createTime": "2020-03-19 17:42:01"
        }
    ],
    "totalCount": 1
}
```

### 15.2 获取已订阅的合约Event事件列表

获取所有前置中已订阅的合约Event事件列表

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/event/contractEvent/list/{groupId}**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                           |
|------|-------------|--------------|--------|-------------------------------|
| 1    | groupId     | Integer      | 是     | 群组编号                       |
| 2    | pageNumber  | Integer      | 是     | 页码，从1开始                       |
| 3    | pageSize    | Integer      | 是     | 页容量                       |

​         

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/event/contractEvent/list/{groupId}/{pageNumber}/{pageSize}
```


#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Integer       | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    
| 3    | data        | List        | 否       | newBlockEvent info                         
| 3.1  | frontInfo   | String        | 否       | 前置对应IP                         
| 3.1  | id          | String        | 否       | 订阅信息的id     
| 3.1  | eventType   | Integer        | 否       | 事件通知类型，1: newBlockEvent, 2: contractEvent, 3: others                          
| 3.1  | appId       | String        | 否       |  事件通知对应的应用Id 
| 3.1  | groupId   | Integer        | 否       |    群组编号                       
| 3.1  | exchangeName  | String        | 否       |   exchange名    
| 3.1  | queueName   | String        | 否       |     队列名                 
| 3.1  | routingKey   | String        | 否       |   路由键值
| 3.1  | createTime   | String        | 否       |     起始区块范围                 
| 3.1  | fromBlock   | String        | 否       |      末区块范围                 
| 3.1  | toBlock   | String        | 否       |       订阅信息创建时间                 
| 3.1  | contractAddress  | String        | 否       |       订阅的合约地址                 
| 3.1  | contractAbi   | String        | 否       |     对应合约ABI                 
| 3.1  | topicList   | String        | 否       |       订阅的合约Event                 
| 4    | totalCount  | Integer       | 否     | 1: 国密，0：非国密                           


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "frontInfo": "127.0.0.1",
            "id": "8aba82b5708095af01708095e4f70001",
            "eventType": 2,
            "appId": "app1",
            "groupId": 1,
            "exchangeName": "group001",
            "queueName": "user1",
            "routingKey": "user1_event_app1",
            "fromBlock": "latest",
            "toBlock": "latest",
            "contractAddress": "0x657201d59ec41d1dc278a67916f751f86ca672f7",
            "contractAbi": "[{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"name\":\"name\",\"type\":\"string\"}],\"name\":\"SetName\",\"type\":\"event\"}]",
            "topicList": "SetName(string)",
            "createTime": "2020-02-26 16:21:12"
        }
    ],
    "totalCount": 1
}
```



### 15.3. 获取历史区块EventLog

#### 接口描述

同步获取历史区块中的EventLog

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/event/eventLogs/list**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

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
http://localhost:5001/WeBASE-Node-Manager/event/eventLogs/list
```


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


### 15.4. 获取ABI与合约所有合约信息

#### 接口描述

获取导入的ABI与IDE中已部署合约所有合约的地址、合约名字信息

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/event/listAddress/{groupId}**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**   | **类型**       | **最大长度** | **必填** | **说明**                           |
| -------- | -------- | ------------ | -------------- | ------------ | -------- | -------------- |
| 1        | 所属群组 | groupId | Integer         |              | 是        |                      |

**2）数据格式**

```
http://127.0.0.1:5001/WeBASE-Node-Manager/event/listAddress/{groupId}
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


### 15.5. 根据地址获取ABI与合约的合约信息

#### 接口描述

根据合约地址、合约类型（`abi`或`contract`）获取导入的ABI与IDE中已部署合约的合约地址、合约名字信息

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/event/contractInfo/{groupId}/{type}/{contractAddress}**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**   | **类型**       | **最大长度** | **必填** | **说明**                           |
| -------- | -------- | ------------ | -------------- | ------------ | -------- | -------------- |
| 1        | 所属群组 | groupId | Integer         |              | 是        |                      |
| 2        | 合约类型 | type | String         |              | 是        |    包含`contract`（IDE部署）和`abi`（ABI管理导入）两种类型                  |
| 3        | 合约地址 | contractAddress | String         |              | 是        |                      |

**2）数据格式**

```
http://127.0.0.1:5001/WeBASE-Node-Manager/event/contractInfo/{groupId}/{type}/{contractAddress}
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


## 16 可视化部署

### 16.1 获取 Docker 镜像版本

查询部署时可以选择的 Docker 镜像版本

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/config/list**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                           |
|------|-------------|--------------|--------|-------------------------------|
| 1    | type     | Integer      | 是     | 获取配置类型，1: Docker 镜像列表   |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/config/list?type=1
```


#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Integer       | 否     | 返回码，0：成功；其它：失败|
| 2    | message     | String        | 否     | 描述    
| 3    | data        | List        | 否       | 镜像列表 ｜                       
| 3.1  | id   | Integer        | 否       | 镜像编号|                
| 3.1  | configName          | String        | 否       | 配置名称|    
| 3.1  | configType   | Integer        | 否       | 配置类型，1: Docker 镜像列表     |
| 3.1  | configValue       | String        | 否       |  镜像版本 |
| 3.1  | createTime   | Long        | 否       |    创建时间 |         
| 3.1  | modifyTime  | Long        | 否       |  修改时间 | 


***2）出参示例***
* 成功：

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "id": 1,
      "configName": "docker 镜像版本",
      "configType": 1,
      "configValue": "v2.5.0",
      "createTime": 1590577419000,
      "modifyTime": 1590577419000
    }
  ]
}
```


### 16.2 初始化主机

根据填写的节点主机信息，在节点主机上安装主机依赖，并拉取或检测选择的镜像是否存在。

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/deploy/init**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                           |
|------|-------------|--------------|--------|-------------------------------|
| 1    | chainName     | String      | 是   | 链名称，默认为default_chain        |
| 2    | imageTag  | String      | 是     | 镜像编号， 返回参数中的 id 值            |
| 3    | dockerImageType    | Integer      | 是     |     Docker 镜像拉取方式，0: 手动获取；1: 自动从 Docker Hub 拉取，2-从CDN拉取；默认为2 |
| 4    | hostIdList  | List<Integer>      | 是     |  需要初始化的主机Id数组         |

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/deploy/init
```

```
{
  "imageTag": "v2.7.1"
  "chainName": "default_chain",
  "dockerImageType": "0",
  "hostIdList": [1,2,3]
}
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Integer       | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    
| 3    | data        | String        | 否       | 部署请求结果                        |
| 4    | attachment | List        | 否       | 补充信息，比如：如果连接主机失败，表示连接失败的主机 IP       |     


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": ""
}
```
* 失败：
```
{
    "code": 205015,
    "message": "Connect to host error",
    "data": "",
    "attachment": "172.0.0.2"
}
```



### 16.4 检查主机初始化情况

调用了主机初始化接口后，若前端页面显示请求超时时，后台初始化操作仍在进行，可以通过此接口检查主机是否初始化完成

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/deploy/initCheck**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                           |
|------|-------------|--------------|--------|-------------------------------|
| 1    | chainName     | String      | 是   | 链名称，默认为default_chain        |
| 2    | imageTag  | String      | 是     | 镜像编号， 返回参数中的 id 值            |
| 3    | dockerImageType    | Integer      | 是     |     Docker 镜像拉取方式，0: 手动获取；1: 自动从 Docker Hub 拉取，2-从CDN拉取；默认为2 |
| 4    | hostIdList  | List<Integer>      | 是     |  需要初始化的主机Id数组         |

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/deploy/initCheck
```

```
{
  "imageTag": "v2.7.1"
  "chainName": "default_chain",
  "dockerImageType": "0",
  "hostIdList": [1,2,3]
}
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Integer       | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    
| 3    | data        | String        | 否       | 开关状态，0: 不进入可视化部署；1: 进入可视化部署。  |
| 3.1  | id   | Integer        | 否       | 主机编号|                
| 3.2  | ip       | String        | 否       |  主机 IP |
| 3.3  | rootDir       | String        | 否       | 主机存放节点数据的目录，默认：/opt/fisco |
| 3.4  | status       | Integer        | 否       |  主机状态，0: 添加中，1: 初始化中，2: 初始化成功，3: 初始化失败，4：检测成功，5：检测失败，6：配置链成功，7：配置链失败 |
| 3.5  | remark       | Integer        | 否       |  部署失败时，主机的错误日志 |
| 3.6  | createTime   | Long        | 否       |    创建时间 |         
| 3.7  | modifyTime  | Long        | 否       |  修改时间 | 



***2）出参示例***
* 成功：
```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "id": 19,
      "ip": "172.0.0.2",
      "rootDir": "/root/fisco",
      "status": 2,
      "remark": "",
      "createTime": 1596959644000,
      "modifyTime": 1596959661000
    },
    .......
  ],
  "attachment": null
}
```


### 16.5 检查主机端口占用

传入主机的节点信息，检查目标主机中需要用到的端口是否已被占用；端口被占用时，报错信息保存在主机列表的remark字段里

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/deploy/checkPort**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                           |
|------|-------------|--------------|--------|-------------------------------|
| 1    | deployNodeInfoList     | List<DeployNodeInfo>      | 是   | 节点部署信息数组        |
|     | DeployNodeInfo     | Object      | 是   | 节点的主机编号与端口信息        |
|  1.1   | hostId     | int      | 是   | 主机编号       |
|  1.2   | ip     | String      | 是   | 主机IP       |
|  1.3   | frontPort     | int      | 是   | 前置端口       |
|  1.4   | channelPort     | int      | 是   | 节点的channel端口       |
|  1.5   | p2pPort     | int      | 是   | 节点的P2P端口       |
|  1.6   | rpcPort     | int      | 是   | 节点的RPC端口       |
| 2    | ipconf    | String[]      | 是     |   默认传入空的String数组即可 |

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/deploy/checkPort
```

```
{
  "deployNodeInfoList": [{
		"hostId": 20,
		"ip": "127.0.0.1",
		"frontPort": 5002,
		"p2pPort": 30300,
		"channelPort": 20200,
		"rpcPort": 8545
	}],
  "ipconf": []
}
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Integer       | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    



***2）出参示例***
* 成功：
```
{
  "code": 0,
  "message": "success"
}
```


### 16.6 配置并部署链

传入主机的节点信息，检查目标主机中需要用到的端口是否已被占用；端口被占用时，报错信息保存在主机列表的remark字段里

**注意**：使用接口搭链后，需要妥善保存项目目录（如`/dist`）中的`NODES_ROOT`目录，其中保存了链的相关证书与证书私钥。

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/deploy/config**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                           |
|------|-------------|--------------|--------|-------------------------------|
| 1    | deployNodeInfoList     | List<DeployNodeInfo>      | 是   | 节点部署信息数组        |
|     | DeployNodeInfo     | Object      | 是   | 节点的主机编号与端口信息        |
|  1.1   | hostId     | int      | 是   | 主机编号       |
|  1.2   | ip     | String      | 是   | 主机IP       |
|  1.3   | frontPort     | int      | 是   | 前置端口       |
|  1.4   | channelPort     | int      | 是   | 节点的channel端口       |
|  1.5   | p2pPort     | int      | 是   | 节点的P2P端口       |
|  1.6   | rpcPort     | int      | 是   | 节点的RPC端口       |
| 2    | ipconf    | String[]      | 是     |  单个String中包含：主机IP，节点数量，机构名称，所属群组，端口等 |


**注：ipconf 格式参考**

```
# 1. 可以添加多行；
# 2. 页面需要提示，机构名只能包含英文字母，数字和下划线'_'；
# 3. 群组编号必须是数字；v1.4.3后只支持群组1，如需多个群组请通过动态群组后续增加
# 4. 数量至少为 1，客户端的输入框默认为 1；
# 5. 同一个 IP 的主机，只属于一个机构；如果在单机部署，只能填写一个机构名；v1.4.3后**只支持默认的agency1**
# 
# 格式：IP:数量 机构名 群组列表
    
# 比如：
172.0.0.1:2 agency1 1
172.0.0.2:2 agency1 1
172.0.0.3:2 agency1 1

# 上面配置的意思：
1. 部署三台主机：172.0.0.1，172.0.0.2，172.0.0.3。
2. 172.0.0.x 的每台机器上创建 2 个节点，一共创建 6 个节点。
3. 创建单个机构：agency1。
4. 创建单个群组：1。
5. 群组后续可以动态添加。
```


***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/deploy/config
```

```
{
	"chainName": "default_chain",
	"ipconf": ["127.0.0.1:1 agency1 1 30300,20200,8545"],
	"imageTag": "v2.7.1",
	"encryptType": 0,
	"deployNodeInfoList": [{
		"hostId": 20,
		"ip": "127.0.0.1",
		"frontPort": 5002,
		"p2pPort": 30300,
		"channelPort": 20200,
		"rpcPort": 8545
	}],
	"agencyName": "agency1"
}
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Integer       | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    
| 3    | data        | String        | 否       | 部署请求结果                        |
| 4    | attachment | List        | 否       | 补充信息，比如：如果连接主机失败，表示连接失败的主机 IP       |     

若部署失败，可结合`/host/list`接口查询`remark`了解错误详情

***2）出参示例***
* 成功：
```
{
  "code": 0,
  "message": "success"
}
```



### 16.7 新增节点

添加一个新的节点到指定群组。服务器接收新增节点请求后，完成参数校验和数据库数据插入后，返回客户端请求结果，再异步完成节点新增操作。

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/deploy/node/add**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                           |
|------|-------------|--------------|--------|-------------------------------|
| 1    | deployNodeInfoList     | List<DeployNodeInfo>      | 是   | 节点部署信息数组        |
|     | DeployNodeInfo     | Object      | 是   | 节点的主机编号与端口信息        |
|  1.1   | hostId     | int      | 是   | 主机编号       |
|  1.2   | ip     | String      | 是   | 主机IP       |
|  1.3   | frontPort     | int      | 是   | 前置端口       |
|  1.4   | channelPort     | int      | 是   | 节点的channel端口       |
|  1.5   | p2pPort     | int      | 是   | 节点的P2P端口       |
|  1.6   | rpcPort     | int      | 是   | 节点的RPC端口       |
| 2   | chainName     | String     | 是   | 已有的链名称        |
| 2   | groupId     | int      | 是   | 群组id，默认为1        |
| 2   | agencyName     | String     | 是   | 1.4.3后默认均为agency1        |
| 2   | encryptType     | int  | 是   | 加密类型，与已有链一致        |



***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/deploy/node/add
```

```
{
	"chainName": "default_chain",
	"deployNodeInfoList": [{
		"hostId": 20,
		"ip": "127.0.0.1",
		"frontPort": 5002,
		"p2pPort": 30300,
		"channelPort": 20200,
		"rpcPort": 8545
	}],
	"groupId": 1,
	"agencyName": "agency1",
	"encryptType": 0
}
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Integer       | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    
| 3    | data        | String        | 否       | 部署请求结果                        |
| 4    | attachment | List        | 否       | 补充信息，比如：如果连接主机失败，表示连接失败的主机 IP       |     

若部署失败，可结合`/host/list`接口查询`remark`了解错误详情

***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": ""
}
```
* 失败：
```
{
    "code": 205015,
    "message": "Connect to host error",
    "data": "",
    "attachment": "172.0.0.2"
}
```


### 16.8 启动节点

启动指定节点。

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/deploy/node/start**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                           |
|------|-------------|--------------|--------|-------------------------------|
| 1    | nodeId     | String      | 是   | 启动节点的节点编号        |


***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/deploy/node/start
```

```
{
  "nodeId": "6aba77a7b81ddf71f5e5988c2ba96f51484b55d637286bf49babe48a34f935ee3866fc1a226b465b6bc9d716bfe8b349d82e80710b162e826c0cf91fb58e5099"
}
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Integer       | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    
| 3    | data        | String        | 否       | 启动命令执行结果                        |



***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": ""
}
```

### 16.9 停止节点

停止指定节点。

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/deploy/node/stop**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                           |
|------|-------------|--------------|--------|-------------------------------|
| 1    | nodeId     | String      | 是   | 停止节点的节点编号        |


***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/deploy/node/stop
```

```
{
  "nodeId": "6aba77a7b81ddf71f5e5988c2ba96f51484b55d637286bf49babe48a34f935ee3866fc1a226b465b6bc9d716bfe8b349d82e80710b162e826c0cf91fb58e5099"
}
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Integer       | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    
| 3    | data        | String        | 否       | 停止命令执行结果                        |



***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": ""
}
```


### 16.10 强制停止节点

强制停止指定节点，`/deploy/node/stop`接口需要节点为游离才可以停止，强制停止节点可以结合节点启动接口，用于正常的节点重启

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/deploy/node/stopForce**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                           |
|------|-------------|--------------|--------|-------------------------------|
| 1    | nodeId     | String      | 是   | 停止节点的节点编号        |


***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/deploy/node/stop
```

```
{
  "nodeId": "6aba77a7b81ddf71f5e5988c2ba96f51484b55d637286bf49babe48a34f935ee3866fc1a226b465b6bc9d716bfe8b349d82e80710b162e826c0cf91fb58e5099"
}
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Integer       | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    
| 3    | data        | String        | 否       | 停止命令执行结果                        |



***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": ""
}
```


### 16.11 删除节点

删除指定节点。

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/deploy/node/delete**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                           |
|------|-------------|--------------|--------|-------------------------------|
| 1    | nodeId     | String      | 是   | 停止节点的节点编号        |
| 2    | deleteHost     | Boolean      | 否  | 删除节点时，如果被删除节点是主机上最后一个节点，是否删除主机，true: 删除；false: 不删除；默认：false。    |
| 3    | deleteAgency     | Boolean      | 否   | 如果需要删除主机，在被删除主机机构最后一台主机，是否删除相应机构，true: 删除；false: 不删除； 默认：false。        |


***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/deploy/node/stop
```

```
{
  "nodeId": "6aba77a7b81ddf71f5e5988c2ba96f51484b55d637286bf49babe48a34f935ee3866fc1a226b465b6bc9d716bfe8b349d82e80710b162e826c0cf91fb58e5099",
  "deleteHost": "true",
  "deleteAgency": "false" 
}
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Integer       | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    
| 3    | data        | String        | 否       | 节点删除结果                      |



***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": ""
}
```

* 失败：
```
{
    "code": 205053,
    "message": "Node is running.",
    "data": ""
}
```


### 16.12 获取链信息

查询区块链信息，如果没有部署链，返回空；如果已经部署链，返回部署的链信息。

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/deploy/chain/info**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                           |
|------|-------------|--------------|--------|-------------------------------|
|     |      |       |   |     |



***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/deploy/chain/info
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Integer       | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    
| 3    | data        | String        | 否       | 链信息查询结果    |
| 3.1  | id   | Integer        | 否       | 链编号|                
| 3.1  |chainName          | String        | 否       | 链名称|    
| 3.1  | chainDesc   | String        | 否       | 链描述    |
| 3.1  | version       | String        | 否       |  底层的镜像版本 |
| 3.1  | encryptType       | Integer        | 否       |  加密方式，0: 非国密；1: 国密 |
| 3.1  | chainStatus       | Integer        | 否       |  链状态，具体状态查看备注信息 |
| 3.1  | rootDir       | String        | 否       | 节点主机存放节点数据的目录，默认：/opt/fisco |
| 3.1  | webaseSignAddr       | String        | 否       |  WeBASE-Sign 服务的地址 |
| 3.1  | runType       | Integer        | 否       |  运行方式，1: 使用 Docker 运行 |
| 3.1  | createTime   | Long        | 否       |    创建时间 |         
| 3.1  | modifyTime  | Long        | 否       |  修改时间 | 

**注：链状态**

| 链状态编号 | 链状态  |
|---|---|
|  0 | 初始化中  |
|  1 |  部署中 |
|  2 |  部署失败 |
|  3 |  运行 |
|  4 |  重启中 |

***2）出参示例***
* 没有部署链：
```
{
    "code": 0,
    "message": "success",
    "data": ""
}
```

* 已经部署链：
```
{
  "code": 0,
  "message": "success",
  "data": {
    "id": 10,
    "chainName": "default_chain",
    "chainDesc": "default_chain",
    "version": "v2.5.0",
    "encryptType": 0,
    "chainStatus": 3,
    "rootDir": "/opt/fisco",
    "webaseSignAddr": "172.0.0.1:5004",
    "runType": 1,
    "createTime": 1596959644000,
    "modifyTime": 1596959700000
  },
  "attachment": null
}
```


### 16.13 删除链

重置已部署链，删除节点管理服务的数据库数据，并同时备份当前链数据到临时文件夹。

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/deploy/delete**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                           |
|------|-------------|--------------|--------|-------------------------------|
|     |      |       |   |     |



***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/deploy/delete
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Integer       | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    
| 3    | data        | String        | 否       | 重置链结果                      |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": ""
}
```


### 16.14 查询服务器可视化部署选项配置

查询服务器的可视化部署的选项状态，判断是否进入可视化部署页面。

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/deploy/type**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                           |
|------|-------------|--------------|--------|-------------------------------|
|     |      |       |   |     |



***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/deploy/type
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Integer       | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    
| 3    | data        | String        | 否       | 开关状态，0: 不进入可视化部署；1: 进入可视化部署。                  |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": "1"
}
```


### 16.15 查询主机执行进度

查询主机在可视化的检测、初始化、部署过程中的各个进度

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/deploy/progress**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                           |
|------|-------------|--------------|--------|-------------------------------|
|     |      |       |   |     |



***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/deploy/progress
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Integer       | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    
| 3    | data        | String        | 否       | 进度状态，具体值与对应状态如下                  |

部署的总步骤流程，添加节点时，流程相同
* 0-等待开始；1-检测机器内存与依赖，2-检测Docker服务，3-检测端口占用，4-初始化安装主机依赖，5-初始化加载Docker镜像中
* 6-生成链证书与配置，7-初始化链与前置数据，8-传输链配置到主机
* 9-配置完成，启动中


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": "5" // 正在初始化主机，拉取docker镜像中
}
```


**主机管理接口**

### 16.16 获取主机列表

获取主机列表

*如果部署出现失败，调用此接口，在`remark`字段中返回每台主机部署的错误信息*

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/host/list**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                           |
|------|-------------|--------------|--------|-------------------------------|
|     |      |       |   |     |



***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/host/list
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Integer       | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    
| 3    | data        | String        | 否       | 开关状态，0: 不进入可视化部署；1: 进入可视化部署。  |
| 3.1  | id   | Integer        | 否       | 主机编号|                
| 3.2  | ip       | String        | 否       |  主机 IP |
| 3.3  | rootDir       | String        | 否       | 主机存放节点数据的目录，默认：/opt/fisco |
| 3.4  | status       | Integer        | 否       |  主机状态，0: 添加中，1: 初始化中，2: 初始化成功，3: 初始化失败，4：检测成功，5：检测失败，6：配置链成功，7：配置链失败 |
| 3.5  | remark       | Integer        | 否       |  部署失败时，主机的错误日志 |
| 3.6  | createTime   | Long        | 否       |    创建时间 |         
| 3.7  | modifyTime  | Long        | 否       |  修改时间 | 



***2）出参示例***
* 成功：
```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "id": 19,
      "ip": "172.0.0.2",
      "rootDir": "/root/fisco",
      "status": 2,
      "remark": "",
      "createTime": 1596959644000,
      "modifyTime": 1596959661000
    },
    .......
  ],
  "attachment": null
}
```


### 16.17 添加主机接口

添加主机

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/host/add**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                           |
|------|-------------|--------------|--------|-------------------------------|
|   1  |  sshIp    |  String     | 是     |  主机的IP，或与节点管理服务同机的127.0.0.1    |
|   2  |  rootDir    |  String     | 是     |  主机用于部署节点的路径，若不存在，将自动通过ansible创建   |

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/host/add
```


```
{
	"sshIp": "127.0.0.1",
	"rootDir": "/data/home/webase/opt"
}
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Integer       | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    



***2）出参示例***
* 成功：
```
{
  "code": 0,
  "message": "success"
}
```


### 16.18 删除主机接口

删除主机，将判断主机上是否仍存在节点，若有则无法删除

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/host/{hostId}**
* 请求方式：DELETE
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                           |
|------|-------------|--------------|--------|-------------------------------|
|   1  |  hostId    |  Integer     | 是     |  主机编号    |



***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/host/{hostId}
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Integer       | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    



***2）出参示例***
* 成功：
```
{
  "code": 0,
  "message": "success"
}
```


### 16.19 Ping主机接口

通过Ansible对主机IP执行`ansible {ip} -m ping`命令，检测宿主机到节点主机的SSH免密连接是否连通

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/host/ping**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                           |
|------|-------------|--------------|--------|-------------------------------|
|   1  |  sshIp    |  String     | 是     |  主机的IP，或与节点管理服务同机的127.0.0.1    |
|   2  |  rootDir    |  String     | 是     |  主机用于部署节点的路径，若不存在，将自动通过ansible创建   |

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/host/ping
```


```
{
	"sshIp": "127.0.0.1",
	"rootDir": "/data/home/webase/opt"
}
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Integer       | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    



***2）出参示例***
* 成功：
```
{
  "code": 0,
  "message": "success"
}
```


### 16.20 检测是否安装Ansible接口

检测节点管理服务（宿主机）是否已安装Ansible，**节点主机**无需安装Ansible

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/host/ansible**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                           |
|------|-------------|--------------|--------|-------------------------------|

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/host/ansible
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Integer       | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    



***2）出参示例***
* 成功：
```
{
  "code": 0,
  "message": "success"
}
```


### 16.21 检测主机依赖接口

根据单个主机需要安装的节点数，检测已添加主机是否有足够的空闲内存，检测主机是否已安装Docker并启动Docker

通过并行方式同时检测多个主机，并在主机的`remark`字段中记录检测不通过的原因，若检测不通过，可结合`/host/list`接口查询`remark`了解错误详情

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/host/check**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                           |
|------|-------------|--------------|--------|-------------------------------|
|   1  |  hostIdList    |  List<Integer>     | 是     |  主机编号数组，多个节点时主机id重复多次即可  |

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/host/check
```


下面代表主机编号为1的主机上安装两个节点，主机编号2的主机安装一个节点
```
{
	"hostIdList": [1,1,2]
}
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Integer       | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    

若检测不通过，可结合`/host/list`接口查询`remark`了解错误详情

***2）出参示例***
* 成功：
```
{
  "code": 0,
  "message": "success"
}
```

* 失败：
```
{
	"code": 202493,
	"message": "Check host not pass, please check host remark",
	"data": null,
	"attachment": null
}
```

## 17 应用管理模块

### 17.1 保存应用信息


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址： **/app/save**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型   | 必填 | 备注                               |
| ---- | ---------- | ------ | ------ | ---------------------------------- |
| 1    | appName    | string | 是     | 应用名称                           |
| 2    | appDocLink | string | 是     | 应用文档链接                       |
| 3    | appDesc    | string | 是     | 应用描述                           |
| 4    | appIcon    | string | 否     | 应用图标                           |
| 5    | appDetail  | string | 否     | 应用详细介绍                       |
| 6    | id         | int    | 否     | 应用编号，传入时表示更新，否则新增 |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/app/save
```

```
{
  "appName":"WeID",
  "appDocLink":"https://weidentity.readthedocs.io/zh_CN/latest/docs/deploy-via-web.html",
  "appIcon":"test",
  "appDesc":"WeIdentity是一套分布式多中心的技术解决方案，可承载实体对象（人或者物）的现实身份与链上身份的可信映射、以及实现实体对象之间安全的访问授权与数据交换。WeIdentity由微众银行自主研发并完全开源，秉承公众联盟链整合资源、交换价值、服务公众的理念，致力于成为链接多个垂直行业领域的分布式商业基础设施，促进泛行业、跨机构、跨地域间的身份认证和数据合作。",
  "appDetail":""
}
```


#### 返回参数

***1）出参表***

| 序号 | 输出参数   | 类型          |      | 备注                       |
| ---- | ---------- | ------------- | ---- | -------------------------- |
| 1    | code       | Int           | 否   | 返回码，0：成功 其它：失败 |
| 2    | message    | String        | 否   | 描述                       |
| 3    | data       | Object        |      | 信息对象                   |
| 3.1  | id         | int           | 否   | 自增编号                   |
| 3.2  | appName    | string        | 否   | 应用名称                   |
| 3.3  | appKey     | string        | 否   | 应用Key                    |
| 3.4  | appSecret  | string        | 否   | 应用密码                   |
| 3.5  | appDocLink | string        | 否   | 应用文档链接               |
| 3.6  | appIcon    | string        | 否   | 应用图标                   |
| 3.7  | appDesc    | string        | 否   | 应用描述                   |
| 3.8  | appDetail  | string        | 是   | 应用详细介绍               |
| 3.9  | appIp      | string        | 是   | 应用ip                     |
| 3.10 | frontPort  | int           | 是   | 应用端口                   |
| 3.11 | appLink    | string        | 是   | 应用服务链接               |
| 3.12 | appStatus  | int           | 否   | 应用状态(1存活，2不存活)   |
| 3.13 | createTime | LocalDateTime | 否   | 落库时间                   |
| 3.14 | modifyTime | LocalDateTime | 否   | 修改时间                   |

***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "id": 1,
        "appName": "WeID",
        "appKey": "z2dJaYXe",
        "appSecret": "5bTi2zMgdxAbFwgmkZhxNrUXFFvdjmM8",
        "appStatus": 2,
        "appDocLink": "https://weidentity.readthedocs.io/zh_CN/latest/docs/deploy-via-web.html",
        "appLink": null,
        "appIp": null,
        "appPort": null,
        "appIcon": "test",
        "appDesc": "WeIdentity是一套分布式多中心的技术解决方案，可承载实体对象（人或者物）的现实身份与链上身份的可信映射、以及实现实体对象之间安全的访问授权与数据交换。WeIdentity由微众银行自主研发并完全开源，秉承公众联盟链整合资源、交换价值、服务公众的理念，致力于成为链接多个垂直行业领域的分布式商业基础设施，促进泛行业、跨机构、跨地域间的身份认证和数据合作。",
        "appDetail": "",
        "createTime": "2021-03-07 18:15:47",
        "modifyTime": "2021-03-07 18:15:47"
    },
    "attachment": null
}
```

* 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```


### 17.2 查询应用列表 

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/app/list?appName={appName}&appKey={appKey}&appType={appType}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型   | 必填 | 备注                                                         |
| ---- | -------- | ------ | ------ | ------------------------------------------------------------ |
| 1    | appName  | string | 否     | 应用名称                                                     |
| 2    | appKey   | string | 否     | 应用Key                                                      |
| 3    | appType  | Int    | 否     | 应用类型(1模板，2新建)，传入时查询对应列表，不传入则返回新建的应用列表 |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/app/list?appType=1
```


#### 返回参数 

***1）出参表***

| 序号   | 输出参数   | 类型          |      | 备注                       |
| ------ | ---------- | ------------- | ---- | -------------------------- |
| 1      | code       | Int           | 否   | 返回码，0：成功 其它：失败 |
| 2      | message    | String        | 否   | 描述                       |
| 3      | totalCount | int           | 否   | 总记录数                   |
| 4      | data       | List          | 是   | 列表                       |
| 4.1    |            | Object        |      | 信息对象                   |
| 4.1.1  | id         | int           | 否   | 自增编号                   |
| 4.1.2  | appName    | string        | 否   | 应用名称                   |
| 4.1.3  | appKey     | string        | 否   | 应用Key                    |
| 4.1.4  | appSecret  | string        | 否   | 应用密码                   |
| 4.1.5  | appDocLink | string        | 否   | 应用文档链接               |
| 4.1.6  | appIcon    | string        | 否   | 应用图标                   |
| 4.1.7  | appDesc    | string        | 否   | 应用描述                   |
| 4.1.8  | appDetail  | string        | 是   | 应用详细介绍               |
| 4.1.9  | appIp      | string        | 是   | 应用ip                     |
| 4.1.10 | frontPort  | int           | 是   | 应用端口                   |
| 4.1.11 | appLink    | string        | 是   | 应用服务链接               |
| 4.1.12 | appStatus  | int           | 否   | 应用状态(1存活，2不存活)   |
| 4.1.13 | createTime | LocalDateTime | 否   | 落库时间                   |
| 4.1.14 | modifyTime | LocalDateTime | 否   | 修改时间                   |


***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "id": 1,
            "appName": "WeID",
            "appKey": "RXiHxhWn",
            "appSecret": "FA4evmGGAAQTGnpiu6FF4uWzb2RvuiWU",
            "appStatus": 2,
            "appDocLink": "https://weidentity.readthedocs.io/zh_CN/latest/docs/deploy-via-web.html",
            "appLink": null,
            "appIp": null,
            "appPort": null,
            "appIcon": "test",
            "appDesc": "WeIdentity是一套分布式多中心的技术解决方案，可承载实体对象（人或者物）的现实身份与链上身份的可信映射、以及实现实体对象之间安全的访问授权与数据交换。WeIdentity由微众银行自主研发并完全开源，秉承公众联盟链整合资源、交换价值、服务公众的理念，致力于成为链接多个垂直行业领域的分布式商业基础设施，促进泛行业、跨机构、跨地域间的身份认证和数据合作。",
            "appDetail": "",
            "createTime": "2021-03-07 18:15:47",
            "modifyTime": "2021-03-07 18:15:47"
        }
    ],
    "totalCount": 1
}
```

* 失败：

```
{
   "code": 102000,
   "message": "system exception",
   "data": {}
}
```

### 17.3 删除应用信息

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/app/{id}**
* 请求方式：DELETE
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型 | 必填 | 备注     |
| ---- | -------- | ---- | ------ | -------- |
| 1    | id       | int  | 是     | 应用编号 |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/app/1
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data     | object | 是   | 返回信息实体（空）         |


***2）出参示例***

* 成功：

```
{
    "code": 0,
    "data": {},
    "message": "Success"
}
```

* 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

## 18 配置接口

### 18.1 查询是否使用国密

获取WeBASE-Node-Manager是否使用国密版

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/config/encrypt**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***         

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/config/encrypt
```


#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败                 |
| 2    | message     | String        | 否     | 描述    |
| 3    |  data    | Int        | 否     | 1: 国密，0：非国密                           |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": 1 
}
```


### 18.2 查询WeBASE-Node-Manager的版本

获取WeBASE-Node-Manager服务的版本号

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/config/version**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***         

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/config/version
```


#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | -        | String           | 否     | 版本号                |


***2）出参示例***
* 成功：
```
v1.4.0
```

### 18.3 获取服务ip和端口

返回本服务ip和端口。


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址： **/config/ipPort**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/config/ipPort
```


#### 返回参数

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data     | Object |      | 信息对象                   |
| 3.1  | ip       | string | 否   | 服务IP                     |
| 3.2  | port     | int    | 否   | 服务端口                   |

***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "ip": "127.0.0.1",
        "port": 5001
    },
    "attachment": null
}
```

* 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 18.4 查询已部署合约是否支持修改

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址： **/config/isDeployedModifyEnable**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***   

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/config/isDeployedModifyEnable
```


#### 返回参数

***1）出参表***

| 序号 | 输出参数 | 类型 |      | 备注                       |
| ---- | -------- | ---- | ---- | -------------------------- |
| 1    | code     | Int  | 否   | 返回码，0：成功 其它：失败 |
| 2    | message     | String        | 否     | 描述    |
| 3    |  data    | boolean | 否     | true: 支持，false：不支持                    |


***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": true 
}
```


### 18.5 获取配置列表

查询后台保存的配置列表

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/config/list**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                           |
|------|-------------|--------------|--------|-------------------------------|
| 1    | type     | Integer      | 是     | 获取配置类型。1：Docker 镜像列表  |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/config/list?type=1
```


#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code        | Integer       | 否     | 返回码，0：成功；其它：失败|
| 2    | message     | String        | 否     | 描述    
| 3    | data        | List        | 否       | 镜像列表 ｜                       
| 3.1  | id   | Integer        | 否       | 镜像编号|                
| 3.1  | configName          | String        | 否       | 配置名称|    
| 3.1  | configType   | Integer        | 否       | 配置类型，1: Docker 镜像列表     |
| 3.1  | configValue       | String        | 否       |  镜像版本 |
| 3.1  | createTime   | Long        | 否       |    创建时间 |         
| 3.1  | modifyTime  | Long        | 否       |  修改时间 | 


***2）出参示例***
* 成功：

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "id": 1,
      "configName": "docker 镜像版本",
      "configType": 1,
      "configValue": "v2.5.0",
      "createTime": 1590577419000,
      "modifyTime": 1590577419000
    }
  ]
}
```

## 19. 链上全量数据接口


### 19.1 查询链上全量私钥用户列表

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址： **/external/account/list/all/{groupId}/{pageNumber}/{pageSize}**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***   

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | string        | 是     | 群组id                                     |
| 2    | pageNumber   | int           | 是     | 页码                               |
| 3    | pageSize      | int           | 是     | 页大小                         |
| 4    | account      | int           | 否     | 所属用户（已登记私钥）                               |
| 5   | type      | int           | 是     | 1-全量，2-本地已登记，3-本地未登记，默认为1 |
| 6   | address      | string           | 否     |  搜索用户地址|

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/external/account/list/all/1/1/10
```


#### 返回参数

***1）出参表***

| 序号 | 输出参数 | 类型 |      | 备注                       |
| ---- | -------- | ---- | ---- | -------------------------- |
| 1    | code     | Int  | 否   | 返回码，0：成功 其它：失败 |
| 2    | message     | String        | 否     | 描述    |
| 3    | data        | object        | 是   | 返回信息实体（成功时不为空）       |
| 3.1  | userId      | int           | 是   | 用户编号（若仅存于链上则为null)    |
| 3.2  | userName    | string        | 是   | 用户名称                           |
| 3.3  | groupId     | int           | 否   | 所属群组编号                       |
| 3.4  | description | String        | 是   | 备注                               |
| 3.5  | userStatus  | int           | 是   | 状态（1-正常 2-停用） 默认1        |
| 3.6  | publicKey   | String        | 是   | 公钥信息                           |
| 3.7  | address     | String        | 是   | 在链上位置的hash                   |
| 3.8  | hasPk       | Int           | 否   | 是否拥有私钥信息(1-拥有，2-不拥有) |
| 3.9  | account     | string        | 是   | 关联账户                           |
| 3.10 | createTime  | LocalDateTime | 否   | 创建时间                           |
| 3.11 | modifyTime  | LocalDateTime | 否   | 修改时间                           |
| 3.12 | extAccountId  | int | 否   | 链上用户编号                         |
| 3.13 | transCount  | int   | 否   | 用户交易量                           |
| 3.14 | hashs  | String | 否   | 用户交易hash（5个）                           |
| 3.14 | signUserId  | String | 是   | 用户的sign用户编号          |

***2）出参示例***

* 成功：

```
{
	"code": 0,
	"message": "success",
	"data": [{
		"userId": null,
		"userName": null,
		"account": null,
		"groupId": 1,
		"publicKey": null,
		"privateKey": null,
		"userStatus": null,
		"chainIndex": null,
		"userType": null,
		"address": "0x11523906f9c6d4bbf2bf7ab2ff1049e7bdf2fbf6",
		"signUserId": null,
		"appId": null,
		"hasPk": null,
		"description": null,
		"createTime": "2021-04-07 16:34:42",
		"modifyTime": "2021-04-07 16:34:42",
		"extAccountId": 4,
		"transCount": 1,
		"hashs": "0x6889e8ea793d6326026b2a32bab023183ccc7846d3bcb9bd1001e1f08fb892c5"
	},{
		"userId": 700001,
		"userName": "2222",
		"account": "mars",
		"groupId": 1,
		"publicKey": "04299feb42f324521464c9503220efaeaae99093d92ef08e6f9c1f76e761c2a57422c5fe4dc721e049dfdc05ff8e9b64f59471235ad5e5f4fc07e653f2cd22314e",
		"privateKey": null,
		"userStatus": 1,
		"chainIndex": null,
		"userType": 1,
		"address": "0x6bc1eeb7d1bb3f1d8195336843bd938d51e594ee",
		"signUserId": "0c01b17d67734e95b1e8d5c55e78b4d8",
		"appId": "1",
		"hasPk": 1,
		"description": "",
		"createTime": "2021-04-06 21:14:04",
		"modifyTime": "2021-04-06 21:14:04",
		"extAccountId": 1,
		"transCount": null,
		"hashs": null
	}],
	"totalCount": 2
}
```


### 19.2 查询链上全量合约列表

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址： **/external/contract/list/all/{groupId}/{pageNumber}/{pageSize}?type={type}**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***   

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | string        | 是     | 群组id                                     |
| 2    | pageNumber   | int           | 是     | 页码                               |
| 3    | pageSize      | int           | 是     | 页大小                         |
| 4    | account      | int           | 否     | 所属用户（已登记私钥）                               |
| 5   | type      | int           | 是     | 1-全量，2-本地已登记，3-本地未登记，默认为1 |
| 6   | contractAddress      | string           | 否     |  搜索合约地址|

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/external/contract/list/all/1/1/10?type=1
```


#### 返回参数

***1）出参表***


| 序号 | 输出参数        | 类型          |      | 备注                              |
| ---- | --------------- | ------------- | ---- | --------------------------------- |
| 1    | code            | Int           | 否   | 返回码，0：成功 其它：失败        |
| 2    | message         | String        | 否   | 描述                              |
| 3    |                 | Object        |      | 返回信息实体                      |
| 3.1  | abiId           | int           | 是   | 合约编号（若未登记，则为空）                          |
| 3.2  | contractName    | String        | 否   | 合约名称                          |
| 3.3  | groupId         | Int           | 否   | 所属群组编号                      |
| 3.4  | contractAddress | String        | 否   | 合约地址                          |
| 3.5  | contractAbi     | String        | 是   | 导入的abi文件内容                 |
| 3.6  | contractBin     | String        | 是   | 合约runtime-bytecode(runtime-bin) |
| 3.7  | account         | String        | 否   | 所属账号                          |
| 3.8  | createTime      | LocalDateTime | 否   | 创建时间                          |
| 3.9  | modifyTime      | LocalDateTime | 是   | 修改时间                          |
| 3.10 | extContractId  | int | 否   | 链上合约编号                         |
| 3.11 | transCount  | int   | 否   | 合约交易量                           |
| 3.12 | hashs  | String | 否   | 合约交易hash（5个）                           |
| 3.13 | deployTxHash  | String | 是   | 部署合约的交易hash          |
| 3.14 | deployAddress  | String | 是   | 部署合约的用户地址          |
| 3.15 | deployTime  | Date | 是   | 合约的部署时间          |

***2）出参示例***

* 成功：

```
{
	"code": 0,
	"message": "success",
	"data": [{
		"abiId": 6,
		"groupId": 1,
		"account": "admin",
		"contractName": "SpecificIssuerController",
		"contractAddress": "0xce1d576181e1d68899a3f2b86c8e274657c07fea",
		"contractAbi": "[{\"constant\":false,\"inputs\":[{\"name\":\"typeName\",\"type\":\"bytes32\"},{\"name\":\"addr\",\"type\":\"address\"}],\"name\":\"addIssuer\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"typeName\",\"type\":\"bytes32\"},{\"name\":\"addr\",\"type\":\"address\"}],\"name\":\"isSpecificTypeIssuer\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"typeName\",\"type\":\"bytes32\"},{\"name\":\"extraValue\",\"type\":\"bytes32\"}],\"name\":\"addExtraValue\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"typeName\",\"type\":\"bytes32\"}],\"name\":\"registerIssuerType\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"typeName\",\"type\":\"bytes32\"}],\"name\":\"getExtraValue\",\"outputs\":[{\"name\":\"\",\"type\":\"bytes32[]\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"typeName\",\"type\":\"bytes32\"}],\"name\":\"isIssuerTypeExist\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"typeName\",\"type\":\"bytes32\"},{\"name\":\"addr\",\"type\":\"address\"}],\"name\":\"removeIssuer\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"typeName\",\"type\":\"bytes32\"},{\"name\":\"startPos\",\"type\":\"uint256\"},{\"name\":\"num\",\"type\":\"uint256\"}],\"name\":\"getSpecificTypeIssuerList\",\"outputs\":[{\"name\":\"\",\"type\":\"address[]\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"name\":\"specificIssuerDataAddress\",\"type\":\"address\"},{\"name\":\"roleControllerAddress\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"name\":\"operation\",\"type\":\"uint256\"},{\"indexed\":false,\"name\":\"retCode\",\"type\":\"uint256\"},{\"indexed\":false,\"name\":\"typeName\",\"type\":\"bytes32\"},{\"indexed\":false,\"name\":\"addr\",\"type\":\"address\"}],\"name\":\"SpecificIssuerRetLog\",\"type\":\"event\"}]",
		"contractBin": "",
		"createTime": "2021-04-06 21:34:38",
		"modifyTime": "2021-04-06 21:34:38",
		"extContractId": 800014,
		"deployAddress": "0x222d68876bed5a33c8efe04c6fc9783031c22cd1",
		"deployTxHash": "0xd04b35d7741f0568546de4fc29a880fa0f3727beef544497ca5816fa8793fa13",
		"deployTime": 1617716070000,
		"transCount": 0,
		"hashs": null
	},{
		"abiId": null,
		"groupId": 1,
		"account": null,
		"contractName": null,
		"contractAddress": "0x5e103407b2a06b32bad0fc578e1888036a3e26a8",
		"contractAbi": null,
		"contractBin": "",
		"createTime": null,
		"modifyTime": null,
		"extContractId": 800007,
		"deployAddress": "0x222d68876bed5a33c8efe04c6fc9783031c22cd1",
		"deployTxHash": "0x4c6f026e72b69e9ed1f3685f24bc055f5ef1bdde4778ee684a96d25deba6b34b",
		"deployTime": 1617716065000,
		"transCount": 1,
		"hashs": "0x4c6f026e72b69e9ed1f3685f24bc055f5ef1bdde4778ee684a96d25deba6b34b"
	}],
	"totalCount": 2
}
```



## 附录

### 1. 返回码信息列表 
<span id="code"></span>

`X01XXX`为WeBASE-Front[节点前置错误码](../WeBASE-Front/interface.html#code)，`X02XXX`为WeBASE-Node-Manager节点管理服务错误码，`X03XXX`为WeBASE-Sign[签名服务错误码](../WeBASE-Sign/interfaces.html#code)。


| code   | message                                      | 描述                       |
| ------ | -------------------------------------------- | -------------------------- |
| 0      | success                                      | 成功                       |
| 102001 | system error                                 | 系统异常                   |
| 102002 | system exception: please check front         | 系统异常，请检查前置状态               |
| 102003 | No group belongs to this groupId(node not belongs to this group)  | 当前节点不属于当前群组               |
| 202000 | invalid front id                    | 不正确的前置ID（添加节点前置失败）            |
| 202001 | database exception                  | 数据库异常           |
| 202002 | not found any front for this group      | 找不到此群组的任何前置           |
| 202003 | not support this ip     | 不支持该ip           |
| 202004 | front already exists     | 前置已经存在           |
| 202005 | group id cannot be empty     | 群组不能为空           |
| 202006 | invalid group id     | 无效的网络编号           |
| 202007 | checkCode is null     | 校验码为空           |
| 202008 | invalid checkCode     | 无效的校验码           |
| 202009 | save front fail     | 保存前置失败           |
| 202010 | request front fail      | 请求前置失败           |
| 202011 | abiInfo cannot be empty      | abi信息不能为空           |
| 202012 | user id cannot be empty      | 用户编号不能为空           |
| 202013 | invalid user      | 无效的用户编号           |
| 202014 | user already exists      | 用户信息已经存在           |
| 202015 | contract already exists      | 合约信息已经存在           |
| 202017 | invalid contract id      | 无效的合约编号           |
| 202018 | invalid param info      | 无效的入参信息           |
| 202019 | contract name cannot be repeated     | 合约名称不能重复           |
| 202020 | deployed contract cannot be modified | 已部署合约不支持修改 |
| 202023 | contract has not deploy      | 合约尚未部署           |
| 202026 | account info already exists      | 该帐号已经存在           |
| 202027 | account info not exists      | 该帐号不存在           |
| 202028 | account name empty      | 帐号名称不能为空           |
| 202029 | invalid account name      | 无效的账号名称           |
| 202030 | password error      | 密码错误           |
| 202031 | role id cannot be empty      | 角色编号不能为空           |
| 202032 | invalid role id      | 无效的角色编号           |
| 202033 | invalid contract address      | 无效的合约地址           |
| 202034 | login fail      | 登录失败           |
| 202035 | contract has been deployed      | 该合约已经部署           |
| 202036 | publicKey cannot be empty      | 公钥不能为空           |
| 202037 | associated account cannot be empty    | 关联账号不能为空   |
| 202040 | contract deploy not success      | 合约部署失败           |
| 202045 | the new password cannot be same as old      | 新旧密码不能一致           |
| 202050 | publicKey's length is 130,address's length is 42    | 公钥长度为130，公钥地址长度为42           |
| 202051 | wrong host or port    |  错误的主机或端口          |
| 202052 | invalid token   |  无效的token          |
| 202053 | token expire    |  token过期          |
| 202054 | Available front url is empty, check front status     |  合约尚未部署          |
| 202060 | cert handle error    |  证书句柄错误          |
| 202061 | store cert error    |  存储证书错误          |
| 202062 | cert format error, must start with -----BEGIN CERTIFICATE-----\\n, end with end    |  证书格式错误，必须由 --BEGIN CERTIFICATE-- 包          |
| 202063 | saving front's cert error    |  保存前置证书错误          |
| 202070 | Mail server config error    |  邮件服务器配置错误。          |
| 202071 | Mail server config param empty/not match    |  邮件服务器配置参数为空/不匹配          |
| 202072 | Mail server config error, db's server config is empty    |  邮件服务器配置错误，数据库的服务器配置为空          |
| 202076 | Alert rule error    |  警报规则错误。          |
| 202077 | Alert rule param not match    |  警报规则参数不匹配。          |
| 202080 | Send mail error, please check mail server configuration    |  发送邮件错误，请检查邮件服务器配置。          |
| 202081 | Send mail error, please enable mail server before send    |  发送邮件错误，请在发送前启用邮件服务器。          |
| 202086 | Alert log error    |  警报日志错误。          |
| 202087 | Alert log param: status/logId is empty    |  警报日志参数：status/logId为空。          |
| 202090 | Update guomi methodId error    |  更新国密methodId错误          |
| 202091 | Front's encrypt type not matches with nodemgr    |  Front的加密类型与nodemgr不匹配          |
| 202096 | contract address already exists    |  合约地址已存在          |
| 202097 | abi info of this id not exists    |  此ID的ABI信息不存在          |
| 202098 | Contract abi invalid, please check abi    |  合约ABI无效，请检查ABI          |
| 202099 | Abi Id cannot be empty    |  此ID的ABI信息为空          |
| 202100 | contractAddress is null    |  合约地址为空          |
| 202110 | User's signUserId not exist    |  用户的signUserId不存在          |
| 202111 | Fail to parse json    |  解析json错误          |
| 202121 | Cert file not found, please check cert path in config    |  找不到证书文件，请检查配置中的证书路径          |
| 202122 | Pem file format error, must surrounded by -----XXXXX PRIVATE KEY-----    |  Pem文件格式错误，必须包含-----XXXXX PRIVATE KEY-----          |
| 202123 | Pem file content error    |  Pem文件内容错误          |
| 202124 | p12's password cannot be chinese    |  P12的密码不能为中文          |
| 202125 | p12's password not match    |  P12的密码错误          |
| 202126 | P12 file content error    |  P12文件内容错误          |
| 202300 | Group id already exists    |  群组id已存在          |
| 202301 | Node's front not exists    |  节点前置不存在          |
| 202310 | govern vote record not exist    |  投票记录不存在          |
| 202311 | permission denied on chain    |  链上权限被禁止          |
| 202321 | path contains deployed contract, please delete one by one    |  路径中包含已部署的合约，请逐个删除未部署的合约          |
| 202322 | contract path cannot be blank(use "/" instead)    |  合约地址不能为空（默认请使用"/"）          |
| 202323 | privateKey decode fail    |  私钥解码失败          |
| 202324 | password decode fail  |  密码/授权码解码失败         |
| 202401 | No configured of docker registry url.    |  没有配置 Docker 镜像更新 URL 地址          |
| 202402 | Fetch image tag from docker registry error.    |  从 Docker 源更新镜像版本失败          |
| 202403 | Fetch Docker image tag list error, unknown config type.    |  查询 Docker 镜像版本失败（未知类型）          |
| 202404 | Save chain's configuration to file error.    |  保存链配置信息文件失败          |
| 202405 | Docker image tag invalid.    |  错误的镜像版本          |
| 202406 | Configuration of host is empty.    |  主机配置参数为空          |
| 202407 | Chain exists, deploy failed.    |  链已存在，部署失败          |
| 202408 | Save chain data to DB error.    |  插入链信息到数据库失败          |
| 202409 | Chain root dir exist, please move it manually.    |  主机节点的链安装目录(default_chains)已存在，请手动移除          |
| 202410 | Execute build_chain.sh script error.    |  执行 build_chain.sh 链生成脚本失败          |
| 202411 | Host, agency, group configuration error.    |  主机，机构，群组配置信息错误          |
| 202412 | Host ip and num error.    |  主机 IP，节点数量配置错误          |
| 202413 | Agency name invalid, only [a-zA-Z0-9_] is valid.    |  机构名称格式错误，只能包含大小写字母，数字，下划线          |
| 202414 | Group id error, only positive integer is valid.    |  群组编号格式错误，必须为正整数          |
| 202415 | Login to host /ip/ through SSH error. Please check SSH configuration.    |  SSH登录主机/ip/失败，请检查 SSH 配置          |
| 202416 | Save agency data into DB error.    |  插入新机构信息到数据库失败          |
| 202417 | Save group data into DB error.    |  插入新群组信息到数据库失败          |
| 202418 | Save host data into DB error.    |  插入主机信息到数据库失败          |
| 202419 | Save front data into DB error.    |  插入前置信息到数据库失败          |
| 202420 | Save node data into DB error.    |  插入节点信息到数据库失败          |
| 202421 | Save node and front mapping data into DB error.    |  插入前置和群组映射关系到数据库失败          |
| 202422 | Parse node index from directory error.    |  从目录获取节点序号失败          |
| 202423 | A single host IP only belongs to one agency.    |  一个 IP 主机，只能属于一个机构          |
| 202424 | Unknown error during deploying.    |  部署时发生未知错误          |
| 202425 | SSH login through username and password is unsupported yet.    |  不支持使用 SSH 密码登录主机          |
| 202426 | Chain has no agency.    |  当前链没有所属机构          |
| 202427 | No deployed chain    |  链不存在          |
| 202428 | IP format error.    |  IP 格式错误          |
| 202429 | Agency name cannot be blank when IP is new.    |  主机 IP 是新 IP 时，机构名称不能为空          |
| 202430 | Agency name already exists.    |  存在同名机构          |
| 202431 | Add new node error.    |  新增节点错误          |
| 202432 | No valid chain certification.    |  链证书无效          |
| 202433 | Generate agency private key and crt file error.    |  生成机构私钥和证书失败          |
| 202434 | Host without agency error."    |  主机所属机构为空          |
| 202435 | Node num should be positive integer, and less then 10.    |  主机数量格式错误，正整数，并且小于 10          |
| 202436 | Generate sdk    |  生成主机 SDK 私钥和证书失败          |
| 202437 | Generate node private key and crt files error.    |  生成新节点私钥和证书失败          |
| 202438 | Copy SDK files error.    |  拷贝 SDK 证书和私钥失败          |
| 202439 | Upload SDK files error.    |  上传 SDK 证书和私钥失败          |
| 202440 | Upload node config files error.    |  上传节点证书和私钥失败          |
| 202441 | Copy group config files from original node error.    |  从旧节点复制群组配置文件失败          |
| 202442 | Delete tmp directory of agency error.    |  删除机构临时目录失败          |
| 202443 | Delete tmp directory of SDK error.    |  删除 SDK 临时目录失败          |
| 202444 | Delete tmp directory of node error.    |  删除节点临时目录失败          |
| 202445 | Unknown nodeid.    |  未知节点编号（nodeid）          |
| 202446 | Stop node error.    |  停止节点失败（停止容器）          |
| 202447 | Start node error.    |  启动节点失败（启动容器）          |
| 202448 | Both new image tag and old are the same.    |  链升级的新版本和链的现有版本相同          |
| 202449 | Upgrade chain to new image tag error.    |  链升级失败          |
| 202450 | Delete node failed, node is still in group.    |  节点仍属于群组，删除失败          |
| 202451 | Parse node's config files error.    |  读取节点配置文件失败          |
| 202452 | Delete node's config error.    |  删除节点配置文件失败          |
| 202453 | Stop node before deleting.    |  节点正在运行，删除失败，请先停止节点          |
| 202454 | Update p2p part of related nodes error.    |  更新关联节点 P2P 配置失败          |
| 202455 | Delete chain error.    |  删除链失败          |
| 202456 | Node is still a sealer or observer, delete failed.    |  节点处于观察或共识状态，删除失败          |
| 202457 | Fetch node list from host's configuration files    |  从主机配置文件获取节点列表失败          |
| 202458 | Generate application.yml for front error    |  生成前置 application.yml 配置文件失败          |
| 202459 | Init host with shell script error.    |  通过脚本初始化主机失败          |
| 202460 | Sync files error.    |  传输文件失败          |
| 202461 | Control container through Docker api error.    |  Docker 容器操作失败          |
| 202462 | Two nodes at least.    |  至少两个节点。          |
| 202463 | Group need two sealers at least.    |  群组至少需要两个共识节点。          |
| 202464 | WebaseSignAddess configuration error in Application.yml    |  application.yml中的webaseSignAddess配置错误          |
| 202465 | webaseSignAddress cannot be 127.0.0.1 or localhost in application.yml file   |  sign的地址不能为127.0.0.1或localhost          |
| 202466 | Please pull the Docker image manually in host /ip/    |  主机/ip/请手动拉取 Docker 镜像          |
| 202467 | Max 4 nodes on a single host    |  单个主机最多部署 4 个节点          |
| 202468 | Host of WeBASE-Node-Manager's ip is already existed.    |  WeBASE-Node-Manager所在主机的IP已存在          |
| 202469 | Check docker installed and running of host    |  检测主机Docker已安装且已启动未通过          |
| 202470 | Check host memory not enough for nodes(s)    |  检测主机安装节点所需空余内存未通过          |
| 202471 | Check host cpu core count not enough for node(s)    |  检测主机安装节点所需CPU核核心数未通过          |
| 202472 | Host check had been interrupt    |  主机检测过程被中断          |
| 202473 | Host check fail for inpurt param    |  主机检测入参错误          |
| 202475 | Fail to generate chain and front config locally    |  本地生成链与前置配置失败          |
| 202476 | Not all host init success    |  部分主机在检测时未通过          |
| 202477 | Ipconf's node port config error    |  Ipconf入参格式中节点端口格式错误          |
| 202478 | Ipconf not match with deploy info list    |  Ipconf与主机节点信息不匹配          |
| 202479 | Delete host fail for host contains node(front)    |  无法删除主机，主机中仍包含节点          |
| 202480 | Ansible not installed!    |  Node-Manager所在主机未安装Ansible          |
| 202481 | Ansible fetch not support fetch directory    |  Ansible不支持Fetch目录          |
| 202482 | Ansible ping cannot reach target ip    |  Ansible无法ping连通目标IP         |
| 202483 | Ansible init host of image and scp config not all success    |  主机初始化镜像与传输配置未全部成功          |
| 202484 | Ansible pull docker hub fail    |  Ansible拉取Docker hub镜像失败          |
| 202485 | Ansible pull docker cdn fail    |  Ansible拉取CDN镜像失败          |
| 202486 | Ansible run docker command fail    |  Ansible执行Docker命令失败          |
| 202487 | Ansible exec command error    |  Ansible执行命令失败          |
| 202488 | Ansible exec scp(copy) error    |  Ansible执行scp复制到远端失败          |
| 202489 | Ansible exec scp(fetch) error    |  Ansible执行scp拉取文件失败          |
| 202491 | Ansible check image exist error for param    |  Ansible检测Docker镜像存在的入参错误          |
| 202492 | Ansible check docker container exist error for param    |  Ansible检测Docker容器存在的入参错误          |
| 202493 | Check host not pass, please check host remark    |  检测主机未通过，请通过主机的remark查看错误信息          |
| 202494 | Check host port is in use, please check host remark    |  主机的端口已被占用，请通过主机的remark查看错误信息             |
| 202495 | Host already exist    |  主机已存在          |
| 202496 | Host root dir access denied    |  主机的安装目录无权限访问          |
| 202497 | Host not exist or already been deleted    |  主机不存在或已被删除          |
| 202501 | contract path is exists. | 合约路径已存在 |
| 202502 | version cannot be empty | 版本不能为空 |
| 202503 | cns name cannot be empty | cns名不能为空 |
| 202504 | version already exists | 版本已存在 |
| 202511 | Front's sdk cert and key not found | 未找到前置的SDK证书与私钥 |
| 202512 | Write front's sdk cert and key fail | 导出SDK证书私钥文件失败，无法写入文件 |
| 202513 | Write private key file fail | 导出私钥文件失败，无法写入文件 |
| 202514 | group genesis conf not found | 群组的创世块文件不存在，无法添加为共识节点 |
| 202516 | app name exists | 应用名称已存在 |
| 202517 | app name not exists | 应用名称不存在 |
| 202518 | app id not exists | 应用编号不存在 |
| 202519 | link format invalid | 链接格式错误 |
| 202534 | contract path not exists | 合约路径不存在 |
| 302000 | user not logged in    |  未登录的用户          |
| 302001 | Access denied    |  没有权限          |
| 402000 | param exception    |  参数错误          |

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

