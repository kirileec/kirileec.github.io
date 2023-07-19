title: RESTful
date: "2015-07-29 23:35:00"
update: ""
author: me
tags:
- http
categories:
- http
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



HTTP的扩展

GET获得资源
http://www.example.com 这是网站地址
 如果在后面加上 api/demands 这样表示资源的地址,意思是一些需求的集合
 那么 http://www.example.com/api/demands/GetDemandsAll 可以获取到所有资源的一个列表,以json 数组的形式返回给客户端
 
 http://www.example.com/api/demands/GUID 这样可以将GUID作为参数传入,从数据库中查询到 符合条件的数据返回
 
 POST
 这个不一样了,参数不是在URL里传递,而是以HTTP包的形式
  http://www.example.com/api/demands
  
  构造一个JSON数据包,里面定义Method为POST 然后将需要新增的数据放在包里，发送给服务器即可完成添加数据的任务
  
  PUT也是一样，只不过会对已有的数据进行修改
  
  DELETE
   http://www.example.com/api/demands/GUID 在这样的地址之下发送DELETE METHOD 则会删除对应的数据
   
   其实不同的Method只是引导服务器去调用不同的服务器方法而已，具体要在方法里要干什么都是随意的，比如可以实现DELETE发过去只是返回一条数据，而不进行删除操作
  
  # 验证
  添加CustomHeader
RESTClient.HTTPClient.Request.CustomHeaders.Add(FAuthCode);
