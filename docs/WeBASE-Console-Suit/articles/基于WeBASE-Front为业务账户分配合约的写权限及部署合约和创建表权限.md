# 基于WeBASE-Front为业务账户分配合约的写权限及部署合约和创建表权限

> 作者简介： 孙运盛 吉科软信息技术有限公司 大数据技术研究院架构师。负责吉科软区块链BaaS平台设计研发，基于FISCO BCOS的区块链技术研究以及在智慧农业、智慧城市、智慧食安行业领域的区块链技术应用研发。

## 一、背景

- FISCO的基于角色的权限控制机制，在不启用任何链委员和运维角色账户时，每一个账户都相当于是管理员角色账户，拥有链委员角色的管理权限，无所不能；
- 角色定义分为治理方、运维方、监管方和业务方。且各角色权责分离、角色互斥；各角色拥有不同的权限，不能相互交叉；所以一旦启用了治理方、运维方角色的账户，业务方角色的账户权限将会缩水，受限，不再拥有无所不能的权限，在某些合约架构中有可能会触发对合约写权限的限制；
- 我司的区块链BaaS平台中启用了链委员会的治理角色、运维角色账户，在对合约进行调用时，发现一个权限导致的调用失败问题，利用运维角色账户调用合约的写操作方法可以成功，利用业务角色账户调用合约的读操作方法可以成功，调用合约的写操作方法失败，详细的问题复现测试流程见下文。

   本文将根据官方的一物一码商品追溯合约，在开启链委员会治理和运维角色的情况下，对业务角色账户对合约写操作的方法调用失败问题进行详细测试流程说明，及对应的解决方案说明。为同样因为权限问题而困扰的童鞋，提供对FISCO基于角色的权限控制更好的理解案例。

## 二、实验环境

| 名称         | 版本号  |
| ------------ | ------- |
| FISCO BCOS   | v2.9.0  |
| WeBASE-Front | v1.5.4  |
| Solidity     | ^0.6.10 |

## 三、权限问题复现

### 3.1 测试使用的一物一码追溯合约

基于官方的一物一码追溯合约，做了一些改动，合约分为三个，分别为Goods.sol,Traceability.sol,TraceabilityFactory.sol，代码如下：
**Goods.sol合约:**

```reasonml
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.10;
pragma experimental ABIEncoderV2;
struct TraceData {
        ///上链账户地址
        address addr;
        ///商品流转环节
        int16 status;
        ///上链时间
        uint timestamp;
        ///上链摘要数据
        string remark;
}
contract Goods {
    ///@notice 商品当前状态
    int16 _status;
    ///@notice 商品唯一编码
    string _goodsId;
    ///@notice 商品追溯数据结构体数组
    TraceData[] _traceData;
    ///@notice 商品追溯数据上链事件日志
    event NewStatus(address addr,int16 status,uint timestamp,string remark);
    ///@notice 商品构造器
    constructor(string memory goodsId,int16 goodsStatus,string memory remark) public {
        _status = goodsStatus;
        _goodsId = goodsId;
        _traceData.push(TraceData({addr:tx.origin,status:goodsStatus,timestamp:block.timestamp,remark:remark}));
        emit NewStatus(tx.origin, goodsStatus, block.timestamp, remark);  
    }
    
    ///@notice 商品追溯数据上链
    function changeStatus(int16 goodsStatus,string memory remark) public {
        _status = goodsStatus;
        _traceData.push(TraceData({addr:tx.origin,status:goodsStatus,timestamp:block.timestamp,remark:remark}));
        emit NewStatus(tx.origin, goodsStatus, block.timestamp, remark);

    }
    
    ///获取商品当前环节状态
    function getStatus() public view returns(int16){
        return _status;
    }
    
    ///获取商品已上链的各环节追溯数据
    function getTraceInfo() public view returns(TraceData[] memory) {
        return _traceData;
    }

}
```

**Traceability.sol合约：**

