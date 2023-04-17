
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

| 序号 | 输出参数       | 类型          |      | 备注                       |
| ---- | -------------- | ------------- | ---- | -------------------------- |
| 1    | code           | Int           | 否   | 返回码，0：成功 其它：失败 |
| 2    | message        | String        | 否   | 描述                       |
| 3    | data           | Object        |      | 节点信息对象               |
| 3.1  | frontId        | int           | 否   | 前置编号                   |
| 3.2  | frontIp        | string        | 否   | 前置ip                     |
| 3.3  | frontPort      | int           | 否   | 前置端口                   |
| 3.4  | agency         | string        | 否   | 所属机构                   |
| 3.5  | createTime     | LocalDateTime | 否   | 落库时间                   |
| 3.6  | modifyTime     | LocalDateTime | 否   | 修改时间                   |
| 3.7  | nodeId         | int           | 否   | 节点Id                     |
| 3.8  | groupList      | List<String>  | 否   | 群组列表                   |
| 3.9  | clientVersion  | String        | 否   | 客户端版本                 |
| 3.10 | supportVersion | String        | 否   | 支持版本                   |
| 3.11 | signVersion    | String        | 否   | 签发版本                   |
| 3.12 | status         | int           | 否   | 当前节点状态               |
| 3.13 | runType        | Byte          | 否   | 运行类型                   |
| 3.14 | agencyId       | int           | 否   | 所属机构Id                 |
| 3.15 | agencyName     | int           | 否   | 所属机构名称               |
| 3.16 | hostId         | int           | 否   | 主机ID                     |
| 3.17 | hostIndex      | int           | 否   | 主机索引                   |
| 3.18 | imageTag       | String        | 否   |                            |
| 3.19 | containerName  | String        | 否   | 容器名称                   |
| 3.20 | jsonrpcPort    | int           | 否   | json远程调用端口           |
| 3.21 | p2pPort        | int           | 否   | P2P端口                    |
| 3.22 | channelPort    | int           | 否   | 通道端口                   |
| 3.23 | chainId        | int           | 否   | 链Id                       |
| 3.24 | chainName      | String        | 否   | 链名称                     |
| 3.25 | frontVersion   | String        | 否   | 前置版本                   |

