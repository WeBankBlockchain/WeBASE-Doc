# 接口说明

[TOC]

## 1 区块链管理模块

### 1.1 新增链信息

#### 1.1.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址： **/chain/new**
- 请求方式：POST
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 1.1.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型   | 可为空 | 备注                       |
| ---- | ----------- | ------ | ------ | -------------------------- |
| 1    | chainId     | int    | 否     | 链编号                     |
| 2    | chainName   | string | 否     | 链名称                     |
| 3    | chainType   | int    | 否     | 链类型（0-非国密，1-国密） |
| 4    | description | string | 是     | 备注                       |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/chain/new
```

```
{
    "chainId": 100001,
    "chainName": "链一",
    "chainType": 0,
    "description": "test"
}
```

#### 1.1.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |      | 备注                       |
| ---- | ----------- | ------------- | ---- | -------------------------- |
| 1    | code        | Int           | 否   | 返回码，0：成功 其它：失败 |
| 2    | message     | String        | 否   | 描述                       |
| 3    |             | Object        |      | 节点信息对象               |
| 3.1  | chainId     | int           | 否   | 链编号                     |
| 3.2  | chainName   | string        | 否   | 链名称                     |
| 3.3  | chainType   | int           | 否   | 链类型（0-非国密，1-国密） |
| 3.4  | description | string        | 是   | 备注                       |
| 3.5  | createTime  | LocalDateTime | 否   | 落库时间                   |
| 3.6  | modifyTime  | LocalDateTime | 否   | 修改时间                   |

***2）出参示例***

- 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "chainId": 100001,
        "chainName": "链一",
        "chainType": 0,
        "description": "test"
        "createTime": "2019-02-14 17:47:00",
        "modifyTime": "2019-03-15 11:14:29"
    }
}
```

- 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 1.2 获取所有链列表 

#### 1.2.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址：**/chain/all**
- 请求方式：GET
- 返回格式：JSON

#### 1.2.2 请求参数

***1）入参表***

无

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/chain/all
```

#### 1.2.3 返回参数 

***1）出参表***

| 序号  | 输出参数    | 类型          |      | 备注                       |
| ----- | ----------- | ------------- | ---- | -------------------------- |
| 1     | code        | Int           | 否   | 返回码，0：成功 其它：失败 |
| 2     | message     | String        | 否   | 描述                       |
| 3     | totalCount  | Int           | 否   | 总记录数                   |
| 4     | data        | List          | 否   | 组织列表                   |
| 4.1   |             | Object        |      | 节点信息对象               |
| 4.1.1 | chainId     | int           | 否   | 链编号                     |
| 4.1.2 | chainName   | string        | 否   | 链名称                     |
| 4.1.3 | chainType   | int           | 否   | 链类型（0-非国密，1-国密） |
| 4.1.4 | description | string        | 是   | 备注                       |
| 4.1.5 | createTime  | LocalDateTime | 否   | 落库时间                   |
| 4.1.6 | modifyTime  | LocalDateTime | 否   | 修改时间                   |

***2）出参示例***

- 成功：

```
{
    "code": 0,
    "message": "success",
    "data": [
        {
        "chainId": 100001,
        "chainName": "链一",
        "chainType": 0,
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
   "code": 102000,
   "message": "system exception",
   "data": {}
}
```

### 1.3 删除链信息

#### 1.3.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址：**/chain/{chainId}**
- 请求方式：DELETE
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 1.3.2 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型 | 可为空 | 备注   |
| ---- | -------- | ---- | ------ | ------ |
| 1    | chainId  | int  | 否     | 链编号 |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/chain/100001
```

#### 1.3.3 返回参数 

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
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

## 2 前置管理模块

### 2.1 新增节点前置信息

#### 2.1.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址： **/front/new**
- 请求方式：POST
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 2.1.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型   | 可为空 | 备注         |
| ---- | ----------- | ------ | ------ | ------------ |
| 1    | chainId     | int    | 否     | 链编号       |
| 2    | frontIp     | string | 否     | 前置ip       |
| 3    | frontPort   | int    | 否     | 前置服务端口 |
| 4    | agency      | string | 否     | 所属机构     |
| 5    | description | string | 是     | 备注         |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/front/new
```

```
{
    "chainId": 100001,
    "frontIp": "127.0.0.1",
    "frontPort": 5002,
    "agency": "abc",
    "description": "test"
}
```

#### 2.1.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |      | 备注                       |
| ---- | ----------- | ------------- | ---- | -------------------------- |
| 1    | code        | Int           | 否   | 返回码，0：成功 其它：失败 |
| 2    | message     | String        | 否   | 描述                       |
| 3    |             | Object        |      | 节点信息对象               |
| 3.1  | frontId     | int           | 否   | 前置编号                   |
| 3.2  | chainId     | int           | 否   | 链编号                     |
| 3.3  | nodeId      | string        | 否   | 前置对应的节点编号         |
| 3.4  | frontIp     | string        | 否   | 前置ip                     |
| 3.5  | frontPort   | int           | 否   | 前置端口                   |
| 3.6  | agency      | string        | 否   | 所属机构                   |
| 3.7  | description | string        | 是   | 备注                       |
| 3.8  | createTime  | LocalDateTime | 否   | 落库时间                   |
| 3.9  | modifyTime  | LocalDateTime | 否   | 修改时间                   |

***2）出参示例***

- 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "frontId": 200001,
        "chainId": 100001,
        "nodeId": "78e467957af3d0f77e19b952a740ba8c53ac76913df7dbd48d7a0fe27f4c902b55e8543e1c4f65b4a61695c3b490a5e8584149809f66e9ffc8c05b427e9d3ca2",
        "frontIp": "127.0.0.1",
        "frontPort": 5002,
        "agency": "aa",
        "description": "test"
        "createTime": "2019-02-14 17:47:00",
        "modifyTime": "2019-03-15 11:14:29"
    }
}
```

- 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 2.2 获取所有前置列表 

#### 2.2.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址：**/front/find?chainId={chainId}?frontId={frontId}&groupId={groupId}**
- 请求方式：GET
- 返回格式：JSON

#### 2.2.2 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型 | 可为空 | 备注         |
| ---- | -------- | ---- | ------ | ------------ |
| 1    | chainId  | Int  | 是     | 链编号       |
| 2    | frontId  | Int  | 是     | 前置编号     |
| 3    | groupId  | Int  | 是     | 所属群组编号 |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/front/find
```

#### 2.2.3 返回参数 

***1）出参表***

| 序号  | 输出参数    | 类型          |      | 备注                       |
| ----- | ----------- | ------------- | ---- | -------------------------- |
| 1     | code        | Int           | 否   | 返回码，0：成功 其它：失败 |
| 2     | message     | String        | 否   | 描述                       |
| 3     | totalCount  | Int           | 否   | 总记录数                   |
| 4     | data        | List          | 否   | 组织列表                   |
| 4.1   |             | Object        |      | 节点信息对象               |
| 4.1.1 | frontId     | int           | 否   | 前置编号                   |
| 4.1.2 | chainId     | int           | 否   | 链编号                     |
| 4.1.3 | nodeId      | string        | 否   | 前置对应的节点编号         |
| 4.1.4 | frontIp     | string        | 否   | 前置ip                     |
| 4.1.5 | frontPort   | int           | 否   | 前置端口                   |
| 4.1.6 | agency      | string        | 否   | 所属机构                   |
| 4.1.7 | description | string        | 是   | 备注                       |
| 4.1.8 | createTime  | LocalDateTime | 否   | 落库时间                   |
| 4.1.9 | modifyTime  | LocalDateTime | 否   | 修改时间                   |

***2）出参示例***

- 成功：

```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "frontId": 200001,
            "chainId": 100001,
            "nodeId": "78e467957af3d0f77e19b952a740ba8c53ac76913df7dbd48d7a0fe27f4c902b55e8543e1c4f65b4a61695c3b490a5e8584149809f66e9ffc8c05b427e9d3ca2",
            "frontIp": "127.0.0.1",
            "frontPort": 5002,
            "agency": "aa",
            "description": "test"
            "createTime": "2019-06-04 20:49:42",
            "modifyTime": "2019-06-04 20:49:42"
        }
    ],
    "totalCount": 1
}
```

- 失败：

```
{
   "code": 102000,
   "message": "system exception",
   "data": {}
}
```

### 2.3 删除前置信息

#### 2.3.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址：**/front/{frontId}**
- 请求方式：DELETE
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 2.3.2 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型 | 可为空 | 备注     |
| ---- | -------- | ---- | ------ | -------- |
| 1    | frontId  | int  | 否     | 前置编号 |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/front/200001
```

#### 2.3.3 返回参数 

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
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 2.4 前置节点监控信息

#### 2.4.1 传输协议规范

- 网络传输协议：使用HTTP协议

- 请求地址：

  ```
  /mointorInfo/{frontId}?beginDate={beginDate}&endDate={endDate}&contrastBeginDate={contrastBeginDate}&contrastEndDate={contrastEndDate}&gap={gap}&groupId={groupId}
  ```

- 请求方式：GET

- 请求头：Content-type: application/json

- 返回格式：JSON

#### 2.4.2 请求参数

***1）入参表***

| 序号 | 输入参数          | 类型          | 可为空 | 备注                                                         |
| ---- | ----------------- | ------------- | ------ | ------------------------------------------------------------ |
| 1    | frontId           | int           | 否     | 前置编号                                                     |
| 2    | beginDate         | LocalDateTime | 是     | 显示时间（开始） yyyy-MM-dd'T'HH:mm:ss.SSS 2019-03-13T00:00:00 |
| 3    | endDate           | LocalDateTime | 是     | 显示时间（结束）                                             |
| 4    | contrastBeginDate | LocalDateTime | 是     | 对比时间（开始）                                             |
| 5    | contrastEndDate   | LocalDateTime | 是     | 对比时间（结束）                                             |
| 6    | gap               | Int           | 是     | 数据粒度，默认1                                              |
| 7    | groupId           | int           | 否     | 群组编号，默认1                                              |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/front/mointorInfo/200001?beginDate=2019-03-13T00:00:00&endDate=2019-03-13T14:34:22&contrastBeginDate=2019-03-13T00:00:00&contrastEndDate=2019-03-13T14:34:22&gap=60&groupId=1
```

#### 2.4.3 返回参数 

***1）出参表***

| 序号      | 输出参数         | 类型            |      | 备注                                                         |
| --------- | ---------------- | --------------- | ---- | ------------------------------------------------------------ |
| 1         | code             | Int             | 否   | 返回码                                                       |
| 2         | message          | String          | 否   | 描述信息                                                     |
| 3         | data             | Array           | 否   | 返回信息列表                                                 |
| 3.1       |                  | Object          |      | 返回信息实体                                                 |
| 3.1.1     | metricType       | String          | 否   | 测量类型：blockHeight（块高）、pbftView（pbft视图）、pendingCount（待处理交易数量） |
| 3.1.2     | data             | Object          | 否   |                                                              |
| 3.1.2.1   | lineDataList     | Object          | 否   | 指定时间的数据                                               |
| 3.1.2.1.1 | timestampList    | List\<String\>  | 否   | 时间戳列表                                                   |
| 3.1.2.1.2 | valueList        | List\<Integer\> | 否   | 值列表                                                       |
| 3.1.2.2   | contrastDataList | Object          | 否   | 比对时间的数据                                               |
| 3.1.2.2.1 | timestampList    | List\<String\>  | 否   | 时间戳列表                                                   |
| 3.1.2.2.2 | valueList        | List\<Integer\> | 否   | 值列表                                                       |

***2）出参示例***

- 成功：

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

- 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 2.5 前置节点服务器监控信息 

#### 2.5.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址：

```
/front/ratio/{frontId}?gap={gap}&beginDate={beginDate}&endDate={endDate}&contrastBeginDate={contrastBeginDate}&contrastEndDate={contrastEndDate}
```

- 请求方式：GET
- 返回格式：JSON

#### 2.5.2 请求参数

***1）入参表***

| 序号 | 输入参数          | 类型          | 可为空 | 备注                                                         |
| ---- | ----------------- | ------------- | ------ | ------------------------------------------------------------ |
| 1    | frontId           | int           | 否     | 前置编号                                                     |
| 2    | beginDate         | LocalDateTime | 是     | 显示时间（开始） yyyy-MM-dd'T'HH:mm:ss.SSS 2019-03-13T00:00:00 |
| 3    | endDate           | LocalDateTime | 是     | 显示时间（结束）                                             |
| 4    | contrastBeginDate | LocalDateTime | 是     | 对比时间（开始）                                             |
| 5    | contrastEndDate   | LocalDateTime | 是     | 对比时间（结束）                                             |
| 6    | gap               | Int           | 是     | 数据粒度，默认1                                              |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/front/ratio/200001?gap=1&beginDate=2019-03-15T00:00:00&endDate=2019-03-15T15:26:55&contrastBeginDate=2019-03-15T00:00:00&contrastEndDate=2019-03-15T15:26:55
```

