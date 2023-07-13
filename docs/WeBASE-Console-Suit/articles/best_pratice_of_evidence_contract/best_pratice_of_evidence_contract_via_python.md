# 99Kies | 玩转存证合约（二）| 利用Python开发区块链后端接口

**实验环境**

Python3.6+

FISCO BCOS 

WeBase-Front

Centos7 / Ubuntu


**项目地址：<https://github.com/99Kies/Evidence-Sample-Python>**

## 前言

紧接上文，我们在上一文介绍了存证合约的具体内容以及存证合约的部署和调用，但是遇到一个问题，我们想通过这个合约来开发自己的web或者应用，该怎么办？

FISCO BCOS区块链向外部暴露了接口，外部业务程序能够通过FISCO BCOS提供的SDK来调用这些接口。开发者只需要根据自身业务程序的要求，选择相应语言的SDK，用SDK提供的API进行编程，即可实现对区块链的操作。（https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/sdk/index.html）

目前，FISCO BCOS 提供的SDK包括：

- [Java SDK](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/sdk/java_sdk/index.html) （稳定、功能强大、无内置控制台，推荐使用）
- [Web3SDK](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/sdk/java_sdk.html) （旧版Java SDK）
- [Python SDK](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/sdk/python_sdk/index.html) （简单轻便、有内置控制台）
- [Node-js SDK](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/sdk/nodejs_sdk/index.html) （简单轻便、有内置控制台）
- [Go SDK](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/sdk/go_sdk/index.html) （简单轻便、有内置控制台）
- [C# SDK](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/sdk/csharp_sdk/index.html) （完整适配Json RPC API）

我们本节将利用**Python-SDK**，利用Python来实现区块链的后端开发。

## 安装Python-SDK

### 依赖软件

- **Ubuntu**: `sudo apt install -y zlib1g-dev libffi6 libffi-dev wget git`
- **CentOS**：`sudo yum install -y zlib-devel libffi-devel wget git`
- **MacOs**: `brew install wget npm git`

### 初始化环境(若python环境符合要求，可跳过)

#### **Linux环境初始化**

> 拉取源代码

```bash
git clone https://github.com/FISCO-BCOS/python-sdk
```

> 配置环境(安装pyenv和python，若python版本>=3.6.3可跳过本步)

```bash
# 获取python版本
python --version

## --------若python版本小于3.6.3，执行下面流程--------------------------------------
# 判断python版本，并为不符合条件的python环境安装python 3.7.3的虚拟环境，命名为python-sdk
# 若python环境符合要求，可以跳过此步
# 若脚本执行出错，请检查是否参考[依赖软件]说明安装了依赖
# 提示：安装python-3.7.3可能耗时比较久
cd python-sdk && bash init_env.sh -p

## --------若通过bash init_env.sh -p安装了python-sdk虚拟环境，执行下面流程-------------
# 激活python-sdk虚拟环境
source ~/.bashrc && pyenv activate python-sdk && pip install --upgrade pip
```

### **安装Python SDK依赖**

```bash
cd python-sdk 
pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
```

### 初始化配置

```
# 该脚本执行操作如下：
# 1. 拷贝client_config.py.template->client_config.py
# 2. 安装solc编译器
bash init_env.sh -i
```

> **若MacOS环境solc安装较慢，可在python-sdk目录下执行如下命令安装solcjs**，python-sdk自动加载nodejs编译器：

```
# 安装编译器
npm install solc@v0.4.25
```

> **tips：webase-front部署合约之后，会生成合约地址，bin和abi文件，将abi文件保存到contracts/目录下，合约地址（contractAddress）也需要复制保存用于合约调用（0x8d6327bf7253e87add9d17212cc76dd7ff1d380c），这样子才可以调用相应的合约。IDE页面下方和合约列表都有对应的信息**

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305020911399.png)

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305021027332.png)

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305021043422.png)



### 配置Channel通信协议

