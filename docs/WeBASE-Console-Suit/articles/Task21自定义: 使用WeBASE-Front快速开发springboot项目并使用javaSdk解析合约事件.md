# 19, 使用WeBASE-Front快速开发springboot项目并使用javaSdk解析合约事件
作者: 深职院-符博<br>
本文内容: 使用WeBASE-Front快速开发springboot项目并使用javaSdk解析合约事件

----------------------------------------

# 使用说明
需提前在本地搭建一条4节点的FISCO-BCOS链 <br>官方文档教程: https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/installation.html<br>
需提前搭建好WeBASE-Front中间件 <br> 官方文档教程: https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/install.html

# 1, 做好上述准备后,在浏览器中访问 WeBASE-Front
![image](https://user-images.githubusercontent.com/103564714/163139344-af2beea2-31c8-45ef-8d92-1966b0240cc1.png)

# 2, 编写智能合约 本文采用最简单的hello-world进行教学 并定义了一个update事件 当我们调用set方法时会触发

```
pragma solidity ^0.5.2;

contract HelloWorld {
    string name;
    
    event update (
        string name
    );

    constructor() public {
        name = "Hello, World!";
    }

    function get() public view returns (string memory) {
        return name;
    }

    function set(string memory n) public {
        name = n;
        emit update(n);
    }
    
}
```

# 3，编译部署后点击导出java项目并输入channelPort，选择测试用户和要导出的合约
![image](https://user-images.githubusercontent.com/103564714/185935321-a43ac5b1-6239-430c-8abe-08ab71d08aa3.png)
![image](https://user-images.githubusercontent.com/103564714/185935538-a19efe57-02e6-44d8-b53e-a7ad1559ff38.png)


# 4, 导出解压后在idea打开项目, 项目依赖管理用的是gradle 我的gradle版本为6.1.1 jdk版本为11 依赖管理报错的同学可以参考一下我的版本
这里我简要的说明了一些基本的包和类的作用，记得将证书放到conf文件里
![image](https://user-images.githubusercontent.com/103564714/185937630-dcef7ac4-e2f3-4570-b22d-3e806d518bb6.png)
然后配置好我们的application
![image](https://user-images.githubusercontent.com/103564714/185939526-53146510-65f1-4b35-b669-e4d63af40302.png)




# 5, 然后我们就可以写个接口来测试啦
可以看到我们的service里已经封装好了两个方法 set方法的入参就为上面帮我们封装好的bo
![image](https://user-images.githubusercontent.com/103564714/185940930-cbf45886-6ba2-45fd-995f-151cc63c1aa0.png)

然后一会要用到的JSON解析依赖记得导入
![image](https://user-images.githubusercontent.com/103564714/185951011-0be07f63-e773-4451-8fa7-f46e6da1326e.png)

```
compile 'com.alibaba:fastjson:+'
```

ok 准备就绪后 下面就是我们的测试接口，相关的注释我已经写好啦

```
@RestController
@RequestMapping("/hello")
public class HelloWorldController {

    // 将我们的Service注入
    @Autowired
    private HelloWorldService service;


    // 写个测试接口 这里使用restful风格的接口

    @GetMapping("/test/{input}")
    public String test(@PathVariable String input) throws Exception {
        // 调用set方法

        // 入参封装
        HelloWorldSetInputBO helloWorldSetInputBO = new HelloWorldSetInputBO();

        // 利用提供的set方法设置我们的入参
        helloWorldSetInputBO.setN(input);

        // 调用
        TransactionResponse transactionResponse = service.set(helloWorldSetInputBO);
        // 这个api是返回是否成功的 成功则为Success 我们开发的时候也可以利用这个来判断
        String msg = transactionResponse.getReceiptMessages();

        if ("Success".equalsIgnoreCase(msg)) {
            // 如果调用成功则获取我们的事件 获取我们的事件

            // 解析的事件是这样的 {"update":[["xxx"]]} 是json字符串 (update为我们设置的事件名称，后者则为该事件的返回值)
            String events = transactionResponse.getEvents();

            // 所以我们想要拿到里面的值就需要进行解析
            JSONObject jsonObject = JSON.parseObject(events); // 先解析我们的json字符串
            String update = jsonObject.getString("update"); // 拿到我们的值 [["xxx"]]
            // 继续解析
            String jsonArr = JSON.parseArray(update).getString(0); // 拿到的值 [xxx]

            // 取值
            String setInput = JSON.parseArray(jsonArr).getString(0); // 最终获取到的值xxx 如果事件里有多个值我们只需根据数组下标去拿就ok
            System.out.println("合约set事件:更改的值为" + setInput);
            return "调用成功";
        }

        return "调用失败";


    }
}

```


# 6, 然后用postman测试一下
![image](https://user-images.githubusercontent.com/103564714/185951946-ea5a908e-4332-47ee-b8e8-6faa39bd6835.png)

然后看看我们的控制台，事件已经被成功解析。
![image](https://user-images.githubusercontent.com/103564714/185952162-c3d31ca3-5c26-4858-8deb-98703efc0798.png)




