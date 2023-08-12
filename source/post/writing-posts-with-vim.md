title: vim发 Typecho 博客
date: "2015-02-12 21:25:00"
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



* 首先需要安装 node.js with npm，此命令会先安装 node.js --without-npm，然后再安装 npm，据说原因是 npm 和 Homebrew 之间可能存在着冲突，因此无法直接安装 node.js with npm   


	brew install node
	[sudo] npm -g install instant-markdown-d

实时预览插件需要的，这货默认端口是8090，坑爹的家伙，也找不到源码

* 然后，使用 `Vundle` 安装 必要的插件

	Bundle 'godlygeek/tabular'   #vim-markdown 依赖
	Plugin 'plasticboy/vim-markdown'  #语法高亮&文件类型识别之类的
	Bundle 'vimpress'  # vim 官网的0.9.1版本
	Bundle 'suan/vim-instant-markdown' #实时预览插件

* 在 `~/.vimrc` 中加入这一句


	au BufRead,bufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown

* 到 [此链接][1] 去复制这个修改过的 `blog.vim`，并保存到本地，然后编辑其中的 `Settings` 段
	
	
	enable_tags = 0`
	blog_username = 'Typecho 后台用户名'`
	blog_password = 'Typecho 后台密码'`
	blog_url = 'http://博客首页地址（未测试二级目录）/action/xmlrpc'  #这是 Typecho 的 xmlrpc 的地址`

* 最后，打开 `macvim`，新建一个 md 文件，`:e strID.md` ,然后输入`:BlogNew`,OK 开始，删除不需要的分类，填上文章题目，并在 `Content` 下书写内容，然后 `:BlogSend`即可，如果报错，绝对是网络问题，再试试看就行

-------
### 注意
1. 本过程不完善，还不支持 markdown，因为按照上面的方法 Post 上去的文章是 html 也就是说 markdown 的标记符比如 `>` 最后显示的时候还是 `>`, 其实跟用 windows live writer 写 typecho 博客一样了，不过如果会用 html 标记写文章的人就比较好了，我查看了一下 `blog.vim` 的内容，`handler=xmlrpclib.ServerProxy(blog_url).metaWeblog` 主要是靠这个对象里的方法去进行数据的传送的，可以确定的是，给 Content 加上 html 标签应该也在这里面，只能改天研究一下了
2. instant-markdown-d 这个东西我没找到源代码，这傻逼监听的端口是`8090`，和 ShadowsocksX 的 pac 服务的端口是一样的，关键这两个家伙都不能配置端口，气死我了，所以如果 ShadowsocksX 开着的话，实时预览就会显示空白了，解决方案是要么换别的实时预览方案，要么 MAC 下可以选择 COW 作为 ss 的客户端




  [1]: http://wiki.yepn.net/vimpress
