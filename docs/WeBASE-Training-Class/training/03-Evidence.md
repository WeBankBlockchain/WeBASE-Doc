# 实训三：实现存证合约

使用Solidity语言实现存证合约，包含一个Evidence合约和一个EvidenceFactory合约。

题目合约内容：

**Evidence合约**


```js
pragma solidity ^0.4.25;

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
        return EvidenceSignersDataABI(factoryAddr)./*请在序号后填入 ，勿删除序号[1-1]*/(addr);
    }

   constructor(string evi, address addr) {
       factoryAddr = /*请在序号后填入 ，勿删除序号[1-2]*/;
       if(CallVerify(tx.origin)){
           /*请在序号后填入 ，勿删除序号[1-3]*/
           newSignaturesEvent(evi,addr);
       }else{
           errorNewSignaturesEvent(evi,addr);
       }
    }

    function getEvidence() public constant returns(string,address[],address[]){
        uint length = EvidenceSignersDataABI(factoryAddr)./*请在序号后填入 ，勿删除序号[1-4]*/;
         address[] memory signerList = /*请在序号后填入 ，勿删除序号[1-5]*/(length);
         for(uint i= 0 ;i<length ;i++) {
             signerList[i] = (EvidenceSignersDataABI(factoryAddr)./*请在序号后填入 ，勿删除序号[1-6]*/(i));
         }
        return(/*请在序号后填入 ，勿删除序号[1-6]*/,signerList,signers);
    }

    function addSignatures() public returns(bool) {
        for(uint i= 0 ;i</*请在序号后填入 ，勿删除序号[1-7]*/.length ;i++) {
            if(tx.origin == signers[i]) {
                addRepeatSignaturesEvent(evidence);
                return /*请在序号后填入 ，勿删除序号[1-8]*/;
            }
        }
       if(CallVerify(tx.origin)) {
            signers./*请在序号后填入 ，勿删除序号[1-9]*/;
            addSignaturesEvent(evidence);
            return /*请在序号后填入 ，勿删除序号[1-10]*/;
       } else {
           errorAddSignaturesEvent(evidence,tx.origin);
           return /*请在序号后填入 ，勿删除序号[1-11]*/;
       }
    }
    
    function getSigners()public constant returns(address[])
    {
         uint length = EvidenceSignersDataABI(factoryAddr)./*请在序号后填入 ，勿删除序号[1-12]*/;
         address[] memory signerList = /*请在序号后填入 ，勿删除序号[1-13]*/(length);
         for(uint i= 0 ;i<length ;i++) {
             signerList[i] = (EvidenceSignersDataABI(factoryAddr)./*请在序号后填入 ，勿删除序号[1-14]*/);
         }
         return signerList;
    }
}
```

**EvidenceFactory合约**

```js
pragma solidity ^0.4.25;
import "Evidence.sol";

contract EvidenceFactory{
    address[] signers;
	event newEvidenceEvent(address addr);

    constructor(address[] evidenceSigners){
        for(uint i=0; i<evidenceSigners.length; ++i) {
            signers./*请在序号后填入 ，勿删除序号[2-1]*/;
		}
	}
	
    function newEvidence(string evi)public returns(address){
        Evidence evidence = /*请在序号后填入 ，勿删除序号[2-2]*/;
        newEvidenceEvent(evidence);
        return evidence;
    }
    
    function getEvidence(address addr) public constant returns(string,address[],address[]){
        return Evidence(addr)./*请在序号后填入 ，勿删除序号[2-3]*/;
    }
            
    function addSignatures(address addr) public returns(bool) {
        return Evidence(addr)./*请在序号后填入 ，勿删除序号[2-4]*/;
    }

    function verify(address addr)public constant returns(bool){
        for(uint i=0; i<signers.length; ++i) {
            if (addr == signers[i]) {
                return /*请在序号后填入 ，勿删除序号[2-5]*/;
            }
        }
        return /*请在序号后填入 ，勿删除序号[2-6]*/;
    }

    function getSigner(uint index)public constant returns(address){
        uint listSize = signers.length;
        if(index < listSize) {
            return /*请在序号后填入 ，勿删除序号[2-7]*/;
        } else{
            return 0;
        }
    }

    function getSignersSize() public constant returns(uint){
        return signers./*请在序号后填入 ，勿删除序号[2-8]*/;
    }

    function getSigners() public constant returns(address[]){
        return /*请在序号后填入 ，勿删除序号[2-9]*/;
    }
}
```


