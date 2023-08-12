title: oracle create a read-only account
date: 2023-02-21 08:52:06 +0800
update: ""
author: linx
tags: []
categories: []
topic: ""
cover: ""
draft: false
preview: ""
top: false
type: post
hide: false
toc: false
image: ""
subtitle: ""
config: {}


---



# Oracle 创建只读账号

- ${ADMIN}: 对库有读写权限的原管理账号
- ${ACCOUNT}: 新创建的只读账号
- ${TABLENAME}: 表名
- ${PASSWORD}: 密码


## 创建账号

```sql
CREATE USER ${ACCOUNT} identified by ${PASSWORD};

grant connect to ${ACCOUNT};
grant create view to ${ACCOUNT};
grant create session to ${ACCOUNT};
grant create synonym to ${ACCOUNT};
```

## 生成授权语句

假设管理账号为${ADMIN}

```sql
select 'grant select on '||owner||'.'||object_name||' to ${ACCOUNT};'
from dba_objects
where owner in ('${ADMIN}')
and object_type='TABLE';
```

该语句结果拿出来执行

类似这样的语句, 在管理账号下执行即可

```sql
grant select on ${ADMIN}.${TABLENAME} to ${ACCOUNT}
```

PS: **这里生成的语句是区分大小写的，如果数据库里有一些不是大写的表名，需要加双引号**

## 登录新账号确认

确认新账号可以看到 ${ADMIN} 下的表

## 创建同义词

在${ADMIN}账号下执行，生成的语句，在${ACCOUNT}下执行

```sql
select 'create or replace SYNONYM ${ACCOUNT}.'||object_name|| ' for ' ||owner|| '.'||object_name||';'
from dba_objects
where owner in ('${ADMIN}')
and object_type='TABLE'
```

类似

```sql
create or replace SYNONYM ${ACCOUNT}.${TABLENAME} for ${ADMIN}.${TABLENAME};
```
