title: Golang File Upload
date: 2019-05-30 16:14:36 +0800
update: ""
author: me
tags:
- qrFileTransfer
- go
- vue
categories:
- go
- vue
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


Golang 文件上传

<!--more-->

```go
g1 := r.Group("/api")
g1.Use(middlewares.JWTAuth(),cors.Default())
{
  g1.GET("/ping", func(c *gin.Context) {
    c.JSON(http.StatusOK,gin.H{"code":http.StatusOK,"message":"pong /api"})
  })
  g1.POST("/u", func(c *gin.Context) {
    log.Println("/u POST")
    form, err := c.MultipartForm()
    if err != nil {
      c.JSON(http.StatusOK, gin.H{"code":http.StatusBadRequest,"msg":fmt.Sprintf("error get form: %s",err.Error())})
      return
    }
    files := form.File["files"]

    for _, file := range files {
      basename := filepath.Base(file.Filename)
      filename := filepath.Join(".", basename)
      if err := c.SaveUploadedFile(file, filename); err != nil {
        c.JSON(http.StatusOK, gin.H{"code":http.StatusBadRequest,"error": err.Error()})
        return
      }
    }

    var filenames []string
    for _, file := range files {
      filenames = append(filenames, file.Filename)
    }
    c.JSON(http.StatusOK, gin.H{"code":http.StatusAccepted,"msg":"upload ok!","data": gin.H{"files":filenames}})
  })
}
```
可同时上传多个文件


分别使用`Postman` `git bash里的curl` `Windows子系统里的curl` 调用

Postman
---
![](/images/2019-05-30_170818.png)

key 的值对应 上面代码里的 `files := form.File["files"]` 这一段

Kali
---
```bash
curl \
--request POST \
--url http://localhost:1005/api/u \
--header 'token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ
9.eyJzZXNzaW9uSWQiOiI2Y2JlMmFlYS1lMTFiLTQzOTItYTI4NS05NTRkZDhmMTBkNzAiLCJ1c2VySWQiOiIwIiwiZXhwIjoxNTU5MjA4NjI2LCJpc3MiOiJsbGlueC5tZSIsIm5iZiI6MTU1OTIwN
DAyNn0.0nBvCIPHR9ro_hhxgvoy6uc7Q0ftS1d5D8PXDa3zU04' \
-F "files=@/mnt/c/Users/linx/Desktop/1.txt"
```

> 一开始的时候提示 setting file failed, 还以为是不支持中文啥的
> 后来发现子系统的路径是不一样的  (─.─|||


git bash
---
```bash
curl \
--request POST \
--url http://localhost:1005/api/u \
--header 'token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzZXNzaW9uSWQiOiI2Y2JlMmFlYS1lMTFiLTQzOTItYTI4NS05NTRkZDhmMTBkNzAiLCJ1c2VySWQiOiIwIiwiZXhwIjoxNTU5MjA4NjI2LCJpc3MiOiJsbGlueC5tZSIsIm5iZiI6MTU1OTIwNDAyNn0.0nBvCIPHR9ro_hhxgvoy6uc7Q0ftS1d5D8PXDa3zU04' \
-F "files=@C:/Users/linx/Desktop/1.txt"
```

---
- `--request`选项可以用 `-X`代替
- 而如果 url 放在最后, 就不用写 --url 了
- `--header`则可以使用 `-H`
- `SaveUploadedFile`的时候, 对应的目录必须事先创建好, 否则报错


Vue上传页面(el-upload)
---

加了本地存储来存储token

```html
<template>
  <div>
    <el-button size="small" type="primary" @click="doAuth">认证</el-button>
    <el-upload
      class="upload-demo"
      ref="upload"
      action="/api/u"
      name="files"
      :multiple="true"
      :drag="true"
      :headers="uploadHeaders"
      :on-preview="handlePreview"
      :on-remove="handleRemove"
      :file-list="fileList"
      :auto-upload="false"
    >
      <el-button slot="trigger" size="small" type="primary">选取文件</el-button>
      <el-button style="margin-left: 10px;" size="small" type="success" @click="submitUpload">上传</el-button>
    </el-upload>
  </div>
</template>

<script>
export default {
  data() {
    return {
      fileList: [],
      uploadHeaders: {
        token: ""
      }
    };
  },
  methods: {

    submitUpload() {
       this.$refs.upload.submit();
    },
    handleRemove(file, fileList) {
      console.log(file, fileList);
      this.fileList = fileList;
    },
    handlePreview(file) {
      console.log(file);
    },
    doAuth() {
        var token = localStorage.getItem('token');
        console.log(token)
      this.$http.get("/index/",{headers:{'token' : token}}).then(
        function(res) {
          console.log(res);
          if (res.body.code == 201) {
            this.uploadHeaders.token = res.body.data.token;
            localStorage.setItem("token",this.uploadHeaders.token);
          } else if (res.body.code == 100) {
            this.uploadHeaders.token = token;
          }
          
        },
        function(err) {
          console.log(err);
        }
      );
    }
  }
};
</script>
```

---

- `form.File["files"]` 和 `name="files"` 这两个需要对应, 最终会体现在header里
- 使用 `:headers="uploadHeaders"`
  
  ```typescript
  uploadHeaders: {
        token: ""
      }

  this.uploadHeaders.token = token;
  ```
  这样的方式来让上传组件带上咱自己的token


- `action="/api/u"` 和 `this.$http.get("/index/",{headers:{'token' : token}})`
  
  这种不需要带域名端口的方式需要在项目根目录下创建 `vue.config.js`, 内容如下

  ```js
  module.exports = {
    devServer: {
      proxy: {
        '/api': {
          target: 'http://localhost:1005/api', 
          ws: true,
          changeOrigin: true,
          pathRewrite: {
            '^/api': ''    
          }
        },
        '/index': {
          target: 'http://localhost:1005/index',   
          ws: true,
          changeOrigin: true,
          pathRewrite: {
            '^/index': '' 
          }

        }
      }
    }
  }
  ```
  或者 简单点
  ```js
  module.exports = {
    devServer: {
      proxy: {
        '/api': {
          target: 'http://localhost:1005',   //代理接口
          ws: true,
          changeOrigin: true
        },
        '/index': {
          target: 'http://localhost:1005',   //代理接口
          ws: true,
          changeOrigin: true
        }
      }
    }
  }
  ```
  这样的方式不仅让调用更简单, 同时还能跨域, 当然后端也要加一句 `g1.Use(middlewares.JWTAuth(),cors.Default())`
