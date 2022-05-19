# 区块链教程 | 如何使用WeBASE合约IDE教程部署交易并发起交易

## 前言

WeBASE简介：[WeBASE（WeBank Blockchain Application Software Extension）](https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE/introduction.html) 是在区块链应用和FISCO-BCOS节点之间搭建的一套通用组件。围绕交易、合约、密钥管理，数据，可视化管理来设计各个模块，开发者可以根据业务所需，选择子系统进行部署。WeBASE屏蔽了区块链底层的复杂度，降低开发者的门槛，大幅提高区块链应用的开发效率，包含节点前置、节点管理、交易链路，数据导出，Web管理平台等子系统。

本文基于FISCO BCOS 2.8.0版本，介绍使用WeBASE合约IDE教程部署交易并发起交易。使用“合约IDE”功能，进行部署合约及发布功能；使用“合约调用”功能发起交易。

## 准备工作

准备工作分两种方法：

### 一、一键部署

一键部署会搭建：节点（FISCO-BCOS 2.0+）、管理平台（WeBASE-Web）、节点管理子系统（WeBASE-Node-Manager）、节点前置子系统（WeBASE-Front）、签名服务（WeBASE-Sign）。其中，节点的搭建是可选的，可以通过配置来选择使用已有链或者搭建新链。具体参考[一键部署WeBase手册](https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE/install.html)

### 二、最小安装部署：

#### 1、搭建基础区块链网络

搭建区块链网络参考[搭建第一个区块链网络](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/installation.html)

#### 2、部署WeBase-Front前端管理

部署WeBase-Front参考[WeBASE-Front部署手册](https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/install.html)

![WeBase-Front管理界面](https://user-images.githubusercontent.com/3991904/169191483-955201ef-9c12-48c7-87ac-3ca71cb99d4b.png)
WeBase-Front管理界面

## 合约部署

WeBASE为区块链开发和管理者提供了简单和方便的操作界面，实现了丰富的区块底层操作功能，本节借助合约IDE功能介绍合约的部署功能。

### 一、创建合约
1、登录WeBase-Front管理系统

2、点击合约管理=》合约IDE

3、创建合约文件

![通过IDE创建合约步骤](https://user-images.githubusercontent.com/3991904/169191548-1d1a3ec4-f4bd-43dd-a50f-a9693de1bcc4.png)
注：通过IDE创建合约步骤

### 二、编写合约

注：本节合约编写参考官方文档中的HelloWorld合约，具体可参考：[HelloWorld合约](https://fisco-bcos-doc.readthedocs.io/zh_CN/latest/docs/quick_start/air_installation.html#helloworld)

1、通过合约IDE打开需要编写的合约文件

2、在IDE里编写HelloWorld合约，合约内容参考[HelloWorld合约编写](https://fisco-bcos-doc.readthedocs.io/zh_CN/latest/docs/quick_start/air_installation.html#helloworld)

3、编写完成后点击保存按钮，提示保存成功

4、保存成功后点击编译按钮，完成合约的编译工作

![HelloWorld合约编写步骤](https://user-images.githubusercontent.com/3991904/169191595-5b7b58ea-c5b3-441e-92ea-a371d3060101.png)
HelloWorld合约编写步骤

### 三、部署合约

注：只有部署的合约才可以被外部调用，部署成功的合约不可以修改；合约修改后重新部署不会覆盖之前的合约。

1、通过合约IDE打开需要部署的合约文件

2、点击IDE界面工具条中的部署按钮

3、选择部署用户，点击确认完成部署

4、如果无用户，可以在“合约管理”=》“测试用户”功能中创建测试用户

![部署合约操作步骤](https://user-images.githubusercontent.com/3991904/169191633-8461ccf7-94e1-428e-ac1a-d52407e56991.png)
部署合约操作步骤

![合约部署成功界面](https://user-images.githubusercontent.com/3991904/169191668-bb445bb4-e90e-4b64-83ad-6d911c68bb09.png)
合约部署成功界面

## 合约调用

### 一、打开合约

通过菜单“合约管理”=》“合约IDE”，打开已经编写的合约，我们打开已经部署好的HelloWorld合约。

![HelloWorld合约信息](https://user-images.githubusercontent.com/3991904/169191692-5bde11b1-5ab3-4fb1-94b6-b449981371b2.png)
HelloWorld合约信息

### 二、调用合约

在“合约IDE”操作界面的工具条，点击“合约调用”按钮，打开合约调用配置界面

![HelloWorld合约set方法调用配置界面](https://user-images.githubusercontent.com/3991904/169191726-48abc659-8f29-485f-abaf-8002e9faeaf9.png)
HelloWorld合约set方法调用配置界面

1、合约地址，合约部署后生成的地址，每次部署会重新生成；

2、方法：方法为合约对外提供的方法；例如：HelloWorld合约对外提供了get和set方法，我们先选择set方法

3、参数：参数为动态的，根据选用的方法而变化；在这里我们填写 Hello,FISCOBCOS。

注：如果参数类型是数组，请按照以下格式输入，以逗号分隔，非数值和布尔值须使用双引号，例如：["aaa","bbb"]和[100,101]；如果数组参数包含双引号，需转义，例如：["aaa\"bbb","ccc"]。

4、点击确认，完成合约调用。

![HelloWorld合约set方法调用成功界面](https://user-images.githubusercontent.com/3991904/169191749-68776a62-95c3-4960-bc17-ff6d58c82023.png)
HelloWorld合约set方法调用成功界面

5、重新点击合约调用，方法选择get，点击确认。

![HelloWorld合约get方法调用配置界面](https://user-images.githubusercontent.com/3991904/169191781-b40ca040-5372-470a-ba1a-f79ea7d0fe7d.png)
HelloWorld合约get方法调用配置界面

![HelloWorld合约get方法调用成功界面](https://user-images.githubusercontent.com/3991904/169191797-61091d61-f62c-487c-a579-9b49b06566f6.png)
HelloWorld合约get方法调用成功界面
## 总结

WeBASE是在区块链应用和FISCO-BCOS节点之间搭建的一套通用组件。合约IDE提供了合约编写、编译、部署和调用等通用功能，非常适合开发者进行合约的编辑，编译，部署，调试。

最后的最后：WeBASE虽好，但我还是建议新手用户要打好基础，请先学习[搭建第一个区块链网络](https://fisco-bcos-doc.readthedocs.io/zh_CN/latest/docs/quick_start/air_installation.html) 和 [开发第一个Solidity区块链应用](https://fisco-bcos-doc.readthedocs.io/zh_CN/latest/docs/quick_start/solidity_application.html) ，这样才能更好的应用WeBASE，做到事半功倍的效果，祝各位一切顺利。
