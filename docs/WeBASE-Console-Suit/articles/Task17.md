# 结合 WebASE-Front 接口发起一笔交易

> 作者：梁永豪
>
> 本文会通过 WebASE 技术讲解如何结合 WebASE-Front 接口发起一笔交易（创建合约、创建私钥后发起交易）

首先：要有 java 环境，版本建议：Oracle JDK 8 至 14、git

#### 搭建 4 个节点的区块链网络

[官方文档教程](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/installation.html)

#### 搭建 WeBASE-Font（也可以一键部署 [WeBASE 管理平台](https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE/install.html)）

[官方文档教程](https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/install.html)

1. 拉取代码
   执行命令：

```bash
git clone https://gitee.com/WeBank/WeBASE-Front.git
```

进入目录：

```bash
cd WeBASE-Front
```

2. 编译代码
   使用以下方式编译构建，如果出现问题可以查看 常见问题解答 ：

方式一：如果服务器已安装 Gradle，且版本为 gradle-4.10 至 gradle-6.x 版本

```bash
gradle build -x test
```

方式二：如果服务器未安装 Gradle，或者版本不是 gradle-4.10 至 gradle-6.x 版本，可使用 gradlew 编译

```bash
chmod +x ./gradlew && ./gradlew build -x test
```

构建完成后，会在根目录 WeBASE-Front 下生成已编译的代码目录 dist。

3. 修改配置

（1）进入 dist 目录

```bash
cd dist
```

dist 目录提供了一份配置模板 conf_template：

根据配置模板生成一份实际配置 conf。初次部署可直接拷贝。
例如：`cp -r conf_template conf`

（2）进入 conf 目录：

```bash
cd conf
```

**注意**： 将节点所在目录 nodes/${ip}/sdk 下的所有文件拷贝到当前 conf 目录，供 SDK 与节点建立连接时使用（SDK 会自动判断是否为国密，且是否使用国密 SSL）

- 链的 sdk 目录包含了 ca.crt, sdk.crt, sdk.key 和 gm 文件夹，gm 文件夹包含了国密 SSL 所需的证书
- 拷贝命令可使用 cp -r nodes/${ip}/sdk/\* ./conf/
- _注_，只有在建链时手动指定了-G(大写)时节点才会使用国密 SSL

（3）修改配置（根据实际情况修改）：

如果在企业部署中使用 WeBASE-Front，必须配置下文中的 keyServer，用于连接 WeBASE-Sign 服务

```bash
vi application.yml
```

```yml
spring:
  datasource:
    url: jdbc:h2:file:./h2/webasefront;DB_CLOSE_ON_EXIT=FALSE // 默认H2库为webasefront，建议修改数据库存放路径
...
server:
  port: 5003                    // 服务端口
  context-path: /WeBASE-Front
sdk:
  ...
  ip: 127.0.0.1                 // 连接节点的监听ip
  channelPort: 20200            // 连接节点的链上链下端口
  certPath: conf                // sdk证书的目录，默认为conf
constant:
  keyServer: 127.0.0.1:5004     // 密钥服务的IP和端口(WeBASE-Node-Manager服务或者WeBASE-Sign服务，不同服务支持的接口不同)，如果作为独立控制台使用可以不配置
  aesKey: EfdsW23D23d3df43          // aes加密key(16位) 如启用，各互联的子系统的加密key需保持一致
  transMaxWait: 30              // 交易最大等待时间
  monitorDisk: /                // 要监控的磁盘目录，配置节点所在目录（如：/data）
  monitorEnabled: true          // 是否监控数据，默认true
  nodePath: /fisco/nodes/127.0.0.1/node0      //配置所连节点的绝对路径，用于监控节点配置与日志
...
```

4. 服务启停
   返回到 dist 目录执行：

```bash
#启动:
bash start.sh
#停止:
bash stop.sh
#检查:
bash status.sh
```

5. 访问控制台
   示例：http://localhost:5002/WeBASE-Front

6. 使用 solidity 编写 HelloWorld 合约：

