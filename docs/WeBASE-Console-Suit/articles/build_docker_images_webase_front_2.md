# 银川龙龙 | 构建WeBASE-Front的Docker镜像的图文教程


### 1、编译代码修改配置
  按照 [交易部署说明](https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/install.html)（链接[https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/install.html](https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/install.html)）完成到第4步，主要需要修改的是“//连接节点的监听ip” 和 “//配置所连节点的绝对路径，用于监控节点配置与日志” 这两个配置，确保地址正确和可连接。

### 2、查看Dockerfile文件

进入到WeBASE-Front\docker\build目录，查看Dockerfile文件
```
vim Dockerfile
```
内容如下：

```
FROM ubuntu:18.04 as prod

#RUN apk --no-cache add bash curl wget
RUN apt-get update \
    && apt-get -y install openjdk-8-jre \
    && rm -rf /var/lib/apt/lists/*

COPY gradle                /dist/gradle
COPY static                /dist/static
COPY lib                  /dist/lib
COPY conf_template        /dist/conf
COPY apps                 /dist/apps

# run with 'sdk' volume
RUN mkdir -p /dist/sdk

WORKDIR /dist
EXPOSE 5002

ENV CLASSPATH "/dist/conf/:/dist/apps/*:/dist/lib/*"

ENV JAVA_OPTS " -server -Dfile.encoding=UTF-8 -Xmx512m -Xms512m -Xmn256m -Xss512k -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=512m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/log/heap_error.log  -XX:+UseG1GC -XX:MaxGCPauseMillis=200 "
ENV APP_MAIN "com.webank.webase.front.Application"

# start commond
ENTRYPOINT cp -r /dist/sdk/* /dist/conf/ && java ${JAVA_OPTS} -Djdk.tls.namedGroups="secp256k1", -Duser.timezone="Asia/Shanghai" -Djava.security.egd=file:/dev/./urandom, -Djava.library.path=/dist/conf -cp ${CLASSPATH}  ${APP_MAIN}

```
这个镜像在运行到容器的时候，会报下面这个错误
```
cp: cannot stat '/dist/sdk/*': No such file or directory
```
所以对这个Dockerfile文件进行一下修改。


### 3、修改Dockerfile文件
修改后内容如下：
```
FROM java:8

COPY gradle                /dist/gradle
COPY static                /dist/static
COPY lib                  /dist/lib
COPY conf                 /dist/conf
COPY apps                 /dist/apps
COPY sdk                  /dist/sdk

WORKDIR /dist
EXPOSE 5002

ENV CLASSPATH "/dist/conf/:/dist/apps/*:/dist/lib/*"

ENV JAVA_OPTS " -server -Dfile.encoding=UTF-8 -Xmx512m -Xms512m -Xmn256m -Xss512k -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=512m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/log/heap_error.log  -XX:+UseG1GC -XX:MaxGCPauseMillis=200 "
ENV APP_MAIN "com.webank.webase.front.Application"

# start commond
ENTRYPOINT   java ${JAVA_OPTS} -Djdk.tls.namedGroups="secp256k1", -Duser.timezone="Asia/Shanghai" -Djava.security.egd=file:/dev/./urandom, -Djava.library.path=/dist/conf -cp ${CLASSPATH}  ${APP_MAIN}
```

### 4、创建镜像
复制Dockerfile文件到编译后生成的dist目录中，执行创建命令：（注意最后有个点）
```
docker build -f Dockerfile -t webase-front:myself .
```
执行结果：

```
Sending build context to Docker daemon  360.5MB
Step 1/13 : FROM java:8
 ---> d23bdf5b1b1b
Step 2/13 : COPY gradle                /dist/gradle
 ---> Using cache
 ---> db29fdd4e5b9
Step 3/13 : COPY static                /dist/static
 ---> Using cache
 ---> 2c8800ea228a
Step 4/13 : COPY lib                  /dist/lib
 ---> Using cache
 ---> e54620dd3ad3
Step 5/13 : COPY conf                 /dist/conf
 ---> Using cache
 ---> 25725c474e73
Step 6/13 : COPY apps                 /dist/apps
 ---> Using cache
 ---> 60cdf4dd2645
Step 7/13 : COPY sdk                  /dist/sdk
 ---> Using cache
 ---> 19c44108d43a
Step 8/13 : WORKDIR /dist
 ---> Using cache
 ---> 2e00ce9b1744
Step 9/13 : EXPOSE 5002
 ---> Using cache
 ---> 56d3df58bdb1
Step 10/13 : ENV CLASSPATH "/dist/conf/:/dist/apps/*:/dist/lib/*"
 ---> Using cache
 ---> c2bd30292516
Step 11/13 : ENV JAVA_OPTS " -server -Dfile.encoding=UTF-8 -Xmx512m -Xms512m -Xmn256m -Xss512k -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=512m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/log/heap_error.log  -XX:+UseG1GC -XX:MaxGCPauseMillis=200 "
 ---> Using cache
 ---> aefde654d870
Step 12/13 : ENV APP_MAIN "com.webank.webase.front.Application"
 ---> Using cache
 ---> 856a7ec6c2ff
Step 13/13 : ENTRYPOINT   java ${JAVA_OPTS} -Djdk.tls.namedGroups="secp256k1", -Duser.timezone="Asia/Shanghai" -Djava.security.egd=file:/dev/./urandom, -Djava.library.path=/dist/conf -cp ${CLASSPATH}  ${APP_MAIN}
 ---> Using cache
 ---> 1631bbc9f2ac
Successfully built 1631bbc9f2ac
Successfully tagged webase-front:myself
```

查看镜像：

```
docker images
```

```
REPOSITORY                                                  TAG       IMAGE ID       CREATED         SIZE
webase-front                                                myself    1631bbc9f2ac   4 weeks ago     817MB
```

### 5、运行镜像到容器
首先要启动好
运行命令：
```
docker run -d --name WeBASE-Front -v /docker_file/front/dist/log/:/dist/log -p 5002:5002 webase-front:myself
```

查看运行的容器：

```
docker ps
```
```
CONTAINER ID   IMAGE                 COMMAND                  CREATED         STATUS         PORTS                                       NAMES
04db2b9864e3   webase-front:myself   "/bin/sh -c 'java ${…"   3 seconds ago   Up 2 seconds   0.0.0.0:5002->5002/tcp, :::5002->5002/tcp   WeBASE-Front
```
查看日志：

```
tail -f log/WeBASE-Front.log
```

```
[main] INFO  Application() - Started Application in 18.893 seconds (JVM running for 19.618)
[main] INFO  Application() - main run success...
```

浏览器访问页面：http://IP地址:5002/WeBASE-Front