#### 2.5.3 返回参数 

***1）出参表***

| 序号      | 输出参数         | 类型            |      | 备注                                                         |
| --------- | ---------------- | --------------- | ---- | ------------------------------------------------------------ |
| 1         | code             | Int             | 否   | 返回码                                                       |
| 2         | message          | String          | 否   | 描述信息                                                     |
| 3         | data             | Array           | 否   | 返回信息列表                                                 |
| 3.1       |                  | Object          |      | 返回信息实体                                                 |
| 3.1.1     | metricType       | String          | 否   | 测量类型: cpu（cpu利用率：%）、memory（内存利用率：%）、disk（硬盘利用率：%）、txbps（上行bandwith：KB/s）、rxbps（下行bandwith：KB/s） |
| 3.1.2     | data             | Object          | 否   |                                                              |
| 3.1.2.1   | lineDataList     | Object          | 否   | 指定时间的数据                                               |
| 3.1.2.1.1 | timestampList    | List\<String\>  | 否   | 时间戳列表                                                   |
| 3.1.2.1.2 | valueList        | List\<Integer\> | 否   | 值列表                                                       |
| 3.1.2.2   | contrastDataList | Object          | 否   | 比对时间的数据                                               |
| 3.1.2.2.1 | timestampList    | List\<String\>  | 否   | 时间戳列表                                                   |
| 3.1.2.2.2 | valueList        | List\<Integer\> | 否   | 值列表                                                       |

***2）出参示例***

- 成功：

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

- 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 2.6 前置节点服务器配置信息 

#### 2.6.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址：**/front/config/{frontId}** 

- 请求方式：GET
- 返回格式：JSON

#### 2.6.2 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型 | 可为空 | 备注     |
| ---- | -------- | ---- | ------ | -------- |
| 1    | frontId  | int  | 否     | 前置编号 |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/front/config/200001
```

#### 2.6.3 返回参数 

***1）出参表***

| 序号  | 输出参数        | 类型   |      | 备注                         |
| ----- | --------------- | ------ | ---- | ---------------------------- |
| 1     | code            | int    | 否   | 返回码                       |
| 2     | message         | String | 否   | 描述信息                     |
| 3     | data            | Array  | 否   | 返回信息列表                 |
| 3.1   |                 | Object |      | 返回信息实体                 |
| 3.1.1 | ip              | String | 否   | ip地址                       |
| 3.1.2 | memoryTotalSize | String | 否   | 内存总量（单位：KB）         |
| 3.1.3 | memoryUsedSize  | String | 否   | 当前内存使用量（单位：KB）   |
| 3.1.4 | cpuSize         | String | 否   | CPU的大小（单位：MHz）       |
| 3.1.5 | cpuAmount       | String | 否   | CPU的核数（单位：个）        |
| 3.1.6 | diskTotalSize   | String | 否   | 文件系统总量（单位：KB）     |
| 3.1.7 | diskUsedSize    | String | 否   | 文件系统已使用量（单位：KB） |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": {
    "memoryTotalSize": "8010916",
    "cpuAmount": "4",
    "memoryUsedSize": "7674492",
    "cpuSize": "2599",
    "ip": "127.0.0.1",
    "diskUsedSize": "306380076",
    "diskTotalSize": "515928320"
  }
}
```

- 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 2.7 检查前置节点进程是否存活 

#### 2.7.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址：**/front/checkNodeProcess/{frontId}** 
- 请求方式：GET
- 返回格式：JSON

#### 2.7.2 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型 | 可为空 | 备注     |
| ---- | -------- | ---- | ------ | -------- |
| 1    | frontId  | Int  | 否     | 前置编号 |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/front/checkNodeProcess/200001
```

#### 2.7.3 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型    |      | 备注                    |
| ---- | -------- | ------- | ---- | ----------------------- |
| 1    | code     | Int     | 否   | 返回码                  |
| 2    | message  | String  | 否   | 描述信息                |
| 3    | data     | boolean | 否   | true-存活；false-未存活 |

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
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 2.8 获取前置节点所在群组物理大小信息 

#### 2.8.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址：**/front/getGroupSizeInfos/{frontId}**

- 请求方式：GET
- 返回格式：JSON

#### 2.8.2 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型 | 可为空 | 备注     |
| ---- | -------- | ---- | ------ | -------- |
| 1    | frontId  | Int  | 否     | 前置编号 |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/front/getGroupSizeInfos/200001
```

#### 2.8.3 返回参数 

***1）出参表***

| 序号  | 输出参数  | 类型   |      | 备注             |
| ----- | --------- | ------ | ---- | ---------------- |
| 1     | code      | Int    | 否   | 返回码           |
| 2     | message   | String | 否   | 描述信息         |
| 3     | data      | Array  | 否   | 返回信息列表     |
| 3.1   |           | List   |      | 返回信息实体     |
| 3.1.1 | groupId   | Int    | 否   | 群组id           |
| 3.1.2 | groupName | String | 否   | 群组名           |
| 3.1.3 | path      | String | 否   | 文件路径         |
| 3.1.4 | size      | Long   | 否   | 大小（单位：KB） |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": [
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
}
```

- 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

## 3 群组管理模块

### 3.1 生成新群组

​	向单个节点请求生成新群组配置信息，节点和前置一一对应，节点编号可以从前置列表获取。适用于新群组下的节点属于不同链管理服务，每个节点都要请求一遍。**群组生成后，需对应调用3.3的启动。** 

#### 3.1.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址： **/group/generate/{nodeId}**
- 请求方式：POST
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 3.1.2 请求参数

***1）入参表***

| 序号 | 输入参数        | 类型         | 可为空 | 备注                                 |
| ---- | --------------- | ------------ | ------ | ------------------------------------ |
| 1    | chainId         | int          | 否     | 链编号                               |
| 2    | generateGroupId | int          | 否     | 生成的群组编号                       |
| 3    | timestamp       | BigInteger   | 否     | 创世块时间（单位：ms）               |
| 4    | nodeList        | List<String> | 否     | 节点编号列表（新群组的所有节点编号） |
| 5    | description     | string       | 是     | 备注                                 |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/group/generate/78e467957af3d0f77e19b952a740ba8c53ac76913df7dbd48d7a0fe27f4c902b55e8543e1c4f65b4a61695c3b490a5e8584149809f66e9ffc8c05b427e9d3ca2
```

```
{
    "chainId": 100001,
    "generateGroupId": 2,
    "timestamp": 1574853659000,
    "nodeList": [
       "78e467957af3d0f77e19b952a740ba8c53ac76913df7dbd48d7a0fe27f4c902b55e8543e1c4f65b4a61695c3b490a5e8584149809f66e9ffc8c05b427e9d3ca2"
    ],
    "description": "description"
}
```

#### 3.1.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |      | 备注                       |
| ---- | ----------- | ------------- | ---- | -------------------------- |
| 1    | code        | Int           | 否   | 返回码，0：成功 其它：失败 |
| 2    | message     | String        | 否   | 描述                       |
| 3    | data        | Object        | 否   | 组织信息对象               |
| 3.1  | groupId     | int           | 否   | 群组编号                   |
| 3.2  | chainId     | int           | 否   | 链编号                     |
| 3.3  | groupName   | String        | 否   | 群组名称                   |
| 3.4  | nodeCount   | int           | 否   | 节点数量                   |
| 3.5  | description | String        | 是   | 描述                       |
| 3.6  | createTime  | LocalDateTime | 否   | 落库时间                   |
| 3.7  | modifyTime  | LocalDateTime | 否   | 修改时间                   |

***2）出参示例***

- 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "groupId": 2,
        "chainId": 100001,
        "groupName": "group2",
        "nodeCount": 1,
        "description": "test",
        "createTime": "2019-02-14 17:33:50",
        "modifyTime": "2019-03-15 09:36:17"
    }
}
```

- 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 3.2 批量生成新群组

​	向新群组下所有节点请求生成新群组配置信息，节点和前置一一对应，节点编号可以从前置列表获取。适用于新群组下的节点属于同一个链管理服务（节点对应前置都要添加到链管理服务）。**群组生成后，需对应调用3.4的批量启动。** 

#### 3.2.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址： **/group/generate**
- 请求方式：POST
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 3.2.2 请求参数

***1）入参表***

| 序号 | 输入参数        | 类型         | 可为空 | 备注                                 |
| ---- | --------------- | ------------ | ------ | ------------------------------------ |
| 1    | chainId         | int          | 否     | 链编号                               |
| 2    | generateGroupId | int          | 否     | 生成的群组编号                       |
| 3    | timestamp       | BigInteger   | 否     | 创世块时间（单位：ms）               |
| 4    | nodeList        | List<String> | 否     | 节点编号列表（新群组的所有节点编号） |
| 5    | description     | string       | 是     | 备注                                 |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/group/generate
```

```
{
    "chainId": 100001,
    "generateGroupId": 2,
    "timestamp": 1574853659000,
    "nodeList": [
       "78e467957af3d0f77e19b952a740ba8c53ac76913df7dbd48d7a0fe27f4c902b55e8543e1c4f65b4a61695c3b490a5e8584149809f66e9ffc8c05b427e9d3ca2"
    ],
    "description": "description"
}
```

#### 3.2.3 返回参数

***1）出参表***

| 序号 | 输出参数    | 类型          |      | 备注                       |
| ---- | ----------- | ------------- | ---- | -------------------------- |
| 1    | code        | Int           | 否   | 返回码，0：成功 其它：失败 |
| 2    | message     | String        | 否   | 描述                       |
| 3    | data        | Object        | 否   | 组织信息对象               |
| 3.1  | groupId     | int           | 否   | 群组编号                   |
| 3.2  | chainId     | int           | 否   | 链编号                     |
| 3.3  | groupName   | String        | 否   | 群组名称                   |
| 3.4  | nodeCount   | int           | 否   | 节点数量                   |
| 3.5  | description | String        | 是   | 描述                       |
| 3.6  | createTime  | LocalDateTime | 否   | 落库时间                   |
| 3.7  | modifyTime  | LocalDateTime | 否   | 修改时间                   |

***2）出参示例***

- 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "groupId": 2,
        "chainId": 100001,
        "groupName": "group2",
        "nodeCount": 1,
        "description": "test",
        "createTime": "2019-02-14 17:33:50",
        "modifyTime": "2019-03-15 09:36:17"
    }
}
```

- 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 3.3 动态操作群组

​	可以对已存在的群组或新生成的群组进行动态操作，包括启动、停止、删除、恢复、状态查询。

​	**说明：** 生成新群组时，新群组下每一个节点都要启动，节点和前置一一对应。适用于新群组下的节点属于不同链管理服务，每个节点都要请求一遍进行启动。

#### 3.3.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址：**/operate/{chainId}/{groupId}/{nodeId}/{type}**
- 请求方式：GET
- 返回格式：JSON

#### 3.3.2 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型   | 可为空 | 备注                                                         |
| ---- | -------- | ------ | ------ | ------------------------------------------------------------ |
| 1    | chainId  | int    | 否     | 链编号                                                       |
| 2    | groupId  | int    | 否     | 要操作的群组编号                                             |
| 3    | nodeId   | String | 否     | 节点Id                                                       |
| 4    | type     | String | 否     | 操作类型：start-启动；stop-停止；remove-删除；recover-恢复；getStatus-查询状态 |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/group/operate/100001/2/78e467957af3d0f77e19b952a740ba8c53ac76913df7dbd48d7a0fe27f4c902b55e8543e1c4f65b4a61695c3b490a5e8584149809f66e9ffc8c05b427e9d3ca2/start
```

