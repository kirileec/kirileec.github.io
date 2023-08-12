title: Flask 之 Hello World
date: "2016-07-09 19:40:00"
update: ""
author: me
tags:
- Python 3-Flask
categories:
- Python 3-Flask
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
from flask import Flask
app = Flask(__name__)

@app.route('/wget/<url>')
def wget(url):
    # show the user profile for that user
    return "The Url is %s" % url

if __name__ == "__main__":
    app.run()
```
