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

- 6：执行起停脚本时提示以下信息：

```
（all processes could be identified, non-owned process info will not be shown, you would have to be root to see it all.）
```

答：netstat权限问题，加上权限即可（sudo chmod +s /bin/netstat）