## 实验步骤：
#### 1）理解智能合约的功能

1. 分别描述Evidence合约和EvidenceFactory的功能
2. 分别描述Evidence合约中string evidence、address[] signers、address public factoryAddr的作用
3. 描述Evidence合约中EvidenceSignersDataABI合约的作用

#### 2）完成智能合约空缺部分

将题目合约中的空缺部分`/*待填入*/`填补，可使用系统自带的智能合约IDE编写智能合约

**提交方式：**
- 提交智能合约源码，包含Evidence合约中1-1至1-14共14个空，以及EvidenceFactory合约中2-1至2-9共9个空。

#### 3）编译部署智能合约

**填写完合约空缺部分后**，通过合约IDE编译合约。
- 同时，通过创建Alice私钥、Bob私钥和Caron私钥，以Alice、Bob、Caron私钥的地址为参数，部署合约


**提交方式：**
- 提交合约部署成功后的交易回执截图
- 提交部署成功后的智能合约截图，截图应包含合约地址
- 调用合约，获取合约的signer变量的值，提交截图（signer应该是Alice、Bob、Caron的地址）

#### 4）向部署的智能合约发送交易
- 通过Alice私钥调用EvidenceFactory合约的newEvidence方法创建一个存证，提交交易回执截图，并记录Evidence的地址
- 调用EvidenceFactory合约getEvidence方法，传入上一步骤获得的Evidence，获取刚创建的存证，提交截图
- 通过Bob私钥调用EvidenceFactory合约addSignatures方法，提交交易回执截图
- 再调用EvidenceFactory合约getEvidence方法，获取存证中新增的Bob的签名，提交截图

#### 5）编写应用程序调用合约
- 编写一个区块链应用程序，可以通过SDK连接区块链节点，并向智能合约发送交易。

**提交方式：**
- 提交EvidenceFactory合约Java类截图
- 加载Caron私钥，通过Caron的私钥调用EvidenceFactory合约Java类的addSignatures方法，给步骤4中创建的Evidence存证添加Caron的签名，在console控制台输出交易哈希，截图并提交
- 通过Java调用EvidenceFactory合约Java类的getEvidence方法，获取上述步骤所创建的存证，在控制台输出存证的地址和存证签名数，此时签名数应该为3（包含Alice、Bob、Caron的地址），截图并提交


## 参考答案：

#### 1）理解智能合约的功能
1. 分别描述Evidence合约和EvidenceFactory的功能

