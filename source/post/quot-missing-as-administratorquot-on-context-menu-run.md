title: Missing &quot;Run as Administrator&quot; on Context Menu
date: "2016-07-28 08:47:00"
update: ""
author: me
tags:
- WINDOWS
categories:
- WINDOWS
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



右键菜单中的 以管理员身份运行 消失

refer to 
> http://www.sevenforums.com/tutorials/200558-run-administrator-add-remove-context-menu-windows-7-a.html

here is the registry file content

```reg
Windows Registry Editor Version 5.00

; Created by: Shawn Brink
; http://www.sevenforums.com
; Tutorial:  http://www.sevenforums.com/tutorials/200558-run-administrator-add-remove-context-menu-windows-7-a.html


; For .bat file extention
[-HKEY_CLASSES_ROOT\batfile\shell\runas]

[HKEY_CLASSES_ROOT\batfile\shell\runas]
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\batfile\shell\runas\command]
@=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
  00,5c,00,53,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,63,00,6d,00,\
  64,00,2e,00,65,00,78,00,65,00,20,00,2f,00,43,00,20,00,22,00,25,00,31,00,22,\
  00,20,00,25,00,2a,00,00,00



; For .cmd file extention
[-HKEY_CLASSES_ROOT\cmdfile\shell\runas]

[HKEY_CLASSES_ROOT\cmdfile\shell\runas]
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\cmdfile\shell\runas\command]
@=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
  00,5c,00,53,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,63,00,6d,00,\
  64,00,2e,00,65,00,78,00,65,00,20,00,2f,00,43,00,20,00,22,00,25,00,31,00,22,\
  00,20,00,25,00,2a,00,00,00



; For .cpl file extention
[-HKEY_CLASSES_ROOT\cplfile\shell\runas]

[HKEY_CLASSES_ROOT\cplfile\shell\runas]
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\cplfile\shell\runas\command]
@=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
  00,5c,00,53,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,72,00,75,00,\
  6e,00,64,00,6c,00,6c,00,33,00,32,00,2e,00,65,00,78,00,65,00,20,00,73,00,68,\
  00,65,00,6c,00,6c,00,33,00,32,00,2e,00,64,00,6c,00,6c,00,2c,00,43,00,6f,00,\
  6e,00,74,00,72,00,6f,00,6c,00,5f,00,52,00,75,00,6e,00,44,00,4c,00,4c,00,41,\
  00,73,00,55,00,73,00,65,00,72,00,20,00,22,00,25,00,31,00,22,00,2c,00,25,00,\
  2a,00,00,00



; For .exe file extention
[-HKEY_CLASSES_ROOT\exefile\shell\runas]

[HKEY_CLASSES_ROOT\exefile\shell\runas]
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\exefile\shell\runas\command]
@="\"%1\" %*"
"IsolatedCommand"="\"%1\" %*"



; For .msc file extention
[-HKEY_CLASSES_ROOT\mscfile\shell\RunAs]

[HKEY_CLASSES_ROOT\mscfile\shell\RunAs]
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\mscfile\shell\RunAs\command]
@=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
  00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,6d,00,6d,00,\
  63,00,2e,00,65,00,78,00,65,00,20,00,22,00,25,00,31,00,22,00,20,00,25,00,2a,\
  00,00,00
```

Copy it and Save it as a *.reg file, then check the context menu! It's helpful to me