#### 3.3.3 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data     | object | 否   | 返回信息实体               |

***2）出参示例***

- 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {}
}
```

- 失败：

```
{
  "code": 205032,
  "message": "Group 2 is already running",
  "data": null
}
```

### 3.4 批量启动群组

​	节点和前置一一对应，节点编号可以从前置列表获取。适用于新群组下的节点属于同一个链管理服务（节点对应前置都要添加到链管理服务）。

#### 3.4.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址： **/group/batchStart**
- 请求方式：POST
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 3.4.2 请求参数

***1）入参表***

| 序号 | 输入参数        | 类型         | 可为空 | 备注           |
| ---- | --------------- | ------------ | ------ | -------------- |
| 1    | chainId         | int          | 否     | 链编号         |
| 2    | generateGroupId | int          | 否     | 生成的群组编号 |
| 3    | nodeList        | List<String> | 否     | 节点编号列表   |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/group/generate
```

```
{
    "chainId": 100001,
    "generateGroupId": 2,
    "nodeList": [
       "78e467957af3d0f77e19b952a740ba8c53ac76913df7dbd48d7a0fe27f4c902b55e8543e1c4f65b4a61695c3b490a5e8584149809f66e9ffc8c05b427e9d3ca2"
    ]
}
```

#### 3.4.3 返回参数

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data     | Object | 否   | 组织信息对象               |

***2）出参示例***

- 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {}
}
```

- 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### ~~3.5 更新群组~~（废弃，启动或停止后自动更新）

​	生成新群组并启动新群组的每一个节点后，调用此接口更新群组相关信息。

#### 3.5.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址：**/update**
- 请求方式：GET
- 返回格式：JSON

#### 3.5.2 请求参数

***1）入参表***

无

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/group/update
```

#### 3.5.3 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data     | object | 否   | 返回信息实体               |

***2）出参示例***

- 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {}
}
```

- 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 3.6 获取群组概况

#### 3.6.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址：**/group/general/{chainId}/{groupId}**
- 请求方式：GET
- 返回格式：JSON

#### 3.6.2 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型 | 可为空 | 备注   |
| ---- | -------- | ---- | ------ | ------ |
| 1    | chainId  | int  | 否     | 链编号 |
| 2    | groupId  | int  | 否     | 群组id |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/group/100001/300001
```

#### 3.6.3 返回参数 

***1）出参表***

| 序号 | 输出参数  | 类型   |      | 备注                       |
| ---- | --------- | ------ | ---- | -------------------------- |
| 1    | code      | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message   | String | 否   | 描述                       |
| 3    | data      | object | 否   | 返回信息实体               |
| 3.1  | groupId   | int    | 否   | 群组id                     |
| 3.2  | nodeCount | int    | 否   | 节点数量                   |

***2）出参示例***

- 成功：

```
{
    "code": 0,
    "data": {
        "groupId": "300001",
        "nodeCount": 2
    },
    "message": "success"
}
```

- 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 3.7 获取所有群组列表

#### 3.7.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址：**/group/all/{chainId}**
- 请求方式：GET
- 返回格式：JSON

#### 3.7.2 请求参数

***1）入参表***
无

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/group/all/100001
```

#### 3.7.3 返回参数 

***1）出参表***

| 序号  | 输出参数    | 类型          |      | 备注                       |
| ----- | ----------- | ------------- | ---- | -------------------------- |
| 1     | code        | Int           | 否   | 返回码，0：成功 其它：失败 |
| 2     | message     | String        | 否   | 描述                       |
| 3     | totalCount  | Int           | 否   | 总记录数                   |
| 4     | data        | List          | 否   | 组织列表                   |
| 4.1   |             | Object        |      | 组织信息对象               |
| 4.1.1 | chainId     | int           | 否   | 链编号                     |
| 4.1.2 | groupId     | int           | 否   | 群组编号                   |
| 4.1.3 | groupName   | String        | 否   | 群组名称                   |
| 4.1.4 | nodeCount   | int           | 否   | 节点数量                   |
| 4.1.5 | description | String        | 是   | 描述                       |
| 4.1.6 | createTime  | LocalDateTime | 否   | 落库时间                   |
| 4.1.7 | modifyTime  | LocalDateTime | 否   | 修改时间                   |

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
            "groupId": 2,
            "groupName": "group2",
            "nodeCount": 1,
            "description": "test",
            "createTime": "2019-02-14 17:33:50",
            "modifyTime": "2019-03-15 09:36:17"
        }
    ]
}
```

- 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 3.8 获取群组下节点共识列表

​	获取节点的共识列表，包含节点Id，节点共识状态。返回所有的共识/观察节点（无论运行或停止），以及正在运行的游离节点。

#### 3.8.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址： **/group/getConsensusList/{chainId}/{groupId}/{nodeId}**
- 请求方式：GET
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 3.8.2 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型   | 可为空 | 备注                 |
| ---- | ---------- | ------ | ------ | -------------------- |
| 1    | chainId    | Int    | 否     | 链编号               |
| 2    | groupId    | Int    | 否     | 群组编号             |
| 3    | nodeId     | String | 否     | 节点Id，指定节点调用 |
| 4    | pageSize   | Int    | 是     | 条数，默认10         |
| 5    | pageNumber | Int    | 是     | 页码，默认1          |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/group/getConsensusList/1001/1/413c788ec4b55e8170815e1c61977bac8c38f2df8670d09868a6099a044c0bff7884b9c30f3fa9c331358fcbded28f8d0211e2ffc48019c9796fa05274ed89b1?pageSize=10&pageNumber=1
```

#### 3.8.3 返回参数

***1）出参表***

| 序号  | 输出参数   | 类型   |      | 备注                       |
| ----- | ---------- | ------ | ---- | -------------------------- |
| 1     | code       | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2     | message    | String | 否   | 描述                       |
| 3     | totalCount | Int    | 否   | 总记录数                   |
| 4     | data       | List   | 否   | 共识列表                   |
| 4.1   |            | Object |      | 共识信息对象               |
| 4.1.1 | nodeId     | String | 否   | 节点编号                   |
| 4.1.2 | nodeType   | String | 否   | 节点类型                   |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "nodeId": "626e1f1df03e217a7a25361444b857ec68003482aabfb24645a67111cbd96ceedc998975e158475605e38b899bc97be7283006a0171f4ec4796972ff6ad55b1a",
      "nodeType": "sealer"
    },
    {
      "nodeId": "cd3a0d965ca5e5de9edce69245db827a3a253e4868e074020c3f5fb83ca0ae884d5705940c1fc1de550874de0f02374e83eaeb5317b819e420a8ff2e07e4b84c",
      "nodeType": "sealer"
    }
  ],
  "totalCount": 2
}
```

- 失败：

```
{
  "code": 205002,
  "message": "not fount any front",
  "data": null
}
```

### 3.9 设置群组下节点共识状态

​	可用于节点三种共识状态的切换。分别是共识节点sealer，观察节点observer，游离节点remove。

#### 3.9.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址： **/group/setConsensusStatus**
- 请求方式：POST
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 3.9.2 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型   | 可为空 | 备注                                     |
| ---- | ---------- | ------ | ------ | ---------------------------------------- |
| 1    | chainId    | Int    | 否     | 链编号                                   |
| 2    | groupId    | Int    | 否     | 群组编号                                 |
| 3    | signUserId | String | 否     | WeBASE-Sign签名用户编号                  |
| 4    | nodeId     | String | 否     | 要切换状态节点Id                         |
| 5    | nodeType   | String | 否     | 要设置的节点类型：observer/sealer/remove |
| 6    | reqNodeId  | String | 否     | 调用前置对应的节点Id                     |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/group/setConsensusStatus
```

```
{
  "signUserId": "user100001",
  "chainId": 1001,
  "groupId": 1,
  "nodeId": "626e1f1df03e217a7a25361444b857ec68003482aabfb24645a67111cbd96ceedc998975e158475605e38b899bc97be7283006a0171f4ec4796972ff6ad55b1a",
  "nodeType": "sealer",
  "reqNodeId": "413c788ec4b55e8170815e1c61977bac8c38f2df8670d09868a6099a044c0bff7884b9c30f3fa9c331358fcbded28f8d0211e2ffc48019c9796fa05274ed89b1"
}
```

#### 3.9.3 返回参数

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "msg": "success"
}
```

- 失败：

```
{
    "code": -51000,
    "message": "nodeId already exist"
}
```

### 3.10 获取系统配置列表

​	获取系统配置列表，目前支持tx_count_limit、tx_gas_limit两个参数。

#### 3.10.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址： **/group/getSysConfigList/{chainId}/{groupId}/{nodeId}?pageSize={pageSize}&pageNumber={pageNumber}**
- 请求方式：GET
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 3.10.2 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型   | 可为空 | 备注                 |
| ---- | ---------- | ------ | ------ | -------------------- |
| 1    | chainId    | Int    | 否     | 链编号               |
| 2    | groupId    | Int    | 否     | 群组编号             |
| 3    | nodeId     | String | 否     | 节点Id，指定节点调用 |
| 4    | pageSize   | Int    | 是     | 条数，默认10         |
| 5    | pageNumber | Int    | 是     | 页码，默认1          |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/group/getSysConfigList/1001/1/413c788ec4b55e8170815e1c61977bac8c38f2df8670d09868a6099a044c0bff7884b9c30f3fa9c331358fcbded28f8d0211e2ffc48019c9796fa05274ed89b1?pageSize=10&pageNumber=1
```

#### 3.10.3 返回参数

***1）出参表***

| 序号  | 输出参数    | 类型   |      | 备注                                                 |
| ----- | ----------- | ------ | ---- | ---------------------------------------------------- |
| 1     | code        | Int    | 否   | 返回码，0：成功 其它：失败                           |
| 2     | message     | String | 否   | 描述                                                 |
| 3     | totalCount  | Int    | 否   | 总记录数                                             |
| 4     | data        | List   | 否   | 配置列表                                             |
| 4.1   |             | Object |      | 配置信息对象                                         |
| 4.1.1 | groupId     | Int    | 否   | 群组编号                                             |
| 4.1.2 | configKey   | String | 否   | 配置项，目前支持tx_count_limit、tx_gas_limit两个参数 |
| 4.1.4 | configValue | String | 否   | 配置值                                               |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "groupId": 1,
      "configKey": "tx_count_limit",
      "configValue": "1000"
    },
    {
      "groupId": 1,
      "configKey": "tx_gas_limit",
      "configValue": "300000000"
    }
  ],
  "totalCount": 2
}
```

- 失败：

```
{
  "code": 205002,
  "message": "not fount any front",
  "data": null
}
```

### 3.11 设置系统配置值

​	设置系统配置值，目前支持tx_count_limit、tx_gas_limit两个参数。

#### 3.11.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址： **/group/setSysConfig**
- 请求方式：POST
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 3.11.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型   | 可为空 | 备注                                                 |
| ---- | ----------- | ------ | ------ | ---------------------------------------------------- |
| 1    | chainId     | Int    | 否     | 链编号                                               |
| 2    | groupId     | Int    | 否     | 群组编号                                             |
| 3    | nodeId      | String | 否     | 节点Id，指定节点调用                                 |
| 4    | signUserId  | String | 否     | WeBASE-Sign签名用户编号                              |
| 5    | configKey   | String | 否     | 配置项，目前支持tx_count_limit、tx_gas_limit两个参数 |
| 6    | configValue | String | 否     | 配置值                                               |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/group/setSysConfig
```

```
{
  "signUserId": "user100001",
  "chainId": 1001,
  "configKey": "tx_gas_limit",
  "configValue": "300000000",
  "groupId": 1,
  "nodeId": "413c788ec4b55e8170815e1c61977bac8c38f2df8670d09868a6099a044c0bff7884b9c30f3fa9c331358fcbded28f8d0211e2ffc48019c9796fa05274ed89b1"
}
```

#### 3.11.3 返回参数

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "msg": "success"
}
```

- 失败：

```
{
  "code": 205002,
  "message": "not fount any front",
  "data": null
}
```

### 3.12 获取网络统计日志数据

