---
title: MySQL 远程登录配置
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

<!--more-->

# 授予用户权限

## 改表法

更改 `mysql` 数据库里的 `user` 表里的 `host` 项，将 `localhost` 改为 `%`

```sql
USE mysql;

UPDATE user SET host = '%' WHERE user = 'root';

SELECT host, user FROM user;
```

## 授权法

例如，你想 `myuser` 使用 `mypassword` 从任何主机连接到 `mysql` 服务器的话。

```sql
GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'%' IDENTIFIED BY 'mypassword' WITH GRANT OPTION;

FLUSH   PRIVILEGES;
```

如果你想允许用户 `myuser` 从 `IP` 为 `192.168.1.6` 的主机连接到 `mysql` 服务器，并使用 `mypassword` 作为密码

```sql
GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'192.168.1.3' IDENTIFIED BY 'mypassword' WITH GRANT OPTION;

FLUSH   PRIVILEGES;
```

如果你想允许用户 `myuser` 从 `IP` 为 `192.168.1.6` 的主机连接到 `mysql` 服务器的 `dk` 数据库，并使用 `mypassword` 作为密码

```sql
GRANT ALL PRIVILEGES ON dk.* TO 'myuser'@'192.168.1.3' IDENTIFIED BY 'mypassword' WITH GRANT OPTION;

FLUSH   PRIVILEGES;
```

# 创建、删除用户

## `CREATE USER`

```sql
CREATE USER 'username'@'host' IDENTIFIED BY 'password';
```

## `GRANT`

**授权时若用户不存在会新建用户**

```sql
GRANT privileges ON databasename.tablename TO 'username'@'host' identified by 'password' WITH GRANT OPTION;
```

```sql
WITH GRANT OPTION; # 加上该选项则被授权用户，可以再次授权其他用户，否则不可以。
```

### 撤销权限

```sql
REVOKE privilege ON databasename.tablename FROM 'username'@'host';
```

### 查看权限

```sql
show grants for dog@localhost;
```

>GRANT USAGE:mysql usage 权限就是空权限，默认 create user的权限，只能连库，啥也不能干

## 插表

```sql
# 旧版本

insert into user (host,user,password) values ('%','username',password('123'));

# 新版中 password 已被 authentication_string 代替

insert into user (host,user,password) values ('%','username',password('123'));
```

**用户表全部信息**

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

## 删除用户

```sql
DROP USER 'username'@'host';
```

# 参考链接

* http://blog.csdn.net/huaishu/article/details/50540814