```sol
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

7. HelloWorld 合约 abi

```json
[
  {
    "constant": false,
    "inputs": [{ "name": "n", "type": "string" }],
    "name": "set",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "get",
    "outputs": [{ "name": "", "type": "string" }],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "constructor"
  }
]
```

8. HelloWorld 合约 bin

```json
608060405234801561001057600080fd5b506040805190810160405280600d81526020017f48656c6c6f2c20576f726c6421000000000000000000000000000000000000008152506000908051906020019061005c929190610062565b50610107565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106100a357805160ff19168380011785556100d1565b828001600101855582156100d1579182015b828111156100d05782518255916020019190600101906100b5565b5b5090506100de91906100e2565b5090565b61010491905b808211156101005760008160009055506001016100e8565b5090565b90565b6102d7806101166000396000f30060806040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff1680634ed3885e146100515780636d4ce63c146100ba575b600080fd5b34801561005d57600080fd5b506100b8600480360381019080803590602001908201803590602001908080601f016020809104026020016040519081016040528093929190818152602001838380828437820191505050505050919291929050505061014a565b005b3480156100c657600080fd5b506100cf610164565b6040518080602001828103825283818151815260200191508051906020019080838360005b8381101561010f5780820151818401526020810190506100f4565b50505050905090810190601f16801561013c5780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b8060009080519060200190610160929190610206565b5050565b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156101fc5780601f106101d1576101008083540402835291602001916101fc565b820191906000526020600020905b8154815290600101906020018083116101df57829003601f168201915b5050505050905090565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061024757805160ff1916838001178555610275565b82800160010185558215610275579182015b82811115610274578251825591602001919060010190610259565b5b5090506102829190610286565b5090565b6102a891905b808211156102a457600081600090555060010161028c565b5090565b905600a165627a7a72305820aa8d37bec7b8a85e32740629893aa0bd0894e6eadefe527bc854f28f9493d1fd0029
```

9. 将 HelloWorld 合约编译成 java 文件

```java
package com;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import org.fisco.bcos.sdk.abi.FunctionReturnDecoder;
import org.fisco.bcos.sdk.abi.TypeReference;
import org.fisco.bcos.sdk.abi.datatypes.Function;
import org.fisco.bcos.sdk.abi.datatypes.Type;
import org.fisco.bcos.sdk.abi.datatypes.Utf8String;
import org.fisco.bcos.sdk.abi.datatypes.generated.tuples.generated.Tuple1;
import org.fisco.bcos.sdk.client.Client;
import org.fisco.bcos.sdk.contract.Contract;
import org.fisco.bcos.sdk.crypto.CryptoSuite;
import org.fisco.bcos.sdk.crypto.keypair.CryptoKeyPair;
import org.fisco.bcos.sdk.model.CryptoType;
import org.fisco.bcos.sdk.model.TransactionReceipt;
import org.fisco.bcos.sdk.model.callback.TransactionCallback;
import org.fisco.bcos.sdk.transaction.model.exception.ContractException;

@SuppressWarnings("unchecked")
public class HelloWorld extends Contract {
    public static final String[] BINARY_ARRAY = {"608060405234801561001057600080fd5b506040805190810160405280600d81526020017f48656c6c6f2c20576f726c6421000000000000000000000000000000000000008152506000908051906020019061005c929190610062565b50610107565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106100a357805160ff19168380011785556100d1565b828001600101855582156100d1579182015b828111156100d05782518255916020019190600101906100b5565b5b5090506100de91906100e2565b5090565b61010491905b808211156101005760008160009055506001016100e8565b5090565b90565b6102d7806101166000396000f30060806040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff1680634ed3885e146100515780636d4ce63c146100ba575b600080fd5b34801561005d57600080fd5b506100b8600480360381019080803590602001908201803590602001908080601f016020809104026020016040519081016040528093929190818152602001838380828437820191505050505050919291929050505061014a565b005b3480156100c657600080fd5b506100cf610164565b6040518080602001828103825283818151815260200191508051906020019080838360005b8381101561010f5780820151818401526020810190506100f4565b50505050905090810190601f16801561013c5780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b8060009080519060200190610160929190610206565b5050565b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156101fc5780601f106101d1576101008083540402835291602001916101fc565b820191906000526020600020905b8154815290600101906020018083116101df57829003601f168201915b5050505050905090565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061024757805160ff1916838001178555610275565b82800160010185558215610275579182015b82811115610274578251825591602001919060010190610259565b5b5090506102829190610286565b5090565b6102a891905b808211156102a457600081600090555060010161028c565b5090565b905600a165627a7a72305820aa8d37bec7b8a85e32740629893aa0bd0894e6eadefe527bc854f28f9493d1fd0029"};

