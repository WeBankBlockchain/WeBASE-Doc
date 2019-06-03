# 常见问题解答

### 一般问题
* 1：执行shell脚本报下面错误permission denied： 

   答：chmod +x 给文件增加权限
   
* 2: gradle build -x test 失败，不能编译Lombok注解
```
...
/data/trans/webase-transcation/src/main/java/com/webank/webase/transaction/trans/TransService.java:175: error: cannot find symbol
                        log.warn("save fail. contract is not deploed", contractAddress);
                        ^
  symbol:   variable log
  location: class TransService
/data/trans/webase-transcation/src/main/java/com/webank/webase/transaction/trans/TransService.java:183: error: cannot find symbol
                                log.warn("call fail. contractAddress:{} abi is not exists", contractAddress);
                                ^
  symbol:   variable log
  location: class TransService
Note: /data/trans/webase-transcation/src/main/java/com/webank/webase/transaction/util/ContractAbiUtil.java uses unchecked or unsafe operations.
Note: Recompile with -Xlint:unchecked for details.
100 errors

FAILURE: Build failed with an exception.
...
```

  答： 修改 build.gradle文件，将以下代码的注释去掉
```
 //annotationProcessor 'org.projectlombok:lombok:1.18.2'
```