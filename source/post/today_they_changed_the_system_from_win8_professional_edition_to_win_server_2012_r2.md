title: 今天又换系统了，从win8专业版到Win server 2012 R2
date: "2013-10-11 19:42:00"
update: ""
author: me
tags:
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



这个行动的原因是这样的：
突然有那么一天，在我开机后我的电脑右下角出现了水印，一查看，未激活，而且是windows is not activite

各种还原备份无果之后,嘿，我还不至于马上换，我居然挣扎着用KMS活了几天，但是越来越觉得那个半年不够用，虽然可以无限激活，但人有时候就是那么贱的，半年太短，得一年才好（一年也一样受不了）。

于是先是去找了个win8 with wmc
pro的镜像，先用VHD方式尝试了一下，各种替换，我原来激活过的wmc密钥不能用了。
附上原因：因为我换过硬盘，这是罪魁祸首，但是为什么前一段时间让我活着，这不得而知，也有可能是我的key被完全禁止了。
以下是各项硬件和硬件ID的关系，即cmd下输入SLUI
4回车出来那个窗口的那串数字。当各个加权值总和到25时，那么判定为第二台电脑了。
<div>
<table style="WiDTH: 50%" cellspacing="0">
<tbody>
<tr>
<td>硬件类别</td>
<td>
<p align="center">加权值</p>
</td>
</tr>
<tr>
<td>CD-ROM/CD-RW/DVD-ROM</td>
<td>
<p align="center">1</p>
</td>
</tr>
<tr>
<td>显卡</td>
<td>
<p align="center">1</p>
</td>
</tr>
<tr>
<td>内存</td>
<td>
<p align="center">1</p>
</td>
</tr>
<tr>
<td>声卡</td>
<td>
<p align="center">2</p>
</td>
</tr>
<tr>
<td>MAC地址</td>
<td>
<p align="center">2</p>
</td>
</tr>
<tr>
<td>SCSI适配器</td>
<td>
<p align="center">2</p>
</td>
</tr>
<tr>
<td>IDE接口</td>
<td>
<p align="center">3</p>
</td>
</tr>
<tr>
<td>CPU处理器</td>
<td>
<p align="center">3</p>
</td>
</tr>
<tr>
<td>BIOS固件</td>
<td>
<p align="center">9</p>
</td>
</tr>
<tr>
<td>硬盘</td>
<td>
<p align="center">11</p>
</td>
</tr>
</tbody>
</table>
<br /></div>
<div>硬盘高达11，还说没影响，那就换吧，总有一天系统会告诉你，未激活呦。</div>
<div><br /></div>
<div>既然要重装，还是要考虑SSD的4k对齐。当初我不知道装了多少次win8 才把这货搞定。幸好这次没出什么问题。</div>
<div><br /></div>
<div><br /></div>
<div><br /></div>
<div>
DiskGenius直接删除分区，然后建立新分区，选上“对齐到XXXXX的整数倍”，选中4096。然后格式化,默认即可。</div>
<div><br /></div>
<div>然后可以使用硬盘安装工具将Server2012 的 install.wim导入到系统盘中，重启进入安装。</div>
<div><br /></div>
<div>
第一次进入系统后按照http://bbs.pcbeta.com/viewthread-1197254-1-1.html和</div>
<div>http://bbs.pcbeta.com/viewthread-1023353-1-1.html，配置系统。</div>
<div>激活使用MSDN上的免费key，office还是用以前的备份。</div>
<div>一些基本的弄完之后，大概9G（没显卡驱动，没office），做了一次一次性备份。</div>
<div><br /></div>
</div>
