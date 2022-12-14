# 配置WeBASE的HTTPS

在WeBASE v3.0.1后，WeBASE管理台(WeBASE-Web)支持 节点管理服务WeBASE-Node-Manager 的连接采用SSL（HTTPS）的方式。

## HTTPS配置方法

由于 节点前置WeBASE-Front 用于连接节点，一般 WeBASE-Front 与 节点管理服务WeBASE-Node-Manager 都处于内网，因此二者连接多数直接使用HTTP方式。

节点管理服务WeBASE-Node-Manager 与 WeBASE管理台(WeBASE-Web) 是后台服务与前端网页的连接，本章节提供的HTTPS配置方法就是这两者服务之间的HTTPS配置。

### 1. 生成SSL证书


生成一个SSL的自签发证书，需要使用openssl完成以下步骤：
1. 生成RSA私钥.key
2. 生成证书请求.csr
3. 生成自签发证书.crt
4. 转为pkcs12格式

如果linux中没有安装openssl，需要安装。以CentOS为例：`yum install openssl openssl-devel -y`

```bash
### 生成一个RSA私钥, server.key
### 输入命令后会提示输入密钥的密码，可以设置为123456或自定义密码
openssl genrsa -des3 -out server.pass.key 2048

### 利用私钥生成一个[不需要输入密码]的密钥文件（需要输入刚才设置的密码）
openssl rsa -in server.pass.key -out server.key


### 生成一个证书请求 server.csr
# 字段解读
# C字段：Country，单位所在国家，为两位数的国家缩写，如：CN 表示中国；
# ST 字段：State/Province，单位所在州或省；
# L 字段：Locality，单位所在城市/或县区；
# O 字段：Organization，此网站的单位名称；
# OU 字段：Organization Unit，下属部门名称，也常常用于显示其他证书相关信息，如证书类型，证书产品名称或身份验证类型或验证内容等；
# CN 字段：Common Name，网站的域名；例：adf.com 或IP
openssl req -new -key server.key -out server.csr -subj "/C=CN/ST=GuangDong/L=ShenZhen/O=WeBank/OU=WeBASE/CN=webaseweb"

### 自己签发证书 server.crt
#如果服务器私钥与证书均由自己生成，则无法获取服务器中级CA证书，在使用自签名的临时证书时，浏览器会在地址处提示证书的颁发机构是未知的
openssl x509 -req -days 365  -signkey server.key -in server.csr -out server.crt

### 转换为pkcs12格式 server.p12
# 因为在Java中使用证书，需要转换一下格式）
# -export：这个选项指定了一个PKCS#12文件将会被创建
# -clcerts：仅仅输出客户端证书，不输出CA证书
# -in filename：指定私钥和证书读取的文件，默认为标准输入。必须为PEM格式
# -inkey filename：指定私钥文件的位置。如果没有被指定，私钥必须在-in filename中指定
# -out filename：指定输出的pkcs12文件，默认为标准输出
openssl pkcs12 -export -clcerts -in server.crt -inkey server.key -out server.pkcs12
# 或者
openssl pkcs12 -export -clcerts -in server.crt -inkey server.key -out server.p12
```

把生成的`server.pkcs12`文件，粘贴到节点管理服务的resources目录下（或者打包后的dist/conf/目录下），并把证书的密钥密码（如123456）输入到配置文件中。

### 2. 节点管理服务WeBASE-Node-Manager

在v3.0.1后，节点管理服务在配置文件application.yml中加入了springboot ssl的配置，我们需要
- 修改application.yml配置文件的spring中加上`ssl`的配置，并设置`enable`为`true`，将`key-store-password`的密码改为生成密钥时的密码
- 复制上文密钥文件，粘贴到节点管理服务的resources目录下（或者打包后的dist/conf/目录下），

修改conf/application.yml中server的配置
```yaml

#server config
server:
  port: 5001
  servlet:
    context-path: /WeBASE-Node-Manager
  # https
  ssl:
    key-store-type: pkcs12
    key-store: classpath:server.pkcs12
    # by default this is 123456
    # 由于上文中生成的私钥是不需要密码的，因此此处可为空或123456
    key-store-password: 123456
    # 默认false，不启用SSL。改为true即可启用
    enabled: true


```

### 3. WeBASE管理台(WeBASE-Web)

WeBASE管理台连接启用HTTPS的节点管理服务无需修改源码，在前端的nginx.conf配置文件中加上SSL的配置，即可实现HTTPS连接。

修改nginx.conf，将WeBASE管理台的server配置中加上如下的ssl的配置
```conf
# 上文生成的.crt证书文件
ssl_certificate /data/home/webase/webase-node-mgr/conf/server.crt;
# 上文生成的.key私钥文件
ssl_certificate_key /data/home/webase/webase-node-mgr/conf/server.key;
# SSL详细配置
ssl_session_cache shared:SSL:10m;
ssl_session_timeout 120m;
ssl_prefer_server_ciphers on;
ssl_session_tickets off;
ssl_stapling_verify on;
```

在nginx.conf的完整例子如下：
```conf

    # ...略过上文
	server {
        listen       5000 ssl;       
        server_name  127.0.0.1;
        ################ 此处为ssl相关配置 ##############
        ssl_certificate /data/home/webase/webase-node-mgr/conf/server.crt;
        ssl_certificate_key /data/home/webase/webase-node-mgr/conf/server.key;
        ssl_session_cache shared:SSL:10m;
        ssl_session_timeout 120m;
        ssl_prefer_server_ciphers on;
        ssl_session_tickets off;
        ssl_stapling_verify on;
        ############## 此处为ssl相关配置 ##############

        location / {    
            # default pc page url
            root   /data/home/webase/webase-web;
            ...
        }
        ...
        # ...略过下文

    }
```

通过nginx -c nginx.conf -s reload即可加载新配置

如果配置了nginx的SSL后，启动nginx报错提示TLS模块确实，可在互联网中搜索错误提示的内容，将nginx的tls模块设置为启用，并尝试重启WeBASE管理台的nginx即可。
