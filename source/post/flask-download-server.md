title: Flask 之 中转下载服务器
date: "2016-07-09 21:20:47"
update: ""
author: me
tags:
- python
- flask
- Python
categories:
- Python
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



```python
from flask import Flask,request,redirect
import os
app = Flask(__name__)

@app.route('/wget/')
def wget():
    url = request.args.get('url')
    filename = os.path.basename(url)
    ext = filename.split('.')[-1]
    os.system("wget -o /var/www/"+filename +" "+url)
    return redirect("http://llinx.me/%s" % filename )

if __name__ == "__main__":
    app.run(host="llinx.me")

```

调用方法:

    http://llinx.me/wget/?url=

下载完成之后自动跳转到
    
    http://llinx.me/文件名

可以方便地使用这种方式下载国外速度很慢的资源, 当然必须是直链


由于博客是使用的Typecho并做了伪静态, 因此url对应的目标文件不能是html文件


后续将做这样的几件事
1. php调用本地脚本实现运行这个 wget.py 文件
2. 运行之后跳转到一个网页填写表单
3. 表单填写完成之后, 将表单里的URL组合成请求链接,经过多次跳转实现,可视化的文件中转
4. 文件下载完成之后, 关闭脚本, 这样可以不用长时间运行这个服务
