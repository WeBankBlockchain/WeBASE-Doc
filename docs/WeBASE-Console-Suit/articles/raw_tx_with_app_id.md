# 深职院 张宇豪 | SDK构造RawTransaction交易传入AppId

> 作者： 张宇豪
> 学校： 深圳职业技术学院

## 1、案例准备

- 双节点的FISCO BCOS链
- 合约部署WeBASE-Front

这里的合约和Java项目的案例使用官方文档的开发第一个区块链：

https://fisco-bcos-documentation.readthedocs.io/zh_CN/release-2.8.0/docs/tutorial/sdk_application.html

基于Table合约的Assert合约。如下是我部署到WeBASE-Front中的Assert合约，然后导出Java项目即可。

![image-20230515163339857](https://blog-1304715799.cos.ap-nanjing.myqcloud.com/imgs/202305151633824.webp)

如下是我的项目整体的结构：

![image-20230515163725860](https://blog-1304715799.cos.ap-nanjing.myqcloud.com/imgs/202305151637101.webp)



## 2、RawTransaction构造交易分析

这里我不使用sdk中写好的api方法进行传参以及调用，用自己手动构造`RawTransaction`的方式发送简易的交易请求。

首先需要留意的是如下的三个对象，分别是

- TransactionProcessor对象
- AssembleTransactionProcessor对象
- TransactionPusherService对象

![image-20230515164840913](https://blog-1304715799.cos.ap-nanjing.myqcloud.com/imgs/202305151648083.webp)

如果使用的是如下方式调用合约发送交易：

`sendTransactionAndGetResponse`这个方法首先会将abi、functionName、params进行ABI编码，因为`AssembleTransactionProcessor`继承了`TransactionProcessor`这个类,所以需要将编码的数据在生产带有签名的交易中构造RawTransaction的时候传入参数。包括AppId也是传入这里的`extraData`中。

```java
        AssembleTransactionProcessor transactionProcessor = TransactionProcessorFactory
                .createAssembleTransactionProcessor(this.client, cryptoKeyPair, "abi/", "");
        
        return transactionProcessor
                .sendTransactionAndGetResponse("xxxx",this.address,funcName,params);
```

![image-20230515170740589](https://blog-1304715799.cos.ap-nanjing.myqcloud.com/imgs/202305151707877.webp)

在`sendTransactionAndGetResponse`这个方法调用了`createSignedTransaction`生产签名的交易之后，再调用了`TransactionPusherService`的`push`推送到fisco bcos的节点就可以接收交易收据。所以等会需要用到两个重要的对象，分别是：`TransactionPusherService`和`RawTransaction`。

![image-20230515173020375](https://blog-1304715799.cos.ap-nanjing.myqcloud.com/imgs/202305151730601.webp)

其中，`appId` 是应用的标识符，`appIdBytes` 是将字符串转成 byte[] 格式的 AppId，`hexAppId` 是将 `appIdBytes` 转成十六进制字符串格式的 AppId。在创建 RawTransaction 时，将 `hexAppId` 作为 extraData 的值传入即可。



## 3、详细的Java代码

```java
@Slf4j
public class AssetRawTransaction  {
    // 读取连接节点的配置文件
    private static final ApplicationContext applicationContext = new ClassPathXmlApplicationContext("classpath:applicationContext.xml");
    // 合约的ABI
    private static final String ABI = "xxxxxxx";

    public static void main(String[] args) throws Exception {
        // 通过拿取Bean获得一个BcosSDK的对象
        BcosSDK bcosSDK = applicationContext.getBean(BcosSDK.class);
        // 获取群组1的客户端
        Client client = bcosSDK.getClient(1);
        CryptoKeyPair cryptoKeyPair = client.getCryptoSuite().getCryptoKeyPair();
        // 创建transactionEncoder
        TransactionEncoderService transactionEncoderService = new TransactionEncoderService(client.getCryptoSuite());
        // 创建transactionBuilder
        TransactionBuilderService transactionBuilderService = new TransactionBuilderService(client);
        // 获取groupId 和 chainId
        Pair<String, Integer> chainIdAndGroupId = TransactionProcessorFactory.getChainIdAndGroupId(client);
        // 创建ABICodec对象
        ABICodec abiCodec = new ABICodec(client.getCryptoSuite());
        // 传入的参数
        ArrayList<Object> params = new ArrayList<>();
        params.add("Bob");
        params.add(1000);
        // 应用的APPID
        String appId = "0x6ffec8d032fd7f88cf6e2922768cbc478b818838";
        byte[] appIdBytes = appId.getBytes(StandardCharsets.UTF_8);
        String hexString = Numeric.toHexString(appIdBytes);
        log.info("当前的AppID：{}",appIdBytes);
        System.out.println("当前传入交易的AppID：" + appId);
        // 对ABI functionName params 进行编码
        String data = abiCodec.encodeMethod(ABI, "register", params);

        // 构造交易函数
        RawTransaction rawTransaction =
                transactionBuilderService.createTransaction(
                        DefaultGasProvider.GAS_PRICE,
                        DefaultGasProvider.GAS_LIMIT,
                        "0xf8054f47062a2ed2fef820cd40c94d1d058e55d6",   // 合约地址
                        data,
                        BigInteger.ZERO,
                        new BigInteger(chainIdAndGroupId.getLeft()),
                        BigInteger.valueOf(chainIdAndGroupId.getRight()),
                        hexString       // AppID
                );
        String signedTransaction = transactionEncoderService.encodeAndSign(rawTransaction, cryptoKeyPair);
        // 创建TransactionPusherService对象 推送交易接收收据
        TransactionPusherInterface pusher = new TransactionPusherService(client);
        TransactionReceipt transactionReceipt = pusher.push(signedTransaction);

        // 查看交易的AppID
        String extraData = client.getTransactionByHash(transactionReceipt.getTransactionHash()).getResult().getExtraData();
        byte[] extraAppId = Numeric.hexStringToByteArray(extraData);
        System.out.println("查看交易的AppID:" + new String(extraAppId, StandardCharsets.UTF_8));
    }
}
```

测试当前的主函数，能正确的得到当前extraData中传入app_id的参数。

![image-20230515192837156](https://blog-1304715799.cos.ap-nanjing.myqcloud.com/imgs/202305151928487.webp)
