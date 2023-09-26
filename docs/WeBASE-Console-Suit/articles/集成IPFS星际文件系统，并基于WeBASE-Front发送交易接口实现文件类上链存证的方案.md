## 集成IPFS星际文件系统，并基于WeBASE-Front发送交易接口实现文件类上链存证的方案

> 作者简介： 孙运盛 吉科软信息技术有限公司 大数据技术研究院架构师。负责吉科软区块链BaaS平台设计研发，基于FISCO BCOS的区块链技术研究以及在智慧农业、智慧城市、智慧食安行业领域的区块链技术应用研发。

### 一、背景

- 随着业务的发展，越来越多的业务诉求集中到文件上链，比如图片类、各类电子证明文件、视频文件等文件类型数据上链。常见文件类上链场景如电子证照类、医疗影像类、电子票据类、数字藏品类等等都涉及对文件不可篡改特性的需求，借助区块链上链存储实现文件的不可篡改和一致性校验；

- 对于文件类上链有两种方案：方案一为文件内容直接上链，这样生成的交易内容较大，包含交易的区块大小增长较快，随着业务量增加，对区块链的网络和存储带来较大的压力；方案二为文件内容hash上链，具体方案为将文件存储在对象存储服务器上，将文件内容hash以及相关信息上链，上链信息较小，针对大数据量和高并发场景适用；

