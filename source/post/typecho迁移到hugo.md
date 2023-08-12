title: typecho迁移到hugo
date: 2017-04-22 17:55:26 +0800
update: ""
author: me
tags:
- blog
- hugo
- typecho
categories:
- blog
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



首先需要导出typecho的文章

```php
<?php
$db= new mysqli();
$db->connect('localhost','root','root','typecho');
$sql=<<<TEXT
select title,text,created,t2.category,t1.tags,slug from typecho_contents c
left join 
 (select cid,CONCAT('"',group_concat(m.name),'"') tags from typecho_metas m,typecho_relationships r where m.mid=r.mid and m.type='tag' group by cid ) t1
 on c.cid=t1.cid
 left join 
(select cid,CONCAT('"',GROUP_CONCAT(m.name),'"') category from typecho_metas m,typecho_relationships r where m.mid=r.mid and m.type='category' group by cid) t2
on c.cid=t2.cid
TEXT;
$db->query("set character set 'utf8'");//读库 
$res=$db->query($sql);
if($res){
    if($res->num_rows>0){

        while($r=$res->fetch_object()) {
            $_c=date('Y-m-d H:i:s',$r->created);
            $_t=str_replace('<!--markdown-->','',$r->text);
            $_a = str_replace(array('C#'),'CSharp',$r->tags);
            $_a = str_replace(array(','),'","',$r->$_a);
            $_g = str_replace(array('C#'),'CSharp',$r->category);
            $_g = str_replace(array(','),'-',$_g);
            
            $_tmp = <<<TMP
+++
title= "$r->title"
categories= [$_g]
tags= [$_a]
date= "$_c"
+++

$_t

TMP;            
            $file_name=iconv("utf-8","gb2312",$r->slug);
            //替换不合法文件名字符
           file_put_contents(str_replace(array(" ","?","\\","/" ,":" ,"|", "*" ),'-',$file_name).".md",$_tmp);
        }
    }
    $res->free();
}

$db->close();
```
将以上代码保存为convert.php, 放置到网站目录下，修改其中的mysql账号密码，即可导出hugo所需要的格式了。

如果有部分文章没有正常slug的那只能麻烦点手动修改文件名为文章名了，当然也可以再写个脚本，不过我文章不多, 就累点累点了，

注意：文件名中可以包含中文，也可以有括号 空格什么的，但有些字符应该手动把他修改掉
eg. `#` `%` `@` 类似的这种本身就被用于URL的字符
