# 基于WeBASE-Front前置服务发送交易REST接口调用可升级的智能合约方案

> 作者简介： 孙运盛 吉科软信息技术有限公司 大数据技术研究院架构师。负责吉科软区块链BaaS平台设计研发，基于FISCO BCOS的区块链技术研究以及在智慧农业、智慧城市、智慧食安行业领域的区块链技术应用研发。

## 前言

- 我司区块链BaaS平台中通过集成WeBASE-Front前置服务提供的发送交易接口实现基于REST接口形式的智能合约调用，旨在为上层业务应用提供统一的REST形式区块链交互接口，隔离业务应用与智能合约调用代码的紧耦合；
- 为实现逻辑与数据分离的可升级智能合约，采用基于代理模式的可升级智能合约开发方案，代理合约借助delegatecall+fallback的组合模式，实现对逻辑合约函数的调用，代理合约中不声明逻辑合约的函数签名，但代理合约作为上层业务应用调用的入口合约；
- WeBASE-Front前置服务的发送交易接口的交易输入参数中需指定要调用的合约名称、合约地址、合约ABI、合约函数，按照发送交易接口的交易参数中要求合约ABI和合约函数名称但代理合约为调用入口合约且无逻辑合约中的函数签名，这将给调用者带来疑惑，到底该如何利用前置服务的发送交易接口对真实逻辑合约函数的调用及交易回执的解析呢？

本文将从代理模式合约、WeBASE-Front前置服务发送交易接口说明、编写代理模式合约样例及java代码中调用的测试流程，详细描述如何利用WeBASE-Front前置服务调用基于代理模式的智能合约的方法。

## **实验环境**

| 名称         | 版本号  |
| ------------ | ------- |
| FISCO BCOS   | v2.9.0  |
| WeBASE-Front | v1.5.4  |
| Solidity     | ^0.6.10 |

## **基于代理模式的可升级智能合约**

​在智能合约的开发过程中，对于一些复杂的合约开发，要开发出完美没有bug的智能合约，要求是相当高的。即使编写出来的智能合约能完美没有bug，也很难保证以后的需求和应用业务逻辑一成不变。所以，在开发智能合约的同时，就要考虑好以后的合约更新和升级问题。智能合约的更新和升级，其中一种思路就是：在智能合约的编写过程中，要做到数据和应用逻辑的分离。简单来说，就是把数据和应用逻辑分别放在2个独立的合约里(本文称之为数据合约和逻辑合约)。我们在升级合约时，保证存放数据的数据合约里的数据结构不改变，改变的只是存放应用逻辑的逻辑合约。这样才能保证原有的业务数据不被破坏和能够继续使用。

​Solidity有三种合约间的调用方式 call、delegatecall 和 callcode。其中，delegatecall可作为智能合约升级的一个较好的途径。

代理合约将智能合约的存储合约和逻辑合约分开，代理合约存储所有相关的变量，并且保存逻辑合约的地址；所有函数存在逻辑合约里，通过delegatecall执行。当升级时，只需要将代理合约指向新的逻辑合约即可。


