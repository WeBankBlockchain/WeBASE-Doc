# 使用教程 | WEBASE中“Event查看”功能的使用

WEBASE中的“Event查看”功能，只能用于查询历史Event，即末区块的值不能超过最新区块高度。
## 一、WEBASE中Event功能的业务逻辑介绍
当用户在WEBASE中进行Event事件查询时，由WEBASE调用WEBASE-Front子系统中的“获取历史区块EventLog”接口，WEBASE-Front子系统收到请求后向节点查询历史Event事件并将查询结果返回给WEBASE，即完成Event事件的查询。其中，WEBASE-Front子系统查询历史Event事件的主要逻辑如下：

- 1）WEBASE-Front子系统根据接收的请求信息向节点发送注册请求。
- 2）节点根据请求参数对请求区块范围的Event Log进行过滤，将结果分次推送给WEBASE-Front。
- 3）当WEBASE-Front收到节点的合约事件推送消息后，进行解码，然后返回给WEBASE。

## 二、Event事件的查询操作演示
## 1.演示示例说明
在业务合约中定义的如下Event事件，合约地址为0x983bef367e547db5e2ca7cba0f2d0f17ac643d8c ，现查询该合约的历史Event事件。

    event UpdateOrgInfoRecord(uint256 number,bytes[] orgInfoStr,uint256 previousBlock);

## 2. 操作演示的请求参数填写
- 1）将合约的ABI拷贝到“合约ABI”输入框中，WEBASE会自动进行Event解析，并将Event名填充至“Event名”的下拉框中；
- 2）在此下拉框中选择需要查询的Event名。
- 3）将合约地址参数值"0x983bef367e547db5e2ca7cba0f2d0f17ac643d8c"填入合约地址输入框。
- 4）“起始区块”和“末区块”保持默认值，不做更改。

## 3. 查询结果
![Event查看截图](https://user-images.githubusercontent.com/6872954/186885013-a683a782-2aec-4d31-9c2e-a0a5078c2022.png)
