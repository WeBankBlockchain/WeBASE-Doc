
# WeBASE-Data-Collect接口说明

## 1 区块链管理模块

### 1.1 新增链信息

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址： **/chain/new**
- 请求方式：POST
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型   | 可为空 | 备注                           |
| ---- | ----------- | ------ | ------ | ------------------------------ |
| 1    | chainId     | Int    | 否     | 链编号（1~9999）               |
| 2    | chainName   | String | 否     | 链名称                         |
| 3    | encryptType | Int    | 否     | 链加密类型（0-非国密，1-国密） |
| 4    | description | String | 是     | 备注                           |

***2）入参示例***

```
http://localhost:5009/WeBASE-Data-Collect/chain/new
```

```
{
    "chainId": 1,
    "chainName": "链一",
    "encryptType": 0,
    "description": "test"
}
```

####  返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |      | 备注                           |
| ---- | ----------- | ------------- | ---- | ------------------------------ |
| 1    | code        | Int           | 否   | 返回码，0：成功 其它：失败     |
| 2    | message     | String        | 否   | 描述                           |
| 3    |             | Object        |      | 节点信息对象                   |
| 3.1  | chainId     | Int           | 否   | 链编号                         |
| 3.2  | chainName   | String        | 否   | 链名称                         |
| 3.3  | chainType   | Int           | 否   | 链类型（ 0-fisco 1-fabric）    |
| 3.4  | encryptType | Int           | 否   | 链加密类型（0-非国密，1-国密） |
| 3.5  | description | String        | 是   | 备注                           |
| 3.6  | createTime  | LocalDateTime | 否   | 落库时间                       |
| 3.7  | modifyTime  | LocalDateTime | 否   | 修改时间                       |

***2）出参示例***

- 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "chainId": 1,
        "chainName": "链一",
        "chainType": 0,
        "encryptType": 0,
        "description": "test"
        "createTime": "2019-02-14 17:47:00",
        "modifyTime": "2019-03-15 11:14:29"
    }
}
```

- 失败：

```
{
    "code": 209001,
    "message": "chain id already exists",
    "data": {}
}
```

### 1.2 修改链信息

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址： **/chain/update**
- 请求方式：POST
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型   | 可为空 | 备注   |
| ---- | ----------- | ------ | ------ | ------ |
| 1    | chainId     | Int    | 否     | 链编号 |
| 2    | chainName   | String | 否     | 链名称 |
| 3    | description | String | 是     | 备注   |

***2）入参示例***

```
http://localhost:5009/WeBASE-Data-Collect/chain/update
```

```
{
    "chainId": 1,
    "chainName": "链一",
    "description": "test"
}
```

####  返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |      | 备注                           |
| ---- | ----------- | ------------- | ---- | ------------------------------ |
| 1    | code        | Int           | 否   | 返回码，0：成功 其它：失败     |
| 2    | message     | String        | 否   | 描述                           |
| 3    |             | Object        |      | 节点信息对象                   |
| 3.1  | chainId     | Int           | 否   | 链编号                         |
| 3.2  | chainName   | String        | 否   | 链名称                         |
| 3.3  | chainType   | Int           | 否   | 链类型（ 0-fisco 1-fabric）    |
| 3.4  | encryptType | Int           | 否   | 链加密类型（0-非国密，1-国密） |
| 3.5  | description | String        | 是   | 备注                           |
| 3.6  | createTime  | LocalDateTime | 否   | 落库时间                       |
| 3.7  | modifyTime  | LocalDateTime | 否   | 修改时间                       |

***2）出参示例***

- 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "chainId": 1,
        "chainName": "链一",
        "chainType": 0,
        "encryptType": 0,
        "description": "test"
        "createTime": "2019-02-14 17:47:00",
        "modifyTime": "2019-03-15 11:14:29"
    }
}
```

- 失败：

```
{
    "code": 209006,
    "message": "chain id not exists",
    "data": {}
}
```

### 1.3 获取链列表 

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
http://localhost:5009/WeBASE-Data-Collect/chain/all
```

#### 返回参数 

***1）出参表***

| 序号  | 输出参数    | 类型          |      | 备注                           |
| ----- | ----------- | ------------- | ---- | ------------------------------ |
| 1     | code        | Int           | 否   | 返回码，0：成功 其它：失败     |
| 2     | message     | String        | 否   | 描述                           |
| 3     | totalCount  | Int           | 否   | 总记录数                       |
| 4     | data        | List          | 否   | 组织列表                       |
| 4.1   |             | Object        |      | 节点信息对象                   |
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
   "code": 109000,
   "message": "system exception",
   "data": {}
}
```

### 1.4 删除链信息

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/chain/{chainId}**
- 请求方式：DELETE
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型 | 可为空 | 备注   |
| ---- | -------- | ---- | ------ | ------ |
| 1    | chainId  | Int  | 否     | 链编号 |

***2）入参示例***

```
http://localhost:5009/WeBASE-Data-Collect/chain/1
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
    "data": {},
    "message": "success"
}
```