​	统计日志数据存储在前置H2数据库，前置默认存储一万条，超过将不会从节点日志文件拉取新的数据。此时，获取完现有数据，可以调用**3.14 删除前置统计日志数据**进行删除，数据量少于一万条时，前置自动从节点日志文件拉取新的数据。

#### 3.12.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址： 

```
/group/charging/getNetWorkData/{chainId}/{groupId}/{nodeId}?pageSize={pageSize}&pageNumber={pageNumber}&beginDate={beginDate}&endDate={endDate}
```

- 请求方式：GET
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 3.12.2 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型          | 可为空 | 备注                                                      |
| ---- | ---------- | ------------- | ------ | --------------------------------------------------------- |
| 1    | chainId    | Int           | 否     | 链编号                                                    |
| 2    | groupId    | Int           | 否     | 群组编号                                                  |
| 3    | nodeId     | String        | 否     | 节点Id，指定节点调用                                      |
| 4    | pageSize   | Int           | 是     | 条数，默认10                                              |
| 5    | pageNumber | Int           | 是     | 页码，默认1                                               |
| 6    | beginDate  | LocalDateTime | 是     | 开始时间（yyyy-MM-dd'T'HH:mm:ss.SSS 2019-03-13T00:00:00） |
| 7    | endDate    | LocalDateTime | 是     | 结束时间                                                  |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/group/group/charging/getNetWorkData/1001/1/413c788ec4b55e8170815e1c61977bac8c38f2df8670d09868a6099a044c0bff7884b9c30f3fa9c331358fcbded28f8d0211e2ffc48019c9796fa05274ed89b1?pageSize=2&pageNumber=1&beginDate=2020-03-27T10:30:04&endDate=2020-03-27T17:30:04
```

#### 3.12.3 返回参数

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

- 成功：

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

- 失败：

```
{
  "code": 205002,
  "message": "not fount any front",
  "data": null
}
```

### 3.13 获取交易Gas统计日志数据

​	统计日志数据存储在前置H2数据库，前置默认存储一万条，超过将不会从节点日志文件拉取新的数据。此时，获取完现有数据，可以调用**3.14 删除前置统计日志数据**进行删除，数据量少于一万条时，前置自动从节点日志文件拉取新的数据。

#### 3.13.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址： 

```
/group/charging/getTxGasData/{chainId}/{groupId}/{nodeId}?pageSize={pageSize}&pageNumber={pageNumber}&beginDate={beginDate}&endDate={endDate}&transHash={transHash}
```

- 请求方式：GET
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 3.13.2 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型          | 可为空 | 备注                                                      |
| ---- | ---------- | ------------- | ------ | --------------------------------------------------------- |
| 1    | chainId    | Int           | 否     | 链编号                                                    |
| 2    | groupId    | Int           | 否     | 群组编号                                                  |
| 3    | nodeId     | String        | 否     | 节点Id，指定节点调用                                      |
| 4    | pageSize   | Int           | 是     | 条数，默认10                                              |
| 5    | pageNumber | Int           | 是     | 页码，默认1                                               |
| 6    | beginDate  | LocalDateTime | 是     | 开始时间（yyyy-MM-dd'T'HH:mm:ss.SSS 2019-03-13T00:00:00） |
| 7    | endDate    | LocalDateTime | 是     | 结束时间                                                  |
| 8    | transHash  | String        | 是     | 交易hash，不为空时查询指定hash                            |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/group/group/charging/getTxGasData/1001/1/413c788ec4b55e8170815e1c61977bac8c38f2df8670d09868a6099a044c0bff7884b9c30f3fa9c331358fcbded28f8d0211e2ffc48019c9796fa05274ed89b1?pageSize=2&pageNumber=1&beginDate=2020-03-27T10:30:04&endDate=2020-03-27T17:30:04
```

#### 3.13.3 返回参数

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

- 成功：

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

- 失败：

```
{
  "code": 205002,
  "message": "not fount any front",
  "data": null
}
```

### 3.14 删除前置统计日志数据

​	删除群组下统计日志数据。

#### 3.14.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址：**/group/charging/deleteData/{chainId}/{groupId}/{nodeId}**
- 请求方式：DELETE
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 3.14.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 可为空 | 备注                                                         |
| ---- | ----------- | ------------- | ------ | ------------------------------------------------------------ |
| 1    | chainId     | Int           | 否     | 链编号                                                       |
| 2    | groupId     | Int           | 否     | 群组编号                                                     |
| 3    | nodeId      | String        | 否     | 节点Id，指定节点调用                                         |
| 4    | type        | Int           | 否     | 删除数据类型（1-网络统计数据；2-交易gas数据）                |
| 5    | keepEndDate | LocalDateTime | 否     | 保留截止时间（yyyy-MM-dd'T'HH:mm:ss.SSS 2019-03-13T00:00:00） |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/group/charging/deleteData/1001/1/413c788ec4b55e8170815e1c61977bac8c38f2df8670d09868a6099a044c0bff7884b9c30f3fa9c331358fcbded28f8d0211e2ffc48019c9796fa05274ed89b1?type=2&keepEndDate=2020-01-27T17%3A30%3A04
```

#### 3.14.3 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data     | object | 否   | 处理条数                   |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": 5
}
```

- 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

## 4 节点管理模块

### 4.1 查询节点信息列表

#### 4.1.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址：**/node/nodeList/{chainId}/{groupId}/{pageNumber}/{pageSize}?nodeId={nodeId}**
- 请求方式：GET
- 返回格式：JSON

#### 4.1.2 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型   | 可为空 | 备注       |
| ---- | ---------- | ------ | ------ | ---------- |
| 1    | chainId    | int    | 否     | 链编号     |
| 2    | groupId    | int    | 否     | 群组编号   |
| 3    | pageSize   | Int    | 否     | 每页记录数 |
| 4    | pageNumber | Int    | 否     | 当前页码   |
| 5    | nodeId     | String | 是     | 节点Id     |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/node/nodeList/100001/300001/1/10?nodeId=
```

#### 4.1.3 返回参数 

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
| 4.1.5  | nodeActive  | int           | 否   | 共识状态（1正常，2不正常）       |
| 4.1.6  | nodeIp      | string        | 否   | 节点ip                     |
| 4.1.7  | P2pPort     | int           | 否   | 节点p2p端口                |
| 4.1.8  | description | String        | 否   | 备注                       |
| 4.1.9  | blockNumber | BigInteger    | 否   | 节点块高                   |
| 4.1.10 | pbftView    | BigInteger    | 否   | Pbft view                  |
| 4.1.11 | createTime  | LocalDateTime | 否   | 落库时间                   |
| 4.1.12 | modifyTime  | LocalDateTime | 否   | 修改时间                   |

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
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### ~~4.2 查询节点信息~~（废弃，可通过4.1查询）

​	节点和前置一一对应，节点编号可以从前置列表获取。

#### 4.2.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址：**/node/nodeInfo/{chainId}/{groupId}/{nodeId}**
- 请求方式：GET
- 返回格式：JSON

#### 4.2.2 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型   | 可为空 | 备注     |
| ---- | -------- | ------ | ------ | -------- |
| 1    | chainId  | Int    | 否     | 链编号   |
| 2    | groupId  | Int    | 否     | 群组id   |
| 3    | nodeId   | String | 否     | 节点编号 |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/node/nodeInfo/100001/1/78e467957af3d0f77e19b952a740ba8c53ac76913df7dbd48d7a0fe27f4c902b55e8543e1c4f65b4a61695c3b490a5e8584149809f66e9ffc8c05b427e9d3ca2
```

#### 4.2.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |      | 备注                       |
| ---- | ----------- | ------------- | ---- | -------------------------- |
| 1    | code        | Int           | 否   | 返回码，0：成功 其它：失败 |
| 2    | message     | String        | 否   | 描述                       |
| 3    |             | Object        |      | 节点信息对象               |
| 3.1  | chainId     | Int           | 否   | 链编号                     |
| 3.2  | nodeId      | String        | 否   | 节点编号                   |
| 3.3  | nodeName    | String        | 否   | 节点名称                   |
| 3.4  | groupId     | Int           | 否   | 所属群组编号               |
| 3.5  | nodeActive  | Int           | 否   | 共识状态（1正常，2不正常）       |
| 3.6  | nodeIp      | String        | 否   | 节点ip                     |
| 3.7  | P2pPort     | Int           | 否   | 节点p2p端口                |
| 3.8  | description | String        | 否   | 备注                       |
| 3.9  | blockNumber | BigInteger    | 否   | 节点块高                   |
| 3.10 | pbftView    | BigInteger    | 否   | Pbft view                  |
| 3.11 | createTime  | LocalDateTime | 否   | 落库时间                   |
| 3.12 | modifyTime  | LocalDateTime | 否   | 修改时间                   |

***2）出参示例***

- 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "chainId": 100001,
        "nodeId": "78e467957af3d0f77e19b952a740ba8c53ac76913df7dbd48d7a0fe27f4c902b55e8543e1c4f65b4a61695c3b490a5e8584149809f66e9ffc8c05b427e9d3ca2",
        "nodeName": "1_78e467957af3d0f77e19b952a740ba8c53ac76913df7dbd48d7a0fe27f4c902b55e8543e1c4f65b4a61695c3b490a5e8584149809f66e9ffc8c05b",
        "groupId": 1,
        "nodeIp": "127.0.0.1",
        "p2pPort": 10303,
        "description": null,
        "blockNumber": 133,
        "pbftView": 5852,
        "nodeActive": 1,
        "createTime": "2019-02-14 17:47:00",
        "modifyTime": "2019-03-15 11:14:29"
    }
}
```

- 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 4.3 获取区块高度

​	指定节点获取区块高度。节点和前置一一对应，节点编号可以从前置列表获取。

#### 4.3.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址：**/node/getBlockNumber/{chainId}/{groupId}/{nodeId}**
- 请求方式：GET
- 返回格式：JSON

#### 4.3.2 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型   | 可为空 | 备注     |
| ---- | -------- | ------ | ------ | -------- |
| 1    | chainId  | Int    | 否     | 链编号   |
| 2    | groupId  | Int    | 否     | 群组编号 |
| 3    | nodeId   | String | 否     | 节点编号 |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/node/getBlockNumber/1001/1/78e467957af3d0f77e19b952a740ba8c53ac76913df7dbd48d7a0fe27f4c902b55e8543e1c4f65b4a61695c3b490a5e8584149809f66e9ffc8c05b427e9d3ca2
```

#### 4.3.3 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data     | Object |      | 块高                       |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": 74
}
```

- 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 4.4 根据区块高度获取区块信息

​	指定节点根据区块高度获取区块信息。节点和前置一一对应，节点编号可以从前置列表获取。

#### 4.4.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址：**/node/getBlockByNumber/{chainId}/{groupId}/{nodeId}/{blockNumber}**
- 请求方式：GET
- 返回格式：JSON

#### 4.4.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型       | 可为空 | 备注     |
| ---- | ----------- | ---------- | ------ | -------- |
| 1    | chainId     | Int        | 否     | 链编号   |
| 2    | groupId     | Int        | 否     | 群组编号 |
| 3    | nodeId      | String     | 否     | 节点编号 |
| 4    | blockNumber | BigInteger | 否     | 区块高度 |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/node/getBlockByNumber/1001/1/78e467957af3d0f77e19b952a740ba8c53ac76913df7dbd48d7a0fe27f4c902b55e8543e1c4f65b4a61695c3b490a5e8584149809f66e9ffc8c05b427e9d3ca2/1
```

#### 4.4.3 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data     | Object |      | 区块信息                   |

***2）出参示例***

- 成功：

