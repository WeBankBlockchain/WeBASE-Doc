# 配置教程 | Ubuntu环境安装Java教程

```
# 安装默认Java版本(Java 8或以上)
sudo apt install -y default-jdk
# 查询Java版本
java -version

# 在使用默认安装的jdk无法启动时可以参考以下,换一个版本的jdk试试
# 如果上述default-jdk无法使用，可尝试安装oracle Java版本(Java 8或以上，默认的openjdk无法启动webase的特殊情况的时候可以考虑更换用oracle版本的jdk)
sudo apt-get install oracle-java8-installer

配置Java Home环境，编辑/etc/profile文件
$ vim /etc/profile
在该文件的末尾加上如下部分：
JAVA_HOME=/usr/local/java/jdk1.8.0_66(安装路径)
PATH=$PATH:$HOME/bin:$JAVA_HOME/bin
export JAVA_HOME
export PATH

生效profile
$ source /etc/profile

查询Java版本
java -version
echo $JAVA_HOME
```