# Skkypy | 适配MacOS的WeBASE一键部署工具

&emsp;&emsp;主要通过修改webase一键部署脚本使适配MacOS。

## 安装

- 按照[WeBASE lab](https://webasedoc.readthedocs.io/zh_CN/lab/docs/WeBASE/install.html)下载一键部署工具(WeBASE v3.0)，并修改了两个脚本后，提交基于MacOS的一键部署工具到Github，详情见[地址](https://github.com/Skkypy/webase-deploy-macos/blob/main/README.md)。WeBASE v1.x系列同理

## 适配MacOS

&emsp;&emsp;修改后，重新执行一键部署命令：
```
    root@ /Users/owner/webase3/webase-deploy >python3 deploy.py installAll                       
============================================================

              _    _     ______  ___  _____ _____ 
             | |  | |    | ___ \/ _ \/  ___|  ___|
             | |  | | ___| |_/ / /_\ \ `--.| |__  
             | |/\| |/ _ | ___ |  _  |`--. |  __| 
             \  /\  |  __| |_/ | | | /\__/ | |___ 
              \/  \/ \___\____/\_| |_\____/\____/  
    
============================================================
==============      checking envrionment      ==============
check git...
check finished sucessfully.
check openssl...
check finished sucessfully.
check curl...
check finished sucessfully.
check wget...
check finished sucessfully.
check dos2unix...
check finished sucessfully.
check config webase v1.5.4 and fisco version v3.0.0-rc2...
check finished sucessfully.
check host free memory and cpu core...
[WARN]Free memory 29(M) may be NOT ENOUGH for node count [2] and webase
[WARN]Recommend webase with 2G memory at least, and one node equipped with one core of CPU and 1G memory(linear increase with node count). 
check nginx...
check finished sucessfully.
check java...
check finished sucessfully.
check FISCO-BCOS node port...
check finished sucessfully.
check WeBASE-Web port...
check finished sucessfully.
check WeBASE-Node-Manager port...
check finished sucessfully.
check WeBASE-Sign port...
check finished sucessfully.
check WeBASE-Front port...
check finished sucessfully.
check database connection...
check finished sucessfully.
check database connection...
check finished sucessfully.
check mgr database user/password...
check finished sucessfully.
check sign database user/password...
check finished sucessfully.
check mgr mysql version...
node-mgr's mysql version is [8.0.30]
check finished sucessfully.
check sign mysql version...
sign's mysql version is [8.0.30]
check finished sucessfully.
==============      envrionment available     ==============
============================================================
==============        starting  deploy        ==============
============================================================
==============      Installing FISCO-BCOS     ==============
wget https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/FISCO-BCOS/FISCO-BCOS/releases/vv3.0.0-rc2/build_chain.sh && chmod u+x build_chain.sh
--2022-10-09 00:58:03--  https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/FISCO-BCOS/FISCO-BCOS/releases/vv3.0.0-rc2/build_chain.sh
正在解析主机 osp-1257653870.cos.ap-guangzhou.myqcloud.com (osp-1257653870.cos.ap-guangzhou.myqcloud.com)... 27.155.119.190, 27.155.119.140, 27.155.119.152, ...
正在连接 osp-1257653870.cos.ap-guangzhou.myqcloud.com (osp-1257653870.cos.ap-guangzhou.myqcloud.com)|27.155.119.190|:443... 已连接。
已发出 HTTP 请求，正在等待回应... 404 Not Found
2022-10-09 00:58:03 错误 404：Not Found。

bash: build_chain.sh: No such file or directory
==============      Starting FISCO-BCOS       ==============
======= FISCO-BCOS dir:/Users/owner/webase3/webase-deploy/nodes/127.0.0.1 is not correct. please check! =======
```

已经可以安装，结尾报错是其他的问题，如网络问题。

