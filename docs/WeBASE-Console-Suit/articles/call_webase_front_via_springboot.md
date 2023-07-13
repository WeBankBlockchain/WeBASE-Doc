# 符博|通过SpringBoot调用WeBASE-Front接口发送交易
作者: 深职院-符博<br>
本文内容: 通过WeBASE-Front中间件部署合约 并调用其自带接口WeBASE-Front/trans/handle发送交易<br>
温馨提示: 本文调用WeBASE-Front交易接口运用的技术栈是springboot,需要有springboot的基础~

---------------------------------------
# Fisco-Bcos简介: <br>
FISCO BCOS是由国内企业主导研发、对外开源、安全可控的企业级金融联盟链底层平台，由金链盟开源工作组协作打造，并于2017年正式对外开源。
社区以开源链接多方，截止2020年5月，汇聚了超1000家企业及机构、逾万名社区成员参与共建共治，发展成为最大最活跃的国产开源联盟链生态圈。底层平台可用性经广泛应用实践检验，数百个应用项目基于FISCO BCOS底层平台研发，超80个已在生产环境中稳定运行，覆盖文化版权、司法服务、政务服务、物联网、金融、智慧社区等领域。<br>
官方网址：https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/introduction.html

# WeBASE简介: <br>
WeBASE（WeBank Blockchain Application Software Extension） 是在区块链应用和FISCO-BCOS节点之间搭建的一套通用组件。围绕交易、合约、密钥管理，数据，可视化管理来设计各个模块，开发者可以根据业务所需，选择子系统进行部署。WeBASE屏蔽了区块链底层的复杂度，降低开发者的门槛，大幅提高区块链应用的开发效率，包含节点前置、节点管理、交易链路，数据导出，Web管理平台等子系统。<br>
官方网址: https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE/introduction.html

# WeBASE-Front简介: <br>
WeBASE-Front是和FISCO-BCOS节点配合使用的一个子系统。此分支支持FISCO-BCOS 2.0以上版本，集成web3sdk，对接口进行了封装，可通过HTTP请求和节点进行通信。另外，具备可视化控制台，可以在控制台上开发智能合约，部署合约和发送交易，并查看交易和区块详情。还可以管理私钥，对节点健康度进行监控和统计。<br>
官方网址: https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/README.html

# 使用说明
需提前在本地搭建一条4节点的FISCO-BCOS链 <br>官方文档教程: https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/installation.html<br>
需提前搭建好WeBASE-Front中间件 <br> 官方文档教程: https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/install.html