    public static final String BINARY = org.fisco.bcos.sdk.utils.StringUtils.joinAll("", BINARY_ARRAY);

    public static final String[] SM_BINARY_ARRAY = {"608060405234801561001057600080fd5b506040805190810160405280600d81526020017f48656c6c6f2c20576f726c6421000000000000000000000000000000000000008152506000908051906020019061005c929190610062565b50610107565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106100a357805160ff19168380011785556100d1565b828001600101855582156100d1579182015b828111156100d05782518255916020019190600101906100b5565b5b5090506100de91906100e2565b5090565b61010491905b808211156101005760008160009055506001016100e8565b5090565b90565b6102d7806101166000396000f30060806040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063299f7f9d146100515780633590b49f146100e1575b600080fd5b34801561005d57600080fd5b5061006661014a565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100a657808201518184015260208101905061008b565b50505050905090810190601f1680156100d35780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156100ed57600080fd5b50610148600480360381019080803590602001908201803590602001908080601f01602080910402602001604051908101604052809392919081815260200183838082843782019150505050505091929192905050506101ec565b005b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156101e25780601f106101b7576101008083540402835291602001916101e2565b820191906000526020600020905b8154815290600101906020018083116101c557829003601f168201915b5050505050905090565b8060009080519060200190610202929190610206565b5050565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061024757805160ff1916838001178555610275565b82800160010185558215610275579182015b82811115610274578251825591602001919060010190610259565b5b5090506102829190610286565b5090565b6102a891905b808211156102a457600081600090555060010161028c565b5090565b905600a165627a7a723058200213820e973bd6ced2ea2b697ad80e27402d270ed95e854e77a8d247f96537c50029"};

    public static final String SM_BINARY = org.fisco.bcos.sdk.utils.StringUtils.joinAll("", SM_BINARY_ARRAY);

    public static final String[] ABI_ARRAY = {"[{\"constant\":false,\"inputs\":[{\"name\":\"n\",\"type\":\"string\"}],\"name\":\"set\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"get\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"}]"};

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

    public byte[] set(String n, TransactionCallback callback) {
        final Function function = new Function(
                FUNC_SET,
                Arrays.<Type>asList(new org.fisco.bcos.sdk.abi.datatypes.Utf8String(n)),
                Collections.<TypeReference<?>>emptyList());
        return asyncExecuteTransaction(function, callback);
    }

    public String getSignedTransactionForSet(String n) {
        final Function function = new Function(
                FUNC_SET,
                Arrays.<Type>asList(new org.fisco.bcos.sdk.abi.datatypes.Utf8String(n)),
                Collections.<TypeReference<?>>emptyList());
        return createSignedTransaction(function);
    }

