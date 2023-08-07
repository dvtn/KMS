# 拉取Microsoft SQL Server的镜像
docker pull  mcr.microsoft.com/mssql/server:2022-latest

# 启动容器
docker run -e "ACCEPT_EULA=Y" \
-e "MSSQL_SA_PASSWORD=Love=-.,me1314wn" \
--name mssqlsrv001p \
--restart always \
--privileged=true \
-p 1533:1433 \
-v /opt/mssql/mssqlsrv001p:/var/opt/mssql/data \
-d mcr.microsoft.com/mssql/server:2022-latest

# 权限问题修复
docker run -it --entrypoint /bin/sh mcr.microsoft.com/mssql/server:2022-latest
id mssql
chown -R 10001 /opt/mssql/mssqlsrv001p/


# 拉取MySQL的镜像
docker pull mysql

# 启动容器

docker run -p 3304:3306 --name mysqlsrv001p --restart=always --privileged=true \
-v /opt/mysql/mysqlsrv001p/mysql/log:/var/log/mysql \
-v /opt/mysql/mysqlsrv001p/mysql/data:/var/lib/mysql \
-v /opt/mysql/mysqlsrv001p/mysql/conf:/etc/mysql/conf.d \
-v /etc/localtime:/etc/localtime:ro \
-e MYSQL_ROOT_PASSWORD='Love=-.,me1314wn' -d mysql:latest