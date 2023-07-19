title: MySQL 5.5 节省内存配置
date: "2016-04-25 14:25:13"
update: ""
author: me
tags:
- Nexus 6p
categories:
- Nexus 6p
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



    mysql -V
    default-storage-engine = MyISAM
    loose-skip-innodb
    loose-innodb-trx=0
    loose-innodb-locks=0
    loose-innodb-lock-waits=0
    loose-innodb-cmp=0
    loose-innodb-cmp-per-index=0
    loose-innodb-cmp-per-index-reset=0
    loose-innodb-cmp-reset=0
    loose-innodb-cmpmem=0
    loose-innodb-cmpmem-reset=0
    loose-innodb-buffer-page=0
    loose-innodb-buffer-page-lru=0
    loose-innodb-buffer-pool-stats=0

待测试,看看跑一段时间后的情况如何