    public Tuple1<String> getSetInput(TransactionReceipt transactionReceipt) {
        String data = transactionReceipt.getInput().substring(10);
        final Function function = new Function(FUNC_SET,
                Arrays.<Type>asList(),
                Arrays.<TypeReference<?>>asList(new TypeReference<Utf8String>() {}));
        List<Type> results = FunctionReturnDecoder.decode(data, function.getOutputParameters());
        return new Tuple1<String>(

                (String) results.get(0).getValue()
                );
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

    public static HelloWorld deploy(Client client, CryptoKeyPair credential) throws ContractException {
        return deploy(HelloWorld.class, client, credential, getBinary(client.getCryptoSuite()), "");
    }
}

```

#### 创建项目并结合 WeBASE-Font 实现合约部署 (本地签名)

> - 需要 JAVA 环境
> - 需要 MAVEN 环境
> - 需要使用 FISCO BCOS 的 JAVA-SDK

1. 创建 SpringBoot 项目

2. 添加 MAVEN 依赖

```xml
 <!-- hutool工具类-->
<dependency>
   <groupId>cn.hutool</groupId>
   <artifactId>hutool-all</artifactId>
   <version>5.3.3</version>
</dependency>
 <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
<!--    用于json格式化    -->
<dependency>
    <groupId>com.alibaba</groupId>
    <artifactId>fastjson</artifactId>
    <version>1.2.79</version>
</dependency>

<!-- fisco-jdk -->
<dependency>
    <groupId>org.fisco-bcos.java-sdk</groupId>
    <artifactId>fisco-bcos-java-sdk</artifactId>
    <version>2.8.0</version>
</dependwncy>

<!--    用于发送http请求    -->
<dependency>
    <groupId>org.apache.httpcomponents</groupId>
    <artifactId>httpclient</artifactId>
    <version>4.5.3</version>
</dependency>
```

3. 在 springboot 项目的 src/main/resources 下新建 fisco-config.xml

具体可观看[javaSDK配置文件](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/sdk/java_sdk/configuration.html#xml)

```xml
<?xml version="1.0" encoding="UTF-8" ?>

<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
    http://www.springframework.org/schema/beans/spring-beans-4.0.xsd">
    <bean id="defaultConfigProperty" class="org.fisco.bcos.sdk.config.model.ConfigProperty">
        <property name="cryptoMaterial">
            <map>
                <entry key="certPath" value="conf" />
            </map>
        </property>
        <property name="network">
            <map>
                <entry key="peers">
                    <list>
                        <value>127.0.0.1:20200</value>
                        <value>127.0.0.1:20201</value>
                    </list>
                </entry>
            </map>
        </property>
        <property name="account">
            <map>
                <entry key="keyStoreDir" value="account" />
                <entry key="accountAddress" value="" />
                <entry key="accountFileFormat" value="pem" />
                <entry key="password" value="" />
                <entry key="accountFilePath" value="" />
            </map>
        </property>
        <property name="threadPool">
            <map>
                <entry key="channelProcessorThreadSize" value="16" />
                <entry key="receiptProcessorThreadSize" value="16" />
                <entry key="maxBlockingQueueSize" value="102400" />
            </map>
        </property>
    </bean>

    <bean id="defaultConfigOption" class="org.fisco.bcos.sdk.config.ConfigOption">
        <constructor-arg name="configProperty">
            <ref bean="defaultConfigProperty"/>
        </constructor-arg>
    </bean>

    <bean id="bcosSDK" class="org.fisco.bcos.sdk.BcosSDK">
        <constructor-arg name="configOption">
            <ref bean="defaultConfigOption"/>
        </constructor-arg>
    </bean>
</beans>
```

4. 在 springboot 项目的 src/main/resources 下新建 contract.properties 主要存储合约地址所用

#### 实例代码

[合约部署接口 (本地签名) ](https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/interface.html#id12)

[创建私钥接口](https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/interface.html#id105)

```java
package com.blockchain.controller;

import cn.hutool.json.JSONUtil;
import com.alibaba.fastjson.JSONObject;
import com.blockchain.controller.blockchainResource.HelloWorld;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.fisco.bcos.sdk.BcosSDK;
import org.fisco.bcos.sdk.client.Client;
import org.fisco.bcos.sdk.crypto.keypair.CryptoKeyPair;
import org.fisco.bcos.sdk.model.TransactionReceipt;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Properties;

/**
 * @author 鲤鱼乡
 * date 2022年05月17日下午 7:33
 * info Task
 */
@RestController
@RequestMapping("task")
public class Task {
    // 调用WeBASE-Front接口/contract/deploy 来实现合约部署
    private static final String deployUrl = "http://localhost:5002/WeBASE-Front/contract/deploy";

