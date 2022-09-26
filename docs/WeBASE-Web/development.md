# WeBASE管理平台开发文档

本代码仅支持FISCO-BCOS 3.0以上版本，支持群组和群组切换。


## 1、开发环境搭建

### 1.1 依赖环境

| 环境     | 版本              |
| ------   | ---------------  |
| nodejs   | 1.8及以上         |

nodejs下载地址：https://nodejs.org/en/download/

### 1.2 安装依赖包

#### 1.2.1 拉取代码

> 执行命令：

```shell
git clone -b master-3.0 https://github.com/WeBankBlockchain/WeBASE-Web.git

# 若网络问题导致长时间无法下载，可尝试以下命令
git clone -b master-3.0 https://gitee.com/WeBank/WeBASE-Web.git
```

将代码放在你的工作目录，例如：D：\project

> 切换到项目目录：

    cd D:\project\WeBASE-Web

> 使用命令：

    npm install

下载依赖包

> 执行update修改依赖和下载相关文件：

```
npm run update
```
*注意：必须执行update，否则编译打包都是失败，此脚本会修改部分依赖文件并且从cdn下载solc的编译文件，执行成功后，后面无需再执行。*



### 1.3 启动项目

> 在项目根目录使用命令：

    npm run dev

> 控制台出现：

    Listening at http ://localhost:3006

> 在浏览器输入"http ://127.0.0.1:3006"。

> 默认端口是3006，可在config文件夹index.js中修改。

> 修改跨域配置，在config文件夹index.js中，在dev中的proxyTable修改，修改地址即可,请求的url路径必须加上前缀。

    dev: {
            host: 'localhost', // can be overwritten by process.env.HOST
            port: 3006, // can be overwritten by process.env.PORT, if port is in use, a free one will be determined
            autoOpenBrowser: false,
            errorOverlay: true,
            notifyOnErrors: true,
            poll: false, // https://webpack.js.org/configuration/dev-server/#devserver-watchoptions-
            assetsSubDirectory: 'static',
            assetsPublicPath: '/',
            proxyTable: {
            '/mgr':{
                target:'http://10.0.0.1:8080/',  //在此修改跨域地址，这里是node_mgr服务ip和端口，且可以访问
                changeOrigin:true,
                pathRewrite:{
                    '^/mgr':''
                    }
                },
            },
        },

*本地启动服务用127.0.0.1代替localhost，因为部分合约版本使用了web worker*

### 1.4  修改solidity版本

solidity版本默认0.4.25,如果需要修改请按以下步骤修改：

> 获取所需solidity版本的编译文件；
    自行编译或者[点击此处](https://github.com/ethereum/solc-bin)下载，将其移动到路径/static/js下面，并删除之前的solidity编译文件。

> 修改solc依赖版本；
    找到package.json的dependencies部分的solc，将其版本修改成和上面下载的solidity编译文件一致，执行命令

        npm install

> 修改引入solidity编译文件名称
    在路径 /src/views/chaincode/code   找到引入文件的位置，修改为下载solidity编译文件名称。
    在生命周期beforeMount时引入改文件，修改这里就可以了

        beforeMount() {
        var head = document.head;
        var script = document.createElement("script");
        script.src = "./static/js/soljson-v0.4.25+commit.59dbf8f1.js";
        script.setAttribute('id', 'soljson');
        if (!document.getElementById('soljson')) {
            head.append(script)
        }
    },

> 修改完后，即可进行打包或本地开发测试。


### 1.5 模拟数据

模拟数据在mock.js中，在开发联调前使用，使用中注意mock.js的url和axios请求的url要保持一致。`包括get拼接在url上面的参数`

注意：开发时将mian.js中加上mock.js引用，打包时需要注释mock.js的引用。

> axios请求地址：

    overview请求url： /WeBASE-Web/network/general/1

> mock.js地址：

    Mock.mock('/WeBASE-Web/network/general/1',function (req,res) {     //url和上面axios相同
        return {
            "code":0,
            "message":"success",
            "data":{
                "orgCount":1,
                "nodeCount":1,
                "contractCount":11,
                "latestBlock":10,
                "transactionCount":10,
            }
        }
    });

> main.js引用mock.js：

    Vue.use(ElementUI);
    // require('./mock')    //直接require引入，开发时放开注释，打包时注释
    /* eslint-disable no-new */
    new Vue({
      el: '#app',
      router,
      template: '<App/>',
      components: { App }
    })


## 2、项目打包部署

### 2.1 项目打包
`注意：npm run build之前必须要npm instal下载依赖，还要执行npm run update修改依赖并下载solc-bin文件`

> 切换到项目根目录，执行命令：

    npm run build

> 进行打包，生成打包文件dist，在项目根目录下。

### 2.2 部署

请参考[部署说明](install.html)