- 失败：

```
{
    "code": 209004,
    "message": "invalid chain id",
    "data": {}
}
```

### 1.5 查询数据拉取开关

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/chain/togglePullData**
- 请求方式：GET
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 请求参数

***1）入参表***

无

***2）入参示例***

```
http://localhost:5009/WeBASE-Data-Collect/chain/togglePullData
```

#### 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data     | object | 是   | 信息对象                   |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": true
}
```

- 失败：

```
{
    "code": 109000,
    "message": "system exception",
    "data": {}
}
```

### 1.6 修改数据拉取开关

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址： **/chain/update**
- 请求方式：POST
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型    | 可为空 | 备注                                  |
| ---- | -------- | ------- | ------ | ------------------------------------- |
| 1    | enable   | boolean | 否     | 是否启用开关（true-开启；false-关闭） |

***2）入参示例***

```
http://localhost:5009/WeBASE-Data-Collect/chain/togglePullData
```

```
{
  "enable": false
}
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data     | object | 是   | 信息对象                   |

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
    "code": 109000,
    "message": "system exception",
    "data": {}
}
```

## 2 前置管理模块

### 2.1 新增节点前置


#### 传输协议
* 网络传输协议：使用HTTP协议
* 请求地址： **/front/new**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数  | 类型   | 可为空 | 备注         |
| ---- | --------- | ------ | ------ | ------------ |
| 1    | chainId   | Int    | 否     | 链编号       |
| 2    | frontIp   | String | 否     | 前置ip       |
| 3    | frontPort | Int    | 否     | 前置服务端口 |
| 4    | agency    | Int    | 否     | 所属机构     |

***2）入参示例***

```
http://localhost:5009/WeBASE-Data-Collect/front/new
```

```
{
    "chainId": 1,
    "frontIp": "localhost",
    "frontPort": "5002",
    "agency": "test"
}
```


#### 返回参数

***1）出参表***

| 序号 | 输出参数   | 类型          | 可为空 | 备注                       |
| ---- | ---------- | ------------- | ------ | -------------------------- |
| 1    | code       | Int           | 否     | 返回码，0：成功 其它：失败 |
| 2    | message    | String        | 否     | 描述                       |
| 3    |            | Object        |        | 节点信息对象               |
| 3.1  | frontId    | Int           | 否     | 前置编号                   |
| 3.2  | chainId    | Int           | 否     | 链编号                     |
| 3.3  | frontIp    | String        | 否     | 前置ip                     |
| 3.4  | frontPort  | Int           | 否     | 前置端口                   |
| 3.5  | nodeId     | String        | 否     | 节点编号                   |
| 3.6  | agency     | String        | 否     | 所属机构                   |
| 3.7  | createTime | LocalDateTime | 是     | 落库时间                   |
| 3.8  | modifyTime | LocalDateTime | 是     | 修改时间                   |

***2）出参示例***
* 成功：
```
{
  "code": 0,
  "message": "success",
  "data": {
    "chainId": 1,
    "frontId": 1,
    "nodeId": "944607f7e83efe2ba72476dc39a269a910811db8caac34f440dd9c9dd8ec2490b8854b903bd6c9b95c2c79909649977b8e92097c2f3ec32232c4f655b5a01850",
    "frontIp": "localhost",
    "frontPort": 5002,
    "agency": "test",
    "createTime": null,
    "modifyTime": null
  }
}
```

* 失败：
```
{
    "code": 109000,
    "message": "system exception",
    "data": {}
}
```


### 2.2 获取所有前置列表 


#### 传输协议
* 网络传输协议：使用HTTP协议
* 请求地址：**/front/list?chainId={chainId}?frontId={frontId}&groupId={groupId}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 可为空 | 备注                 |
|------|-------------|---------------|--------|-------------------------------|
| 1 | chainId | Int | 是 | 链编号 |
| 2     | frontId       | Int           | 是     | 前置编号                  |
| 3    | groupId       | Int           | 是     | 群组编号                |


***2）入参示例***

```
http://localhost:5009/WeBASE-Data-Collect/front/list
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
| 4.1.1 | frontId       | Int           | 否     | 前置编号                   |
| 4.1.2 | chainId | Int | 否 | 链编号 |
| 4.1.3 | frontIp       | String        | 否     | 前置ip                     |
| 4.1.4 | frontPort     | Int           | 否     | 前置端口                   |
| 4.1.5 | nodeId | String | 否 | 节点编号 |
| 4.1.6 | agency | String | 否 | 所属机构 |
| 4.1.7 | createTime    | LocalDateTime | 否     | 落库时间                   |
| 4.1.8 | modifyTime    | LocalDateTime | 否     | 修改时间                   |