```
  "code": 0,
  "message": "success",
  "data": {
    "number": 1,
    "hash": "0x74ce7bf9daea04cfc9f69a2269f5f524dc62fcc19c7c649d56ded98c064321dd",
    "parentHash": "0xcd55822ef3c4bf20cd12a110e0d7d14e436385dd68ed133e4bf48183208943dc",
    "nonce": 0,
    "sha3Uncles": null,
    "logsBloom": "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
    "transactionsRoot": "0x623f3f6b4a0bf166d70001876dd5ce6af6d215aa4282e390580e66f65f652eb5",
    "stateRoot": "0x286b6bb8045118b1f4429f4155e71847cf2c021dce78bf1ef780c5d131dfe0f2",
    "receiptsRoot": "0x5c15415b928ba2726259094659d3753d752e009fd5c36d4e86138e7260890553",
    "author": null,
    "sealer": "0x1",
    "mixHash": null,
    "extraData": [],
    "gasLimit": 0,
    "gasUsed": 0,
    "timestamp": 1577777367654,
    "transactions": [
      {
        "hash": "0x2bf33fff3b81d74548079a669333aef601d4d2acaf8d33a31687fac8d5d9c815",
        "nonce": 4.2909445613494797e+74,
        "blockHash": "0x74ce7bf9daea04cfc9f69a2269f5f524dc62fcc19c7c649d56ded98c064321dd",
        "blockNumber": 1,
        "transactionIndex": 0,
        "from": "0x42446154be80379b68debfdb06682d29d084fad4",
        "to": null,
        "value": 0,
        "gasPrice": 1,
        "gas": 100000000,
        "input": "0xxx",
        "creates": null,
        "publicKey": null,
        "raw": null,
        "r": null,
        "s": null,
        "v": 0,
        "blockNumberRaw": "1",
        "transactionIndexRaw": "0",
        "nonceRaw": "429094456134947991292268568258086729239801142894854477452577045806616816236",
        "gasRaw": "100000000",
        "valueRaw": "0",
        "gasPriceRaw": "1"
      }
    ],
    "uncles": null,
    "sealerList": [
      "626e1f1df03e217a7a25361444b857ec68003482aabfb24645a67111cbd96ceedc998975e158475605e38b899bc97be7283006a0171f4ec4796972ff6ad55b1a",
      "cd3a0d965ca5e5de9edce69245db827a3a253e4868e074020c3f5fb83ca0ae884d5705940c1fc1de550874de0f02374e83eaeb5317b819e420a8ff2e07e4b84c"
    ],
    "timestampRaw": "1577777367654",
    "nonceRaw": "0",
    "gasUsedRaw": "0",
    "gasLimitRaw": "0",
    "numberRaw": "1"
  }
}
```

- 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 4.5 获取群组交易总数信息

​	指定节点获取群组交易总数信息。节点和前置一一对应，节点编号可以从前置列表获取。

#### 4.5.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址：**/getTotalTransactionCount/{chainId}/{nodeId}/{groupId}**
- 请求方式：GET
- 返回格式：JSON

#### 4.5.2 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型   | 可为空 | 备注     |
| ---- | -------- | ------ | ------ | -------- |
| 1    | chainId  | Int    | 否     | 链编号   |
| 2    | groupId  | Int    | 否     | 群组编号 |
| 3    | nodeId   | String | 否     | 节点编号 |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/node/getTotalTransactionCount/1001/1/78e467957af3d0f77e19b952a740ba8c53ac76913df7dbd48d7a0fe27f4c902b55e8543e1c4f65b4a61695c3b490a5e8584149809f66e9ffc8c05b427e9d3ca2
```

#### 4.5.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型   |      | 备注                       |
| ---- | ----------- | ------ | ---- | -------------------------- |
| 1    | code        | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message     | String | 否   | 描述                       |
| 3    | data        | Object |      |                            |
| 3.1  | txSum       | Int    | 否   | 交易总数                   |
| 3.2  | blockNumber | Int    | 否   | 当前块高                   |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": {
    "txSum": 74,
    "blockNumber": 74
  }
}
```

- 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 4.6 根据交易hash获取交易信息

​	指定节点根据交易hash获取交易信息。节点和前置一一对应，节点编号可以从前置列表获取。

#### 4.6.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址：**/node/getTransactionByHash/{chainId}/{groupId}/{nodeId}/{transHash}**
- 请求方式：GET
- 返回格式：JSON

#### 4.6.2 请求参数

***1）入参表***

| 序号 | 输入参数  | 类型   | 可为空 | 备注     |
| ---- | --------- | ------ | ------ | -------- |
| 1    | chainId   | Int    | 否     | 链编号   |
| 2    | groupId   | Int    | 否     | 群组编号 |
| 3    | nodeId    | String | 否     | 节点编号 |
| 4    | transHash | String | 否     | 交易hash |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/node/getTransactionByHash/1001/1/78e467957af3d0f77e19b952a740ba8c53ac76913df7dbd48d7a0fe27f4c902b55e8543e1c4f65b4a61695c3b490a5e8584149809f66e9ffc8c05b427e9d3ca2/0x2bf33fff3b81d74548079a669333aef601d4d2acaf8d33a31687fac8d5d9c815
```

#### 4.6.3 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data     | Object |      | 交易信息                   |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": {
    "hash": "0x2bf33fff3b81d74548079a669333aef601d4d2acaf8d33a31687fac8d5d9c815",
    "nonce": 4.2909445613494797e+74,
    "blockHash": "0x74ce7bf9daea04cfc9f69a2269f5f524dc62fcc19c7c649d56ded98c064321dd",
    "blockNumber": 1,
    "transactionIndex": 0,
    "from": "0x42446154be80379b68debfdb06682d29d084fad4",
    "to": "0x0000000000000000000000000000000000000000",
    "value": 0,
    "gasPrice": 1,
    "gas": 100000000,
    "input": "0xxxx",
    "creates": null,
    "publicKey": null,
    "raw": null,
    "r": null,
    "s": null,
    "v": 0,
    "blockNumberRaw": "1",
    "transactionIndexRaw": "0",
    "nonceRaw": "429094456134947991292268568258086729239801142894854477452577045806616816236",
    "gasRaw": "100000000",
    "valueRaw": "0",
    "gasPriceRaw": "1"
  }
}
```

- 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 4.7 根据交易hash获取交易回执信息

​	指定节点根据交易hash获取交易回执信息。节点和前置一一对应，节点编号可以从前置列表获取。

#### 4.7.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址：**/node/getTransactionReceipt/{chainId}/{groupId}/{nodeId}/{transHash}**
- 请求方式：GET
- 返回格式：JSON

#### 4.7.2 请求参数

***1）入参表***

| 序号 | 输入参数  | 类型   | 可为空 | 备注     |
| ---- | --------- | ------ | ------ | -------- |
| 1    | chainId   | Int    | 否     | 链编号   |
| 2    | groupId   | Int    | 否     | 群组编号 |
| 3    | nodeId    | String | 否     | 节点编号 |
| 4    | transHash | String | 否     | 交易hash |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/node/getTransactionReceipt/1001/1/78e467957af3d0f77e19b952a740ba8c53ac76913df7dbd48d7a0fe27f4c902b55e8543e1c4f65b4a61695c3b490a5e8584149809f66e9ffc8c05b427e9d3ca2/0x2bf33fff3b81d74548079a669333aef601d4d2acaf8d33a31687fac8d5d9c815
```

#### 4.7.3 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否   | 描述                       |
| 3    | data     | Object |      | 交易回执信息               |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": {
    "transactionHash": "0x2bf33fff3b81d74548079a669333aef601d4d2acaf8d33a31687fac8d5d9c815",
    "transactionIndex": 0,
    "blockHash": "0x74ce7bf9daea04cfc9f69a2269f5f524dc62fcc19c7c649d56ded98c064321dd",
    "blockNumber": 1,
    "gasUsed": 371053,
    "contractAddress": "0xff15a64b529be2538826acd6bd436ebdedbc0557",
    "root": "0x286b6bb8045118b1f4429f4155e71847cf2c021dce78bf1ef780c5d131dfe0f2",
    "status": "0x0",
    "message": null,
    "from": "0x42446154be80379b68debfdb06682d29d084fad4",
    "to": "0x0000000000000000000000000000000000000000",
    "input": "0xxxxx",
    "output": "0x",
    "logs": [],
    "logsBloom": "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
  }
}
```

- 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

## 5 合约管理模块  

### 5.1 编译合约

​	接口参数为合约文件压缩成zip并Base64编码后的字符串。合约文件需要放在同级目录压缩，涉及引用请使用"./XXX.sol"。可参考测试类ContractControllerTest的testCompileContract()方法。国密和非国密编译的bytecodeBin不一样，合约管理模块以国密为例。

#### 5.1.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址：**/contract/compile**
- 请求方式：POST
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 5.1.2 请求参数

***1）入参表***

| 序号 | 输入参数          | 类型   | 可为空 | 备注                                        |
| ---- | ----------------- | ------ | ------ | ------------------------------------------- |
| 1    | chainId           | Int    | 否     | 链编号                                      |
| 2    | nodeId            | String | 否     | 节点编号                                    |
| 3    | contractZipBase64 | String | 是     | 合约源码（合约文件压缩成zip，并Base64编码） |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/contract/compile
```

```
{
  "chainId": 1001,
  "contractZipBase64": "UEsDBBQAAAAIAIqMeFAi98KgkQAAAPwAAAAOAAAASGVsbG9Xb3JsZC5zb2xdjjELwjAQhfdC/8ON7VJE3Iq7k4uDmxDSMwSSi1yugkj/u7GJNPjGe/e+9x6sjFcQg7OTlRfcdsNh2I9towMJKy1wQufCNbCb3m0DSVHYkgFSHsd8wSeSwAXlnG5d5ffl4T6TFhsIDErXJ3QUlRKMMjPFkui//Kzi1B3LHykm0q+pTqK32xRaB2StsCNtuOUDUEsBAj8AFAAAAAgAiox4UCL3wqCRAAAA/AAAAA4AJAAAAAAAAAAgAAAAAAAAAEhlbGxvV29ybGQuc29sCgAgAAAAAAABABgA3EMdrL8B1gGPz3r5xAjWAX8gr5/Rr9UBUEsFBgAAAAABAAEAYAAAAL0AAAAAAA==",
  "nodeId": "a89e1fcb189ad740636bbef814388f2782a577cfc8ee9d6e0751bfbb4e3ddb4f0eadde82d5108bc6f3734aef4b04eafcb0911a2166bf47f309c16e31740548d2"
}
```

#### 5.1.3 返回参数 

***1）出参表***

| 序号  | 输出参数       | 类型   | 可为空 | 备注                              |
| ----- | -------------- | ------ | ------ | --------------------------------- |
| 1     | code           | Int    | 否     | 返回码，0：成功 其它：失败        |
| 2     | message        | String | 否     | 描述                              |
| 3     | data           | List   |        | 列表                              |
| 3.1   |                | Object |        | 信息对象                          |
| 3.1.1 | contractName   | String | 否     | 合约名称                          |
| 3.1.2 | contractAbi    | String | 否     | 编译合约生成的abi文件内容         |
| 3.1.3 | bytecodeBin    | String | 否     | 合约bytecode binary，用于部署合约 |
| 3.1.4 | contractSource | String | 否     | 单个合约内容Base64编码            |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "contractName": "HelloWorld",
      "contractAbi": "[{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"name\":\"name\",\"type\":\"string\"}],\"name\":\"SetName\",\"type\":\"event\"}]",
      "contractSource": "cHJhZ21hIHNvbGlkaXR5IF4wLjQuMjsNCmNvbnRyYWN0IEhlbGxvV29ybGR7DQogICAgc3RyaW5nIG5hbWU7DQogICAgZXZlbnQgU2V0TmFtZShzdHJpbmcgbmFtZSk7DQogICAgZnVuY3Rpb24gZ2V0KCljb25zdGFudCByZXR1cm5zKHN0cmluZyl7DQogICAgICAgIHJldHVybiBuYW1lOw0KICAgIH0NCiAgICBmdW5jdGlvbiBzZXQoc3RyaW5nIG4pew0KICAgICAgICBlbWl0IFNldE5hbWUobik7DQogICAgICAgIG5hbWU9bjsNCiAgICB9DQp9",
      "bytecodeBin": "608060405234801561001057600080fd5b50610373806100206000396000f30060806040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063299f7f9d146100515780633590b49f146100e1575b600080fd5b34801561005d57600080fd5b5061006661014a565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100a657808201518184015260208101905061008b565b50505050905090810190601f1680156100d35780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156100ed57600080fd5b50610148600480360381019080803590602001908201803590602001908080601f01602080910402602001604051908101604052809392919081815260200183838082843782019150505050505091929192905050506101ec565b005b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156101e25780601f106101b7576101008083540402835291602001916101e2565b820191906000526020600020905b8154815290600101906020018083116101c557829003601f168201915b5050505050905090565b7f05432a43e07f36a8b98100b9cb3631e02f8e796b0a06813610ce8942e972fb81816040518080602001828103825283818151815260200191508051906020019080838360005b8381101561024e578082015181840152602081019050610233565b50505050905090810190601f16801561027b5780820380516001836020036101000a031916815260200191505b509250505060405180910390a1806000908051906020019061029e9291906102a2565b5050565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106102e357805160ff1916838001178555610311565b82800160010185558215610311579182015b828111156103105782518255916020019190600101906102f5565b5b50905061031e9190610322565b5090565b61034491905b80821115610340576000816000905550600101610328565b5090565b905600a165627a7a72305820cff924cb0783dc84e2e107aae1fd09e1e04154b80834c9267a4eaa630997b2b90029"
    }
  ]
}
```