    // 合约ABI接口信息
    private static final String deploy_abi = "[{ \"constant\": false, \"inputs\": " +
            "[{ \"name\": \"n\", \"type\": \"string\" }],\"name\": \"set\", \"outputs\": []," +
            "\"payable\": false, \"stateMutability\": \"nonpayable\", \"type\": \"function\" }," +
            "{ \"constant\": true, \"inputs\": [],\"name\": \"get\", \"outputs\": [{ \"name\": \"\", \"type\": \"string\" }]," +
            "\"payable\": false, \"stateMutability\": \"view\", \"type\": \"function\" }," +
            "{ \"inputs\": [],\"payable\": false, \"stateMutability\": \"nonpayable\", \"type\": \"constructor\" }]";

    // 合约bin接口信息
    private static final String deploy_bin = "608060405234801561001057600080fd5b506040805" +
            "190810160405280600d81526020017f48656c6c6f2c20576f726c64210000000000" +
            "00000000000000000000000000008152506000908051906020019061005c9291906100" +
            "62565b50610107565b82805460018160011615610100020316600290049060005260206000" +
            "2090601f016020900481019282601f106100a357805160ff19168380011785556100d1565" +
            "b828001600101855582156100d1579182015b828111156100d0578251825591602001919060" +
            "0101906100b5565b5b5090506100de91906100e2565b5090565b61010491905b80821115610100" +
            "5760008160009055506001016100e8565b5090565b90565b6102d7806101166000396000f30060" +
            "806040526004361061004c576000357c0100000000000000000000000000000000000000000000" +
            "000000000000900463ffffffff1680634ed3885e146100515780636d4ce63c146100ba575b60" +
            "0080fd5b34801561005d57600080fd5b506100b8600480360381019080803590602001908201" +
            "803590602001908080601f01602080910402602001604051908101604052809392919081815260200" +
            "1838380828437820191505050505050919291929050505061014a565b005b3480156100c657600080fd5b" +
            "506100cf610164565b6040518080602001828103825283818151815260200191508051906020019080838360005b8381101" +
            "561010f5780820151818401526020810190506100f4565b50505050905090810190601f16801561013c57808" +
            "20380516001836020036101000a031916815260200191505b509250505060405180910390f35b806000908051906020" +
            "0190610160929190610206565b5050565b606060008054600181600116156101000203166002900480601f016020809104026" +
            "0200160405190810160405280929190818152602001828054600181600116156101000203166002900480156101fc5780601f106101d" +
            "1576101008083540402835291602001916101fc565b820191906000526020600020905b815481529060010190602001808311" +
            "6101df57829003601f168201915b5050505050905090565b828054600181600116156101000203166002900" +
            "490600052602060002090601f016020900481019282601f1061024757805160ff1916838001178555610" +
            "275565b82800160010185558215610275579182015b828111156102745782518255916020019190600101" +
            "90610259565b5b5090506102829190610286565b5090565b6102a891905b808211156102a457600081600" +
            "090555060010161028c565b5090565b905600a165627a7a72305820aa8d37bec7b8a85e32740629893aa0bd08" +
            "94e6eadefe527bc854f28f9493d1fd0029";


    private Client client;
    private CryptoKeyPair cryptoKeyPair;
    private HelloWorld helloWorld;