***2）出参示例***
* 成功：
```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "chainId": 1,
      "frontId": 1,
      "nodeId": "944607f7e83efe2ba72476dc39a269a910811db8caac34f440dd9c9dd8ec2490b8854b903bd6c9b95c2c79909649977b8e92097c2f3ec32232c4f655b5a01850",
      "frontIp": "localhost",
      "frontPort": 5002,
      "agency": "test",
      "createTime": "2020-05-20 20:22:35",
      "modifyTime": "2020-05-20 20:22:35"
    }
  ],
  "totalCount": 1
}
```

* 失败：
```
{
   "code": 109000,
   "message": "system exception",
   "data": {}
}
```


### 2.3 删除前置信息

#### 传输协议
* 网络传输协议：使用HTTP协议
* 请求地址：**/front/{frontId}**
* 请求方式：DELETE
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 可为空 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | frontId    | Int    | 否     | 前置编号                   |


***2）入参示例***

```
http://localhost:5009/WeBASE-Data-Collect/front/1
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code       | Int    | 否     | 返回码，0：成功 其它：失败 |
| 2    | message    | String | 否     | 描述                       |
| 3    | data       | object | 是     | 返回信息实体（空）         |


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
    "code": 109000,
    "message": "system exception",
    "data": {}
}
```

## 3 群组管理模块

### 3.1 获取群组列表

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/group/list/{chainId}**
- 请求方式：GET
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型 | 可为空 | 备注   |
| ---- | -------- | ---- | ------ | ------ |
| 1    | chainId  | Int  | 否     | 链编号 |

***2）入参示例***

```
http://localhost:5009/WeBASE-Data-Collect/group/list/1
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
| 4.1.5  | appSummary      | String        | 是   | 应用概要介绍               |
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
    "code": 109000,
    "message": "system exception",
    "data": {}
}
```

### 3.2 修改群组对应的应用信息

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址： **/group/update**
- 请求方式：POST
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型   | 可为空 | 备注         |
| ---- | ----------- | ------ | ------ | ------------ |
| 1    | chainId     | Int    | 否     | 链编号       |
| 2    | groupId     | Int    | 否     | 群组编号     |
| 3    | appName     | String | 是     | 应用名称     |
| 4    | appVersion  | String | 是     | 应用版本号   |
| 5    | appSummary | String | 是     | 应用概要介绍 |
| 6    | description | String | 是     | 应用描述     |

***2）入参示例***

```
http://localhost:5009/WeBASE-Data-Collect/group/update
```

```
{
    "chainId": 1,
    "groupId": 1,
    "appName": "存证",
    "appVersion": "v1.0.0",
    "appSummary": "存证测试",
    "description": "这是一个存证应用"
}
```

####  返回参数

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data     | Object |      |                            |

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
    "code": 109000,
    "message": "system exception",
    "data": {}
}
```

## 4 节点管理模块

### 4.1 查询群组节点列表

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/node/list/{chainId}/{groupId}/{pageNumber}/{pageSize}**
- 请求方式：GET
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型   | 可为空 | 备注       |
| ---- | ---------- | ------ | ------ | ---------- |
| 1    | chainId    | Int    | 否     | 链编号     |
| 2    | groupId    | Int    | 否     | 群组编号   |
| 3    | pageSize   | Int    | 否     | 每页记录数 |
| 4    | pageNumber | Int    | 否     | 当前页码   |
| 5    | nodeId     | String | 是     | 节点编号   |

***2）入参示例***

```
http://localhost:5009/WeBASE-Data-Collect/node/nodeList/100001/300001/1/10
```

#### 返回参数 

***1）出参表***

| 序号   | 输出参数    | 类型          |      | 备注                       |
| ------ | ----------- | ------------- | ---- | -------------------------- |
| 1      | code        | Int           | 否   | 返回码，0：成功 其它：失败 |
| 2      | message     | String        | 否   | 描述                       |
| 3      | totalCount  | Int           | 否   | 总记录数                   |
| 4      | data        | List          | 是   | 节点列表                   |
| 4.1    |             | Object        |      | 节点信息对象               |
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
    "code": 109000,
    "message": "system exception",
    "data": {}
}
```

### 4.2 查询机构节点列表

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/node/orgList/{chainId}/{pageNumber}/{pageSize}**
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
http://localhost:5009/WeBASE-Data-Collect/node/orgList/100001/1/10
```

#### 返回参数 

***1）出参表***

| 序号  | 输出参数    | 类型   |      | 备注                       |
| ----- | ----------- | ------ | ---- | -------------------------- |
| 1     | code        | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2     | message     | String | 否   | 描述                       |
| 3     | totalCount  | Int    | 否   | 总记录数                   |
| 4     | data        | List   | 是   | 节点列表                   |
| 4.1   |             | Object |      | 节点信息对象               |
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
    "code": 109000,
    "message": "system exception",
    "data": {}
}
```

### 4.3 修改节点的机构信息

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址： **/node/update**
- 请求方式：POST
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型   | 可为空 | 备注     |
| ---- | ----------- | ------ | ------ | -------- |
| 1    | chainId     | Int    | 否     | 链编号   |
| 2    | nodeId      | String | 否     | 节点编号 |
| 3    | orgName     | String | 否     | 机构名称 |
| 4    | description | String | 是     | 描述     |