# 1, 做好上述准备后,在浏览器中访问 WeBASE-Front
![image](https://user-images.githubusercontent.com/103564714/163139344-af2beea2-31c8-45ef-8d92-1966b0240cc1.png)

# 2, 编写智能合约，本文将用简单的领养宠物合约作为案例
```
pragma solidity ^0.4.24;

contract Adoption {

  uint8 userIndex;
  
  mapping(address => uint8) userMapping;

  // 保存领养者的地址
  address[8] public adopters;  
  
  constructor() public {
      userIndex = 0;
  }
  
  //用户注册
  function register(address user) public returns(uint8) {
      userIndex++;
      userMapping[user] = userIndex;
      return userIndex;
  }
  
  //判断用户是否可以登录（>0）
  function login(address user) public view returns(uint8) {
      return userMapping[user];
  }

    // 领养宠物
  function adopt(uint petId) public returns (uint) {
    // 确保id在数组长度内
    require(petId >= 0 && petId <= 7);  
    
    uint userNotExist = 404;
    if (userMapping[msg.sender] == 0) {
        return userNotExist;
    }
    // 保存调用这地址 
    adopters[petId] = msg.sender;        
    return petId;
  }

  // 返回领养者
  function getAdopters() public view returns (address[8]) {
    return adopters;
  }

}
```

# 3, 保存编译部署合约成功后 会生成合约地址,合约名称，合约ABI等，在后续都将会用到(部署合约前，需在测试用户中创建用户)
![image](https://user-images.githubusercontent.com/103564714/163151209-f4375aae-8d10-4061-9000-bfef53be56be.png)

# 4, 在windows端打开IDEA并创建一个新的springboot项目 在pom.xml中导入hutool工具包
![image](https://user-images.githubusercontent.com/103564714/163153688-b2cd45b0-808c-446e-932a-489aa5067fee.png)
```
  <dependency>
      <groupId>cn.hutool</groupId>
      <artifactId>hutool-all</artifactId>
      <version>5.8.0.M2</version>
  </dependency>
```
hutool官方文档: https://www.hutool.cn/
# 5, 在写后端接口前，先熟悉一下调用WeBASE-Front自带接口WeBASE-Front/trans/handle发送交易时所需的参数要求
![image](https://user-images.githubusercontent.com/103564714/163154396-8a02cdd3-b0d9-4982-85e3-5254c8db72af.png)
![image](https://user-images.githubusercontent.com/103564714/163154417-610a982d-4353-4b9b-bad4-c57263f0fd84.png)<br>
官方文档说明: https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/interface.html#id392

# 6, 根据合约内容去写后端调用的逻辑(这里只简单的测试两个登录和注册的功能)
```
package com.example;

import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.util.List;


@RestController
@RequestMapping("/pet")
public class controller {

    // 调用WeBASE-Front中间件交易接口 在windows做测试 192.168.239.133为ubuntu虚拟机的ip地址
    private static final String URL = "http://192.168.239.133:5002/WeBASE-Front/trans/handle";

    // 合约名称
    private static final String CONTRACT_NAME = "Adoption";

    // 合约地址
    private static final String CONTRACT_ADDRESS = "0x3deadcfbe5ee16e2f93532536cccc64eb8c3af94";

    // 合约ABI
    private static final String CONTRACT_ABI = "[{\"constant\":true,\"inputs\":[{\"name\":\"user\",\"type\":\"address\"}],\"name\":\"login\",\"outputs\":[{\"name\":\"\",\"type\":\"uint8\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"getAdopters\",\"outputs\":[{\"name\":\"\",\"type\":\"address[8]\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"name\":\"adopters\",\"outputs\":[{\"name\":\"\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"user\",\"type\":\"address\"}],\"name\":\"register\",\"outputs\":[{\"name\":\"\",\"type\":\"uint8\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"petId\",\"type\":\"uint256\"}],\"name\":\"adopt\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"}]";


    // 用户地址(本文因合约登陆注册方法传入的就是用户地址 所以这里可以选择不设置常量)
    // private static final String TEST_USER = "0x5851739e2fed4ea87db565eaea63549c78a070df";

    // RestTemplate 是从 Spring3.0 开始支持的一个 HTTP 请求工具，
    // 它提供了常见的REST请求方案的模版，例如 GET 请求、POST 请求、PUT 请求、DELETE
    // 本文用他来发送请求
    RestTemplate restTemplate = new RestTemplate();



    // 注册
    @PostMapping("/register")
    public String Register(@RequestParam String address) throws IOException {
        // _JsonOutPut 返回给前端的内容
        JSONObject _jsonOutPut = new JSONObject();

        // 调用WeBASE-Front中间件交易接口需传入的参数为json格式
        JSONObject _jsonObj = new JSONObject();

        // param为合约方法需要传入的参数, 此方法为Login登录 传入的是一个用户地址 官方要求格式为:JSON数组，多个参数以逗号分隔
        // 此操作就是将入参address转为JSON数组类型
        List param = new ObjectMapper().readValue("[" + "\"" + address + "\"" + "]",List.class);

        // 合约名称
        _jsonObj.putOpt("contractName",CONTRACT_NAME);
        // 合约地址
        _jsonObj.putOpt("contractAddress",CONTRACT_ADDRESS);
        // 合约ABI 官方要求格式为:JSONArray
        _jsonObj.putOpt("contractAbi", JSONUtil.parseArray(CONTRACT_ABI));
        // 用户地址 此方法直接调用入参address为用户地址
        _jsonObj.putOpt("user",address);
        // 方法名称 对应合约 “login”
        _jsonObj.putOpt("funcName","register");
        // 方法参数
        _jsonObj.putOpt("funcParam",param);

        // 用restTemplate.postForEntity调用其接口 URL为路径,_jsonObj为调用WeBASE-Front中间件交易接口需传入的参数,String.class为返回值类型
        ResponseEntity<String> stringResponseEntity = restTemplate.postForEntity(URL, _jsonObj, String.class);

        // 获取返回值的body
        String body = stringResponseEntity.getBody();
        // 将body转为Json数组格式
        JSONObject responseJson = JSONUtil.parseObj(body);
        // 获取返回值中的message的值 key-value的形式获取
        String msg = responseJson.getStr("message");
        // 判断逻辑 如果为Success则注册成功
        if (msg.equals("Success")){
            // 注册成功返回给前端的值
            _jsonOutPut.putOpt("ret",1);
            _jsonOutPut.putOpt("msg",msg);
        }else {
            // 注册失败 返回给前端的值
            _jsonOutPut.putOpt("ret",0);
            _jsonOutPut.putOpt("msg",msg);
        }
        return _jsonOutPut.toString();
    }


    // 登录
    @PostMapping("/login")
    public String Login(@RequestParam String address) throws IOException {
        // _JsonOutPut 返回给前端的内容
        JSONObject _jsonOutPut = new JSONObject();

        // 调用WeBASE-Front中间件交易接口需传入的参数为json格式
        JSONObject _jsonObj = new JSONObject();

        // param为合约方法需要传入的参数, 此方法为Login登录 传入的是一个用户地址 官方要求格式为:JSON数组，多个参数以逗号分隔
        // 此操作就是将入参address转为JSON数组类型
        JSONArray param = new ObjectMapper().readValue("[" + "\"" + address + "\"" + "]", JSONArray.class);

        // 合约名称
        _jsonObj.putOpt("contractName",CONTRACT_NAME);
        // 合约地址
        _jsonObj.putOpt("contractAddress",CONTRACT_ADDRESS);
        // 合约ABI 官方要求格式为:JSONArray
        _jsonObj.putOpt("contractAbi", JSONUtil.parseArray(CONTRACT_ABI));
        // 用户地址 此方法直接调用入参address为用户地址
        _jsonObj.putOpt("user",address);
        // 方法名称 对应合约 “login”
        _jsonObj.putOpt("funcName","login");
        // 方法参数
        _jsonObj.putOpt("funcParam",param);

        // 用restTemplate.postForEntity调用其接口 URL为路径,_jsonObj为调用WeBASE-Front中间件交易接口需传入的参数,String.class为返回值类型
        ResponseEntity<String> stringResponseEntity = restTemplate.postForEntity(URL, _jsonObj, String.class);
        // 获取返回值的body
        String body = stringResponseEntity.getBody();
        // 将返回值转为List类型方便获取
        List list = new ObjectMapper().readValue(body,List.class);
        // 获取返回值
        String result = list.get(0).toString();

        // 合约登录逻辑判断 如果返回值为0 则登录失败
        if (result.equals("0")){
            // _jsonOutPut 登陆失败返回给前端的内容
            _jsonOutPut.putOpt("ret",0);
            _jsonOutPut.putOpt("msg",false);
        }else {
            // _jsonOutPut 登陆成功返回给前端的内容
            _jsonOutPut.putOpt("ret",1);
            _jsonOutPut.putOpt("msg",true);
        }
        return _jsonOutPut.toString();
    }

}

```

# 7, 使用postman进行测试
![image](https://user-images.githubusercontent.com/103564714/163156930-ef9e062c-8535-4484-b9dd-ae46906c0293.png)
![image](https://user-images.githubusercontent.com/103564714/163156949-560fd029-8a78-48b3-b20e-ecc4e1901c99.png)

# 8, 查看WeBASE-Front区块高度和交易记录会发现都有所新增
![image](https://user-images.githubusercontent.com/103564714/163157058-1138fed9-5728-4411-99ed-0353dac429ec.png)











