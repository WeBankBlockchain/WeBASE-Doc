# 19, 结合WeBASE-Front的订阅消息队列功能，监听合约中的Event推送
作者: 深职院-符博<br>
本文内容: 通过在在springboot项目中通过RabbitMQ结合WeBASE-Front的订阅消息队列功能，监听合约中的事件推送

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

# 3，在我们的webase-front上可以看到订阅事件所需要的参数，这里需要交换机和消息队列 我们选择使用RabbitMQ
![image](https://user-images.githubusercontent.com/103564714/185745841-e417abba-783d-4268-8568-850ad7c8380f.png)


# 4, 利用docker容器 运行RabbitMQ
在线拉取
```
docker pull rabbitmq:3-management
```

启动 这里的密码账号密码可以自己设置 5672是rabbitMQ的端口 15672是rabbitMQ提供的看板中间件 方便我们查看整体状态的
```
docker run \
 -e RABBITMQ_DEFAULT_USER=itcast \
 -e RABBITMQ_DEFAULT_PASS=123321 \
 --name mq \
 --hostname mq1 \
 -p 15672:15672 \
 -p 5672:5672 \
 -d \
 rabbitmq:3-management
```

# 5, 然后我们可以随意创建个springboot项目进行测试
创建好后导入rabbitMQ的依赖
```
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-amqp</artifactId>
</dependency>
```
并配置yml文件

![image](https://user-images.githubusercontent.com/103564714/185747057-b74c8021-ad92-43c4-af00-697de8d29a65.png)

Webase-front已经帮我们引入了依赖,同理webase-front也需要配置yml文件 在webase-front dist/conf目录下的application.yml文件
![image](https://user-images.githubusercontent.com/103564714/185747096-e846ceb8-d1c1-4ad4-b156-7f4d84410d24.png)
然后已启动的记得重启一下webase-front 使配置生效



# 6, 然后就开始写我们的java代码了，配置我们的交换机和消息队列
这里是写了一个配置类 然后定义了交换机和消息队列 将他们绑定在了一起
![image](https://user-images.githubusercontent.com/103564714/185746557-5c990ad2-7924-46bf-8203-03aab91e234f.png)

```
// 声明FanoutExchange交换机
    @Bean
    public FanoutExchange fanoutExchange() {
        return new FanoutExchange("webase.fanout");
    }

    // 声明第一个队列
    @Bean
    public Queue fanoutQueue1() {
        return new Queue("webase.queue1");
    }

    // 绑定队列1和交换机
    @Bean
    public Binding bindingQueue1(Queue fanoutQueue1, FanoutExchange fanoutExchange) {
        return BindingBuilder.bind(fanoutQueue1).to(fanoutExchange);
    }
```

定义好后再写一个监听类
![image](https://user-images.githubusercontent.com/103564714/185746613-2e6d2863-047f-4468-87cd-c23317270533.png)

```
    @RabbitListener(queues = "webase.queue1")
    public void listenSimpleQueueMessage3(String msg) throws InterruptedException {
        System.err.println("webase" + msg);
    }
```

# 7，然后就可以启动我们的springboot项目，在浏览器输入你虚拟机的地址:15672 访问rabbitMQ的看板
输入刚刚启动时设置的密码
![image](https://user-images.githubusercontent.com/103564714/185746768-1f699b4d-1799-4c45-a15d-0b3a8e1389fb.png)

可以查看到刚刚在java中定义的消息队列和交换机
![image](https://user-images.githubusercontent.com/103564714/185747014-1109757a-7a50-48ad-a6e5-db442536b669.png)
![image](https://user-images.githubusercontent.com/103564714/185747024-06df3770-9c98-493f-b790-65877656eb08.png)

# 8, 配置webase-front订阅合约事件
然后我们就可以在webase-front上订阅事件了
![image](https://user-images.githubusercontent.com/103564714/185747161-fb3523f4-84d8-4066-957b-3bd6e59c8730.png)

# 9，调用helloworld set方法测试 
![image](https://user-images.githubusercontent.com/103564714/185747260-d5280b35-9a17-4279-a8ac-6a44a6a7059b.png)

成功接收到webase-front发来的消息
![image](https://user-images.githubusercontent.com/103564714/185747255-34bc9260-e9a1-4a51-aa37-2afd86249779.png)