Python SDK支持使用[Channel协议](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/design/protocol_description.html#channelmessage-v1)与FISCO BCOS节点通信，通过SSL加密通信保障SDK与节点通信的机密性。

设SDK连接的节点部署在目录`~/fisco/nodes/127.0.0.1`目录下，则通过如下步骤使用Channel协议：

**配置Channel信息**

在节点目录下的 config.ini 文件中获取 channel_listen_port, 这里为20200

```bash
[rpc]
    listen_ip=0.0.0.0
    channel_listen_port=20200
    jsonrpc_listen_port=8545
```

切换到python-sdk目录，修改 client_config.py 文件中`channel_host`为实际的IP，`channel_port`为上步获取的`channel_listen_port`：

```bash
channel_host = "127.0.0.1"
channel_port = 20200
```

**配置证书**

```bash
# 若节点与python-sdk位于不同机器，请将节点sdk目录下所有相关文件拷贝到bin目录
# 若节点与sdk位于相同机器，直接拷贝节点证书到SDK配置目录
cp ~/fisco/nodes/127.0.0.1/sdk/* bin/
```

**配置证书路径**

- `client_config.py`的`channel_node_cert`和`channel_node_key`选项分别用于配置SDK证书和私钥
- `release-2.1.0`版本开始，SDK证书和私钥更新为`sdk.crt`和`sdk.key`，配置证书路径前，请先检查上步拷贝的证书名和私钥名，并将`channel_node_cert`配置为SDK证书路径，将`channel_node_key`配置为SDK私钥路径

检查从节点拷贝的sdk证书路径，若sdk证书和私钥路径分别为`bin/sdk.crt`和`bin/sdk.key`，则`client_config.py`中相关配置项如下：

```
channel_node_cert = "bin/sdk.crt"  # 采用channel协议时，需要设置sdk证书,如采用rpc协议通信，这里可以留空
channel_node_key = "bin/sdk.key"   # 采用channel协议时，需要设置sdk私钥,如采用rpc协议通信，这里可以留空
```

若sdk证书和私钥路径分别为`bin/node.crt`和`bin/node.key`，则`client_config.py`中相关配置项如下:

```bash
channel_node_cert = "bin/node.crt"  # 采用channel协议时，需要设置sdk证书,如采用rpc协议通信，这里可以留空
channel_node_key = "bin/node.key"   # 采用channel协议时，需要设置sdk私钥,如采用rpc协议通信，这里可以留空
```

**国密支持**

- 支持国密版本的非对称加密、签名验签(SM2), HASH算法(SM3),对称加解密(SM4)
- 国密版本在使用上和非国密版本基本一致，主要是配置差异。
- 国密版本sdk同一套代码可以连接国密和非国密的节点，需要根据不同的节点配置相应的IP端口和证书
- 因为当前版本的实现里，账户文件格式有差异，所以国密的账户文件和ECDSA的账户文件采用不同的配置

连接国密节点时，有以下相关的配置项需要修改和确认，IP端口也需要确认是指向国密版本节点

```bash
crypto_type = "GM" 	#密码算法选择: 大小写不敏感："GM" 标识国密, "ECDSA" 或其他是椭圆曲线默认实现。
gm_account_keyfile = "gm_account.json"  #国密账号的存储文件，可以加密存储,如果留空则不加载
gm_account_password = "123456" 		#如果不设密码，置为None或""则不加密
gm_solc_path = "./bin/solc/v0.4.25/solc-gm" #合约编译器配置，通过执行bash init_env.sh -i命令下载
```

**使用Channel协议访问节点**

```bash
# 获取FISCO BCOS节点版本号
./console.py getNodeVersion
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305021110780.png)
**Event事件回调**

- 针对已经部署在链上某个地址的合约，先注册要监听的事件，当合约被交易调用，且生成事件时，节点可以向客户端推送相应的事件
- 事件定义如有indexed类型的输入，可以指定监听某个特定值作为过滤，如事件定义为 on_set(string name,int indexed value),可以增加一个针对value的topic监听，只监听value=5的事件
- 具体实现参考demo_event_callback.py,使用的命令行为：

```bash
params: contractname address event_name indexed
        1. contractname :       合约的文件名,不需要带sol后缀,默认在当前目录的contracts目录下
        2. address :    十六进制的合约地址,或者可以为:last,表示采用bin/contract.ini里的记录
        3. event_name : 可选,如不设置监听所有事件
        4. indexed :    可选,根据event定义里的indexed字段,作为过滤条件)

        eg: for contract sample [contracts/HelloEvent.sol], use cmdline:

        python demo_event_callback.py HelloEvent last
        --listen all event at all indexed ：

        python demo_event_callback.py HelloEvent last on_set
        --listen event on_set(string newname) （no indexed）：

        python demo_event_callback.py HelloEvent last on_number 5
        --listen event on_number(string name,int indexed age), age ONLY  5 ：
