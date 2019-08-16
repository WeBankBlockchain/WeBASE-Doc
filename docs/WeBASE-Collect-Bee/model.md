## 存储模型

数据导出中间件会自动将数据导出到存储介质中，每一类数据都有特定的存储格式和模型，以MySQL为例。包括四类数据：区块数据、账户数据、事件数据和交易数据。

### 1. 区块数据存储模型

区块数据存储模型包括三个数据存储模型，分别为区块基本数据存储模型、区块详细数据存储模型及区块交易数据存储模型。

#### 1.1 区块下载任务明细表

存储了所有区块的状态信息和下载情况，对应数据库表名称为**block_task_pool**,如下所示:

| 字段 | 类型 | 字段设置 | 默认值 | 说明 |
| --- | --- | --- | --- | --- |
| pk_id | bigint(20) | Primary key & NOT NULL | 自增 | 主键Id |
| block_height | bigint(20) |  |  | 块高 |
| certainty   |  int(11)        | 是否可能分叉 | 0- 是； 1-否 |
| handle_item | int(11) |  |  | 处理分片序号，默认为0 |
| sync_status | int |  | 2 | 0-待处理；1-处理中；2-已成功；3-处理失败；4-超时 |
| depot_updatetime | datetime |  | 系统时间 | 记录插入/更新时间 |

#### 1.2 区块详细数据存储模型

区块详细数据存储模型用于存储每个区块的详细数据，包括区块哈希、块高、出块时间、块上交易量，对应的数据库表名为**block_detail_info**，如下表所示。

| 字段 | 类型 | 字段设置 | 默认值 | 说明 |
| --- | --- | --- | --- | --- |
| pk_id | bigint(20) | Primary key & NOT NULL | 自增 | 主键Id |
| block_hash | varchar(255) | Unique key & Index |  | 区块哈希 |
| block_height | bigint(20) |  |  | 区块高度 |
| block_tiemstamp | datetime | index |  | 出块时间 |
| tx_count | int(11) |  |  | 当前区块交易量 |
| depot_updatetime | datetime |  | 系统时间 | 记录插入/更新时间 |
| status | int(11) |  |  | 区块状态 0-初始化 1-成功 2-失败 |

#### 1.3 区块交易数据存储模型

区块交易数据存储模型用于存储每个区块中每个交易的基本信息，包括区块哈希、块高、出块时间、合约名称、方法名称、交易哈希、交易发起方地址、交易接收方地址，对应的数据库表名为**block_tx_detail_info**。如下表所示。

| 字段 | 类型 | 字段设置 | 默认值 | 说明 |
| --- | --- | --- | --- | --- |
| pk_id | bigint(20) | Primary key & NOT NULL | 自增 | 主键Id |
| block_hash | varchar(255) | Unique key & Index |  | 区块哈希 |
| block_height | bigint(20) |  |  | 区块高度 |
| block_tiemstamp | datetime | index |  | 出块时间 |
| contract_name | varchar(255) |  |  | 该笔交易的合约名称 |
| method_name | varchar(255) |  |  | 该笔交易调用的function名称 |
| tx_hash | varchar(255) |  |  | 交易哈希 |
| tx_from | varchar(255) |  |  | 交易发起方地址 |
| tx_to | varchar(255) |  |  | 交易接收方地址 |
| depot_updatetime | datetime |  | 系统时间 | 记录插入/更新时间 |

### 2. 账户数据存储模型

账户数据存储模型用于存储区块链网络中所有账户信息，包括账户创建时所在块高、账户所在块的出块时间、账户地址（合约地址）、合约名称。对应的数据库表名为**account_info**。如下表所示。需要注意的是，如果通过嵌套合约隐式调用构造方法，则不会导出。比如A合约中通过关键字new一个B合约，则B合约不会导出。

| 字段 | 类型 | 字段设置 | 默认值 | 说明 |
| --- | --- | --- | --- | --- |
| pk_id | bigint(20) | Primary key & NOT NULL | 自增 | 主键Id |
| block_height | bigint(20) | index |  | 区块高度 |
| block_tiemstamp | datetime | index |  | 出块时间 |
| contract_address | varchar(255) | index |  | 合约/账户地址 |
| contract_name | varchar(255) |  |  | 合约名称 |
| depot_updatetime | datetime |  | 系统时间 | 记录插入/更新时间 |

### 3. 事件数据存储模型

事件数据存储模型是根据合约中的事件（Event）自动生成的。一个合约中有多少个事件就会生成多少个对应的事件数据存储表。

