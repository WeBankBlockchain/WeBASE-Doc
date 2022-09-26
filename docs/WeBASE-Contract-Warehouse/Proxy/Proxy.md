# 代理合约模板

本合约模板由深圳前海股权交易中心基于合约迭代升级的需要，研发合约应用开源实现参考，并基于拥抱开源的理念贡献给社区，包括合约接口层代理、合约数据层代理等主要功能。

本合约模板社区贡献者：
[xiaomdong]https://github.com/xiaomdong

## 简介
本合约模板由深圳前海股权交易中心贡献，针对数据上链编写的通用代理存储合约。

代理合约利用solidity的fallback功能，包含EnrollProxy（代理合约），EnrollController（业务合约），EnrollStorage（存储合约）。

- 代理合约对外交互接口
- 业务合约实现业务逻辑
- 存储合约完成数据存储

EnrollProxy合约通过Fallback机制调用EnrollController合约的函数进行数据上链（通过EnrollProxy合约地址结合使用EnrollController合约的ABI，操作EnrollController合约的函数），其带来的优点包括：

- 区块链应用的业务层只与EnrollProxy合约进行交互，EnrollProxy合约不会升级，地址不会变化。

- 后续中业务或存储需求导致业务合约或存储合约需要升级，则升级EnrollController和EnrollStorage合约，达到数据、业务逻辑解耦的效果。

*期待你一起完善合约模板中的权限控制逻辑*

## 合约架构说明

```java
EnrollProxy
        继承EnrollStorageStateful
        继承Proxy（继承Ownable）　
    
EnrollController
        继承EnrollStorageStateful
        继承Ownable

EnrollStorageStateful
        包含成员enrollStorage，EnrollStorage合约实例

由于是继承的关系，EnrollProxy合约和EnrollController合约的存储空间排列是一样的，所以可通过EnrollProxy执行fallback操作。  

enrollStorage是EnrollStorageStateful合约中的成员，所以enrollStorage合约与EnrollStorageStateful合约存储空间排布是不一样。
```

## 使用说明
1. 编译部署EnrollProxy，EnrollController，EnrollStorage合约。
2. 配置代理合约：
   1. 存储合约合约：调用EnrollProxy合约setStorage函数，参数为EnrollStorage合约地址。
   2. 配置业务合约：调用EnrollProxy合约upgradeTo函数，参数为：合约版本号，EnrollController合约地址。
3. 设置存储合约的代理地址：调用EnrollStorage合约setProxy函数，参数为EnrollProxy合约地址。
       

完成以上步骤后，就可以通过EnrollProxy合约地址，结合业务合约EnrollController合约的ABI，操作EnrollController合约的业务函数。
