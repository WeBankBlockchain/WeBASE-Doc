## 附录

### 一般问题
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


### 数据库问题
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
答：mysql没有开通该帐号的远程访问权限，登录mysql，执行如下命令，其中TestUser改为你的帐号
```
GRANT ALL PRIVILEGES ON *.* TO 'TestUser'@'%' IDENTIFIED BY '此处为TestUser的密码’' WITH GRANT OPTION;
```



### mgr服务搭建问题
* 问：执行构建命令`gradle build -x test`抛出异常：
```
A problem occurred evaluating root project 'WeBASE-Node-Manager'.
Could not find method compileOnly() for arguments [[org.projectlombok:lombok:1.18.2]] on root project 'WeBASE-Node-Manager'.
```
答：
方法1、已安装的gradle版本过低，升级gradle版本到4.10以上即可。
方法2、直接使用命令：`./gradlew build -x test`
