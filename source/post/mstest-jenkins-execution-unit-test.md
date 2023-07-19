title: Jenkins MSTest 执行单元测试
date: "2016-09-13 22:06:00"
update: ""
author: me
tags:
- CSharp-WPF-CI
categories:
- CSharp-WPF-CI
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



添加构建 Execute Windows batch Command
```
"C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\MSTest.exe" /testcontainer:"C:\Program Files (x86)\Jenkins\workspace\Saturn-win\bin\Release\Modules\Tests\Saturn.Module.LoginTests2.dll" /resultsfile:G:\www\%BUILD_ID%.trx
```
需要将测试工程的生成目录单独出来
我这里使用生成事件, 将测试工程所需的文件全部拷贝到单独的目录
```
xcopy /y /s /e "$(ProjectDir)bin\$(ConfigurationName)" "$(SolutionDir)bin\$(ConfigurationName)\Modules\Tests\"
```
