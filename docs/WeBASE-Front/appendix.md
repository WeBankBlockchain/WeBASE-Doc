# 附录

## 1. 安装问题

### 1.1 Java部署

此处给出Oracle JDK安装简单步骤，供快速查阅。更详细的步骤，请参考[官网](http://www.oracle.com/technetwork/java/javase/downloads/index.html)。

（1）从[官网](http://www.oracle.com/technetwork/java/javase/downloads/index.html)下载对应版本的java安装包，并解压到相应目录

```shell
mkdir /software
tar -zxvf jdkXXX.tar.gz /software/
```

（2）配置环境变量

```shell
export JAVA_HOME=/software/jdk1.8.0_121
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
```

### 1.2 Gradle部署

此处给出简单步骤，供快速查阅。更详细的步骤，请参考[官网](http://www.gradle.org/downloads)。

（1）从[官网](http://www.gradle.org/downloads)下载对应版本的Gradle安装包，并解压到相应目录

```shell
mkdir /software/
unzip -d /software/ gradleXXX.zip
```

（2）配置环境变量

```shell
export GRADLE_HOME=/software/gradle-4.9
export PATH=$GRADLE_HOME/bin:$PATH
```

## 2. 常见问题

* 1：执行shell脚本报错"permission denied"

   答：chmod +x filename 给文件增加权限 

 * 2：eclipse环境编译源码失败，错误提示如下：
```
...
/data/temp/WeBASE-Front/src/main/java/com/webank/webase/front/performance/PerformanceService.java:167: error: cannot find symbol
        log.info("begin sync performance");
        ^
  symbol:   variable log
  location: class PerformanceService
Note: /data/temp/WeBASE-Front/src/main/java/com/webank/webase/front/contract/CommonContract.java uses or overrides a deprecated API.
Note: Recompile with -Xlint:deprecation for details.
Note: Some input files use unchecked or unsafe operations.
Note: Recompile with -Xlint:unchecked for details.
100 errors

> Task :compileJava FAILED

FAILURE: Build failed with an exception.
...
```

  答：问题是不能编译Lombok注解 ，修改build.gradle文件，将以下代码的注释加上
```
 //annotationProcessor 'org.projectlombok:lombok:1.18.6'
```


* 3：节点运行一段时间后新增了一个群组，前置查不到新群组的信息。 

   答：调用 http://{ip}:{port}/WeBASE-Front/1/web3/refresh 方法，即可手动更新。

- 4：升级1.0.2版本时，数据库报错：

  ```
  Caused by: org.h2.jdbc.JdbcSQLException: NULL not allowed for column "TYPE"; SQL statement:
  alter table key_store_info add column type integer not null [23502-197]
          at org.h2.message.DbException.getJdbcSQLException(DbException.java:357) ~[h2-1.4.197.jar:1.4.197]
          at org.h2.message.DbException.get(DbException.java:179) ~[h2-1.4.197.jar:1.4.197]
          at org.h2.message.DbException.get(DbException.java:155) ~[h2-1.4.197.jar:1.4.197]
  ```

  答：将H2数据库删除（在h2目录下），或者配置新数据库名，在 application.yml 文件中的配置如下：

  ```
  spring:
    datasource:
      url: jdbc:h2:file:./h2/webasefront;DB_CLOSE_ON_EXIT=FALSE // 默认H2库为webasefront
  ...
  ```

- 5：日志报以下错误信息：

  ```
  2019-08-08 17:29:05.505 [pool-11-thread-1] ERROR TaskUtils$LoggingErrorHandler() - Unexpected error occurred in scheduled task.
  org.hyperic.sigar.SigarFileNotFoundException: 没有那个文件或目录
          at org.hyperic.sigar.FileSystemUsage.gather(Native Method) ~[sigar-1.6.4.jar:?]
          at org.hyperic.sigar.FileSystemUsage.fetch(FileSystemUsage.java:30) ~[sigar-1.6.4.jar:?]
          at org.hyperic.sigar.Sigar.getFileSystemUsage(Sigar.java:667) ~[sigar-1.6.4.jar:?]
  ```

  答：监控目录不存在，需配置节点所在磁盘目录，在 application.yml 文件中的配置如下：

  ```
  ...
  constant:  
    monitorDisk: /            // 要监控的磁盘目录，配置节点所在目录（如：/home）
  ...
  ```

- 6：启动报“nested exception is javax.net.ssl.SSLException”：

```
...
nested exception is javax.net.ssl.SSLException: Failed to initialize the client-side SSLContext: Input stream not contain valid certificates.
```

答：CentOS的yum仓库的OpenJDK缺少JCE(Java Cryptography Extension)，导致Web3SDK无法正常连接区块链节点，因此在使用CentOS操作系统时，推荐从[OpenJDK网站](https://jdk.java.net/java-se-ri/8)自行下载。

- 7：启动失败，日志却没有异常

```
===============================================================================================
Starting Server com.webank.webase.front.Application Port 5002 ................................[Failed]. Please view log file (default path:./log/).
Because port 5002 not up in 20 seconds.Script finally killed the process.
===============================================================================================
```

答：确认机器是否满足硬件要求。机器性能过低会导致服务端口一定时间内没起来，脚本会自动杀掉进程。可以尝试手动修改dist目录下的start.sh脚本，将启动等待时间设置久一点（默认600，单位：秒），然后启动。

```
...
startWaitTime=600
...
```


