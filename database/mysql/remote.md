---
title: MySQL 远程登录配置 （用户管理）
date: 2015-03-03 13:00:00
updated:
comments: true
tags:
- MySQL
categories:
- DataBase
- MySQL
---

开启 MySQL 的远程登录需要一些配置，网上一些教程较陈旧，不适用于新版本。

GitHub：https://github.com/khs1994-docker/lnmp/issues/452

<!--more-->

# 修订记录

* 2018/04/21 8.0.11+ `GRANT` 不会自动创建用户，不能修改用户密码

# 配置文件 `my.conf`

默认的配置文件没有该配置(即默认监听所有 IP)，不排除有人增加了这项配置，所以首先看看这个配置项

```bash
[mysqld]

# bind-address=127.0.0.1

bind-address=0.0.0.0

# 或改为你自己的 IP, 0.0.0.0 表示监听全部 IP
```

# 远程登录

* 第一步 创建远程用户

* 第二步 赋予用户权限

## `CREATE USER` 创建用户

```sql
mysql> CREATE USER 'username'@'%','user2'@'%' IDENTIFIED WITH mysql_native_password BY 'password';

# mysql> IDENTIFIED WITH [ mysql_native_password | caching_sha2_password | sha256_password ]
```

### 无密码用户

```sql
mysql> CREATE USER 'username'@'host';
```

## `GRANT` 赋予用户权限

~~授权时若用户不存在会新建用户~~（不适用于 8.0.11+，必须先创建用户，后授权 ）

以下语句中的 `priv_type` 必须替换为具体的权限名字。后边有详细介绍

```sql
# mysql> GRANT privileges ON databasename.tablename TO 'username'@'host' identified by 'password' WITH GRANT OPTION;

mysql> GRANT priv_type ON db_name.tbl_name TO 'username'@'host' WITH GRANT OPTION;

mysql> GRANT ALL ON *.* TO 'myuser'@'%' WITH GRANT OPTION;

mysql> GRANT ALL ON *.* TO 'myuser'@'192.168.1.3' WITH GRANT OPTION;

mysql> GRANT ALL ON dbname.tbname TO 'myuser'@'192.168.1.%' WITH GRANT OPTION;
```

```sql
WITH GRANT OPTION; # 加上该选项则被授权用户，可以再次授权其他用户，否则不可以。
```

### 撤销权限

```sql
mysql> REVOKE priv_type ON db_name.tbl_name FROM 'username'@'host','user2'@'host2';
```

### 查看权限

```sql
mysql> show grants for username@localhost;
```

>GRANT USAGE:mysql usage 权限就是空权限，默认 `create user` 的权限，只能连库，啥也不能干

### 权限可选项 `privilege`

https://dev.mysql.com/doc/refman/8.0/en/grant.html

这里只是简单列出，具体请查看官方文档

#### Permissible Static Privileges for GRANT and REVOKE

* ALL [PRIVILEGES]

* ALTER

* ALTER ROUTINE

* CREATE

* CREATE TABLESPACE | TEMPORARY TABLES | USER | VIEW

* DELETE

* DROP

* EVENT

* EXECUTE

* FILE

* GRANT OPTION

* INDEX

* INSERT

* LOCK TABLES

* PROCESS

* PROXY

* REFERENCES

* RELOAD

* REPLICATION CLIENT | SLAVE

* SELECT

* SHOW DATABASES | VIEW

* SHUTDOWN

* SUPER

* TRIGGER

* UPDATE

* USAGE

#### Permissible Dynamic Privileges for GRANT and REVOKE

* AUDIT ADMIN

* BINLOG ADMIN

* CONNECTION ADMIN

* ENCRYPTION KEY ADMIN

* FIREWALL ADMIN | USER

* GROUP REPLICATION ADMIN

* REPLICATION SLAVE ADMIN

* ROLE ADMIN

* SET USER ID

* SYSTEM VARIABLES ADMIN

* VERSION TOKEN ADMIN

## 修改密码

```sql
mysql> ALTER USER IF EXISTS 'root'@'localhost','user2'@'host2' IDENTIFIED WITH mysql_native_password BY 'mytest';
```

# 删除用户

```sql
mysql> DROP USER IF EXISTS 'username'@'host','user2'@'host2';
```

# 用户表全部信息

```json
[
  {
    "Host": "%",
    "User": "node",
    "Select_priv": "Y",
    "Insert_priv": "N",
    "Update_priv": "N",
    "Delete_priv": "N",
    "Create_priv": "N",
    "Drop_priv": "N",
    "Reload_priv": "N",
    "Shutdown_priv": "N",
    "Process_priv": "N",
    "File_priv": "N",
    "Grant_priv": "N",
    "References_priv": "N",
    "Index_priv": "N",
    "Alter_priv": "N",
    "Show_db_priv": "N",
    "Super_priv": "N",
    "Create_tmp_table_priv": "N",
    "Lock_tables_priv": "N",
    "Execute_priv": "N",
    "Repl_slave_priv": "N",
    "Repl_client_priv": "N",
    "Create_view_priv": "N",
    "Show_view_priv": "N",
    "Create_routine_priv": "N",
    "Alter_routine_priv": "N",
    "Create_user_priv": "N",
    "Event_priv": "N",
    "Trigger_priv": "N",
    "Create_tablespace_priv": "N",
    "ssl_type": "",
    "ssl_cipher": {
      "type": "Buffer",
      "data": []
    },
    "x509_issuer": {
      "type": "Buffer",
      "data": []
    },
    "x509_subject": {
      "type": "Buffer",
      "data": []
    },
    "max_questions": 0,
    "max_updates": 0,
    "max_connections": 0,
    "max_user_connections": 0,
    "plugin": "mysql_native_password",
    "authentication_string": "*58F4612C3598D20A3C51A37D7B2643BF15806832",
    "password_expired": "N",
    "password_last_changed": "2018-03-15 00:10:34",
    "password_lifetime": null,
    "account_locked": "N",
    "Create_role_priv": "N",
    "Drop_role_priv": "N",
    "Password_reuse_history": null,
    "Password_reuse_time": null
  }
]

```

# 用户角色管理 （8.0+）

将一组用户加入到某个角色，后续通过更改角色权限，就可以一次性操作多个用户

https://dev.mysql.com/doc/refman/8.0/en/roles.html

```sql
mysql> CREATE ROLE IF NOT EXISTS 'admin', 'developer', 'webapp'@'localhost';

mysql> DROP ROLE IF EXISTS 'webapp'@'localhost';

mysql> GRANT 'role' TO 'user'@'host';

mysql> GRANT priv_type ON db_name.tbl_name TO 'role';

# 在向用户帐户授予角色时，当用户帐户连接到数据库服务器时，它不会自动使角色变为活动状态。

mysql> SET ROLE DEFAULT;
```



# 参考链接

* http://blog.csdn.net/huaishu/article/details/50540814

* https://www.yiibai.com/mysql/roles.html
