title: win8无法拖拽文件打开
date: "2012-12-20 12:17:02"
update: ""
author: me
tags:
- win8
- other
categories:
- other
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




			问题描述：在用restorator还有Photoshop等软件的时候，因为这软件无法在普通账户权限下运行（无法写C盘的目录，PS直接启动就报错），但是使用了管理员权限运行之后，另一个问题出现了，无法拖拽文件。但是restorator在普通权限的时候是可以拖拽的。
<div><br /></div>
<div>处理问题过程：</div>
<div>
百般搜索，终于找到了“肇事者”，对，就是win8本身的资源管理器。默认情况下，使用普通账户登录时运行的资源管理器不具备“管理员权限”，而在此时进行拖拽，会直接被忽略！！！</div>
<div>
经测试，结束explorer进程之后，以系统权限建立“explorer.exe”任务之后，可以成功拖拽。但是这时一个问题出现了，win8的开始界面是包含在explorer.exe这个进程里的，而metroAPP是无法在管理员权限下运行的，这主要是为了保证应用程序的安全性而设计的。真心懒得吐槽这渣一般的设定了</div>
<div><br /></div>
<div>于是尝试在已经存在explorer.exe的情况下建立一个新的具有管理员权限的资源管理器，失败！！！！</div>
<div>Windows下不存在ubuntu下的那个nautilus模式，即只会同时存在一个资源管理器。</div>
<div><br /></div>
<div>那么，提出以下解决办法：</div>
<div>
1）在administrator账户下进行工作，具体开启方法自己去找。然后寻找在administrator下正常运行metro应用的方法。（此法没什么意思的，觉得还是微软的能自动同步配置的账号比较好，而且权限的更改风险大，除非你做好了重装的准备）</div>
<div>2）使用一个第三方的资源管理器。如Totalcommander，此类工具可以很容易就在管理员权限下运行。</div>
<div>
3）在你需要进行拖拽工作的时候，结束explorer进程，新建一个有权限的，然后暂时放弃metro应用的使用，用完再切换回来。（此法，也许比较好，如果能够使用程序将这两个操作整合为两个按钮事件，进行傻瓜化的操作，那么有值得一试的价值）</div>
