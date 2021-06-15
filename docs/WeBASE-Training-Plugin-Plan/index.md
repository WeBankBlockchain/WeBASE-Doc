# WeBASE实训插件方案

## 1 背景介绍

2020年7月6日，人社部联合国家市场监管总局、国家统计局向社会发布了第三批新职业名单，“区块链工程技术人员”赫然在列，越来越多的区块链从业者得到了国家层面的承认，对就业、创业的带动作用明显，彰显了区块链行业的巨大价值和就业前景。随着市场对人才的需求和要求迅速增长，区块链技术培训需求加快释放。如何将 WeBASE与区块链课程相结合，以更好的服务开发者？应对这一命题，WeBASE团队和FISCO BCOS 教育合作伙伴柏链教育对 WeBASE 功能进行针对性调整，推出WeBASE实训插件方案。

## 2 插件使用形态

WeBASE实训插件方案主要的目的是：将WeBASE管理台的部分功能作为插件嵌入到具体的实训系统中，辅助实训系统完成其区块链相关的一些实训功能。

​                 其嵌入的形式可以入下图：![](../../images/WeBASE-Training-Plugin-Plan/iframe2.png)

![](../../images/WeBASE-Training-Plugin-Plan/iframe1.png)

## 3 具体改造方案

1. 侧边栏默认收起
2. 陆页面获取参数配置，根据配置判断是否支持iframe嵌入，允许哪些域名嵌入
3. 满足iframe嵌入的条件下，如果是iframe嵌入，则自动登录
4. 自动登录的用户取消使用引导
5. 自动登录的用户隐藏修改密码功能（包括首次登陆、右上角修改密码入口）
6. 自动登录跳转到指定的router

## 4 使用方法和二次开发

### 4.1 安装 WeBASE 环境

使用到的子系统有WeBASE-Front、WeBASE-Node-Manager、WeBASE-Sign、 WeBASE-Web。WeBASE-Web使用dev-sx分支，WeBASE-Front、WeBASE-Node-Manager、WeBASE-Sign 使用v1.5.1及上版本。

###  4.2 WeBASE配置

#### 4.2.1 WeBASE-Node-Manager数据库中插入参数设置数据，脚本如下：

```plain
INSERT INTO `tb_config`(`config_name`, `config_type`, `config_value`, `create_time`, `modify_time`) VALUES ('SupportIframe', 2, '1', '2020-09-22 17:14:23', '2020-09-22 17:14:23');
INSERT INTO `tb_config`(`config_name`, `config_type`, `config_value`, `create_time`, `modify_time`) VALUES ('IframeSupportHostList', 3, 'baidu.com|163.com', '2020-09-22 17:14:23', '2020-09-22 17:14:23'); 
```

其中，SupportIframe设置为1，表示开启iframe嵌入支持；IframeSupportHostList为iframe嵌入支持的host白名单列表。

配置访问接口如下：

```
http://127.0.0.1:5001/WeBASE-Node-Manager/config/list?type=2
```



#### 4.2.2 WeBASE-Node-Manager配置

修改webase-node-manager/conf/application.yml。

- 修改constant.permitUrlArray：


```plain
permitUrlArray:/account/login,/account/pictureCheckCode,/login,/user/privateKey/**,/config/encrypt,/config/version,/front/refresh,/api/*,/config/list
```

- 修改constant.verificationCodeMaxAge，设置为与你的系统的session时间一致。
- 修改constant.enableVerificationCode=false，设置为false，用以固定验证constant.verificationCodeValue="8888"，为固定的验证码值，不需要修改
- 修改constant.developerModeEnable，设置为true，开启开发者模式。
- 重启WeBASE-Node-Manager服务。

这些配置主要的作用是：

1. 开发者模式主要是为了做学员间的合约和私钥隔离。
2. 固定校验码为了实现单点登录
3. permitUrlArray配置是为了放开接口访问权限

## 5 实验台中使用

### 5.1  iframe嵌入

在适当的位置使用iframe嵌入，嵌入时直接使用WeBASE-Node-Manager的login页面。
如：

```xml
<iframe
      ref="myFrame"
      src="http://localhost:3006/#/login"
      frameborder="0"
      width="100%"
      height="700"
></iframe>
```
### 5.2 自动登录

