# 区块链教程 | 通过WeBASE-Front接口进行合约调用

作者：高旭亮

本文会通过编写java程序来发送请求到WeBASE-Front的接口**trans/handle**来示范如何进行合约调用。

## WeBASE-Front简介

来自WeBASE-Front官网：

WeBASE-Front是和FISCO BCOS节点配合使用的一个子系统，需要和节点统计部署，目前支持FISCO BCOS  2.0以上版本，可通过HTTP请求和节点进行通信，集成了web3sdk(java-sdk)，对接口进行了封装和抽象，具备可视化控制台，可以在控制台上查看交易和区块详情，开发智能合约，管理私钥，并对节点健康度进行监控和统计。

## 前期准备

- 搭建一条FiscoBcos区块链

- 编写HelloWorld合约：

- ```solidity
  pragma solidity ^0.4.4;
  contract HelloWorld {
      string  my_name = "Mike";
      
      function getName() public returns (string){
          return my_name;
      }
      
      function setName(string name) public{
          my_name = name;
      }
  }
  ```

  

- 搭建WeBASE-Front平台（详见官方文档https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front）

  通过访问https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/interface.html 获取详细的接口文档描述。

```
http://127.0.0.1:5002/WeBASE-Front/trans/handle
```

## 通过java调用trans/handle接口

新建一个空maven项目

### 导入maven依赖

```
<dependency>
    <groupId>com.alibaba</groupId>
    <artifactId>fastjson</artifactId>
    <version>1.2.79</version>
</dependency>

<dependency>
    <groupId>org.apache.httpcomponents</groupId>
    <artifactId>httpclient</artifactId>
    <version>4.5.3</version>
</dependency>
```

### 完整代码

通过WeBASE-Front的trans/handle接口进行合约调用，建议先了解WeBASE-Front官方文档的接口描述

```java
public class Handler {
    // WeBASE-Front接口地址，该接口用于执行交易
    private static final String URL = "http://127.0.0.1:5002/WeBASE-Front/trans/handle";
    // 合约名称
    private static final String CONTRACT_NAME = "HelloWorld";
    // 合约地址（在WeBASE-Front中部署或者控制台中部署时产生的地址）
    private static final String CONTRACT_ADDRESS = "0x71688af04b9eb59bfbf61a451798f22501d1d4ef";
    // 合约ABI接口信息，为json格式
    private static final String CONTRACT_ABI = "[{\"constant\":false,\"inputs\":[],\"name\":\"getName\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"name\",\"type\":\"string\"}],\"name\":\"setName\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"}]";
    // 用户私钥地址，需要在WeBASE-Front中创建用户后获取对应地址
    private static final String USER_ADDRESS = "0x3cc88bc73a739f5e9c23ce096b0ff311613cee96";


    // 主方法，从此执行
    public static void main(String[] args) {
        // 传入的参数要求以数组形式
        Object[] params = {"Danis"};
        // 新建一个对象用于承载数据，来自fastjson依赖，底层为Map，
        JSONObject jsonObj = new JSONObject();
        jsonObj.put("contractName",CONTRACT_NAME);
        // 要调用的合约地址
        jsonObj.put("contractAddress",CONTRACT_ADDRESS);
        // 此处ABI原为json格式，因为JSONObject对象要序列化为json格式，避免重复序列化所以先将ABI转为java对象
        jsonObj.put("contractAbi", JSONArray.parseArray(CONTRACT_ABI));
        // 指定发送该次请求的私钥
        jsonObj.put("user",USER_ADDRESS);
        // 指定要调用的合约的方法名
        jsonObj.put("funcName", "setName");
        // 传入对应合约方法需要的参数
        jsonObj.put("funcParam",params);

        // 发起请求调用合约setName方法，此处返回了json格式的数据，调用结束
        String responseStr = httpPost(URL, jsonObj.toJSONString());
        // 以下为trans/handle接口的响应
        //{"transactionHash":"0x6b7e72502cb57e96c4c6d07582dd63649ae649e2a918d4b54ec833adcfbf9f0d",
        // "transactionIndex":"0x0",
        // "root":"0x0000000000000000000000000000000000000000000000000000000000000000",
        // "blockNumber":"2",
        // "blockHash":"0x8634210113be8db5d0e2f8927fb9e7a1269cb83286435f8c14052d3af3d66487",
        // "from":"0x3cc88bc73a739f5e9c23ce096b0ff311613cee96",
        // "to":"0x71688af04b9eb59bfbf61a451798f22501d1d4ef",
        // "gasUsed":"22430",
        // "contractAddress":"0x0000000000000000000000000000000000000000",
        // "logs":[],
        // "logsBloom":"0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
        // "status":"0x0",
        // "statusMsg":"None",
        // "input":"0xc47f00270000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000544616e6973000000000000000000000000000000000000000000000000000000",
        // "output":"0x","txProof":null,"receiptProof":null,"message":"Success","statusOK":true}
        System.out.println(responseStr);
    }

    /**
     * 发送 post 请求
     * @param url 请求地址
     * @param jsonStr 准备放入请求体的json字符串
     * @return 请求结果
     */
    public static String httpPost(String url, String jsonStr){
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
}
```
