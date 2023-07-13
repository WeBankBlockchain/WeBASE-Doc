## 使用Docker部署WeBASE-Front服务 

### 1、配置镜像源
创建或修改 /etc/docker/daemon.json 文件，内容如下：
```
{
    "registry-mirrors": [
        "http://hub-mirror.c.163.com",
        "https://docker.mirrors.ustc.edu.cn",
        "https://registry.docker-cn.com"
    ]
}
```
重启docker服务：

```
service docker restart
```



### 2、拉取webase-front镜像
拉取命令：
```
docker pull webasepro/webase-front
```
执行结果：

```
Using default tag: latest
latest: Pulling from webasepro/webase-front
25fa05cd42bd: Pull complete 
a67ba6b28d8a: Pull complete 
4bdf98e06c11: Pull complete 
2d85efc5eaf2: Pull complete 
a667039d379f: Pull complete 
dbe9e6d88803: Pull complete 
4581dee6fb48: Pull complete 
36449df65590: Pull complete 
Digest: sha256:126eee0f940d3ea9e08150a9896c57648d8eb8bab9eb4efd90930c4ec8ad5423
Status: Downloaded newer image for webasepro/webase-front:latest
docker.io/webasepro/webase-front:latest
```
查看拉取的镜像：

```
docker images
```

```
REPOSITORY                                                  TAG       IMAGE ID       CREATED         SIZE
webasepro/webase-front                                      latest    a2d3effc01d9   12 months ago   610MB
```

### 3、运行镜像
执行命令：

```
docker run -d --name WeBASE-Front -v /docker_file/front/dist/log/:/dist/log -p 5002:5002 webasepro/webase-front:latest
```
查看容器状态：

```
docker ps -a
```

```
CONTAINER ID   IMAGE                           COMMAND                  CREATED          STATUS                      PORTS                                       NAMES
da20cddd5379   webasepro/webase-front:latest   "/bin/sh -c 'cp -r /…"   15 seconds ago   Exited (1) 14 seconds ago                                               WeBASE-Front
```
未启动成功，查看日志：

```
docker logs da20cddd5379
```
报以下错误：
```
cp: cannot stat '/dist/sdk/*': No such file or directory
```

### 4、自己构建镜像
#### （1）、编译代码修改配置
  按照 [交易部署说明](https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/install.html)（链接[https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/install.html](https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/install.html)）完成到第4步，主要需要修改的是“//连接节点的监听ip” 和 “//配置所连节点的绝对路径，用于监控节点配置与日志” 这两个配置，确保地址正确和可连接。
  
  
#### （2）、修改Dockerfile文件
进入到WeBASE-Front\docker\build目录，修改Dockerfile文件，修改后内容如下：
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

#### （3）、创建镜像
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

#### （4）、运行镜像到容器
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
