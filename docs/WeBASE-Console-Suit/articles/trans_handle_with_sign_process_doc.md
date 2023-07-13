# COMS | 交易处理接口（结合WeBASE-Sign）的流程分析

作者：COMS (陈钦宇)

来自WeBASE-Front官网：
WeBASE-Front是和FISCO BCOS节点配合使用的一个子系统，需要和节点统计部署，目前支持FISCO BCOS 2.0以上版本，可通过HTTP请求和节点进行通信，集成了web3sdk(java-sdk)，对接口进行了封装和抽象，具备可视化控制台，可以在控制台上查看交易和区块详情，开发智能合约，管理私钥，并对节点健康度进行监控和统计。

## 前期准备
- 搭建一条 FISCO BCOS 区块链
- 搭建 WeBASE-Front 前置服务
    - https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/index.html 
- 搭建 WeBASE-Sign 签名服务
    - https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Sign/index.html 
- 搭建 WeBASE-Manager 管理服务
    - https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Node-Manager/index.html  
- 搭建 WeBASE-Web 管理平台
  - https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Web/index.html 

#### 最终效果
浏览器访问：http://127.0.0.1:5000/#/login
![image](https://user-images.githubusercontent.com/39053440/163217202-072b29fd-8d51-4480-bfca-bddecffb732d.png)


## 使用 WeBASE-Web 搭建所需要的环境：
**1. 使用 WeBASE-Web 创建一个用户**

![image2](https://user-images.githubusercontent.com/39053440/163217295-8d6f0325-c287-4e93-998e-c9936a23f192.png)

**2. 编写 HelloWorld.sol**
```
contract HelloWorld {
    string my_name;
    function Insert(string name) public {
       my_name = name;
    }
}
```
 WeBASE-Web 管理平台 上部署的效果
 
![image3](https://user-images.githubusercontent.com/39053440/163217306-07d97aa0-f2f4-49f7-a7a8-9d12ddf7924c.png)

==然后 保存 -> 编译 -> 部署==

## 访问 WeBASE-Front Swagger-ui 
- 浏览器访问: http://127.0.0.1:5002/WeBASE-Front/swagger-ui.html
- 找到 /trans/handleWithSign 的 API 接口
![image4](https://user-images.githubusercontent.com/39053440/163217422-795d75b1-9d25-462e-af7d-890f422a34fb.png)

里面有相关的测试用例对其进行测试操作

**可以查看 WeBASE-Front 接口文档**
文档地址：https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/interface.html?highlight=handleWithSign#id2

![image](https://user-images.githubusercontent.com/39053440/163298191-253fc756-fca4-434e-83e4-bee630fec745.png)

## 使用 Swagger-ui 或者 Postman 发送请求
这里是使用 postman 来对 /trans/handleWithSign 发送请求，postman 看起来比较清晰

**1) 请求所需要的参数**
```
{
    "groupId" :1,
    "signUserId": "2a6559877ea341e087f6822459679aa4", 
    "contractAbi":[{"constant":false,"inputs":[{"name":"name","type":"string"}],"name":"Insert","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"}],
    "contractAddress":"0xeeae8c36c4df8965fca297bed205af722be817f7",
    "funcName":"Insert",
    "funcParam":["coms"],
    "useCns":false
}

```
- signUserId : 根据部署合约的用户 signUserId 

![image6](https://user-images.githubusercontent.com/39053440/163217603-5e0bf4d7-277b-4db2-8237-125c740d1ed6.png)

- contractAddress: 合约地址
- contractAbi: 合约相应的 abi

![image7](https://user-images.githubusercontent.com/39053440/163217693-7671da17-c3ed-44e2-a1a9-066071f7331f.png)


**2) 使用 postman 请求**

![image8](https://user-images.githubusercontent.com/39053440/163217760-b711025c-577e-4afb-94fe-23ba53b8b915.png)

- **通过调用WeBASE-Sign服务的签名接口让相关用户对数据进行签名，拿回签名数据再发送上链** "status": "0x0" 则为成功

## 源码流程分析

- 要从 WeBASE-Front 前置节点源码深入分析
- 分析 WeBASE-Sign 是如果对交易进行加密

### 1）WeBASE-Front 源码分析
WeBASE-Front 源码：
git clone https://gitee.com/WeBank/WeBASE-Front.git

![image9](https://user-images.githubusercontent.com/39053440/163217828-345e1945-6407-42a2-ac65-204ea4986219.png)

**public Object transHandle**
- 处理 postman request 数据
![image10](https://user-images.githubusercontent.com/39053440/163217903-7eadea74-b674-4355-937b-b9fbe89a6a8d.png)

**public Object transHandleWithSign**
- 解析过后的数据，交给该函数进行处理
![image11](https://user-images.githubusercontent.com/39053440/163218144-96e52148-a7a0-4672-949f-233ca1a07209.png)

**public Object transHandleWithSign**
- 解析后的 groupId 数据，获取 web3ApiService client
- 解析后的  funcName (执行函数名：insert), funcParam（传过去数据：coms）对其进行编码成字符串数据流
![image12](https://user-images.githubusercontent.com/39053440/163218123-bec1277b-a9e8-4cc5-a972-b2279d3d50a1.png)

**public TransactionReceipt handleTransaction**
- this.requestSignForSign 是把编码后的交易和签名用户ID 发送给 WeBASE-Front-sign 对其进行交易签名
- this.sendMessage 则是发送交易
![image13](https://user-images.githubusercontent.com/39053440/163218205-32572d7b-b3d1-43e4-8b45-853c27082201.png)



### 2）WeBASE-Sign 源码分析
2. WeBASE-Sign 源码：git clone https://github.com/WeBankBlockchain/WeBASE-Sign.git

重点关注：

![image14](https://user-images.githubusercontent.com/39053440/163218332-20c4340b-b904-4fc2-b4e4-c20c9a36b98e.png)


![image15](https://user-images.githubusercontent.com/39053440/163218342-543867ba-a422-4c26-87be-3afd29af7090.png)


**sign 方法**
- check signUserId
- 根据 signUserId 获取 cryptoKeyPair（加密密钥对），往下的代码就是对交易加密相关操作
- 对其交易内容进行消息签名
- 往下最后把执行结果交给 WeBASE-Front

![image16](https://user-images.githubusercontent.com/39053440/163218367-07cd6856-4dbf-4aa6-9c06-e20cf19a5450.png)


### 3）总结
  WeBASE-Front API: /trans/handleWithSign 接受数据求就交给 WeBASE-Sign API: sign 对数据进行签名 ， 然后返回
  给  WeBASE-Front 在进行上链操作。重点了解上面标注的函数，都是核心方法。