    /**
     * 发送 post 请求
     *
     * @param url     请求地址
     * @param jsonStr 请求体中的json字符串
     * @return 返回合约地址
     */
    private static String sendPost(String url, String jsonStr) {
        // 创建httpClient
        CloseableHttpClient httpClient = HttpClients.createDefault();
        // 创建post请求方式实例
        HttpPost httpPost = new HttpPost(url);
        // 设置请求头 发送的是json数据格式
        httpPost.setHeader("Content-type", "application/json;charset=utf-8");
        // 设置参数---设置消息实体 也就是携带的数据
        StringEntity entity = new StringEntity(jsonStr, StandardCharsets.UTF_8);
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

    private static String contractDeployment(String userAddress) {
        // 新建一个对象用于承载数据，来自fastjson依赖，底层为Map，
        JSONObject jsonObj = new JSONObject();
        // 调用的所属群组
        jsonObj.put("groupId", 1);
        // 要调用的用户地址
        jsonObj.put("user", userAddress);
        // 要调用的合约名称
        jsonObj.put("contractName", "HelloWorld");
        // 此处ABI原为json格式，因为JSONObject对象要序列化为json格式，避免重复序列化所以先将ABI转为java对象
        jsonObj.put("abiInfo", JSONUtil.parseArray(deploy_abi));
        // 要调用的合约bin
        jsonObj.put("bytecodeBin", deploy_bin);

        // 发起请求获取已签名交易体
        String responseStr = sendPost(deployUrl, jsonObj.toJSONString());
        return responseStr;
    }


    public void init() throws Exception {
        //初始化合约
        @SuppressWarnings("resource")
        ApplicationContext context =
                new ClassPathXmlApplicationContext("classpath:fisco-config.xml");
        BcosSDK bcosSDK = context.getBean(BcosSDK.class);
        client = bcosSDK.getClient(1);
        cryptoKeyPair = client.getCryptoSuite().createKeyPair();
        client.getCryptoSuite().setCryptoKeyPair(cryptoKeyPair);
    }

    @GetMapping("deploy")
    public void deployAssetAndRecordAddr(String userAddress) {
        /**
         * 说明
         * userAddress 为前端通过 'http://localhost:5002/WeBASE-Front/privateKey?type=0&userName=test' 创建私钥的接口
         * 获取到的该用户的地址
         */
        //部署合约获取到合约地址
        try {
            String contractAddress = contractDeployment(userAddress);
            //获取到的合约地址传给函数--recordAssetAddr
            recordAssetAddr(contractAddress);
        } catch (Exception e) {
            System.out.println(" deploy Asset contract failed, error message is  " + e.getMessage());
        }
    }

    /**
     * info 保存地址
     *
     * @param address
     * @author 鲤鱼乡
     * date 2022-05-17 下午 8:56
     */
    public void recordAssetAddr(String address) throws IOException {
        //将合约地址存储到文件中
        Properties prop = new Properties();
        prop.setProperty("address", address);
        final Resource contractResource = new ClassPathResource("contract.properties");
        FileOutputStream fileOutputStream = new FileOutputStream(contractResource.getFile());
        prop.store(fileOutputStream, "contract address");
    }

    /**
     * info 获取地址
     *
     * @return java.lang.String
     * @author 鲤鱼乡
     * date 2022-05-17 下午 8:56
     */
    public String loadAssetAddr() throws Exception {
        //加载Asset合约从 contract.properties 获取地址返回
        Properties prop = new Properties();
        final Resource contractResource = new ClassPathResource("contract.properties");
        prop.load(contractResource.getInputStream());
        String contractAddress = prop.getProperty("address");
        if (contractAddress == null || contractAddress.trim().equals("")) {
            throw new Exception(" load Asset contract address failed, please deploy it first. ");
        }
        return contractAddress;
    }

    // 调用HelloWorld合约的set接口
    @GetMapping("/set")
    public String setHelloWorld(@RequestParam(value = "val", required = false, defaultValue = "default val") String val) throws Exception {
        try {
            String contractAddress = loadAssetAddr();
            helloWorld = HelloWorld.load(contractAddress, client, cryptoKeyPair);
            // 调用HelloWorld合约的set接口
            TransactionReceipt receipt = helloWorld.set(val);
            System.out.println("-----call HelloWorld get success------:" + receipt.getMessage());
            return "setHelloWorld success";
        } catch (Exception e) {
            return (" query asset account failed, error message is %s\n" + e.getMessage());
        }
    }
}

```