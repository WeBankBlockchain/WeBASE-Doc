## 附录

### 1. 问题及方案
#### 一般问题
* 问：执行shell脚本报下面错误：
```
[app@VM_96_107_centos deployInputParam]$ bash start.sh
start.sh: line 2: $'\r': command not found
start.sh: line 8: $'\r': command not found
start.sh: line 9: $'\r': command not found
start.sh: line 10: $'\r': command not found
```
答：这是编码问题，在脚本的目录下执行转码命令：
```shell
dos2unix *.sh
```


#### 数据库问题
* 问：服务访问数据库抛出异常：
```
The last packet sent successfully to the server was 0 milliseconds ago. The driver has not received any packets from the server.
```
答：检查数据库的网络策略是否开通
```
下面以centos7为例：
查看防火墙是否开放3306端口： firewall-cmd --query-port=3306/tcp
防火墙永久开放3306端口：firewall-cmd --zone=public --add-port=3306/tcp --permanent
重新启动防火墙：firewall-cmd --reload
```

* 问：执行数据库初始化脚本抛出异常：
```
ERROR 2003 (HY000): Can't connect to MySQL server on '127.0.0.1' (110)
```
答：MySQL没有开通该帐号的远程访问权限，登录MySQL，执行如下命令，其中TestUser改为你的帐号
```
GRANT ALL PRIVILEGES ON *.* TO 'TestUser'@'%' IDENTIFIED BY '此处为TestUser的密码’' WITH GRANT OPTION;
```

#### WeBASE-Node-Manager服务搭建问题
* 问：执行构建命令`gradle build -x test`抛出异常：
```
A problem occurred evaluating root project 'WeBASE-Node-Manager'.
Could not find method compileOnly() for arguments [[org.projectlombok:lombok:1.18.2]] on root project 'WeBASE-Node-Manager'.
```
答：
方法1、已安装的Gradle版本过低，升级Gradle版本到4.10以上即可。
方法2、直接使用命令：`./gradlew build -x test`

- 2. 配置文件解析

| 参数 | 默认值    | 描述          |
|------|-------------|-----------|
| server.port  | 5001 | 当前服务端口   |
| server.servlet.context-path  | /WeBASE-Node-Manager | 当前服务访问目录   |
| mybatis.typeAliasesPackage  | com.webank.webase.node.mgr | mapper类扫描路径   |
| mybatis.mapperLocations  | classpath:mapper/*.xml | mybatis的xml路径   |
| spring.datasource.driver-class-name | com.mysql.cj.jdbc.Driver | mysql驱动   |
| spring.datasource.url | jdbc:mysql://127.0.0.1:3306/webasenodemanager | mysql连接地址   |
| spring.datasource.username | defaultAccount |  mysql账号  |
| spring.datasource.password | defaultPassword |  mysql密码  |
| logging.config | classpath:log/log4j2.xml | 日志配置文件目录   |
| logging.level | com.webank.webase.node.mgr: info |  日志扫描目录和级别  |
| constant.isDeleteInfo | true | 是否定时删除数据（区块、交易hash、审计数据）；true-是，false-否   |
| constant.transRetainMax | 10000 |表中交易hash保留的条数（开启constant.isDeleteInfo时有效） |
| constant.deleteInfoCron | "0 0/1 * * * ?" | 定时删除数据的频率，默认一分钟   |
| constant.statisticsTransDailyCron | "0 0/1 * * * ?" | 统计交易记录的执行频率，默认一分钟|
| constant.resetGroupListCycle | 600000 | 刷新群组列表任务执行完后，下一个开始间隔（毫秒）   |
| constant.groupInvalidGrayscaleValue | 1M |  群组失效灰度期长度，灰度期过后，如果还没查到失效状态的群组，就删除（y:年, M:月, d:天, h:小时, m:分钟, n:永远有效）  |
| constant.notSupportFrontIp | localhost | 不支持的前置ip   |
| constant.isBlockPullFromZero | false |  是否从0开始同步区块信息（true-是，false-最新块开始同步）  |
| constant.pullBlockInitCnts | 1000 | 最新块的前1000个块之后开始同步（constant.isBlockPullFromZero=false时有效） |
| constant.pullBlockSleepTime | 200 |  拉完一个区块，睡眠时间（毫秒）  |
| constant.pullBlockTaskFixedDelay | 30000 |  拉区块任务执行完后，间隔多久开始下一次（毫秒）|
| constant.blockRetainMax | 10000 |  表中区块保留的条数（开启constant.isDeleteInfo时有效）  |
| constant.verificationCodeMaxAge | 300 | y验证码有效时长（秒） |
| constant.authTokenMaxAge | 1800 |  登录token有效时长（秒）  |
| constant.isUseSecurity | true | 是否启用登录鉴权   |
| constant.aesKey | ERTadb83f9ege39k | aes加密key（16位），建议更改 |
| constant.jwtSecret | S3g4HtJyg7G6Hg0Ln3g4H5Jyg7H6f9dL |  jwt生成时用到的key，建议更改  |
| constant.frontUrl | http://%1s:%2d/WeBASE-Front/%3s | 前置服务的请求路径  |
| constant.httpTimeOut | 5000 | http请求超时时间（毫秒）  |
| constant.contractDeployTimeOut | 30000 | 合约部署超时时间（毫秒）  |
| constant.isPrivateKeyEncrypt | true | 前置私钥接口返回的私钥是否需要加密，true-加密，false-不加密  |
| constant.maxRequestFail | 3 |  请求前置（frot）被允许失败次数，达到配置值后，将会停止往该路径发送请求  |
| constant.sleepWhenHttpMaxFail | 60000 | 请求失败次数过多，熔断时间长度（毫秒） |
| constant.transMonitorTaskFixedRate | 60000  | 交易审计开始执行后，下一个任务开始时间（毫秒）  |
| constant.analysisSleepTime | 200 | 审计完一条交易hash后，睡眠时间（毫秒）  |
| constant.monitorInfoRetainMax | 10000 | 表中审计数据保留的条数（开启constant.isDeleteInfo时有效） |
| constant.isMonitorIgnoreUser | false | 审计逻辑是否忽略私钥用户  |
| constant.isMonitorIgnoreContract | false |  审计逻辑是否忽略合约 |
| constant.monitorUnusualMaxCount | 20 | 审计异常数据被允许最大值，到达后会停止审计  |
| constant.auditMonitorTaskFixedDelay | 300000 | 监控审计数据任务的间隔时间，异常时将发送告警邮件（毫秒）  |
| constant.nodeStatusMonitorTaskFixedDelay | 60000 | 监控节点状态任务的间隔时间，异常时将发送告警邮件（毫秒）  |
| constant.certMonitorTaskFixedDelay | 300000 | 监控证书任务的间隔时间，有效期结束7天前时将发送告警邮件（毫秒）  |
| sdk.encryptType | 0 |  sdk的加密类型，0：标准，1：国密；需要与链和Front的类型一致  |

### 3. 升级兼容性

请查看[升级说明](upgrade.md)