```reasonml
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.10;
pragma experimental ABIEncoderV2;
import "./Goods.sol";
contract Traceability {
    struct GoodsData{
        Goods traceGoods;
        bool isExists;
    }
    ///@notice 商品品类
    bytes32 _category;
    
    ///@notice 商品品类映射表，key为商品唯一编码，value为商品结构体
    mapping(string => GoodsData) private _goods;
    constructor(bytes32 goodsCategory) public {
        _category = goodsCategory;
    }
    
    ///@notice 创建新商品的事件日志
    event NewGoodsEvent(string goodsId);

    function changeGoodsStatus(string memory goodsId,int16 goodsStatus,string memory remark) public  {
        ///如果商品编码不存在，则初始化添加商品，并添加商品追溯信息
        if(!_goods[goodsId].isExists){
            _goods[goodsId].isExists = true;
            Goods traceGoods = new Goods(goodsId,goodsStatus,remark);
            emit NewGoodsEvent(goodsId);
            _goods[goodsId].traceGoods = traceGoods;
        }else {
            ///否则直接根据商品ID从mapping中找到对应的商品，调用商品的的改变状态函数添加商品追溯数据
            _goods[goodsId].traceGoods.changeStatus(goodsStatus, remark);
        }
    }
    ///@notice 获取指定商品的追溯数据
    function getTraceInfo(string memory goodsId) public view returns(TraceData[] memory _data){
        require(_goods[goodsId].isExists,"The Goods is not exists");
        return _goods[goodsId].traceGoods.getTraceInfo();
    }
    ///@notice 获取指定商品的当前环节状态
    function getStatus(string memory goodsId) public view returns (int16){
        require(_goods[goodsId].isExists,"The Goods is not exists");
        return _goods[goodsId].traceGoods.getStatus();
    }


}
```

**TraceabilityFactory.sol合约：**

```reasonml
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.10;
pragma experimental ABIEncoderV2;
import "./Traceability.sol";

contract TraceabilityFactory {
    
    struct GoodsTrace{
        Traceability trace;
        bool isExists;
    }
    ///@notice 商品品类映射表
    mapping(bytes32 => GoodsTrace) private _goodsCategory;
    
    ///@notice 新商品生成事件日志
    event NewTraceEvent(bytes32 goodsGroup);

    
    ///@notice 商品追溯信息上链
    function changeTraceGoods(bytes32 goodsGroup,string memory goodsId,int16 goodsStatus,string memory remark) public {
        Traceability category = getTraceability(goodsGroup);
        category.changeGoodsStatus(goodsId, goodsStatus, remark);
    }
    
    ///@notice 获取某个商品的当前环节编码
    function getTraceStatus(bytes32 goodsGroup,string memory goodsId) public view returns(int16 ){
        Traceability category = getTraceabilityForSearch(goodsGroup);
        return category.getStatus(goodsId);
    }
    
    ///@notice 获取商品的追溯信息
    function getTraceInfo(bytes32 goodsGroup,string memory goodsId) public view returns(TraceData[] memory _data) {
         Traceability category = getTraceabilityForSearch(goodsGroup);
        return category.getTraceInfo(goodsId);
    }

    ///@notice 根据商品品类名创建产品组hash值，返回bytes32类型的goodsGroup
    function getGoodsGroup(string memory goodsGroupName) public view  returns(bytes32){
        return keccak256(abi.encode(goodsGroupName));
    }
    
    function createTraceability(bytes32 goodsGroup) private returns(Traceability) {
        require(!_goodsCategory[goodsGroup].isExists,"The trademark already exists");
        Traceability category = new Traceability(goodsGroup);
        _goodsCategory[goodsGroup].isExists = true;
        _goodsCategory[goodsGroup].trace = category;
        emit NewTraceEvent(goodsGroup);
        return category;

    }
    
    function getTraceability(bytes32 goodsGroup) private  returns(Traceability) {
        if(!_goodsCategory[goodsGroup].isExists){
            createTraceability(goodsGroup);
        }
        return _goodsCategory[goodsGroup].trace;
    }
    function getTraceabilityForSearch(bytes32 goodsGroup) private view returns(Traceability) {
        require(_goodsCategory[goodsGroup].isExists,"The trademark has not exists" );
        return _goodsCategory[goodsGroup].trace;
    }
    
}
```