- 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 5.2 保存合约和更新

#### 5.2.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址：**/contract/save**
- 请求方式：POST
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 5.2.2 请求参数

***1）入参表***

| 序号 | 输入参数       | 类型   | 可为空 | 备注                                       |
| ---- | -------------- | ------ | ------ | ------------------------------------------ |
| 1    | chainId        | Int    | 否     | 链编号                                     |
| 2    | groupId        | Int    | 否     | 所属群组编号                               |
| 3    | contractName   | String | 否     | 合约名称                                   |
| 4    | contractSource | String | 是     | 合约源码，Base64编码                       |
| 5    | contractAbi    | String | 是     | 编译合约生成的abi文件内容                  |
| 6    | contractBin    | String | 是     | 合约运行时binary，用于合约解析             |
| 7    | bytecodeBin    | String | 是     | 合约bytecode binary，用于部署合约          |
| 8    | contractId     | String | 是     | 合约编号（为空时表示新增，不为空表示更新） |
| 9    | contractPath   | String | 否     | 合约所在目录                               |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/contract/save
```

```
{
  "bytecodeBin": "608060405234801561001057600080fd5b50610373806100206000396000f30060806040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063299f7f9d146100515780633590b49f146100e1575b600080fd5b34801561005d57600080fd5b5061006661014a565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100a657808201518184015260208101905061008b565b50505050905090810190601f1680156100d35780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156100ed57600080fd5b50610148600480360381019080803590602001908201803590602001908080601f01602080910402602001604051908101604052809392919081815260200183838082843782019150505050505091929192905050506101ec565b005b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156101e25780601f106101b7576101008083540402835291602001916101e2565b820191906000526020600020905b8154815290600101906020018083116101c557829003601f168201915b5050505050905090565b7f05432a43e07f36a8b98100b9cb3631e02f8e796b0a06813610ce8942e972fb81816040518080602001828103825283818151815260200191508051906020019080838360005b8381101561024e578082015181840152602081019050610233565b50505050905090810190601f16801561027b5780820380516001836020036101000a031916815260200191505b509250505060405180910390a1806000908051906020019061029e9291906102a2565b5050565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106102e357805160ff1916838001178555610311565b82800160010185558215610311579182015b828111156103105782518255916020019190600101906102f5565b5b50905061031e9190610322565b5090565b61034491905b80821115610340576000816000905550600101610328565b5090565b905600a165627a7a72305820cff924cb0783dc84e2e107aae1fd09e1e04154b80834c9267a4eaa630997b2b90029",
  "chainId": 1001,
  "contractAbi": "[{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"name\":\"name\",\"type\":\"string\"}],\"name\":\"SetName\",\"type\":\"event\"}]",
  "contractBin": "xxx",
  "contractName": "HelloWorld",
  "contractPath": "/",
  "contractSource": "cHJhZ21hIHNvbGlkaXR5IF4wLjQuMjsNCmNvbnRyYWN0IEhlbGxvV29ybGR7DQogICAgc3RyaW5nIG5hbWU7DQogICAgZXZlbnQgU2V0TmFtZShzdHJpbmcgbmFtZSk7DQogICAgZnVuY3Rpb24gZ2V0KCljb25zdGFudCByZXR1cm5zKHN0cmluZyl7DQogICAgICAgIHJldHVybiBuYW1lOw0KICAgIH0NCiAgICBmdW5jdGlvbiBzZXQoc3RyaW5nIG4pew0KICAgICAgICBlbWl0IFNldE5hbWUobik7DQogICAgICAgIG5hbWU9bjsNCiAgICB9DQp9",
  "groupId": 1
}
```

#### 5.2.3 返回参数 

***1）出参表***

| 序号 | 输出参数        | 类型          |      | 备注                                    |
| ---- | --------------- | ------------- | ---- | --------------------------------------- |
| 1    | code            | Int           | 否   | 返回码，0：成功 其它：失败              |
| 2    | message         | String        | 否   | 描述                                    |
| 3    |                 | Object        |      | 返回信息实体                            |
| 3.1  | contractId      | Int           | 否   | 合约编号                                |
| 3.2  | contractPath    | String        | 否   | 合约所在目录                            |
| 3.3  | contractName    | String        | 否   | 合约名称                                |
| 3.4  | chainId         | Int           | 否   | 链编号                                  |
| 3.5  | groupId         | Int           | 否   | 所属群组编号                            |
| 3.6  | contractStatus  | Int           | 否   | 1未部署，2已部署                        |
| 3.7  | contractType    | Int           | 否   | 合约类型(0-普通合约，1-系统合约，默认0) |
| 3.8  | contractSource  | String        | 否   | 合约源码                                |
| 3.9  | contractAbi     | String        | 是   | 编译合约生成的abi文件内容               |
| 3.10 | contractBin     | String        | 是   | 合约运行时binary，用于合约解析          |
| 3.11 | bytecodeBin     | String        | 是   | 合约bytecode binary，用于部署合约       |
| 3.12 | contractAddress | String        | 是   | 合约地址                                |
| 3.13 | deployTime      | LocalDateTime | 是   | 部署时间                                |
| 3.14 | description     | String        | 是   | 备注                                    |
| 3.15 | createTime      | LocalDateTime | 否   | 创建时间                                |
| 3.16 | modifyTime      | LocalDateTime | 是   | 修改时间                                |

***2）出参示例***

- 成功：

```
{
  "code": 0,
  "message": "success",
  "data": {
    "contractId": 400003,
    "contractPath": "/",
    "contractName": "HelloWorld",
    "contractStatus": 1,
    "chainId": 1001,
    "groupId": 1,
    "contractType": 0,
    "contractSource": "cHJhZ21hIHNvbGlkaXR5IF4wLjQuMjsNCmNvbnRyYWN0IEhlbGxvV29ybGR7DQogICAgc3RyaW5nIG5hbWU7DQogICAgZXZlbnQgU2V0TmFtZShzdHJpbmcgbmFtZSk7DQogICAgZnVuY3Rpb24gZ2V0KCljb25zdGFudCByZXR1cm5zKHN0cmluZyl7DQogICAgICAgIHJldHVybiBuYW1lOw0KICAgIH0NCiAgICBmdW5jdGlvbiBzZXQoc3RyaW5nIG4pew0KICAgICAgICBlbWl0IFNldE5hbWUobik7DQogICAgICAgIG5hbWU9bjsNCiAgICB9DQp9",
    "contractAbi": "[{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"name\":\"name\",\"type\":\"string\"}],\"name\":\"SetName\",\"type\":\"event\"}]",
    "contractBin": "xxx",
    "bytecodeBin": "608060405234801561001057600080fd5b50610373806100206000396000f30060806040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063299f7f9d146100515780633590b49f146100e1575b600080fd5b34801561005d57600080fd5b5061006661014a565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100a657808201518184015260208101905061008b565b50505050905090810190601f1680156100d35780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156100ed57600080fd5b50610148600480360381019080803590602001908201803590602001908080601f01602080910402602001604051908101604052809392919081815260200183838082843782019150505050505091929192905050506101ec565b005b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156101e25780601f106101b7576101008083540402835291602001916101e2565b820191906000526020600020905b8154815290600101906020018083116101c557829003601f168201915b5050505050905090565b7f05432a43e07f36a8b98100b9cb3631e02f8e796b0a06813610ce8942e972fb81816040518080602001828103825283818151815260200191508051906020019080838360005b8381101561024e578082015181840152602081019050610233565b50505050905090810190601f16801561027b5780820380516001836020036101000a031916815260200191505b509250505060405180910390a1806000908051906020019061029e9291906102a2565b5050565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106102e357805160ff1916838001178555610311565b82800160010185558215610311579182015b828111156103105782518255916020019190600101906102f5565b5b50905061031e9190610322565b5090565b61034491905b80821115610340576000816000905550600101610328565b5090565b905600a165627a7a72305820cff924cb0783dc84e2e107aae1fd09e1e04154b80834c9267a4eaa630997b2b90029",
    "contractAddress": null,
    "deployTime": null,
    "description": null,
    "createTime": "2020-04-02 16:17:20",
    "modifyTime": "2020-04-02 16:17:20"
  }
}
```

- 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 5.3 查询合约列表 


#### 5.3.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/contract/contractList**
* 请求方式：POST
* 返回格式：JSON

#### 5.3.2 请求参数


***1）入参表***

| 序号 | 输入参数    | 类型          | 可为空 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1 | chainId | Int | 否 | 链编号 |
| 1      | groupId       | Int           | 否     | 群组id                                          |
| 2      | contractName       | String           | 是    | 合约名                             |
| 3      | contractAddress    | String           | 是    | 合约地址                               |
| 4      | pageSize        | Int           | 是    | 每页记录数                                      |
| 5      | pageNumber      | Int           | 是    | 当前页码                                        |
| 6      | contractStatus      | Int           | 是    | 1未部署，2已部署                        |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/contract/contractList
```

```
{
  "chainId": 1001,
  "groupId": 1
}
```

#### 5.3.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1      | code            | Int           | 否     | 返回码，0：成功 其它：失败                      |
| 2      | message         | String        | 否     | 描述                                            |
| 3      | totalCount      | Int           | 否     | 总记录数                                        |
| 4      | data            | List          | 是     | 列表                                            |
| 5.1    |                 | Object         |        | 返回信息实体                                    |
| 5.1.1  | contractId      | int           | 否     | 合约编号                                        |
| 5.1.2  | contractPath    | String        | 否     | 合约所在目录                              |
| 5.1.3  | contractName    | String        | 否     | 合约名称                                        |
| 5.1.4 | chainId | int | 否 | 链编号 |
| 5.1.5  | groupId       | Int           | 否     | 所属群组编号                                    |
| 5.1.6  | contractStatus      | int           | 否     | 1未部署，2已部署                        |
| 5.1.7  | contractType    | Int           | 否     | 合约类型(0-普通合约，1-系统合约)                |
| 5.1.8  | contractSource  | String        | 否     | 合约源码                                        |
| 5.1.9  | contractAbi     | String        | 是     | 编译合约生成的abi文件内容                       |
| 5.1.10 | contractBin     | String        | 是     | 合约运行时binary，用于合约解析               |
| 5.1.11 | bytecodeBin     | String        | 是     | 合约bytecode binary，用于部署合约                 |
| 5.1.12 | contractAddress | String        | 是     | 合约地址                                        |
| 5.1.13 | deployTime      | LocalDateTime | 是     | 部署时间                                        |
| 5.1.14 | description     | String        | 是     | 备注                                            |
| 5.1.15 | createTime      | LocalDateTime | 否     | 创建时间                                        |
| 5.1.16 | modifyTime | LocalDateTime | 是 | 修改时间 |
***2）出参示例***

