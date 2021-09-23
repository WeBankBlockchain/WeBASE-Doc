## 区块链教程 | 使用WeBASE进行“两阶段交易”
作者：黎宁

作为一个友好的、功能丰富的区块链中间件平台， WeBASE致力于提高区块链开发者的运维与管理效率。在新近发布的 WeBASE v1.5.2 中，一大优化是提供了获取交易编码的接口，更方便用户使用"两阶段交易"。

“两阶段交易”是什么？“两阶段交易”是指分成两个步骤发送交易，即对交易编码并签名、将交易提交到链上这两个阶段：
- 第一阶段：构造并获取交易编码值，并通过私钥对交易编码值签名;
- 第二阶段：发送交易，也就是将已签名的编码值发送到链上。

在WeBASE v1.5.2中，我们在WeBASE-Front节点前置服务中增加了获取交易编码值的功能。该接口可以返回未签名的交易编码值，也可以返回通过WeBASE-Front本地私钥或WeBASE-Sign私钥签名后的交易编码值。获得已签名的编码值后，用户直接调用前置服务的提交交易接口即可完成“两阶段交易”。

以下演示，我们通过WeBASE-Front节点前置服务接口获取交易编码值，并通过FISCO-BCOS Java-SDK对编码值进行签名，最后通过接口提交交易来加深对“两阶段交易”的了解。

### |前期准备

#### 部署HelloWorld合约

在发起交易之前，首先要确保在链上部署一个可调用的合约。这里以WeBASE-Front “合约仓库-工具合约”中的 “HelloWorld” 合约为例，部署一份 HelloWorld 合约。
我们在 WeBASE-Front 的合约IDE中编译一份 HelloWorld 合约并完成部署操作，如下图所示：

获得合约地址、合约ABI等信息后，我们根据 WeBASE-Front 的接口文档指引，调用获取交易编码接口。
#### 查看接口文档
两阶段交易中，第一步交易编码并签名可以通过 WeBASE-Front 的 `/trans/convertRawTxStr/withSign` 接口构造一个已签名的交易体，接口文档简介如下：

值得一提的是，调用 `/trans/convertRawTxStr/withSign` 接口时：
- 如果传入了 signUserId 非空，则返回的交易体编码值是通过signUserId对应私钥签名后的交易体编码值。
- 如果传入的 signUserId 为空，则返回的是未签名的交易体编码值，开发者也可以通过JAVA-SDK用私钥对该值签名。

获取已签名的交易编码值后，就可以进行第二步的提交交易操作了。

在 WeBASE-Front 中，我们可以通过 `/trans/signed-transaction` 接口，将已签名的交易体编码值，完成交易上链并获得交易回执。

上述各个接口的调用方法都可以在 WeBASE-Front 的接口文档中找到（https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/interface.html）。

### |结合WeBASE-Front接口进行“两阶段交易”
#### 获取交易编码值
下面以 WeBASE-Sign 签名的获取交易编码接口( `/trans/convertRawTxStr/withSign` )为例，获取未签名的交易编码值。

我们可以访问 WeBASE-Front 的 Swagger 进行接口调用（如，http://localhost:5002/WeBASE-Front/swagger-ui.html），找到Swagger接口列表中的"transaction interface"交易接口一栏，点开  /trans/convertRawTxStr/withSign 即可。

在文章开头我们提到，“两阶段交易”的第一阶段是交易编码并通过私钥对编码值签名。

因此，我们调用接口时传入的 “signUserId” 为空字符串，接口将返回未签名的交易编码值，稍后我们再通过 Java-SDK 手动对编码值签名。在调用 /trans/convertRawTxStr/local 接口时同理，user地址字段为空字符串时也会返回未签名的交易编码值。

我们以调用HelloWorld合约的 "set" 方法为例，按接口文档填入对应参数。

首先，点开Swagger中的 /trans/convertRawTxStr/withSign 接口，再填入参数包括合约ABI、合约地址、函数名及函数入参、群组ID和WeBASE-Sign的私钥用户ID signUserId，点击"Try it out"输入参数，删除不必要的字段。注意，其中signUserId为空字符串。

点击"Execute"即可发起调用，获得未签名的交易编码值。接口返回值为：

拿到未签名的交易编码值之后，我们接下来通过 Java-SDK 对编码值进行签名。

#### 对交易编码值签名
下面我们使用 FISCO-BCOS Java-SDK 加载私钥，对上文获取的未签名交易编码值进行签名操作，并根据 RawTransaction 交易体再次编码，得到最终签名后的交易编码值。

```Java
    public void testSign(TransactionEncoderService encoderService, RawTransaction rawTransaction) {
        // 未签名的交易编码值
        String encodedTransaction = "0xf8a9a001b41b2cc71fe0bf0450f1fa4d820209b6686a8f226d217be0bc51cd9fc4a020018405f5e100820204941f2dfecfd75b883b51762aef6326d3ae9ad5230180b8644ed3885e000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000033132330000000000000000000000000000000000000000000000000000000000010180";
        // 私钥
        String privateKey = "0x123";
        // ECDSA 加密套件
        CryptoSuite cryptoSuite = new CryptoSuite(CryptoType.ECDSA_TYPE);
        // 对待签名的编码值作哈运算
        String hashMessageStr = cryptoSuite.hash(encodedTransaction);
        System.out.println("hashMessageStr: " + hashMessageStr);
        // 创建私钥对
        CryptoKeyPair myKeyPair = cryptoSuite.createKeyPair(privateKey);
        // 对交易编码值签名
        SignatureResult signedTx = cryptoSuite.sign(hashMessageStr, myKeyPair);

        // 获得最终签名后的交易编码值
        byte[] signedTransaction = encoderService.encode(rawTransaction, signedTx);
        // 转十六进制字符串
        String signedTransactionStr = Numeric.toHexString(signedTransaction);
        System.out.println("signedTransactionStr: " + signedTransactionStr);
    }
```

