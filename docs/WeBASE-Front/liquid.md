
# Liquid配置

## 安装rust

```bash

# 结尾追加export使用镜像源
$ vi /etc/profile

export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup


# 此命令将会自动安装 rustup，rustup 会自动安装 rustc 及 cargo
$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

Rust is installed now. Great!

To get started you may need to restart your current shell.
This would reload your PATH environment variable to include
Cargo's bin directory ($HOME/.cargo/bin).

# 执行一次source使环境变量生效
$ source $HOME/.cargo/env
```

#### 检查版本
检查rustc和cargo版本，确认安装成功
```bash
$ rustc --version

$ cargo --version
```

#### 此外需要安装以下工具链组件：

```bash
$ rustup toolchain install nightly-2021-06-23 --component rust-src rustc-dev llvm-tools-preview
$ rustup default nightly-2021-06-23
$ rustup target add wasm32-unknown-unknown
```


> 如果当前网络无法访问Rustup官方镜像，请参考 Rustup 镜像安装帮助 更换镜像源。
https://mirrors.tuna.tsinghua.edu.cn/help/rustup/


#### cargo 更换镜像源

```bash
# 编辑cargo配置文件，若没有则新建
$ vim $HOME/.cargo/config

[source.crates-io]
registry = "https://github.com/rust-lang/crates.io-index"
replace-with = 'ustc'
[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"
```

#### 确保配置 cmake 环境，Linux可以通过以下命令安装：

要求安装 cmake 3.12及以上版本，gcc 7及以上版本
```bash

# CentOS请执行下面的命令
$ sudo yum install cmake3
# Ubuntu请执行下面的命令
$ sudo apt install cmak
```

如果centos的yum资源无cmake3，则需要手动下载cmake3进行配置

以下载cmake 3.21.3版本为例，到cmake官网下载包后，解压到目录如/data/home/webase目录，并修改/etc/profile，设置cmake环境变量
```bash

$ vi /etc/profile

export CMAKE3_HOME=//data/home/webase/cmake-3.21.3-linux-x86_64
export PATH=$PATH:$CMAKE3_HOME/bin

# 环境变量生效
source /etc/profile
```

#### 安装 cargo-liquid
安装前，如果使用的是centos，执行下文命令以确保依赖符合要求，具体可参考[Cargo-Liquid issue 14](https://github.com/WeBankBlockchain/cargo-liquid/issues/14)
```bash
#请确保cmake版本大于3.12
#请参考下述命令使用gcc7
$ sudo yum install -y epel-release centos-release-scl
$ sudo yum install -y devtoolset-7

# 启用devtool
$ source /opt/rh/devtoolset-7/enable

# 参考下述命令使用要求版本的rust工具链
$ rustup toolchain install nightly-2021-06-23 --component rust-src rustc-dev llvm-tools-preview
$ rustup default nightly-2021-06-23
```

确保上述工具版本符合要求后，并执行以上命令尝试安装：

cargo-liquid 是用于辅助开发 Liquid 智能合约的命令行工具，在终端中执行以下命令安装：

```bash

# 通过gitee 安装
$ cargo install --git https://gitee.com/WeBankBlockchain/cargo-liquid --tag v1.0.0-rc2 --force

# 通过github安装
$ cargo install --git https://github.com/WeBankBlockchain/cargo-liquid --tag v1.0.0-rc2 --force   
```

开始安装后：
```bash

Updating git repository `https://gitee.com/WeBankBlockchain/cargo-liquid`
Installing cargo-liquid v1.0.0-rc2 (https://gitee.com/WeBankBlockchain/cargo-liquid?tag=v1.0.0-rc2#5da4da65)
Updating `git://mirrors.ustc.edu.cn/crates.io-index` index
Fetch [=======>                 ]  34.20%, 5.92MiB/s
```
    

如果下载crates失败，可重新执行cargo install命令**重试**下载


执行成功后
```bash

Compiling wabt v0.10.0
Finished release [optimized] target(s) in 1m 33s
Installing /data/home/webase/.cargo/bin/cargo-liquid
Installing /data/home/webase/.cargo/bin/liquid-analy
Installed package `cargo-liquid v1.0.0-rc2 (https://gitee.com/WeBankBlockchain/cargo-liquid?tag=v1.0.0-rc2#5da4da65)` (executables `cargo-liquid`, `liquid-analy`)
```

至此liquid依赖安装完成

#### wasm-opt优化.wasm文件大小

安装 Binaryen（可选，推荐安装，优化编译）

Binaryen 项目中包含了一系列 Wasm 字节码分析及优化工具，其中如 wasm-opt 等工具会在 Liquid 智能合约的构建过程中使用。请参考其官方文档。https://github.com/WebAssembly/binaryen#building

除根据官方文档的编译安装方式外，
- Ubuntu下可通过 `sudo apt install binaryen` 下载安装（如使用Ubuntu，则系统版本不低于20.04） 
- 其他操作系统可参照此处查看是否可直接通过包管理工具安装 https://pkgs.org/download/binaryen
- Mac下可直接通过 `brew install binaryen` 下载安装binaryen。

下面介绍CentOS安装方式：
```bash
# 下载其rpm包
$ wget https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/b/binaryen-104-1.el7.x86_64.rpm
# 安装rpm包
$ sudo rpm -ivh binaryen-104-1.el7.x86_64.rpm
```

## 例子：HelloWorld

以简单的 HelloWorld 合约为示例，帮助读者快速建立对 Liquid 合约的直观认识。

```
#![cfg_attr(not(feature = "std"), no_std)]

use liquid::storage;
use liquid_lang as liquid;

#[liquid::contract]
mod hello_world {
    use super::*;

    #[liquid(storage)]
    struct HelloWorld {
        name: storage::Value<String>,
    }

    #[liquid(methods)]
    impl HelloWorld {
        pub fn new(&mut self) {
            self.name.initialize(String::from("Alice"));
        }

        pub fn get(&self) -> String {
            self.name.clone()
        }

        pub fn set(&mut self, name: String) {
            self.name.set(name)
        }
    }

    #[cfg(test)]
    mod tests {
        use super::*;

        #[test]
        fn get_works() {
            let contract = HelloWorld::new();
            assert_eq!(contract.get(), "Alice");
        }

        #[test]
        fn set_works() {
            let mut contract = HelloWorld::new();

            let new_name = String::from("Bob");
            contract.set(new_name.clone());
            assert_eq!(contract.get(), "Bob");
        }
    }
}
```
