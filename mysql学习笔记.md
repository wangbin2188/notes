mysql
常用命令：
mapred.reduce.tasks=1
user/wangbin10/new_data
TabResidenceTime  停留时长key
修改数据库权限允许特定ip访问
use mysql;
SELECT Host,User FROM user;
UPDATE user SET Host = '%' WHERE User= 'root' LIMIT 1;
刷新权限
flush privileges;
一切OK
-- mysql密码问题
service mysqld stop
mysqld_safe --user=mysql --skip-grant-tables --skip-networking &
mysql -uroot
use mysql;
UPDATE user SET Password=PASSWORD('wangbin') where USER='';
FLUSH PRIVILEGES;
quit
最终指定了mysql的port为3306，才解决问题。
-- 备份数据库：
mysqldump -uroot -pwangbin  --databases chart yiche > backup.sql
mysqldump -u root -pwangbin yiche > yiche.sql
-- 备份指定表
mysqldump -h 'ip' -p'' -u'' databoard car_user_attention >a.sql
-- 还原数据库
mysql -u root -pwangbin yiche < yiche.sql
mysql.x86_64            5.1.73-7.el6    @base
列出所有数据库：
show databases;

选择模板数据库
use database;

查看数据库中的所有表
show tables;

查看建表语句
show create table 表名;
建立表
create table touch_red
(id int,
user_mobile varchar(30),
user_id varchar(30),
user_name varchar(30),
flag int,
value int,
red_use_period int,
logdate varchar(30),
logtime varchar(30));

将数据导入表
load data local infile ''  
into table yiche.deviceid
fields terminated by ',' lines terminated by '\n';

将表中的数据导出到外部文件
select * from yiche_daily into outfile ''
fields terminated by '\t' lines terminated by '\n';

更新表中的内容
update touch_red
set value=200 where flag=18;

update touch_red
set logtime=concat(user_id,user_name);

update touch_red 
set logtime ='2015-04-01';

update touch_red
set create_time='2015-04-21' where flag=18;
向表中插入数据
insert into touch_red values ('667','18701687236','17836549','wangbin2188','18','200','7','2015-04-23','14:06:00');
insert into touch_red (id,user_mobile,value) values ('668','18511371536','200');

删除表中的数据
delete from touch_red where id='' or id='NULL' or id is null;

在表中增加删除列
alter table touch_red
add column create_time varchar(30);

alter table touch_red
drop column create_time ;

建立中间表，并导入数据
INSERT INTO pangolin_order(order_id,task_no,product_type,is_pre_auth,section )
SELECT a.key_value,b.task_no ,b.product_type,b.is_pre_auth,a.section FROM 
(SELECT DISTINCT key_value,section,json FROM order_00.order_detail_0602)a 
JOIN
(SELECT DISTINCT order_no,task_no,product_type,is_pre_auth 
FROM f_pangolin_ticket.ticket_order)b 
ON a.key_value=b.order_no
WHERE  a.key_value!='' ;

抽取中间表
create table new_table as select * from old_table where 1=0 ; 

更改表名：
alter table table_name rename table_new_name;

建表并知道字符类型
create table transDetail
(vid varchar(10),
stime varchar(10),
etime varchar(10),
dragc varchar(10))
default charset=utf8;

更改字段名称
alter table test.trans change direction direction varchar(10) ;

insert into test.trans(vid,stime,direction,dragc)
select vid,substr(timesae,1,5),if(substr(timesae,1,5)>=substr(timesae,7,5),'forward','after'),sum(dragc) from test.tran
where vid in (25520328,25520762,)
group by vid,substr(timesae,1,5),if(substr(timesae,1,5)>=substr(timesae,7,5),'forward','after');

导出数据到外文件
select vid,substr(timesae,1,5),if(substr(timesae,1,5)>=substr(timesae,7,5),'forward','after'),sum(dragc) from test.tran
where vid in (25520328,25520762,)
group by vid,substr(timesae,1,5),if(substr(timesae,1,5)>=substr(timesae,7,5),'forward','after') into outfile 'E:/data.txt'
fields terminated by ',' lines terminated by '\n';

select * from yiche.yiche_daily where date between '2016-09-12' and '2016-09-18'
into outfile 'E:/data.txt' fields terminated by ',' lines terminated by '\n';

select column_name from information_schema.columns where table_name='yiche_daily'
into outfile 'E:/data1.txt' fields terminated by ',' lines terminated by '\n';

只修改列的数据类型的方法:
通常可以写成 alter table 表名 modify column 列名 新的列的类型
例如:student表中列sname的类型是char(20),现在要修改为varchar(20),SQL语句如下
alter table student modify column sname varchar(20);
 
同时修改列名和列的数据类型的方法:
通常可以写成 alter table 表名 change column 旧列名 新列名 新的列类型
例如:student表中列sname的类型是char(20),现在要修改为stuname varchar(20),SQL语句如下
alter table student change column sname stuname varchar(20);
	 
create table app_business(
dvid string,
date string) 
row format delimited  fields terminated by ',';

load data inpath '/user/wangbin10/new_data/df4.txt' into table app_business;


-- csv文件导入mysql
load data local infile 'test4.csv' into table yiche_test2
fields terminated by ',' 
enclosed by '\'' 
lines terminated by '\n';

-- 如果每个数据没有包裹引号，则用如下语句
load data local infile 'test3.csv' into table yiche_core fields terminated by ',' lines terminated by '\n';

-- mysql导出到csv
select * from tablename into outfile '/tmp/data.txt' 
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n';

--outputformat=csv2 --showHeader=false  -e  "${sql}"  > /home/wangbin10/tmp_data/test2.csv

select dt,c_key,c_value from chart.push_appbasic
where dt>='2016-08-14' and dt<'2017-01-01' and c_key in ('adr_active','ios_active')
group by dt,c_key 
into outfile 'appbusiness.txt'
fields terminated by ',' lines terminated by '\n';