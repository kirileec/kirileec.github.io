title: 狸猫换太子 C程序分析
date: "2012-06-09 20:43:10"
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




 
指针型变量里存储着地址，和一般的变量没有本质区别，而存储的这个地址对应着一个变量（或者其他什么，这里以变量为例），那么 `*p` 可以访问这个地址对应的变量此处的`*`和定义指针型变量时
 `int *p`的`*`是不一样的, `&+变量名`则表示这个变量的地址.

这个例子很容易把人搞晕，特别是当参数名和某个变量名一样的时候。总算不晕了，
[狸猫换太子  C程序分析](http://simg.sinajs.cn/blog7style/images/common/sg_trans.gif)
```c
#include<stdio.h>
#define CIVET 0
#define PRINCE 1
int main(void)
{
int baby=PRINCE;      
     
//此处baby是一个属于main（）函数的局部变量，被赋予了初值1 
printf("before change,baby is");
display(baby);
replace1(baby);   
//此处等价于replace1（1） 
printf("n")
printf("after first action,baby is");
display(baby);
replace2(&baby);   
//将局部变量baby的地址传入这个子程序   
     
printf("n");
printf("after second action,baby is");
display(baby);
return 0;
}
void replace1(int baby)      
//此处baby为一个参数的名字，仅仅是参数名.如果将此处的baby改为shabi什么的就容易理解了吧 
{
baby=CIVET;      
  //此处baby仍然是个参数名，在replace1（）被调用时被赋值为1.在此处又被赋值一次，而传入的只是那个局部变量的值而已，因此局部变量的值没变 
}
void replace2(int * baby)  //此处这个指针型参数“baby” 被赋值为局部变量“baby”的地址，此处改为“int * shaA”是不是更容易理解呢 
{
*baby=CIVET;         //*baby是调用传入的地址的那个变量，即baby那个局部变量 
}
void display(int who)
{
if(who==CIVET)
printf("狸猫");
else if(who==PRINCE)
printf("王子");
}
```

总之，想对另一个子程序的某个局部变量进行修改，只能用指针方式进行修改。