***2）入参示例***

```
http://localhost:5009/WeBASE-Data-Collect/node/update
```

```
{
    "chainId": 1,
    "nodeId": "78e467957af3d0f77e19b952a740ba8c53ac76913df7dbd48d7a0fe27f4c902b55e8543e1c4f65b4a61695c3b490a5e8584149809f66e9ffc8c05b427e9d3ca2",
    "orgName": "org",
    "description": "test"
}
```

####  返回参数

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data     | Object |      |                            |

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
    "code": 109000,
    "message": "system exception",
    "data": {}
}
```

## 5 用户管理模块

### 5.1 新增用户

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址： **/user/add**
- 请求方式：POST
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型   | 可为空 | 备注     |
| ---- | ----------- | ------ | ------ | -------- |
| 1    | chainId     | Int    | 否     | 链编号   |
| 2    | groupId     | Int    | 否     | 群组编号 |
| 3    | userName    | String | 否     | 用户名   |
| 4    | address     | String | 否     | 用户地址 |
| 5    | description | String | 是     | 描述     |

***2）入参示例***

```
http://localhost:5009/WeBASE-Data-Collect/user/add
```

```
{
  "address": "0x056a6b8bd27e861773ec2419a871ff245291a2d6",
  "chainId": 1,
  "description": "string",
  "groupId": 1,
  "userName": "alice"
}
```

#### 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          | 可为空 | 备注                       |
| ---- | ----------- | ------------- | ------ | -------------------------- |
| 1    | code        | Int           | 否     | 返回码，0：成功 其它：失败 |
| 2    | message     | String        | 否     | 描述                       |
| 3    |             | Object        |        | 节点信息对象               |
| 3.1  | userId      | Int           | 否     | 用户编号                   |
| 3.2  | chainId     | Int           | 否     | 链编号                     |
| 3.3  | groupId     | Int           | 否     | 群组编号                   |
| 3.2  | userName    | String        | 否     | 用户名                     |
| 3.3  | address     | String        | 否     | 用户地址                   |
| 3.4  | description | String        | 是     | 描述                       |
| 3.5  | createTime  | LocalDateTime | 是     | 落库时间                   |
| 3.6  | modifyTime  | LocalDateTime | 是     | 修改时间                   |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": {
    "userId": 1,
    "chainId": 1,
    "groupId": 1,
    "userName": "alice",
    "address": "0x056a6b8bd27e861773ec2419a871ff245291a2d6",
    "description": "test",
    "createTime": "2020-06-02 20:35:20",
    "modifyTime": "2020-06-02 20:35:20"
  }
}
```

- 失败：

```
{
    "code": 109000,
    "message": "system exception",
    "data": {}
}
```

### 5.2 获取用户列表 

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/user/list/{pageNumber}/{pageSize}?chainId={chainId}&groupId={groupId}&userParam={userParam}**
- 请求方式：GET
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型   | 可为空 | 备注               |
| ---- | ---------- | ------ | ------ | ------------------ |
| 1    | pageNumber | Int    | 否     | 当前页码           |
| 2    | pageSize   | Int    | 否     | 每页记录数         |
| 3    | chainId    | Int    | 是     | 链编号             |
| 4    | groupId    | Int    | 是     | 群组编号           |
| 5    | userParam  | String | 是     | 参数，用户名或地址 |

***2）入参示例***

```
http://localhost:5009/WeBASE-Data-Collect/user/list/1/2
```

#### 返回参数 

***1）出参表***

