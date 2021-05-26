# 应用接入说明

应用管理是WeBASE管理台提供的一种第三方应用接入功能。其他应用可以通过WeBASE通用API来开发自己的运维管理台。接入的步骤如下：

1. 通过WeBASE管理平台获得注册信息，并通过API向WeBASE注册服务。
2. 通过WeBASE提供的基础能力API和WeBASE连通。

## 签名

### 签名说明

第三方应用从WeBASE管理平台获取注册信息**WeBASE的IP和端口、为应用分配的`appKey`（应用Key）和`appSecret`（应用密码，应用自己保存，不要暴露）**，向WeBASE发送请求时，需要使用应用分配的`appSecret`对请求进行签名。WeBASE收到请求后，根据`appKey`查询应用对应的`appSecret`，使用相同规则对请求进行签名验证。只有在验证通过后，WeBASE才会对请求进行相应的处理。

* 每个URL请求需带以下三个参数：

| 参数名    | 类型   | 描述                 | 参数值        | 备注                                          |
| --------- | ------ | -------------------- | ------------- | --------------------------------------------- |
| timestamp | long   | 请求的时间戳（毫秒） | 1614928857832 | 当前时间戳，有效期默认5分钟                   |
| appKey    | String | 应用Key              | fdsf78aW      | 从WeBASE管理平台获取                          |
| signature | String | 签名串               | 15B8F38...    | 从WeBASE管理平台获取appSecret对appKey做的签名 |

### 签名规则

使用MD5对`timestamp`、`appKey`加密并转大写得到签名值`signature`

```
public static String md5Encrypt(long timestamp, String appKey, String appSecret) {
        try {
            String dataStr = timestamp + appKey + appSecret;
            MessageDigest m = MessageDigest.getInstance("MD5");
            m.update(dataStr.getBytes("UTF8"));
            byte s[] = m.digest();
            String result = "";
            for (int i = 0; i < s.length; i++) {
                result += Integer.toHexString((0x000000FF & s[i]) | 0xFFFFFF00).substring(6);
            }
            return result.toUpperCase();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }
```

### 示例

* 参数值：

| 参数      | 参数值                             |
| --------- | ---------------------------------- |
| timestamp | `1614928857832`                    |
| appKey    | `fdsf78aW`                         |
| appSecret | `oMdarsqFOsSKThhvXagTpNdoOcIJxUwQ` |

* 签名后的 `signature` 为

```Bash
EEFD7CD030E6B311AA85B053A90E8A31
```



<span id="api"></span>

## WeBASE通用API


## 1 应用管理模块

###  1.1 应用注册


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/api/appRegister?appKey={appKey}&signature={signature}&timestamp={timestamp}**
* 请求方式：POST
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型   | 可为空 | 备注         |
| ---- | -------- | ------ | ------ | ------------ |
| 1    | appIp    | String | 否     | 应用ip       |
| 2    | appPort  | int    | 否     | 应用端口     |
| 3    | appLink  | String | 否     | 应用服务链接 |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/api/appRegister?timestamp=1614928857832&appKey=fdsf78aW&signature=EEFD7CD030E6B311AA85B053A90E8A31
```

```
{
  "appIp": "127.0.0.1",
  "appPort": 8080,
  "appLink": "http://127.0.0.1:8080/sample"
}
```

#### 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   | 可为空 | 备注                       |
| ---- | -------- | ------ | ------ | -------------------------- |
| 1    | code     | int    | 否     | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否     | 描述                       |
| 3    | data     | object | 是     | 返回信息实体（空）         |

***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "Success",
    "data": {}
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

## 2 系统账号信息模块

###  2.1 查询帐号列表

查询系统登录账号列表，不返回密码


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/api/accountList?appKey={appKey}&signature={signature}&timestamp={timestamp}&pageNumber={pageNumber}&pageSize={pageSize}&account={account}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型   | 可为空 | 备注                             |
| ---- | ---------- | ------ | ------ | -------------------------------- |
| 1    | pageSize   | int    | 否     | 每页记录数                       |
| 2    | pageNumber | int    | 否     | 当前页码                         |
| 3    | account    | String | 是     | 帐号名，不为空时查询具体账号信息 |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/api/accountList?timestamp=1614928857832&appKey=fdsf78aW&signature=EEFD7CD030E6B311AA85B053A90E8A31&pageNumber=1&pageSize=10&account=
```


#### 返回参数 

***1）出参表***

| 序号  | 输出参数      | 类型          | 可为空 | 备注                       |
| ----- | ------------- | ------------- | ------ | -------------------------- |
| 1     | code          | int           | 否     | 返回码，0：成功 其它：失败 |
| 2     | message       | String        | 否     | 描述                       |
| 3     | totalCount    | int           | 否     | 总记录数                   |
| 4     | data          | List          | 是     | 信息列表                   |
| 4.1   |               | Object        |        | 信息对象                   |
| 4.1.1 | account       | String        | 否     | 帐号                       |
| 4.1.2 | roleId        | int           | 否     | 所属角色                   |
| 4.1.3 | roleName      | String        | 否     | 角色名称                   |
| 4.1.4 | roleNameZh    | String        | 否     | 角色中文名                 |
| 4.1.5 | loginFailTime | int           | 是     | 登录失败次数               |
| 4.1.6 | accountStatus | int           | 否     | 帐号状态                   |
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

### 2.2 查询角色列表


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**api/roleList?appKey={appKey}&signature={signature}&timestamp={timestamp}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/api/roleList?timestamp=1614928857832&appKey=fdsf78aW&signature=EEFD7CD030E6B311AA85B053A90E8A31
```

#### 返回参数 

***1）出参表***

| 序号  | 输出参数    | 类型          |      | 备注                       |
| ----- | ----------- | ------------- | ---- | -------------------------- |
| 1     | code        | Int           | 否   | 返回码，0：成功 其它：失败 |
| 2     | message     | String        | 否   | 描述                       |
| 3     | totalCount  | Int           | 否   | 总记录数                   |
| 4     | data        | List          | 否   | 组织列表                   |
| 4.1   |             | Object        |      | 组织信息对象               |
| 4.1.1 | roleId      | Int           | 否   | 角色编号                   |
| 4.1.2 | roleName    | String        | 否   | 角色名称                   |
| 4.1.3 | roleNameZh  | String        | 否   | 角色中文名称               |
| 4.1.4 | roleStatus  | Int           | 否   | 状态（1-正常2-无效） 默认1 |
| 4.1.5 | description | String        | 否   | 备注                       |
| 4.1.6 | createTime  | LocalDateTime | 否   | 创建时间                   |
| 4.1.7 | modifyTime  | LocalDateTime | 否   | 修改时间                   |


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

### 2.3 新增帐号


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/api/accountAdd?appKey={appKey}&signature={signature}&timestamp={timestamp}**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数   | 类型   | 可为空 | 备注               |
| ---- | ---------- | ------ | ------ | ------------------ |
| 1    | account    | String | 否     | 帐号名称           |
| 2    | accountPwd | String | 否     | 登录密码（sha256） |
| 3    | roleId     | int    | 否     | 所属角色编号       |
| 4    | email      | String | 否     | email地址          |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/api/accountAdd?timestamp=1614928857832&appKey=fdsf78aW&signature=EEFD7CD030E6B311AA85B053A90E8A31
```