#### 3.1 事件数据存储命名规则

由于事件数据存储模型是自动生成的，所以事件数据存储表名和表结构及字段命名采用统一的规则。以如下合约作为示例。

```
pragma solidity ^0.4.7;
contract UserInfo {
    bytes32 _userName;
    uint8 _sex;
    
    function UserInfo(bytes32 userName, uint8 sex) public {
        _userName = userName;
        _sex = sex;
    }
    
    event modifyUserNameEvent(bytes32 userName，uint8 sex);
    
    function modifyUserName(bytes32 userName) public returns(bytes32){
        _userName = userName;
        modifyUserNameEvent(_userName，_sex);
        return _userName;
    }
}
```

##### 3.1.1 事件表命名规则

事件表命名规则为：合约名称_事件名称，并将合约名称和事件名称中的驼峰命名转化为小写加下划线方式。比如上述合约中合约名称为UserInfo，事件名称为modifyUserNameEvent，则表名称为user_info_modify_user_name_event。

##### 3.1.2 事件字段命名规则

事件字段命名规则：事件字段驼峰命名转化为小写加下划线方式。仍以上述合约中modifyUserNameEvent为例，包含字段userName，则在user_info_modify_user_name_event表中对应的字段为user_name。

#### 3.2 事件数据存储模型

事件数据存储模型除过存储该事件的相关信息外，还会存储和该事件相关的块和交易信息，如下表所示。

| 字段 | 类型 | 字段设置 | 默认值 | 说明 |
| --- | --- | --- | --- | --- |
| pk_id | bigint(20) | Primary key & NOT NULL | 自增 | 主键Id |
| block_height | bigint(20) | index |  | 区块高度 |
| block_tiemstamp | datetime | index |  | 出块时间 |
| **event-paralist** |  |  |  | 事件字段列表 |
| tx_hash | varchar(255) | index |  | 交易哈希 |
| depot_updatetime | datetime |  | 系统时间 | 记录插入/更新时间 |

以上述智能合约为例，对应的 **<event-paralist>** 如下：

| 字段 | 类型 | 字段设置 | 默认值 | 说明 |
| --- | --- | --- | --- | --- |
| user_name | varchar(255) |  |  | 用户名 |
| sex | int |  |  | 性别 |

### 4. 交易数据存储模型

交易数据存储模型同事件数据存储模型类似，是根据合约中的方法（Function）自动生成的。一个合约中有多少个方法就会生成多少个对应的方法数据存储表。该方法指的是实际产生交易的方法（含构造方法），不包含事件（Event）方法和查询方法（constant关键字标注）。

#### 4.1 交易数据存储命名规则

交易数据存储表名、表结构及字段命名规则同事件数据存储模型类似。

##### 4.1.1 交易表命名规则

交易表命名规则为：合约名称_方法名称，并将合约名称和方法名称中的驼峰命名转化为小写加下划线方式。比如上述合约中合约名称为UserInfo，方法名称为modifyUserName，则表名称为user_info_modify_user_name_method；构造方法名称为UserInfo，那么对应的表名为user_info_user_info_method。

##### 4.1.2 交易字段命名规则

交易字段命名规则也是将交易参数字段驼峰命名转化为小写加下划线，不再赘述。需要指出的是，对于一些没有参数的方法，交易数据存储模型没有办法存储，即通过无参方法产生的交易明细将无法通过数据导出工具获取到。

#### 4.2 交易数据存储模型

交易数据存储模型除过存储该方法的相关信息外，还会存储和该方法相关的块和交易信息，如下表所示。

| 字段 | 类型 | 字段设置 | 默认值 | 说明 |
| --- | --- | --- | --- | --- |
| pk_id | bigint(20) | Primary key & NOT NULL | 自增 | 主键Id |
| block_height | bigint(20) | index |  | 区块高度 |
| block_tiemstamp | datetime | index |  | 出块时间 |
| tx_hash | varchar(255) | |  | 合约地址 |
| **function-paralist** |  |  |  | 方法字段列表 |
| tx_hash | varchar(255) | index |  | 交易哈希 |
| depot_updatetime | datetime |  | 系统时间 | 记录插入/更新时间 |

以**3.1**中的合约为例，对应的 **<function-paralist>** 如下：

| 字段 | 类型 | 字段设置 | 默认值 | 说明 |
| --- | --- | --- | --- | --- |
| user_name | varchar(255) |  |  | 用户名 |
| sex | int |  |  | 性别 |