向子页面传递参数（router, user, password），实现自动登录。其中，用户的账号及密码，为WeBASE-Node-Manager平台已添加的账户信息，建议账户类型为开发者；router为指定跳转后定位到的页面

```plain
router清单：
/home    首页
/contract   合约IDE
/contractList   合约列表
/cnsManagement    CNS查询
/CRUDServiceManagement    CURD
/privateKeyManagement    私钥管理
```


vue向webase子页面传参示例：

```xml

<script>
export default {
  data() {
    return {};
  },
  created() {},
  mounted() {
    this.iframeInit();
  },
  computed: {},
  methods: {
    iframeInit() {
      let myFrame = this.$refs["myFrame"];
      if (myFrame.attachEvent) {
        //兼容浏览器判断
        myFrame.attachEvent("onload", function () {
          let iframeWin = myFrame.contentWindow;
          iframeWin.postMessage(
            { router: "/contract", user: "admin", password: "123456" },
            "*"
          );
          //data传递的参数   *写成子页面的域名或者是ip
        });
      } else {
        myFrame.onload = function () {
          let iframeWin = myFrame.contentWindow;
          iframeWin.postMessage(
            { router: "/contract", user: "admin", password: "123456" },
            "*"
          );
        };
      }
    },
  },
};
</script>
```

在适当的位置使用iframe嵌入 嵌入示例
```xml
<template>
        <div style="height:100%">
            
            <div>
                <div style="height:100%;width: 10%;float: left;background: #0B243B;">
                   <div style="width: 100%;float: left;border-bottom:1px">
                       <div style="padding-left: 35px;padding-top: 40px;">
                           <span style="font-size: 14px;color: #37eef2;">学生</span>
                       </div>
                   </div>
                   <div style="width: 100%;height:250px;float: left;">
                        <div style="padding-top: 50px;padding-left: 60px;">
                            <span style="font-size: 14px;color: #37eef2;text-align: left;">结束实验</span>
                       </div>
                        <div style="padding-top: 50px;padding-left: 60px;">
                            <span style="font-size: 14px;color: #37eef2;text-align: left;">下个实验</span>
                       </div>
                        <div style="padding-top: 50px;padding-left: 60px;">
                            <span style="font-size: 14px;color: #37eef2;text-align: left;">关闭页面</span>
                       </div>

                   </div>
                   <div style="width: 100%;height:250px;float: left;">
                       <div style="padding-top: 50px;padding-left: 5px;">
                            <span style="font-size: 14px;color: #9da2ab;text-align: left;">实验名称:
                                <span style="color: #37eef2;">
                                    智能合约编辑器2.0
                                </span>
                            </span>
                       </div>
                        <div style="padding-top: 50px;padding-left: 5px;">
                            <span style="font-size: 14px;color: #9da2ab;text-align: left;">实验时间:
                                 <span style="color: #37eef2;">
                                     1小时
                                </span>
                            </span>
                       </div>
                        <div style="padding-top: 50px;padding-left: 5px;">
                            <span style="font-size: 14px;color: #9da2ab;text-align: left;">倒计时:
                                <span style="color: #37eef2;">
                                      50分32秒
                                </span>
                            </span>
                       </div>

                   </div>
                   <div style="width: 100%;height:421px;float: left;">
                       <div style="padding-top: 50px;padding-left: 5px;">
                            <span style="font-size: 14px;color: #37eef2;text-align: left;">智能合约编辑器2.0</span>
                       </div>
                        <div style="padding-top: 50px;padding-left: 5px;">
                            <span style="font-size: 14px;color: #9da2ab;text-align: left;">测试实验1</span>
                       </div>
                   </div>
                </div>
                 <div style="float:left;width: 90%;height:100%;">
                       <iframe
                        ref="myFrame" 
                        src="http://127.0.0.1:3006/#/login"
                        frameborder="0"
                        width="100%"
                        height="980"
                    ></iframe>
                 </div>
                </div>
        </div>
</template>
<script>
    export default {
        data() {
            return {};
        },
        created() {},
        mounted() {
            this.iframeInit();
        },
        computed: {},
        methods: {
            iframeInit() {
            let myFrame = this.$refs["myFrame"];
            if (myFrame.attachEvent) {
                //兼容浏览器判断
                myFrame.attachEvent("onload", function () {
                let iframeWin = myFrame.contentWindow;
                iframeWin.postMessage(
                    { router: "/contract", user:localStorage.getItem("userName"), password: localStorage.getItem("passWord")},
                    "*"
                );
                //data传递的参数   *写成子页面的域名或者是ip
                });
            } else {
                myFrame.onload = function () {
                let iframeWin = myFrame.contentWindow;
                iframeWin.postMessage(
                    { router: "/contract", user: localStorage.getItem("userName"),password: localStorage.getItem("passWord")},
                    "*"
                );
                };
            }
            },
        },
    };
</script>
<style>
.main {
    width: 100%;
    min-width: 1200px; 
}
.el-message__content {
    display: inline-block;
}
.el-message__closeBtn {
    display: inline-block !important;
    vertical-align: middle !important;
    line-height: 0 !important;
}
.home-center {
    margin-right: 20px;
}
</style>

```