* 成功：
```
{
  "code": 0,
  "message": "success",
  "data": [
    {
      "contractId": 400003,
      "contractPath": "/",
      "contractName": "HelloWorld",
      "contractStatus": 1,
      "chainId": 1001,
      "groupId": 1,
      "contractType": 0,
      "contractSource": "cHJhZ21hIHNvbGlkaXR5IF4wLjQuMjsNCmNvbnRyYWN0IEhlbGxvV29ybGR7DQogICAgc3RyaW5nIG5hbWU7DQogICAgZXZlbnQgU2V0TmFtZShzdHJpbmcgbmFtZSk7DQogICAgZnVuY3Rpb24gZ2V0KCljb25zdGFudCByZXR1cm5zKHN0cmluZyl7DQogICAgICAgIHJldHVybiBuYW1lOw0KICAgIH0NCiAgICBmdW5jdGlvbiBzZXQoc3RyaW5nIG4pew0KICAgICAgICBlbWl0IFNldE5hbWUobik7DQogICAgICAgIG5hbWU9bjsNCiAgICB9DQp9",
      "contractAbi": "[{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"name\":\"name\",\"type\":\"string\"}],\"name\":\"SetName\",\"type\":\"event\"}]",
      "contractBin": "xxx",
      "bytecodeBin": "608060405234801561001057600080fd5b50610373806100206000396000f30060806040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063299f7f9d146100515780633590b49f146100e1575b600080fd5b34801561005d57600080fd5b5061006661014a565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100a657808201518184015260208101905061008b565b50505050905090810190601f1680156100d35780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156100ed57600080fd5b50610148600480360381019080803590602001908201803590602001908080601f01602080910402602001604051908101604052809392919081815260200183838082843782019150505050505091929192905050506101ec565b005b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156101e25780601f106101b7576101008083540402835291602001916101e2565b820191906000526020600020905b8154815290600101906020018083116101c557829003601f168201915b5050505050905090565b7f05432a43e07f36a8b98100b9cb3631e02f8e796b0a06813610ce8942e972fb81816040518080602001828103825283818151815260200191508051906020019080838360005b8381101561024e578082015181840152602081019050610233565b50505050905090810190601f16801561027b5780820380516001836020036101000a031916815260200191505b509250505060405180910390a1806000908051906020019061029e9291906102a2565b5050565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106102e357805160ff1916838001178555610311565b82800160010185558215610311579182015b828111156103105782518255916020019190600101906102f5565b5b50905061031e9190610322565b5090565b61034491905b80821115610340576000816000905550600101610328565b5090565b905600a165627a7a72305820cff924cb0783dc84e2e107aae1fd09e1e04154b80834c9267a4eaa630997b2b90029",
      "contractAddress": null,
      "deployTime": null,
      "description": null,
      "createTime": "2020-04-02 16:17:20",
      "modifyTime": "2020-04-02 16:17:20"
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


### 5.4 查询合约信息


#### 5.4.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/contract/{contractId}**
* 请求方式：GET
* 返回格式：JSON

#### 5.4.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 可为空 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | contractId      | int           | 否     | 合约编号                                        |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/contract/400003
```

#### 5.4.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code            | Int           | 否     | 返回码，0：成功 其它：失败                      |
| 2    | message         | String        | 否     | 描述                                            |
| 3    |                 | Object         |        | 返回信息实体                                    |
| 3.1  | contractId      | int           | 否     | 合约编号                                        |
| 3.2  | contractPath    | String        | 否     | 合约所在目录                              |
| 3.3  | contractName    | String        | 否     | 合约名称                                        |
| 3.4 | chainId | int | 否 | 链编号 |
| 3.5  | groupId         | Int           | 否     | 所属群组编号                                    |
| 3.6  | contractStatus  | int           | 否     | 1未部署，2已部署                        |
| 3.7  | contractType    | Int           | 否     | 合约类型(0-普通合约，1-系统合约)                |
| 3.8  | contractSource  | String        | 否     | 合约源码                                        |
| 3.9  | contractAbi     | String        | 是     | 编译合约生成的abi文件内容                       |
| 3.10 | contractBin     | String        | 是     | 合约运行时binary，用于合约解析               |
| 3.11 | bytecodeBin     | String        | 是     | 合约bytecode binary，用于部署合约                 |
| 3.12 | contractAddress | String        | 是     | 合约地址                                        |
| 3.13 | deployTime      | LocalDateTime | 是     | 部署时间                                        |
| 3.14 | description     | String        | 是     | 备注                                            |
| 3.15 | createTime      | LocalDateTime | 否     | 创建时间                                        |
| 3.16 | modifyTime      | LocalDateTime | 是     | 修改时间                                        |

***2）出参示例***

* 成功：
```
{
  "code": 0,
  "message": "success",
  "data": {
    "contractId": 400003,
    "contractPath": "/",
    "contractName": "HelloWorld",
    "contractStatus": 1,
    "chainId": 1001,
    "groupId": 1,
    "contractType": 0,
    "contractSource": "cHJhZ21hIHNvbGlkaXR5IF4wLjQuMjsNCmNvbnRyYWN0IEhlbGxvV29ybGR7DQogICAgc3RyaW5nIG5hbWU7DQogICAgZXZlbnQgU2V0TmFtZShzdHJpbmcgbmFtZSk7DQogICAgZnVuY3Rpb24gZ2V0KCljb25zdGFudCByZXR1cm5zKHN0cmluZyl7DQogICAgICAgIHJldHVybiBuYW1lOw0KICAgIH0NCiAgICBmdW5jdGlvbiBzZXQoc3RyaW5nIG4pew0KICAgICAgICBlbWl0IFNldE5hbWUobik7DQogICAgICAgIG5hbWU9bjsNCiAgICB9DQp9",
    "contractAbi": "[{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"name\":\"name\",\"type\":\"string\"}],\"name\":\"SetName\",\"type\":\"event\"}]",
    "contractBin": "xxx",
    "bytecodeBin": "608060405234801561001057600080fd5b50610373806100206000396000f30060806040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063299f7f9d146100515780633590b49f146100e1575b600080fd5b34801561005d57600080fd5b5061006661014a565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100a657808201518184015260208101905061008b565b50505050905090810190601f1680156100d35780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156100ed57600080fd5b50610148600480360381019080803590602001908201803590602001908080601f01602080910402602001604051908101604052809392919081815260200183838082843782019150505050505091929192905050506101ec565b005b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156101e25780601f106101b7576101008083540402835291602001916101e2565b820191906000526020600020905b8154815290600101906020018083116101c557829003601f168201915b5050505050905090565b7f05432a43e07f36a8b98100b9cb3631e02f8e796b0a06813610ce8942e972fb81816040518080602001828103825283818151815260200191508051906020019080838360005b8381101561024e578082015181840152602081019050610233565b50505050905090810190601f16801561027b5780820380516001836020036101000a031916815260200191505b509250505060405180910390a1806000908051906020019061029e9291906102a2565b5050565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106102e357805160ff1916838001178555610311565b82800160010185558215610311579182015b828111156103105782518255916020019190600101906102f5565b5b50905061031e9190610322565b5090565b61034491905b80821115610340576000816000905550600101610328565b5090565b905600a165627a7a72305820cff924cb0783dc84e2e107aae1fd09e1e04154b80834c9267a4eaa630997b2b90029",
    "contractAddress": null,
    "deployTime": null,
    "description": null,
    "createTime": "2020-04-02 16:17:20",
    "modifyTime": "2020-04-02 16:17:20"
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

### 5.5 部署合约

调用此接口进行合约部署。

构造方法参数（funcParam）为JSON数组，多个参数以逗号分隔（参数为数组时同理），示例：

```
constructor(string s) -> ["aa,bb\"cc"]	// 双引号要转义
constructor(uint n,bool b) -> [1,true]
constructor(bytes b,address[] a) -> ["0x1a",["0x7939E26070BE44E6c4Fc759Ce55C6C8b166d94BE","0xce867fD9afa64175bb50A4Aa0c17fC7C4A3C67D9"]]
```


#### 5.5.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/contract/deploy**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 5.4.2 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 可为空 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1 | chainId | Int | 否 | 链编号 |
| 2    | groupId           | Int            | 否     | 所属群组编号               |
| 3    | contractName      | String         | 否     | 合约名称               |
| 4    | contractSource    | String         | 是    | 合约源码                   |
| 5    | contractAbi       | String         | 否     | 编译合约生成的abi文件内容  |
| 6    | contractBin       | String         | 是    | 合约运行时binary，用于合约解析 |
| 7    | bytecodeBin       | String         | 否     | 合约bytecode binary，用于部署合约 |
| 8    | contractId      | String         | 否     | 合约编号             |
| 9    | contractPath      | String         | 否     | 合约所在目录               |
| 10   | signUserId    | String         | 否     | WeBASE-Sign签名用户编号 |
| 11    | constructorParams | List | 是     | 构造函数入参，JSON数组，多个参数以逗号分隔（参数为数组时同理），如：["str1",["arr1","arr2"]] |
| 12 | nodeId | String | 否 | 节点编号，指定节点调用 |


***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/contract/deploy
```

```
{
  "bytecodeBin": "608060405234801561001057600080fd5b50610373806100206000396000f30060806040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063299f7f9d146100515780633590b49f146100e1575b600080fd5b34801561005d57600080fd5b5061006661014a565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100a657808201518184015260208101905061008b565b50505050905090810190601f1680156100d35780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156100ed57600080fd5b50610148600480360381019080803590602001908201803590602001908080601f01602080910402602001604051908101604052809392919081815260200183838082843782019150505050505091929192905050506101ec565b005b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156101e25780601f106101b7576101008083540402835291602001916101e2565b820191906000526020600020905b8154815290600101906020018083116101c557829003601f168201915b5050505050905090565b7f05432a43e07f36a8b98100b9cb3631e02f8e796b0a06813610ce8942e972fb81816040518080602001828103825283818151815260200191508051906020019080838360005b8381101561024e578082015181840152602081019050610233565b50505050905090810190601f16801561027b5780820380516001836020036101000a031916815260200191505b509250505060405180910390a1806000908051906020019061029e9291906102a2565b5050565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106102e357805160ff1916838001178555610311565b82800160010185558215610311579182015b828111156103105782518255916020019190600101906102f5565b5b50905061031e9190610322565b5090565b61034491905b80821115610340576000816000905550600101610328565b5090565b905600a165627a7a72305820cff924cb0783dc84e2e107aae1fd09e1e04154b80834c9267a4eaa630997b2b90029",
  "chainId": 1001,
  "constructorParams": [
  ],
  "contractAbi": "[{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"name\":\"name\",\"type\":\"string\"}],\"name\":\"SetName\",\"type\":\"event\"}]",
  "contractBin": "xxx",
  "contractId": 400003,
  "contractName": "HelloWorld",
  "contractPath": "/",
  "contractSource": "cHJhZ21hIHNvbGlkaXR5IF4wLjQuMjsNCmNvbnRyYWN0IEhlbGxvV29ybGR7DQogICAgc3RyaW5nIG5hbWU7DQogICAgZXZlbnQgU2V0TmFtZShzdHJpbmcgbmFtZSk7DQogICAgZnVuY3Rpb24gZ2V0KCljb25zdGFudCByZXR1cm5zKHN0cmluZyl7DQogICAgICAgIHJldHVybiBuYW1lOw0KICAgIH0NCiAgICBmdW5jdGlvbiBzZXQoc3RyaW5nIG4pew0KICAgICAgICBlbWl0IFNldE5hbWUobik7DQogICAgICAgIG5hbWU9bjsNCiAgICB9DQp9",
  "groupId": 1,
  "nodeId": "a89e1fcb189ad740636bbef814388f2782a577cfc8ee9d6e0751bfbb4e3ddb4f0eadde82d5108bc6f3734aef4b04eafcb0911a2166bf47f309c16e31740548d2",
  "signUserId": "user1001"
}
```

#### 5.5.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code            | Int           | 否     | 返回码，0：成功 其它：失败                      |
| 2    | message         | String        | 否     | 描述                                            |
| 3    |                 | Object         |        | 返回信息实体                                    |
| 3.1  | contractId      | int           | 否     | 合约编号                                        |
| 3.2  | contractPath    | String        | 否     | 合约所在目录                              |
| 3.3  | contractName    | String        | 否     | 合约名称                                        |
| 3.4 | chainId | int | 否 | 链编号 |
| 3.5  | groupId         | Int           | 否     | 所属群组编号                                    |
| 3.6  | contractStatus  | int           | 否     | 1未部署，2已部署                        |
| 3.7  | contractType    | Int           | 否     | 合约类型(0-普通合约，1-系统合约)                |
| 3.8  | contractSource  | String        | 否     | 合约源码                                        |
| 3.9  | contractAbi     | String        | 是     | 编译合约生成的abi文件内容                       |
| 3.10 | contractBin     | String        | 是     | 合约binary                                      |
| 3.11 | bytecodeBin     | String        | 是     | 合约bin                                         |
| 3.12 | contractAddress | String        | 是     | 合约地址                                        |
| 3.13 | deployTime      | LocalDateTime | 是     | 部署时间                                        |
| 3.14 | description     | String        | 是     | 备注                                            |
| 3.15 | createTime      | LocalDateTime | 否     | 创建时间                                        |
| 3.16 | modifyTime      | LocalDateTime | 是     | 修改时间                                        |


