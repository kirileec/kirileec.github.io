title: '[git].gitignore cannot ignore the specific dir or file'
date: "2016-12-30 09:07:32"
update: ""
author: me
tags:
- git
categories:
- git
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



I had already added `obj/Debug` to  `.gitignore`,
however, files in this path are still in file list that to be committed

If you want to ignore `obj/Debug` dir, which should be confirmed first is `obj/Debug` is not already under version control.
So.
```git
git rm -r --cached obj/Debug 
```
