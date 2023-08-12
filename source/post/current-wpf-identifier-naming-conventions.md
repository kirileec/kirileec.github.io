title: 目前使用的WPF代码规范
date: "2016-12-24 21:16:12"
update: ""
author: me
tags:
- CSharp-WPF
categories:
- CSharp-WPF
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



## 标识符大小写命名
### 定义
本文使用以下简称
`Pascal`: Delphi的命名方式, 所有单词均为首字母大写, 其它字母小写, 不使用下划线,但可以使用点
`Camel`: 驼峰命名法 首个单词首字母小写, 其它单词遵循`Pascal`规则

|标识符|大小写|备注|
|-----|------|----|
|命名空间|Pascal||
|类|Pascal||
|接口|Pascal|以 "I" 开头|
|方法/函数|Pascal||
|属性|Camel||
|事件|Pascal||
|私有字段|Camel|以 "_" 开头|
|非私有字段|Camel||
|枚举|Pascal||
|参数|Camel||
|局部变量|Camel||
|泛型类型|Pascal|以 "T" 开头|
|集合类型|Pascal|以 "s" 结尾表示为复数|

## 目录布局
### 解决方案下的布局
注意: 目录应该是实际存在的目录, 即先实际建立目录再到VS里添加或者创建相关项目, 如果直接在VS里创建目录那么这个创建的目录是虚的.所有目录名可以加上项目的名称, 中间以点分隔. 另外特别注意 ####不要使用奇怪的文件夹, 例如`Methods Function` ####

`Infrastructure`: 基础设施, 存放多个模块公用的类库, 例如 `Common`类库就存放在这个目录下, 
`Doc`: 存放相关文档
`Modules`: 存放各个子模块
`ThirdParties`: 存放第三方类库, 例如自己修改过或实现了新特性的类库, 还有一些不在Nuget上存放的包, 以及一些其它人写的通用的类库, 该目录下的类库应该全部托管到git的仓库, 然后以子模块的形式加载到解决方案中

`README.md`: 写一些项目总体的描述和一些开发环境设置的教程

### 模块下目录布局
`Services`: 服务, 存放所有用到的服务类, 包括发起HTTP请求的类, 封装的函数也可以放在这里
`ViewModels`: 视图模型类, 目前暂时把 模块主视图`ModuleViewModel`和其它显示视图模型`ClassViewModel`都放在这里, 其实也可以把这两个分开,但因为一般一个模块只有一个主视图, 就懒得分开了
`Models`: 模型, 基础的模型, 在REST应用中, 这里存放和后台DTO对应的Model, 当然如果这个Model在多个模块中使用, 那么应该独立出来放到单独的一个 Api 类库下的Model文件夹中, 并以Model的作用以文件夹进行归类
`Views`: 视图, 嗯, 所有界面相关的都扔这里吧
`Constants`: 放一些常量
`Helpers`: 辅助类, 例如 `ValidationRule` 这种
`Extensions`: 扩展类, 一般也就放点扩展方法吧
`Enums`: 枚举类放在这个里面
`Converters`: WPF绑定用的转换器
`Selectors`: 模板选择器
`Resources`: 图像/静态资源
`Events`: Prism使用的事件消息
