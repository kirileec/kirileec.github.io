title: C语言头文件及其源文件
date: "2014-03-07 10:42:00"
update: ""
author: me
tags:
- windows
- c
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



C中希望把一段代码，写成头文件的形式，作为后续调用，总不能每次都去粘贴代码吧
 
于是我按照规定写了这么两个文件

####getfilename.h
```c 
char *GetFileName(char *FilePath);

getfilename.c

#include <string.h>
char *GetFileName(char *FilePath)
{
    int len;
    char *current = NULL;
    len = strlen(FilePath);
    for (; len>0; len--)
    if (FilePath[len] == '134')
    {
        current = &FilePath[len + 1];
        break;
    }
    return current;
}
```
然后又写了个测试的
```c
#include <stdio.h>
#include "getfilename.h"

int main ( int argc, char *argv[] )
{
    char *y="45648511226456564C47.pdf";
    printf ( "%sn",GetFileName(y));
    getchar();
    return 0;
}    
```
然后在gvim中按下了F5（一键编译运行），报错了，说找不到GetFileName
怎么会呢
不信又用cl试了一下，还是一样

然后我试着把getfilename.h改成后缀.c

居然可以了，看来是文件包含问题

但是我想不通的是为什么头文件里可以不包含源文件呢，编译器如何找到源文件里的函数的实现部分呢？

终于找到了“容易理解”的说法

[http://www.cnblogs.com/arun/articles/1536803.html](http://www.cnblogs.com/arun/articles/1536803.html)

然后我带着这种说法去visual studio里

这么一放

果然VC会把源文件里所有的.c文件都编译成.obj文件，然后在生成的时候，把他们链接起来，至于.h文件，预编译的时候就已经用掉了。
