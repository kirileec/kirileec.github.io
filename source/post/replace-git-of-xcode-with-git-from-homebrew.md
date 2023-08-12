title: 用 Homebrew 的 git 替代XCODE 的 git
date: "2015-02-12 12:42:00"
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



<p>自卸载了 Xcode 之后，发现它附带的一些命令行工具都没有删除，仍然可用，于是 make 当然也可以。它自带的 git 版本是1.9.3</p>

<p>而最新版 git 已经是2.3.0。</p>

<p>自带的版本安装位置是/usr/bin/git，而 brew 会在 /usr/local/bin/git 这里建立链接</p>

<blockquote>
<p>brew link git</p>
</blockquote>

<blockquote>
<p>cd /usr/bin</p>

<p>sudo mkdir backup-git-apple</p>

<p>sudo mv git* backup-git-apple</p>
</blockquote>

<p>删除了自带的版本，然后重新安装一下 git。</p>

<p>接着，</p>

<blockquote>
<p>sudo vi /etc/paths ，</p>
</blockquote>

<p>将 /usr/local/bin 放到/usr/bin 的上面即可</p>

<p>最后，检查一下</p>

<blockquote>
<p>git --version</p>
</blockquote>