```
{
    "account": "testAccount",
    "accountPwd": "3f21a8490cef2bfb60a9702e9d2ddb7a805c9bd1a263557dfd51a7d0e9dfa93e",
    "roleId": 100001,
    "email": "test@xxx.com"
}
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数      | 类型          |      | 备注                       |
| ---- | ------------- | ------------- | ---- | -------------------------- |
| 1    | code          | Int           | 否   | 返回码，0：成功 其它：失败 |
| 2    | message       | String        | 否   | 描述                       |
| 3    | data          | object        | 否   | 返回信息实体               |
| 3.1  | account       | String        | 否   | 帐号                       |
| 3.2  | roleId        | Integer       | 否   | 所属角色                   |
| 3.3  | roleName      | String        | 否   | 角色名称                   |
| 3.4  | roleNameZh    | String        | 否   | 角色中文名                 |
| 3.5  | loginFailTime | Integer       | 是   | 登录失败次数               |
| 3.6  | accountStatus | Integer       | 否   | 帐号状态                   |
| 3.7  | description   | String        | 是   | 备注                       |
| 3.8  | createTime    | LocalDateTime | 否   | 创建时间                   |
| 3.9  | modifyTime    | LocalDateTime | 否   | 修改时间                   |


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
    	"email": "test@xxx.com",
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

### 2.4 更新密码 


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/api/passwordUpdate?appKey={appKey}&signature={signature}&timestamp={timestamp}**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数      | 类型   | 可为空 | 备注             |
| ---- | ------------- | ------ | ------ | ---------------- |
| 1    | account       | String | 否     | 帐号             |
| 2    | oldAccountPwd | String | 否     | 旧密码（sha256） |
| 3    | newAccountPwd | String | 否     | 新密码（sha256） |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/api/passwordUpdate?timestamp=1614928857832&appKey=fdsf78aW&signature=EEFD7CD030E6B311AA85B053A90E8A31
```

```
{
    "account": "admin ",
    "oldAccountPwd": "dfdfgdg490cef2bfb60a9702erd2ddb7a805c9bd1arrrewefd51a7d0etttfa93e",
    "newAccountPwd": "3f21a8490cef2bfb60a9702e9d2ddb7a805c9bd1a263557dfd51a7d0e9dfa93e"
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
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

## 3 链信息模块

### 3.1 查询基本信息

获取链基本信息，包括链版本、是否使用国密、是否使用国密SSL连接、WeBASE版本等。

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址： **/api/basicInfo?appKey={appKey}&signature={signature}&timestamp={timestamp}**
* 请求方式：GET
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

***2）入参示例***

```
http://localhost:5001/WeBASE-Node-Manager/api/basicInfo?timestamp=1614928857832&appKey=fdsf78aW&signature=EEFD7CD030E6B311AA85B053A90E8A31
```


#### 返回参数

***1）出参表***

| 序号 | 输出参数 | 类型 | 可为空 | 备注                       |
| ---- | -------- | ---- | ---- | -------------------------- |
| 1    | code     | int  | 否   | 返回码，0：成功 其它：失败 |
| 2    | message     | String        | 否     | 描述   |
| 3    |  data    | Object     | 否     | 基本信息 |
| 3.1 | encryptType | int | 否 | 是否使用国密（1: 国密，0：非国密） |
| 3.2 | sslCryptoType | int | 否 | 是否使用国密SSL连接（1: 国密，0：非国密） |
| 3.3 | fiscoBcosVersion | String | 否 | FISCO-BCOS版本 |
| 3.4 | webaseVersion | String | 否 | WeBASE版本 |

***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "encryptType": 1,
        "sslCryptoType": 1,
        "fiscoBcosVersion": "2.7.2 gm",
        "webaseVersion": "v1.5.0"
    },
    "attachment": null
}
```

### 3.2 查询群组列表

默认只返回groupStatus为1的群组ID，可传入groupStatus筛选群组 (1-normal, 2-maintaining, 3-conflict-genesisi, 4-conflict-data)

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/api/groupList?appKey={appKey}&signature={signature}&timestamp={timestamp}&groupStatus={groupStatus}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型 | 可为空 | 备注                                                        |
| ---- | ----------- | ---- | ------ | ----------------------------------------------------------- |
| 1    | groupStatus | int  | 是     | 群组状态（默认1），1-正常, 2-维护中, 3-脏数据, 4-创世块冲突 |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/api/groupList?timestamp=1614928857832&appKey=fdsf78aW&signature=EEFD7CD030E6B311AA85B053A90E8A31&groupStatus=
```


#### 返回参数 

***1）出参表***

| 序号  | 输出参数    | 类型          | 可为空 | 备注                                               |
| ----- | ----------- | ------------- | ------ | -------------------------------------------------- |
| 1     | code        | int           | 否     | 返回码，0：成功 其它：失败                         |
| 2     | message     | String        | 否     | 描述                                               |
| 3     | totalCount  | int           | 否     | 总记录数                                           |
| 4     | data        | List          | 是     | 列表                                               |
| 4.1   |             | Object        |        | 信息对象                                           |
| 4.1.1 | groupId     | int           | 否     | 群组编号                                           |
| 4.1.2 | groupName   | String        | 否     | 群组名称                                           |
| 4.1.2 | groupStatus | int           | 否     | 群组状态：1-正常, 2-维护中, 3-脏数据, 4-创世块冲突 |
| 4.1.2 | nodeCount   | int           | 否     | 群组节点数                                         |
| 4.1.3 | latestBlock | BigInteger    | 否     | 最新块高                                           |
| 4.1.4 | transCount  | BigInteger    | 否     | 交易量                                             |
| 4.1.5 | createTime  | LocalDateTime | 否     | 落库时间                                           |
| 4.1.6 | modifyTime  | LocalDateTime | 否     | 修改时间                                           |
| 4.1.2 | description | String        | 是     | 群组描述                                           |
| 4.1.2 | groupType   | int           | 否     | 群组类别：1-同步，2-动态创建                       |


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

### 3.3 查询所有节点列表

查询所有节点列表，用于获取所有节点信息，包括自动同步的节点信息


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/api/nodeList?appKey={appKey}&signature={signature}&timestamp={timestamp}&pageNumber={pageNumber}&pageSize={pageSize}&groupId={groupId}&nodeId={nodeId}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数


***1）入参表***

| 序号 | 输入参数   | 类型   | 可为空 | 备注                                 |
| ---- | ---------- | ------ | ------ | ------------------------------------ |
| 1    | pageSize   | int    | 否     | 每页记录数                           |
| 2    | pageNumber | int    | 否     | 当前页码                             |
| 3    | groupId    | int    | 是     | 群组id，不为空则查询该群组下所有节点 |
| 4    | nodeId     | String | 是     | 节点编号，不为空则查询该节点相关信息 |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/api/nodeList?timestamp=1614928857832&appKey=fdsf78aW&signature=EEFD7CD030E6B311AA85B053A90E8A31&pageNumber=1&pageSize=10
```


