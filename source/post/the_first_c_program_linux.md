title: 第一个C程序[linux]
date: "2012-06-07 13:56:01"
update: ""
author: me
tags:
- 杂谈
- other
categories:
- other
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




<div>Fibonacci 序列产生程序－－－－线程的创建</div>
<div>#include&lt;pthread.h&gt;</div>
<div>#include&lt;stdio.h&gt;</div>
<div>float &nbsp;<wbr>b[100]; &nbsp;</wbr><wbr>
&nbsp;</wbr><wbr> &nbsp;</wbr><wbr> &nbsp;</wbr><wbr>
&nbsp;</wbr><wbr> &nbsp;</wbr><wbr> &nbsp;</wbr><wbr>
&nbsp;</wbr><wbr> &nbsp;</wbr><wbr> int甚至long long
int都不能满足后面指数般递增的数列，直接float省事儿</wbr></div>
<div>int n=100;</div>
<div><br /></div>
<div>void *f() &nbsp;<wbr> &nbsp;</wbr><wbr>
&nbsp;</wbr><wbr> &nbsp;</wbr><wbr> &nbsp;</wbr><wbr>
&nbsp;</wbr><wbr> &nbsp;</wbr><wbr> &nbsp;</wbr><wbr>
&nbsp;</wbr><wbr> &nbsp;</wbr><wbr> &nbsp;</wbr><wbr>
&nbsp;</wbr><wbr>带参数的函数在创建线程时，各种错误啊，于是换一个</wbr></div>
<div>{</div>
<div>int i;</div>
<div>b[0]=0;</div>
<div>b[1]=1;</div>
<div>i=2; &nbsp;<wbr> &nbsp;</wbr><wbr> &nbsp;</wbr><wbr>
&nbsp;</wbr><wbr> 此处为必须的，否则会得不到需要的结果，伤心的往事。。。</wbr></div>
<div>while(i&lt;=n) &nbsp;<wbr>
&nbsp;</wbr><wbr> &nbsp;</wbr><wbr> 该循环为主要的计算循环，是傻瓜式的</wbr></div>
<div>{</div>
<div>&nbsp;<wbr> &nbsp;</wbr><wbr>b[i]=b[i-1]+b[i-2];</wbr></div>
<div>&nbsp;<wbr> &nbsp;</wbr><wbr>i++;
&nbsp;</wbr><wbr></wbr></div>
<div>}</div>
<div>&nbsp;<wbr> &nbsp;</wbr><wbr>sleep(3);
&nbsp;</wbr><wbr> &nbsp;</wbr><wbr> &nbsp;</wbr><wbr>
&nbsp;</wbr><wbr> &nbsp;</wbr><wbr> &nbsp;</wbr><wbr>
此处是为了让所谓线程更加形象，因为现在的CPU运算太快了！呵呵</wbr></div>
<div>&nbsp;<wbr> &nbsp;</wbr><wbr>return 0;</wbr></div>
<div>}</div>
<div><br /></div>
<div><br /></div>
<div>int main()</div>
<div>{</div>
<div>pthread_t tid;</div>
<div>int a,j,ret;</div>
<div>printf("请输入需要的序列项数:"); &nbsp;<wbr> &nbsp;</wbr><wbr>
用printf输出中文时容易造成乱码，具体方法是对当前c文件另存为UTF－8，即你拿来执行此程序的终端的编码</wbr></div>
<div>scanf("%d",&amp;a);</div>
<div>ret=pthread_create(&amp;tid,NULL,f,NULL);</div>
<div>pthread_join(tid, NULL);</div>
<div>&nbsp;<wbr> &nbsp;</wbr><wbr> j=0;</wbr></div>
<div>while(j&lt;=a){</div>
<div>&nbsp;<wbr> &nbsp;</wbr><wbr> &nbsp;</wbr><wbr>
&nbsp;</wbr><wbr>printf("%fn",b[j]); &nbsp;</wbr><wbr>
&nbsp;</wbr><wbr> &nbsp;</wbr><wbr> &nbsp;</wbr><wbr>
可以改为<span style="line-height: 21px;">%.0fn</span></wbr></div>
<div>&nbsp;<wbr> &nbsp;</wbr><wbr> &nbsp;</wbr><wbr>
&nbsp;</wbr><wbr>j=j+1;</wbr></div>
<div>} 返回值什么的就不要了吧，注释真是开心的事儿</div>
<div>}</div>
