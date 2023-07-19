title: zsh 使用小键盘
date: "2015-06-26 15:02:22"
update: ""
author: me
tags:
- MAC OS X
categories:
- MAC OS X
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





```bash
mvim .zshrc
```

```
		# Fix numeric keypad  
		# 0 . Enter  
		bindkey -s "^[Op" "0"  
		bindkey -s "^[On" "."  
		bindkey -s "^[OM" "^M"  
		# 1 2 3  
		bindkey -s "^[Oq" "1"  
		bindkey -s "^[Or" "2"  
		bindkey -s "^[Os" "3"  
		# 4 5 6  
		bindkey -s "^[Ot" "4"  
		bindkey -s "^[Ou" "5"  
		bindkey -s "^[Ov" "6"  
		# 7 8 9  
		bindkey -s "^[Ow" "7"  
		bindkey -s "^[Ox" "8"  
		bindkey -s "^[Oy" "9"  
		# + - * /  
		bindkey -s "^[Ol" "+"  
		bindkey -s "^[Om" "-"  
		bindkey -s "^[Oj" "*"  
		bindkey -s "^[Oo" "/"  
```

From:[Link](http://blog.csdn.net/qibaoyuan/article/details/42963499)
