# MJAppTools
处理iOS APP信息的命令行工具



## 目前已有的功能

- 彩色打印 + 正则搜索
  - 列出用户安装的所有应用
  - 列出用户安装的所有加壳应用
  - 列出用户安装的所有脱壳应用
- 应用信息
  - 应用名称
  - Bundle Identifier
  - Bundle URL
  - 架构信息（Architecture）
    - 架构名称（Architecture Name）
    - 加壳信息（Cryptid）




## 安装

### 1、下载MJAppTools项目

![](https://images2017.cnblogs.com/blog/497279/201801/497279-20180128160423850-1514904706.png)



### 2、编译

- **make**（或者用Xcode打开项目**Command+B**编译一下）

![](https://images2017.cnblogs.com/blog/497279/201801/497279-20180128160439272-1085020939.png)

- 生成命令行工具

![](https://images2017.cnblogs.com/blog/497279/201801/497279-20180128160450287-718908728.png)



### 3、将命令行工具存放到手机的/usr/bin目录

![](https://images2017.cnblogs.com/blog/497279/201801/497279-20180128160456444-2037015854.png)



### 4、在手机上设置可执行权限

```shell
chmod +x /usr/bin/MJAppTools
```

![](https://images2017.cnblogs.com/blog/497279/201801/497279-20180128160514569-571116137.png)



### 5、开始使用MJAppTools

![](https://images2017.cnblogs.com/blog/497279/201801/497279-20180128160520912-1432195115.png)



## 用法

### 搜索用户安装的所有应用

![](https://images2017.cnblogs.com/blog/497279/201801/497279-20180128221025584-441116962.png)

### 支持正则搜索
- 搜索名称
  ![](https://images2017.cnblogs.com/blog/497279/201801/497279-20180128221554725-1505248222.png)

- 搜索ID
  ![](https://images2017.cnblogs.com/blog/497279/201801/497279-20180128221635897-1734040701.png)

- 搜索路径
  ![](https://images2017.cnblogs.com/blog/497279/201801/497279-20180129014550003-918385208.png)