#### 返回参数 

***1）出参表***

| 序号   | 输出参数    | 类型          | 可为空 | 备注                       |
| ------ | ----------- | ------------- | ------ | -------------------------- |
| 1      | code        | int           | 否     | 返回码，0：成功 其它：失败 |
| 2      | message     | String        | 否     | 描述                       |
| 3      | totalCount  | int           | 否     | 总记录数                   |
| 4      | data        | List          | 是     | 节点列表                   |
| 4.1    |             | Object        |        | 节点信息对象               |
| 4.1.1  | nodeId      | String        | 否     | 节点编号                   |
| 4.1.2  | nodeName    | String        | 否     | 节点名称                   |
| 4.1.3  | groupId     | int           | 否     | 所属群组编号               |
| 4.1.4  | nodeActive  | int           | 否     | 状态                       |
| 4.1.5  | nodeIp      | String        | 否     | 节点ip                     |
| 4.1.6  | P2pPort     | int           | 否     | 节点p2p端口                |
| 4.1.7  | description | String        | 是     | 备注                       |
| 4.1.8  | blockNumber | BigInteger    | 否     | 节点块高                   |
| 4.1.9  | pbftView    | BigInteger    | 否     | Pbft view                  |
| 4.1.10 | createTime  | LocalDateTime | 否     | 落库时间                   |
| 4.1.11 | modifyTime  | LocalDateTime | 否     | 修改时间                   |

