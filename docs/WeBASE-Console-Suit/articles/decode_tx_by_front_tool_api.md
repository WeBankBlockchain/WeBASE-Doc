# 高旭亮 | 通过WeBASE-Front tool接口进行交易解析

作者：深职院高旭亮

本文会通过编写java程序来发送请求到WeBASE-Front的接口**tool/decode**来示范如何进行交易解析。

## WeBASE-Front简介

来自WeBASE-Front官网：

WeBASE-Front是和FISCO BCOS节点配合使用的一个子系统，需要和节点统计部署，目前支持FISCO BCOS  2.0以上版本，可通过HTTP请求和节点进行通信，集成了web3sdk(JAVA-SDK)，对接口进行了封装和抽象，具备可视化控制台，可以在控制台上查看交易和区块详情，开发智能合约，管理私钥，并对节点健康度进行监控和统计。

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
http://127.0.0.1:5002/WeBASE-Front/tool/decode
```

## 通过JAVA调用tool/decode接口

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

### 示例代码

通过WeBASE-Front的tool/decode接口进行交易解析，建议先了解WeBASE-Front官方文档的接口描述

注意：

- 代码中testDecodeInput()是解析调用合约setName方法时候的input，解析结果为调用时候传入的参数hello
- 代码中testDecodeOutput()是解析调用合约getName方法时候的output

```java
public class TestDecode {
    // WeBASE-Front接口地址，该接口用于执行交易
    private static final String URL = "http://127.0.0.1:5002/WeBASE-Front/tool/decode";
    // 合约ABI接口信息，为json格式
    private static final String CONTRACT_ABI = "[{\"constant\":false,\"inputs\":[],\"name\":\"getName\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"name\",\"type\":\"string\"}],\"name\":\"setName\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"}]";

    public static void main(String[] args) {
        testDecodeInput();
        testDecodeOutput();
    }

    /**
     * 调用tool/decode接口解析input参数
     */
    private static void testDecodeInput() {
        // 新建一个对象用于承载数据，来自fastjson依赖，底层为Map，
        JSONObject jsonObj = new JSONObject();
        // 此处ABI原为json格式，因为JSONObject对象要序列化为json格式，避免重复序列化所以先将ABI转为java对象
        jsonObj.put("abiList", JSONArray.parseArray(CONTRACT_ABI));
        // 指定调用合约时候的方法
        jsonObj.put("methodName", "setName");
        // decodeType为1表示解析input输入的参数，为2表示解析output输出的参数
        jsonObj.put("decodeType", 1);
        // 当decodeType为1，需要传入input，此处使用编码后的"hello"字符串
        jsonObj.put("input", "0xc47f00270000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000568656c6c6f000000000000000000000000000000000000000000000000000000");
        // 此处返回了json格式的数据，调用结束
        String responseStr = httpPost(URL, jsonObj.toJSONString());
        // 响应字符串hello，成功解码
        System.out.println(responseStr);
    }

    /**
     * 调用tool/decode接口解析output参数
     */
    private static void testDecodeOutput() {
        // 新建一个对象用于承载数据，来自fastjson依赖，底层为Map，
        JSONObject jsonObj = new JSONObject();
        // 此处ABI原为json格式，因为JSONObject对象要序列化为json格式，避免重复序列化所以先将ABI转为java对象
        jsonObj.put("abiList", JSONArray.parseArray(CONTRACT_ABI));
        // 指定调用合约时候的方法
        jsonObj.put("methodName", "getName");
        // decodeType为1表示解析input输入的参数，为2表示解析output输出的参数
        jsonObj.put("decodeType", 2);
        // 当decodeType为2，需要传入output
        jsonObj.put("output", "0x0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000568656c6c6f000000000000000000000000000000000000000000000000000000");
        //此处返回了json格式的数据，调用结束
        String responseStr = httpPost(URL, jsonObj.toJSONString());
        // 成功解码
        /*
        {
          "[hello]": [
            {
              "name": "",
              "type": "VALUE",
              "valueType": "STRING",
              "numericValue": null,
              "bytesValue": null,
              "bytesLength": 0,
              "addressValue": null,
              "boolValue": null,
              "dynamicBytesValue": null,
              "stringValue": {
                "value": "hello",
                "typeAsString": "string"
              },
              "listType": null,
              "listValues": null,
              "listLength": 0,
              "listValueType": null,
              "structFields": null,
              "dynamic": true
            }
          ]
        }
         */
        System.out.println(responseStr);
    }


    /**
     * 发送 post 请求
     *
     * @param url     请求地址
     * @param jsonStr 准备放入请求体的json字符串
     * @return 请求结果
     */
    private static String httpPost(String url, String jsonStr) {
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