TraceabilityFactory.sol为业务调用的入口合约，对外公开的接口列表，如下表所示：

| 接口名称         | 接口描述                       | 读/写  |
| ---------------- | ------------------------------ | ------ |
| getGoodsGroup    | 根据商品品类名创建产品组hash值 | 读操作 |
| changeTraceGoods | 商品追溯信息上链               | 写操作 |
| getTraceStatus   | 获取某个商品的当前环节编码     | 读操作 |
| getTraceInfo     | 获取商品的追溯信息             | 读操作 |

### 3.2 治理、运维、业务角色的账户地址

链委员治理角色账户地址：0x6eac7c4ff88516ba72e4237bfc721e33af88a933
![img](https://segmentfault.com/img/bVc9eqb)
运维角色账户地址：0x4c88e3e3764767aa398c29de440c3492df8d2747
![img](https://segmentfault.com/img/bVc9eqc)
业务账户地址1：0xba7d313fac4caa48f7c937f8212b1b4cbb73697f
业务账户地址2：0x4acb81ee8f9f777807fc18009f294cd29af4509e
![img](https://segmentfault.com/img/bVc9eqd)

### 3.3 使用运维角色账户部署合约

使用运维账户0x4c88e3e3764767aa398c29de440c3492df8d2747，部署TraceabilityFactory.sol合约，合约地址为：**0x3683ac26ede6bdbb2d36712f04aa23b8e073cd14**
![img](https://segmentfault.com/img/bVc9eqe)

### 3.4 使用运维角色账户调用合约的数据上链方法，调用成功

TraceabilityFactory合约的changeTraceGoods方法为追溯数据上链，利用运维角色账户 0x4c88e3e3764767aa398c29de440c3492df8d2747 ，发起交易，如下图所示：
![img](https://segmentfault.com/img/bVc9eqf)
![img](https://segmentfault.com/img/bVc9eqg)
通过交易回执，可以看到使用运维角色账户调用合约写操作接口是成功的。

### 3.5 使用业务账户1调用合约的数据上链方法，调用失败

使用业务账户1： 0xba7d313fac4caa48f7c937f8212b1b4cbb73697f 调用合约的追溯数据上链接口
![img](https://segmentfault.com/img/bVc9eqh)
![img](https://segmentfault.com/img/bVc9eqi)
通过交易回执，可以看到交易失败，返回状态0x16，RevertInstruction错误。

### 3.6 将业务账户1升级为运维角色并调用合约数据上链方法，调用成功

将业务账户1 ：0xba7d313fac4caa48f7c937f8212b1b4cbb73697f，添加到运维角色，如下图所示：
![img](https://segmentfault.com/img/bVc9eqk)
然后使用业务账户1 ，再次调用合约的追溯数据上链方法，下图直接展示交易回执结果：
![img](https://segmentfault.com/img/bVc9eql)

### 3.7 使用业务账户2调用合约的数据上链方法，调用失败

然后再使用业务账户2：0x4acb81ee8f9f777807fc18009f294cd29af4509e，调用合约的追溯数据上链方法，如下图所示：
![img](https://segmentfault.com/img/bVc9eqp)
![img](https://segmentfault.com/img/bVc9eqq)
从交易回执结果看，业务账户2调用合约写操作方法失败，返回0x16，RevertInstruction错误。

## 四、权限问题分析及解决方案

### 4.1 分析原因一

从以上测试过程看，运维角色账户拥有合约的部署、创建、调用写操作方法的权限，可以对写操作的方法调用成功，而业务角色账户调用失败，但对于读操作的合约方法可以调用成功，且升级为运维角色账户后同样可以对写操作方法调用成功，推测可能的原因为业务角色账户对合约写操作的方法缺少写权限。

### 4.2 解决方案一

  尝试为合约分配可写权限的业务账户，WeBASE-Front前置服务中的权限分配接口，权限类型分为六种，为权限管理权限permission, 用户表管理权限userTable, 部署合约和创建用户表权限deployAndCreate, 节点管理权限node, 使用CNS权限cns, 系统参数管理权限sysConfig。我们当前推测是业务账户对合约缺少写权限，所以以上六种权限分配没有为合约分配写权限的类型。
  另外合约状态管理接口中，已经废弃了为合约分配管理权限的账户的操作类型。所以我们可自行添加为合约分配写权限的账户的接口。以下是改造WeBASE-Front前置服务的分配权限接口的部分关键代码：
   PrecompiledUtils.java中增加权限类型：

```arduino
//2023-07-27 sunyunsheng add
public static final String PERMISSION_TYPE_CONTRACT_WRITE = "contractWrite";
```

PermissionManagerController.java中增加：

```java
/**
 * 2023-07-27 sunyunsheng  add
 * 为业务账户分配合约的写权限
 * @param groupId 群组ID
 * @param from 发起账户
 * @param contractAddress 合约地址
 * @param userAddress 业务账户地址
 * @return
 */
public Object grantContractWritePermission(int groupId, String from, String contractAddress,
                                    String userAddress) {
    if(Objects.isNull(contractAddress)){
        log.error("grantContractWritePermission error for contract address is empty");
        return ConstantCode.PARAM_FAIL_TABLE_NAME_IS_EMPTY;
    }else {
        try{
            Object res = permissionManageService
                    .grantContractWritePermission(groupId, from, contractAddress, userAddress);
            return res;
        } catch (Exception e) {
            log.error("end grantContractWritePermission for startTime:{}, Exception:{}",
                    Instant.now().toEpochMilli(), e);
            return new BaseResponse(ConstantCode.FAIL_TABLE_NOT_EXISTS, e.getMessage());
        }
    }
}
/**
 * 2023-07-27 sunyunsheng  add
 * 撤销业务账户对合约的写权限
 * @param groupId 群组ID
 * @param from 发起账户
 * @param contractAddress 合约地址
 * @param userAddress 业务账户地址
 * @return
 */
public Object revokeContractWritePermission(int groupId, String from, String contractAddress,
                                     String userAddress) {
    if(Objects.isNull(contractAddress)){
        log.error("revokeContractWritePermission error for table name is empty");
        return ConstantCode.PARAM_FAIL_TABLE_NAME_IS_EMPTY;
    }else {
        try {
            Object res = permissionManageService
                    .revokeContractWritePermission(groupId, from, contractAddress, userAddress);
            return res;
        } catch (Exception e) {
            log.error("end revokeContractWritePermission for startTime:{}, Exception:{}",
                    Instant.now().toEpochMilli(), e);
            return new BaseResponse(ConstantCode.FAIL_TABLE_NOT_EXISTS, e.getMessage());
        }
    }
}
/**
 * 2023-07-27 sunyunsheng  add
 * 查询合约写权限的权限列表
 * @param groupId 群组ID
 * @param contractAddress 合约地址
 * @param pageSize 每页大小
 * @param pageNumber 页码
 * @return
 */
public Object listContractWritePermission(int groupId, String contractAddress, int pageSize, int pageNumber) {
    if(Objects.isNull(contractAddress)){
        return ConstantCode.PARAM_FAIL_TABLE_NAME_IS_EMPTY;
    }else {       
        List<PermissionInfo> resList = permissionManageService.listContractWritePermission(groupId, contractAddress);
        if(resList.size() != 0) {
            List2Page<PermissionInfo> list2Page = new List2Page<>(resList, pageSize, pageNumber);
            List<PermissionInfo> finalList = list2Page.getPagedList();
            long totalCount = (long) resList.size();
            return new BasePageResponse(ConstantCode.RET_SUCCESS, finalList, totalCount);
        } else {
            return new BasePageResponse(ConstantCode.RET_SUCCESS_EMPTY_LIST, resList, 0);
        }
    }
}
```

PermissionManagerService.java中增加：

```java
/**
 * 2023-07-28 sunyunsheng add
 * 为合约分配可写权限的账户地址
 * @param groupId 群组ID
 * @param signUserId 签名服务用户ID
 * @param contractAddress 合约地址
 * @param userAddress 分配的用户账户地址
 * @return
 * @throws Exception
 */
public Object grantContractWritePermission(int groupId, String signUserId, String contractAddress,
                                    String userAddress) throws Exception {
    String res = precompiledWithSignService.grantWrite(groupId, signUserId, contractAddress, userAddress);
    return res;
}
/**
 * 2023-07-28 sunyunsheng add
 * 撤销合约分配可写权限的账户地址
 * @param groupId 群组ID
 * @param signUserId 签名服务用户ID
 * @param contractAddress 合约地址
 * @param userAddress 分配的用户账户地址
 * @return
 */
public Object revokeContractWritePermission(int groupId, String signUserId, String contractAddress,
                                     String userAddress) {
    String res = precompiledWithSignService.revokeWrite(groupId, signUserId, contractAddress, userAddress);
    return res;
}
/**
 * 查询合约写权限的权限列表
 * @param groupId
 * @param constractAddress
 * @return
 */
public List<PermissionInfo> listContractWritePermission(int groupId, String constractAddress) {

    PermissionService permissionService = new PermissionService(web3ApiService.getWeb3j(groupId),
            keyStoreService.getCredentialsForQuery());
    try {
        return permissionService.queryPermission(constractAddress);
    } catch (Exception e) {
        log.error("listContractWritePermission fail:[]", e);
        throw new FrontException(ConstantCode.GET_LIST_MANAGER_FAIL);
    }
}
```

然后在分配、去除、查询权限的接口中，增加switch分支，以处理新增加的权限类型 contractWrite。
在区块链BaaS平台中增加相应的为合约分配写权限的业务账户功能，如下图所示：
![img](https://segmentfault.com/img/bVc9equ)
![img](https://segmentfault.com/img/bVc9eqv)
为合约添加可写权限的业务账户2之后，再次测试业务账户2发起上链交易请求，交易回执结果如下图所示：
![img](https://segmentfault.com/img/bVc9eqx)
由此可见，单单为业务账户分配合约的写权限仍旧未解决问题。

### 4.3 分析原因二

根据交易回执结果的状态为0x16，错误信息 RevertInstruction，官方给出的交易执行失败问题排查方向中列举了可引起此错误的情况，如下所示：

```coq
2. revert instruction
问题描述:
交易回滚，交易回执状态值为0x16，错误描述revert instruction，这个错误是因为合约的逻辑问题，包括:
    访问调用未初始化的合约
    访问初始化为0x0的合约
    数组越界访问
    除零错误
    调用assert、revert
    其他错误
解决方法:
检查合约逻辑，修复漏洞。
```

既然是合约逻辑问题，那说明还是合约内的某些地方引起的，但运维账户可以调用成功，所以合约方法本身的逻辑应该是不存在漏洞的， 引起该错误的其中一种情况有“访问调用未初始化的合约”，根据这种情况，我们检查合约的changeTraceGoods方法的源码，

```reasonml
///@notice 商品追溯信息上链
    function changeTraceGoods(bytes32 goodsGroup,string memory goodsId,int16 goodsStatus,string memory remark) public {
        Traceability category = getTraceability(goodsGroup);
        category.changeGoodsStatus(goodsId, goodsStatus, remark);
    }
    function getTraceability(bytes32 goodsGroup) private  returns(Traceability) {
        if(!_goodsCategory[goodsGroup].isExists){
            createTraceability(goodsGroup);
        }
        return _goodsCategory[goodsGroup].trace;
    }
     function createTraceability(bytes32 goodsGroup) private returns(Traceability) {
        require(!_goodsCategory[goodsGroup].isExists,"The trademark already exists");
        Traceability category = new Traceability(goodsGroup);
        _goodsCategory[goodsGroup].isExists = true;
        _goodsCategory[goodsGroup].trace = category;
        emit NewTraceEvent(goodsGroup);
        return category;

    }
```

通过合约源码分析，当合约方法传入的goodsGroup商品分组hash值不存在时，合约内部使用了 Traceability category = new Traceability(goodsGroup);进行创建Traceability合约，new关键字的作用是创建合约，由此可推测，如果当前发起调用的账户不具有创建合约的权限的话，此处就会创建合约失败，也就会造成 “访问调用未初始化的合约”，从而引起回滚，RevertInstruction错误。

### 4.4 解决方案二

根据分析原因二，推测是由业务账户不具有创建合约权限引起的，那么就需要为业务账户单独分配创建合约权限，WeBASE-Front前置服务的权限分配类型中提供了一种权限类型为部署合约和创建用户表权限deployAndCreate 的权限，为默认提供支持的权限类型，可以直接调用权限分配接口为业务账户分配该类型权限。
改造区块链BaaS平台中的链管理模块功能，增加业务账户分配权限的功能，并给业务账户2 ：0x4acb81ee8f9f777807fc18009f294cd29af4509e分配 部署合约和创建表权限。
![img](https://segmentfault.com/img/bVc9eqy)
再次使用业务账户2，调用合约的追溯数据上链方法，调用成功，交易回执结果如下图所示：
![img](https://segmentfault.com/img/bVc9eqz)
![img](https://segmentfault.com/img/bVc9eqA)
通过交易回执结果，可以看出，当业务账户2分配部署合约和创建表的权限后，合约追溯数据上链的方法调用执行成功，可断定当前业务账户在没有分配部署合约和创建表权限之前，是不具有创建合约的权限，从而导致合约内使用new关键字创建合约时会造成失败回滚。

## 五、测试流程总结

> 1、运维账号调用合约的写方法，调用成功；
> 2、业务账号1调用合约的写方法，调用失败；
> 3、业务账号1添加到运维角色，调用合约写接口，成功；
> 4、使用业务账号2调用合约写方法，调用失败；
> 5、分配业务账号2对合约的写权限，(重写前置服务的权限分配接口，增加contractWrite权限类型的接口，包括分配、撤销、查询权限列表三个接口)；
> 6、使用已分配合约写权限的业务账号2调用合约写方法，调用失败；
> 7、为业务账号2分配deployAndCreate(部署合约和创建表的权限)
> 8、使用业务账号2对合约的写方法调用，调用成功

## 六、方案总结

FISCO-BCOS的基于角色权限控制机制，一旦启用链委员治理角色、运维角色时，基于角色权限互斥原则，普通业务账户的权限会缩减，在业务角色账户调用合约时，遇到使用高于业务角色的权限执行时，就需要额外单独给业务角色分配所需的权限。分配权限时可以利用WeBASE-Front前置服务的权限分配接口，接口地址是/permission。

> 注意事项：
>
> - 在测试为合约分配写权限的业务账户时，要注意必须使用合约部署者来发起该权限分配的调用，该权限分配调用的是预编译合约1005，所以部署业务合约时最好是使用运维账号进行部署，调用权限分配的交易发起账户为业务合约的部署者，否则会提示 “permission denied”的错误。
> - 在排查调用合约出现的错误时，一定要注重错误码的分类，根据错误码找到可能引起该错误的所有原因，同时结合合约内的逻辑及发起调用的账户角色、权限进行综合性研判分析，逐步定位错误的真正原因。
> - 要谨慎使用权限分配，小心角色权限之间的互斥机制，要充分了解角色权限互斥的原理，防止造成各角色间莫名的权限混乱