***2）出参示例***
* 成功：
```
{
  "code": 0,
  "message": "success",
  "data": {
    "contractId": 400003,
    "contractPath": "/",
    "contractName": "HelloWorld",
    "contractStatus": 2,
    "chainId": 1001,
    "groupId": 1,
    "contractType": 0,
    "contractSource": "cHJhZ21hIHNvbGlkaXR5IF4wLjQuMjsNCmNvbnRyYWN0IEhlbGxvV29ybGR7DQogICAgc3RyaW5nIG5hbWU7DQogICAgZXZlbnQgU2V0TmFtZShzdHJpbmcgbmFtZSk7DQogICAgZnVuY3Rpb24gZ2V0KCljb25zdGFudCByZXR1cm5zKHN0cmluZyl7DQogICAgICAgIHJldHVybiBuYW1lOw0KICAgIH0NCiAgICBmdW5jdGlvbiBzZXQoc3RyaW5nIG4pew0KICAgICAgICBlbWl0IFNldE5hbWUobik7DQogICAgICAgIG5hbWU9bjsNCiAgICB9DQp9",
    "contractAbi": "[{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"name\":\"name\",\"type\":\"string\"}],\"name\":\"SetName\",\"type\":\"event\"}]",
    "contractBin": "xxx",
    "bytecodeBin": "608060405234801561001057600080fd5b50610373806100206000396000f30060806040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063299f7f9d146100515780633590b49f146100e1575b600080fd5b34801561005d57600080fd5b5061006661014a565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100a657808201518184015260208101905061008b565b50505050905090810190601f1680156100d35780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156100ed57600080fd5b50610148600480360381019080803590602001908201803590602001908080601f01602080910402602001604051908101604052809392919081815260200183838082843782019150505050505091929192905050506101ec565b005b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156101e25780601f106101b7576101008083540402835291602001916101e2565b820191906000526020600020905b8154815290600101906020018083116101c557829003601f168201915b5050505050905090565b7f05432a43e07f36a8b98100b9cb3631e02f8e796b0a06813610ce8942e972fb81816040518080602001828103825283818151815260200191508051906020019080838360005b8381101561024e578082015181840152602081019050610233565b50505050905090810190601f16801561027b5780820380516001836020036101000a031916815260200191505b509250505060405180910390a1806000908051906020019061029e9291906102a2565b5050565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106102e357805160ff1916838001178555610311565b82800160010185558215610311579182015b828111156103105782518255916020019190600101906102f5565b5b50905061031e9190610322565b5090565b61034491905b80821115610340576000816000905550600101610328565b5090565b905600a165627a7a72305820cff924cb0783dc84e2e107aae1fd09e1e04154b80834c9267a4eaa630997b2b90029",
    "contractAddress": "0x377127dbe8c03cf0decf353ac5119f5e7cbcfe97",
    "deployTime": "2020-04-02 16:22:44",
    "description": null,
    "createTime": "2020-04-02 16:17:20",
    "modifyTime": "2020-04-02 16:22:44"
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

### 5.6 发送交易

调用此接口发送交易请求，数据上链或查询结果。

方法入参（funcParam）为JSON数组，多个参数以逗号分隔（参数为数组时同理），示例：

```
function set(string s) -> ["aa,bb\"cc"]	// 双引号要转义
function set(uint n,bool b) -> [1,true]
function set(bytes b,address[] a) -> ["0x1a",["0x7939E26070BE44E6c4Fc759Ce55C6C8b166d94BE","0xce867fD9afa64175bb50A4Aa0c17fC7C4A3C67D9"]]
```


#### 5.6.1 传输协议规范
* 网络传输协议：使用HTTP协议
* 请求地址：**/contract/transaction**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 5.6.2 请求参数


***1）入参表***

| 序号 | 输入参数    | 类型          | 可为空 | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1 | chainId | int | 否 | 链编号 |
| 2    | groupId      | Int            | 否     | 所属群组编号               |
| 3    | signUserId | String  | 否     | WeBASE-Sign签名用户编号 |
| 4    | contractName | String         | 否     | 合约名称                   |
| 5    | contractId      | Int      | 否     | 合约编号               |
| 6    | funcName     | String         | 否     | 合约方法名                 |
| 7    | contractAddress     | String         | 是     | 合约地址   |
| 8   | funcParam    | List | 是     | 合约方法入参，JSON数组，多个参数以逗号分隔（参数为数组时同理），如：["str1",["arr1","arr2"]] |
| 9 | contractAbi | String | 否 | 所调用合约方法的abi，注意格式（传入所有abi可能导致合约重载方法出问题） |
| 10 | nodeId | String | 否 | 节点编号，指定节点调用 |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/contract/transaction
```

```
{
  "chainId": 1001,
  "contractAbi": "[{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"}]",
  "contractId": 400003,
  "contractName": "HelloWorld",
  "funcName": "get",
  "funcParam": [],
  "groupId": 1,
  "nodeId": "a89e1fcb189ad740636bbef814388f2782a577cfc8ee9d6e0751bfbb4e3ddb4f0eadde82d5108bc6f3734aef4b04eafcb0911a2166bf47f309c16e31740548d2",
  "signUserId": "user1001"
}
```


#### 5.6.3 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          |        | 备注                                       |
|------|-------------|---------------|--------|-------------------------------|
| 1    | code         | Int            | 否     | 返回码，0：成功 其它：失败 |
| 2    | message      | String         | 否     | 描述                       |
| 3    | data         | object         | 是     | 返回信息实体（空）         |

***2）出参示例***

- 上链成功：

```
{
  "code": 0,
  "message": "success",
  "data": {
    "transactionHash": "0x150b562cfe3f8432853925bbed13f3ae549dc5083da9f42a5226f5df18094974",
    "transactionIndex": 0,
    "blockHash": "0x70ae837060441a087a12e4b6d70a5d76b7c9af3d97ec97035ffefdbe1836e567",
    "blockNumber": 177303,
    "gasUsed": 44956,
    "contractAddress": "0x0000000000000000000000000000000000000000",
    "root": "0x98372c72262170a0325f7c162feb2c310f7f43f13aeac42349e62784a98efebe",
    "status": "0x0",
    "message": null,
    "from": "0xdb4ed7a548623c219235aa68156f117dff959a17",
    "to": "0x377127dbe8c03cf0decf353ac5119f5e7cbcfe97",
    "input": "0x3590b49f0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000548656c6c6f000000000000000000000000000000000000000000000000000000",
    "output": "0x",
    "logs": [
      {
        "removed": false,
        "logIndex": null,
        "transactionIndex": null,
        "transactionHash": null,
        "blockHash": null,
        "blockNumber": null,
        "address": "0x377127dbe8c03cf0decf353ac5119f5e7cbcfe97",
        "data": "0x0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000548656c6c6f000000000000000000000000000000000000000000000000000000",
        "type": null,
        "topics": [
          "0x05432a43e07f36a8b98100b9cb3631e02f8e796b0a06813610ce8942e972fb81"
        ],
        "transactionIndexRaw": null,
        "logIndexRaw": null,
        "blockNumberRaw": null
      }
    ],
    "logsBloom": "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000"
  }
}
```

* 查询成功：
```
{
  "code": 0,
  "message": "success",
  "data": [
    "Hello"
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

### 5.7 合约状态管理

​	通过预编译合约管理合约状态，根据入参的操作类型进行调用，可以冻结、解冻合约和授权用户操作权限，还可以查询合约状态和合约用户权限列表。

#### 5.7.1 传输协议规范

- 网络传输协议：使用HTTP协议
- 请求地址： **/contract/statusManage**
- 请求方式：POST
- 请求头：Content-type: application/json
- 返回格式：JSON

#### 5.7.2 请求参数

***1）入参表***

| 序号 | 输入参数        | 类型   | 可为空 | 备注                                                         |
| ---- | --------------- | ------ | ------ | ------------------------------------------------------------ |
| 1    | chainId         | Int    | 否     | 链编号                                                       |
| 2    | groupId         | Int    | 否     | 群组编号                                                     |
| 3    | nodeId          | String | 否     | 节点Id                                                       |
| 4    | signUserId      | String | 否     | WeBASE-Sign签名用户编号                                      |
| 5    | contractAddress | String | 否     | 已部署的合约地址                                             |
| 6    | handleType      | String | 否     | 操作类型：freeze-冻结；unfreeze-解冻；grantManager-授权；getStatus-查询合约状态；listManager-查询合约权限列表 |
| 7    | grantAddress    | String | 是     | 授权用户地址，操作类型为grantManager时需传入                 |

***2）入参示例***

```
http://127.0.0.1:5005/WeBASE-Chain-Manager/contract/statusManage
```

```
{
  "chainId": 1001,
  "contractAddress": "0x1d518bf3fb0edceb18519808edf7ad8adeeed792",
  "grantAddress": "",
  "groupId": 1,
  "handleType": "freeze",
  "nodeId": "413c788ec4b55e8170815e1c61977bac8c38f2df8670d09868a6099a044c0bff7884b9c30f3fa9c331358fcbded28f8d0211e2ffc48019c9796fa05274ed89b1",
  "signUserId": "user1001"
}
```

#### 5.7.3 返回参数

***1）出参表***

| 序号 | 输出参数 | 类型   |      | 备注                       |
| ---- | -------- | ------ | ---- | -------------------------- |
| 1    | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 是   | 描述                       |
| 3    | data     | String | 是   | 数据                       |

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
  "code": 205002,
  "message": "not fount any front",
  "data": null
}
```

## 附录 

### 1. 返回码信息列表

| Code   | message                                          | 描述               |
| ------ | ------------------------------------------------ | ------------------ |
| 0      | success                                          | 正常               |
| 105000 | system error                                     | 系统异常           |
| 205000 | invalid front id                                 | 无效的前置编号     |
| 205001 | database exception                               | 数据库异常         |
| 205002 | not fount any front                              | 找不到前置         |
| 205003 | front already exists                             | 前置已存在         |
| 205004 | group id cannot be empty                         | 群组编号不能为空   |
| 205005 | invalid group id                                 | 无效的群组编号     |
| 205006 | save front fail                                  | 保存前置失败       |
| 205007 | request front fail, please check front           | 请求前置失败       |
| 205008 | abiInfo cannot be empty                          | abi信息不能为空    |
| 205009 | contract already exists                          | 合约已存在         |
| 205010 | invalid contract id                              | 无效的合约编号     |
| 205011 | invalid param info                               | 无效的参数         |
| 205012 | contract name cannot be repeated                 | 合约名称不能重复   |
| 205013 | contract has not deploy                          | 合约未部署         |
| 205014 | invalid contract address                         | 无效的合约地址     |
| 205015 | contract has been deployed                       | 合约已部署         |
| 205016 | contract deploy not success                      | 合约部署不成功     |
| 205017 | wrong host or port                               | 地址或端口错误     |
| 205018 | group id already exists                          | 群组编号已存在     |
| 205019 | node not exists                                  | 节点不存在         |
| 205020 | front's encrypt type not match                   | 前置加密类型不匹配 |
| 205021 | chain name already exists                        | 链名称已经存在     |
| 205022 | save chain fail                                  | 保存链失败         |
| 205023 | invalid chain id                                 | 无效的链编号       |
| 205024 | user already exists                              | 用户已存在         |
| 205025 | publicKey cannot be empty                        | 公钥不能为空       |
| 205026 | publicKey's length is 130,address's length is 42 | 公钥或地址长度不对 |
| 205027 | user id cannot be empty                          | 用户编号不能为空   |
| 205028 | invalid user                                     | 无效用户           |
| 205029 | chain id already exists                          | 链编号已存在       |
| 205030 | contract compile error                           | 合约编译错误       |
| 205031 | group generate fail                              | 群组创建失败       |
| 205032 | group operate fail                               | 群组操作失败       |
| 205033 | request node exception                           | 请求节点异常       |
| 305000 | param exception                                  | 参数异常           |