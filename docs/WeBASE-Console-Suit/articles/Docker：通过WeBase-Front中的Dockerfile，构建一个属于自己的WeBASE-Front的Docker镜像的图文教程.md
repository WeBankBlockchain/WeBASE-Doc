## Docker��ͨ��WeBase-Front/Docker/Build�е�Dockerfile������һ�������Լ���WeBASE-Front��Docker�����ͼ�Ľ̳�


### 1����������޸�����
  ���� [���ײ���˵��](https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/install.html)������[https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/install.html](https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/install.html)����ɵ���4������Ҫ��Ҫ�޸ĵ��ǡ�//���ӽڵ�ļ���ip�� �� ��//���������ڵ�ľ���·�������ڼ�ؽڵ���������־�� ���������ã�ȷ����ַ��ȷ�Ϳ����ӡ�

### 2���鿴Dockerfile�ļ�

���뵽WeBASE-Front\docker\buildĿ¼���鿴Dockerfile�ļ�
```
vim Dockerfile
```
�������£�

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
������������е�������ʱ�򣬻ᱨ�����������
```
cp: cannot stat '/dist/sdk/*': No such file or directory
```
���Զ����Dockerfile�ļ�����һ���޸ġ�


### 3���޸�Dockerfile�ļ�
�޸ĺ��������£�
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

### 4����������
����Dockerfile�ļ�����������ɵ�distĿ¼�У�ִ�д��������ע������и��㣩
```
docker build -f Dockerfile -t webase-front:myself .
```
ִ�н����

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

�鿴����

```
docker images
```

```
REPOSITORY                                                  TAG       IMAGE ID       CREATED         SIZE
webase-front                                                myself    1631bbc9f2ac   4 weeks ago     817MB
```

### 5�����о�������
����Ҫ������
�������
```
docker run -d --name WeBASE-Front -v /docker_file/front/dist/log/:/dist/log -p 5002:5002 webase-front:myself
```

�鿴���е�������

```
docker ps
```
```
CONTAINER ID   IMAGE                 COMMAND                  CREATED         STATUS         PORTS                                       NAMES
04db2b9864e3   webase-front:myself   "/bin/sh -c 'java ${��"   3 seconds ago   Up 2 seconds   0.0.0.0:5002->5002/tcp, :::5002->5002/tcp   WeBASE-Front
```
�鿴��־��

```
tail -f log/WeBASE-Front.log
```

```
[main] INFO  Application() - Started Application in 18.893 seconds (JVM running for 19.618)
[main] INFO  Application() - main run success...
```

���������ҳ�棺http://IP��ַ:5002/WeBASE-Front