#### 提交交易
有了已签名的交易编码值后，我们可以调用 `/trans/signed-transaction` 接口，将该交易发到链上，获得交易回执。这里我们继续使用 Swagger 调用该接口。

提交请求后，接口返回了交易的回执。可以根据交易回执判断交易是否执行成功。

当看到返回的交易回执中显示 status 为 0x0，也就意味着交易执行成功了。

### |交易编码接口源码解析
WeBASE-Front 源码中，位于 transaction 包里的 TransService 包含了对交易编码并签名的具体代码。

#### 获取交易编码值
我们找到 createRawTxEncoded() 方法，该方法通过合约函数的ABI，合约函数的函数名 funcName 和合约函数入参 funcParam 等参数构造了 Function 实例，并通过FunctionEncoder 将 Function 实例进行编码得到字符串 encodedFunction（代码中的 cryptoSuite 是国密或非国密的加密套件，可用于计算哈希、创建私钥对、签名等）。
```Java
// 构造Function实例
Function function = new Function(funcName, contractFunction.getFinalInputs(),
            contractFunction.getFinalOutputs());
// 编码Function
FunctionEncoder functionEncoder = new FunctionEncoder(cryptoSuite);
String encodedFunction = functionEncoder.encode(function);
```

下面使用 convertRawTx2Str() 方法，该方法主要负责构造 RawTransaction 交易体。

构造 RawTransaction 需要传入一个随机数和从节点获取当前的 BlockLimit 值(避免重复提交交易)、合约地址和上文获得的 encodedFunction 等参数。
```Java
// 构造交易体
BigInteger randomId = new BigInteger(250, new SecureRandom());
BigInteger blockLimit = web3j.getBlockLimit();
RawTransaction rawTransaction =
    RawTransaction.createTransaction(randomId, Constants.GAS_PRICE,
        Constants.GAS_LIMIT, blockLimit, contractAddress, BigInteger.ZERO, encodedFunction,
        new BigInteger(Constants.chainId), BigInteger.valueOf(groupId), "");
// 编码交易体RawTransaction
TransactionEncoderService encoderService = new TransactionEncoderService(cryptoSuite);
byte[] encodedTransaction = encoderService.encode(rawTransaction, null);
```

#### 对交易编码值签名
对交易编码值签名前，WeBASE-Front 中会根据传入的 user 字段和 isLocal 字段判断：

- 如果 user 字段为空，则将 encodedTransaction 转为十六进制后返回。该值就是第一阶段未签名的交易编码值。
- 如果 user 字段非空， isLocal 字段为 true，则 user 为 WeBASE-Front 本地的用户私钥，通过本地私钥对交易编码值 encodedTransaction 签名。注意，签名前还需对 encodedTransaction 进行一次哈希运算后再签名。
- 如果 user 字段非空， isLocal 字段为 false，则 user 为 WeBASE-Sign 托管私钥的signUserId，通过签名服务对交易体编码值 encodedTransaction 签名。注意，此处签名前没有对 encodedTransaction 进行哈希，而是直接转为十六进制发到签名服务，签名服务拿到该值后再做哈希运算并签名返回结果。

下面展示的代码为 isLocal 字段为 false，user 字段非空，其值为 signUserId 的交易编码值签名逻辑。

我们将交易编码值 encodedTransaction 转十六进制后，传到签名服务进行签名，得到了 String 格式的签名结果 signDataStr ，将签名结果反序列化，得到了签名结果 SignatureResult。同时，通过 TransactionEncoderService 将签名结果和上文构造的 RawTransaction 实例进行编码，最终可得到十六进制的已签名的交易编码值 signResultStr 。
```Java
// encodedTransaction转十六进制
String hashMessageStr = Numeric.toHexString(encodedTransaction);
// 通过WeBASE-Sign签名
EncodeInfo encodeInfo = new EncodeInfo(user, hashMessageStr);
String signDataStr = keyStoreService.getSignData(encodeInfo);
// 反序列化签名结果
SignatureResult signData = CommonUtils.stringToSignatureData(signDataStr, cryptoSuite.cryptoTypeConfig);
// 加入签名结果，再次编码
byte[] signedMessage = encoderService.encode(rawTransaction, userSignResult);
// 转为十六进制
String signResultStr = Numeric.toHexString(signedMessage);
```

至此，获取交易编码，对交易编码签名交易体，并对编码值签名的过程就完成了。

值得一提的是，提交交易后获得的交易哈希 TransHash 值是通过对签名交易体编码值进行哈希计算得到的，有了交易哈希，也可以在提交交易后，直接根据交易哈希到链上查询交易回执。
```Java
// 通过CryptoSuite实例计算signResultStr的交易哈希值
String transHash = cryptoSuite.hash(signResultStr);
```




