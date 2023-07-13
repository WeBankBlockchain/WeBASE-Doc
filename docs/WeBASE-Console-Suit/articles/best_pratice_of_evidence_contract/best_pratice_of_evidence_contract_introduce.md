# 99Kies | 玩转存证合约（一）| 合约介绍

**实验环境**

FISCO BCOS （<https://github.com/fisco-bcos>）

WeBase-Front （<https://blog.csdn.net/qq_19381989/article/details/112228750?spm=1001.2014.3001.5501>）

Centos7


**项目地址：<https://github.com/99Kies/Evidence-Sample-Python>**
## 前言

存证合约的主要功能有 添加存证，添加签名。我们此次主要以研读存证合约为主，然后再通过python sdk调用合约实现后端API。


## 合约部署以及功能介绍

### 合约内容

**EvidenceFactory.sol**

```javascript
pragma solidity ^0.4.4;
import "Evidence.sol";

contract EvidenceFactory{
        address[] signers;
		event newEvidenceEvent(address addr);
        function newEvidence(string evi)public returns(address)
    		// 创建新存证
        {
            Evidence evidence = new Evidence(evi, this);
            newEvidenceEvent(evidence);
            return evidence;
        }
        
        function getEvidence(address addr) public constant returns(string,address[],address[]){
            // 通过evidence地址获取具体内容。
            return Evidence(addr).getEvidence();
        }

                
        function addSignatures(address addr) public returns(bool) {
            // 添加存证签名
            return Evidence(addr).addSignatures();
        }
        
        constructor(address[] evidenceSigners){
            for(uint i=0; i<evidenceSigners.length; ++i) {
            signers.push(evidenceSigners[i]);
			}
		}

        function verify(address addr)public constant returns(bool){
            // 验证是否存在该用户。
                for(uint i=0; i<signers.length; ++i) {
                if (addr == signers[i])
                {
                    return true;
                }
            }
            return false;
        }

        function getSigner(uint index)public constant returns(address){
            // 通过下标索引获取对应的账户地址。
            uint listSize = signers.length;
            if(index < listSize)
            {
                return signers[index];
            }
            else
            {
                return 0;
            }
    
        }

        function getSignersSize() public constant returns(uint){
            // 获取用户的数量。
            return signers.length;
        }
    
        function getSigners() public constant returns(address[]){
            // 列出所有的用户地址。
            return signers;
        }

}
```



**Evidence.sol**

```javascript
pragma solidity ^0.4.4;

contract EvidenceSignersDataABI
{
	function verify(address addr)public constant returns(bool){}
	function getSigner(uint index)public constant returns(address){} 
	function getSignersSize() public constant returns(uint){}
}

contract Evidence{
    
    string evidence;
    address[] signers;
    address public factoryAddr;
    
    event addSignaturesEvent(string evi);
    event newSignaturesEvent(string evi, address addr);
    event errorNewSignaturesEvent(string evi, address addr);
    event errorAddSignaturesEvent(string evi, address addr);
    event addRepeatSignaturesEvent(string evi);
    event errorRepeatSignaturesEvent(string evi, address addr);

    function CallVerify(address addr) public constant returns(bool) {
        return EvidenceSignersDataABI(factoryAddr).verify(addr);
    }

   constructor(string evi, address addr)  {
       factoryAddr = addr;
       if(CallVerify(tx.origin))
       {
           evidence = evi;
           signers.push(tx.origin);
           newSignaturesEvent(evi,addr);
       }
       else
       {
           errorNewSignaturesEvent(evi,addr);
       }
    }

    function getEvidence() public constant returns(string,address[],address[]){
        uint length = EvidenceSignersDataABI(factoryAddr).getSignersSize();
         address[] memory signerList = new address[](length);
         for(uint i= 0 ;i<length ;i++)
         {
             signerList[i] = (EvidenceSignersDataABI(factoryAddr).getSigner(i));
         }
        return(evidence,signerList,signers);
    }

    function addSignatures() public returns(bool) {
        for(uint i= 0 ;i<signers.length ;i++)
        {
            if(tx.origin == signers[i])
            {
                addRepeatSignaturesEvent(evidence);
                return true;
            }
        }
       if(CallVerify(tx.origin))
       {
            signers.push(tx.origin);
            addSignaturesEvent(evidence);
            return true;
       }
       else
       {
           errorAddSignaturesEvent(evidence,tx.origin);
           return false;
       }
    }
    
    function getSigners()public constant returns(address[])
    {
         uint length = EvidenceSignersDataABI(factoryAddr).getSignersSize();
         address[] memory signerList = new address[](length);
         for(uint i= 0 ;i<length ;i++)
         {
             signerList[i] = (EvidenceSignersDataABI(factoryAddr).getSigner(i));
         }
         return signerList;
    }
}
```

在这里EvidenceFactory.sol合约导入了Evidence合约，Evidence.sol合约其实相当于提供了一个**Evidence类**，存证的数据结构和接口在这里实现，EvidenceFactory.sol合约只需要声明和调用即可。（所以需要把这两个合约放在同一级目录下，然后部署EvidenceFactory.sol合约即可）



可见我们的合约里提供了**创建新存证**，**获取存证信息**，**添加存证签名**，**验证用户**，**获取所有用户地址**，**获取相应用户地址**，**获取用户数量**的函数功能。

> tips：EvidenceFactory.sol 中导入了 Evidence.sol合约，所以部署的时候，只需要部署EvidenceFactory.sol即可。

