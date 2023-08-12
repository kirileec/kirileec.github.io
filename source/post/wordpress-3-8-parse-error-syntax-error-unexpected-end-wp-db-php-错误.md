title: 'wordpress 3.8  “Parse Error: syntax error, unexpected $end ”@wp-db.php 错误'
date: "2013-12-17 12:04:46"
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



今天用ftp升级wordpress的时候，上传完了之后，打开页面就提示了这么一句。

于是果断打开wp-db.php编辑查看,因为看到了unexpected $end，于是想到是不是缺了个反括号或者啥，然后再错误提示的1063行那里，发现是一堆注释，开始怀疑了，是怎么个回事呢

翻到代码最后
```php
/**
* The database version number.
*
* @since 2.7.0
*
* @return false|string false on failure, version number on success
*/
function db_version() {
return preg_replace( '/[^0-9.].*/', '', mysql_get_server_info( $this->dbh ) );
}
}
```
而我在文件开头看到了`<?php` 字样，于是就想也不想就给它加上了`?>`;

然后重新上传，但一上传我就知道问题出在哪儿了，因为提示我覆盖的两个文件大小相差太大了，一个20k，一个40k。

原来是上传的问题。

然后就查这个php的开头和结尾的写法，发现其实只有`<?php` 也是正确的，相反反而比`<?php ?>`更加严谨。
