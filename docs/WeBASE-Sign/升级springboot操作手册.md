# 升级SpringBoot版本操作手册

## 1 升级jar

修改**build.gradle**配置文件，全局替换以下配置

```
version '1.0'

apply plugin: 'maven'
apply plugin: 'java'
apply plugin: 'idea'
apply plugin: 'eclipse'

sourceCompatibility = 1.8
targetCompatibility = 1.8

[compileJava, compileTestJava, javadoc]*.options*.encoding = 'UTF-8'

// In this section you declare where to find the dependencies of your project
repositories {
    maven { url "http://maven.aliyun.com/nexus/content/groups/public/"}
    maven { url "https://oss.sonatype.org/content/repositories/snapshots" }

    maven { url 'https://dl.bintray.com/ethereum/maven/'}
    mavenLocal()
    mavenCentral()
}

def spring_boot_version="2.5.12"
List springboot =[ 
	"org.springframework.boot:spring-boot-starter-web:$spring_boot_version",
	"org.springframework.boot:spring-boot-autoconfigure:$spring_boot_version",
	"org.springframework.boot:spring-boot-configuration-processor:$spring_boot_version",
	"org.springframework.boot:spring-boot-starter-aop:$spring_boot_version",
    "org.springframework.boot:spring-boot-starter-cache:$spring_boot_version"
]

List swagger = [
    'io.springfox:springfox-swagger2:2.8.0',
    'io.springfox:springfox-swagger-ui:2.8.0'
]

List mysql = [
    'mysql:mysql-connector-java:8.0.22',
    'org.mybatis.spring.boot:mybatis-spring-boot-starter:2.2.2'
]

def log4j_version="2.17.1"
List log4j = [
    "org.apache.logging.log4j:log4j-api:$log4j_version",
    "org.apache.logging.log4j:log4j-core:$log4j_version",
    "org.apache.logging.log4j:log4j-slf4j-impl:$log4j_version",
    "org.apache.logging.log4j:log4j-web:$log4j_version"
]

List jaxb = [
     "javax.xml.bind:jaxb-api:2.3.0",
     "com.sun.xml.bind:jaxb-impl:2.3.0",
     "com.sun.xml.bind:jaxb-core:2.3.0",
     "javax.activation:activation:1.1.1"
]

def jackson_version = "2.13.3"
List jackson = [
    "com.fasterxml.jackson.core:jackson-databind:$jackson_version",
    "com.fasterxml.jackson.core:jackson-annotations:$jackson_version",
    "com.fasterxml.jackson.core:jackson-core:$jackson_version",
    "com.fasterxml.jackson.module:jackson-module-parameter-names:$jackson_version",
    "com.fasterxml.jackson.datatype:jackson-datatype-jdk8:$jackson_version",
    "com.fasterxml.jackson.datatype:jackson-datatype-jsr310:$jackson_version",
]

dependencies {
    compile springboot,swagger,mysql,log4j,jaxb,jackson
//    compile 'org.fisco-bcos.java-sdk:sdk-crypto:2.7.0-SNAPSHOT'
    compile 'org.fisco-bcos.java-sdk:fisco-bcos-java-sdk:2.9.0'
    compile 'org.slf4j:jcl-over-slf4j:1.7.30'
    compile 'org.apache.commons:commons-lang3:3.6'
    compile 'org.projectlombok:lombok:1.18.2'
    compile "org.bouncycastle:bcprov-jdk15on:1.67"
    compile 'javax.validation:validation-api:2.0.1.Final'

    annotationProcessor 'org.projectlombok:lombok:1.18.2'
}

configurations {
    all*.exclude group: 'org.springframework.boot', module: 'spring-boot-starter-logging'
    all*.exclude group: 'org.slf4j', module: 'slf4j-log4j12'
    all*.exclude group: 'log4j', module: 'log4j'
    all*.exclude group: 'com.mchange', module: '*'
}

sourceSets {
	main {
		java {
	        srcDir 'src/main/java'
		}
        resources  {
            srcDir 'src/main/resources'
        }
	}
}

clean {
    delete 'dist'
    delete 'build'
    delete 'log'
}

jar {
	destinationDir file('dist/apps')
	archiveName project.name + '.jar'
	exclude '**/*.xml'
	exclude '**/*.properties'

    doLast {
        copy {
            from file('src/main/resources/')
            into 'dist/conf_template'
        }
		copy {
			from configurations.runtime
			into 'dist/lib'
		}
		copy {
			from file('.').listFiles().findAll{File f -> (f.name.endsWith('.sh') || f.name.endsWith('.env'))}
			into 'dist'
		}
		copy {
		    from file('release_note.txt')
		    into 'dist'
		}
	}
}
```



## 2 修改配置文件

修改配置文件**application.yml**

第一处，修改context-path路径，升级springboot版本以后，需要改成如下

```
server:
  servlet:
    context-path: /WeBASE-Sign
```

第二处修改，如果未修改，启动会报如下错误

```
2022-08-31 13:32:27.817 [main] ERROR SpringApplication() - Application run failed
org.springframework.context.ApplicationContextException: Failed to start bean 'documentationPluginsBootstrapper'; nested exception is java.lang.NullPointerException
```

在spring节点下，新增如下配置

```
 mvc:
    pathmatch:
      matching-strategy: ant_path_matcher
```

## 3 修改类文件

（1）可以将**com.webank.webase.sign.config**报下的**TomcatConfig**文件删除或全部注释

（2）由于升级springboot以后，vo包下的java bean的相关validator的注解不能使用，因为导致类缺失，全部更改为javax包下的注解，需要修改三个类文件

ReqEncodeInfoVo，ReqNewUserVo，ReqSignMessageHashVo

```
/*
 * Copyright 2014-2021 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.webank.webase.sign.pojo.vo;

import javax.validation.constraints.NotBlank;

import lombok.Data;

/**
 * ReqEncodeInfoVo.
 */
@Data
public class ReqEncodeInfoVo {
    @NotBlank(message = "signUserId cannot be empty")
    private String signUserId;
    @NotBlank(message = "encodedDataStr cannot be empty")
    private String encodedDataStr;
}

```

```
/**
 * Copyright 2014-2021 the original author or authors.
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.webank.webase.sign.pojo.vo;

import javax.validation.constraints.NotBlank;

import lombok.Data;

/**
 * import private key entity
 * @author marsli
 */
@Data
public class ReqNewUserVo {
	@NotBlank
	private String signUserId;
	@NotBlank
	private String appId;
	private Integer encryptType;
	/**
	 * encoded by base64
	 */
	private String privateKey;
}

```

```
/*
 * Copyright 2014-2021 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.webank.webase.sign.pojo.vo;

import javax.validation.constraints.NotBlank;

import lombok.Data;

/**
 * ReqHashSignVo.
 */
@Data
public class ReqSignMessageHashVo {
    @NotBlank(message = "signUserId cannot be empty")
    private String signUserId;
    @NotBlank(message = "hashStr cannot be empty")
    private String messageHash;
}

```

