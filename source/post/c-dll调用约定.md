title: C++ DLL调用约定
date: "2014-03-19 21:56:00"
update: ""
author: me
tags:
- windows
- c++
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



先看一段代码
```c
#define DLL_API __declspec(dllexport)
#pragma comment(linker,"/export:file=_file@4")
extern "C" DLL_API char * __stdcall file(char *FilePath)
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

这是在Visual Studio 2013环境下的C++ DLL的一个函数的代码
函数作用为取出一段路经的文件名带上后缀
首先第一行，把`__declspec(dllexport)`这么长的一个家伙缩减一下

第二行重命名函数，
`extern "C"` 表示下面的代码将用C的标准进行编译链接
`__declspec(dllexport)`表示这个函数为导出函数
`__stdcall` 是一种调用约定，很多其他的语言或者IDE都支持这种调用方式
还有一种`__cdecl`，当不加`__stdcall`时，默认，即C的调用约定

然后说说`__stdcall`,当使用这种方式约定函数时，编译器会对函数名进行格式化，比如上面这个，本来的函数名是file，当编译之后，用导出函数查看器一看，成了`_file@4`，被加上了两部分，一个是前面的下划线，另一个是后面的@4 ，这个应该是表示参数的信息的，如果用C++（即不加`extern "C"`），那么前面会是一个？号，后面会有一些表示函数参数数据类型之类的“乱码”

所以这句就很有必要了
```c
#pragma comment(linker,"/export:file=_file@4")
```

等号前后分别改为“原函数名”和“导出函数名”，当然导出函数函数要先编译一次了，如果函数很多个的话，就用*.def文件进行，我是暂时用不到了。

加上这句之后，会出现两个导出函数`_file@4`和`_file`，也不知道是怎么个情况，下划线还存在，待我后续继续研究