- 其中方案二更优，当查询链上文件信息时，校验链上文件内容hash与对象存储服务器上文件内容hash是否一致，来确认文件内容是否被篡改。这种方式可极大避免对区块链产品的网络和存储压力，同时也能保证对文件内容的可信与可验证。

  本文将根据IPFS星际文件存储系统和基于CRUD的代理模式合约，对文件类上链的处理过程进行示例说明，如何将业务方的文件存储到IPFS，同时计算文件内容哈希，再通过智能合约将文件内容哈希、IPFS文件存储哈希以及业务方上送的其他文件属性信息一并上链存储。方案流程如下图：
  ![基于IPFS和WeBASE-Front实现文件类上链的方案流程](https://segmentfault.com/img/bVc9SYL)

### 二、实验环境

| 名称         | 版本号  | 说明                     |
| ------------ | ------- | ------------------------ |
| FISCO BCOS   | v2.9.0  |                          |
| WeBASE-Front | v1.5.4  |                          |
| Solidity     | ^0.6.10 |                          |
| IPFS(kubo)   | v0.21.0 | 最新IPFS版本已更名为kubo |

### 三、IPFS私有网络多节点部署

#### 3.1 下载安装文件

ipfs官网地址:[https://dist.ipfs.tech/](https://link.segmentfault.com/?enc=4ng%2B3T9NPetMry9BR9YF7Q%3D%3D.1Si1%2Fz2ovyuk0gSZKh%2Bb4MRoXZyFWH8GEWoREjehF0I%3D)
下载kubo(go-ipfs)，安装列表中适配的操作系统进行下载对应的安装文件。

#### 3.2 安装及初始化

将下载的文件放到任意安装目录下，进行解压

```stylus
#1.解压安装包
tar -zxvf kubo_v0.21.0_linux-amd64.tar.gz
#2.进入解压后的目录
cd kubo
#3.执行install.sh脚本
./install.sh
#4.执行初始化
ipfs init
#5.解决跨域问题
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "GET", "POST", "OPTIONS"]'
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["*"]'
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Credentials '["true"]'
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Headers '["Authorization"]'
ipfs config --json API.HTTPHeaders.Access-Control-Expose-Headers '["Location"]'
#6.启动ipfs
ipfs daemon
#7.若启动时与本地服务端口发生冲突，可以在IPFS的配置中对端口进行重新指定
```

#### 3.3 私有网络部署多节点

##### 3.3.1 安装golang环境

官网下载go，地址 [https://go.dev/dl/](https://link.segmentfault.com/?enc=9ZIcz6kDQFGK57na9iicIQ%3D%3D.mf8yNXnddNeRi77pyI%2Fhzk0fdc8LT%2B9URP5mez5o84o%3D)
下载符合操作系统的版本 ，如 [https://go.dev/dl/go1.20.6.linux-amd64.tar.gz](https://link.segmentfault.com/?enc=C5TB%2Bm7z4TVbXVV%2BwBXQYA%3D%3D.BAxvPi2VddWaFV0EtPy4Uv7omvmKy%2FULPJBcTAYHAehrWB5NeZ74EN7lrCYeAw84)
![img](https://segmentfault.com/img/bVc9SZw)
下载后解压文件

```
tar -zxvf go1.20.6.linux-amd64.tar.gz
```

配置环境变量，修改/etc/profile文件，增加go的bin目录，如：

```routeros
export GOROOT=/home/bigdata/go
export PATH=$PATH:$GOROOT/bin
```

执行 source /etc/profile，使更改生效。

##### 3.3.2 各节点服务器依次下载并安装IPFS

参考上节的单机安装ipfs,查看节点的ID

```autoit
[root@localhost .ipfs]# ipfs id
{
"ID": "12D3KooWPRK2HL5deq1wn8ZuoeJKqctzh6ywoTsg9cz7Fwzwzpn3",
"PublicKey": "CAESIMobs4cyoWjM0h980TSqNLp+FYEWpXrhKz+GTGJyWMk4",
"Addresses": null,
"AgentVersion": "kubo/0.21.0-rc3/",
"ProtocolVersion": "ipfs/0.1.0",
"Protocols": null
}
```

##### 3.3.3 IPFS 配置文件修改

IPFS多节点 才能构建一个本地的分布式文件系统，在联盟链开发环境下，多数会使用到IPFS多节点私有网存储文件。
为了搭建多节点的IPFS访问，需要修改~/.ipfs目录下的config 文件

```prolog
"Addresses": {
    "API": "/ip4/192.168.189.102/tcp/5001",
    "Announce": [],
    "AppendAnnounce": [],
    "Gateway": "/ip4/192.168.189.102/tcp/8181",
    "NoAnnounce": [],
    "Swarm": [
      "/ip4/0.0.0.0/tcp/4001",
      "/ip6/::/tcp/4001",
      "/ip4/0.0.0.0/udp/4001/quic",
      "/ip4/0.0.0.0/udp/4001/quic-v1",
      "/ip4/0.0.0.0/udp/4001/quic-v1/webtransport",
      "/ip6/::/udp/4001/quic",
      "/ip6/::/udp/4001/quic-v1",
      "/ip6/::/udp/4001/quic-v1/webtransport"
    ]
  }
```

其中 API 和Gateway两部分的ip地址改为本机IP地址。Gateway的端口地址默认为8080，可以修改为其他端口号 如 8181， 不与其他应用的8080端口号冲突即可。

##### 3.3.4 删除公共连接节点

```
ipfs bootstrap rm --all
```

##### 3.3.5 创建共享KEY

下载go-ipfs-swarm-key-gen，由于linux下访问github.com很难访问，可以使用git命令将工程clone下来，并且github.com 用kgithub.com替换，即可成功访问github。

```awk
git clone https://kgithub.com/Kubuxu/go-ipfs-swarm-key-gen.git
```

swarm.key 密钥允许我们创建一个私有网络，并告诉网络节点只和拥有相同秘钥的节点通信，在一个节点上执行下面命令:
进入go-ipfs-swarm-key-gen/ipfs-swarm-key-gen目录下执行 go build编译。

```autoit
[root@localhost ipfs-swarm-key-gen]# go build
[root@localhost ipfs-swarm-key-gen]# ls
ipfs-swarm-key-gen  main.go
```

编译成功会在目录下生成 ipfs-swarm-key-gen的可执行文件。

使用ipfs-swarm-key-gen 生成密钥文件：

```
./ipfs-swarm-key-gen > ~/.ipfs/swarm.key
```

进入 ~/.ipfs/查看生成的swarm.key文件

```csharp
[root@localhost ipfs-swarm-key-gen]# cd ~/.ipfs/
[root@localhost .ipfs]# ls
api  blocks  config  datastore  datastore_spec  gateway  keystore  nohup.out  repo.lock  swarm.key  version
```

a.如果编译报错，解决方案

```subunit
[root@localhost ipfs-swarm-key-gen]# go build
error obtaining VCS status: directory "/home/bigdata" is not using a known version control system
Use -buildvcs=false to disable VCS stamping.
```

出现此错误时，执行

```
go env -w GOFLAGS=-buildvcs=false
```



##### 3.3.6 将共享key复制到其他节点

```angelscript
[root@localhost .ipfs]# scp swarm.key root@192.168.189.103:~/.ipfs
swarm.key                                                                                                                    100%   95     1.2KB/s   00:00
[root@localhost .ipfs]# scp swarm.key root@192.168.189.120:~/.ipfs
swarm.key                                                                                                                    100%   95     0.9KB/s   00:00
[root@localhost .ipfs]# scp swarm.key root@192.168.189.121:~/.ipfs
swarm.key
```

##### 3.3.7 查看本节点的ID，并在其他节点中添加本节点

在本节点服务器执行 ipfs id

```prolog
[root@localhost .ipfs]# ipfs id
{
"ID": "12D3KooWPRK2HL5deq1wn8ZuoeJKqctzh6ywoTsg9cz7Fwzwzpn3",
"PublicKey": "CAESIMobs4cyoWjM0h980TSqNLp+FYEWpXrhKz+GTGJyWMk4",
"Addresses": [
"/ip4/127.0.0.1/tcp/4001/p2p/12D3KooWPRK2HL5deq1wn8ZuoeJKqctzh6ywoTsg9cz7Fwzwzpn3",
"/ip4/127.0.0.1/udp/4001/quic-v1/p2p/12D3KooWPRK2HL5deq1wn8ZuoeJKqctzh6ywoTsg9cz7Fwzwzpn3",
"/ip4/127.0.0.1/udp/4001/quic-v1/webtransport/certhash/uEiCl2iwFGuc_5lPbIW_1kx-sHE8StNUn1oyO9C92Fo_aMA/certhash/uEiAqpOGn8isK2l-fOPxkGKwk63FSkYVmlw1O3cMNO3pbVA/p2p/12D3KooWPRK2HL5deq1wn8ZuoeJKqctzh6ywoTsg9cz7Fwzwzpn3",
"/ip4/127.0.0.1/udp/4001/quic/p2p/12D3KooWPRK2HL5deq1wn8ZuoeJKqctzh6ywoTsg9cz7Fwzwzpn3",
"/ip4/192.168.189.102/tcp/4001/p2p/12D3KooWPRK2HL5deq1wn8ZuoeJKqctzh6ywoTsg9cz7Fwzwzpn3",
"/ip4/192.168.189.102/udp/4001/quic-v1/p2p/12D3KooWPRK2HL5deq1wn8ZuoeJKqctzh6ywoTsg9cz7Fwzwzpn3",
"/ip4/192.168.189.102/udp/4001/quic-v1/webtransport/certhash/uEiCl2iwFGuc_5lPbIW_1kx-sHE8StNUn1oyO9C92Fo_aMA/certhash/uEiAqpOGn8isK2l-fOPxkGKwk63FSkYVmlw1O3cMNO3pbVA/p2p/12D3KooWPRK2HL5deq1wn8ZuoeJKqctzh6ywoTsg9cz7Fwzwzpn3",
"/ip4/192.168.189.102/udp/4001/quic/p2p/12D3KooWPRK2HL5deq1wn8ZuoeJKqctzh6ywoTsg9cz7Fwzwzpn3",
"/ip6/::1/tcp/4001/p2p/12D3KooWPRK2HL5deq1wn8ZuoeJKqctzh6ywoTsg9cz7Fwzwzpn3",
"/ip6/::1/udp/4001/quic-v1/p2p/12D3KooWPRK2HL5deq1wn8ZuoeJKqctzh6ywoTsg9cz7Fwzwzpn3",
"/ip6/::1/udp/4001/quic-v1/webtransport/certhash/uEiCl2iwFGuc_5lPbIW_1kx-sHE8StNUn1oyO9C92Fo_aMA/certhash/uEiAqpOGn8isK2l-fOPxkGKwk63FSkYVmlw1O3cMNO3pbVA/p2p/12D3KooWPRK2HL5deq1wn8ZuoeJKqctzh6ywoTsg9cz7Fwzwzpn3",
"/ip6/::1/udp/4001/quic/p2p/12D3KooWPRK2HL5deq1wn8ZuoeJKqctzh6ywoTsg9cz7Fwzwzpn3"
],
"AgentVersion": "kubo/0.21.0-rc3/",
"ProtocolVersion": "ipfs/0.1.0",
"Protocols": [
"/ipfs/bitswap",
"/ipfs/bitswap/1.0.0",
"/ipfs/bitswap/1.1.0",
"/ipfs/bitswap/1.2.0",
"/ipfs/id/1.0.0",
"/ipfs/id/push/1.0.0",
"/ipfs/lan/kad/1.0.0",
"/ipfs/ping/1.0.0",
"/libp2p/autonat/1.0.0",
"/libp2p/circuit/relay/0.2.0/stop",
"/x/"
]
}
```

找到 /ip4/192.168.189.102/tcp/4001/p2p/12D3KooWPRK2HL5deq1wn8ZuoeJKqctzh6ywoTsg9cz7Fwzwzpn3 ，在其他节点执行添加节点，如：

```awk
ipfs bootstrap add  /ip4/192.168.189.102/tcp/4001/p2p/12D3KooWPRK2HL5deq1wn8ZuoeJKqctzh6ywoTsg9cz7Fwzwzpn3
```

##### 3.3.8 强制启用私有网络

修改config配置文件 ，在Routing部分添加 "Type":"dht",如下：

```json
"Routing": {
    "AcceleratedDHTClient": false,
    "Methods": null,
    "Routers": null,
    "Type": "dht"
}
```

添加环境变量，修改/etc/profile 添加 export LIBP2P_FORCE_PNET=1， 刷新文件
source /etc/profile

##### 3.3.9 查看节点连接情况

```
ipfs swarm peers
```

##### 3.3.10 在其中一个节点上传文件，其他节点查看文件

每个节点都添加其他几个节点的ID信息，如在其中一个节点 添加另外一个节点的命令

```awk
ipfs bootstrap  add  /ip4/192.168.189.121/tcp/4001/p2p/12D3KooWPRTod1R4ivaac8cSfXRnkXgivcKaXjfrNmBCadXY1ATi
```

全部添加完成后，使用 ipfs swarm peers查看连接的节点信息

```awk
[root@localhost .ipfs]# ipfs swarm peers
/ip4/192.168.189.103/tcp/4001/p2p/12D3KooWKjjNkV2tUw3FZUMnrDrkPqR72eqjMCDkAXKqo1Foth2e
/ip4/192.168.189.120/tcp/4001/p2p/12D3KooWB3EJA4m73qCWMXi9cWyZzfbsSEnn7LXsCFpHZX9JuQcb
/ip4/192.168.189.121/tcp/4001/p2p/12D3KooWPRTod1R4ivaac8cSfXRnkXgivcKaXjfrNmBCadXY1ATi
```

在192.168.189.102节点上添加文件， 其他节点上查看文件
添加文件：

```css
[root@localhost home]# ipfs add haha.txt
added QmWEkNNf7XUJ2aS6BhNs9UNRnusVVyFfbmD7L9HmPFWnQP haha.txt
4 B / 4 B [===================================================================================] 100.00%
```

其他节点依次查看 该哈希对应的文件内容

```autoit
[root@localhost bigdata]# ipfs cat QmWEkNNf7XUJ2aS6BhNs9UNRnusVVyFfbmD7L9HmPFWnQP
hello
```

可以在任意节点上传文件，其他节点查看文件，进行测试所有节点是否均联通。

##### 3.3.11 通过浏览器访问文件

访问文件的地址为 http://节点IP:节点PORT/ipfs/文件哈希值
如：
[http://192.168.189.102:8181/ipfs/QmSJYWJz9pXn6y4vXc5veEaQUQJQ...](https://link.segmentfault.com/?enc=XoI2TtAPKRprCa8OgfrjeQ%3D%3D.8FLziFOtIPMlwxjMNqXjv0eHuTBplYQwqDB3ct%2FMcFC8u58rPT885RyhBMYg4zngB8dL0k8sjCzwvKJRiv2pKZYc6Ope%2F%2BHHwgCzuOwEBgA%3D)
![img](https://segmentfault.com/img/bVc9SZ1)

##### 3.3.12 将ipfs添加为系统服务

首先创建 /etc/systemd/system/ipfs.service，

```
touch /etc/systemd/system/ipfs.service
```

修改ipfs.service文件，添加以下内容：

修改ipfs.service文件，添加以下内容：

```ini
[Unit]
Description=IPFS Daemon
After=syslog.target network.target remote-fs.target nss-lookup.target
[Service]
Type=simple
ExecStart=/usr/local/bin/ipfs daemon --enable-namesys-pubsub
User=root
[Install]
WantedBy=multi-user.target
```

执行

```
systemctl daemon-reload
```

使用以下命令进行启动和停止 及查看状态

使用以下命令进行启动和停止 及查看状态

```protobuf
service ipfs start 
service ipfs stop
service ipfs restart
service ipfs status
```

### 四、IPFS文件上传、下载JAVA服务接口

#### 4.1 引入IPFS SDK依赖包

```xml
<dependency>
    <groupId>com.github.ipfs</groupId>
    <artifactId>java-ipfs-http-client</artifactId>
    <version>v1.4.4</version>
</dependency>
```

#### 4.2 初始化IPFS

```kotlin
package com.jkr.api.config;
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
/**
 * ipfs星际文件系统的属性配置
 */
@Data
@Configuration
@ConfigurationProperties(prefix = "ipfs.config")
public class IpfsProperties {
    private String multiAddr;
}
package com.jkr.config;
import com.jkr.api.config.IpfsProperties;
import io.ipfs.api.IPFS;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import java.io.IOException;
/**
 * 初始化相关类
 */
@Log4j2
@Configuration
public class BeanConfig {
    @Autowired
    private IpfsProperties ipfsProperties;
    @Bean
    public IPFS ipfs() throws IOException {
        IPFS ipfs = new IPFS(ipfsProperties.getMultiAddr());
        ipfs.refs.local();
        return ipfs;
    }
}
```

#### 4.3 IPFS 文件上传、下载服务实现类

```java
package com.jkr.api.service.impl;
import cn.hutool.core.io.FileUtil;
import com.jkr.api.service.IpfsService;
import io.ipfs.api.IPFS;
import io.ipfs.api.MerkleNode;
import io.ipfs.api.NamedStreamable;
import io.ipfs.multihash.Multihash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.io.File;
import java.io.IOException;

/**
 * 连接ipfs星际文件系统的文件上传和下载服务类
 */
@Service
public class IpfsServiceImpl implements IpfsService {
    @Autowired
    private IPFS ipfs;
    /**
     * 指定文件路径上传文件到ipfs
     *
     * @param filePath 文件路径
     * @return 存储文件的寻址哈希
     * @throws IOException
     */
    @Override
    public String uploadToIpfs(String filePath) throws IOException {
        NamedStreamable.FileWrapper file = new NamedStreamable.FileWrapper(new File(filePath));
        MerkleNode addResult = ipfs.add(file).get(0);
        String hash = addResult.hash.toString();
        return hash;
    }
    /**
     * 将byte格式的数据,上传至ipfs
     *
     * @param fileData
     * @return 存储文件的寻址哈希
     * @throws IOException
     */
    @Override
    public String uploadToIpfs(byte[] fileData) throws IOException {
        NamedStreamable.ByteArrayWrapper file = new NamedStreamable.ByteArrayWrapper(fileData);
        MerkleNode addResult = ipfs.add(file).get(0);
        return addResult.hash.toString();
    }
    /**
     * 根据Hash值,从ipfs下载内容,返回byte数据格式
     * @param hash 文件寻址哈希
     * @return
     */
    @Override
    public byte[] downFromIpfs(String hash) {
        byte[] data = null;
        try {
            data = ipfs.cat(Multihash.fromBase58(hash));
        } catch (IOException e) {
            e.printStackTrace();
        }
        return data;
    }

    /**
     * 根据Hash值,从ipfs下载内容,并写入指定文件destFilePath
     *
     * @param hash         文件寻址哈希
     * @param destFilePath 目标文件路径
     */
    @Override
    public void downFromIpfs(String hash, String destFilePath) {
        byte[] data = null;
        try {
            data = ipfs.cat(Multihash.fromBase58(hash));
        } catch (IOException e) {
            e.printStackTrace();
        }
        if (data != null && data.length > 0) {
            FileUtil.del(destFilePath);
            FileUtil.writeBytes(data, destFilePath);
        }
    }
}
```

### 五、文件数据上链的合约样例

对于文件上链采用方案二，上链文件内容哈希，而不直接将文件本身上链，所以智能合约的编写可采用文本信息上链方式，本示例中是基于CRUD合约的代理模式的通用存证智能合约。主合约为代理合约EvidenceProxy、逻辑合约EvidenceController、存储合约EvidenceStorage。

#### 5.1 代理合约EvidenceProxy

```javascript
pragma solidity ^0.6.10;

import "./Proxy.sol";
import "./EvidenceStorageStateful.sol";

/**
 * @title 入口代理合约 
 * @author sunyunsheng
 * @notice 通用数据上链存证入口代理合约，实现设置具体实现的逻辑合约地址、返回存储合约地址列表
 */
contract EvidenceProxy is EvidenceStorageStateful, Proxy {


 
    event SetStorage(address operator, address evidenceStorage);



    /**
    * @notice 设置存储合约地址
    * @dev 限合约管理员调用
    * @param _storageAddr 登记存储合约
    */
    function setStorage(address _storageAddr) external onlyOwner {

        require(_storageAddr != address(0), "Proxy: storage address should not be 0x");
        require(Address.isContract(_storageAddr), "Proxy: Cannot set a proxy storage to a non-contract address");

        evidenceStorage = EvidenceStorage(_storageAddr);
        storageAddrList.push(_storageAddr);
        emit SetStorage(msg.sender, _storageAddr);
    }

    /**
    * @notice 返回所有的存储合约地址列表
    */
    function getStorageVersions() public view returns (string memory result){
        result="{";
        for(uint i = 0; i < storageAddrList.length; i++) {
            result = result.toSlice().concat(addressToString(storageAddrList[i]).toSlice());
            if(i != (storageAddrList.length-1)) {
                result = result.toSlice().concat(",".toSlice());
            }
        }
        result = result.toSlice().concat("}".toSlice());
    }
}
```

#### 5.2 逻辑合约EvidenceController

```javascript
pragma solidity ^0.6.10;
pragma experimental ABIEncoderV2;

import "./Ownable.sol";
import "./EvidenceStorageStateful.sol";
import "./Table.sol";
import "./Strings.sol";

/**
 * @title 存证逻辑合约
 * @author sunyunsheng
 * @notice 继承逻辑合约基类和控制权基类，实现动态建表、添加或更新数据、删除数据、根据主键查询数据的逻辑接口
 */
contract EvidenceController is EvidenceStorageStateful, Ownable {
    
    using Strings for *;



    event Create(string tableName);
    event Put(string tableName, string key, string[] _data);
    event Remove(string tableName, string key);
    event MultiPutJson(string tableName, string keys, string values, string result);



    /**
    * @notice 动态建表
    * @param tableName 表名
    */
    function create(string memory tableName) external {

        require(evidenceStorage.StorageCreate(tableName) == int(0), "EvidenceController: createTable error");

        emit Create(tableName);
    }

    /**
    * @notice 添加信息，自动区分是新增信息还是更新信息
    * @param tableName 表名
    * @param key 主键
    * @param data 包含value以及5个保留字段的值集合
    */
    function put(string memory tableName, string memory key, string[] memory data) public {

        int _result ;
        string memory  _key;
        string[] memory _dataValue;
    
        (_result, _key,  _dataValue) = evidenceStorage.StorageSelect(tableName, key);
      
        require(keccak256(abi.encode(_dataValue)) != keccak256(abi.encode(data)),"EvidenceController: same value, not need put");

        require(evidenceStorage.StoragePut(tableName, key, data) == int(1), "EvidenceController: put info error");

        emit Put(tableName, key, data);
    }

    /*
    * @notice 在表中删除key对应的记录
    *         删除所有版本中key对应的记录
    *
    * @param tableName 表名
    * @param keyValue 主键
    */
    function remove(string memory tableName, string memory key) external {

        require(evidenceStorage.StorageRemove(tableName, key) == int(1), "EvidenceController: remove info error");

        emit Remove(tableName, key);
    }

    /**
    * @notice 获取链上信息
    * @param tableName 表名
    * @param key 主键
    */
    function get(string memory tableName, string memory  key) external view returns(
        int _result ,string memory _key,string[] memory _valueData){

        return evidenceStorage.StorageSelect(tableName, key);
    }

}
```

#### 5.3 存储合约EvidenceStorage

```javascript
pragma solidity ^0.6.10;
pragma experimental ABIEncoderV2;

import "./Table.sol";
import "./BaseStorage.sol";
import "./Strings.sol";

/**
 * @title 通用存储合约
 * @author sunyunsheng
 * @notice 数据上链通用存证的存储合约，实现动态建表、插入数据、修改数据、删除数据、查询数据、判断给定的key是否存在的逻辑功能
 */
contract EvidenceStorage is BaseStorage {
    using Strings for *;
    
    
    // table列表
    string[] internal tableList;
    
    // table记录的条目数
    mapping(string => uint) internal tableRecords;
    /**
    * @return table列表
    */
    function getTableList() public view returns (string[] memory) {
        return tableList;
    }

    /**
    * @return table中操作的条目数
    */
    function getTableRecords(string memory key) public view returns (uint) {
        return tableRecords[key];
    }

    /**
    * @notice 动态创建表
    * @param tableName 表的名称
    * 表结构：
    * +--------------+---------------------+-------------------------+
    * | Field        | Type                | Desc                    |
    * +--------------+---------------------+-------------------------+
    * | key          | string              | 主键                     |
    * | value        | string              | 对应value                |
    * | reserve1     | string              | 保留字段1                | 
    * | reserve2     | string              | 保留字段2                |
    * | reserve3     | string              | 保留字段3                |
    * | reserve4     | string              | 保留字段4                |
    * | reserve5     | string              | 保留字段5                |
    * +--------------+---------------------+-------------------------+
    *  count = 0 表示成功创建
    *  其他值表示创建失败
    */
    function StorageCreate(string memory tableName)public onlyProxy returns(int) {
        TableFactory tf = TableFactory(0x1001);
        int count = tf.createTable(tableName, "key", "value, reserve1, reserve2, reserve3, reserve4, reserve5");

        tableList.push(tableName);
        emit CreateResult(count);
        
        return count;
    }

    /**
    * @notice 插入数据
    * @dev 限入口合约调用
    * @param tableName 表的名称
    * @param key       主键
    * @param _data     包含除key主键之外的其他字段的值集合

    * count = 1  表示插入成功
    * count = -1 表示key已存在
    * 其他值 表示插入失败
    */
    function StorageInsert(string memory tableName, string memory key, string[] memory _data)public onlyProxy returns(int) {
        TableFactory tf = TableFactory(0x1001);
        Table table = tf.openTable(tableName);
      
        int count = 0 ;
        if(_isKeyExist(table, key)){
            count = -1 ;
            tableRecords[tableName.toSlice().concat("_Insert_BAD".toSlice())] += 1; 
        }else{
            Entry entry = table.newEntry();
            entry.set("key", key);
            entry.set("value", _data[0]);
            if(_data.length>1){
                for(uint i=1; i<_data.length; i++){
                    entry.set("reserve".toSlice().concat(toString(i).toSlice()), _data[i]);
                }
            }
            count = table.insert(key, entry);
            tableRecords[tableName.toSlice().concat("_Insert_OK".toSlice())] += 1; 
        }
        emit InsertResult(count);
        return count;
    }

    /**
    * @notice 通过key查询数据,以结构体形式返回
    * @param tableName 表的名称
    * @param key       主键
    *
    * result =  0 表示查询成功
    * result = -1 表示查询失败
    */
    function StorageSelect(string memory tableName,  string memory key) public view returns(int , string memory , string[] memory ){
        TableFactory tf = TableFactory(0x1001);
        Table table = tf.openTable(tableName);
        int _result;
        string memory _key;
        string[] memory _data = new string[](6);
        if(_isKeyExist(table, key)){
            Condition condition = table.newCondition();
            Entry entry = table.select(key, condition).get(int(0));
            _data[0]=entry.getString("value");
            _data[1]=entry.getString("reserve1");
            _data[2]=entry.getString("reserve2");
            _data[3]=entry.getString("reserve3");
            _data[4]=entry.getString("reserve4");
            _data[5]=entry.getString("reserve5");
            _result = 0 ;
            _key = key;
        }else{
            _result= -1 ;
            _key = key;
            _data[0]="";
            _data[1]="";
            _data[2]="";
            _data[3]="";
            _data[4]="";
            _data[5]="";           
        }
        return (_result, _key, _data);
    }

    /**
    * @notice 通过key添加数据，自动区分是注册还是更新
    * @param tableName 表的名称
    * @param key       主键
    * @param _data     包含除key主键之外的其他字段的值集合
    *
    * count =  1 表示添加成功
    * 其他值表示更新失败
    */
    function StoragePut(string memory tableName, string memory key, string[] memory _data) public onlyProxy returns(int) {
        TableFactory tf = TableFactory(0x1001);
        Table table = tf.openTable(tableName);
        int count = 0 ;
        ( int _result, , string[] memory _valueData ) = StorageSelect(tableName, key);
        Entry entry = table.newEntry();
        entry.set("value", _data[0]);
        if(_data.length>1){
            for(uint i=1; i<_data.length; i++){
                entry.set("reserve".toSlice().concat(toString(i).toSlice()), _data[i]);
            }
        }
        if(_result == 0 ){
            Condition condition = table.newCondition();
            count = table.update(key, entry, condition);
        }else{
            count = table.insert(key, entry);
        }
        tableRecords[tableName.toSlice().concat("_Put".toSlice())] += 1;
        emit PutResult(_result, count);
        return count;
    }
 /**
    * @notice 通过key更新数据
    * @param tableName 表的名称
    * @param key       主键
    * @param _data     包含除key主键之外的其他字段的值集合
    *
    * count =  1 表示更新成功
    * count = -1 表示key不存在
    * 其他值表示更新失败
    */
    function StorageUpdate(string memory tableName, string memory key, string[] memory _data ) public onlyProxy returns(int) {
        TableFactory tf = TableFactory(0x1001);
        Table table = tf.openTable(tableName);
        int count = 0 ;
        ( int _result, , string[] memory _valueData ) = StorageSelect(tableName, key);
        if(_result == 0 ){
            
            Entry entry = table.newEntry();
            entry.set("value", _data[0]);
            if(_data.length>1){
                for(uint i=1; i<_data.length; i++){
                    entry.set("reserve".toSlice().concat(toString(i).toSlice()), _data[i]);
                }
            }
            Condition condition = table.newCondition();
            count = table.update(key, entry, condition);
            tableRecords[tableName.toSlice().concat("_Update_OK".toSlice())] += 1;    
        }else{
            count = -1;
            tableRecords[tableName.toSlice().concat("_Update_BAD".toSlice())] += 1;            
        }
        emit UpdateResult(count);
        return count;
    }
   

    /**
    * @notice 通过key删除数据
    * @param tableName 表的名称
    * @param key       主键
    *
    * count =  1 标识删除成功
    * count = -1 表示key不存在
    * 其他值表示删除失败
    */
    function StorageRemove(string memory tableName, string memory key) public onlyProxy returns(int){
        TableFactory tf = TableFactory(0x1001);
        Table table = tf.openTable(tableName);
        int count = 0 ;
        if(_isKeyExist(table, key)){
            Condition condition = table.newCondition();
            count = table.remove(key, condition);
            tableRecords[tableName.toSlice().concat("_Remove_OK".toSlice())] += 1;
        }else{
            count = -1;
            tableRecords[tableName.toSlice().concat("_Remove_BAD".toSlice())] += 1;        
        }
    
        emit RemoveResult(count);
        return count;
    }


    /**
    * @notice 判读key值是否存在
    * @param tableName 表的名称
    * @param key       主键
    */
    function isKeyExist(string memory tableName, string memory key) external view returns(bool) {
        TableFactory tf = TableFactory(0x1001);
        Table table = tf.openTable(tableName);

        return _isKeyExist(table, key);
    }

    function _isKeyExist(Table _table, string memory _id) internal view returns(bool) {
        Condition condition = _table.newCondition();
        return _table.select(_id, condition).size() != int(0);
    }

}
```





### 六、基于WeBASE-Front交易处理接口实现文件数据上链

对于基于WeBASE-Front交易处理接口实现文件信息数据上链，主要逻辑是在区块链BaaS接口平台中接收业务方上送的文件地址、文件内容哈希，文件归属信息等其他类业务信息，通过文件地址到业务方OSS平台下载文件，并计算文件内容哈希与业务方上送的文件内容哈希进行校验，防止上链前的文件内容篡改，校验通过后将下载的文件存储至IPFS，将IPFS返回的寻址哈希，与业务上送的其他信息，组装发送区块链的交易报文，智能合约采用CRUD方式，表中预留扩展字段，可将接口平台重新计算的文件内容哈希和IPFS寻址哈希存到预留扩展字段，按此组装发送交易到区块链的交易报文，调用WeBASE-Front前置服务的发送交易接口，由WeBASE-Front调用WeBASE-Sign进行交易云签名，然后发送交易到区块链节点，实现文件信息的上链。
WeBASE-Front发送交易接口的调用可参考本作者的另一篇文章《基于WeBASE-Front前置服务发送交易REST接口调用可升级的智能合约方案》。