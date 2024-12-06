-- 设置 root 用户允许从任何主机访问，并使用 mysql_native_password
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'init0925';
-- 开放 root 用户的外网访问权限
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
-- 刷新权限
FLUSH PRIVILEGES;