***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success",
    "totalCount": 1,
    "data": [
        {
            "nodeId": "5942fe2460c1a6329b8ebf5bc5a9ca9bd02ee944e8dac297742982de5920e7211489950ac4ac5eb1bd7219dcd773f861da496539d79328ae63f379f898bd2172",
            "nodeName": "127.0.0.1_10303",
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

* 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 3.4 查询节点信息

查询具体某个节点信息


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/api/nodeInfo?appKey={appKey}&signature={signature}&timestamp={timestamp}&groupId={groupId}&nodeId={nodeId}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型   | 可为空 | 备注     |
| ---- | -------- | ------ | ------ | -------- |
| 1    | groupId  | int    | 否     | 群组id   |
| 2    | nodeId   | String | 否     | 节点编号 |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/api/nodeInfo?timestamp=1614928857832&appKey=fdsf78aW&signature=EEFD7CD030E6B311AA85B053A90E8A31&groupId=1&nodeId=5942fe2460c1a6329b8ebf5bc5a9ca9bd02ee944e8dac297742982de5920e7211489950ac4ac5eb1bd7219dcd773f861da496539d79328ae63f379f898bd2172
```

#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          | 可为空 | 备注                       |
| ---- | ----------- | ------------- | ------ | -------------------------- |
| 1    | code        | int           | 否     | 返回码，0：成功 其它：失败 |
| 2    | message     | String        | 否     | 描述                       |
| 3    | data        | Object        | 是     | 节点信息对象               |
| 3.1  | nodeId      | String        | 否     | 节点编号                   |
| 3.2  | nodeName    | String        | 否     | 节点名称                   |
| 3.3  | groupId     | int           | 否     | 所属群组编号               |
| 3.4  | nodeActive  | int           | 否     | 状态                       |
| 3.5  | nodeIp      | String        | 否     | 节点ip                     |
| 3.6  | P2pPort     | int           | 否     | 节点p2p端口                |
| 3.7  | description | String        | 是     | 备注                       |
| 3.8  | blockNumber | BigInteger    | 否     | 节点块高                   |
| 3.9  | pbftView    | BigInteger    | 否     | Pbft view                  |
| 3.10 | createTime  | LocalDateTime | 否     | 落库时间                   |
| 3.11 | modifyTime  | LocalDateTime | 否     | 修改时间                   |

***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "nodeId": "5942fe2460c1a6329b8ebf5bc5a9ca9bd02ee944e8dac297742982de5920e7211489950ac4ac5eb1bd7219dcd773f861da496539d79328ae63f379f898bd2172",
        "nodeName": "127.0.0.1_10303",
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

* 失败：

```
{
    "code": 102000,
    "message": "system exception",
    "data": {}
}
```

### 3.5 查询前置节点列表 

查询前置及其对应节点信息列表，包括前置ip（对应节点Ip），节点端口等。

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/api/frontNodeList?appKey={appKey}&signature={signature}&timestamp={timestamp}&groupId={groupId}&nodeId={nodeId}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型   | 可为空 | 备注         |
| ---- | -------- | ------ | ------ | ------------ |
| 1    | groupId  | Int    | 是     | 所属群组编号 |
| 2    | nodeId   | String | 是     | 节点编号     |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/api/frontNodeList?timestamp=1614928857832&appKey=fdsf78aW&signature=EEFD7CD030E6B311AA85B053A90E8A31
```


#### 返回参数 

***1）出参表***

| 序号   | 输出参数       | 类型          |      | 备注                                                         |
| ------ | -------------- | ------------- | ---- | ------------------------------------------------------------ |
| 1      | code           | Int           | 否   | 返回码，0：成功 其它：失败                                   |
| 2      | message        | String        | 否   | 描述                                                         |
| 3      | totalCount     | Int           | 否   | 总记录数                                                     |
| 4      | data           | List          | 否   | 组织列表                                                     |
| 4.1    |                | Object        |      | 节点信息对象                                                 |
| 4.1.1  | frontId        | int           | 否   | 前置编号                                                     |
| 4.1.2  | frontIp        | string        | 否   | 前置ip                                                       |
| 4.1.3  | frontPort      | int           | 否   | 前置端口                                                     |
| 4.1.4  | createTime     | LocalDateTime | 否   | 落库时间                                                     |
| 4.1.5  | modifyTime     | LocalDateTime | 否   | 修改时间                                                     |
| 4.1.6  | agency         | string        | 否   | 备注所属机构                                                 |
| 4.1.7  | frontVersion   | string        | 否   | 前置的后台版本，如: v1.4.0                                   |
| 4.1.8  | signVersion    | string        | 否   | 前置所连接签名服务的后台版本，如: v1.4.0                     |
| 4.1.9  | clientVersion  | string        | 否   | 链节点的版本，如: 2.5.0 gm                                   |
| 4.1.10 | supportVersion | string        | 否   | 链节点所支持的最高版本, 如: 2.5.0, (此处仅显示支持的最高版本，不显示是否为国密。若从2.4.0升级到2.5.0，此处将返回2.4.0) |
| 4.1.11 | status         | int           | 否   | 前置服务状态：0，未创建；1，停止；2，启动；                  |
| 4.1.12 | runType        | int           | 否   | 运行方式：0，命令行；1，Docker                               |
| 4.1.13 | agencyId       | int           | 否   | 所属机构 ID                                                  |
| 4.1.14 | agencyName     | string        | 否   | 所属机构名称                                                 |
| 4.1.15 | hostId         | int           | 否   | 所属主机                                                     |
| 4.1.16 | hostIndex      | int           | 否   | 一台主机可能有多个节点。表示在主机中的编号，从 0 开始编号    |
| 4.1.17 | imageTag       | string        | 否   | 运行的镜像版本标签                                           |
| 4.1.18 | containerName  | string        | 否   | Docker 启动的容器名称                                        |
| 4.1.19 | jsonrpcPort    | int           | 否   | jsonrpc 端口                                                 |
| 4.1.20 | p2pPort        | int           | 否   | p2p 端口                                                     |
| 4.1.21 | channelPort    | int           | 否   | channel 端口                                                 |
| 4.1.22 | chainId        | int           | 否   | 所属链 ID                                                    |
| 4.1.23 | chainName      | string        | 否   | 所属链名称                                                   |
| 4.1.23 | groupList      | List<Integer> | 否   | 节点所属群组列表                                             |


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
            "groupList": [
                1,
                2
            ],
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

### 3.6 查询sdk证书信息 

返回sdk证书文件名和内容，根据需要保存。根据底层是否使用国密和是否使用国密SSL连接，自动识别返回国密还是非国密证书。

- 非国密证书：非国密链或国密链未使用国密SSL连接
- 国密证书：国密链且使用国密SSL连接

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/api/sdkCert?appKey={appKey}&signature={signature}&timestamp={timestamp}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/api/sdkCert?timestamp=1614928857832&appKey=fdsf78aW&signature=EEFD7CD030E6B311AA85B053A90E8A31
```


#### 返回参数 

***1）出参表***

| 序号  | 输出参数 | 类型   |      | 备注                       |
| ----- | -------- | ------ | ---- | -------------------------- |
| 1     | code     | Int    | 否   | 返回码，0：成功 其它：失败 |
| 2     | message  | String | 否   | 描述                       |
| 3     | data     | List   | 否   | 列表                       |
| 3.1   |          | Object |      | 信息对象                   |
| 3.1.1 | name     | int    | 否   | 证书名                     |
| 3.1.2 | content  | string | 否   | 证书内容                   |


***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "name": "sdk.key",
            "content": "-----BEGIN PRIVATE KEY-----\nMIGEAgEAMBAGByqGSM49AgEGBSuBBAAKBG0wawIBAQQg4mtXDYHIhSPJwmy+CBVZ\nfZM7cpSimSxTKsbtPEWqYZKhRANCAAQZhhhtmx872M2puJDQtfPJ0WE1DUvsxjLX\nmUzCO9OqKGVFjyo1fAMCgAqwObdp5NIW06y1EAqYKjNiZywsOwzC\n-----END PRIVATE KEY-----\n"
        },
        {
            "name": "ca.crt",
            "content": "-----BEGIN CERTIFICATE-----\nMIIBsTCCAVagAwIBAgIJAM+BzxI9PhQhMAoGCCqGSM49BAMCMDUxDjAMBgNVBAMM\nBWNoYWluMRMwEQYDVQQKDApmaXNjby1iY29zMQ4wDAYDVQQLDAVjaGFpbjAgFw0y\nMTAyMjYwMjQ2NTRaGA8yMTIxMDIwMjAyNDY1NFowNTEOMAwGA1UEAwwFY2hhaW4x\nEzARBgNVBAoMCmZpc2NvLWJjb3MxDjAMBgNVBAsMBWNoYWluMFYwEAYHKoZIzj0C\nAQYFK4EEAAoDQgAEYRLMZw7xe6xHt76AVHivokoHhz6ffwbKmOzbP0I5LAChwD5n\n1glOfWwJc4fFhn2bH/qfFlIGIdOj8vmOzywsqaNQME4wHQYDVR0OBBYEFPd7x8U8\nnHjZ5YWuzyKQh9SZ7p5bMB8GA1UdIwQYMBaAFPd7x8U8nHjZ5YWuzyKQh9SZ7p5b\nMAwGA1UdEwQFMAMBAf8wCgYIKoZIzj0EAwIDSQAwRgIhAO9s16mWfFzceJahV2GA\n4Od9d0fBvMN+UamEUGL0twsOAiEAza/jJna1+nPKBVB+lxnfK3TpN/QH4V0sS1VW\nkpOFMVU=\n-----END CERTIFICATE-----\n"
        },
        {
            "name": "sdk.crt",
            "content": "-----BEGIN CERTIFICATE-----\nMIIBeTCCAR+gAwIBAgIJAPYOLyl8weZiMAoGCCqGSM49BAMCMDgxEDAOBgNVBAMM\nB2FnZW5jeUExEzARBgNVBAoMCmZpc2NvLWJjb3MxDzANBgNVBAsMBmFnZW5jeTAg\nFw0yMTAyMjYwMjQ2NTRaGA8yMTIxMDIwMjAyNDY1NFowMTEMMAoGA1UEAwwDc2Rr\nMRMwEQYDVQQKDApmaXNjby1iY29zMQwwCgYDVQQLDANzZGswVjAQBgcqhkjOPQIB\nBgUrgQQACgNCAAQZhhhtmx872M2puJDQtfPJ0WE1DUvsxjLXmUzCO9OqKGVFjyo1\nfAMCgAqwObdp5NIW06y1EAqYKjNiZywsOwzCoxowGDAJBgNVHRMEAjAAMAsGA1Ud\nDwQEAwIF4DAKBggqhkjOPQQDAgNIADBFAiBaUwBn+xmdq4kMY4RdamjOdy5IhGih\nLNlC6uowICpHFgIhAOPuWHD5FwJ6iKgia/Pg28vUh1OycM6m58SB0uYWHCPi\n-----END CERTIFICATE-----\n-----BEGIN CERTIFICATE-----\nMIIBcTCCARegAwIBAgIJAKA09HPrLxBIMAoGCCqGSM49BAMCMDUxDjAMBgNVBAMM\nBWNoYWluMRMwEQYDVQQKDApmaXNjby1iY29zMQ4wDAYDVQQLDAVjaGFpbjAeFw0y\nMTAyMjYwMjQ2NTRaFw0zMTAyMjQwMjQ2NTRaMDgxEDAOBgNVBAMMB2FnZW5jeUEx\nEzARBgNVBAoMCmZpc2NvLWJjb3MxDzANBgNVBAsMBmFnZW5jeTBWMBAGByqGSM49\nAgEGBSuBBAAKA0IABMvK4cYauT6D3aVBGt4tl1lD0XGxGQ9On4dGsG7lnuyxn96x\nhWGWJf7WxWcIM5cSZRxmcH8yGxTfsVJQCCC0FuujEDAOMAwGA1UdEwQFMAMBAf8w\nCgYIKoZIzj0EAwIDSAAwRQIhAOwC+rimC9RWRjEVJqoI6eP+Hm8I0Cx+3SQc6yDa\n+sZXAiBRW+SRjA2PdxbKrUEWP88V5iIrKoaNedaKJn0ydBJuHQ==\n-----END CERTIFICATE-----\n-----BEGIN CERTIFICATE-----\nMIIBsTCCAVagAwIBAgIJAM+BzxI9PhQhMAoGCCqGSM49BAMCMDUxDjAMBgNVBAMM\nBWNoYWluMRMwEQYDVQQKDApmaXNjby1iY29zMQ4wDAYDVQQLDAVjaGFpbjAgFw0y\nMTAyMjYwMjQ2NTRaGA8yMTIxMDIwMjAyNDY1NFowNTEOMAwGA1UEAwwFY2hhaW4x\nEzARBgNVBAoMCmZpc2NvLWJjb3MxDjAMBgNVBAsMBWNoYWluMFYwEAYHKoZIzj0C\nAQYFK4EEAAoDQgAEYRLMZw7xe6xHt76AVHivokoHhz6ffwbKmOzbP0I5LAChwD5n\n1glOfWwJc4fFhn2bH/qfFlIGIdOj8vmOzywsqaNQME4wHQYDVR0OBBYEFPd7x8U8\nnHjZ5YWuzyKQh9SZ7p5bMB8GA1UdIwQYMBaAFPd7x8U8nHjZ5YWuzyKQh9SZ7p5b\nMAwGA1UdEwQFMAMBAf8wCgYIKoZIzj0EAwIDSQAwRgIhAO9s16mWfFzceJahV2GA\n4Od9d0fBvMN+UamEUGL0twsOAiEAza/jJna1+nPKBVB+lxnfK3TpN/QH4V0sS1VW\nkpOFMVU=\n-----END CERTIFICATE-----\n"
        }
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

## 4 私钥管理模块 

**说明：**私钥传输时以Base64加密传输，示例如下：

```
String hexPrivateKey = CryptoSuite.createKeyPair().getHexPrivateKey();
// 加密
String privateKey = Base64.getEncoder().encodeToString(hexPrivateKey.getBytes());
// 解密
hexPrivateKey = new String(Base64.getDecoder().decode(privateKey));
```

### 4.1 新增私钥用户


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/api/newUser?appKey={appKey}&signature={signature}&timestamp={timestamp}**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型   | 可为空 | 备注         |
| ---- | ----------- | ------ | ------ | ------------ |
| 1    | userName    | String | 否     | 用户名称     |
| 2    | description | String | 是     | 备注         |
| 3    | groupId     | int    | 否     | 所属群组     |
| 4    | account     | String | 否     | 关联系统账号 |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/api/newUser?timestamp=1614928857832&appKey=fdsf78aW&signature=EEFD7CD030E6B311AA85B053A90E8A31
```

```
{"groupId":"1","userName":"bob","account":"admin","description":""}
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          | 可为空 | 备注                               |
| ---- | ----------- | ------------- | ------ | ---------------------------------- |
| 1    | code        | int           | 否     | 返回码，0：成功 其它：失败         |
| 2    | message     | String        | 否     | 描述                               |
| 3    | data        | object        | 是     | 返回信息实体（成功时不为空）       |
| 3.1  | userId      | int           | 否     | 用户编号                           |
| 3.2  | userName    | String        | 否     | 用户名称                           |
| 3.3  | groupId     | int           | 否     | 所属群组编号                       |
| 3.4  | description | String        | 是     | 备注                               |
| 3.5  | userStatus  | int           | 否     | 状态（1-正常 2-停用） 默认1        |
| 3.6  | publicKey   | String        | 否     | 公钥信息                           |
| 3.7  | privateKey  | String        | 是     | Base64加密后的私钥内容             |
| 3.8  | address     | String        | 否     | 用户链上地址                       |
| 3.9  | hasPk       | int           | 否     | 是否拥有私钥信息(1-拥有，2-不拥有) |
| 3.10 | account     | String        | 否     | 关联系统账号                       |
| 3.11 | signUserId  | String        | 否     | 用户在sign服务的ID                 |
| 3.12 | createTime  | LocalDateTime | 否     | 创建时间                           |
| 3.13 | modifyTime  | LocalDateTime | 否     | 修改时间                           |


***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "userId": 700001,
        "userName": "bob",
        "account": "admin",
        "groupId": 1,
        "publicKey": "04d7e3391db028aba558e7111702b42d90db9fe3b3b47f19a9dd9ff3b7fd216e9f19adc4643b40c86cab266edbf947503b202f90ff3d8f07e5df49d7e2047f0636",
        "privateKey": "OGNlZDA1OTUyM2NmYjgzYThjYjk1MmMxMTM1YmQwZDViNzAzNmZkNWM2ZDExNmFhMjMwZWZkNGFmYzcwMWVjMQ==",
        "userStatus": 1,
        "chainIndex": null,
        "userType": 1,
        "address": "0xc1c7f7e5916d1cf787924128bca0cb5b34622952",
        "signUserId": "6c804064630e46f587de3d905e82295a",
        "appId": "1",
        "hasPk": 1,
        "description": "",
        "createTime": "2021-03-07 16:52:29",
        "modifyTime": "2021-03-07 16:52:29"
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

### 4.2 查询用户列表

返回用户信息列表，不返回私钥内容，查询私钥需调用`4.3`。


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/api/userList?appKey={appKey}&signature={signature}&timestamp={timestamp}&pageNumber={pageNumber}&pageSize={pageSize}&groupId={groupId}&userParam={userParam}&account={account}&hasPrivateKey={hasPrivateKey}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数      | 类型   | 可为空 | 备注                           |
| ---- | ------------- | ------ | ------ | ------------------------------ |
| 1    | groupId       | int    | 否     | 所属群组id                     |
| 2    | pageSize      | int    | 否     | 每页记录数                     |
| 3    | pageNumber    | int    | 否     | 当前页码                       |
| 4    | userParam     | String | 是     | 查询参数（用户名或公钥地址）   |
| 5    | account       | String | 是     | 关联系统账号                   |
| 6    | hasPrivateKey | int    | 是     | 是否拥有私钥(1-拥有，2-不拥有) |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/api/userList?timestamp=1614928857832&appKey=fdsf78aW&signature=EEFD7CD030E6B311AA85B053A90E8A31&pageNumber=1&pageSize=10&groupId=1
```


#### 返回参数 

***1）出参表***

| 序号   | 输出参数    | 类型          | 可为空 | 备注                               |
| ------ | ----------- | ------------- | ------ | ---------------------------------- |
| 1      | code        | int           | 否     | 返回码，0：成功 其它：失败         |
| 2      | message     | String        | 否     | 描述                               |
| 3      | totalCount  | int           | 否     | 总记录数                           |
| 4      | data        | List          | 是     | 用户列表                           |
| 4.1    |             | Object        |        | 用户信息对象                       |
| 4.1.1  | userId      | int           | 否     | 用户编号                           |
| 4.1.2  | userName    | String        | 否     | 用户名称                           |
| 4.1.3  | groupId     | int           | 否     | 所属群组编号                       |
| 4.1.4  | description | String        | 是     | 备注                               |
| 4.1.5  | userStatus  | int           | 否     | 状态（1-正常 2-停用） 默认1        |
| 4.1.6  | publicKey   | String        | 否     | 公钥信息                           |
| 4.1.7  | privateKey  | String        | 是     | 列表不返回私钥                     |
| 4.1.8  | address     | String        | 否     | 用户链上地址                       |
| 4.1.9  | hasPk       | int           | 否     | 是否拥有私钥信息(1-拥有，2-不拥有) |
| 4.1.10 | account     | String        | 否     | 关联系统账号                       |
| 4.1.11 | signUserId  | String        | 否     | 用户在sign服务的ID                 |
| 4.1.12 | createTime  | LocalDateTime | 否     | 创建时间                           |
| 4.1.13 | modifyTime  | LocalDateTime | 否     | 修改时间                           |


***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": [
        {
            "userId": 700001,
            "userName": "bob",
            "account": "admin",
            "groupId": 1,
            "publicKey": "04d7e3391db028aba558e7111702b42d90db9fe3b3b47f19a9dd9ff3b7fd216e9f19adc4643b40c86cab266edbf947503b202f90ff3d8f07e5df49d7e2047f0636",
            "privateKey": null,
            "userStatus": 1,
            "chainIndex": null,
            "userType": 1,
            "address": "0xc1c7f7e5916d1cf787924128bca0cb5b34622952",
            "signUserId": "6c804064630e46f587de3d905e82295a",
            "appId": "1",
            "hasPk": 1,
            "description": "",
            "createTime": "2021-03-07 16:52:29",
            "modifyTime": "2021-03-07 16:52:29"
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

### 4.3 查询用户信息

返回具体用户信息，包含私钥内容（Base64加密后的私钥内容）。


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/api/userInfo?appKey={appKey}&signature={signature}&timestamp={timestamp}&userId={userId}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数 | 类型 | 可为空 | 备注     |
| ---- | -------- | ---- | ------ | -------- |
| 1    | userId   | int  | 否     | 用户编号 |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/api/userInfo?timestamp=1614928857832&appKey=fdsf78aW&signature=EEFD7CD030E6B311AA85B053A90E8A31&userId=700001
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数    | 类型          | 可为空 | 备注                               |
| ---- | ----------- | ------------- | ------ | ---------------------------------- |
| 1    | code        | int           | 否     | 返回码，0：成功 其它：失败         |
| 2    | message     | String        | 否     | 描述                               |
| 3    | data        | object        | 是     | 返回信息实体（成功时不为空）       |
| 3.1  | userId      | int           | 否     | 用户编号                           |
| 3.2  | userName    | String        | 否     | 用户名称                           |
| 3.3  | groupId     | int           | 否     | 所属群组编号                       |
| 3.4  | description | String        | 是     | 备注                               |
| 3.5  | userStatus  | int           | 否     | 状态（1-正常 2-停用） 默认1        |
| 3.6  | publicKey   | String        | 否     | 公钥信息                           |
| 3.7  | privateKey  | String        | 是     | Base64加密后的私钥内容             |
| 3.8  | address     | String        | 否     | 用户链上地址                       |
| 3.9  | hasPk       | int           | 否     | 是否拥有私钥信息(1-拥有，2-不拥有) |
| 3.10 | account     | String        | 否     | 关联系统账号                       |
| 3.11 | signUserId  | String        | 否     | 用户在sign服务的ID                 |
| 3.12 | createTime  | LocalDateTime | 否     | 创建时间                           |
| 3.13 | modifyTime  | LocalDateTime | 否     | 修改时间                           |


***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "userId": 700001,
        "userName": "bob",
        "account": "admin",
        "groupId": 1,
        "publicKey": "04d7e3391db028aba558e7111702b42d90db9fe3b3b47f19a9dd9ff3b7fd216e9f19adc4643b40c86cab266edbf947503b202f90ff3d8f07e5df49d7e2047f0636",
        "privateKey": "OGNlZDA1OTUyM2NmYjgzYThjYjk1MmMxMTM1YmQwZDViNzAzNmZkNWM2ZDExNmFhMjMwZWZkNGFmYzcwMWVjMQ==",
        "userStatus": 1,
        "chainIndex": null,
        "userType": 1,
        "address": "0xc1c7f7e5916d1cf787924128bca0cb5b34622952",
        "signUserId": "6c804064630e46f587de3d905e82295a",
        "appId": "1",
        "hasPk": 1,
        "description": "",
        "createTime": "2021-03-07 16:52:29",
        "modifyTime": "2021-03-07 16:52:29"
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

### 4.4 导入私钥用户	

导入私钥，其中私钥字段用Base64加密

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/api/importPrivateKey?appKey={appKey}&signature={signature}&timestamp={timestamp}**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型   | 可为空 | 备注                   |
| ---- | ----------- | ------ | ------ | ---------------------- |
| 1    | privateKey  | String | 否     | Base64加密后的私钥内容 |
| 2    | userName    | String | 否     | 用户名称               |
| 3    | description | String | 是     | 备注                   |
| 4    | groupId     | int    | 否     | 所属群组               |
| 5    | account     | String | 否     | 关联系统账号           |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/api/importPrivateKey?timestamp=1614928857832&appKey=fdsf78aW&signature=EEFD7CD030E6B311AA85B053A90E8A31
```

```
{
    "privateKey": "Yjk4YzM3Y2EzNTMxMzNiOWI2MWUwOTMxODhmOTk2NTc2MGYxMTBhMTljNTI2MmY3NTczMDVkNThlOGM3ZWNlMA==",
    "groupId": 1,
    "description": "test",
    "userName": "alice",
    "account": "admin"
}
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   | 可为空 | 备注                       |
| ---- | -------- | ------ | ------ | -------------------------- |
| 1    | code     | int    | 否     | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否     | 描述                       |


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


### 4.5 导入.pem私钥

可导入控制台所生成的私钥.pem文件

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/api/importPem?appKey={appKey}&signature={signature}&timestamp={timestamp}**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型   | 可为空 | 备注                                                         |
| ---- | ----------- | ------ | ------ | ------------------------------------------------------------ |
| 1    | pemContent  | String | 否     | pem文件的内容，必须以`-----BEGIN PRIVATE KEY-----\n`开头，以`\n-----END PRIVATE KEY-----\n`结尾的格式 |
| 2    | userName    | String | 否     | 用户名称                                                     |
| 3    | description | String | 是     | 备注                                                         |
| 4    | groupId     | int    | 否     | 所属群组                                                     |
| 5    | account     | String | 否     | 关联系统账号                                                 |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/api/importPem?timestamp=1614928857832&appKey=fdsf78aW&signature=EEFD7CD030E6B311AA85B053A90E8A31
```

```
{
    "pemContent":"-----BEGIN PRIVATE KEY-----\nMIGEAgEAMBAGByqGSM49AgEGBSuBBAAKBG0wawIBAQQgC8TbvFSMA9y3CghFt51/\nXmExewlioX99veYHOV7dTvOhRANCAASZtMhCTcaedNP+H7iljbTIqXOFM6qm5aVs\nfM/yuDBK2MRfFbfnOYVTNKyOSnmkY+xBfCR8Q86wcsQm9NZpkmFK\n-----END PRIVATE KEY-----\n",
    "groupId": "1",
    "description": "test",
    "userName": "user2",
    "account": "admin"
}
```


#### 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   | 可为空 | 备注                       |
| ---- | -------- | ------ | ------ | -------------------------- |
| 1    | code     | int    | 否     | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否     | 描述                       |


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


### 4.6 导入.p12私钥

可导入控制台生成的私钥.p12文件

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/api/importP12?appKey={appKey}&signature={signature}&timestamp={timestamp}**
* 请求方式：POST
* 请求头：Content-type: **form-data**
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型          | 可为空 | 备注                                                         |
| ---- | ----------- | ------------- | ------ | ------------------------------------------------------------ |
| 1    | p12File     | MultipartFile | 否     | .p12文件                                                     |
| 2    | p12Password | String        | 是     | 使用base64编码的密码；.p12文件的密码，缺省时默认为""，即空密码；p12无密码时，可传入空值或不传；不包含中文 |
| 3    | userName    | String        | 否     | 用户名称                                                     |
| 4    | description | String        | 是     | 备注                                                         |
| 5    | groupId     | int           | 否     | 所属群组                                                     |
| 6    | account     | String        | 否     | 关联系统账号                                                 |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/api/importP12?timestamp=1614928857832&appKey=fdsf78aW&signature=EEFD7CD030E6B311AA85B053A90E8A31
```

> 使用form-data传参

#### 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   | 可为空 | 备注                       |
| ---- | -------- | ------ | ------ | -------------------------- |
| 1    | code     | int    | 否     | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否     | 描述                       |


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

### 4.7 导入公钥用户


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/api/importPublicKey**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数

***1）入参表***

| 序号 | 输入参数    | 类型   | 可为空 | 备注     |
| ---- | ----------- | ------ | ------ | -------- |
| 1    | userName    | string | 否     | 用户名称 |
| 2    | publicKey   | string | 否     | 用户公钥 |
| 3    | groupId     | Int    | 否     | 所属群组 |
| 4    | account     | string | 否     | 关联账户 |
| 5    | description | string | 是     | 备注     |


***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/api/importPublicKey?timestamp=1614928857832&appKey=fdsf78aW&signature=EEFD7CD030E6B311AA85B053A90E8A31
```

```
{
    "userName": "rose",
    "publicKey": "0x98c4e9896dfa062c7555ede0f1509bda90668902ee9a3b382a3941869d3d69026ece966e1afe9f9de41c2e762750dee8d7df47439b3340a22cd620e2f6975ef8",
    "groupId": 1,
    "description": "test",
    "account": "admin"
}
```


#### 返回参数 

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
        "userId": 700003,
        "userName": "rose",
        "account": "admin",
        "groupId": 1,
        "publicKey": "0x98c4e9896dfa062c7555ede0f1509bda90668902ee9a3b382a3941869d3d69026ece966e1afe9f9de41c2e762750dee8d7df47439b3340a22cd620e2f6975ef8",
        "privateKey": null,
        "userStatus": 1,
        "chainIndex": null,
        "userType": 1,
        "address": "0xd5eefc7e9df47f17ee8da8639078ac5da934a782",
        "signUserId": null,
        "appId": null,
        "hasPk": 2,
        "description": "sdfa",
        "createTime": "2021-03-12 18:39:39",
        "modifyTime": "2021-03-12 18:39:39"
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

### 5.1 合约原文保存接口

导入应用合约原文信息，按版本导入，WeBASE会存储到应用合约仓库表。当应用调用合约地址保存接口（5.2）时，会从合约仓库表获取对应合约保存到合约表，在WeBASE管理平台展示。

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/api/contractSourceSave?appKey={appKey}&signature={signature}&timestamp={timestamp}**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数


***1）入参表***

| 序号 | 输入参数        | 类型   | 可为空 | 备注                                        |
| ---- | --------------- | ------ | ------ | ------------------------------------------- |
| 1    | contractList    | List   | 否     | 合约列表                                    |
| 1.1  | contractName    | String | 否     | 合约名称                                    |
| 1.2  | contractSource  | String | 否     | 合约源码的base64                            |
| 1.3  | contractAbi     | String | 否     | 合约编译后生成的abi文件内容                 |
| 1.4  | bytecodeBin     | String | 否     | 合约编译后生成的bytecodeBin，可用于合约部署 |
| 2    | contractVersion | String | 否     | 合约版本                                    |
| 3    | account         | String | 否     | 关联系统账号                                |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/api/contractSourceSave?timestamp=1614928857832&appKey=fdsf78aW&signature=EEFD7CD030E6B311AA85B053A90E8A31
```

```
{
	"contractList": [
		{
        "contractName": "HelloWorld",
        "contractSource": "cHJhZ21hIHNvbGlkaXR5IF4wLjQuMjsNCmNvbnRyYWN0IEhlbGxvV29ybGR7DQogICAgc3RyaW5nIG5hbWU7DQogICAgZXZlbnQgU2V0TmFtZShzdHJpbmcgbmFtZSk7DQogICAgZnVuY3Rpb24gZ2V0KCljb25zdGFudCByZXR1cm5zKHN0cmluZyl7DQogICAgICAgIHJldHVybiBuYW1lOw0KICAgIH0NCiAgICBmdW5jdGlvbiBzZXQoc3RyaW5nIG4pew0KICAgICAgICBlbWl0IFNldE5hbWUobik7DQogICAgICAgIG5hbWU9bjsNCiAgICB9DQogICAgZnVuY3Rpb24gZ2V0KGJ5dGVzMzJbXSB2KWNvbnN0YW50IHJldHVybnMoYWRkcmVzcyl7DQogICAgICAgIGlmICh2Lmxlbmd0aCA8IDIpIHsNCiAgICAgICAgICAgIHJldHVybiAweDA7DQogICAgICAgIH0NCiAgICAgICAgcmV0dXJuIDB4MTsNCiAgICB9DQp9",
        "contractAbi": "[{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"v\",\"type\":\"bytes32[]\"}],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"name\":\"name\",\"type\":\"string\"}],\"name\":\"SetName\",\"type\":\"event\"}]",
        "bytecodeBin": "608060405234801561001057600080fd5b50610443806100206000396000f300608060405260043610610057576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff1680634ed3885e1461005c5780636d4ce63c146100c5578063abf306a814610155575b600080fd5b34801561006857600080fd5b506100c3600480360381019080803590602001908201803590602001908080601f01602080910402602001604051908101604052809392919081815260200183838082843782019150505050505091929192905050506101fb565b005b3480156100d157600080fd5b506100da6102b1565b6040518080602001828103825283818151815260200191508051906020019080838360005b8381101561011a5780820151818401526020810190506100ff565b50505050905090810190601f1680156101475780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b34801561016157600080fd5b506101b960048036038101908080359060200190820180359060200190808060200260200160405190810160405280939291908181526020018383602002808284378201915050505050509192919290505050610353565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b7f4df9dcd34ae35f40f2c756fd8ac83210ed0b76d065543ee73d868aec7c7fcf02816040518080602001828103825283818151815260200191508051906020019080838360005b8381101561025d578082015181840152602081019050610242565b50505050905090810190601f16801561028a5780820380516001836020036101000a031916815260200191505b509250505060405180910390a180600090805190602001906102ad929190610372565b5050565b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156103495780601f1061031e57610100808354040283529160200191610349565b820191906000526020600020905b81548152906001019060200180831161032c57829003601f168201915b5050505050905090565b6000600282511015610368576000905061036d565b600190505b919050565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106103b357805160ff19168380011785556103e1565b828001600101855582156103e1579182015b828111156103e05782518255916020019190600101906103c5565b5b5090506103ee91906103f2565b5090565b61041491905b808211156104105760008160009055506001016103f8565b5090565b905600a165627a7a72305820731c8ae3330a613a2a8c196a28a9fb816dd19bdea5fdcab508d9d968af0fdccd0029",
        "account": "admin"
		}
    ],
    "contractVersion": "1.0.0",
    "account": "admin"
}
```

#### 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   | 可为空 | 备注                       |
| ---- | -------- | ------ | ------ | -------------------------- |
| 1    | code     | int    | 否     | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否     | 描述                       |
| 3    | data     | object | 是     | 返回信息实体（空）         |

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

### 5.2 合约地址保存接口

应用自己部署完合约，导入相应合约地址。导入时，WeBASE会从应用合约仓库表获取对应合约保存到合约表，从而可以在WeBASE管理平台进行展示和调用。

#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/api/contractAddressSave?appKey={appKey}&signature={signature}&timestamp={timestamp}**
* 请求方式：POST
* 请求头：Content-type: application/json
* 返回格式：JSON

#### 请求参数


***1）入参表***

| 序号 | 输入参数        | 类型   | 可为空 | 备注                                                         |
| ---- | --------------- | ------ | ------ | ------------------------------------------------------------ |
| 1    | groupId         | int    | 否     | 所属群组编号                                                 |
| 2    | contractName    | String | 否     | 合约名称                                                     |
| 3    | contractPath    | String | 否     | 合约目录（应用以自己部署合约的逻辑定义路径，部署一次则提供一个路径，该路径在WeBASE管理平台合约文件夹） |
| 4    | contractAddress | String | 否     | 合约地址                                                     |
| 5    | contractVersion | String | 否     | 合约版本                                                     |

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/api/contractAddressSave?timestamp=1614928857832&appKey=fdsf78aW&signature=EEFD7CD030E6B311AA85B053A90E8A31
```

```
{
    "groupId": "1",
    "contractName": "hellos",
    "contractPath": "/",
    "contractVersion": "1.0.0",
    "contractAddress": "0x651a8e7899084019f82a93da880d77470bacf6d7"
}
```

#### 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   | 可为空 | 备注                       |
| ---- | -------- | ------ | ------ | -------------------------- |
| 1    | code     | int    | 否     | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否     | 描述                       |
| 3    | data     | object | 是     | 返回信息实体（空）         |

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


## 6 其他接口

### 6.1 查询数据库信息


#### 传输协议规范

* 网络传输协议：使用HTTP协议
* 请求地址：**/api/dbInfo?appKey={appKey}&signature={signature}&timestamp={timestamp}**
* 请求方式：GET
* 返回格式：JSON

#### 请求参数

***1）入参表***

***2）入参示例***

```
http://127.0.0.1:5001/WeBASE-Node-Manager/api/dbInfo?timestamp=1614928857832&appKey=fdsf78aW&signature=EEFD7CD030E6B311AA85B053A90E8A31
```

#### 返回参数 

***1）出参表***

| 序号 | 输出参数 | 类型   | 可为空 | 备注                       |
| ---- | -------- | ------ | ------ | -------------------------- |
| 1    | code     | int    | 否     | 返回码，0：成功 其它：失败 |
| 2    | message  | String | 否     | 描述                       |
| 3    | data     | Object |        | 返回信息实体               |
| 3.1  | dbIp     | String | 否     | 数据库IP                   |
| 3.2  | dbPort   | int    | 否     | 数据库端口                 |
| 3.3  | dbUser   | String | 否     | 数据库用户名               |
| 3.4  | dbPwd    | String | 否     | Base64加密后的数据库密码   |

***2）出参示例***

* 成功：

```
{
    "code": 0,
    "message": "success",
    "data": {
        "dbIp": "127.0.0.1",
        "p2pPort": 3306,
        "dbUser": test,
        "dbPwd": "Yjk4YzM3Y2EzNTMxMzNiOWI2MWUwOTMxODhmOTk2NTc2MGYxMTBhMTljNTI2MmY3NTcz=="
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

## 附录

### 1. 返回码信息列表
<span id="code"></span>

| code   | message                                      | 描述                       |
| ------ | -------------------------------------------- | -------------------------- |
| 0      | success                                      | 成功                       |
| 102001 | system error                                 | 系统异常                   |
| 202001 | database exception                  | 数据库异常           |
| 202005 | group id cannot be empty     | 群组不能为空           |
| 202012 | user id cannot be empty      | 用户编号不能为空           |
| 202013 | invalid user      | 无效的用户编号           |
| 202014 | user already exists      | 用户信息已经存在           |
| 202015 | contract already exists      | 合约信息已经存在           |
| 202017 | invalid contract id      | 无效的合约编号           |
| 202018 | invalid param info      | 无效的入参信息           |
| 202019 | contract name cannot be repeated     | 合约名称不能重复           |
| 202027 | account info not exists      | 该帐号不存在           |
| 202028 | account name empty      | 帐号名称不能为空           |
| 202029 | invalid account name      | 无效的账号名称           |
| 202520 | contract source not exist | 合约原文不存在 |
| 202521 | timestamp cannot be empty | 时间戳不能为空 |
| 202522 | appKey cannot be empty | 应用Key不能为空 |
| 202523 | signature cannot be empty | 签名不能为空 |
| 202524 | timestamp timeout | 时间戳超时 |
| 202525 | app key not exists | 应用Key不存在 |
| 202526 | signature not match | 签名不匹配 |
| 202527 | request encrypt fail | 请求加密失败 |
| 202528 | request decrypt fail | 请求解密失败 |
| 202529 | isTransferEncrypt config not match | 是否加密传输配置不匹配 |