### 可视化部署

利用webase-front实现部署。

【如何使用webase-front部署合约：<https://blog.csdn.net/qq_19381989/article/details/112228750?spm=1001.2014.3001.5501>】

这里需要把Evidence.sol 和 EvidenceFactory.sol 放在同一个文件夹下，然后再部署即可成功。

**生成多个测试用户**
![在这里插入图片描述](https://img-blog.csdnimg.cn/202103050154448.png)

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305015508950.png)

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305015539674.png)




> 我这里的两个用户地址分别为 0x28b7a9da9f3a92e139b58181aee04d0720cdd767, 0x405b66921a8ec0899d60961834982aa207acc922。我们需要用到用户来部署合约以及实现签名功能。



**部署EvidenceFactory.sol**

部署EvidenceFactory合约时需要提供signers的地址列表，所以我们在前面需要创建**多个用户**用于**部署合约**。

对应代码：

```javascript
constructor(address[] evidenceSigners){
    for(uint i=0; i<evidenceSigners.length; ++i) {
        signers.push(evidenceSigners[i]);
    }
}
```

>  tips：使用`constructor`关键字声明的函数。创建合约时执行一次。

把Evidence.sol 和 EvidenFactory.sol存放在同一目录下，并部署EvidenceFactory.sol合约。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305015628480.png)


在这里我们把创建的两个用户以[]address的形式传入。**["0x28b7a9da9f3a92e139b58181aee04d0720cdd767", "0x405b66921a8ec0899d60961834982aa207acc922"]**
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305015723913.png)


部署成功

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305015743611.png)




### 调用合约
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305015759454.png)

可见**创建新存证**，**获取存证信息**，**添加存证签名**，**验证用户**，**获取所有用户地址**，**获取相应用户地址**，**获取用户数量**的合约接口。

我们从创建合约开始介绍，一步一步实现存证的多签功能。

**newEvidence -- 创建新合约**

对应的函数

```javascript
function newEvidence(string evi)public returns(address)
// 创建新存证
{
    Evidence evidence = new Evidence(evi, this);
    newEvidenceEvent(evidence);
    return evidence;
}
```



选择方法名以及首次签名的用户。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305015818408.png)


写入存证信息。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305015853819.png)


部署成功。

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305015908777.png)


我们可以通过存证地址 **0x96B75240e58abff69636510c3d3CE641fA48696B** ，来查看存证信息。



**getEvidence -- 获取存证信息**

对应函数：

```javascript
function getEvidence(address addr) public constant returns(string,address[],address[]){
    return Evidence(addr).getEvidence();
}
```

根据Evidence的地址来查看存证的信息，（存证内容，合约账户，签名者）

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305015943536.png)

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305015957573.png)


**addSignerature -- 添加存证签名**

相关函数：

```javascript
function addSignatures(address addr) public returns(bool) {
    return Evidence(addr).addSignatures();
}
```

根据指定用户向指定合约签名。

选择另外一个用户 `fengfeng2`对 **0x96B75240e58abff69636510c3d3CE641fA48696B** 合约签名。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305020015266.png)

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305020046496.png)


成功签名
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305020110688.png)

我们可以重新调用**getEvidence** 进行查看。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305020132101.png)
成功实现了多签。

**verify -- 验证用户**

相关函数：

```javascript
function verify(address addr)public constant returns(bool){
    for(uint i=0; i<signers.length; ++i) {
        if (addr == signers[i])
        {
            return true;
        }
    }
    return false;
}
```

验证地址是否为用户地址。（即是否为合约部署时提供的用户地址）

使用上述的 0x28b7a9da9f3a92e139b58181aee04d0720cdd767 用户地址进行测试。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305020219486.png)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305020235753.png)




**getSigners -- 获取所有用户地址**

相关函数：

```javascript
function getSigners() public constant returns(address[]){
    return signers;
}
```

获取所有用户地址
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305020251795.png)

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305020308479.png)


**getSigner -- 获取相应用户地址**

相关函数：

```javascript
function getSigner(uint index)public constant returns(address){
    uint listSize = signers.length;
    if(index < listSize)
    {
        return signers[index];
    }
    else
    {
        return 0;
    }
}
```

根据下标索引查询用户地址。（下标从0开始）
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305020421658.png)

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305020438976.png)




**getSignersSize -- 获取用户数量**

相关函数：

```javascript
function getSignersSize() public constant returns(uint){
    return signers.length;
}
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305020455464.png)![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305020510125.png)


## 总结

在这里我们复现了存证合约并部署和调用了合约，但是如何利用高级开发语言对合约进行调用呢，我会在下节利用Python对这个合约进行调用，实现api接口。



## 参考链接

<https://blog.csdn.net/hindsights/article/details/80360636>

<https://blog.csdn.net/qq_19381989/article/details/112228750?spm=1001.2014.3001.5501>

## 关于作者

<div align=center><a href="https://blog.csdn.net/qq_19381989" target="_blank"><img src="https://img-blog.csdnimg.cn/20200427000145250.png" width="40%" /></a></div>


**作者的联系方式：**

微信：`thf056`
qq：1290017556
邮箱：1290017556@qq.com

你也可以通过 <strong><a href="https://github.com/99kies" target="_blank">github</a></strong> | <strong><a href="https://blog.csdn.net/qq_19381989" target="_blank">csdn</a></strong> | <strong><a href="https://weibo.com/99kies" target="_blank">@新浪微博</a></strong> 关注我的动态
