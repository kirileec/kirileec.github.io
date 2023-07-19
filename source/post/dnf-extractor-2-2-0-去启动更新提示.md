title: DNF Extractor 2.2.0 去启动更新提示
date: "2014-11-01 20:42:00"
update: ""
author: me
tags:
- 汇编
categories:
- 汇编
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



- 【文章标题】: DNF Extractor 2.2.0 去更新提示

- 【文章作者】: kirile

- 【软件名称】: DNF Extractor

【软件大小】: 724 KB

【下载地址】: 自己搜索下载

【加壳方式】: 无

【保护方式】: 无

【编写语言】: VB

【使用工具】: OllyDbg

【操作平台】: Win7 X64

【作者声明】: 只是感兴趣，没有其他目的。失误之处敬请诸位大侠赐教!


====
【详细过程】
启动时提示更新,关闭后打开官网 minidnf专用,新版没找到运行脚本的功能
1.
00404010  $  68 74424000   push DNF_Extr.00404274                   ;  VB5!6&&*  VB入口
00404015   .  E8 F0FFFFFF   call &amp;lt;jmp.&amp;amp;MSVBVM60.#100&amp;gt;
0040401A   .  0000          add byte ptr ds:[eax],al
0040401C   .  0000          add byte ptr ds:[eax],al
0040401E   .  0000          add byte ptr ds:[eax],al
00404020   .  3000          xor byte ptr ds:[eax],al
00404022   .  0000          add byte ptr ds:[eax],al
00404024   .  50            push eax
00404025   .  0000          add byte ptr ds:[eax],al
00404027   .  0040 00       add byte ptr ds:[eax],al
0040402A   .  0000          add byte ptr ds:[eax],al
0040402C   .  DA7D A2       fidivr dword ptr ss:[ebp-0x5E]
0040402F   .  08AE 7817488B or byte ptr ds:[esi+0x8B481778],ch
00404035   .  8038 4A       cmp byte ptr ds:[eax],0x4A
00404038   .  AF            scas dword ptr es:[edi]
00404039   .^ EB F3         jmp XDNF_Extr.0040402E</pre>
2.
插件搜索抓包得到的 GET代码，搜Client，HTTP开头，回车
3.
<pre class="lang:asm decode:true ">00455636   .  68 A82D4100   push DNF_Extr.00412DA8                   ;
0045563B   .  52            push edx                                 ;  接下来程序开始拼装字符串了
0045563C   .  8985 28FFFFFF mov dword ptr ss:[ebp-0xD8],eax
00455642   .  8985 24FFFFFF mov dword ptr ss:[ebp-0xDC],eax
00455648   .  8985 20FFFFFF mov dword ptr ss:[ebp-0xE0],eax
0045564E   .  FFD3          call ebx                                 ;  &amp;lt;&amp;amp;MSVBVM60.__vbaStrI2&amp;gt;
00455650   .  8B35 AC164000 mov esi,dword ptr ds:[&amp;lt;&amp;amp;MSVBVM60.__vbaSt&amp;gt;;  MSVBVM60.__vbaStrMove
00455656   .  8BD0          mov edx,eax
00455658   .  8D4D E4       lea ecx,dword ptr ss:[ebp-0x1C]
0045565B   .  FFD6          call esi                                 ;  &amp;lt;&amp;amp;MSVBVM60.__vbaStrMove&amp;gt;
0045565D   .  8B3D 44144000 mov edi,dword ptr ds:[&amp;lt;&amp;amp;MSVBVM60.__vbaSt&amp;gt;;  MSVBVM60.__vbaStrCat
00455663   .  50            push eax                                 ; /String
00455664   .  FFD7          call edi                                 ; __vbaStrCat
.......                                                              ; 中间省略一部分，因为太长了，拼装个语句拼了好久
004558B8   .  68 242F4100   push DNF_Extr.00412F24                   ;  &amp;amp;LangID=   //这是最后一个字段,判断语言
004558BD   .  FFD7          call edi
004558BF   .  8BD0          mov edx,eax
004558C1   .  8D8D 48FFFFFF lea ecx,dword ptr ss:[ebp-0xB8]
004558C7   .  FFD6          call esi
004558C9   .  50            push eax
004558CA   .  FF15 98114000 call dword ptr ds:[&amp;lt;&amp;amp;KERNEL32.GetUserDef&amp;gt;; [GetUserDefaultLangID
004558D0   .  50            push eax
004558D1   .  FF15 D4134000 call dword ptr ds:[&amp;lt;&amp;amp;MSVBVM60.__vbaStrI2&amp;gt;;  MSVBVM60.__vbaStrI2</pre>
4.
<pre class="lang:asm decode:true ">004559BE   .  FF15 48164000 call dword ptr ds:[&amp;lt;&amp;amp;MSVBVM60.__vbaFreeS&amp;gt;;  MSVBVM60.__vbaFreeStrList
004559C4   .  8D85 38FFFFFF lea eax,dword ptr ss:[ebp-0xC8]
004559CA   .  50            push eax
004559CB   .  8D8D 3CFFFFFF lea ecx,dword ptr ss:[ebp-0xC4]
004559D1   .  51            push ecx
004559D2   .  8D95 40FFFFFF lea edx,dword ptr ss:[ebp-0xC0]
004559D8   .  52            push edx
004559D9   .  6A 03         push 0x3
004559DB   .  FF15 28144000 call dword ptr ds:[&amp;lt;&amp;amp;MSVBVM60.__vbaFreeO&amp;gt;;  MSVBVM60.__vbaFreeObjList
004559E1   .  81C4 B8000000 add esp,0xB8
004559E7   .  68 FE5A4500   push DNF_Extr.00455AFE
004559EC   .  E9 0C010000   jmp DNF_Extr.00455AFD
004559F1   .  F645 FC 04    test byte ptr ss:[ebp-0x4],0x4
004559F5   .  74 09         je XDNF_Extr.00455A00
004559F7   .  8D4D E8       lea ecx,dword ptr ss:[ebp-0x18]
004559FA   .  FF15 F0164000 call dword ptr ds:[&amp;lt;&amp;amp;MSVBVM60.__vbaFreeS&amp;gt;;  MSVBVM60.__vbaFreeStr
.............                                                         ;中间又是很长一段,从上面可以看到VB开始释放那个长字符串的内存里
00455AD0   .  51            push ecx
00455AD1   .  6A 29         push 0x29
00455AD3   .  FF15 48164000 call dword ptr ds:[&amp;lt;&amp;amp;MSVBVM60.__vbaFreeS&amp;gt;;  MSVBVM60.__vbaFreeStrList
00455AD9   .  8D95 38FFFFFF lea edx,dword ptr ss:[ebp-0xC8]
00455ADF   .  52            push edx
00455AE0   .  8D85 3CFFFFFF lea eax,dword ptr ss:[ebp-0xC4]
00455AE6   .  50            push eax
00455AE7   .  8D8D 40FFFFFF lea ecx,dword ptr ss:[ebp-0xC0]
00455AED   .  51            push ecx
00455AEE   .  6A 03         push 0x3
00455AF0   .  FF15 28144000 call dword ptr ds:[&amp;lt;&amp;amp;MSVBVM60.__vbaFreeO&amp;gt;;  MSVBVM60.__vbaFreeObjList
00455AF6   .  81C4 B8000000 add esp,0xB8
00455AFC   .  C3            retn
00455AFD   &amp;gt;  C3            retn                                     ;  RET 跳到下一行
00455AFE   &amp;gt;  8B4D EC       mov ecx,dword ptr ss:[ebp-0x14]
00455B01   .  8B45 E8       mov eax,dword ptr ss:[ebp-0x18]
00455B04   .  5F            pop edi
00455B05   .  5E            pop esi
00455B06   .  64:890D 00000&amp;gt;mov dword ptr fs:[0],ecx
00455B0D   .  5B            pop ebx
00455B0E   .  8BE5          mov esp,ebp
00455B10   .  5D            pop ebp
00455B11   .  C2 0800       retn 0x8</pre>
5.
<pre class="lang:asm decode:true ">00453550   .  8B35 AC164000 mov esi,dword ptr ds:[&amp;lt;&amp;amp;MSVBVM60.__vbaSt&amp;gt;;  MSVBVM60.__vbaStrMove    ;retn 0x8 后跳到这里
00453556   .  8BD0          mov edx,eax
00453558   .  8D4D E4       lea ecx,dword ptr ss:[ebp-0x1C]
0045355B   .  FFD6          call esi                                 ;  &amp;lt;&amp;amp;MSVBVM60.__vbaStrMove&amp;gt;
0045355D   .  8D55 D8       lea edx,dword ptr ss:[ebp-0x28]
00453560   .  52            push edx
00453561   .  8D45 DC       lea eax,dword ptr ss:[ebp-0x24]
00453564   .  50            push eax
00453565   .  6A 02         push 0x2
00453567   .  FF15 48164000 call dword ptr ds:[&amp;lt;&amp;amp;MSVBVM60.__vbaFreeS&amp;gt;;  MSVBVM60.__vbaFreeStrList  ;总算是Free完了
0045356D   .  8B4D E4       mov ecx,dword ptr ss:[ebp-0x1C]
00453570   .  83C4 0C       add esp,0xC
00453573   .  51            push ecx
;走到这一行的时候   ECX 05095F64 UNICODE "&lt;a href="http://client.......&amp;quot;"&gt;http://client......."&lt;/a&gt;
;并且后面直接就开始call了,于是推断,下面这个函数 ExtUtility.dll:ID#212是用来访问网页的,右键nop之
00453574      FF15 A4134000 call dword ptr ds:[&amp;lt;&amp;amp;EXTUTILITY.#212&amp;gt;]   ;  EXTUTILI.#212
0045357A   .  8B45 0C       mov eax,dword ptr ss:[ebp+0xC]
0045357D   .  F600 01       test byte ptr ds:[eax],0x1
00453580   .  74 26         je XDNF_Extr.004535A8
00453582   .  FF15 A8134000 call dword ptr ds:[&amp;lt;&amp;amp;EXTUTILITY.#214&amp;gt;]   ;  EXTUTILI.#214           ;并且后面有switch case条件语句出现,推测是用于检测 本次 GET操作的结果,并显示是否更新之类的提示</pre>
最后,nop掉之后,退出的时候也没有打开网页,检查更新也没反应了,那么结束了

--------------------------------------------------------------------------------

2014年11月01日 20:42:29
