title: win8 右键菜单---添加一个按住shift才会显示的右键菜单
date: "2013-01-14 17:38:48"
update: ""
author: me
tags:
- 杂谈
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




			windows的注册表真是博大精深啊，以下是折腾过程：
<div><br /></div>
<div>HKEY_LOCAL_MACHINESOFTWAREClassesFoldershell</div>
<div>
HKEY_LOCAL_MACHINESOFTWAREClassesDirectorybackgroundshell</div>
<div><br /></div>
<div>以上两个，第一个是文件夹的右键菜单，后一个是文件夹背景的右键菜单（平时右键刷新的时候看到的那个）</div>
<div><br /></div>
<div>只要</div>
<div>在这两个位置新建一个项，命名为你自己喜欢的，</div>
<div>选中这个项，再新建一个项，命名为“command”（无引号，在英文输入状态下输入），</div>
<div>双击右侧的默认，改值为你希望显示的文字。</div>
<div>选中前面的command项，然后双击右侧的默认，改为，程序绝对路径+空格+“%V”。（英文输入状态）</div>
<div>如
&nbsp;<wbr>D:LeanKeyTooltoolTotalCMDTotalcmd64.exe
"%V"</wbr></div>
<div>这样这个菜单项就会显示了，即时生效。</div>
<div><br /></div>
<div>然后是按住shift才显示</div>
<div>
只要在你选中新建的这个项，在右侧新建两个字符串值，分别命名为Extended和NoWorkingDirectory。完成。</div>
<div><br /></div>
<div>附带几个位置</div>
<div>HKEY_CLASSES_ROOT*shell &nbsp;<wbr>
&nbsp;</wbr><wbr>所有文件的右键菜单</wbr></div>
<div>HKEY_CLASSES_ROOTexefileshell &nbsp;<wbr>
.exe文件的右键菜单</wbr></div>
<div>HKEY_CLASSES_ROOTDirectoryshell &nbsp;<wbr>
目录的右键菜单</wbr></div>
<div><br /></div>
<div><br /></div>
<div><br /></div>
<div><br /></div>
<div><br /></div>
<div><br /></div>