```

成功安装Python-SDK以及保存abi和合约地址之后，就可以进行后端开发了。

## 构造Evidence类

现阶段，Python-SDK不支持pip下载，配置好的SDK和项目应该处于同一级目录下。例如：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305021141830.png)


首先介绍一下合约调用的初始化。



我们需要通过**BcosClient**（from client.bcosclient import BcosClient）底下的**call()**函数和**sendRawTransaction() / sendRawTransactionGetReceipt()**函数实现合约的调用。

- call() 不上链，不发送交易。
- sendRawTransaction() / sendRawTransactionGetReceipt() 上链，发送交易。

**sendRawTransaction()**函数只返回交易地址，并不会返回交易的具体内容，如果需要获取交易的具体内容则需要调用**sendRawTransactionGetReceipt()**函数。（我们需要用api显示这些内容，所以使用sendRawTransactionGetReceipt()函数）

通过观察这几个函数
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305021158669.png)
![在这里插入图片描述](https://img-blog.csdnimg.cn/2021030502121461.png)

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305021225590.png)


- to_address —— 合约地址（string格式）
- contract_abi —— abi内容（json格式/dict格式）

所以我们需要提供给SDK两个东西——**abi（contracts/EvidenceFactory.abi）**和**合约地址（0x8d6327bf7253e87add9d17212cc76dd7ff1d380c）**。

Python-SDK提供了导入abi文件的函数，直接调用即可（读取abi文件json内容）

```
from client.datatype_parser import DatatypeParser
abi_file = "contracts/EvidenceFactory.abi"
data_parser = DatatypeParser()
data_parser.load_abi_file(abi_file)
print(data_parser.contract_abi)
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305021249635.png)


所以只要能设计一个类能实现call函数和sendRawTransactionGetReceipt()即可。

### 以HelloWorld.sol为例

在python-sdk文件夹下执行`python3 console.py deploy HelloWorld`即可部署成功。abi会自动在contracts/目录下生成。



```python
from client.bcosclient import BcosClient
from client.datatype_parser import DatatypeParser

class Contract:
    def __init__(self, address: str):
        """
        :param address: 合约地址
        :return:
        """

        # 合约地址
        self.to_address = address

        # 读取abi文件，并转为json格式
        abi_file = "contracts/HelloWorld.abi"
        data_parser = DatatypeParser()
        data_parser.load_abi_file(abi_file)
        self.contract_abi = data_parser.contract_abi

        # 创建BcosClient实例
        self.client = BcosClient()

    def sendtx(self, fn_name, args=None):
        """
        :param fn_name: 对应合约中的函数名
        :param args: fn_name的参数
        :return: 交易信息，json格式
        """
        if args is None:
            sendtx_result = self.client.sendRawTransactionGetReceipt(self.to_address, self.contract_abi, fn_name, [])
        else:
            sendtx_result = self.client.sendRawTransactionGetReceipt(self.to_address, self.contract_abi, fn_name, [args])
        return {"result": sendtx_result}

    def call(self, fn_name, args=None):
        """
        :param fn_name: 对应合约中的函数名
        :param args: fn_name的参数
        :return: 交易信息，json格式
        """

        if args is None:
            call_result = self.client.call(self.to_address, self.contract_abi, fn_name, [])
        else:
            call_result = self.client.call(self.to_address, self.contract_abi, fn_name, [args])
        return {"result": call_result}
```



调用测试：

```python
contract_address = "0xa2a802c413d738c98054c5582997c3120d2ebe0b"
cnt = Contract(contract_address)
call_msg = cnt.call("get")
print(call_msg)

send_msg = cnt.sendtx("set", "hello, fengfeng")
print(send_msg)

call_finish = cnt.call("get")
print(call_finish)
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305021308464.png)



### 客制化Evidence类

上述实现了一个call和sendRawTransactionGetReceipt的HelloWorld类，但是这并不方便我们后端调用，我们需要对其进行客制化设计，不把fn_name当成参数传入，并对每个函数返回的数据进行处理。

```python
from client.bcosclient import BcosClient
from client.datatype_parser import DatatypeParser
from web3 import Web3