### 5.3 linux环境一键部署
1.下载安装包
```xml
wget https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/WeBASE/releases/download/v1.5.1sx/sx-deploy.zip

```

2. 解压包
```xml
unzip sx-deploy.zip
cd webase-front
```

3.修改common.properties文件
```xml
sx.web.version = v1.5.1sx
webase.web.version=v1.5.1sx
webase.mgr.version=v1.5.1sx
webase.sign.version=v1.5.1
webase.front.version=v1.5.1

# 节点管理子系统mysql数据库配置
mysql.ip=127.0.0.1
mysql.port=3306
mysql.user=dbUsername
mysql.password=dbPassword
mysql.database=webasenodemanager

# 签名服务子系统mysql数据库配置
sign.mysql.ip=localhost
sign.mysql.port=3306
sign.mysql.user=dbUsername
sign.mysql.password=dbPassword
sign.mysql.database=webasesign

# 节点前置子系统h2数据库名和所属机构
front.h2.name=webasefront
front.org=fisco

# sxWEB管理平台服务端口
sxweb.port=5110
# WeBASE管理平台服务端口
web.port=5000
# 节点管理子系统服务端口
mgr.port=5001
# 节点前置子系统端口
front.port=5002
# 签名服务子系统端口
sign.port=5004


# 节点监听Ip
node.listenIp=127.0.0.1
# 节点p2p端口
node.p2pPort=30300
# 节点链上链下端口
node.channelPort=20200
# 节点rpc端口
node.rpcPort=8545

# 加密类型 (0: ECDSA算法, 1: 国密算法)
encrypt.type=0
# SSL连接加密类型 (0: ECDSA SSL, 1: 国密SSL)
# 只有国密链才能使用国密SSL
encrypt.sslType=0

# 是否使用已有的链（yes/no）
if.exist.fisco=no

# 使用已有链时需配置
# 已有链的路径，start_all.sh脚本所在路径
# 路径下要存在sdk目录（sdk目录中包含了SSL所需的证书，即ca.crt、sdk.crt、sdk.key和gm目录（包含国密SSL证书，gmca.crt、gmsdk.crt、gmsdk.key、gmensdk.crt和gmensdk.key）
fisco.dir=/data/app/nodes/127.0.0.1
# 前置所连接节点的绝对路径
# 节点路径下要存在conf文件夹，conf里存放节点证书（ca.crt、node.crt和node.key）
node.dir=/data/app/nodes/127.0.0.1/node0

# 搭建新链时需配置
# FISCO-BCOS版本
fisco.version=2.7.2
# 搭建节点个数（默认两个）
node.counts=nodeCounts
```

4.部署并启动所有服务

```xml
   python3 deploy.py installAll
```

5.部署完成后可以看到deploy has completed的日志：
```xml
==============      Starting startSxWeb      ==============
=======  sx-web   start success! =======
============================================================
==============      deploy  has completed     ==============
============================================================
==============    webase-web version  v1.5.1sx        ========
==============    webase-web version  v1.5.1sx        ========
==============    webase-node-mgr version  v1.5.1sx   ========
==============    webase-sign version  v1.5.1       ========
==============    sx-web version  v1.5.1sx      ========
============================================================
  
```

6.启动和停止所有服务
```xml
	 python3 deploy.py startAll
	 python3 deploy.py stopAll
```

7. 访问
http://10.107.105.18:5110/sx/#/   用户名密码需要登录节点管理子系统添加



