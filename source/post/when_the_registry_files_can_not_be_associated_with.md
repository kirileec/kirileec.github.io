title: 当注册表文件不能关联时
date: "2013-04-22 17:50:33"
update: ""
author: me
tags:
- windowsserver2012
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




			症状:<br />
注册表文件无法关联,在打开方式里找不到"注册表编辑器"这一项,手动选择C:Windows下的regedit.exe提示无法将该类型和该程序进行关联,但是先打开regedit.exe再手动用菜单导入则正常.<br />
<br />
原因:<br />
<br />
<font style="font-size: 16px;" color="#ED1C24">万恶的权限问题</font><br />
<br />
附带会出现以下附带的情况:<br />
在HKEY_CLASSES_ROOT下新建项,会提示没有权限<br />
并且HKEY_CLASSES_ROOT下会无法找到regfile这一项<br />
<br />
<br />
解决办法:<br />
1)更改C:Windowsregedit.exe文件的高级选项,更改所有者为你自己的用户名或者管理员<br />
2)在HKEY_CLASSES_ROOT这个上面右键&gt;权限,同样更改所有者<br />
3)上一步做完就可以新建项了,新建regfile,再新建shell,再新建open,再新建command,然后双击command的默认,输入&nbsp;<wbr>
<font color="#FF380A">regedit.exe "%1"</font><br />
4)重新设置打开方式<br />
</wbr>
