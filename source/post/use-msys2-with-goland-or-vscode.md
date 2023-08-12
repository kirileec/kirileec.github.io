title: Use Msys2 With Goland or Vscode
date: 2019-11-14 08:54:58 +0800
update: ""
author: linx
tags:
- go
categories:
- go
topic: ""
cover: ""
draft: false
preview: ""
top: false
type: ""
hide: false
toc: true
image: ""
subtitle: ""
config: {}


---


Use msys2 as integrated shell
<!--more-->

## VSCode

First, use `Everything` to search `msys2_shell.cmd` and get the full path. My path is long because I install msys2 by using scoop.
Then, add config to VSCode setting.json file

```json
"terminal.integrated.shell.windows": "path\\to\\msys2_shell.cmd",
"terminal.integrated.shellArgs.windows": ["-defterm", "-msys2", "-no-start", "-here"],
```

## Goland

Go to `Setting`->`Tools`->`Terminal`->`Shell Path` and use string as follow

```shell
"path\\to\\msys2_shell.cmd" -defterm -msys2 -no-start -here
```

---
You can also change param `-msys2` to `-mingw64` which you like.