***2）出参示例***
* 成功：
```
{
	"code": 0,
	"message": "success",
	"data": {
		"frontId": 6,
		"nodeId": "6e24cc5a21a41eab08636f8bbde0c93dd4a9ce4f16fa7fbaed0174872716dd1463d3ce822340d0f51badd2e43c9c106adffd740dbae3adcba7843959609322fd",
		"frontIp": "127.0.0.1",
		"frontPort": 5022,
		"agency": null,
		"groupList": null,
		"clientVersion": null,
		"supportVersion": null,
		"frontVersion": "lab-rc1",
		"signVersion": "v2.0.0-lab",
		"createTime": null,
		"modifyTime": null,
		"status": 1,
		"runType": 0,
		"agencyId": null,
		"agencyName": null,
		"hostId": null,
		"hostIndex": null,
		"imageTag": null,
		"containerName": null,
		"jsonrpcPort": null,
		"p2pPort": null,
		"channelPort": null,
		"chainId": 0,
		"chainName": "default"
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
| 2     | groupId       | String      | 否     | 所属群组编号                |
| 2     | frontStatus       | Int           | 否     | 前置状态        |


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
| 4.1.24 | nodeId | string | 否 | 节点ID |
| 4.1.25 | groupList | List<Integer> | 否 | 群组列表 |

***2）出参示例***

* 成功：
```
{
	"code": 0,
	"message": "success",
	"data": [{
		"frontId": 2,
		"nodeId": "5e4624ac3929babcba542088c0029d6a055f42e03f28b3c9f2c591c2fd0c0ce8c6f1f8bef92131f3acdcee3a4d5698fb30602981e8ff480ed41186828d365abc",
		"frontIp": "127.0.0.1",
		"frontPort": 5002,
		"agency": null,
		"groupList": null,
		"clientVersion": null,
		"supportVersion": null,
		"frontVersion": "string",
		"signVersion": "String",
		"createTime": "2021-12-01 12:49:32",
		"modifyTime": "2021-12-01 12:49:32",
		"status": 1,
		"runType": 0,
		"agencyId": null,
		"agencyName": null,
		"hostId": null,
		"hostIndex": null,
		"imageTag": null,
		"containerName": null,
		"jsonrpcPort": null,
		"p2pPort": null,
		"channelPort": null,
		"chainId": 0,
		"chainName": "default"
	}],
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
| 1     | groupId         | String      | 是     | 所属群组编号               |
| 2     | transactionHash | String        | 否    | 交易hash                   |
| 3     | blockNumber     | BigInteger    | 否    | 块高                       |
| 4     | pageSize        | int           | 是     | 每页记录数                 |
| 5     | pageNumber      | int           | 是     | 当前页码                   |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/transaction/transList/group/1/10?transactionHash=0x303daa78ebe9e6f5a6d9761a8eab4bf5a0ed0b06c28764488e4716de42e1df01
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
| 4.1.2 | blockNumber     | BigInteger    | 否     | 所属块高                   |
| 4.1.3 | statisticsFlag  | Int           | 否     | 是否已经统计               |
| 4.1.4 | createTime      | LocalDateTime | 否     | 落库时间                   |
| 4.1.5 | modifyTime      | LocalDateTime | 否     | 修改时间                   |
| 4.1.6 | transFrom | String | 否 | 交易发起方 |
| 4.1.7 | transTo | String | 否 | 交易接收方 |
| 4.1.8 | blockTimestamp | String | 否 | 区块时间戳 |


***2）出参示例***
* 成功：
```
{
    "code": 0,
    "message": "success",
    "data": [
        {        
             "transHash": "0x158c20a61d5ee01f64f2fb2b7f752f834b6a64c1687ac2bfc541dcd8b261301c",
             "transFrom": "0x",
             "transTo": "92E730F449bbCE3af96dE1Fb9c9c44672DDccb66",
             "blockNumber": 204,
             "blockTimestamp": "2021-12-02 10:12:21",
             "statisticsFlag": 1,
             "createTime": "2021-12-02 10:12:37",
             "modifyTime": "2021-12-02 10:12:37"
        }
    ],
    "totalCount": 204
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
| 1     | groupId         | String      | 是     | 所属群组编号               |
| 2     | transHash | String        | 是     | 交易hash                   |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/transaction/transactionReceipt/group/0x158c20a61d5ee01f64f2fb2b7f752f834b6a64c1687ac2bfc541dcd8b261301c
```


#### 2.2.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | code            | Int           | 否     | 返回码，0：成功 其它：失败 |
| 2     | message         | String        | 否     | 描述                       |
| 3     |                 | Object        |        | 交易信息对象               |
| 3.1 | transactionHash       | String        | 否     | 交易hash                   |
| 3.2 | version  | String     | 否 | 版本号                     |
| 3.3 | blockNumber     | String | 否     | 所属块高                   |
| 3.4 | message | String     | 否    |                |
| 3.5 | gasUsed      | String | 否     | 交易消耗的gas                   |
| 3.6 | contractAddress      | String | 否     | 合约地址                   |
| 3.7 | status      | int | 否     | 交易的状态值                   |
| 3.8 | from      | String | 否     | 交易发起者                   |
| 3.9 | to      | String | 否     | 交易目标                   |
| 3.10 | output      | String | 否     | 交易输出内容                   |
| 3.11 | statusOk | boolean | 否    |                    |
| 3.12 | hash  | String | 否     |                    |
| 3.13 | logEntries | List<Logs> | 否 | 日志 |
| 3.14 | input | String | 否 |  |
| 3.15 | transactionProof | List<MerkleProofUnit> | 否 |  |
| 3.16 | receiptProof | List<MerkleProofUnit> | 否 |  |


***2）出参示例***
* 成功：
```
{
  "code": 0,
  "message": "success",
  "data": {
    "version": "0",
    "contractAddress": "",
    "gasUsed": "29999998452",
    "status": 0,
    "blockNumber": "204",
    "output": "0x",
    "transactionHash": "0x158c20a61d5ee01f64f2fb2b7f752f834b6a64c1687ac2bfc541dcd8b261301c",
    "logEntries": [],
    "input": "0x1e26fd330000000000000000000000000000000000000000000000000000000000000001",
    "from": "0x9097678eb34daeebb6e3528ed4f8715cdc5e4c09",
    "to": "92E730F449bbCE3af96dE1Fb9c9c44672DDccb66",
    "transactionProof": null,
    "receiptProof": null,
    "message": null,
    "statusOK": true,
    "hash": "0xf8f0fa250662d5403415600696fbeaba65035cf5d3642cb9787fc958d4d859cc"
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
| 1     | groupId         | String      | 是     | 所属群组编号               |
| 2     | transHash       | String        | 是    | 交易hash                   |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/transaction/transInfo/group/0x158c20a61d5ee01f64f2fb2b7f752f834b6a64c1687ac2bfc541dcd8b261301c
```


#### 2.3.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | code            | Int           | 否     | 返回码，0：成功 其它：失败 |
| 2     | message         | String        | 否     | 描述                       |
| 3     |                 | Object        |        | 交易信息对象               |
| 3.1   | hash            | String        | 否     | 交易hash                   |
| 3.2  | from            | String | 否     | 交易发起者                   |
| 3.3  | to              | String | 否     | 交易目标                   |
| 3.4 | nonce           | String | 否     |                    |
| 3.5 | input           | String | 否     |                    |
| 3.6 | version | int | 否 | 版本 |
| 3.7 | blockLimit | Long | 否 | 区块限制 |
| 3.8 | chainID | String | 否 | 链ID |
| 3.9 | groupID | String | 否 | 群组编号 |
| 3.10 | signature | String | 否 | |
| 3.11 | importTime | Long | 否 | |
| 3.12 | transactionProof | List<MerkleProofUnit> | 否 | |


***2）出参示例***
* 成功：
```
{
  "code": 0,
  "message": "success",
  "data": {
    "version": 0,
    "hash": "0x158c20a61d5ee01f64f2fb2b7f752f834b6a64c1687ac2bfc541dcd8b261301c",
    "nonce": "242209552661748908689249931886835523971363412991803060052851540572747331123",
    "blockLimit": 703,
    "to": "92E730F449bbCE3af96dE1Fb9c9c44672DDccb66",
    "from": "0x9097678eb34daeebb6e3528ed4f8715cdc5e4c09",
    "input": "0x1e26fd330000000000000000000000000000000000000000000000000000000000000001",
    "chainID": "chain",
    "groupID": "group",
    "signature": "0x9a43124ac99a39783b1765d0c3ab96de5e7766db44ce06119fde0a5f7357e05628cb9098c220ec7323fcf5bf84ddae2feb69bb350270fccee7323c7d8f536dff00",
    "importTime": 0,
    "transactionProof": null
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


## 3 帐号管理模块


### 3.1 新增帐号


#### 3.1.1 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/account/accountInfo**
* 请求方式：post
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 3.1.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | account       | String        | 是     | 帐号名称                   |
| 2    | accountPwd    | String        | 是     | 登录密码（sha256）         |
| 3    | roleId        | int           | 是     | 所属角色                   |
| 4 | email | String | 是 |  |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/account/accountInfo
```

```
{
    "account": "testAccount",
    "accountPwd": "3f21a8490cef2bfb60a9702e9d2ddb7a805c9bd1a263557dfd51a7d0e9dfa93e",
    "roleId": 100001,
    "email": "string"
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
| 4 | email | String | 是 |  |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/account/accountInfo
```

```
{
    "account": "testAccount",
    "accountPwd": "82ca84cf0d2ae423c09a214cee2bd5a7ac65c230c07d1859b9c43b30c3a9fc80",
    "roleId": 100001,
    "email": "string"
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
| 1     | groupId        | String      | 是     | 当前所属链                 |
| 2     | pageSize       | Int           | 是     | 每页记录数                 |
| 3     | pageNumber     | Int           | 是     | 当前页码                   |
| 4     | pkHash         | String        | 否     | 区块hash                   |
| 5     | blockNumber    | BigInteger    | 否     | 块高                       |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/block/blockList/group/1/10?pkHash=
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
            "pkHash": "0xa6a8e4154fc9c5dbd19922fcb7a77e4018f7004c5681d9d5faf1e3f5723c2053",
            "blockNumber": 206,
            "blockTimestamp": "2021-12-02 14:43:51",
            "transCount": 1,
            "sealerIndex": 0,
            "sealer": "2d5053131f5c0a906fec99380ae797b505e697e1ec0e1f2b59a85ae7f28cb3313986e4e627090d8fdff0c545b82e475f00e616f28fd2b4ce0fb43c74bef7c2ab",
            "createTime": "2021-12-02 14:44:16",
            "modifyTime": "2021-12-02 14:44:16"
        },
        ......
    ],
    "totalCount": 207
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


### 4.2 根据块高查询区块信息


#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/block/blockByNumber/{groupId}/{blockNumber}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | groupId        | String     | 是     | 当前所属链                 |
| 2    | pageNumber     | Int           | 是     | 当前页码                   |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/block/blockByNumber/group/1
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
    "number": 1,
    "version": 0,
    "hash": "0x60d1eacd2a279c343c74b673ad30fc6c6a528fb8434b90cc276cc239bf998835",
    "logsBloom": null,
    "receiptsRoot": "0x96e73cf059095f36cd0fed8bd3ce15550de892eae269598b7ba9e1721c8d05a9",
    "stateRoot": "0xd212274a9fdaf3c59a9733f0607b510456d5f395ae0a19c391cd277ff54c2872",
    "sealer": 0,
    "sealerList": [
      "0x2d5053131f5c0a906fec99380ae797b505e697e1ec0e1f2b59a85ae7f28cb3313986e4e627090d8fdff0c545b82e475f00e616f28fd2b4ce0fb43c74bef7c2ab",
      "0x44f760aa2f9058d2dd85a578197d2bfdeac7ef8db1dec39386854e1d66bce4077ce3cae1e4779658b3ebcf929c12e6f7a9c646b60084038c73aeeb9a9b376dab"
    ],
    "extraData": "0x",
    "gasUsed": "6677",
    "timestamp": 1637909172326,
    "parentInfo": [
      {
        "blockNumber": 0,
        "blockHash": "0xe093202d1b18d96ac52700c37af54cd370f06d5062d31232baa3d9ac324d6a57"
      }
    ],
    "signatureList": [
      {
        "signature": "0x1695e0ae6ca37a5fd3d6dfd5c4f18223ec509caa89a485f58cc2675b9147538d1bd381ff5e1b07169639ad1865d18b9b9d1c01335a1edd6d251ff4a1dcef6d4700",
        "sealerIndex": 0
      },
      {
        "signature": "0x8d05b9be2cd01006e249b96c10261e560bf4994144e3808c64186b67001f70675a7d00244d4bc78b6c2369206d9675ed64e37c89c168c113afe4706db9bb0b1801",
        "sealerIndex": 1
      }
    ],
    "consensusWeights": [
      1,
      1
    ],
    "transactions": [
      {
        "version": 0,
        "hash": "0x29fc394aab9f6b850cf670e4ffcfa07f749d65a96fdaf4a1734d08078716df2a",
        "nonce": "628963865034161222069339779084488493077824905060891430374114608099078683365",
        "blockLimit": 500,
        "to": "",
        "from": "0x",
        "input": "0x608060405234801561001057600080fd5b50610148806100206000396000f30060806040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff1680635f76f6ab146100515780636d4ce63c14610080575b600080fd5b34801561005d57600080fd5b5061007e6004803603810190808035151590602001909291905050506100af565b005b34801561008c57600080fd5b50610095610106565b604051808215151515815260200191505060405180910390f35b7f36091dfff76478d9ae2479602161a4e2cab3189920dc3bd12ee0e9e37a35cdc481604051808215151515815260200191505060405180910390a1806000806101000a81548160ff02191690831515021790555050565b60008060009054906101000a900460ff169050905600a165627a7a72305820e29d1a7d9ff77427603f50bd778c7194a67eb5d3e043498f1e666f95f47f8f090029",
        "chainID": "chain",
        "groupID": "group",
        "signature": "0x01ca79d793e424fa2cd54ef8b8967cfdae72b7560d9ff9236bff5d833946571573b87172963acda9a88f119d932d7c76ae4ac2f29badf3e135c3b6f0eefd948e00",
        "importTime": 0,
        "transactionProof": null
      }
    ],
    "txsRoot": "0xc329ee0d01e17507035ef1e507a77484f0191744f9d28ad252ed33c9147cfa05"
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

## 5 合约管理模块  

### 5.1 查询合约列表 


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/contract/contractList/**
* 请求方式：POST
* 返回格式：JSON

#### 请求参数


***1）入参表***

| 序号 | 输入参数        | 类型   | 必填 | 备注             |
| ---- | --------------- | ------ | ------ | ---------------- |
| 1    | groupId         | String | 是     | 群组id           |
| 2    | contractName    | String | 否     | 合约名           |
| 3    | contractAddress | String | 否     | 合约地址         |
| 4    | pageSize        | int    | 是     | 每页记录数       |
| 5    | pageNumber      | int    | 是     | 当前页码         |
| 6    | contractStatus  | int    | 否     | 1未部署，2已部署 |
| 7    | account         | String | 否     | 关联账户         |
| 8 | contractPath | String | 否 | 合约路径 |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/contract/contractList
```

```
{
  "account": "string",
  "contractAddress": "string",
  "contractName": "string",
  "contractPath": "string",
  "contractStatus": 0,
  "groupId": "string",
  "pageNumber": 0,
  "pageSize": 0
}
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
| 5.1.4  | groupId         | String        | 否   | 所属群组编号                                |
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
            "groupId": "group",
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
| 3.4  | groupId         | String        | 否   | 所属群组编号                                          |
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
        "groupId": "group",
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



3.0.2及以后版本：
> 构造方法参数（funcParam）为String数组，每个参数都使用String字符串表示，多个参数以逗号分隔（参数为数组时同理），示例：
> 
> ```
> constructor(string s) -> ["aa,bb\"cc"]	// 双引号要转义
> constructor(uint n,bool b) -> ["1","true"]
> constructor(bytes b,address[] a) -> ["0x1a","[\"0x7939E26070BE44E6c4Fc759Ce55C6C8b166d94BE\",\"0xce867fD9afa64175bb50A4Aa0c17fC7C4A3C67D9\"]"]
> ```


3.0.2以前的版本：
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
| 1    | groupId           | String | 是     | 所属群组编号                                          |
| 2    | contractName      | String | 是     | 合约名称                                              |
| 3    | contractSource    | String | 是     | 合约源码                                              |
| 4    | contractAbi       | String | 是     | 编译合约生成的abi文件内容                             |
| 5    | contractBin       | String | 是     | 合约编译的runtime-bytecode(runtime-bin)，用于交易解析 |
| 6    | bytecodeBin       | String | 是     | 合约编译的bytecode(bin)，用于部署合约                 |
| 7    | contractId        | String | 是     | 合约名称                                              |
| 8    | contractPath      | String | 是     | 合约所在目录                                          |
| 9    | user              | String | 是     | WeBASE的私钥用户的地址                                |
| 10   | account           | String | 是     | 关联账户                                              |
| 11   | constructorParams | List<String>   | 否     | 构造函数入参，根据合约构造函数决定。String数组，每个参数都通过String字符串表示，包括数组也需要括在双引号内，多个参数以逗号分隔（参数为数组时同理），如：set(string s, string[] l) -> ["str1","[\"arr1\",\"arr2\"]"]     |
| 12 | isWasm | Boolean | 是 | 是否为liquid合约，默认为false |
| 13   | contractAddress | String   | 否     | 合约地址，如果isWasm为true，则合约地址不能为空                        |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/contract/deploy
```

```
{
	"groupId": "group",
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
| 3.4  | groupId         | String        | 否   | 所属群组编号                                          |
| 3.5  | contractStatus  | int           | 否   | 1未部署，2已部署                                      |
| 3.6  | contractType    | Int           | 否   | 合约类型(0-普通合约，1-系统合约) （已弃用字段）       |
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
        "groupId": "group",
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
        "modifyTime": null,
        "deployAddress": "0xb783d7c2cd45d8c678093d5f6f1d61855e260e67",
		"deployUserName": "frank"
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


3.0.2及以后版本：

方法参数（funcParam）为String数组，每个参数都使用String字符串表示，多个参数以逗号分隔（参数为数组时同理），示例：

```
function set(string s) -> ["aa,bb\"cc"]	// 双引号要转义
function set(uint n,bool b) -> ["1","true"]
function set(bytes b,address[] a) -> ["0x1a","[\"0x7939E26070BE44E6c4Fc759Ce55C6C8b166d94BE\",\"0xce867fD9afa64175bb50A4Aa0c17fC7C4A3C67D9\"]"]
```

3.0.2以前的版本：

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
| 1    | groupId         | String | 是     | 所属群组编号                        |
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
| 12 | isWasm | Boolean | 是 | 是否为liquid合约，默认为false |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/contract/transaction
```

```
{
    "groupId": "group",
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
	"data": [{
		"value": 0,
		"bitSize": 16,
		"typeAsString": "int16"
	}],
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
| 1    | groupId           | String | 是     | 所属群组编号                  |
| 2    | partOfBytecodeBin | String | 是     | 包含合约bytecodeBin的的字符串 |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/contract/findByPartOfBytecodeBin
```

```
{
    "groupId": "group",
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
| 3.3  | groupId         | String        | 否   | 所属群组编号                                          |
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
| 1    | groupId        | String | 是     | 所属群组编号                                |
| 2    | contractId     | int    | 否     | 合约编号，传入contractId表示更新，否则新增  |
| 3    | contractName   | String | 是     | 合约名称                                    |
| 4    | contractPath   | String | 是     | 合约所在目录                                |
| 5    | contractSource | String | 否     | 合约源码的base64                            |
| 6    | contractAbi    | String | 否     | 合约编译后生成的abi文件内容                 |
| 7    | contractBin    | String | 否     | 合约编译后生成的bin,可用于交易解析          |
| 8    | bytecodeBin    | String | 否     | 合约编译后生成的bytecodeBin，可用于合约部署 |
| 9    | account        | String | 否     | 关联账户，新建时不能为空                    |
| 10 | contractAddress | String | 否 | 合约地址 |
| 11 | isWasm | Boolean | 是 | 是否为liquid合约，默认为false |

***2）入参示例***

```
{
    "groupId": "group",
    "contractName": "HeHe",
    "contractPath": "/",
    "contractSource": "cHJhZ21hIHNvbGlkaXR5IF4wLjQuMjsn0=",
    "contractAbi": “[]”
    "contractBin": "60806040526004361061004c576000357c0100000000000000000000000029",
    "bytecodeBin": "6080604052348015610010572269b80029",
    "contractId": 1,
    "account": "admin",
    "contractAddress": "string"
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
| 3.4  | groupId         | String        | 否   | 所属群组编号                                |
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
| 1    | groupId    | String | 是     | 群组编号      |
| 2    | pageNumber | int    | 是     | 页码，从1开始 |
| 3    | pageSize   | int    | 是     | 页大小        |
| 4    | account    | String | 否     | 所属账号      |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/abi/list/group/1/5?account=
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
| 3.3  | groupId         | String        | 否   | 所属群组编号                      |
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
      "groupId": "group",
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
| 1    | groupId         | String | 是     | 所属群组编号                |
| 2    | contractAddress | String | 是     | 合约地址                    |
| 3    | contractName    | String | 是     | 合约名称                    |
| 4    | contractAbi     | List<Object> | 是     | 合约编译后生成的abi文件内容 |
| 5    | account         | String | 是     | 所属账号                    |
| 6 | abiId | int | 是 | 合约编号 |


***2）入参示例***

```
{
    "groupId": "group",
    "abiId": 1,
    "account": "admin",
    "contractAddress": "0x3214227e87bccca63893317febadd0b51ade735e",
    "contractName": "HelloWorld",
    "contractAbi": [{
        "constant": false,
        "inputs": [{
            "name": "n",
            "type": "string"
        }],
        "name": "set",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    }, {
        "constant": true,
        "inputs": [],
        "name": "get",
        "outputs": [{
            "name": "",
            "type": "string"
        }],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    }, {
        "anonymous": false,
        "inputs": [{
            "indexed": false,
            "name": "name",
            "type": "string"
        }],
        "name": "SetName",
        "type": "event"
    }]
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
| 2    | groupId         | String | 是     | 所属群组编号                |
| 3    | contractAddress | String | 是     | 合约地址                    |
| 4    | contractName    | String | 是     | 合约名称                    |
| 5    | contractAbi     | List<Object> | 是     | 合约编译后生成的abi文件内容 |
| 6 | account | String | 是 |  |


***2）入参示例***

```
{
    "abiId": 1,
    "groupId": "group",
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
| 1        | 所属群组 | groupId | String |              | 是        |                      |
| 2        | 合约状态 | contractStatus | Integer         |       | 是       |1未部署，2已部署  |

**2）数据格式** 

```
http://127.0.0.1:5001/WeBASE-Node-Manager/contract/contractList/all/light?groupId=group&contractStatus=2
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
            "groupId":"group",
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


### 5.12. 保存合约路径

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
| 1        | 所属群组 | groupId | String    |              | 是        |                      |
| 2       | 合约路径 | contractPath | String         |              | 是        |                      |
| 3 | 账户 | account | String | | 是 | |

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


### 5.13. 删除合约路径并批量删除合约

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
| 1        | 所属群组 | groupId | String    |              | 是        |                      |
| 2       | 合约路径 | contractPath | String         |              | 是        |                      |
| 3 | 账户 | account | String | | 是 | |

**2）数据格式** 

```
http://127.0.0.1:5001/WeBASE-Node-Manager/contract/batch/path
```

```
{
    "groupId": "group",
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

### 5.14 获取合约与导入ABI列表（分页）  


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址： **/abi/list/all/{groupId}/{pageNumber}/{pageSize}?account={account}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型   | 必填 | 备注          |
| ---- | ---------- | ------ | ------ | ------------- |
| 1    | groupId    | String | 是     | 群组编号      |
| 2    | pageNumber | int    | 是     | 页码，从1开始 |
| 3    | pageSize   | int    | 是     | 页大小        |
| 4    | account    | String | 否     | 所属账号      |
| 5 | contractName | String | 否 |  |
| 6 | contractAddress | String | 否 |  |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/abi/list/all/group/1/5
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数        | 类型          |      | 备注                              |
| ---- | --------------- | ------------- | ---- | --------------------------------- |
| 1    | code            | Int           | 否   | 返回码，0：成功 其它：失败        |
| 2    | message         | String        | 否   | 描述                              |
| 3  |        | Object        |      | 返回数据                      |
| 3.0  | contractId      | int        |      | 合约编号（contractId为空时，说明合约为外部导入的）                      |
| 3.1  | abiId           | int           | 否   | 合约abi编号                       |
| 3.2  | contractName    | String        | 否   | 合约名称                          |
| 3.3  | groupId         | String      | 否   | 所属群组编号                      |
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
| 3.14 | contractVersion | String | 否 | 合约版本 |
| 3.15 | contractType | int | 否 | 合约类型 |
| 3.16 | contractSource | String | 否 | 合约来源 |
| 3.17 | bytecodeBin | String | 否 | 字节码bin |
| 3.18 | deployTime | String | 否 | 部署时间 |
| 3.19 | description | String | 否 | 描述 |

***2）出参示例***

* 成功：

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "contractId": 200032,
      "contractPath": "/",
      "contractVersion": null,
      "contractName": "AAA",
      "account": "admin",
      "contractStatus": 2,
      "groupId": "group",
      "contractType": 0,
      "contractSource": null,
      "contractAbi": "[{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"name\":\"\",\"type\":\"int256\"}],\"name\":\"test\",\"type\":\"event\"}]",
      "contractBin": "60806040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff1680634ed3885e146100515780636d4ce63c146100ba575b600080fd5b34801561005d57600080fd5b506100b8600480360381019080803590602001908201803590602001908080601f016020809104026020016040519081016040528093929190818152602001838380828437820191505050505050919291929050505061014a565b005b3480156100c657600080fd5b506100cf61019c565b6040518080602001828103825283818151815260200191508051906020019080838360005b8381101561010f5780820151818401526020810190506100f4565b50505050905090810190601f16801561013c5780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b7f9b22c05d8738838d85bfcacfb2975e59c4f830d5977978bc4e3807f38d08b40e607b6040518082815260200191505060405180910390a1806000908051906020019061019892919061023e565b5050565b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156102345780601f1061020957610100808354040283529160200191610234565b820191906000526020600020905b81548152906001019060200180831161021757829003601f168201915b5050505050905090565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061027f57805160ff19168380011785556102ad565b828001600101855582156102ad579182015b828111156102ac578251825591602001919060010190610291565b5b5090506102ba91906102be565b5090565b6102e091905b808211156102dc5760008160009055506001016102c4565b5090565b905600a165627a7a72305820af1790f550db8574896d26e14c0d9b1e24ac7d740ceb8514606e649c7688a3fe0029",
      "bytecodeBin": "608060405234801561001057600080fd5b5061030f806100206000396000f30060806040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff1680634ed3885e146100515780636d4ce63c146100ba575b600080fd5b34801561005d57600080fd5b506100b8600480360381019080803590602001908201803590602001908080601f016020809104026020016040519081016040528093929190818152602001838380828437820191505050505050919291929050505061014a565b005b3480156100c657600080fd5b506100cf61019c565b6040518080602001828103825283818151815260200191508051906020019080838360005b8381101561010f5780820151818401526020810190506100f4565b50505050905090810190601f16801561013c5780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b7f9b22c05d8738838d85bfcacfb2975e59c4f830d5977978bc4e3807f38d08b40e607b6040518082815260200191505060405180910390a1806000908051906020019061019892919061023e565b5050565b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156102345780601f1061020957610100808354040283529160200191610234565b820191906000526020600020905b81548152906001019060200180831161021757829003601f168201915b5050505050905090565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061027f57805160ff19168380011785556102ad565b828001600101855582156102ad579182015b828111156102ac578251825591602001919060010190610291565b5b5090506102ba91906102be565b5090565b6102e091905b808211156102dc5760008160009055506001016102c4565b5090565b905600a165627a7a72305820af1790f550db8574896d26e14c0d9b1e24ac7d740ceb8514606e649c7688a3fe0029",
      "contractAddress": "0xab9F30F9827e1C16Bf62d557c3626AeAd9E85502",
      "deployTime": "2021-12-06 11:31:34",
      "description": null,
      "createTime": "2021-12-06 11:31:34",
      "modifyTime": "2021-12-06 11:31:34",
      "deployAddress": "0x9097678eb34daeebb6e3528ed4f8715cdc5e4c09",
      "deployUserName": "new_test",
      "abiId": 26
    },
    ...
  ],
  "totalCount": 2
}
```

### 5.15. 导入合约仓库到IDE

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
| 1        | 所属群组   | groupId         | String |              | 是       |          |
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



### 5.16. 获取合约仓库列表

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

### 5.17. 根据仓库编号获取仓库信息

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

### 5.18. 根据仓库编号获取合约文件夹信息

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

### 5.19. 根据合约文件夹编号获取合约文件夹信息

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

### 5.20. 根据文件夹编号获取合约列表

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

### 5.21. 根据合约编号获取合约信息

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


### 5.22. 查询合约管理者列表

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
| 1    | groupId         | String | 是     | 群组id           |
| 2    | contractAddress | String | 否     | 合约地址         |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/contract/listManager/group/0xab9F30F9827e1C16Bf62d557c3626AeAd9E85502
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
      "userId": 700003,
      "userName": "new_test",
      "account": "test",
      "groupId": "group",
      "publicKey": "04b27022e80712f4def30d008a390cbe3503100ef54236bea3d4ca9a7fe95c8aafc2a401dd344605fa8d6b52533b289e8af9a75b992ac006a6a0ec8c0ef0b300eb",
      "privateKey": null,
      "userStatus": 1,
      "chainIndex": null,
      "userType": 1,
      "address": "0x9097678eb34daeebb6e3528ed4f8715cdc5e4c09",
      "signUserId": "05281cdc3c894a2da852af6b2ad3d919",
      "appId": "group",
      "hasPk": 1,
      "description": "",
      "createTime": "2021-11-30 16:18:03",
      "modifyTime": "2021-11-30 16:18:03"
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


### 5.23. 检测是否已配置Liquid环境

通过cargo命令和liquid命令，检测WeBASE-Front所在主机是否已配置Liquid环境

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/contract/liquid/check/{frontId}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**      | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | --------------- | -------- | ------------ | -------- | -------- |
| 1        | 前置编号   | frontId        | Integer  |            | 是       | 检测该前置所在主机是否配置了liquid环境 |

**2）数据格式** 

```
http://127.0.0.1:5001/WeBASE-Node-Manager/contract/liquid/check/10001
```

#### 响应参数

**1）参数表**

| **序号** | **中文** | **参数名**      | **类型** | **必填** | **说明**              |
| -------- | -------- | --------------- | -------- | -------- | --------------------- |
| 1        | 返回码   | code            | String   | 是       | 返回码信息请参看附录1 |
| 2        | 提示信息 | message         | String   | 是       |                       |

**2）数据格式**

```
{
  "code": 0,
  "message": "success"
}
```


### 5.24. 编译liquid合约

传入合约源码、编译liquid合约，并返回编译得到的abi和bin。

由于liquid合约类似于rust编译，耗时比solidity更长（3分钟左右），因此接口返回状态为“编译中”时，后台将异步执行编译任务，通过轮询`/contract/liquid/compile/check`接口可以获取最新的编译结果


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/contract/liquid/compile**
* 请求方式：POST
* 返回格式：JSON

#### 请求参数

| 序号 | 输入参数       | 类型   | 必填 | 备注                                        |
| ---- | -------------- | ------ | ------ | ------------------------------------------- |
| 1    | groupId        | String | 是     | 所属群组编号                                |
| 2    | contractId     | int    | 是     | 合约编号，非空，用于编译完成后后台更新合约ABI和BIN  |
| 3    | contractName   | String | 是     | 合约名称                                    |
| 4    | contractPath   | String | 是     | 合约所在目录                                |
| 5    | contractSource | String | 是     | 合约源码的base64                            |
| 6    | account        | String | 否     | 关联账户，新建时不能为空                    |
| 7 | isWasm | Boolean | 是 | 是否为liquid合约，默认为false |
| 8 | frontId | int | 是 | 前置编号，用于指定通过哪个前置进行liquid编译 |

***2）入参示例***
```
http://127.0.0.1:5001/WeBASE-Node-Manager/contract/liquid/compile
```

```
{
    "groupId": "group0",
	"contractName": "LiquidHelloWorld",
	"contractPath": "/",
	"contractSource": "IyFbY2ZnX2F0dHIobm90KGZlYXR1cmUgPSAic3RkIiksIG5vX3N0ZCldCgp1c2UgbGlxdWlkOjpzdG9yYWdlOwp1c2UgbGlxdWlkX2xhbmcgYXMgbGlxdWlkOwoKI1tsaXF1aWQ6OmNvbnRyYWN0XQptb2QgaGVsbG9fd29ybGQgewogICAgdXNlIHN1cGVyOjoqOwoKICAgICNbbGlxdWlkKHN0b3JhZ2UpXQogICAgc3RydWN0IEhlbGxvV29ybGQgewogICAgICAgIG5hbWU6IHN0b3JhZ2U6OlZhbHVlPFN0cmluZz4sCiAgICB9CgogICAgI1tsaXF1aWQobWV0aG9kcyldCiAgICBpbXBsIEhlbGxvV29ybGQgewogICAgICAgIHB1YiBmbiBuZXcoJm11dCBzZWxmKSB7CiAgICAgICAgICAgIHNlbGYubmFtZS5pbml0aWFsaXplKFN0cmluZzo6ZnJvbSgiQWxpY2UiKSk7CiAgICAgICAgfQoKICAgICAgICBwdWIgZm4gZ2V0KCZzZWxmKSAtPiBTdHJpbmcgewogICAgICAgICAgICBzZWxmLm5hbWUuY2xvbmUoKQogICAgICAgIH0KCiAgICAgICAgcHViIGZuIHNldCgmbXV0IHNlbGYsIG5hbWU6IFN0cmluZykgewogICAgICAgICAgICBzZWxmLm5hbWUuc2V0KG5hbWUpCiAgICAgICAgfQogICAgfQoKICAgICNbY2ZnKHRlc3QpXQogICAgbW9kIHRlc3RzIHsKICAgICAgICB1c2Ugc3VwZXI6Oio7CgogICAgICAgICNbdGVzdF0KICAgICAgICBmbiBnZXRfd29ya3MoKSB7CiAgICAgICAgICAgIGxldCBjb250cmFjdCA9IEhlbGxvV29ybGQ6Om5ldygpOwogICAgICAgICAgICBhc3NlcnRfZXEhKGNvbnRyYWN0LmdldCgpLCAiQWxpY2UiKTsKICAgICAgICB9CgogICAgICAgICNbdGVzdF0KICAgICAgICBmbiBzZXRfd29ya3MoKSB7CiAgICAgICAgICAgIGxldCBtdXQgY29udHJhY3QgPSBIZWxsb1dvcmxkOjpuZXcoKTsKCiAgICAgICAgICAgIGxldCBuZXdfbmFtZSA9IFN0cmluZzo6ZnJvbSgiQm9iIik7CiAgICAgICAgICAgIGNvbnRyYWN0LnNldChuZXdfbmFtZS5jbG9uZSgpKTsKICAgICAgICAgICAgYXNzZXJ0X2VxIShjb250cmFjdC5nZXQoKSwgIkJvYiIpOwogICAgICAgIH0KICAgIH0KfQ==",
	"contractAbi": "[{\"inputs\":[],\"type\":\"constructor\"},{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"internalType\":\"string\",\"type\":\"string\"}],\"type\":\"function\"},{\"conflictFields\":[{\"kind\":0,\"path\":[],\"read_only\":false,\"slot\":0}],\"constant\":false,\"inputs\":[{\"internalType\":\"string\",\"name\":\"name\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"type\":\"function\"}]",
    "isWasm": true,
    "contractId": 1,
    "account": "admin",
    "frontId": 10001
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
| 3.2      | 合约路径 | contractPath    | String   | 是       |  默认空，代表了"/"路径                     |
| 3.3      | 合约名   | contractName    | String   | 是       |                       |
| 3.4      | 编译状态    | status         | Integer   | 是       |  1-编译中，2-编译成功，3-编译失败，4-编译已重置                     |
| 3.5      | 合约Abi  | abi         | String   | 是       |   编译成功时为非空                    |
| 3.6      | 合约bytecode-bin | bin | String   | 是       |   编译成功时为非空，用于部署合约                    |
| 3.7      | 编译描述  | description     | String   | 是       |   编译失败时，错误原因将记录在此字段                    |
| 3.8      | 修改时间 | modifyTime      | LocalDatetime   | 是       |                       |
| 3.9      | 创建时间 | createTime      | LocalDatetime   | 是       |                       |

**2）数据格式**

状态为编译中时： （编译中时，后台将异步执行编译任务，通过轮询`/contract/liquid/compile/check`接口可以获取最新的编译结果）
```
{
  "code": 0,
  "message": "success"
  "data": {
    "groupId": "group",
    "contractPath": "", 
    "contractName": "Hello",
    "status": "1",
    "bin": null,
    "abi": null,
    "createTime": "2020-12-30 16:32:28",
    "modifyTime": "2020-12-30 16:32:28"
  }
}
```

状态为编译成功时（后台将自动更新合约IDE中的合约内容，包括ABI，BIN等）：
```
{
  "code": 0,
  "message": "success"
  "data": {
    "groupId": "group",
    "contractPath": "", 
    "contractName": "Hello",
    "status": "2",
    "bin": "",  //bin过长，此处略
    "abi":"[{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\",\"type0\":null,\"indexed\":false}],\"type\":\"function\",\"payable\":false,\"stateMutability\":\"view\"},{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\",\"type0\":null,\"indexed\":false}],\"name\":\"set\",\"outputs\":[],\"type\":\"function\",\"payable\":false,\"stateMutability\":\"nonpayable\"},{\"constant\":false,\"inputs\":[{\"name\":\"name\",\"type\":\"string\",\"type0\":null,\"indexed\":false}],\"name\":\"SetName\",\"outputs\":null,\"type\":\"event\",\"payable\":false,\"stateMutability\":null}]",
    "createTime": "2020-12-30 16:32:28",
    "modifyTime": "2020-12-30 16:32:28"
  }
}
```


### 5.25. 查询liquid合约编译进度

根据群组ID，合约路径，合约名获取liquid合约的编译状态

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/contract/liquid/compile/check**
* 请求方式：POST
* 返回格式：JSON


#### 请求参数

| 序号 | 输入参数       | 类型   | 必填 | 备注                                        |
| ---- | -------------- | ------ | ------ | ------------------------------------------- |
| 1    | groupId        | String | 是     | 所属群组编号                                |
| 2    | contractId     | int    | 是     | 合约编号，非空，用于编译完成后后台更新合约ABI和BIN  |
| 3    | contractName   | String | 是     | 合约名称                                    |
| 4    | contractPath   | String | 是     | 合约所在目录                                |
| 5    | contractSource | String | 是     | 合约源码的base64                            |
| 6    | account        | String | 是     | 关联账户，新建时不能为空                    |
| 7 | isWasm | Boolean | 是 | 是否为liquid合约，默认为false |
| 8 | frontId | int | 是 | 前置编号，用于指定通过哪个前置进行liquid编译 |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/contract/liquid/compile/check
```

```
{
    "groupId": "group0",
	"contractName": "LiquidHelloWorld",
	"contractPath": "/",
	"contractSource": "IyFbY2ZnX2F0dHIobm90KGZlYXR1cmUgPSAic3RkIiksIG5vX3N0ZCldCgp1c2UgbGlxdWlkOjpzdG9yYWdlOwp1c2UgbGlxdWlkX2xhbmcgYXMgbGlxdWlkOwoKI1tsaXF1aWQ6OmNvbnRyYWN0XQptb2QgaGVsbG9fd29ybGQgewogICAgdXNlIHN1cGVyOjoqOwoKICAgICNbbGlxdWlkKHN0b3JhZ2UpXQogICAgc3RydWN0IEhlbGxvV29ybGQgewogICAgICAgIG5hbWU6IHN0b3JhZ2U6OlZhbHVlPFN0cmluZz4sCiAgICB9CgogICAgI1tsaXF1aWQobWV0aG9kcyldCiAgICBpbXBsIEhlbGxvV29ybGQgewogICAgICAgIHB1YiBmbiBuZXcoJm11dCBzZWxmKSB7CiAgICAgICAgICAgIHNlbGYubmFtZS5pbml0aWFsaXplKFN0cmluZzo6ZnJvbSgiQWxpY2UiKSk7CiAgICAgICAgfQoKICAgICAgICBwdWIgZm4gZ2V0KCZzZWxmKSAtPiBTdHJpbmcgewogICAgICAgICAgICBzZWxmLm5hbWUuY2xvbmUoKQogICAgICAgIH0KCiAgICAgICAgcHViIGZuIHNldCgmbXV0IHNlbGYsIG5hbWU6IFN0cmluZykgewogICAgICAgICAgICBzZWxmLm5hbWUuc2V0KG5hbWUpCiAgICAgICAgfQogICAgfQoKICAgICNbY2ZnKHRlc3QpXQogICAgbW9kIHRlc3RzIHsKICAgICAgICB1c2Ugc3VwZXI6Oio7CgogICAgICAgICNbdGVzdF0KICAgICAgICBmbiBnZXRfd29ya3MoKSB7CiAgICAgICAgICAgIGxldCBjb250cmFjdCA9IEhlbGxvV29ybGQ6Om5ldygpOwogICAgICAgICAgICBhc3NlcnRfZXEhKGNvbnRyYWN0LmdldCgpLCAiQWxpY2UiKTsKICAgICAgICB9CgogICAgICAgICNbdGVzdF0KICAgICAgICBmbiBzZXRfd29ya3MoKSB7CiAgICAgICAgICAgIGxldCBtdXQgY29udHJhY3QgPSBIZWxsb1dvcmxkOjpuZXcoKTsKCiAgICAgICAgICAgIGxldCBuZXdfbmFtZSA9IFN0cmluZzo6ZnJvbSgiQm9iIik7CiAgICAgICAgICAgIGNvbnRyYWN0LnNldChuZXdfbmFtZS5jbG9uZSgpKTsKICAgICAgICAgICAgYXNzZXJ0X2VxIShjb250cmFjdC5nZXQoKSwgIkJvYiIpOwogICAgICAgIH0KICAgIH0KfQ==",
	"contractAbi": "[{\"inputs\":[],\"type\":\"constructor\"},{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"internalType\":\"string\",\"type\":\"string\"}],\"type\":\"function\"},{\"conflictFields\":[{\"kind\":0,\"path\":[],\"read_only\":false,\"slot\":0}],\"constant\":false,\"inputs\":[{\"internalType\":\"string\",\"name\":\"name\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"type\":\"function\"}]",
    "isWasm": true,
    "contractId": 1,
    "account": "admin",
    "contractAddress": "string",
    "frontId": 10001
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
| 3.2      | 合约路径 | contractPath    | String   | 是       |  默认空，代表了"/"路径                     |
| 3.3      | 合约名   | contractName    | String   | 是       |                       |
| 3.4      | 编译状态    | status         | Integer   | 是       |  1-编译中，2-编译成功，3-编译失败，4-编译已重置                     |
| 3.5      | 合约Abi  | abi         | String   | 是       |   编译成功时为非空                    |
| 3.6      | 合约bytecode-bin | bin | String   | 是       |   编译成功时为非空，用于部署合约                    |
| 3.7      | 编译描述  | description     | String   | 是       |   编译失败时，错误原因将记录在此字段                    |
| 3.8      | 修改时间 | modifyTime      | LocalDatetime   | 是       |                       |
| 3.9      | 创建时间 | createTime      | LocalDatetime   | 是       |                       |

**2）数据格式**

状态为编译中时，轮询当前接口直到状态为编译成功、编译失败，status=1：
```
{
  "code": 0,
  "message": "success"
  "data": {
    "groupId": "group",
    "contractPath": "/", 
    "contractName": "Hello",
    "status": "1",
    "bin": null,
    "abi": null,
    "createTime": "2020-12-30 16:32:28",
    "modifyTime": "2020-12-30 16:32:28"
  }
}
```

状态为编译成功时，status=2（后台将自动更新合约IDE中的合约内容，包括ABI，BIN等）：
```
{
  "code": 0,
  "message": "success"
  "data": {
    "groupId": "group",
    "contractPath": "/", 
    "contractName": "Hello",
    "status": "2",
    "bin": "",  //bin过长，此处略
    "abi":"[{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\",\"type0\":null,\"indexed\":false}],\"type\":\"function\",\"payable\":false,\"stateMutability\":\"view\"},{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\",\"type0\":null,\"indexed\":false}],\"name\":\"set\",\"outputs\":[],\"type\":\"function\",\"payable\":false,\"stateMutability\":\"nonpayable\"},{\"constant\":false,\"inputs\":[{\"name\":\"name\",\"type\":\"string\",\"type0\":null,\"indexed\":false}],\"name\":\"SetName\",\"outputs\":null,\"type\":\"event\",\"payable\":false,\"stateMutability\":null}]",
    "createTime": "2020-12-30 16:32:28",
    "modifyTime": "2020-12-30 16:32:28"
  }
}
```



## 6 服务器监控相关

### 6.1 发送测试邮件

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


### 6.2 获取告警类型配置

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

### 6.3 获取全部告警类型配置列表

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


### 6.4 更新告警类型配置

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


### 6.5 开启/关闭 告警类型

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


### 6.6 获取出块监控信息  

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
| 1      | groupId        | string      | 是     | 所属群组编号                                  |


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
| 1      | groupId        | String | 是     | 所属群组编号      |
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
| 1       | groupId     | String     | 是     | 所属群组编号               |
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
| 3.1     | groupId     | String     | 否     | 所属群组编号               |
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
| 1     | groupId  | stirng      | 是     | 所属群组编号               |
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
| 1     | groupId       | String      | 是     | 所属群组编号               |
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
| 1    | groupId          | string | 是     | 群组id                     |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/group/general/group
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code             | Int    | 否     | 返回码，0：成功 其它：失败 |
| 2    | message          | String | 否     | 描述                       |
| 3    | data             | object | 否     | 返回信息实体               |
| 3.1  | groupId          | string | 否     | 群组id                     |
| 3.2  | nodeCount        | int    | 否     | 节点数量                   |
| 3.3  | contractCount    | int    | 否     | 已部署智能合约数量         |
| 3.4  | transactionCount | int    | 否     | 交易数量                   |
| 3.5  | latestBlock      | int    | 否     | 当前块高                   |
| 3.6 | orgCount | int | 否 | 组织数量 |


***2）出参示例***
* 成功：
```
{
  "code": 0,
  "message": "success",
  "data": {
    "groupId": "group",
    "orgCount": 0,
    "nodeCount": 2,
    "contractCount": 51,
    "transactionCount": 249,
    "latestBlock": 249
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


### 8.2 获取所有群组列表

默认只返回groupStatus为1的群组ID，可传入groupStatus筛选群组 (1-normal, 2-maintaining, 3-conflict-genesisi, 4-conflict-data)

#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/group/all**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

无


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/group/all
http://127.0.0.1:5001/WeBASE-Node-Manager/group/all/{groupStatus}
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1     | code          | Integer    | 否     | 返回码，0：成功 其它：失败 |
| 2     | message       | String        | 否     | 描述                       |
| 3     | totalCount    | Integer    | 否     | 总记录数                   |
| 4     | data          | List          | 否     | 组织列表                   |
| 4.1   |               | Object        |        | 组织信息对象               |
| 4.1.1 | groupId       | String          | 否     | 群组编号                   |
| 4.1.2 | groupName     | String        | 否     | 群组名称                   |
| 4.1.3 | groupStatus   | Integer        | 否     | 群组状态：1-正常, 2-维护中, 3-脏数据, 4-创世块冲突                  |
| 4.1.4 | nodeCount     | Integer        | 否     | 群组节点数                  |
| 4.1.5 | latestBlock   | BigInteger    | 否     | 最新块高                   |
| 4.1.6 | transCount    | BigInteger    | 否     | 交易量                     |
| 4.1.7 | createTime    | LocalDateTime | 否     | 落库时间                   |
| 4.1.8 | modifyTime    | LocalDateTime | 否     | 修改时间                   |
| 4.1.9 | description     | String        | 否     | 群组描述                   |
| 4.1.10 | groupType     | Integer        | 否     | 群组类别：1-同步，2-动态创建  |
| 4.1.11 | encryptType | Integer | 否 | 加密类型 |
| 4.1.12 | groupTimestamp | String | 否 | 群组时间戳 |
| 4.1.13 | nodeIdList | String | 否 | 节点ID列表 |
| 4.1.14 | chainId | Integer | 否 | 链ID |
| 4.1.15 | chainName | String | 否 | 链名称 |


***2）出参示例***
* 成功：
```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "groupId": "group",
      "groupName": "group",
      "groupStatus": 1,
      "nodeCount": 2,
      "latestBlock": 0,
      "transCount": 0,
      "createTime": "2021-12-06 11:21:55",
      "modifyTime": "2021-12-06 17:12:06",
      "description": "synchronous",
      "groupType": 1,
      "encryptType": 0,
      "groupTimestamp": null,
      "nodeIdList": null,
      "chainId": 0,
      "chainName": ""
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
| 1    | groupId    | string | 是     | 群组id                     |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/group/transDaily/group
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
| 4.2  | groupId    | String | 否     | 群组编号                   |
| 4.3  | transCount | int    | 否     | 交易数量                   |

***2）出参示例***

* 成功：
```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "day": "2021-11-29",
      "groupId": "group",
      "transCount": 75
    },
    ...
  ],
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

### 8.4 刷新群组列表

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

### 8.5 获取所有群组列表（包含异常群组）

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
| 4.1.3 | groupStatus   | Integer        | 否     | 群组状态：1-正常, 2-维护中, 3-脏数据, 4-创世块冲突|
| 4.1.4 | nodeCount     | Integer        | 否     | 群组节点数                  |
| 4.1.5 | latestBlock   | BigInteger    | 否     | 最新块高                   |
| 4.1.6 | transCount    | BigInteger    | 否     | 交易量                     |
| 4.1.7 | createTime    | LocalDateTime | 否     | 落库时间                   |
| 4.1.8 | modifyTime    | LocalDateTime | 否     | 修改时间                   |
| 4.1.9 | description     | String        | 否     | 群组描述                   |
| 4.1.10 | groupType     | Integer        | 否     | 群组类别：1-同步，2-动态创建  |
| 4.1.11 | encryptType | Integer | 否 | 加密类型 |
| 4.1.12 | groupTimestamp | String | 否 | 群组时间戳 |
| 4.1.13 | nodeIdList | String | 否 | 节点Id列表 |
| 4.1.14 | chainId | Integer | 否 | 链Id |
| 4.1.15 | chainName | String | 否 | 链名称 |

***2）出参示例***

* 成功：
```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "groupId": "group",
      "groupName": "group",
      "groupStatus": 1,
      "nodeCount": 2,
      "latestBlock": 0,
      "transCount": 0,
      "createTime": "2021-12-06 11:21:55",
      "modifyTime": "2021-12-06 17:12:06",
      "description": "synchronous",
      "groupType": 1,
      "encryptType": 0,
      "groupTimestamp": null,
      "nodeIdList": null,
      "chainId": 0,
      "chainName": ""
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


### 8.6 删除群组所有数据

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
| 1      | groupId    | String     | 是     | 群组编号                                 |

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
| 3 | data |  |  |  |
| 4 | attachment |  |  |  |


***2）出参示例***
* 成功：
```
{
  "code": 0,
  "message": "success",
  "data": null,
  "attachment": null
}
```

* 失败：
```
{
    "code": 202006,
    "message": "invalid group id"
}
```


### 8.7 配置群组备注信息

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
| 1      | groupId   | String      | 是     |  群组ID                                    |
| 1      | description   | String           | 否     | 群组备注                                  |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/group/description
```

{
  "description": "溯源存证应用",
  "groupId": "group"
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



### 8.8 获取单个群组详细信息


#### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/group/detail/{groupId}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1      | groupId   | string     | 是     |  群组ID                                    |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/group/detail/{groupId}
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1      | code        | Integer    | 否     | 返回码，0：成功 其它：失败                 |
| 2      | message     | String        | 否     | 描述                                       |
| 3     | data          | List          | 否     | 组织列表                   |
| 3.1   |               | Object        |        | 组织信息对象               |
| 3.1.1 | groupId       | String      | 否     | 群组编号                   |
| 3.1.2 | groupName     | String        | 否     | 群组名称                   |
| 3.1.3 | groupStatus   | Integer        | 否     | 群组状态：1-正常, 2-维护中, 3-脏数据, 3-创世块冲突|
| 3.1.4 | nodeCount     | Integer        | 否     | 群组节点数                  |
| 3.1.5 | latestBlock   | BigInteger    | 否     | 最新块高                   |
| 3.1.6 | transCount    | BigInteger    | 否     | 交易量                     |
| 3.1.7 | createTime    | LocalDateTime | 否     | 落库时间                   |
| 3.1.8 | modifyTime    | LocalDateTime | 否     | 修改时间                   |
| 3.1.9 | description     | String        | 否     | 群组描述                   |
| 3.1.10 | groupType     | Integer        | 否     | 群组类别：1-同步，2-动态创建  |
| 3.1.11 | groupTimestamp | String | 否 | 群组时间戳 |
| 3.1.12 | nodeIdList | String | 否 | 节点Id列表 |
| 3.1.13 | chainId | Integer | 否 | 链Id |
| 3.1.14 | chainName | String | 否 | 链名称 |
| 3.1.15 | encryptType | Integer | 否 | 加密类型 |

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
    "chainName": "default"，
    "encryptType": 0
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
| 1      | groupId   | String      | 是     | 群组id                                     |
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
| 1    | groupId     | String     | 是     | 群组id                                     |

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
        "groupId": "group",
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
* 请求地址：**/node/nodeIdList/{groupId}/{pageNumber}/{pageSize}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1      | groupId   | string    | 是     | 群组id                                     |
| 2 | pageNumber | int | 是 |  |
| 3 | pageSize | int | 是 |  |
| 4 | nodeName | string | 是 |  |

***2）入参示例***

**

```
http://127.0.0.1:5001/WeBASE-Node-Manager/node/nodeIdList/group
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
| 2     | nodeIp   | String           | 否     | 节点备注IP                                    |
| 3     | agency   | String           | 否     | 节点备注机构名                                  |
| 4     | city     | String           | 否     | 节点备注城市                              |


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

无


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


### 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**role/roleList**
* 请求方式：GET
* 返回格式：JSON

### 请求参数

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

#### 返回参数 

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
| 3    | groupId     | String | 是     | 所属群组 |
| 4    | account     | string | 是     | 关联账户 |
| 5 | userType | int | 是 |  |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/user/userInfo
```

```
{
  "account": "admin",
  "description": "string",
  "groupId": "group",
  "userName": "frank",
  "userType": 0
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
| 3.3  | groupId     | String        | 否   | 所属群组编号                       |
| 3.4  | description | String        | 是   | 备注                               |
| 3.5  | userStatus  | int           | 否   | 状态（1-正常 2-停用） 默认1        |
| 3.6  | publicKey   | String        | 否   | 公钥信息                           |
| 3.7  | address     | String        | 是   | 在链上位置的hash                   |
| 3.8  | hasPk       | Int           | 否   | 是否拥有私钥信息(1-拥有，2-不拥有) |
| 3.9  | account     | string        | 否   | 关联账户                           |
| 3.10 | createTime  | LocalDateTime | 否   | 创建时间                           |
| 3.11 | modifyTime  | LocalDateTime | 否   | 修改时间                           |
| 3.12 | chainIndex  | int           | 否   | 链索引                             |
| 3.13 | userType    | int           | 否   | 用户类型                           |
| 3.14 | signUserId  | String        | 否   | 签名用户Id                         |
| 3.15 | appId       | String        | 否   | 应用Id                             |
| 3.16 | privateKey  | String        | 否   | 私钥信息                           |


***2）出参示例***

* 成功：

```
{
  "code": 0,
  "message": "success",
  "data": {
    "userId": 700006,
    "userName": "frank",
    "account": "admin",
    "groupId": "group",
    "publicKey": "04aa23e6fcc6099c622d7cc9da0ab30019c6a349bfd71d69c83f7cf65a00a5ff9ed5e6fa0ab12c21cc46f0af0aed361a2854777b3b5cd2d13f6ade78bd41fe5b16",
    "privateKey": null,
    "userStatus": 1,
    "chainIndex": null,
    "userType": 0,
    "address": "0xd24488a4d51661694f0c31f2cc688d1670f51d29",
    "signUserId": "c5a76d781e124c7db7279af39819ed2f",
    "appId": "group",
    "hasPk": 1,
    "description": "string",
    "createTime": "2021-12-06 17:53:53",
    "modifyTime": "2021-12-06 17:53:53"
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
| 3    | groupId     | String | 是     | 所属群组 |
| 4    | account     | string | 是     | 关联账户 |
| 5 | publicKey | String | 是 |  |
| 6 | userType | int | 是 |  |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/user/userInfo
```

```
{
  "account": "admin",
  "description": "string",
  "groupId": "group",
  "publicKey": "04aa23e6fcc6099c622d7cc9da0ab30019c6a349bfd71d69c83f7cf65a00a5ff9ed5e6fa0ab12c21cc46f0af0aed361a2854777b3b5cd2d13f6ade78bd41fe5b16",
  "userName": "alex",
  "userType": 0
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
    "userId": "700006",
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
| 3.2  | userName    | String        | 否   | 用户名称                           |
| 3.3  | groupId     | String        | 否   | 所属群组编号                       |
| 3.4  | description | String        | 是   | 备注                               |
| 3.5  | userStatus  | int           | 否   | 状态（1-正常 2-停用） 默认1        |
| 3.6  | publicKey   | String        | 否   | 公钥信息                           |
| 3.7  | address     | String        | 是   | 在链上位置的hash                   |
| 3.8  | hasPk       | Int           | 否   | 是否拥有私钥信息(1-拥有，2-不拥有) |
| 3.9  | account     | String        | 否   | 关联账户                           |
| 3.10 | createTime  | LocalDateTime | 否   | 创建时间                           |
| 3.11 | modifyTime  | LocalDateTime | 否   | 修改时间                           |
| 3.12 | chainIndex  | int           | 否   |                                    |
| 3.13 | userType    | int           | 否   | 用户类型                           |
| 3.14 | signUserId  | String        | 否   | 签名用户Id                         |
| 3.15 | appId       | String        | 否   |                                    |
| 3.16 | privateKey  | String        | 否   |                                    |


***2）出参示例***

* 成功：

```
{
  "code": 0,
  "message": "success",
  "data": {
    "userId": 700006,
    "userName": "frank",
    "account": "admin",
    "groupId": "group",
    "publicKey": "04aa23e6fcc6099c622d7cc9da0ab30019c6a349bfd71d69c83f7cf65a00a5ff9ed5e6fa0ab12c21cc46f0af0aed361a2854777b3b5cd2d13f6ade78bd41fe5b16",
    "privateKey": null,
    "userStatus": 1,
    "chainIndex": null,
    "userType": 0,
    "address": "0xd24488a4d51661694f0c31f2cc688d1670f51d29",
    "signUserId": "c5a76d781e124c7db7279af39819ed2f",
    "appId": "group",
    "hasPk": 1,
    "description": "string",
    "createTime": "2021-12-06 17:53:53",
    "modifyTime": "2021-12-06 19:13:17"
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


### 11.4 导入私钥用户

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
| 4    | groupId     | String | 是     | 所属群组               |
| 5    | account     | string | 是     | 关联账户               |
| 6 | userId | int | 是 | 用户Id |
| 7 | userType | int | 是 | 用户类型 |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/user/import
```

```
{
    "privateKey": "OGFmNWIzMzNmYTc3MGFhY2UwNjdjYTY3ZDRmMzE4MzU4OWRmOThkMjVjYzEzZGFlMGJmODhkYjhlYzVhMDcxYw==",
    "groupId": "group",
    "description": "密钥拥有者",
    "userName": "user1",
    "account": "admin",
    "userId": 0,
    "userType": 0
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


### 11.5 导入.pem私钥

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
| 4    | groupId     | String | 是     | 所属群组                                                     |
| 5    | account     | string | 是     | 关联账户                                                     |
| 6 | userType | int | 是 |  |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/user/importPem
```

```
{
    "pemContent":"-----BEGIN PRIVATE KEY-----\nMIGEAgEAMBAGByqGSM49AgEGBSuBBAAKBG0wawIBAQQgC8TbvFSMA9y3CghFt51/\nXmExewlioX99veYHOV7dTvOhRANCAASZtMhCTcaedNP+H7iljbTIqXOFM6qm5aVs\nfM/yuDBK2MRfFbfnOYVTNKyOSnmkY+xBfCR8Q86wcsQm9NZpkmFK\n-----END PRIVATE KEY-----\n",
    "groupId": "group",
    "description": "密钥拥有者",
    "userName": "user2",
    "account": "admin",
    "userType": 0
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


### 11.6 导入.p12私钥

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
| 5    | groupId     | String      | 是     | 所属群组                                                     |
| 6    | account     | string        | 是     | 关联账户                                                     |
| 7 | roleId | int | 否 | 角色ID |

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


### 11.7 导出明文私钥

可在页面导出WeBASE-Front所导出的私钥txt文件

其中私钥字段用Base64加密

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/user/export/{userId}**
* 请求方式：POST
* 请求头：Content-type: form-data
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型   | 必填 | 备注                   |
| ---- | ----------- | ------ | ------ | ---------------------- |
| 1    | userId | int | 是     |  |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/user/export/300001
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
| 3.3  | groupId     | String      | 否   | 所属群组编号                       |
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
		"userName": "frank",
		"account": "admin",
		"groupId": "group",
		"publicKey": "04d01115d548e7561b15c38f004d734633687cf4419620095bc5b0f47070afe85aa9f34ffdc815e0d7a8b64537e17bd81579238c5dd9a86d526b051b13f4062327",
		"privateKey": "MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwYw==",
		"userStatus": 1,
		"chainIndex": null,
		"userType": 1,
		"address": "0xdbc23ae43a150ff8884b02cea117b22d1c3b9796",
		"signUserId": "b751efc5d0cc4e12b90908b1f2670258",
		"appId": "group",
		"hasPk": 1,
		"description": "",
		"createTime": "2021-04-06 21:24:12",
		"modifyTime": "2021-04-06 21:24:12"
	},
	"attachment": null
}
```


### 11.8 导出.pem私钥

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
| 1    | groupId     | String | 是     | 群组id                                                     |
| 2    | signUserId | string        | 是     | 用户的signUserId |
| 3 | p12Password | String | 否 |  |

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


### 11.9 导出.p12私钥

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
| 1    | groupId     | string | 是     | 群组id                                                     |
| 2    | signUserId | string        | 是     | 用户的signUserId |
| 3 | p12Password | string | 是 |  |

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
| 1    | groupId     | String      | 是     | 所属群组                           |
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
  "groupId": "string",
  "methodList": [
    {
      "abiInfo": "string",
      "methodId": "string",
      "methodType": "string"
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
| 1    | groupId     | String      | 是     | 所属群组                           |
| 2    | methodId    | String        | 是     | 方法编号                           |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/method/findById/group/add
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

### 13.1获取系统配置

根据群组id获取系统配置SystemConfig的list列表，目前只支持tx_count_limit, tx_gas_limit两个参数。


#### 13.1.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/sys/config/list**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.1.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | String   | 是     | 群组id      |
| 2   | pageSize   | int           | 是     ||
| 3    | pageNumber   | int           | 是     ||

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/sys/config/list?groupId=1&pageSize=10&pageNumber=1
```


#### 13.1.3 返回参数

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


### 13.2 设置系统配置

系统配置管理员设置系统配置，目前只支持tx_count_limit, tx_gas_limit两个参数。


#### 13.2.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/sys/config**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.2.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | String   | 是     | 群组id      |
| 2    | fromAddress     | String        | 是     | 管理员自己的地址|
| 3    | configKey     | String        | 是     | 目前类型两种(tx_count_limit， tx_gas_limit，用户可自定义key如tx_gas_price|
| 4    | configValue     | String        | 是     ||
| 5 | signUserId | String | 是 ||

​                          

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/sys/config
```

```
{
    "groupId": "group",
    "fromAddress": "0xd5bba8fe456fce310f529edecef902e4b63129b1",
    "configKey": "tx_count_limit",
    "configValue": "1001",
    "signUserId": "string"
}
```


#### 13.2.3 返回参数

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




### 13.3 获取节点列表(节点管理)

获取节点的list列表，包含节点id，节点共识状态。

注：接口返回所有的共识/观察节点（无论运行或停止），以及正在运行的游离节点

#### 13.3.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/precompiled/consensus/list**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.3.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | String   | 是     | 群组id    |
| 2   | pageSize   | int           | 是     ||
| 3    | pageNumber   | int           | 是     ||

​         

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/precompiled/consensus/list?groupId=1&pageSize=10&pageNumber=1
```


#### 13.3.3 返回参数

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

### 13.4 设置节点共识状态接口（节点管理）

节点管理相关接口，可用于节点三种共识状态的切换。分别是共识节点sealer, 观察节点observer, 游离节点remove


#### 13.4.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址： **/precompiled/consensus**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 13.4.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 必填 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | groupId     | String   | 否     | 群组id    |
| 2    | fromAddress     | String        | 否     | 管理员的地址    |
| 3    | nodeType     | String        | 否     | 节点类型：observer,sealer,remove  |
| 4    | nodeId     | String        | 否     | 节点id    |
| 5    | signUserId | String   | 是     | 签名用户ID |
| 6 | weight | int | 是 |  |


***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/precompiled/consensus
```

```
{
    "groupId": "group",
    "fromAddress": "0xd5bba8fe456fce310f529edecef902e4b63129b1",
    "nodeType": "remove",
    "nodeId": "224e6ee23e8a02d371298b9aec828f77cc2711da3a981684896715a3711885a3177b3cf7906bf9d1b84e597fad1e0049511139332c04edfe3daddba5ed60cffa",
    "signUserId": "string",
    "weight": 0
}
```


#### 13.4.3 返回参数

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
| 1    | groupId     | String | 是     | 群组编号                       |
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
| 1    | groupId     | String | 是     | 群组编号                       |
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
| 1        | 所属群组 | groupId | String    |              | 是        |                      |
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
    "groupId": "group",
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
| 1        | 所属群组 | groupId | String    |              | 是        |                      |

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
| 1        | 所属群组 | groupId | String    |              | 是        |                      |
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
        "groupId": "group",
        "contractName": "Hello3",
        "contractAddress": "0x7a754bb46418c93b4cec7dcc6fef0676ae6a1e32",
        "contractAbi": "",
        "contractBin": "",
        "createTime": "2020-11-06 15:12:51",
        "modifyTime": "2020-11-06 15:12:51"
    }
}
```

## 16 配置接口

### 16.1 查询是否使用国密

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


### 16.2 查询WeBASE-Node-Manager的版本

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

### 16.3 获取服务ip和端口

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

### 16.4 查询已部署合约是否支持修改

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


### 16.5 获取配置列表

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

## 17. 链上全量数据接口


### 17.1 查询链上全量私钥用户列表

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


### 17.2 查询链上全量合约列表

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

## 18. 预编译权限管理

### 18.1.查询治理委员信息(everyone可访问)

#### 接口描述

通过接口查询链的治理委员信息

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/authmanager/everyone/cmtInfo**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 群组Id   | groupId    | String   |              | 是       |          |

**2）数据格式**

```
http://127.0.0.1:5001/WeBASE-Node-Manager/precntauth/authmanager/everyone/cmtInfo?groupId=group0
```

#### 响应参数

**1）数据格式**

a、成功：

```
[
  {
    "governorList": [
      {
        "governorAddress": "0x015577ab8c903adcf9b65433f16e574d6daf0559",
        "weight": 1
      },
      {
        "governorAddress": "0x36c10bfbce3b6550ed92a5ebbb9a44e052bfd285",
        "weight": 2
      }
    ],
    "participatesRate": 100,
    "winRate": 90
  }
]
```

b、失败：

```
{
  "code": 500,
  "errorMessage": "get Client failed, e: The group not exist, please check the groupID, groupID: g3"
}
```

### 18.2. 查询合约管理员信息(everyone可访问)

#### 接口描述

通过接口查询某合约的管理员信息

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/authmanager/everyone/contract/admin**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**   | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ------------ | -------- | ------------ | -------- | -------- |
| 1        | 群组Id   | groupId      | String   |              | 是       |          |
| 2        | 合约地址 | contractAddr | String   |              | 是       |          |

**2）数据格式**

```
{
  "contractAddr": "0xB47fd49b0f1Af2Fce3a1824899b60C2b6A29B851",
  "groupId": "g1"
}
```

#### 响应参数

**1）数据格式**

a、成功：

```
0x489877b18f93353c67d252c1b8f4b745d41c2107
```

b、失败1，查询群组不存在：

```
{
  "code": 500,
  "errorMessage": "get Client failed, e: The group not exist, please check the groupID, groupID: g3"
}
```

​    失败2，查询合约地址错误：

```
{
  "code": 19,
  "errorMessage": "Call address error"
}
```

​    失败3，查询合约地址不存在：

```
0x0000000000000000000000000000000000000000
```

### 18.5. 查询合约函数访问权限(everyone可访问)

#### 接口描述

通过接口查询某用户对某合约函数的访问权限

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/authmanager/everyone/contract/method/auth**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**   | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ------------ | -------- | ------------ | -------- | -------- |
| 1        | 群组Id   | groupId      | String   |              | 是       |          |
| 2        | 合约地址 | contractAddr | String   |              | 是       |          |
| 3        | 合约函数 | func         | String   |              | 是       |          |
| 4        | 用户地址 | userAddress  | String   |              | 是       |          |

**2）数据格式**

```
{
  "contractAddr": "0xB47fd49b0f1Af2Fce3a1824899b60C2b6A29B851",
  "func": "set",
  "groupId": "g1",
  "userAddress": "0x489877b18f93353c67d252c1b8f4b745d41c2107"
}
```

#### 响应参数

**1）数据格式**

a、成功：

```
true
```

b、失败1，查询群组不存在：

```
{
  "code": 500,
  "errorMessage": "get Client failed, e: The group not exist, please check the groupID, groupID: g3"
}
```

   失败2，查询合约地址错误：

```
{
  "code": 19,
  "errorMessage": "Call address error"
}
```

### 18.6. 查询合约部署权限(everyone可访问)

#### 接口描述

通过接口查询全局合约部署权限

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/authmanager/everyone/deploy/type**

#### 调用方法

HTTP GET	

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 群组Id   | groupId    | String   |              | 是       |          |

**2）数据格式**

```
http://localhost:5001/WeBASE-Node-Manager/precntauth/authmanager/everyone/deploy/type?groupId=g1
```

#### 响应参数

**1）数据格式**

a、成功，可部署：

```
0
```

b、失败1，查询群组不存在：

```
{
  "code": 500,
  "errorMessage": "get Client failed, e: The group not exist, please check the groupID, groupID: g0"
}
```

### 18.7. 查询单一提案信息(everyone可访问)

#### 接口描述

通过接口查询某个提案信息

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/authmanager/everyone/proposalInfo**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型**   | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | ---------- | ------------ | -------- | -------- |
| 1        | 群组Id   | groupId    | String     |              | 是       |          |
| 2        | 提案Id   | proposalId | BigInteger |              | 是       |          |

**2）数据格式**

```
{
  "groupId": "g1",
  "proposalId": 1
}
```

#### 响应参数

**1）数据格式**

a、成功，可部署：

```
[
  {
    "resourceId": "0xc0523dbdd94ba27e14b0336d799489340ca24cdf",
    "proposer": "0x015577ab8c903adcf9b65433f16e574d6daf0559",
    "proposalType": 31,
    "blockNumberInterval": 604809,
    "status": 2,
    "agreeVoters": [
      "0x015577ab8c903adcf9b65433f16e574d6daf0559"
    ],
    "againstVoters": [],
    "statusString": "finished",
    "proposalTypeString": "resetAdmin"
  }
]
```

b、失败1，查询提案不存在：

```
[
  {
    "resourceId": "0x0000000000000000000000000000000000000000",
    "proposer": "0x0000000000000000000000000000000000000000",
    "proposalType": 0,
    "blockNumberInterval": 0,
    "status": 0,
    "agreeVoters": [],
    "againstVoters": [],
    "statusString": "unknown",
    "proposalTypeString": "unknown"
  }
]
```

### 18.8. 查询提案总数(everyone可访问)

#### 接口描述

通过接口查询某个提案信息

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/authmanager/everyone/proposalInfo**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 群组Id   | groupId    | String   |              | 是       |          |

**2）数据格式**

```
http://localhost:5001/WeBASE-Node-Manager/precntauth/authmanager/everyone/proposalInfoCount?groupId=g1
```

#### 响应参数

**1）数据格式**

a、成功：

```
5
```

b、失败1，查询提案不存在：

```
{
  "code": 500,
  "errorMessage": "get Client failed, e: The group not exist, please check the groupID, groupID: g0"
}
```

### 18.9. 查询提案列表(everyone可访问)

#### 接口描述

通过接口查询某群组提案列表

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/authmanager/everyone/proposalInfo**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明**   |
| -------- | -------- | ---------- | -------- | ------------ | -------- | ---------- |
| 1        | 群组Id   | groupId    | String   |              | 是       |            |
| 2        | 页面数   | pageNum    | Integer  |              | 是       | 所在页面   |
| 3        | 页面大小 | pageSize   | Integer  |              | 是       | 页面数据量 |

**2）数据格式**

```
http://localhost:5001/WeBASE-Node-Manager/precntauth/authmanager/everyone/proposalInfoList
```

#### 响应参数

**1）数据格式**

a、成功：

```
[
  {
    "resourceId": "0x02a6340ef1d8a780f0ddf01dde9141cc09f678d6",
    "proposer": "0x015577ab8c903adcf9b65433f16e574d6daf0559",
    "proposalType": "setWeight",
    "blockNumberInterval": 604825,
    "status": "notEnoughVotes",
    "agreeVoters": [
      "0x015577ab8c903adcf9b65433f16e574d6daf0559"
    ],
    "againstVoters": [],
    "proposalId": 5
  },
  {
    "resourceId": "0x36c10bfbce3b6550ed92a5ebbb9a44e052bfd285",
    "proposer": "0x36c10bfbce3b6550ed92a5ebbb9a44e052bfd285",
    "proposalType": "setWeight",
    "blockNumberInterval": 604812,
    "status": "failed",
    "agreeVoters": [
      "0x36c10bfbce3b6550ed92a5ebbb9a44e052bfd285"
    ],
    "againstVoters": [
      "0x015577ab8c903adcf9b65433f16e574d6daf0559"
    ],
    "proposalId": 4
  },
  {
    "resourceId": "0x0000000000000000000000000000000000010001",
    "proposer": "0x015577ab8c903adcf9b65433f16e574d6daf0559",
    "proposalType": "setRate",
    "blockNumberInterval": 604811,
    "status": "finished",
    "agreeVoters": [
      "0x015577ab8c903adcf9b65433f16e574d6daf0559"
    ],
    "againstVoters": [],
    "proposalId": 3
  },
  {
    "resourceId": "0x36c10bfbce3b6550ed92a5ebbb9a44e052bfd285",
    "proposer": "0x015577ab8c903adcf9b65433f16e574d6daf0559",
    "proposalType": "setWeight",
    "blockNumberInterval": 604810,
    "status": "finished",
    "agreeVoters": [
      "0x015577ab8c903adcf9b65433f16e574d6daf0559"
    ],
    "againstVoters": [],
    "proposalId": 2
  },
  {
    "resourceId": "0xc0523dbdd94ba27e14b0336d799489340ca24cdf",
    "proposer": "0x015577ab8c903adcf9b65433f16e574d6daf0559",
    "proposalType": "resetAdmin",
    "blockNumberInterval": 604809,
    "status": "finished",
    "agreeVoters": [
      "0x015577ab8c903adcf9b65433f16e574d6daf0559"
    ],
    "againstVoters": [],
    "proposalId": 1
  }
]
```

### 18.10. 查询用户全局部署权限(everyone可访问)

#### 接口描述

通过接口查询用户全局部署权限

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/authmanager/everyone/usr/deploy**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**  | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ----------- | -------- | ------------ | -------- | -------- |
| 1        | 群组Id   | groupId     | String   |              | 是       |          |
| 2        | 用户地址 | userAddress | String   |              | 是       |          |

**2）数据格式**

```
{
  "groupId": "g1",
  "userAddress": "0x489877b18f93353c67d252c1b8f4b745d41c2107"
}
```

#### 响应参数

**1）数据格式**

a、成功：

```
true
```

### 18.11. 设置合约的访问权限类型(admin可访问)

#### 接口描述

通过接口设置合约的访问权限类型

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/authmanager/admin/method/auth/type**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**   | **参数名**   | **类型** | **最大长度** | **必填** | **说明**           |
| -------- | ---------- | ------------ | -------- | ------------ | -------- | ------------------ |
| 1        | 群组Id     | groupId      | String   |              | 是       |                    |
| 2        | 调用地址   | fromAddress  | String   |              | 是       |                    |
| 3        | 合约地址   | contractAddr | String   |              | 是       |                    |
| 4        | 合约函数   | func         | String   |              | 是       |                    |
| 5        | 用户签名Id | signUserId   | String   |              | 否       |                    |
| 6        | 权限类型   | authType     | Integer  |              | 是       | 1.白名单；2.黑名单 |

**2）数据格式**

```
{
  "authType": 1,
  "contractAddr": "4721d1a77e0e76851d460073e64ea06d9c104194",
  "fromAddress": "0xe88ff54644de54fa32ac845c05ed2b7d5677c078",
  "func": "set",
  "groupId": "group0",
  "signUserId": ""
}
```

#### 响应参数

**1）数据格式**

a、成功：

```
{
  "code" : 0,
  "message" : "success",
  "data" : "Success"
}
```

### 18.12. 设置某用户对合约的访问权限(admin可访问)

#### 接口描述

通过接口设置某用户对合约函数的访问权限

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/authmanager/admin/method/auth/set**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**   | **类型** | **最大长度** | **必填** | **说明** |
| -------- | ------------ | ------------ | -------- | ------------ | -------- | -------- |
| 1        | 群组Id       | groupId      | String   |              | 是       |          |
| 2        | 调用地址     | fromAddress  | String   |              | 是       |          |
| 3        | 合约地址     | contractAddr | String   |              | 是       |          |
| 4        | 合约函数     | func         | String   |              | 是       |          |
| 5        | 用户签名Id   | signUserId   | String   |              | 否       |          |
| 6        | 是否开启权限 | isOpen       | Boolean  |              | 是       |          |

**2）数据格式**

```
{
  "contractAddr": "0xB47fd49b0f1Af2Fce3a1824899b60C2b6A29B851",
  "fromAddress": "0x489877b18f93353c67d252c1b8f4b745d41c2107",
  "func": "set",
  "groupId": "g1",
  "isOpen": true,
  "signUserId": "string",
  "userAddress": "0x489877b18f93353c67d252c1b8f4b745d41c2107"
}
```

#### 响应参数

**1）数据格式**

a、成功：

```
{
  "code" : 0,
  "message" : "success",
  "data" : "Success"
}
```

### 18.13. 设置某合约的管理员(committee可访问)

#### 接口描述

通过接口设置某合约的管理员

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/authmanager/committee/contract/admin**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**     | **参数名**   | **类型** | **最大长度** | **必填** | **说明** |
| -------- | ------------ | ------------ | -------- | ------------ | -------- | -------- |
| 1        | 群组Id       | groupId      | String   |              | 是       |          |
| 2        | 调用地址     | fromAddress  | String   |              | 是       |          |
| 3        | 合约地址     | contractAddr | String   |              | 是       |          |
| 4        | 合约新管理员 | newAdmin     | String   |              | 是       |          |
| 5        | 用户签名Id   | signUserId   | String   |              | 否       |          |

**2）数据格式**

```
{
  "contractAddr": "4721d1a77e0e76851d460073e64ea06d9c104194",
  "fromAddress": "0x70da1da76e0e423ec582ec866fae749af67ec4c0",
  "groupId": "group0",
  "newAdmin": "0x70da1da76e0e423ec582ec866fae749af67ec4c0",
  "signUserId": ""
}
```

#### 响应参数

**1）数据格式**

a、成功：

```
{
  "code" : 0,
  "message" : "success",
  "data" : "Success"
}
```

### 18.14. 设置全局部署权限类型(committee可访问)

#### 接口描述

通过接口设置全局部署类型

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/authmanager/committee/deploy/type**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**   | **参数名**     | **类型** | **最大长度** | **必填** | **说明**           |
| -------- | ---------- | -------------- | -------- | ------------ | -------- | ------------------ |
| 1        | 群组Id     | groupId        | String   |              | 是       |                    |
| 2        | 调用地址   | fromAddress    | String   |              | 是       |                    |
| 3        | 部署类型   | deployAuthType | Integer  |              | 是       | 1.白名单；2.黑名单 |
| 4        | 用户签名Id | signUserId     | String   |              | 否       |                    |

**2）数据格式**

```
{
  "deployAuthType":1,
  "fromAddress": "0x70da1da76e0e423ec582ec866fae749af67ec4c0",
  "groupId": "group0",
  "signUserId": ""
}
```

#### 响应参数

**1）数据格式**

a、成功：

```
{
  "code" : 0,
  "message" : "success",
  "data" : "Success"
}
```

### 18.15. 设置治理委员账户(committee可访问)

#### 接口描述

通过接口设置治理委员(新增/更新/删除)

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/authmanager/committee/governor**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**   | **参数名**     | **类型** | **最大长度** | **必填** | **说明**         |
| -------- | ---------- | -------------- | -------- | ------------ | -------- | ---------------- |
| 1        | 群组Id     | groupId        | String   |              | 是       |                  |
| 2        | 调用地址   | fromAddress    | String   |              | 是       |                  |
| 3        | 账户地址   | accountAddress | Integer  |              | 是       | 对该账户进行操作 |
| 4        | 分配权重   | weight         | Integer  |              | 是       |                  |
| 5        | 用户签名Id | signUserId     | String   |              | 否       |                  |

**2）数据格式**

```
{
  "accountAddress": "0xe88ff54644de54fa32ac845c05ed2b7d5677c078",
  "fromAddress": "0x70da1da76e0e423ec582ec866fae749af67ec4c0",
  "groupId": "group0",
  "signUserId": "",
  "weight": 5
}
```

#### 响应参数

**1）数据格式**

a、成功：

```
{
  "code" : 0,
  "message" : "success",
  "data" : "Success"
}
```

### 18.16. 设置治理阈值(committee可访问)

#### 接口描述

通过接口设置治理阈值

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/authmanager/committee/rate**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**   | **参数名**       | **类型** | **最大长度** | **必填** | **说明** |
| -------- | ---------- | ---------------- | -------- | ------------ | -------- | -------- |
| 1        | 群组Id     | groupId          | String   |              | 是       |          |
| 2        | 调用地址   | fromAddress      | String   |              | 是       |          |
| 3        | 参与阈值   | participatesRate | Integer  |              | 是       |          |
| 4        | 获胜阈值   | winRate          | Integer  |              | 是       |          |
| 5        | 用户签名Id | signUserId       | String   |              | 否       |          |

**2）数据格式**

```
{
  "fromAddress": "0x70da1da76e0e423ec582ec866fae749af67ec4c0",
  "groupId": "group0",
  "participatesRate": 51,
  "signUserId": "",
  "winRate": 51
}
```

#### 响应参数

**1）数据格式**

```
{
  "code" : 0,
  "message" : "success",
  "data" : "Success"
}
```

### 18.17. 对提案投票(committee可访问)

#### 接口描述

通过接口设置对提案进行投票

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/authmanager/committee/proposal/vote**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**   | **参数名**  | **类型** | **最大长度** | **必填** | **说明** |
| -------- | ---------- | ----------- | -------- | ------------ | -------- | -------- |
| 1        | 群组Id     | groupId     | String   |              | 是       |          |
| 2        | 调用地址   | fromAddress | String   |              | 是       |          |
| 3        | 提案Id     | proposalId  | Integer  |              | 是       |          |
| 4        | 是否同意   | agree       | Boolean  |              | 是       |          |
| 5        | 用户签名Id | signUserId  | String   |              | 否       |          |

**2）数据格式**

```
{
  "agree": true,
  "fromAddress": "0x70da1da76e0e423ec582ec866fae749af67ec4c0",
  "groupId": "group0",
  "proposalId": 55,
  "signUserId": "5db5a98aef544650aa3864f4cb27af31"
}
```

#### 响应参数

**1）数据格式**

```
{
  "code" : 0,
  "message" : "success",
  "data" : "Success"
}
```

### 18.18.撤销提案(committee可访问)

#### 接口描述

通过接口设置撤销某提案

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/authmanager/committee/proposal/revoke**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**   | **参数名**  | **类型** | **最大长度** | **必填** | **说明** |
| -------- | ---------- | ----------- | -------- | ------------ | -------- | -------- |
| 1        | 群组Id     | groupId     | String   |              | 是       |          |
| 2        | 调用地址   | fromAddress | String   |              | 是       |          |
| 3        | 提案Id     | proposalId  | Integer  |              | 是       |          |
| 4        | 用户签名Id | signUserId  | String   |              | 否       |          |

**2）数据格式**

```
{
  "fromAddress": "0x70da1da76e0e423ec582ec866fae749af67ec4c0",
  "groupId": "group0",
  "proposalId": 55,
  "signUserId": "5db5a98aef544650aa3864f4cb27af31"
}
```

#### 响应参数

**1）数据格式**

```
{
  "code" : 0,
  "message" : "success",
  "data" : "Success"
}
```

## 19. 预编译合约管理


### 19.1. 创建BFS路径

#### 接口描述

通过接口创建BFS

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/precompiled/bfs/create**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文**   | **参数名**  | **类型** | **最大长度** | **必填** | **说明** |
| -------- | ---------- | ----------- | -------- | ------------ | -------- | -------- |
| 1        | 群组Id     | groupId     | String   |              | 是       |          |
| 2        | 调用地址   | fromAddress | String   |              | 是       |          |
| 3        | 创建路径   | path        | String   |              | 是       |          |
| 4        | 用户签名Id | signUserId  | String   |              | 否       |          |

**2）数据格式**

```
{
  "fromAddress": "0x2abd2fc35c4553b1f1aa6cf70a4e6ef30b4d53a2",
  "groupId": "group0",
  "path": "/apps/test9",
  "signUserId": "5db5a98aef544650aa3864f4cb27af31"
}
```

#### 响应参数

```
{
  "code" : 0,
  "message" : "success",
  "data" : "Success"
}
```

### 19.2. 查询BFS路径

#### 接口描述

通过接口查询BFS

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/precompiled/bfs/query**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 群组Id   | groupId    | String   |              | 是       |          |
| 2        | 查询路径 | path       | String   |              | 是       |          |

**2）数据格式**

```
{
  "groupId": "group0",
  "path": "/apps"
}
```

#### 响应参数

```
[
  "test",
  "test1"
]
```

### 19.3. 通过contractName查询合约信息

#### 接口描述

通过groupId和contractName查询合约信息

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/precompiled/cns/queryCnsByName**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**   | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ------------ | -------- | ------------ | -------- | -------- |
| 1        | 群组Id   | groupId      | String   |              | 是       |          |
| 2        | 合约名称 | contractName | String   |              | 是       |          |

**2）数据格式**

```
{
  "contractName": "HelloWorld",
  "groupId": "group0"
}
```

#### 响应参数

```
[
  {
    "name": "HelloWorld",
    "version": "1.0",
    "address": "4721d1a77e0e76851d460073e64ea06d9c104194",
    "abi": "[{\"inputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"},{\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"internalType\":\"string\",\"name\":\"\",\"type\":\"string\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"string\",\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"}]"
  },
  {
    "name": "HelloWorld",
    "version": "2.0",
    "address": "4721d1a77e0e76851d460073e64ea06d9c104194",
    "abi": "[{\"inputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"},{\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"internalType\":\"string\",\"name\":\"\",\"type\":\"string\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"string\",\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"}]"
  }
]
```

### 19.4. 通过contractName和version查询合约信息

#### 接口描述

通过groupId、contractName、version查询合约信息

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/precompiled/cns/queryCnsByNameVersion**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**   | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ------------ | -------- | ------------ | -------- | -------- |
| 1        | 群组Id   | groupId      | String   |              | 是       |          |
| 2        | 合约名称 | contractName | String   |              | 是       |          |
| 3        | 合约版本 | version      | String   |              | 是       |          |

**2）数据格式**

```
{
  "contractName": "HelloWorld",
  "groupId": "group0",
  "version": "1.0"
}
```

#### 响应参数

```
{
  "address": "0x4721d1a77e0e76851d460073e64ea06d9c104194",
  "abi": "[{\"inputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"},{\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"internalType\":\"string\",\"name\":\"\",\"type\":\"string\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"string\",\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"}]"
}
```

### 19.5. 通过contractName/groupId/version查询合约地址

#### 接口描述

通过contractName/groupId/version参数查询合约地址

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/precompiled/cns/queryCnsByNameVersion**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**   | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ------------ | -------- | ------------ | -------- | -------- |
| 1        | 群组Id   | groupId      | String   |              | 是       |          |
| 2        | 合约名称 | contractName | String   |              | 是       |          |
| 3        | 合约版本 | version      | String   |              | 是       |          |

**2）数据格式**

```
{
  "contractName": "HelloWorld",
  "groupId": "group0",
  "version": "1.0"
}
```

#### 响应参数

```
0x4721d1a77e0e76851d460073e64ea06d9c104194
```

### 19.6. 注册合约

#### 接口描述

通过接口注册合约信息

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/precompiled/cns/reqAddressInfoByNameVersion**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**   | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ------------ | -------- | ------------ | -------- | -------- |
| 1        | 群组Id   | groupId      | String   |              | 是       |          |
| 2        | 合约名称 | contractName | String   |              | 是       |          |
| 3        | 合约版本 | version      | String   |              | 是       |          |

**2）数据格式**

```
{
  "abiData": "[{\"inputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"},{\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"internalType\":\"string\",\"name\":\"\",\"type\":\"string\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"string\",\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"}]",
  "contractAddress": "4721d1a77e0e76851d460073e64ea06d9c104194",
  "contractName": "HelloWorld",
  "contractVersion": "1.0",
  "fromAddress": "",
  "groupId": "group0",
  "signUserId": "5db5a98aef544650aa3864f4cb27af31"
}
```

#### 响应参数

```
{
  "code" : 0,
  "message" : "success",
  "data" : "Success"
}
```

### 19.7. 查询共识节点列表

#### 接口描述

通过接口查询共识节点列表

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/precompiled/consensus/list**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 群组Id   | groupId    | String   |              | 是       |          |
| 2        | 页面数   | pageNumber | Integer  |              | 是       |          |
| 3        | 页面大小 | pageSize   | Integer  |              | 是       |          |

**2）数据格式**

```
{
  "groupId": "group0",
  "pageNumber": 1,
  "pageSize": 5
}
```

#### 响应参数

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "nodeId": "6447e978505cafd05fc99b731d8fdff31fb07a3c6e9679054fb1880ae6f58aeff638eacfe082d54adca93086c2986bc27a5befeabb7ba39728e24c7da9c786e9",
      "nodeType": "sealer",
      "weight": 1
    },
    {
      "nodeId": "b14bd4a225db308da3f395c69f12ce06f191ff19941d52eebf30cfb5fc979422ad086fedb0378fdcfbcb4630416e71c34aeb421f4fe51792408283bfd7338099",
      "nodeType": "sealer",
      "weight": 1
    },
    {
      "nodeId": "848883c435d5c7e32da7744ffb0659538995994a42c24ec7da81a2fd58cd28e76fbaaf603b81f9134d22f57d112cdbd701cece549121b99f5e436daec11b3267",
      "nodeType": "sealer",
      "weight": 1
    },
    {
      "nodeId": "5007b294c7aadd22d62e0c5e33bae14ee6ec0230ebd34df23f29f0330272f6021fd3a8f2b4a4789f1e2fe7fbc8581c1d371883d9eb1e16a9266905f36d57ab8b",
      "nodeType": "sealer",
      "weight": 1
    }
  ],
  "totalCount": 4
}
```

### 19.8. 修改共识节点类型

#### 接口描述

通过接口查询共识节点列表

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/precompiled/consensus/manage**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**  | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ----------- | -------- | ------------ | -------- | -------- |
| 1        | 群组Id   | groupId     | String   |              | 是       |          |
| 2        | 调用地址 | fromAddress | String   |              | 是       |          |
| 3        | 节点Id   | nodeId      | String   |              | 是       |          |
| 4        | 节点类型 | nodeType    | String   |              | 是       |          |
| 5        | 签名Id   | signUserId  | String   |              | 否       |          |
| 6        | 权重     | weight      | Integer  |              | 是       |          |

**2）数据格式**

```
{
  "fromAddress": "0x2abd2fc35c4553b1f1aa6cf70a4e6ef30b4d53a2",
  "groupId": "group0",
  "nodeId": "5007b294c7aadd22d62e0c5e33bae14ee6ec0230ebd34df23f29f0330272f6021fd3a8f2b4a4789f1e2fe7fbc8581c1d371883d9eb1e16a9266905f36d57ab8b",
  "nodeType": "observer",
  "signUserId": "5db5a98aef544650aa3864f4cb27af31",
  "weight": 1
}
```

#### 响应参数

```
{
  "code" : 0,
  "message" : "success",
  "data" : "Success"
}
```

### 19.9. 建表

#### 接口描述

通过接口插入新的表结构

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/precompiled/kvtable/reqCreateTable**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**   | **类型** | **最大长度** | **必填** | **说明**     |
| -------- | -------- | ------------ | -------- | ------------ | -------- | ------------ |
| 1        | 群组Id   | groupId      | String   |              | 是       |              |
| 2        | 调用地址 | fromAddress  | String   |              | 是       |              |
| 3        | 主键     | keyFieldName | String   |              | 是       |              |
| 4        | 值描述   | valueFields  | List     |              | 是       | 对表进行描述 |
| 5        | 签名Id   | signUserId   | String   |              | 否       |              |
| 6        | 表名     | tableName    | String   |              | 是       |              |

**2）数据格式**

```
{
  "fromAddress": "0x2abd2fc35c4553b1f1aa6cf70a4e6ef30b4d53a2",
  "groupId": "group0",
  "keyFieldName": "myKey",
  "signUserId": "5db5a98aef544650aa3864f4cb27af31",
  "tableName": "test_table",
  "valueFields": [
    "valueIsData"
  ]
}
```

#### 响应参数

```
{
  "code" : 0,
  "message" : "success",
  "data" : "Success"
}
```

### 19.10. 写表

#### 接口描述

通过接口在表插入数据

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/precompiled/kvtable/reqSetTable**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**       | **类型** | **最大长度** | **必填** | **说明**   |
| -------- | -------- | ---------------- | -------- | ------------ | -------- | ---------- |
| 1        | 群组Id   | groupId          | String   |              | 是       |            |
| 2        | 调用地址 | fromAddress      | String   |              | 是       |            |
| 3        | 主键     | key              | String   |              | 是       |            |
| 4        | 对应值   | fieldNameToValue | JSON     |              | 是       | 写入JSON值 |
| 5        | 签名Id   | signUserId       | String   |              | 否       |            |
| 6        | 表名     | tableName        | String   |              | 是       |            |

**2）数据格式**

```
{
  "fieldNameToValue": {
    "key1": "hi",
    "key2": "hello",
    "key3": "how are u"
  },
  "fromAddress": "0x2abd2fc35c4553b1f1aa6cf70a4e6ef30b4d53a2",
  "groupId": "group0",
  "key": "myKey",
  "signUserId": "5db5a98aef544650aa3864f4cb27af31",
  "tableName": "test_table"
}
```

#### 响应参数

```
{
  "code" : 0,
  "message" : "success",
  "data" : "Success"
}
```

### 19.11. 读表

#### 接口描述

通过接口在表读取数据

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/precompiled/kvtable/reqGetTable**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**       | **类型** | **最大长度** | **必填** | **说明**   |
| -------- | -------- | ---------------- | -------- | ------------ | -------- | ---------- |
| 1        | 群组Id   | groupId          | String   |              | 是       |            |
| 2        | 调用地址 | fromAddress      | String   |              | 是       |            |
| 3        | 主键     | key              | String   |              | 是       |            |
| 4        | 对应值   | fieldNameToValue | JSON     |              | 是       | 写入JSON值 |
| 5        | 签名Id   | signUserId       | String   |              | 否       |            |
| 6        | 表名     | tableName        | String   |              | 是       |            |

**2）数据格式**

```
{
  "groupId": "group0",
  "key": "myKey",
  "tableName": "test_table"
}
```

#### 响应参数

```
{
  "key2": "hello",
  "key1": "hi",
  "key3": "how are u"
}
```

### 19.12. 获取群组系统配置

#### 接口描述

通过接口读取某个群组的系统配置

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/precompiled/sys/config/list**

#### 调用方法

HTTP GET

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名** | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ---------- | -------- | ------------ | -------- | -------- |
| 1        | 群组Id   | groupId    | String   |              | 是       |          |

**2）数据格式**

```
http://127.0.0.1:5001/WeBASE-Node-Manager/precntauth/precompiled/sys/config/list?groupId=group0
```

#### 响应参数

```
[
  {
    "groupId": "group0",
    "configKey": "tx_count_limit",
    "configValue": "10"
  },
  {
    "groupId": "group0",
    "configKey": "tx_gas_limit",
    "configValue": "300000002"
  }
]
```

### 19.13. 设置群组系统配置

#### 接口描述

通过接口设置某个群组的系统配置

#### 接口URL

**http://localhost:5001/WeBASE-Node-Manager/precntauth/precompiled/sys/config/list**

#### 调用方法

HTTP POST

#### 请求参数

**1）参数表**

| **序号** | **中文** | **参数名**  | **类型** | **最大长度** | **必填** | **说明** |
| -------- | -------- | ----------- | -------- | ------------ | -------- | -------- |
| 1        | 群组Id   | groupId     | String   |              | 是       |          |
| 2        | 调用地址 | fromAddress | String   |              | 是       |          |
| 3        | 配置主键 | configKey   | String   |              | 是       |          |
| 4        | 配置值   | configValue | String   |              | 是       |          |
| 5        | 签名Id   | signUserId  | String   |              | 否       |          |

**2）数据格式**

```
{
  "configKey": "tx_count_limit",
  "configValue": "5",
  "fromAddress": "0x2abd2fc35c4553b1f1aa6cf70a4e6ef30b4d53a2",
  "groupId": "group0",
  "signUserId": "5db5a98aef544650aa3864f4cb27af31"
}
```

#### 响应参数

```
{
  "code" : 0,
  "message" : "success",
  "data" : "Success"
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

