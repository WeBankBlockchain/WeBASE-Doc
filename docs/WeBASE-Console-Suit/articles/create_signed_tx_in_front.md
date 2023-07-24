# 易海博 | 通过WeBASE-Front接口生成已签名交易并发送交易

作者：易海博

## 简介

本示例通过调用WeBASE-Front接口**/trans/convertRawTxStr/local**来生成已签名交易，通过JAVA-SDK的Client来发送已签名交易。

FISCO BCOS官方文档：https://fisco-bcos-documentation.readthedocs.io

WeBASE官方文档：https://webasedoc.readthedocs.io/zh_CN/latest/docs

注：以下示例中是以调用**/trans/convertRawTxStr/local**时有传入用户参数进行签名然后发送已签名交易为例的，如果未指定用户则生成的交易是未签名的，不可直接通过Client的sendRawTransactionAndGetReceipt方法直接发送交易。

## 环境准备

- 搭建FISCO BCOS区块链并且搭建WeBASE-Front平台

- 使用solidity编写HelloWorld合约并且部署：

- ```solidity
  contract HelloWorld {
      string  my_name = "name";
      
      function getName() public returns (string){
          return my_name;
      }
      
      function setName(string name) public{
          my_name = name;
      }
  }
  ```

  

## 调用WeBASE-Front接口创建已签名交易并发送交易

- 需要JAVA环境
- 需要MAVEN环境
- 需要使用FISCO BCOS的JAVA-SDK

### 新建JAVA项目导入MAVEN依赖

```xml
<!--    用于json格式化    -->
<dependency>
    <groupId>com.alibaba</groupId>
    <artifactId>fastjson</artifactId>
    <version>1.2.79</version>
</dependency>
<!--    用于发送http请求    -->
<dependency>
    <groupId>org.apache.httpcomponents</groupId>
    <artifactId>httpclient</artifactId>
    <version>4.5.3</version>
</dependency>
```

### 示例代码

注：实际开发中使用java框架springboot与WeBASE-Front进行交互时可以不使用httpclient依赖来发送请求，springboot自身封装了一个RestTemplate类用于发送请求，使用更便捷。

```java
    
	// 调用WeBASE-Front接口/trans/convertRawTxStr/local来生成已签名交易
	private static final String CREATERAWTX = "http://127.0.0.1:5002/WeBASE-Front/trans/convertRawTxStr/local";
    // 合约ABI接口信息
    private static final String CONTRACT_ABI = "[{\"constant\":false,\"inputs\":[],\"name\":\"getName\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"name\",\"type\":\"string\"}],\"name\":\"setName\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"}]";

    public static void main(){
        // 创建JAVA-SDK客户端详见官网https://fisco-bcos-documentation.readthedocs.io
        String path = Demo.class.getClassLoader().getResource("config.toml").getPath();
        System.out.println(path);
        BcosSDK sdk = BcosSDK.build(path);
        Client client = sdk.getClient(1);
        Client client = applicationContext.getBean("client", Client.class);
        // 调用WeBASE-Front的trans/convertRawTxStr/local接口创建一个已签名交易（本地签名）
        String rawTx = createRawTx();
        // 通过JAVA-SDK客户端，传入已签名交易发起交易并获取交易回执
        TransactionReceipt transactionReceipt = client.sendRawTransactionAndGetReceipt(rawTx);
        System.out.println(transactionReceipt);
    }

    /**
     * 调用WeBASE-Front的trans/convertRawTxStr/local接口创建一个已签名交易（本地签名）
     *
     * @return 响应已签名的交易体编码值（十六进制字符串）
     */
    private static String createRawTx() {
        // 传入的参数要求以数组形式
        Object[] params = {"new_name"};
        // 新建一个对象用于承载数据，来自fastjson依赖，底层为Map，
        JSONObject jsonObj = new JSONObject();
        // 调用的合约名
        jsonObj.put("contractName", "HelloWorld");
        // 要调用的合约地址
        jsonObj.put("contractAddress", "0x30c4afab6d671b12b4ef00f9662a77d064603cc3");
        // 此处ABI原为json格式，因为JSONObject对象要序列化为json格式，避免重复序列化所以先将ABI转为java对象
        jsonObj.put("contractAbi", JSONArray.parseArray(CONTRACT_ABI));
        // 指定用户进行签名，如果为空，则生成未签名交易
        jsonObj.put("user", "0x3cc88bc73a739f5e9c23ce096b0ff311613cee96");
        // 指定要调用的合约的方法名
        jsonObj.put("funcName", "setName");
        // 传入对应合约方法需要的参数
        jsonObj.put("funcParam", params);
        // 传入群组id
        jsonObj.put("groupId", 1);
        // 不使用CNS版本方式调用合约，如果为true，还需增加额外参数指定版本。详见官方文档接口描述
        jsonObj.put("useCns", false);

        // 发起请求获取已签名交易体
        String responseStr = sendPost(CREATERAWTX, jsonObj.toJSONString());
        System.out.println(responseStr);
        return responseStr;
    }


    /**
     * 发送 post 请求
     *
     * @param url     请求地址
     * @param jsonStr 请求体中的json字符串
     * @return 响应结果
     */
    private static String sendPost(String url, String jsonStr) {
        // 创建httpClient
        CloseableHttpClient httpClient = HttpClients.createDefault();
        // 创建post请求方式实例
        HttpPost httpPost = new HttpPost(url);
        // 设置请求头 发送的是json数据格式
        httpPost.setHeader("Content-type", "application/json;charset=utf-8");
        // 设置参数---设置消息实体 也就是携带的数据
        StringEntity entity = new StringEntity(jsonStr, Charset.forName("UTF-8"));
        // 设置编码格式
        entity.setContentEncoding("UTF-8");
        // 发送Json格式的数据请求
        entity.setContentType("application/json");
        // 把请求消息实体塞进去
        httpPost.setEntity(entity);
        // 执行http的post请求
        CloseableHttpResponse httpResponse;
        String result = null;
        try {
            httpResponse = httpClient.execute(httpPost);
            result = EntityUtils.toString(httpResponse.getEntity(), "UTF-8");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }


```

