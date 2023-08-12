title: Delphi奇技淫巧
date: 2017-12-09 19:18:00 +0800
update: ""
author: me
tags:
- Delphi
categories:
- Delphi
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



当一个属性为[]类似的数组访问形式， 并且标记为default时，那么可以不用写Itemsp[], 直接 objs[]这样访问
```delphi
   property Items[const Key:string]:TObject read FGetItem write FSetItem;default;
```

当多个单元同时拥有相同名称的方法或者变量， 并且你在另外一个单元里都引用了这些单元时，就会出问题了
例如: Syncommons这个单元里有大量的和Delphi自带同名的类型， 比如 TStringDynArray

那么如果有一天，你在某个单元里引用了Syncommons， 就会报错， 因为你写的之前的方法所需要的类型并不是Syncommons这个单元里的那个类型（即使它们的定义是一样的）
这时候只需要做一件事 **把Syncommons单元的引用位置移动到最前面** ，因为Delphi的编译器会用后面的单元覆盖前面单元的相同声明
