title: Mirillis Action! win8下我认为最好的视频录制软件
date: "2013-01-31 21:43:46"
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




<p>win8 x64 下，也许也适用于win7，据说不支持vista以下的系统</p>
<p>&nbsp;<wbr></wbr></p>
<p>来吐个槽好了。</p>
<p>win8已经面目全非了，就来说说不对劲的地方吧。</p>
<p>&nbsp;<wbr></wbr></p>
<p>
虽然在win8的任务栏可以看到壁纸的样子，我以为是AERO还没消失。其实，AERO已经不在了，因为你可以试试这在高级系统设置里把所有效果全取消，然后你会发现很神奇的一幕，哈哈，窗口的样子一点没变嘛，咋回事啊，win7下不是会变成windows经典界面的么（就那个灰色的窗口）。其实很简单，这两个系统的核心不一样了，win7是在一个窗口框架的基础上加上Aero的特效，而win8么，“纯净”的纸片。另外你可以再测试一点东西。</p>
<p>&nbsp;<wbr></wbr></p>
<p>
比如QQ，你会发现，最新版也不能开透明效果了，不过迅雷应该还可以，据说不是靠windows的Aero模块实现的，因为迅雷在xp照样能透明。</p>
<p>
然后Fraps，这货不能在桌面显示帧数了，真心不是版本什么的问题，因为它提供的对win7的支持的那个DWM桌面，在win8上压根没有，虽然win8的进程列表里还存在着dwm.exe但已经不是一家的了。于是Fraps不能录制桌面了。</p>
<p>&nbsp;<wbr></wbr></p>
<p>好了进入正题。</p>
<p>&nbsp;<wbr></wbr></p>
<p>
我尝试过的软件有FSRecorder（FScapture截图软件自带的录像机）、屏幕录像专家、AVSVideoRecorder（AVSVideoEditor自带的）、Bandicam、FreeScreenVideoRecorder、camtasia、Fraps。</p>
<p>额，还有用虚拟机也录过，呵呵。</p>
<p>&nbsp;<wbr></wbr></p>
<p>
最后我得出的一个结论是，上面这些基本原理都一样的，先录制，然后转码，编码器是它们的核心（如果要录成AVI这样的文件的话），然后问题都一样，在win8下，基本都要么CPU占用很高（高的50%以上，低的也要10%，有时dwm.exe也能占用个10%），要么硬盘占用高（典型的生成文件过大，硬盘写不过来了）。归根结底一个原因，转码器问题。</p>
<p>
转码器压缩率高，那么cpu就高，压缩率低，硬盘就要狂写，我估计搞个128G的内存，然后虚拟成硬盘，再整个16核的CPU，估计就绝对不会卡了吧。</p>
<p>CPU和硬盘高了，那我在桌面操作还有什么意思呢，我还录像干啥呢，还不如整个DV自己拍得了。</p>
<p>&nbsp;<wbr></wbr></p>
<p>于是就出现了这么哥软件 Mirillis Action!，不说别的特点了吧，就一个特点完爆其他的软件----硬件加速。</p>
<p>&nbsp;<wbr></wbr></p>
<p>于是CPU
硬盘都安静了，于是显卡虽然工作了，但是我桌面操作又不用占用显卡多少的运算量，这叫啥，物尽其用，呵呵。这里的加速其实和视频播放器硬解是一个道理。</p>
<p>&nbsp;<wbr></wbr></p>
<p>另外推荐Action v 1.8.0的版本，貌似这个版本有对win8下的一些方面进行过改动。附上changloge</p>
<p>&gt;1.8.0</p>
<p>NEW FEATURE: Pause/resume for video recordings added<br />
--NEW FEATURE: Support for Logitech multimedia keyboards LCD
displays (Logitech G13/G15/G19 etc.)<br />
-Changed default recordings folder on Windows 8 (fixes problems
with desktop video recording)<br />
-Translations improvements<br />
-Stability fixes (closing Action! application)<br />
-Small GUI improvements</p>
<p>&nbsp;<wbr></wbr></p>
<p>&nbsp;<wbr></wbr></p>
