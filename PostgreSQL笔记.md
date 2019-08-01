Postgresql

安装Postgres

`brew install postgres`

删除postgresql

`brew uninstall postgresql`

现在启动Postgres，之后每次启动的时候都启动：

`brew services start postgresql`

不在后台启动，只是现在启动Postgres：

`pg_ctl -D /usr/local/var/postgres start`

连接数据库

`psql -U wangbin01 -d jiayundata -h jiayundatatest.cls0csjdlwvj.us-west-2.redshift.amazonaws.com -p 5439`

列出数据库

`\l`

切换数据库

`\c dbname`

查看指定表

`\d tablename`

`\d+ tablename`

退出

`\q`

将查询结果保存到外部文件

`\o path`

从amazon S3导数据到Postgresql

`copy test.loss from 's3://migration-pengxiao-test/tmp/loss.txt' CREDENTIALS 'aws_iam_role=arn:aws:iam::660338696248:role/redshift'  DELIMITER ','  COMPUPDATE OFF;`

导出建表语句

`pg_dump -U wangbin01 -d jiayundata -h jiayundatatest.cls0csjdlwvj.us-west-2.redshift.amazonaws.com -p 5439 -t test.purchase_order_tmp  -s > sql.txt `