Evidence合约记录存证内容和各方签名，EvidenceFactory合约用于管理Evidence存证的生成
(Evidence合约指出了用于保存存证即可，EvidenceFactory指出了用于生成或管理Evidence存证即可）

1. 分别描述Evidence合约中string evidence、address[] signers、address public factoryAddr的作用

evidence用于存储存证内容、signers用于存储存证签名者的签名、factoryAddr用于记录存证工厂合约的地址
（evidence指出存储存证即可、signers指出是保存签名即可、factoryAddr指出记录工厂合约或管理存证合约的合约地址即可）

1. 描述Evidence合约中EvidenceSignersDataABI合约的作用

用于调用EvidenceFactory合约中的verify，getSigner，getSignerSize方法
(指出EvidenceSignersDataABI用于获取签名者数据，或signer数据可得分、指出用于调用EvidenceFactory或获取EvidenceFactory签名者数据也可以得分、指出用于EvidenceFactory接口或签名者接口也可以得分。直接翻译verify，getSigner，getSignerSize的中文意思不得分)

#### 2）完成智能合约空缺部分
- 将空缺的部分天上，并成功编译部署合约
- 若未成功部署，则提供参考合约

**Evidence合约**
```js
pragma solidity ^0.4.25;

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
       if(CallVerify(tx.origin)){
           evidence = evi;
           signers.push(tx.origin);
           newSignaturesEvent(evi,addr);
       }else{
           errorNewSignaturesEvent(evi,addr);
       }
    }

    function getEvidence() public constant returns(string,address[],address[]){
        uint length = EvidenceSignersDataABI(factoryAddr).getSignersSize();
         address[] memory signerList = new address[](length);
         for(uint i= 0 ;i<length ;i++) {
             signerList[i] = (EvidenceSignersDataABI(factoryAddr).getSigner(i));
         }
        return(evidence,signerList,signers);
    }

    function addSignatures() public returns(bool) {
        for(uint i= 0 ;i<signers.length ;i++) {
            if(tx.origin == signers[i]) {
                addRepeatSignaturesEvent(evidence);
                return true;
            }
        }
       if(CallVerify(tx.origin)) {
            signers.push(tx.origin);
            addSignaturesEvent(evidence);
            return true;
       } else {
           errorAddSignaturesEvent(evidence,tx.origin);
           return false;
       }
    }
    
    function getSigners()public constant returns(address[]) {
         uint length = EvidenceSignersDataABI(factoryAddr).getSignersSize();
         address[] memory signerList = new address[](length);
         for(uint i= 0 ;i<length ;i++) {
             signerList[i] = (EvidenceSignersDataABI(factoryAddr).getSigner(i));
         }
         return signerList;
    }
}
```

EvidenceFactory合约

```js
pragma solidity ^0.4.25;
import "Evidence.sol";

contract EvidenceFactory{
    address[] signers;
	event newEvidenceEvent(address addr);
	  
    constructor(address[] evidenceSigners){
        for(uint i=0; i<evidenceSigners.length; ++i) {
            signers.push(evidenceSigners[i]);
		}
	}
	
    function newEvidence(string evi)public returns(address) {
        Evidence evidence = new Evidence(evi, this);
        newEvidenceEvent(evidence);
        return evidence;
    }
    
    function getEvidence(address addr) public constant returns(string,address[],address[] {
        return Evidence(addr).getEvidence();
    }

            
    function addSignatures(address addr) public returns(bool) {
        return Evidence(addr).addSignatures();
    }
  

    function verify(address addr)public constant returns(bool){
        for(uint i=0; i<signers.length; ++i) {
            if (addr == signers[i]) {
                return true;
            }
        }
        return false;
    }

    function getSigner(uint index)public constant returns(address){
        uint listSize = signers.length;
        if(index < listSize) {
            return signers[index];
        } else {
            return 0;
        }

    }

    function getSignersSize() public constant returns(uint){
        return signers.length;
    }

    function getSigners() public constant returns(address[]){
        return signers;
    }
}
```

#### 3）编译部署智能合约
若步骤2提交的合约未编译成功，可以使用参考合约进行部署，完成后续操作。
- 要求创建Alice私钥、Bob私钥和Caron私钥共三个用于存证的私钥
- 以Alice、Bob、Caron的地址为参数，部署合约
- 要求提交成功部署合约的截图，截图包含合约的ABI，BIN和部署得到的合约地址
- 调用合约，获取合约的signer变量的值，提交截图（signer应该是Alice、Bob、Caron的地址）

#### 4）向部署的智能合约发送交易
- 要求通过Alice私钥调用EvidenceFactory合约的newEvidence方法创建一个存证，提交交易回执截图
- 要求调用EvidenceFactory合约getEvidence方法，传入上一步骤中newEvidence获得的Evidence的地址，获取刚创建的存证，提交截图
- 要求通过Bob私钥调用EvidenceFactory合约addSignatures方法，提交交易回执截图
- 要求再调用EvidenceFactory合约getEvidence方法，获取存证中新增的Bob的签名，提交截图


#### 5）编写应用程序调用合约
实现功能的编程语言不限，需要提交源码与调用结果的截图
- 提交EvidenceFactory合约Java类截图
- 加载Caron私钥，通过Caron的私钥调用EvidenceFactory合约Java类的addSignatures方法，给步骤4中创建的Evidence存证添加Caron的签名，在console控制台输出交易哈希，截图并提交
- 通过Java调用EvidenceFactory合约Java类的getEvidence方法，获取上述步骤所创建的存证，在控制台输出存证的地址和存证签名数，此时签名数应该为3（包含Alice、Bob、Caron的地址），截图并提交

 
下图以WeBASE-Front为例，查看交易回执
![](../../../images/WeBASE-Training/check_trans_hash.png)