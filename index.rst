##############################################################
WeBASE 技术文档
##############################################################

.. image:: ./images/logo/logo_smaller_new.png

WeBASE（WeBank Blockchain Application Software Extension） 是在区块链应用和FISCO BCOS节点之间搭建的一套通用组件。

- 本技术文档适用于WeBASE lab版本（适配FISCO BCOS v3.0），WeBASE 1.x版技术文档可跳转至 `[WeBASE master分支] <https://webasedoc.readthedocs.io/zh_CN/latest>`_ 查看


.. important::
    FISCO-BCOS 2.0与3.0对比、JDK版本、WeBASE及其他子系统的版本兼容说明！`请查看 <https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/compatibility.html>`_


.. container:: row 
   
   .. container:: card-holder
      
      .. container:: card rocket

         .. raw:: html

            <br>
            <h style="font-size: 22px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;快速开始</h>
            <br><br>
         
         - `什么是WeBASE <./docs/WeBASE/introduction.html>`_
         - `WeBASE版本信息 <./docs/WeBASE/ChangeLOG.html#fisco-bcos-2-x-x>`_
         - `安装部署 <./docs/WeBASE-Install/index.html>`_
         - `WeBASE管理平台使用手册 <./docs/WeBASE-Console-Suit/index.html>`_


   .. container:: card-holder
      
      .. container:: card ref

         .. raw:: html

            <br>
            <h style="font-size: 22px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;WeBASE子系统</h>
            <br><br>
         
         - `节点前置服务 <./docs/WeBASE-Front/index.html>`_
         - `节点管理服务 <./docs/WeBASE-Node-Manager/index.html>`_
         - `WeBASE管理平台 <./docs/WeBASE-Web/index.html>`_
         - `私钥托管与签名服务 <./docs/WeBASE-Sign/index.html>`_
         - `交易服务 <./docs/WeBASE-Transaction/index.html>`_


.. container:: row 

   .. container:: card-holder
      
      .. container:: card ref

         .. raw:: html

            <br>
            <h style="font-size: 22px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;解决方案</h>
            <br><br>

         - `WeBASE合约仓库 <./docs/WeBASE-Contract-Warehouse/index.html>`_
         - `WeBASE实训课程案例 <./docs/WeBASE-Training-Class/index.html>`_


   .. container:: card-holder
      
      .. container:: card manuals

         .. raw:: html

            <br>
            <h style="font-size: 22px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;更多资料</h>
            <br><br>
         
         - `WeBASE贡献指南 <./docs/WeBASE/CONTRIBUTING.html>`_
         - `WeBASE国内镜像仓库、文档、安装包资源 <./docs/WeBASE/mirror.html>`_
         - `开源社区 <./docs/More/community.html>`_
         
.. container:: row 

   .. container:: card-holder-bigger
      
      .. container:: card-bigger rocket

         .. raw:: html

               <br>
               <h style="font-size: 22px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;更多开源工具</h>
               <br><br>

               <img src="_images/overview_blockchain.png" class="card-holder-full">


         .. container:: tools 

            .. raw:: html

            - **FISCO BCOS企业级金融联盟链底层平台**: `[GitHub] <https://github.com/FISCO-BCOS/FISCO-BCOS>`_ `[Gitee] <https://gitee.com/FISCO-BCOS>`_ `[文档] <https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/index.html>`_ 
            - **WeBASE 区块链中间件平台**：`[GitHub] <https://github.com/WeBankBlockchain/WeBASE>`_ `[Gitee] <https://gitee.com/WeBank/WeBASE>`_  `[文档] <https://webasedoc.readthedocs.io/>`_ 
            - **Liquid 智能合约编程语言软件**：`[GitHub] <https://github.com/WeBankBlockchain/liquid>`_ `[Gitee] <https://gitee.com/WeBankBlockchain/liquid>`_  `[文档] <https://liquid-doc.readthedocs.io/>`_


.. toctree::
   :hidden:
   :maxdepth: 3
   :caption: 平台介绍

   docs/WeBASE/introduction.md
   docs/WeBASE/ChangeLOG.md

.. toctree::
   :hidden:
   :maxdepth: 3
   :caption: 安装部署

   docs/WeBASE-Install/developer.md
   docs/WeBASE/install.md
   docs/WeBASE-Install/enterprise.md
   docs/WeBASE/mirror.md

.. toctree::
   :hidden:
   :maxdepth: 3
   :caption: WeBASE使用指南
   
   docs/WeBASE-Console-Suit/index.md
   docs/WeBASE-Contract-Warehouse/index.md
   docs/WeBASE-Training-Class/index.md
   docs/WeBASE/quick-start.md

.. toctree::
   :hidden:
   :maxdepth: 3
   :caption: WeBASE子系统

   docs/WeBASE-Front/index.md
   docs/WeBASE-Node-Manager/index.md
   docs/WeBASE-Web/index.md
   docs/WeBASE-Sign/index.md
   docs/WeBASE-Transaction/index.md

.. toctree::
   :hidden:
   :maxdepth: 3
   :caption: 更多参考资料
   
   docs/WeBASE-Console-Suit/articles/index.md
   docs/WeBASE/CONTRIBUTING.md
   docs/More/family-bucket.md
   docs/More/community.md