class Evidence_Contract:

    def __init__(self, address: str):

        self.to_address = address
        
        abi_file = "contracts/EvidenceFactory.abi"
        data_parser = DatatypeParser()
        data_parser.load_abi_file(abi_file)
        self.contract_abi = data_parser.contract_abi

        self.client = BcosClient()


    def new_evidence_by_evi(self, evi: str):

        new_evidence = self.client.sendRawTransactionGetReceipt(self.to_address, self.contract_abi, "newEvidence", [evi])
        return {"result": new_evidence["logs"]}

    def get_evidence_by_address(self, address: str):

        addr = Web3.toChecksumAddress(address)
        evidence_msg = self.client.call(self.to_address, self.contract_abi, "getEvidence", [addr])
        return {"result": evidence_msg}

    def add_signatures_by_evi_address(self, address: str):
        addr = Web3.toChecksumAddress(address)
        signature = self.client.sendRawTransactionGetReceipt(self.to_address, self.contract_abi, "addSignatures", [addr])
        return {
            "result": signature["logs"]
        }

    def verifySigner_by_address(self, address: str):
        try:
            addr = Web3.toChecksumAddress(address)
            signature = self.client.call(self.to_address, self.contract_abi, "verify", [addr])
            return {
                "result": signature[0]
            }
        except:
            return {
                "address": False
            }

    def get_signer_by_index(self, index: int):
        signature = self.client.call(self.to_address, self.contract_abi, "getSigner", [index])
        return {
            "address": signature[0]
        }

    def get_signers_size(self):
        signers_size = self.client.call(self.to_address, self.contract_abi, "getSignersSize", [])
        return {
            "size": signers_size[0]
        }

    def get_signers(self):
        signers = self.client.call(self.to_address, self.contract_abi, "getSigners", [])
        return {
            "signers": signers[0]
        }
```

> tips：python没有address这个数据类型，如果需要传入address类型的数据，需要用`Web3.toChecksumAddress(address)`转换。

存证合约中涉及到多签的场景，对一个存证进行多次签名。

实现思路：**切换账户发送交易。**

只要切换账户再调用addSignatures即可。

在client/bcosclient.py下的BcosClient类中添加以下内容：

```python
def set_account_by_privkey(self, privkey):
    """
    :param privkey: 用户私钥
    :return: 
    """
    self.ecdsa_account = Account.from_key(privkey)
    keypair = BcosKeyPair()
    keypair.private_key = self.ecdsa_account.privateKey
    keypair.public_key = self.ecdsa_account.publickey
    keypair.address = self.ecdsa_account.address
    self.keypair = keypair


def set_account_by_keystorefile(self, account_keyfile):
    """
    :param account_keyfile: bing/accounts目录下的account_keyfile文件名
    :return: 
    """
    try:
        self.keystore_file = "{}/{}".format(client_config.account_keyfile_path,
                                            account_keyfile)
        if os.path.exists(self.keystore_file) is False:
            raise BcosException(("keystore file {} doesn't exist, "
                                 "please check client_config.py again "
                                 "and make sure this account exist")
                                .format(self.keystore_file))
        with open(self.keystore_file, "r") as dump_f:
            keytext = json.load(dump_f)
            privkey = keytext["privateKey"]
            self.ecdsa_account = Account.from_key(privkey)
            keypair = BcosKeyPair()
            keypair.private_key = self.ecdsa_account.privateKey
            keypair.public_key = self.ecdsa_account.publickey
            keypair.address = self.ecdsa_account.address
            self.keypair = keypair
    except Exception as e:
        raise BcosException("load account from {} failed, reason: {}"
                            .format(self.keystore_file, e))
```

python内置了一个账户（/bin/accounts/pyaccount.keystore），如果不实现切换账户的功能就办法调用部署的合约更没办法实现多签。

1. 将webase-front导出的**account_keyfile**保存在bin/accounts下，即可通过 `BcosClient.set_account_by_keystorefile(account_keyfile) `切换用户
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305021331569.png)




2. 也可以根据用户的私钥来切换账户 `BcosClient.set_account_by_privkey(privkey)`



测试代码：

```python
contract_address = "0x8d6327bf7253e87add9d17212cc76dd7ff1d380c"
# 合约地址
a = Evidence_Contract(contract_address)

fengfeng_privkey = "d6f8c8f9106835ccc8f8d0bbc4b5bf32ff5f8941e69f9f50d075684d10dda7be"
fengfeng2_privkey = "619834a32f41fc9dce7809c3063070af3d78fac577a0c12705984eed0b1a3cb"

a.client.set_account_by_privkey(fengfeng2_privkey)
# 切换账户

t = a.new_evidence_by_evi("Hello, world")
print(t)
# 创建存证

print(a.get_evidence_by_address(t["result"][0]["address"]))
# 获取存证信息

print("==================== 切换账户 ====================")
print("==================== 添加多签用户 ====================")