| 序号  | 输出参数    | 类型          |      | 备注                       |
| ----- | ----------- | ------------- | ---- | -------------------------- |
| 1     | code        | Int           | 否   | 返回码，0：成功 其它：失败 |
| 2     | message     | String        | 否   | 描述                       |
| 3     | totalCount  | Int           | 否   | 总记录数                   |
| 4     | data        | List          | 否   | 列表                       |
| 4.1   |             | Object        |      | 对象                       |
| 4.1.1 | userId      | Int           | 否   | 用户编号                   |
| 4.1.2 | chainId     | Int           | 否   | 链编号                     |
| 4.1.3 | groupId     | Int           | 否   | 群组编号                   |
| 4.1.4 | userName    | String        | 否   | 用户名                     |
| 4.1.5 | address     | String        | 否   | 用户地址                   |
| 4.1.6 | description | String        | 是   | 描述                       |
| 4.1.7 | createTime  | LocalDateTime | 否   | 落库时间                   |
| 4.1.8 | modifyTime  | LocalDateTime | 否   | 修改时间                   |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "userId": 1,
      "chainId": 1,
      "groupId": 1,
      "userName": "alice",
      "address": "0x056a6b8bd27e861773ec2419a871ff245291a2d6",
      "description": "test",
      "createTime": "2020-06-02 20:35:20",
      "modifyTime": "2020-06-02 20:35:20"
    }
  ],
  "totalCount": 1
}
```

- 失败：

```
{
   "code": 109000,
   "message": "system exception",
   "data": {}
}
```

### 5.3 删除用户

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/user/{userId}**
- 请求方式：DELETE
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型 | 可为空 | 备注     |
| ---- | -------- | ---- | ------ | -------- |
| 1    | userId   | Int  | 否     | 用户编号 |

***2）入参示例***

```
http://localhost:5009/WeBASE-Data-Collect/user/1
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
    "code": 109000,
    "message": "system exception",
    "data": {}
}
```

## 6 合约管理模块

### 6.1 保存合约和更新

####  传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/contract/save**
- 请求方式：POST
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数       | 类型   | 可为空 | 备注                                       |
| ---- | -------------- | ------ | ------ | ------------------------------------------ |
| 1    | chainId        | Int    | 否     | 链编号                                     |
| 2    | groupId        | Int    | 否     | 群组编号                                   |
| 3    | contractName   | String | 否     | 合约名称                                   |
| 4    | contractSource | String | 是     | 合约源码，Base64编码                       |
| 5    | contractAbi    | String | 是     | 编译合约生成的abi文件内容                  |
| 6    | runtimeBin    | String | 是     | 合约运行时binary，用于合约解析             |
| 7    | bytecodeBin    | String | 是     | 合约bytecode binary，用于部署合约          |
| 8    | contractId     | String | 是     | 合约编号（为空时表示新增，不为空表示更新） |
| 9    | contractPath   | String | 否     | 合约所在目录                               |

***2）入参示例***

```
http://localhost:5009/WeBASE-Data-Collect/contract/save
```

```
{
  "bytecodeBin": "608060405234801561001057600080fd5b50610373806100206000396000f30060806040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063299f7f9d146100515780633590b49f146100e1575b600080fd5b34801561005d57600080fd5b5061006661014a565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100a657808201518184015260208101905061008b565b50505050905090810190601f1680156100d35780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156100ed57600080fd5b50610148600480360381019080803590602001908201803590602001908080601f01602080910402602001604051908101604052809392919081815260200183838082843782019150505050505091929192905050506101ec565b005b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156101e25780601f106101b7576101008083540402835291602001916101e2565b820191906000526020600020905b8154815290600101906020018083116101c557829003601f168201915b5050505050905090565b7f05432a43e07f36a8b98100b9cb3631e02f8e796b0a06813610ce8942e972fb81816040518080602001828103825283818151815260200191508051906020019080838360005b8381101561024e578082015181840152602081019050610233565b50505050905090810190601f16801561027b5780820380516001836020036101000a031916815260200191505b509250505060405180910390a1806000908051906020019061029e9291906102a2565b5050565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106102e357805160ff1916838001178555610311565b82800160010185558215610311579182015b828111156103105782518255916020019190600101906102f5565b5b50905061031e9190610322565b5090565b61034491905b80821115610340576000816000905550600101610328565b5090565b905600a165627a7a72305820cff924cb0783dc84e2e107aae1fd09e1e04154b80834c9267a4eaa630997b2b90029",
  "chainId": 1,
  "contractAbi": "[{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"name\":\"name\",\"type\":\"string\"}],\"name\":\"SetName\",\"type\":\"event\"}]",
  "runtimeBin": "xxx",
  "contractName": "HelloWorld",
  "contractPath": "/",
  "contractSource": "cHJhZ21hIHNvbGlkaXR5IF4wLjQuMjsNCmNvbnRyYWN0IEhlbGxvV29ybGR7DQogICAgc3RyaW5nIG5hbWU7DQogICAgZXZlbnQgU2V0TmFtZShzdHJpbmcgbmFtZSk7DQogICAgZnVuY3Rpb24gZ2V0KCljb25zdGFudCByZXR1cm5zKHN0cmluZyl7DQogICAgICAgIHJldHVybiBuYW1lOw0KICAgIH0NCiAgICBmdW5jdGlvbiBzZXQoc3RyaW5nIG4pew0KICAgICAgICBlbWl0IFNldE5hbWUobik7DQogICAgICAgIG5hbWU9bjsNCiAgICB9DQp9",
  "groupId": 1
}
```

#### 返回参数 

***1）出参表***

| 序号 | 输出参数       | 类型          |      | 备注                                    |
| ---- | -------------- | ------------- | ---- | --------------------------------------- |
| 1    | code           | Int           | 否   | 返回码，0：成功 其它：失败              |
| 2    | message        | String        | 否   | 描述                                    |
| 3    |                | Object        |      | 返回信息实体                            |
| 3.1  | contractId     | Int           | 否   | 合约编号                                |
| 3.2  | contractPath   | String        | 否   | 合约所在目录                            |
| 3.3  | contractName   | String        | 否   | 合约名称                                |
| 3.4  | chainId        | Int           | 否   | 链编号                                  |
| 3.5  | groupId        | Int           | 否   | 群组编号                                |
| 3.6  | contractType   | Int           | 否   | 合约类型(0-普通合约，1-系统合约，默认0) |
| 3.7  | contractSource | String        | 否   | 合约源码                                |
| 3.8  | contractAbi    | String        | 是   | 编译合约生成的abi文件内容               |
| 3.9  | runtimeBin    | String        | 是   | 合约运行时binary，用于合约解析          |
| 3.10 | bytecodeBin    | String        | 是   | 合约bytecode binary，用于部署合约       |
| 3.11 | description    | String        | 是   | 备注                                    |
| 3.12 | createTime     | LocalDateTime | 否   | 创建时间                                |
| 3.13 | modifyTime     | LocalDateTime | 是   | 修改时间                                |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": {
    "contractId": 1,
    "chainId": 1,
    "groupId": 1,
    "contractType": 0,
    "contractPath": "/",
    "contractName": "HelloWorld",
    "contractSource": "cHJhZ21hIHNvbGlkaXR5IF4wLjQuMjsNCmNvbnRyYWN0IEhlbGxvV29ybGR7DQogICAgc3RyaW5nIG5hbWU7DQogICAgZXZlbnQgU2V0TmFtZShzdHJpbmcgbmFtZSk7DQogICAgZnVuY3Rpb24gZ2V0KCljb25zdGFudCByZXR1cm5zKHN0cmluZyl7DQogICAgICAgIHJldHVybiBuYW1lOw0KICAgIH0NCiAgICBmdW5jdGlvbiBzZXQoc3RyaW5nIG4pew0KICAgICAgICBlbWl0IFNldE5hbWUobik7DQogICAgICAgIG5hbWU9bjsNCiAgICB9DQp9",
    "contractAbi": "[{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"name\":\"name\",\"type\":\"string\"}],\"name\":\"SetName\",\"type\":\"event\"}]",
    "runtimeBin": "xxx",
    "bytecodeBin": "608060405234801561001057600080fd5b50610373806100206000396000f30060806040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063299f7f9d146100515780633590b49f146100e1575b600080fd5b34801561005d57600080fd5b5061006661014a565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100a657808201518184015260208101905061008b565b50505050905090810190601f1680156100d35780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156100ed57600080fd5b50610148600480360381019080803590602001908201803590602001908080601f01602080910402602001604051908101604052809392919081815260200183838082843782019150505050505091929192905050506101ec565b005b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156101e25780601f106101b7576101008083540402835291602001916101e2565b820191906000526020600020905b8154815290600101906020018083116101c557829003601f168201915b5050505050905090565b7f05432a43e07f36a8b98100b9cb3631e02f8e796b0a06813610ce8942e972fb81816040518080602001828103825283818151815260200191508051906020019080838360005b8381101561024e578082015181840152602081019050610233565b50505050905090810190601f16801561027b5780820380516001836020036101000a031916815260200191505b509250505060405180910390a1806000908051906020019061029e9291906102a2565b5050565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106102e357805160ff1916838001178555610311565b82800160010185558215610311579182015b828111156103105782518255916020019190600101906102f5565b5b50905061031e9190610322565b5090565b61034491905b80821115610340576000816000905550600101610328565b5090565b905600a165627a7a72305820cff924cb0783dc84e2e107aae1fd09e1e04154b80834c9267a4eaa630997b2b90029",
    "description": null,
    "createTime": "2020-06-02 20:50:58",
    "modifyTime": "2020-06-02 20:50:58"
  }
}
```

