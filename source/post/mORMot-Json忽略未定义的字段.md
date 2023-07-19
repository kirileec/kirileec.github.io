title: mORMot Json忽略未定义的字段
date: "2018-10-31 09:00:43"
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



默认状态下, mORMot的SynCommon.pas单元的JSON反序列化会需要保证JSON中的字段和声明的结构体是一致的
例如,

```json
{"a":1,"b":2}
```

是不能被反序列化到下面这个结构体的

```pascal
TTest = record
  a:Integer;
end;
```

在官方博客有篇帖子提到这样的需求 [链接](http://blog.synopse.info/post/2013/12/10/JSON-record-serialization)

使用 `soReadIgnoreUnknownFields` 选项即可让反序列化忽略不存在的字段 

```pascal
TTextWriter.RegisterCustomJSONSerializerFromText(TypeInfo(TTestCustomJSONGitHub),
    __TTestCustomJSONGitHub).Options := [soReadIgnoreUnknownFields,soWriteHumanReadable]
```

> - soReadIgnoreUnknownFields to ignore any non defined field in the incoming JSON;
> - soWriteHumanReadable to let the output JSON be more readable.

不过一般使用的时候, 对于这种的需求还是很大的, 如果有个JSON, 里面有几十个字段, 而且还疯狂嵌套, 那简直是要疯了

于是, 直接在源码上进行修改, 以永久实现这个功能

在`SynCommon.pas` 文件搜索 `TJSONRecordAbstract.Create`, 并增加一行

```pascal
  fItems := TObjectList.Create;
  Options := [soReadIgnoreUnknownFields, soWriteHumanReadable];
```

这样就可以实现, 默认忽略字段, 并且输出JSON时是可读性更好的已展开的JSON

最后, 为保证这个修改可以一直生效, 可以使用自己的GIT仓库, 把这个修改提交到自己的仓库中. 就像这样

origin/master 对应官方的仓库
origin2/master 对应自己本地的仓库 

origin2中包含这个自定义的修改, 以后官方有修改了, 就先拉取一下origin, 然后推送到origin2, 那么以后要用代码了就从origin2克隆一份就行了