![代理模式合约](https://segmentfault.com/img/bVc9en7)
### 四、代理模式合约样例

该合约样例中Storage.sol为数据合约，ImplementationV1.sol、ImplementationV2.sol为逻辑合约、ProxyGateway.sol为代理合约。

![img](https://segmentfault.com/img/bVc9en8)

Storage.sol合约：

```zephir
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.10;
/**
 * @title 定义数据合约,代理合约和逻辑合约继承数据合约，代理合约设置合约实现地址(逻辑合约地址)、逻辑合约对玩家集合进行添加操作
 * @author sunyunsheng
 * @dev 该合约主要为演示数据与逻辑分离，记录玩家和对应的分数及查询玩家分数的功能，模拟对区块链的写和读操作
 */
contract Storage {
    /// @notice 合约实现地址（逻辑地址）
    address public implementation;
    /// @notice 玩家信息集合
    mapping(address=>uint256) public points;
    /// @notice 玩家总数量
    uint256 public totalPlayers;
    address public owner;
}
```

ImplementationV1.sol合约：
逻辑合约V1中定义了addPlayer和getPlayer函数，但addPlayer函数中未改变totalPalyers变量的值，为升级逻辑合约到V2版埋个伏笔

```php
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.10;
import "./Storage.sol";
/**
 *@title 玩家信息操作的逻辑合约V1.0
 *@author sunyunsheng
 *@dev 合约中定义添加玩家、查询玩家分数的两个接口
 */
contract ImplementationV1 is Storage {
    modifier onlyowner()  {
        require(msg.sender == owner, "only owner can do");
        _;
    }
    /**
     *@notice 增加玩家信息
     *@dev 函数修饰符virtual，旨在为演示升级合约时可以继承该合约进行升级并可以修改该函数的逻辑，如增加累加玩家总数的逻辑  totalPlayers++;
     *@param player 玩家账户地址
     *@param point 玩家分数
     */
    function addPlayer(address player, uint256 point) public onlyowner virtual {
        require(points[player] == 0, "player already exists");
        points[player] = point;
    }
    /**
    @notice 根据玩家账户地址，查询玩家的分数
    @param player 玩家账户地址
    @return 玩家的分数
    */
    function getPlayer(address player) public view  returns (uint256){
        require(points[player] != 0, "player must already exists");
        return points[player];
    }
}
```

ImplementationV2.sol合约：
逻辑合约V2继承逻辑合约V1，重写addPlayer函数，累加totalPlayers变量；增加setPlayer函数修改玩家分数

```php
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.10;
import "./ImplementationV1.sol";
/**
 * @title 玩家信息操作的逻辑合约V2.0,继承v1.0的逻辑合约
 * @author sunyunsheng
 * @dev 合约中基于V1.0的逻辑合约，增加修改玩家分数的接口，增加获取玩家总数的函数
 */
contract ImplementationV2 is ImplementationV1 {
    /**
     * @notice 增加玩家信息,继承V1.0的合约函数，增加累加玩家数量的逻辑
     * @param player 玩家账户地址
     * @param point 玩家分数
     */
    function addPlayer(address player, uint256 point) public onlyowner override {
        require(points[player] == 0, "player already exists");
        points[player] = point;
        totalPlayers++;
    }
    /**
     * @notice 修改玩家分数
     * @param player 玩家账户地址
     * @param point 玩家分数
     */
    function setPlayer(address player, uint256 point) public onlyowner {
        require(points[player] != 0, "player must already exists");
        points[player] = point;
    }
    /**
     * @notice 获取玩家总数据量，基于totalPlayers变量获取
     * @dev 由于v1.0版本逻辑合约中未累加totalPlayers变量，v2.0启用该变量，所以总数量与实际玩家集合中的数量不一致，
     * 本函数仅作为合约升级演示示例用，勿纠结总数量是否正确的问题

     * @return 玩家总数
     */
     
    function getTotalPlayers() public  view returns(uint256) {
        return totalPlayers;
    }
}
```

ProxyGateway.sol合约：

```typescript
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.10;
import "./Storage.sol";

/**
 *  @title 代理合约，业务方调用合约的入口
 *  @author sunyunsheng
 *  @dev 通过代理合约的setImpl设置逻辑合约的地址，业务方调用的函数不属于代理合约内定义的函数，都将通过委托调用到逻辑合约的函数
 */ 
contract ProxyGateway is  Storage{
    modifier onlyowner()  {
        require(msg.sender == owner, "only owner can do");
        _;
    }
    
    constructor() public {
        owner = msg.sender;
    }
    
    /// @notice 更新逻辑合约的地址,代理合约不变，逻辑合约可任意升级
    function setImpl(address impl) public {
        implementation = impl;
    }
    
    /// @dev fallback函数,合约底层代码调用，对于业务方调用的函数不属于当前代理合约的函数，都委托调用逻辑合约(由implementation地址对应的逻辑合约)的函数
    fallback() external {
        address _impl = implementation;
        require(_impl != address(0), "implementation must already exists");
        assembly {
            let ptr := mload(0x40)
            calldatacopy(ptr,0,calldatasize())
            let result := delegatecall(gas(),_impl,ptr,calldatasize(),0,0)
            let size := returndatasize()
            returndatacopy(ptr,0,size)
            switch result
            case 0 { revert(ptr,size)}
            default {return(ptr,size)}
        }
    }
}
```

​    需要部署的合约是ImplementationV1、ProxyGateway合约，其中ProxyGateway代理合约部署后，需要通过合约IDE调用代理合约的setImpl函数设置逻辑合约的地址，比如ImplementationV1的合约地址，使代理合约的实现地址为ImplementationV1，从而代理合约能够委托调用ImplementationV1逻辑合约的函数。如果升级合约到ImplementationV2，则部署ImplementationV2，重新通过合约IDE调用ProxyGateway合约的setImpl函数，设置实现地址为ImplementationV2的合约地址。
### 五、WeBASE-Front前置服务发送交易接口说明
可以查看 WeBASE-Front 接口文档， 文档地址：[https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/interface.html?highlight=handleWithSign#id2](https://link.segmentfault.com/?enc=Hehx4ZCNxspKwZ5MvtTrkQ%3D%3D.hEjKulDdDK7ZUqt6PBOFMyaWqx7eCZ%2BduPlAJ23Rbz8JdYUaFNHg4id8It5eBpk4L3K5NBxj6avEcBInR3FLGhXTHECB9fTfiQKJa%2B1vtwd%2FDFHH37u7nopdSTPCkx%2BgVV8W872e0O3eMlfAQEoYzQ%3D%3D)
![img](https://segmentfault.com/img/bVc9eoq)

  通过交易接口的请求参数分析，重要的合约参数包含 合约名称、合约地址、方法名、合约编译后生成的abi文件内容、方法参数(函数的输入参数)，理论上这几个参数都是指逻辑合约的相关参数，真实要调用的逻辑合约的方法名、方法输入参数、合约的abi信息。
  那么问题来了，对于代理模式的合约，代理合约为业务方调用的入口，但代理合约中并没有定义逻辑合约的函数声明，通过该接口传递的合约名称和合约地址必须是代理合约的名称和地址，如果传递的abi信息也是代理合约的abi，那么我们要调用的方法名将与代理合约的abi无法匹配，从而导致无法调用成功。
跟踪WeBASE-Front的交易处理接口源码进行分析，发送交易到区块链的报文组装过程：**transHandleWithSign方法:**

```java
public Object transHandleWithSign(int groupId, String signUserId,
    String contractAddress, String abiStr, String funcName, List<Object> funcParam) throws FrontException {
    ......//省略之前的代码
    String encodeFunction = this.encodeFuncation2Str(abiStr, funcName, funcParam);
    ......//省略之后的代码
    boolean isTxConstant = this.getABIDefinition(abiStr, funcName).isConstant();
    if (isTxConstant) {
        //读操作的函数，有函数返回值
        return this.handleCall(groupId, userAddress, contractAddress, encodeFunction, abiStr, funcName);
    } else {
        //写操作的数据上链函数，有交易回执
        return this.handleTransaction(client, signUserId, contractAddress, encodeFunction);
    }
}
```

**encodeFunction2Str方法:**

```java
public String encodeFunction2Str(String abiStr, String funcName, List<Object> funcParam) {
    ......//省略之前的代码
    String encodeFunction = abiCodec.encodeMethod(abiStr, funcName, funcParam);    
    ......//省略之后的代码
}
```

**encodeMethod方法:**

```java
public String encodeMethod(String ABI, String methodName, List<Object> params)
        throws ABICodecException {
    ContractABIDefinition contractABIDefinition = abiDefinitionFactory.loadABI(ABI);
    List<ABIDefinition> methods = contractABIDefinition.getFunctions().get(methodName);
    if (methods == null || methods.size() == 0) {
        throw new ABICodecException(Constant.NO_APPROPRIATE_ABI_METHOD);
    }
    for (ABIDefinition abiDefinition : methods) {
        if (abiDefinition.getInputs().size() == params.size()) {
            @SuppressWarnings("static-access")
            ABIObject inputABIObject = abiObjectFactory.createInputObject(abiDefinition);
            ABICodecObject abiCodecObject = new ABICodecObject();
            try {
                String methodId = abiDefinition.getMethodId(cryptoSuite);
                return methodId + abiCodecObject.encodeValue(inputABIObject, params).encode();
            } catch (Exception e) {
                logger.error(" exception in encodeMethodFromObject : {}", e.getMessage());
            }
        }
    }
    logger.error(Constant.NO_APPROPRIATE_ABI_METHOD);
    throw new ABICodecException(Constant.NO_APPROPRIATE_ABI_METHOD);
}
```

  该方法中生成的编码数据是 *methodId + abiCodecObject.encodeValue(inputABIObject, params).encode()*，格式为方法ID+所有输入参数的值编码。该编码数据将最终作为创建交易报文时的data参数，也即代理合约中获取的calldata。
  
**在Remix中验证交易输入的calldata：**
在Remix IDE中测试ImplementationV1合约的addPlayer函数调用时，玩家地址参数值0x4c88e3e3764767aa398c29de440c3492df8d2747，玩家分数90，

![img](https://segmentfault.com/img/bVc9eoA)

  点击Calldata 获取编码的输入数据为以下格式：*0x6fd075fc0000000000000000000000004c88e3e3764767aa398c29de440c3492df8d2747000000000000000000000000000000000000000000000000000000000000005a*
 对于calldata，也就是交易的input编码数据，可将其进行拆分为两部分，分别为函数选择器和参数编码。
 
**函数选择器(0x6fd075fc):**
其中0x6fd075fc为函数addPlayer的函数签名Keccak哈希的前四个字节，EVM就是根据这个函数选择器来判断用户调用的是合约的哪个接口；
 
**参数编码：**
0000000000000000000000004c88e3e3764767aa398c29de440c3492df8d2747为函数的第一个输入参数玩家地址0x4c88e3e3764767aa398c29de440c3492df8d2747；5a为函数第二个输入参数玩家分数90的十六进制。
![img](https://segmentfault.com/img/bVc9eoD)


**代理合约的fallback函数:**

```nim
 fallback() external {
        address _impl = implementation;
        require(_impl != address(0), "implementation must already exists");
        assembly {
            let ptr := mload(0x40)
            calldatacopy(ptr,0,calldatasize())
            let result := delegatecall(gas(),_impl,ptr,calldatasize(),0,0)
            let size := returndatasize()
            returndatacopy(ptr,0,size)
            switch result
            case 0 { revert(ptr,size)}
            default {return(ptr,size)}
        }
    }
```

  代理合约的fallback函数中委托调用具体实现的逻辑合约时，最重要的是拷贝calldata，而calldata编码数据中主要是要调用的逻辑合约的函数ID以及函数的所有输入参数，由此我们可以推导，如果我们需要调用逻辑合约的函数时，在WeBASE-Front的交易处理接口中构建交易参数时，可以传递代理合约名称、代理合约地址、逻辑合约ABI、逻辑合约函数名、函数输入参数即可，由前置服务构建交易报文时利用逻辑合约ABI、逻辑合约函数名、函数输入参数编码calldata，交易请求发送到代理合约，最终由代理合约通过委托调用到由Implementation指向的具体实现逻辑合约，以及calldata编码数据，从而实现类似透传的逻辑合约调用。

### 六、JAVA代码调用样例JAVA代码调用样例

  基于SpringBoot开发，分Controller控制层接口、Service层服务处理逻辑层、WeBASE-Front前置服务交易处理接口，最终与区块链部署的代理合约进行交互调用。

![img](https://segmentfault.com/img/bVc9eoG)

**Controller控制层接口代码：**

```java
package com.jkr.traceability.controller;
import com.jkr.common.constant.ConstantCode;
import com.jkr.common.core.domain.AjaxResult;
import com.jkr.common.exception.ServiceException;
import com.jkr.traceability.service.IProxyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.Map;
/**
 * 代理合约的调用接口
 *
 * @author sunyunsheng
 * @version 1.0
 * @date 2023/7/25
 */
@RestController
@RequestMapping("/proxy")
public class ProxyController {
    @Autowired
    private IProxyService proxyService;
    
    @GetMapping("/addPlayer")
    public AjaxResult addPlayer(String player, int point) {
        Map<String, Object> res;
        try {
            res = proxyService.addPlayer(player, point);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServiceException(ConstantCode.SYSTEM_EXCEPTION);
        }
        return AjaxResult.success("操作成功", res);
    }

    @GetMapping("/setPlayer")
    public AjaxResult setPlayer(String player, int point) {
        Map<String, Object> res;
        try {
            res = proxyService.setPlayer(player, point);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServiceException(ConstantCode.SYSTEM_EXCEPTION);
        }
        return AjaxResult.success("操作成功", res);
    }

    @GetMapping("/getPlayer")
    public AjaxResult getPlayer(String player) {

        Map<String, Object> res;
        try {
            res = proxyService.getPlayer(player);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServiceException(ConstantCode.SYSTEM_EXCEPTION);
        }
        return AjaxResult.success("操作成功", res);
    }

    @GetMapping("/getTotalPlayers")
    public AjaxResult getTotalPlayers() {

        Map<String, Object> res;
        try {
            res = proxyService.getTotalPlayers();
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServiceException(ConstantCode.SYSTEM_EXCEPTION);
        }
        return AjaxResult.success("操作成功", res);
    }

}
```

**Service层服务处理逻辑代码：**

```java
package com.jkr.traceability.service;
import org.fisco.bcos.sdk.abi.ABICodecException;
import org.fisco.bcos.sdk.transaction.model.exception.TransactionException;
import java.io.IOException;
import java.util.Map;
/**
 * 测试代理模式的可升级合约， 利用请求的合约地址为代理合约，ABI信息为具体实现的逻辑合约的ABI及函数名称，测试是否可以调用成功，并验证
 * 具有上链写操作的交易回执解析和 读操作的函数返回值解析，是否可以正常解析
 * @author sunyunsheng
 * @version 1.0
 * @date 2023/7/25
 */
public interface IProxyService {
    /**
     * 添加玩家信息接口
     * @param player 玩家地址
     * @param point 玩家分数
     * @return 上链交易回执信息
     * @throws TransactionException
     * @throws ABICodecException
     * @throws IOException
     */
    public Map<String,Object> addPlayer(String player,int point) throws TransactionException, ABICodecException, IOException;

    /**
     * 查询玩家分数
     * @param player 玩家地址
     * @return 返回玩家分数
     * @throws TransactionException
     * @throws ABICodecException
     * @throws IOException
     */
    public Map<String,Object> getPlayer(String player) throws TransactionException, ABICodecException, IOException;

    /**
     * 修改玩家分数
     * @param player 玩家地址
     * @param point 玩家分数
     * @return 上链交易回执信息
     * @throws TransactionException
     * @throws ABICodecException
     * @throws IOException
     */
    public Map<String,Object> setPlayer(String player,int point) throws TransactionException, ABICodecException, IOException;

    /**
     * 查询玩家总数量
     * @return 玩家总数量，取数据合约的totalPlayers变量的值
     * @throws TransactionException
     * @throws ABICodecException
     * @throws IOException
     */
    public Map<String,Object> getTotalPlayers() throws TransactionException, ABICodecException, IOException;
}
```
```java
package com.jkr.traceability.service.impl;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.json.JSONUtil;
import com.alibaba.fastjson2.JSON;
import com.jkr.auth.domain.CbAuthBussContract;
import com.jkr.auth.service.ICbAuthBussContractService;
import com.jkr.base.enums.ContractStatus;
import com.jkr.common.constant.ConstantCode;
import com.jkr.common.exception.ServiceException;
import com.jkr.contract.domain.TransactionInputParam;
import com.jkr.contract.service.ICbContractService;
import com.jkr.traceability.service.IProxyService;
import com.jkr.uitls.Web3Tools;
import org.fisco.bcos.sdk.abi.ABICodecException;
import org.fisco.bcos.sdk.abi.datatypes.Address;
import org.fisco.bcos.sdk.abi.wrapper.ABIDefinition;
import org.fisco.bcos.sdk.model.TransactionReceipt;
import org.fisco.bcos.sdk.transaction.codec.decode.TransactionDecoderInterface;
import org.fisco.bcos.sdk.transaction.model.dto.TransactionResponse;
import org.fisco.bcos.sdk.transaction.model.exception.TransactionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 通过WeBASE-Front的trans/handleWithSign接口发送调用合约的交易，处理添加玩家、修改玩家、查询玩家的逻辑。
 * 重点在于调用WeBASE-Front的发送交易REST接口中传递的合约地址为代理合约的地址，ABI信息为对应实现的逻辑合约的ABI信息，
 * 实验如何通过WeBASE-Front的发送交易接口对代理模式的智能合约的调用及返回结果的解析
 *
 * @author sunyunsheng
 * @version 1.0
 * @date 2023/7/25
 */
@Service
public class ProxyServiceImpl implements IProxyService {

    private static final int CONTRACT_ADDRESS_LENGTH = 42;
    @Autowired
    private TransactionDecoderInterface transactionDecoder;
    @Autowired
    private ICbContractService cbContractService;
    @Autowired
    private ICbAuthBussContractService cbAuthBussContractService;
    public static final String RES_KEY_TRANSHASH = "transHash";
    public static final String RES_KEY_BLOCKNUMBER = "blockNumber";
    public static final String RES_KEY_BLOCKHASH = "blockHash";
    public static final String RES_KEY_STATUS = "status";
    public static final String RES_KEY_MESSAGE = "message";
    public static final String RES_KEY_IS_SUCCESS = "isSuccess";
    public static final String RES_KEY_RESULT = "result";
    public static final String FUNC_GET_PLAYER = "getPlayer";
    public static final String FUNC_ADD_PLAYER = "addPlayer";
    public static final String FUNC_SET_PLAYER = "setPlayer";
    public static final String FUNC_GET_TOTAL_PLAYERS = "getTotalPlayers";
    public static final String PROXY_CONTRACT_NAME = "ProxyGateway";
    public static final String PROXY_CONTRACT_ADDRESS = "0x29552f27d75533c49bd163f62450335b81b993e9";
    public static final String LOGIC_CONTRACT_V1_ADDRESS = "0x2d5871e96a6232ad31165e26e7131f577e3b4d2a";
    public static final String LOGIC_CONTRACT_V2_ADDRESS = "0xeaa498fd9848a2ae4d0710d5291bf472caca7d25";
    /**
     * 根据合约地址查询已部署的合约abi信息，从本地库查询
     * @param contractAddr 合约地址
     * @return
     */
    private CbAuthBussContract getContractAbi(String contractAddr){
        if (contractAddr.length() != CONTRACT_ADDRESS_LENGTH) {
            throw new ServiceException(ConstantCode.CONTRACT_ADDRESS_INVALID);
        }
        // 0x0000000000000000000000000000000000000000 合约地址是无效的
        if (Address.DEFAULT.toString().equals(contractAddr)) {
            throw new ServiceException(ConstantCode.CONTRACT_ADDRESS_INVALID);
        }
        CbAuthBussContract contract = cbAuthBussContractService.selectCbAuthBussContractByAddr(contractAddr);
        if(ObjectUtil.isEmpty(contract) || Integer.parseInt(contract.getStatus()) != ContractStatus.DEPLOYED.getValue()){
            throw new ServiceException(ConstantCode.CONTRACT_NOT_DEPLOY);
        }
        return contract;
    }
    @Override
    public Map<String, Object> addPlayer(String player, int point) throws TransactionException, ABICodecException, IOException {
        //具体实现的逻辑合约地址,在逻辑合约升级时，替换该实现合约地址即可，如修改为LOGIC_CONTRACT_V2_ADDRESS
        String implementionContractAddr = LOGIC_CONTRACT_V1_ADDRESS;
        // 根据逻辑合约地址查询本地库存储的逻辑合约信息，通过平台部署的逻辑合约
        CbAuthBussContract contract = getContractAbi(implementionContractAddr);
        //--------------------------构建交易输入参数-----------------------------------------
        TransactionInputParam param = new TransactionInputParam();
        //群组ID
        param.setGroupId(1);
        //此处为代理合约名称
        param.setContractName(PROXY_CONTRACT_NAME);
        //此处为代理合约地址
        param.setContractAddress(PROXY_CONTRACT_ADDRESS);
        //此处为逻辑合约ABI信息，集合形式
        param.setContractAbi(JSON.parseArray(contract.getContractAbi(),Object.class));
        //此处为逻辑合约ABI信息，json格式字符串
        param.setContractAbiStr(contract.getContractAbi());
        //业务方调用的外部账户地址
        param.setUser("0x358b4d5388d5812c9a25d2dcee52bed7c840e66d");
        //要调用的逻辑合约的函数名称
        param.setFuncName(FUNC_ADD_PLAYER);
        //构建逻辑合约函数的输入参数，如添加玩家函数addPlayer的输入参数为 玩家地址和分数
        List<Object> funcParamList = CollUtil.newLinkedList();
        funcParamList.add(player);
        funcParamList.add(point);
        return sendTransactionToContract(param,funcParamList);
    }

    @Override
    public Map<String,Object> getPlayer(String player) throws TransactionException, ABICodecException, IOException {
        //具体实现的逻辑合约地址
        String implementionContractAddr = LOGIC_CONTRACT_V1_ADDRESS;
        // 根据逻辑合约地址查询本地库存储的逻辑合约信息
        CbAuthBussContract contract = getContractAbi(implementionContractAddr);
        //--------------------------构建交易输入参数-----------------------------------------
        TransactionInputParam param = new TransactionInputParam();
        //群组ID
        param.setGroupId(1);
        //此处为代理合约名称
        param.setContractName(PROXY_CONTRACT_NAME);
        //此处为代理合约地址
        param.setContractAddress(PROXY_CONTRACT_ADDRESS);
        //此处为逻辑合约ABI信息，集合形式
        param.setContractAbi(JSON.parseArray(contract.getContractAbi(),Object.class));
        //此处为逻辑合约ABI信息，json格式字符串
        param.setContractAbiStr(contract.getContractAbi());
        //业务方调用的外部账户地址
        param.setUser("0x358b4d5388d5812c9a25d2dcee52bed7c840e66d");
        //要调用的逻辑合约的函数名称
        param.setFuncName(FUNC_GET_PLAYER);
        //构建逻辑合约函数的输入参数，如添加玩家函数addPlayer的输入参数为 玩家地址和分数
        List<Object> funcParamList = CollUtil.newLinkedList();
        funcParamList.add(player);

        return sendTransactionToContract(param,funcParamList);
    }

    @Override
    public Map<String, Object> setPlayer(String player, int point) throws TransactionException, ABICodecException, IOException {
        //具体实现的逻辑合约地址
        String implementionContractAddr = LOGIC_CONTRACT_V1_ADDRESS;
        // 根据逻辑合约地址查询本地库存储的逻辑合约信息
        CbAuthBussContract contract = getContractAbi(implementionContractAddr);
        //--------------------------构建交易输入参数-----------------------------------------
        TransactionInputParam param = new TransactionInputParam();
        //群组ID
        param.setGroupId(1);
        //此处为代理合约名称
        param.setContractName(PROXY_CONTRACT_NAME);
        //此处为代理合约地址
        param.setContractAddress(PROXY_CONTRACT_ADDRESS);
        //此处为逻辑合约ABI信息，集合形式
        param.setContractAbi(JSON.parseArray(contract.getContractAbi(),Object.class));
        //此处为逻辑合约ABI信息，json格式字符串
        param.setContractAbiStr(contract.getContractAbi());
        //业务方调用的外部账户地址
        param.setUser("0x358b4d5388d5812c9a25d2dcee52bed7c840e66d");
        //要调用的逻辑合约的函数名称
        param.setFuncName(FUNC_SET_PLAYER);
        //构建逻辑合约函数的输入参数，如添加玩家函数addPlayer的输入参数为 玩家地址和分数
        List<Object> funcParamList = CollUtil.newLinkedList();
        funcParamList.add(player);
        funcParamList.add(point);
        return sendTransactionToContract(param,funcParamList);
    }

    @Override
    public Map<String, Object> getTotalPlayers() throws TransactionException, ABICodecException, IOException {
        //具体实现的逻辑合约地址
        String implementionContractAddr = LOGIC_CONTRACT_V1_ADDRESS;
        // 根据逻辑合约地址查询本地库存储的逻辑合约信息
        CbAuthBussContract contract = getContractAbi(implementionContractAddr);
        //--------------------------构建交易输入参数-----------------------------------------
        TransactionInputParam param = new TransactionInputParam();
        //群组ID
        param.setGroupId(1);
        //此处为代理合约名称
        param.setContractName(PROXY_CONTRACT_NAME);
        //此处为代理合约地址
        param.setContractAddress(PROXY_CONTRACT_ADDRESS);
        //此处为逻辑合约ABI信息，集合形式
        param.setContractAbi(JSON.parseArray(contract.getContractAbi(),Object.class));
        //此处为逻辑合约ABI信息，json格式字符串
        param.setContractAbiStr(contract.getContractAbi());
        //业务方调用的外部账户地址
        param.setUser("0x358b4d5388d5812c9a25d2dcee52bed7c840e66d");
        //要调用的逻辑合约的函数名称
        param.setFuncName(FUNC_GET_TOTAL_PLAYERS);
        //构建逻辑合约函数的输入参数，对于无参函数，要使用空集合来构建输入参数
        List<Object> funcParamList = CollUtil.newLinkedList();
        return sendTransactionToContract(param,funcParamList);
    }

    /**
     * 通用发送交易到合约的接口
     * @param param 发送交易到合约的请求参数
     * @param funcParamList 合约函数参数
     * @return
     * @throws TransactionException
     * @throws ABICodecException
     * @throws IOException
     */
    private Map<String,Object> sendTransactionToContract(TransactionInputParam param,List<Object> funcParamList)
            throws TransactionException, ABICodecException, IOException {
        param.setFuncParam(funcParamList);
        //此处调用WeBASE-Front前置服务的trans/handleWithSign接口发送交易，sendTransaction方法，参加下方代码示例
        Object transRsp = cbContractService.sendTransaction(param);
        Map<String,Object> resMap = new HashMap<>();
        ABIDefinition funcAbi = Web3Tools.getAbiDefinition(param.getFuncName(), param.getContractAbiStr());
        boolean isTxConstant = funcAbi.isConstant();
        if(isTxConstant){
            //合约函数为读操作，有函数返回值，直接转换transRsp
            resMap.put(RES_KEY_IS_SUCCESS,true);
            resMap.put(RES_KEY_RESULT, JSONUtil.toJsonStr(transRsp));
        }else {
            //合约函数为写操作，有交易回执，对交易回执进行解析
            TransactionResponse transactionResponse = transactionDecoder.decodeReceiptWithValues(param.getContractAbiStr(),
                    param.getFuncName(), JSON.to(TransactionReceipt.class,JSON.toJSONString(transRsp)));
            if(transactionResponse.getTransactionReceipt().isStatusOK()) {
                resMap.put(RES_KEY_IS_SUCCESS, true);
                resMap.put(RES_KEY_TRANSHASH, transactionResponse.getTransactionReceipt().getTransactionHash());
                resMap.put(RES_KEY_BLOCKNUMBER, transactionResponse.getTransactionReceipt().getBlockNumber());
                resMap.put(RES_KEY_BLOCKHASH, transactionResponse.getTransactionReceipt().getBlockHash());
                resMap.put(RES_KEY_STATUS, transactionResponse.getTransactionReceipt().getStatus());
                resMap.put(RES_KEY_MESSAGE, transactionResponse.getTransactionReceipt().getMessage());
            }
        }
        return resMap;
    }
}
```

**sendTransaction方法：**

```java
/**
 * 发送交易请求到WeBASE-Front前置服务的trans/handleWithSign接口
 *
 * @param param 交易的输入参数
 * @return 交易结果
 * @throws ServiceException 业务异常
 */
@Override
public Object sendTransaction(TransactionInputParam param) throws ServiceException  {
    log.debug("start sendTransaction. param:{}", JSON.toJSONString(param));

    if (Objects.isNull(param)) {
        log.info("fail sendTransaction. request param is null");
        throw new ServiceException(ConstantCode.INVALID_PARAM_INFO);
    }

    // 检查合约ID
    String contractAbiStr = param.getContractAbiStr();
    if (param.getContractId() != null) {
        //获取合约abi信息
        CbContract contract = verifyContractIdExist(param.getContractId(), param.getGroupId());
        contractAbiStr = contract.getContractAbi();
        //发送abi到前置服务
        sendAbi(param.getGroupId(), param.getContractId(), param.getContractAddress());

    } else if(StrUtil.isEmpty(param.getContractAbiStr())){
        CbAbi abiParam = new CbAbi();
        abiParam.setGroupId(param.getGroupId());
        abiParam.setContractAddress(param.getContractAddress());
        CbAbi abiInfo = cbAbiService.selectCbAbi(abiParam);
        contractAbiStr = abiInfo.getContractAbi();
    }

    //如果是常量修饰的函数，signUserId可以不使用
    ABIDefinition funcAbi = Web3Tools.getAbiDefinition(param.getFuncName(), contractAbiStr);
    String signUserId = "empty";

    boolean isConstant = (STATE_MUTABILITY_VIEW.equals(funcAbi.getStateMutability()) ||
            STATE_MUTABILITY_PURE.equals(funcAbi.getStateMutability()));
    if (!isConstant) {
        // !funcAbi.isConstant()
        signUserId = cbPkeyInfoService.getSignUserIdByAddress(param.getGroupId(), param.getUser());
    }

    //通过前置服务发送交易到区块链，FrontRestTools工具类封装的http请求，及WeBASE-Front前置服务的接口地址，如URI_SEND_TRANSACTION_WITH_SIGN = "trans/handleWithSign";
    TransactionParam transParam = new TransactionParam();
    BeanUtils.copyProperties(param, transParam);
    transParam.setSignUserId(signUserId);
    Object frontRsp = frontRestTools
            .postForEntity(param.getGroupId(), FrontRestTools.URI_SEND_TRANSACTION_WITH_SIGN, transParam,
                    Object.class);
    log.debug("end sendTransaction. frontRsp:{}", JSON.toJSONString(frontRsp));
    return frontRsp;
}
```

### 七、逻辑合约V1版部署、测试

  首先我们部署代理合约ProxyGateway.sol，ImplementationV1.sol的逻辑合约，代理合约部署地址为0x29552f27d75533c49bd163f62450335b81b993e9，逻辑合约部署地址为0x2d5871e96a6232ad31165e26e7131f577e3b4d2a，并且将代理合约ProxyGateway的具体实现地址设置为ImplementationV1的合约地址，如下图：

![img](https://segmentfault.com/img/bVc9eoO)

  以添加玩家信息为例，JAVA代码中将addPlayer方法中的逻辑合约地址设置为LOGIC_CONTRACT_V1_ADDRESS = "0x2d5871e96a6232ad31165e26e7131f577e3b4d2a"，方法中会根据逻辑合约地址查询本地库中部署的合约的ABI信息，将构建发往WeBASE-Front前置服务的交易处理请求参数中的contractName合约名称设置为代理合约的名称、contractAddress合约地址设置为代理合约地址、contractAbi合约ABI设置为逻辑合约的ABI、函数名称设置为要调用的逻辑合约的函数名addPlayer，通过Postman模拟发起http请求添加玩家信息，请求结果如下图：
![img](https://segmentfault.com/img/bVc9eoP)

  通过调用结果的输出，我们可以看到通过代理合约能够成功委托调用到逻辑合约的addPlayer函数，并且解析交易回执信息时，与直接调用逻辑合约时解析交易回执是同样的方式，不用做任何更改。我们进入平台查询链上交易信息，来验证此次交易请求是否真的是发送到代理合约，并由代理合约委托调用逻辑合约的addPlayer函数，交易信息查询结果如下图：

![img](https://segmentfault.com/img/bVc9eoR)

  通过链上交易信息的查询，可以看到目标账户地址是代理合约的地址 0x29552f27d75533c49bd163f62450335b81b993e9，交易的输入是逻辑合约的addPlayer函数及输入参数。
  利用ImplementationV1逻辑合约的getPlayer函数，查询当前添加的玩家信息，该结果作为逻辑合约升级后，对比查询同一个玩家信息是否还会存在，验证数据合约分离当逻辑合约升级重新部署后，数据是否会丢失，查询结果如下：

![img](https://segmentfault.com/img/bVc9eoS)

### 八、逻辑合约升级V2版部署、测试

  ImplementationV2.sol为升级后的合约，继承了ImplementationV1.sol合约(当然也可以不用继承v1合约，直接继承Storage数据合约，此处示例继承V1合约主要是演示对父类合约函数的addPlayer函数的重写、以及继承父类的getPlayer函数)。ImplementationV2.sol合约代码在《代理模式合约样例》章节中。
   逻辑合约升级的过程是，首先部署ImplementationV2.sol合约，获取逻辑合约V2的部署地址后，调用代理合约ProxyGateway的setImpl函数，重新设置代理合约的实现地址，如下图：

![img](https://segmentfault.com/img/bVc9eoW)

   代理合约设置为升级后的ImplementationV2逻辑合约之后，验证先前调用ImplementationV1逻辑合约添加的玩家信息是否存在：

![img](https://segmentfault.com/img/bVc9eoZ)

   JAVA代码调用示例中，修改各函数调用的交易请求参数构建，其中代理合约名称和代理合约地址保持不变，修改逻辑合约地址为 LOGIC_CONTRACT_V2_ADDRESS = "0xeaa498fd9848a2ae4d0710d5291bf472caca7d25"，验证ImplementationV2逻辑合约新增加的setPlayer修改玩家函数是否可以正常调用成功，结果如下：

![img](https://segmentfault.com/img/bVc9eo0)

   我们进入平台查询链上交易信息，来验证此次交易请求是否真的是发送到代理合约，并由代理合约委托调用逻辑合约的setPlayer函数，交易信息查询结果如下图：

![img](https://segmentfault.com/img/bVc9eo1)

   验证ImplementationV2逻辑合约重写ImplementationV1逻辑合约的addPlayer函数，对totalPlayers变量的更改效果：

![img](https://segmentfault.com/img/bVc9eo2)

   验证ImplementationV2逻辑合约的getTotalPlayers函数的结果：

![img](https://segmentfault.com/img/bVc9eo3)

> 注意：从整个测试过程中做了两次addPlayer函数的调用，添加了两个玩家，但此处totalPlayers变量值为1，是因为在ImplementationV1逻辑合约中的addPlayer函数中未启用累加totalPlayers变量的值，只在升级后的ImplementationV2逻辑合约中进行累加了，所以最终结果是1，勿纠结该结果是1还是2，本示例仅是为了演示合约升级的调用处理过程。

**通过以上步骤的实验，可以总结如下：**

​    基于代理模式的三层结构合约，代理合约、逻辑合约、数据合约分离模式，可以实现逻辑与数据的分离，保证逻辑合约的升级不会丢失数据，同时代理合约作为业务方调用的入口合约可以保持不变，仅通过升级中间逻辑合约即可。利用代理合约的底层代码调用实现对逻辑合约函数的委托调用，业务方只需要获取代理合约名称、代理合约地址、逻辑合约ABI、所需要调用的函数名称及对应的输入参数，通过WeBASE-Front的发送交易REST接口实现通用的交易发送接口，且对于写操作的交易回执解析、读操作的函数返回值解析与直接调用逻辑合约的方式结果是一致的。

### 九、方案总结

   对于智能合约的调用，常见的方案有通过合约脚手架生成java调用代码，将调用代码紧耦合到应用项目中，使业务应用中直接连接区块链节点进行合约的调用，此种方式的弊端是当合约升级改动后，需要重新生成java调用代码，替换原有调用代码，对合约升级给业务应用造成不便。另外一种方式是业务应用中通过WeBASE-Front前置服务提供的REST风格的交易处理接口(结合WeBASE-Sign私钥托管签名服务，实现交易云签名)，将合约的调用从业务应用中解耦，合约的升级改动，对业务应用调用发送交易接口无任何影响，业务应用中仅需要调整交易组装参数中的值即可。据此思路我司开发的区块链BaaS平台中采用的是集成WeBASE-Front前置服务的REST接口，进行链上合约的调用。架构模式如下：

![img](https://segmentfault.com/img/bVc9eo5)