- 失败：

```
{
    "code": 109000,
    "message": "system exception",
    "data": {}
}
```

### 6.2 查询合约列表 

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/contract/list**
- 请求方式：POST
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数     | 类型   | 可为空 | 备注       |
| ---- | ------------ | ------ | ------ | ---------- |
| 1    | chainId      | Int    | 否     | 链编号     |
| 2    | groupId      | Int    | 否     | 群组id     |
| 3    | contractName | String | 是     | 合约名     |
| 4    | pageSize     | Int    | 是     | 每页记录数 |
| 5    | pageNumber   | Int    | 是     | 当前页码   |

***2）入参示例***

```
http://localhost:5009/WeBASE-Data-Collect/contract/list
```

```
{
  "chainId": 1,
  "groupId": 1,
  "pageNumber": 1,
  "pageSize": 2
}
```

#### 返回参数 

***1）出参表***

| 序号   | 输出参数       | 类型          |      | 备注                              |
| ------ | -------------- | ------------- | ---- | --------------------------------- |
| 1      | code           | Int           | 否   | 返回码，0：成功 其它：失败        |
| 2      | message        | String        | 否   | 描述                              |
| 3      | totalCount     | Int           | 否   | 总记录数                          |
| 4      | data           | List          | 是   | 列表                              |
| 5.1    |                | Object        |      | 返回信息实体                      |
| 5.1.1  | contractId     | Int           | 否   | 合约编号                          |
| 5.1.2  | contractPath   | String        | 否   | 合约所在目录                      |
| 5.1.3  | contractName   | String        | 否   | 合约名称                          |
| 5.1.4  | chainId        | Int           | 否   | 链编号                            |
| 5.1.5  | groupId        | Int           | 否   | 群组编号                          |
| 5.1.6  | contractType   | Int           | 否   | 合约类型(0-普通合约，1-系统合约)  |
| 5.1.7  | contractSource | String        | 否   | 合约源码                          |
| 5.1.8  | contractAbi    | String        | 是   | 编译合约生成的abi文件内容         |
| 5.1.9  | runtimeBin    | String        | 是   | 合约运行时binary，用于合约解析    |
| 5.1.10 | bytecodeBin    | String        | 是   | 合约bytecode binary，用于部署合约 |
| 5.1.11 | description    | String        | 是   | 备注                              |
| 5.1.12 | createTime     | LocalDateTime | 否   | 创建时间                          |
| 5.1.13 | modifyTime     | LocalDateTime | 是   | 修改时间                          |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "contractId": 1,
      "chainId": 1,
      "groupId": 1,
      "contractPath": "/",
      "contractName": "HelloWorld",
      "contractSource": "cHJhZ21hIHNvbGlkaXR5IF4wLjQuMjsNCmNvbnRyYWN0IEhlbGxvV29ybGR7DQogICAgc3RyaW5nIG5hbWU7DQogICAgZXZlbnQgU2V0TmFtZShzdHJpbmcgbmFtZSk7DQogICAgZnVuY3Rpb24gZ2V0KCljb25zdGFudCByZXR1cm5zKHN0cmluZyl7DQogICAgICAgIHJldHVybiBuYW1lOw0KICAgIH0NCiAgICBmdW5jdGlvbiBzZXQoc3RyaW5nIG4pew0KICAgICAgICBlbWl0IFNldE5hbWUobik7DQogICAgICAgIG5hbWU9bjsNCiAgICB9DQp9",
      "contractAbi": "[{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"name\":\"name\",\"type\":\"string\"}],\"name\":\"SetName\",\"type\":\"event\"}]",
      "runtimeBin": "xxx",
      "bytecodeBin": "608060405234801561001057600080fd5b50610373806100206000396000f30060806040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063299f7f9d146100515780633590b49f146100e1575b600080fd5b34801561005d57600080fd5b5061006661014a565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100a657808201518184015260208101905061008b565b50505050905090810190601f1680156100d35780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156100ed57600080fd5b50610148600480360381019080803590602001908201803590602001908080601f01602080910402602001604051908101604052809392919081815260200183838082843782019150505050505091929192905050506101ec565b005b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156101e25780601f106101b7576101008083540402835291602001916101e2565b820191906000526020600020905b8154815290600101906020018083116101c557829003601f168201915b5050505050905090565b7f05432a43e07f36a8b98100b9cb3631e02f8e796b0a06813610ce8942e972fb81816040518080602001828103825283818151815260200191508051906020019080838360005b8381101561024e578082015181840152602081019050610233565b50505050905090810190601f16801561027b5780820380516001836020036101000a031916815260200191505b509250505060405180910390a1806000908051906020019061029e9291906102a2565b5050565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106102e357805160ff1916838001178555610311565b82800160010185558215610311579182015b828111156103105782518255916020019190600101906102f5565b5b50905061031e9190610322565b5090565b61034491905b80821115610340576000816000905550600101610328565b5090565b905600a165627a7a72305820cff924cb0783dc84e2e107aae1fd09e1e04154b80834c9267a4eaa630997b2b90029",
      "contractType": 0,
      "description": null,
      "createTime": "2020-06-02 20:50:58",
      "modifyTime": "2020-06-02 20:50:58"
    }
  ],
  "totalCount": 1
}
```

- 失败：

```
{
    "code": 109000,
    "message": "system exception",
    "data": {}
}
```

### 6.3 删除合约

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/contract/{contractId}**
- 请求方式：DELETE
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型 | 可为空 | 备注     |
| ---- | ---------- | ---- | ------ | -------- |
| 1    | contractId | Int  | 否     | 合约编号 |

***2）入参示例***

```
http://localhost:5009/WeBASE-Data-Collect/contract/1
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
    "code": 109000,
    "message": "system exception",
    "data": {}
}
```

### 6.4 保存合约方法信息

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/contract/addMethod**
- 请求方式：POST
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号  | 输入参数   | 类型   | 可为空 | 备注     |
| ----- | ---------- | ------ | ------ | -------- |
| 1     | contractId | Int    | 否     | 合约编号 |
| 2     | methodList | List   | 否     | 方法列表 |
| 2.1   |            | Object | 否     | 方法实体 |
| 2.1.1 | methodId   | String | 否     | 方法编号 |
| 2.1.2 | methodName | String | 否     | 方法名   |
| 2.1.4 | methodType | String | 否     | 方法类型 |

***2）入参示例***

```
http://127.0.0.1:5009/WeBASE-Data-Collect/contract/addMethod
```

```
{
  "contractId": 2,
  "methodList": [
    {
      "methodId": "0x3590b49f",
      "methodName": "set",
      "methodType": "function"
    }，
    {
      "methodId": "0x9bd13510",
      "methodName": "get",
      "methodType": "function"
    }
  ]
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
    "code": 109000,
    "message": "system exception",
    "data": {}
}
```

## 7. 编译器管理模块

### 7.1. 查询编译器列表

#### 传输协议

- 网络传输协议：使用HTTP协议
- 请求地址：**/solc/list?encryptType={encryptType}**
- 请求方式：GET
- 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型 | 可为空 | 备注                     |
| ---- | ----------- | ---- | ------ | ------------------------ |
| 1    | encryptType | Int  | 是     | 类型（0-ecdsa；1-guomi） |

***2）入参示例***

```
http://localhost:5009/WeBASE-Data-Collect/solc/list
```

#### 返回参数 

***1）出参表***

| 序号  | 输出参数    | 类型          |      | 备注                       |
| ----- | ----------- | ------------- | ---- | -------------------------- |
| 1     | code        | Int           | 否   | 返回码，0：成功 其它：失败 |
| 2     | message     | String        | 否   | 描述                       |
| 3     | totalCount  | Int           | 否   | 总记录数                   |
| 4     | data        | List          | 否   | 列表                       |
| 4.1   |             | Object        |      | 对象                       |
| 4.1.1 | id          | Int           | 否   | 编号                       |
| 4.1.2 | solcName    | Int           | 否   | 编译器文件名               |
| 4.1.3 | encryptType | Int           | 否   | 类型                       |
| 4.1.4 | md5         | String        | 否   | md5值                      |
| 4.1.5 | fileSize    | Long          | 否   | 文件长度                   |
| 4.1.6 | description | String        | 是   | 描述                       |
| 4.1.7 | createTime  | LocalDateTime | 否   | 落库时间                   |
| 4.1.8 | modifyTime  | LocalDateTime | 否   | 修改时间                   |

***2）出参示例***

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "id": 1,
      "solcName": "soljson-v0.4.25-gm.js",
      "encryptType": 1,
      "md5": "c0810103136fb9177df943346b2dcad4",
      "fileSize": 8273598,
      "description": "guomi",
      "createTime": "2020-06-14 11:05:56",
      "modifyTime": "2020-06-14 11:05:56"
    },
    {
      "id": 2,
      "solcName": "soljson-v0.4.25+commit.59dbf8f1.js",
      "encryptType": 0,
      "md5": "e201c5913e0982cb90cdb2a711e36f63",
      "fileSize": 8276063,
      "description": "ecdsa",
      "createTime": "2020-06-14 11:19:10",
      "modifyTime": "2020-06-14 11:19:10"
    }
  ]
}
```

