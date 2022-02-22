# 实训一：运行第一个智能合约

使用Solidity语言编写一个HelloWorld合约，合约包含一个string变量、一个get方法和一个set方法。
1. 构造函数初始化该变量为”Hello world!”
2. 提供get方法获取变量string的值
3. 提供set方法设置变量string的值

例：
```js
pragma solidity >=0.4.25 <0.6.11;
contract HelloWorld {     
string name;  
    
constructor() public ...
function get() public ...
function set() public ...
}
```


## 实验步骤：

#### 1）准备好区块链运行环境

使用FISCO BCOS搭建4节点的区块链，也可用系统自带的区块链。

#### 2）编写智能合约
可使用系统自带的智能合约IDE编写智能合约

**提交方式：**
- 提交智能合约源码

#### 3）编译部署智能合约
合约IDE进行编译、部署

**提交方式：**
- 部署成功后的交易回执截图
- 部署成功后的智能合约截图，截图应包含合约地址

#### 4）向部署的智能合约发送交易
编写一个区块链应用程序，可以通过SDK连接区块链节点，并向智能合约发送交易。

**提交方式：**
- 提交初始化SDK连接节点源码代码
- 提交HelloWorld合约Java类截图
- 提交调用合约Java类set方法的源代码
- 通过Java调用HelloWorld合约set方法，将变量设置为“Hello From Java!”，在控制台输出交易哈希，截图并提交
- 通过合约IDE调用合约，获取string变量的值，其值应为“Hello From Java!”，截图返回结果并提交

#### 5）通过区块链浏览器查看交易
发送的交易（交易哈希）可通过系统自带的区块链浏览器展示，确认在哪个区块中。

**提交方式：**
- 区块链浏览器中交易回执/交易详情的截图


## 参考答案：

#### 1） 智能合约：
- 要求constructor构造函数初始化string变量
- 要求get方法是查询交易view/constant/pure中的一种，返回string变量的值
- 要求set方法设置string变量

源码参考（实现方式不唯一）：
```js
pragma solidity >=0.4.25 <0.6.11;
contract HelloWorld {     
string name;      
constructor() public 
{        
  name = "Hello, World!";     
}      
function get() public view returns (string memory){         
    return name;    
 }      
function set(string memory n) public {         
   name = n;    
 }
}
```

#### 2）调用端：

以Java语言为例，从Solidity智能合约，生成合约Java类，并传入调用set方法所需参数。
- 要求加载SDK的Client实例连接节点截图
- 要求合约Java类的源码截图，可通过工具将Solidity源码转为Java类
- 要求传入合约地址、SDK连接实例及私钥对来初始化/加载一个HelloWorld合约实例
- 要求调用合约实例的set方法，入参为"Hello sent from Java!"
- 要求输出/打印/记录调用set方法返回的交易回执，或打印交易回执的交易哈希

合约Java类参考：
```java
package com.sx.demo;
// import内容，略

public class HelloWorld extends Contract {
    // BIN和ABI内容略
    public static final String[] BINARY_ARRAY = {""};
    public static final String BINARY = org.fisco.bcos.sdk.utils.StringUtils.joinAll("", BINARY_ARRAY);
    public static final String[] SM_BINARY_ARRAY = {""};
    public static final String SM_BINARY = org.fisco.bcos.sdk.utils.StringUtils.joinAll("", SM_BINARY_ARRAY);
    public static final String[] ABI_ARRAY = {""};
    public static final String ABI = org.fisco.bcos.sdk.utils.StringUtils.joinAll("", ABI_ARRAY);

    public static final String FUNC_SET = "set";
    public static final String FUNC_GET = "get";

    protected HelloWorld(String contractAddress, Client client, CryptoKeyPair credential) {
        super(getBinary(client.getCryptoSuite()), contractAddress, client, credential);
    }

    public static String getBinary(CryptoSuite cryptoSuite) {
        return (cryptoSuite.getCryptoTypeConfig() == CryptoType.ECDSA_TYPE ? BINARY : SM_BINARY);
    }

    public TransactionReceipt set(String n) {
        final Function function = new Function(
                FUNC_SET, 
                Arrays.<Type>asList(new org.fisco.bcos.sdk.abi.datatypes.Utf8String(n)), 
                Collections.<TypeReference<?>>emptyList());
        return executeTransaction(function);
    }

    public String get() throws ContractException {
        final Function function = new Function(FUNC_GET, 
                Arrays.<Type>asList(), 
                Arrays.<TypeReference<?>>asList(new TypeReference<Utf8String>() {}));
        return executeCallWithSingleValueReturn(function, String.class);
    }

    public static HelloWorld load(String contractAddress, Client client, CryptoKeyPair credential) {
        return new HelloWorld(contractAddress, client, credential);
    }
}
```

合约Java类调用源码参考，以单元测试代码为例（SDK连接节点端的Client实例初始化代码以截图为准）。
```java
@RunWith(SpringRunner.class)
@SpringBootTest(classes = Application.class)
@WebAppConfiguration
public class RawServiceTest {

    // 获取SDK连接节点的Client实例
    @Autowired
    private Client client;

    @Test
    public void testHello() throws Exception {
        // 合约地址
        String contractAddress = "0xb2b3f596797c37745fbe92e52f0e39837230c25b";
        // 创建一个私钥对
        CryptoKeyPair keyPair = client.getCryptoSuite().createKeyPair();
        // 加载HelloWorld合约
        HelloWorld helloWorld = HelloWorld.load(contractAddress, client, keyPair);
        // 调用HelloWorld合约set方法
        TransactionReceipt receipt = helloWorld.set("Hello sent from Java!");
        // 打印交易回执的交易哈希
        System.out.println(receipt.getTransactionHash());
    }
}
```

#### 3）区块链浏览器查看上链结果：

根据步骤2可以得到在Java端调用HelloWorld的set方法后，得到的交易哈希。拿到交易哈希后，可以通过区块链浏览器，查看交易哈希对应的交易回执的详情。
- 要求区块链浏览器上查询的交易哈希与上文调用的交易哈希一致、交易的被调用方to为上文部署的合约地址
- 要求交易回执的状态为成功（此处为0x0）
 
下图以WeBASE-Front为例，查看交易回执
![](../../../images/WeBASE-Training/check_trans_hash.png)

