title: 启用Win10传统的图片浏览器
date: "2016-02-22 13:03:53"
update: ""
author: me
tags:
- windows
categories:
- windows
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



因为对win10做了清理, 并关闭了审核模式,所以Metro App都不能用,于是新版的图片浏览器也不能用

下面是修改注册表方式

    Windows Registry Editor Version 5.00 
    
    ; Change Extension's File Type 
    [HKEY_CURRENT_USER\Software\Classes\.jpg] 
    @="PhotoViewer.FileAssoc.Tiff" 
    
    ; Change Extension's File Type 
    [HKEY_CURRENT_USER\Software\Classes\.jpeg] 
    @="PhotoViewer.FileAssoc.Tiff" 
    
    ; Change Extension's File Type 
    [HKEY_CURRENT_USER\Software\Classes\.gif] 
    @="PhotoViewer.FileAssoc.Tiff" 
    
    ; Change Extension's File Type 
    [HKEY_CURRENT_USER\Software\Classes\.png] 
    @="PhotoViewer.FileAssoc.Tiff" 
    
    ; Change Extension's File Type 
    [HKEY_CURRENT_USER\Software\Classes\.bmp] 
    @="PhotoViewer.FileAssoc.Tiff" 
    
    ; Change Extension's File Type 
    [HKEY_CURRENT_USER\Software\Classes\.tiff] 
    @="PhotoViewer.FileAssoc.Tiff" 
    
    ; Change Extension's File Type 
    [HKEY_CURRENT_USER\Software\Classes\.ico] 
    
    @="PhotoViewer.FileAssoc.Tiff"
