title: GitLab+Jenkins 构建WPF持续集成环境
date: "2016-09-12 21:00:00"
update: ""
author: me
tags:
- CSharp-WPF
categories:
- CSharp-WPF
topic: ""
cover: ""
draft: false
preview: ""
top: false
type: ""
hide: false
toc: false
image: ""
subtitle: ""
config: {}


---



## Gitlab搭建

> https://github.com/beginor/gitlab-ce

先安装说明把image pull下来

```
sudo mkdir -p /gitlab/etc
sudo mkdir -p /gitlab/log
sudo mkdir -p /gitlab/data
```
创建对应的映射文件, 这样可以把重要的文件保存在容器外面

```
docker run \
    --detach \
    --publish 8443:443 \
    --publish 8180:80 \
    --publish 2222:22 \
    --hostname 192.168.1.206 \
    --name gitlab \
    --restart unless-stopped \
    --volume /gitlab/etc:/etc/gitlab \
    --volume /gitlab/log:/var/log/gitlab \
    --volume /gitlab/data:/var/opt/gitlab \
    beginor/gitlab-ce
```

跑起来之后需要较长一段时间启动, 启动完成之前会一直提示502错误, 属于正常情况

## Jenkins

由于是Windows下的编译, 因此直接下载Jenkins的Win安装包进行安装, 安装完成之后, 访问`http://localhost:8080`即可, 先安装一些推荐的插件, 暂时不要自定义, 因为一不小心就装了很多, 会需要很长时间去安装

安装必须的插件
Git plugin
MSBuild Plugin
MSTestRunner plugin


配置Git源码管理,例如
`git@192.168.1.206:linx/saturn.git`
然后 添加`Credentials`
选择如下

SSH Username with private key
`Username` linx
`Private Key` 
`Enter directly` 直接粘贴私钥(注意不是公钥)
分支可以自己填
*/develop

构建触发器, 选择`Poll SCM`
日程表填写
```
H/2 * * * *
```
或者
```
* * * * *
```

这样表示定时检查代码库的更新, 前者为2分钟一次, 后者是1分钟

然后到 http://127.0.0.1:8080/configureTools/
配置`MSBuild`, `Name`随便填, `Path To MSBuild` 填写 `C:\Program Files (x86)\MSBuild\14.0\Bin\`

同样的, 配置好`MSTest`, 路径一般是
`C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\`
以上是Visual Studio 2015的路径


回到工程配置
##### 构建
- 添加 `Execute Windows batch command`
`nuget.exe restore XXX.sln`
这一步可以将解决方案的包还原, 需要手动将`nuget.exe`拷贝到解决方案根目录或者环境变量的目录下

- 添加`Build a Visual Studio project or solution MSBuild`
`MSBuild Version`选择刚添加的 `MSBuild 4.5`
`MSBuild Build File` 填写解决方案的名称
`Command Line Arguments` 填写 `/t:Build /p:Configuration=Release`

最后保存之后, 回到工程界面, 点击立即构建, 测试一下是否正常

这样添加好之后, 就可以在Gitlab上推送的时候,自动触发编译

然后还需要添加一些东西, 暂时还没有落实

- 自动修改工程的版本号, 使编译出来的成品的版本号自动变化
- 调用MSTest执行单元测试
- 测试结果正常的情况下, 将构建的文件转移到发布服务器或者测试服务器, 或者进行打包成安装包
- 全部流程完成之后, 对git进行打tag标记所有源码, 以便以后根据tag生成所需要的版本的全部内容
- 流程成功或者失败, 都发送文件到指定的邮箱地址, 通知相关人
- 生成报告发布到报告web服务器, 以供查看