## 附录 

### 1. 返回码信息列表

| Code   | message                          | 描述               |
| ------ | -------------------------------- | ------------------ |
| 0      | success                          | 正常               |
| 109000 | system exception                 | 系统异常           |
| 109001 | param exception                  | 请求参数错误       |
| 109002 | database exception               | 数据库异常         |
| 209001 | chain id already exists          | 链编号已经存在     |
| 209002 | chain name already exists        | 链名称已经存在     |
| 209003 | save chain fail                  | 链保存失败         |
| 209004 | invalid chain id                 | 无效链编号         |
| 209005 | invalid encrypt type             | 无效链加密类型     |
| 209006 | chain id not exists              | 链编号不存在       |
| 209101 | wrong host or port               | ip或端口错误       |
| 209102 | invalid front id                 | 无效前置编号       |
| 209103 | not found any front              | 找不到前置         |
| 209104 | front already exists             | 前置已经存在       |
| 209105 | save front fail                  | 前置保存失败       |
| 209106 | request front fail               | 前置请求失败       |
| 209107 | request node exception           | 前置节点请求失败   |
| 209108 | front's encrypt type not matches | 前置类型不匹配     |
| 209109 | invalid block number             | 无效块高           |
| 209110 | invalid node id                  | 无效节点编号       |
| 209201 | invalid group id                 | 无效群组编号       |
| 209202 | group name already exist         | 群组名称已存在     |
| 209301 | user name already exists         | 用户名已存在       |
| 209302 | user address already exists      | 用户地址已存在     |
| 209401 | contract already exists          | 合约已存在         |
| 209402 | invalid contract id              | 无效合约编号       |
| 209403 | contract name cannot be repeated | 合约名重复         |
| 209501 | task is still running            | 任务正在执行       |
| 209502 | block has been reset             | 区块已重置         |
| 209601 | solc js file cannot be empty     | 编译器文件不能为空 |
| 209602 | solc js file already exist       | 编译器文件已存在   |
| 209603 | solc js file not exist           | 编译器文件不存在   |
| 209604 | save solc js file error          | 编译器文件保存失败 |
| 209605 | read solc js file error          | 编译器文件读取失败 |