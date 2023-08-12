title: Delphi 合并BPL 摔的坑
date: "2015-12-31 21:22:59"
update: ""
author: me
tags:
- 合并bpl
- delphi
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



首先是DevExpress的合并

1. 必须要经历的过程，手动编译安装DevExpress的所有包，需要保证直接`右键` -> `工程组` -> `build all`->多选`dcl`开头的包->'Install',这个过程可以一气呵成地完成，否则进行调整包的顺序，当然`安装`这个不是硬性要求，因为合并bpl并不是合并设计期包而是运行期包。总之，最终得到的就是DevExpress的包顺序了。

2. 提取所有`dpk`的`contains`部分的单元按照顺序放入新的dpk中，如果编译后提示需要add什么东西，那么是因为`那个包的单元没有放全`，保持成dxpack.dpk之类的名字，工程配置如下

> RELEASE 
> Description: `Runtime Only` && `Explicit rebuild`
> Unit Scope: ADD `vcl` `vcl.imaging` `Bde` `vcl.shell` etc. if some unit not found

3. 实际使用工程一个大的工程进行测试，因为我发现虽然可以编译但不是随便一个工程带上上面出来的包就可以正常运行的，会报各种恶心的内存错误，于是需要进行下一步

4. 尝试注释一部分单元，然后再慢慢加回来，如果发现无法继续加入，那么，重新建一个dpk讲剩下的单元放到新的包里，requires里写上dxpack，这样这两个包就是一体的了，然后会发现居然正常不报错了


Delphi XE8 rtl vcl包的合并

待更新