a.client.set_account_by_keystorefile("fengfeng.keystore")
# 切换账户

print(a.add_signatures_by_evi_address(t["result"][0]["address"]))
# 添加签名

print(a.get_evidence_by_address(t["result"][0]["address"]))
# 查看存证信息
```


![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305021349232.png)


### 通过Flask设计后端API接口

```python
from flask import Flask, jsonify, request, render_template
from evidence_contract import Evidence_Contract
from flask_cors import CORS

app = Flask(__name__)
contract_address = "0x8d6327bf7253e87add9d17212cc76dd7ff1d380c"
fengfeng_privkey = "d6f8c8f9106835ccc8f8d0bbc4b5bf32ff5f8941e69f9f50d075684d10dda7be"
fengfeng2_privkey = "619834a32f41fc9dce7809c3063070af3d78fac577a0c12705984eed0b1a3cb"
CORS(app)

@app.route("/new_evidence", methods=["GET", "POST"])
def new_evidence():
    data = request.get_json()
    if data is None:
        return jsonify({"error": "Pleace input [privkey, evidenceString] by string."}), 400
    privkey = data["privkey"]
    evidence_string = data["evidenceString"]
    evidence = Evidence_Contract(contract_address)
    evidence.client.set_account_by_privkey(privkey)
    new_evi = evidence.new_evidence_by_evi(evidence_string)
    return jsonify(new_evi), 200

@app.route("/evidence/<address>", methods=["GET", "POST"])
def show_evidence(address):
    try:
        evidence = Evidence_Contract(contract_address)
        evi = evidence.get_evidence_by_address(address)
        return jsonify(evi), 200
    except Exception as e:
        return jsonify({"error": e}), 400

@app.route("/addsignatures", methods=["GET", "POST"])
def add_sinatures():
    data = request.get_json()
    if data is None:
        return jsonify({"error": "pleace input [privkey, evidenceAddress] by string."}), 400
    privkey = data["privkey"]
    evidence_address = data["evidenceAddress"]
    evidence = Evidence_Contract(contract_address)
    try:
        evidence.client.set_account_by_privkey(privkey)
    except:
        return jsonify({"error": "Please enter the correct private key."}), 400
    result = evidence.add_signatures_by_evi_address(evidence_address)
    return jsonify(result), 200

@app.route("/verifysigner", methods=["GET", "POST"])
def verify():
    data = request.get_json()
    if data is None:
        return jsonify({"error": "pleace input [signerAddress,] by string."}), 400
    evidence = Evidence_Contract(contract_address)
    result = evidence.verifySigner_by_address(data["signerAddress"])
    return jsonify(result), 200

@app.route("/signer/<int:index>")
def showsigner(index):
    evidence = Evidence_Contract(contract_address)
    result = evidence.get_signer_by_index(index)
    return jsonify(result), 200

@app.route("/signer/lists")
def listsigner():
    evidence = Evidence_Contract(contract_address)
    result = evidence.get_signers()
    return jsonify(result), 200

@app.route("/signer/size")
def get_signer_size():
    evidence = Evidence_Contract(contract_address)
    result = evidence.get_signers_size()
    return jsonify(result), 200

if __name__ == '__main__':
    app.run(host="0.0.0.0")
```

**postman测试接口**

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210305021410147.png)


至此我们利用Python实现了后端API接口，可以通过这一套API来设计属于自己的web应用了。

## 总结

利用Webase-Front + Python-SDK，我们实现了一套API接口并通过这套API接口调用了所有的合约接口。

### 项目仓库

<https://github.com/WeLightProject/Evidence-Sample-Python>



## 参考链接

<https://github.com/fisco-bcos/python-sdk>

<https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/sdk/index.html>

<https://github.com/MIllionBenjamin/Blockchain-FinalProject-SupplyChainFinancialPlatform>
# 关于作者

<div align=center><a href="https://blog.csdn.net/qq_19381989" target="_blank"><img src="https://img-blog.csdnimg.cn/20200427000145250.png" width="40%" /></a></div>


**作者的联系方式：**

微信：`thf056`
qq：1290017556
邮箱：1290017556@qq.com

你也可以通过 <strong><a href="https://github.com/99kies" target="_blank">github</a></strong> | <strong><a href="https://blog.csdn.net/qq_19381989" target="_blank">csdn</a></strong> | <strong><a href="https://weibo.com/99kies" target="_blank">@新浪微博</a></strong> 关注我的动态
