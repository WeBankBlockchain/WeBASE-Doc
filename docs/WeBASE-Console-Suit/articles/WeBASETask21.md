# WeBASE task 21

# 关于WeBASE导出的java 脚手架项目如何实现动态设置发起合约方法的用户

注：脚手架默认走的SdkBeanConfig类中的用户client
```java
    @Bean//这里加了bean注解，合约服务中注入了这个用户
    public Client client() throws Exception {
        String certPaths = this.config.getCertPath();
        String[] possibilities = certPaths.split(",|;");
        for(String certPath: possibilities ){
            try{
                ConfigProperty property = new ConfigProperty();
                configNetwork(property);
                configCryptoMaterial(property,certPath);

                ConfigOption configOption = new ConfigOption(property);
                Client client = new BcosSDK(configOption).getClient(config.getGroupId());

                BigInteger blockNumber = client.getBlockNumber().getBlockNumber();
                log.info("Chain connect successful. Current block number {}", blockNumber);

                configCryptoKeyPair(client);
                log.info("is Gm:{}, address:{}", client.getCryptoSuite().cryptoTypeConfig == 1, client.getCryptoSuite().getCryptoKeyPair().getAddress());
                return client;
            }
            catch (Exception ex){
                log.error(ex.getMessage());
                try{
                    Thread.sleep(5000);
                }catch (Exception e){}
            }
        }
        throw new ConfigException("Failed to connect to peers:" + config.getPeers());
    }

```
解决思路：每次执行调用服务前重新设置一个新的用户就好了，但从合约服务中可以看到实际上真正到链上发起交易时用的应该是后面的密钥对，故每次调用服务调用合约方法时，用当前发起人的密钥队重新初始化txProcessors.
```java
  @Autowired
  private Client client;

  AssembleTransactionProcessor txProcessor;

  @PostConstruct
  public void init() throws Exception {
    //初始化交易发起者
    this.txProcessor = TransactionProcessorFactory.createAssembleTransactionProcessor(this.client, this.client.getCryptoSuite().getCryptoKeyPair());
  }
```
我的代码方案：
```java
 public void reloadAssembleTransactionProcessor(String hexPrivateKey){
    try {
       this.txProcessor = TransactionProcessorFactory.createAssembleTransactionProcessor(this.client, this.client.getCryptoSuite().createKeyPair(hexPrivateKey));
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  public TransactionResponse insert(MaterialCodeRelationshipStoreInsertInputBO input,String hexPrivateKey) throws Exception {
    if(!"".equals(hexPrivateKey)){
        //私钥不为空，重新初始化txProcessor
      this.reloadAssembleTransactionProcessor(hexPrivateKey);
    }
    return this.txProcessor.sendTransactionAndGetResponse(this.address, ABI, "insert", input.toArgs());
  }
```
