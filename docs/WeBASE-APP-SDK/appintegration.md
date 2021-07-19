# 接入说明

应用管理是WeBASE管理台提供的一种第三方应用接入功能。其他应用可以通过WeBASE通用API来开发自己的运维管理台。接入的步骤如下：

1. 通过WeBASE管理平台获得注册信息，并通过API向WeBASE注册服务。
2. 通过WeBASE提供的基础能力API和WeBASE连通。


## 应用集成SDK

### SDK简介
WeBASE-APP-SDK是应用集成SDK，提供调用WeBASE-Node-Manager的接口，方便WeBASE管理台接入第三方应用。
​	从`v1.5.1`开始，提供应用集成SDK，方便应用接入。接口API可以查看[WeBASE通用API](./api.html)。调用之前需要添加依赖和初始化应用信息。

- `v1.5.1`及其以上版本，应用配置AppConfig的属性`isTransferEncrypt`需和WeBASE-Node-Manager的配置文件`/conf/application.yml`下的配置`constant.isTransferEncrypt`相同，默认为`true`。
- 如果`v1.5.0`需要使用SDK，应用配置AppConfig的属性`isTransferEncrypt`需设置为`false`。`v1.5.1`及其以上版本新增的接口调用不了。

### 添加依赖

- 添加 SDK 的依赖，以Gradle为例

```java
repositories {
    maven { url "http://maven.aliyun.com/nexus/content/groups/public/" }
    maven { url "https://oss.sonatype.org/content/repositories/snapshots" }
}
dependencies {
    implementation 'com.webank:webase-app-sdk:1.5.1-SNAPSHOT'
    implementation 'org.bouncycastle:bcprov-jdk15on:1.67'
    implementation 'org.apache.commons:commons-lang3:3.8.1'
    implementation 'com.squareup.okhttp3:okhttp:4.8.1'
    implementation 'com.fasterxml.jackson.core:jackson-databind:2.11.0'
    implementation 'com.fasterxml.jackson.datatype:jackson-datatype-jdk8:2.11.0'
    implementation 'com.fasterxml.jackson.datatype:jackson-datatype-jsr310:2.11.0'
    implementation 'com.fasterxml.jackson.module:jackson-module-parameter-names:2.11.0'
    implementation 'org.projectlombok:lombok:1.18.12'
    implementation 'org.apache.logging.log4j:log4j-api:2.13.3'
    implementation 'org.apache.logging.log4j:log4j-core:2.13.3'
    implementation 'org.apache.logging.log4j:log4j-slf4j-impl:2.13.3'
}
```

### 配置说明

- 应用配置

```
public class AppConfig {
    // 节点管理服务地址
    private String nodeManagerUrl;
    // 应用Key
    private String appKey;
    // 应用密码
    private String appSecret;
    // 是否加密传输
    private boolean isTransferEncrypt;
}
```

- Http请求配置

```
public class HttpConfig {
	// 连接超时（默认30s）
    private int connectTimeout;
    // 读取超时（默认30s）
    private int readTimeout;
    // 写超时（默认30s）
    private int writeTimeout;
}
```

### 调用示例

完整示例请查看[SDK示例](https://github.com/WeBankFinTech/WeBASE-APP-SDK/blob/main/src/test/java/com/webank/webase/app/sdk/ClientTest.java)。

```java
public class ClientTest {

    // WeBASE-Node-Manager的url
    private static String url = "http://localhost:5001";
    private static String appKey = "RUPCNAsd";
    private static String appSecret = "65KiXNxUpPywVwQxM7SFsMHsKmCbpGrQ";
    private static boolean isTransferEncrypt = true;

    private static AppClient appClient = null;

    public static void main(String[] args) {
        try {
            initClient();
            appRegister();
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.exit(0);
    }

    public static void initClient() {
        // 未设置httpConfig时，默认http连接均为30s
        HttpConfig httpConfig = new HttpConfig(30, 30, 30);
        appClient = new AppClient(url, appKey, appSecret, isTransferEncrypt, httpConfig);
        System.out.println("testInitClient:" + JacksonUtil.objToString(appClient));
    }

    public static void appRegister() throws Exception {
        try {
            ReqAppRegister req = new ReqAppRegister();
            req.setAppIp("127.0.0.1");
            req.setAppPort(5001);
            req.setAppLink("https://127.0.0.1:5001/");
            appClient.appRegister(req);
            System.out.println("appRegister end.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```

## 签名
使用SDK时，SDK会自动填充。

### 签名说明

第三方应用从WeBASE管理平台获取注册信息**WeBASE的IP和端口、为应用分配的`appKey`（应用Key）和`appSecret`（应用密码，应用自己保存，不要暴露）**，向WeBASE发送请求时，需要使用应用分配的`appSecret`对请求进行签名。WeBASE收到请求后，根据`appKey`查询应用对应的`appSecret`，使用相同规则对请求进行签名验证。只有在验证通过后，WeBASE才会对请求进行相应的处理。

* 每个URL请求需带以下三个参数：

| 参数名    | 类型   | 描述                 | 参数值        | 备注                                          |
| --------- | ------ | -------------------- | ------------- | --------------------------------------------- |
| timestamp | long   | 请求的时间戳（毫秒） | 1614928857832 | 当前时间戳，有效期默认5分钟                   |
| appKey    | String | 应用Key              | fdsf78aW      | 从WeBASE管理平台获取                          |
| signature | String | 签名串               | 15B8F38...    | 从WeBASE管理平台获取appSecret对appKey做的签名 |

### 签名规则

使用MD5对`timestamp`、`appKey`加密并转大写得到签名值`signature`

```
public static String md5Encrypt(long timestamp, String appKey, String appSecret) {
        try {
            String dataStr = timestamp + appKey + appSecret;
            MessageDigest m = MessageDigest.getInstance("MD5");
            m.update(dataStr.getBytes("UTF8"));
            byte s[] = m.digest();
            String result = "";
            for (int i = 0; i < s.length; i++) {
                result += Integer.toHexString((0x000000FF & s[i]) | 0xFFFFFF00).substring(6);
            }
            return result.toUpperCase();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }
```

### 示例

* 参数值：

| 参数      | 参数值                             |
| --------- | ---------------------------------- |
| timestamp | `1614928857832`                    |
| appKey    | `fdsf78aW`                         |
| appSecret | `oMdarsqFOsSKThhvXagTpNdoOcIJxUwQ` |

* 签名后的 `signature` 为

```Bash
EEFD7CD030E6B311AA85B053A90E8A31
```