
-- 自定义变量
hive --define foo=bar
hive> set foo;
foo=bar
hive> set hivevar:foo;
hivevar:foo=bar

hive> set hivevar:foo=bar3;
hive> set foo;
foo=bar3
-- 使用变量创建table
create table tmp_set(
id int,
${hivevar:foo} string);
实际生成SQL：
CREATE TABLE `tmp_set`(
  `id` int, 
  `bar3` string)
-- 使用参数设置在命令行显示当前数据库名称
set hiveconf:hive.cli.print.current.db=true;
结果：
hive (ycappdata)> 
可以使用set hiveconf:hive.cli.print.current.db=false;关闭设置

hive --hiveconf y=5
set y;
y=5
select * from tmp_set where id=${hiveconf:y};

-- 使用linux命令搜索hive相关参数
hive -S -e "set" |grep "foo"

-- 执行一个hive文件
file.hql中以--开头的是注释
hive -f /path/file.hql
进入hive之后可以用source执行一个文件
hive>source /path/file.hql

-- 在hive中执行简单的shell命令,只需要前面加！后面加;
hive>!pwd;
/home/shtermuser
-- 在hive中执行hadoop dfs命令
dfs -ls /;

-- 查询结果展示表头
set hive.cli.print.header=true;
set hive.cli.print.current.db=true;
加入$HOME/.hiverc文件中

-- 每次执行hive都会执行文件中的命令
hive -i .hiverc

-- 清空表中的数据，保留表结构
truncate table tmp_userid;
insert into tmp_userid values('123456');

-- 搜索库或表支持正则表达式
show tables 'sa*';
show tables in basename;

-- 创建数据库时，默认位置是'/user/hive/warehouse/basename.db',可以创建表时指定物理位置
CREATE DATABASE  BASENAME
LOCATION '/path/to/hdfs/';
-- 查看数据库信息，含hdfs信息
describe database ycappdata;

-- 查看表结构和存储信息
show create table tablename;
describe extended ycappdata.tmp_userid_activity;
-- 给数据库增加附属信息
create database basename 
with dbproperties ('creator'='wangbin','date'='2017-12-01');
-- 可以通过~查看
DESCRIBE DATABASE EXTENDED BASENAME;


-- 递归删除数据库和数据库中的表
DROP DATABASE IF EXISTS BASENAME CASCADE;


-- 查看表存储位置，并将数据put进hdfs
show create table db.table 
hadoop fs -put ${local} ${hdfs}

-- 创建外部表,并制定存储位置，删除表并不会删除hdfs上的数据
create external table if not exists stocks(
*)
row format delimited fields terminated by ','
location '/path/to/hdfs/'

-- 使用已有表创建外部表,管理表也可以这样复制
create external table if not exists stocks2
like stocks
location '';

-- 规定查询分区表必须指定分区以及相反的情况
set hive.mapred.mode=strict;
set hive.mapred.mode=nostrict;

-- 查看表的分区,以及查看特定分区
show partitions tablename;
show partitions tablename partition(dt='2017-12-01');

-- 给表增加一个分区
alter table log_messages add partition(year=2017,month=12,day=2);
location '/path/to/hdfs';

-- 改变表的分区地址
alter table log_messages  partition(year=2017,month=12,day=2);
set location '/newpath/to/hdfs';

-- 查看分区表的地址
describe extended ycappdata.sa_daydau_detail partition (ctl_dt='2017-12-01');

-- 表重命名
alter table log_messages rename to log_msgs;
-- 增加、修改、删除表分区
alter table log_messages drop if exists partition(year=2017,month=12,day=2);
-- 修改列信息
alter table log_messages change column hms1 hms2 int ; 
alter table log_messages add column hms3 int;
-- 还可以修改表属性和列属性

-- 从一个表查询数据并插入到分区表中
insert overwrite table employees
partition(country='US',state='OR')
select * from  tablename;

-- 动态分区插入数据,hive 根据select 语句的最后两列来确定分区字段的值
insert overwrite table employees
partition(country,state)
select ...,se.cnty,se.st 
from tablename se;

set hive.exec.dynamic.partition=true;表示开启动态分区功能。还有一些其他的属性可以配置

-- 从表中导出数据
insert overwrite local directory '/dir/'
select * from ;

-- 从表中查询集合数据类型,array[0],map['key'],struct.key
select subordinates[0],deductions['key'],address.city from employees;


-- 使用表生成函数
select explode(subordinates) as sub  from employees;

-- join 虽然是内连接，但是如果左右表分别有多条数据满足on条件，则这些数据会形成笛卡尔积，left outer join 与之相似

-- 左半链接，只返回和右表能匹配上的左表数据，可以用来替代left outer join where b.id is not null;
-- 基本上算inner join的优化，优点是inner  join 时如果右表有多条数据，则会产生两条记录，但left semi join 只会返回一条。缺点是不能返回右表数据。
left semi join

-- 扫描一次全表，执行多次操作
from history 
insert overwrite table1 select *  where action='p1'
insert overwrite table2 select *  where action='p2'
insert overwrite table3 select *  where action='p3';

-- 创建视图
create view if not exists viewname(col1,col2)
as select * from tablename;

-- 创建索引,仅对country建索引，一张表的索引数据存储在另外一张表中
create index employees_index
on table employees(country)
as 'org.apache.hadoop.hive.ql.index.compact.CompactIndexHandler'
with deferred rebuild
in table employees_index_table;

-- 显示索引
show formated index on employees;

-- 删除索引
drop index employees_index on table employees;

-- hive 数据分桶
create table weblog (user_id int,url string,source_ip string)
partition by (dt string)
cluster by (user_id) into 96 buckets;

-- 设置hive为表分桶的默认reduce数，如果为false就需要手动指定buckets数,分桶时必须加cluster by
set hive.enforce.bucketing=true;
->
set mapred.reduce.tasks=96;

-- 开启中间压缩，shuffle数据会减少
set hive.exec.compress.intermediate=true;
-- 开启输出结果压缩
set hive.exec.compress.output=true;

-- 设置输出压缩格式为Gzip
set  mapred.map.output.compression.codec=org.apache.hadoop.io.compress.GzipCodec;

-- 旧文件访问频率很低，可以考虑进行归档，减少namenode的压力，缺点是查询效率会降低，也不会减少磁盘空间
-- 设置表为归档表,并将指定分区归档->.har，之后的语句可以进行反向操作，将数据从har文件提取出来重新放在hdfs
set hive.archive.enabled=true;
alter table hive_text archive partition(folder='docs');
alter table hive_text unarchive partition(folder='docs');


-- 使用表生成函数

select name,sub from employees
lateral view explode(subordinates) subView as  sub ;

-- hive streaming

-- 创建指向hbase的hive外部表
create external table hbase_events(
row_name string,
event string,
dt string,
dvid string,
os string,
uid string,
cha string,
lau string,
lou string,
fac string,
cyid string,
av string,
mdl string) 
STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
WITH SERDEPROPERTIES 
("hbase.columns.mapping" = ":key,eventinfo:type,eventinfo:dt,deviceinfo:dvid,deviceinfo:os,deviceinfo:uid,deviceinfo:cha,deviceinfo:lau,deviceinfo:lou,deviceinfo:fac,deviceinfo:cyid,deviceinfo:av,deviceinfo:mdl")
TBLPROPERTIES("hbase.table.name"="events");

-- hbase(main):002:0> scan 'emp'
-- ROW                                COLUMN+CELL                                                                                      
 -- row1                              column=personal:city, timestamp=1504601425375, value=beijing                                     
 -- row1                              column=personal:name, timestamp=1504601133182, value=raju                                        
 -- row1                              column=personal:source, timestamp=1504601133182, value=hyderabad

-- 创建基于hbase多列簇多列的hive外部表
create external table hbase_emp(row_name string,active string,newadd string,login string,loss string,headline string) 
STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
WITH SERDEPROPERTIES ("hbase.columns.mapping" = ":key,basic:active,basic:newadd,basic:login,basic:loss,module:headline")
TBLPROPERTIES("hbase.table.name"="events");

-- 创建基于hive表的hbase表
create  table hbase_kv(
dt string,
starts string,
tab string,
push string,
views string,
news string,
photos string,
starts_u string,
tab_u string,
push_u string,
views_u string,
news_u string,
photos_u string) 
STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
WITH SERDEPROPERTIES ("hbase.columns.mapping" = ":key,pv:start,pv:tab,pv:push,pv:view,pv:news,pv:photos,uv:start,uv:tab,uv:push,uv:view,uv:news,uv:photos")
TBLPROPERTIES("hbase.table.name"="hbase_kv");

create table hbase_userid_to_dvid(
user_id string,
dvid string) 
STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
WITH SERDEPROPERTIES ("hbase.columns.mapping" = ":key,base:dvid")
TBLPROPERTIES("hbase.table.name"="userid_to_dvid");

insert overwrite table hbase_userid_to_dvid select distinct user_id,dvid from dvid_to_user_id; 

-- 创建基于hbase动态列的hive外部表,目前无法获取hbase时间戳
create external table hbase_events2(
row_key string,
dt string,
deviceinfo map<STRING,STRING>,
eventinfo map<STRING,STRING> ) 
STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
WITH SERDEPROPERTIES ("hbase.columns.mapping" = ":key,eventinfo:dt,deviceinfo:,eventinfo:")
TBLPROPERTIES("hbase.table.name"="events");




-- hive集合数据类型
ARRAY：ARRAY类型是由一系列相同数据类型的元素组成，这些元素可以通过下标来访问。比如有一个ARRAY类型的变量fruits，它是由['apple','orange','mango']组成，那么我们可以通过fruits[1]来访问元素orange，因为ARRAY类型的下标是从0开始的；
MAP：MAP包含key->value键值对，可以通过key来访问元素。比如”userlist”是一个map类型，其中username是key，password是value；那么我们可以通过userlist['username']来得到这个用户对应的password；
STRUCT：STRUCT可以包含不同数据类型的元素。类似于一个对象，这些元素可以通过”点语法”的方式来得到所需要的元素，比如user是一个STRUCT类型，那么可以通过user.address得到这个用户的地址。
UNION: UNIONTYPE，他是从Hive 0.7.0开始支持的。

CREATE TABLE employees (  
    name STRING,  
    salary FLOAT,  
    subordinates ARRAY<STRING>,  
    deductions MAP<STRING, FLOAT>,  
    address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>  
) PARTITIONED BY (country STRING, state STRING);
row format delimited
fields terminated by '\001'
collection items terminated by '\002'
map keys terminated by '\003'
lines terminated by '\n'
sorted by textfile;

当然列之间也可以用逗号','和'\t'来分割,但行之间只能用'\n'分割


-- 创建分区表
create table ycapp_push(
md5_dvid string) 
partitioned by 
(dt date);

-- 创建活跃和新增表
create table ycapp_log.ycapp_daily_active2(
dvid string,
ip string,
appversion string,
channel string,
factory string,
platform string,
userid string)
partitioned by 
(dt date)
row format delimited fields terminated by '\t';

-- 修改字段内容
ALTER TABLE tplab_wangbin10.yiche_daily_active2 REPLACE COLUMNS (
  dvid string,
ip string,
appversion string,
channel string,
factory string,
platform string,
userid string)


row format delimited fields terminated by '\t';
# 往分区表insert数据
insert overwrite table ycapp_push partition(dt)
select distinct deviceid,dt from xxtable;



# -- 删掉一个分区
alter table tplab_wangbin10.ycapp_daily_detail drop partition( dt='2017-07-04')
      
# -- 往分区表 load 数据
LOAD DATA LOCAL INPATH '/home/sa_cluster/wangbin/0705yc_35529.txt' OVERWRITE INTO TABLE ycapp_push PARTITION(dt='2017-07-05');
LOAD DATA LOCAL INPATH '/home/hadoop/wangbin/ip_data.txt' OVERWRITE INTO TABLE ycapp_area ;


-- 自定义MD5函数使用方法

add jar /home/sa_cluster/ycappdata/jar/hive/ycappdata_hive_myfunc.jar;
create temporary function StrToMd5 as'ycappdata.hive.myfunc.StrToMd5';
select 'd520a61cfd284ea05a6fce244168b563', StrToMd5('059931015020684') ;  


hive函数
http://www.yiibai.com/hive/hive_built_in_functions.html
split()分割函数
size()返回对象中的元素个数
#collect_list()/collect_set()以数组方式返回一对多的内容
select  ticket_task_no,collect_list(task_no) from stage.sg_bidding_task_pangolinticket
where dt=20160317 
group by ticket_task_no 
limit 100;
#concat_ws将多个字段连成一个，并用第一个参数分割
select  ticket_task_no,db_host,db_name,businesstype,concat_ws(',',db_host,db_name,businesstype) from stage.sg_bidding_task_pangolinticket
where dt=20160317 
limit 10;
#coalesce() 返回参数中第一个非空的参数
#cast() 强制类型转换
#distribute by是控制在map端如何拆分数据给reduce端的，hive会根据distribute by后面列，根据reduce的个数进行数据分发，默认是采用hash算法。
#order by
order by 会对输入做全局排序，因此只有一个reducer（多个reducer无法保证全局有序）
只有一个reducer，会导致当输入规模较大时，需要较长的计算时间。
#sort by
sort by不是全局排序，其在数据进入reducer前完成排序.
因此，如果用sort by进行排序，并且设置mapred.reduce.tasks>1， 则sort by只保证每个reducer的输出有序，不保证全局有序。
#distribute by
按照指定的字段对数据进行划分到不同的输出reduce  / 文件中。
#Cluster By
cluster by 除了具有 distribute by 的功能外还兼具 sort by 的功能。 
但是排序只能是倒序排序，不能指定排序规则为asc 或者desc。
#concat_ws('*',collect_list(task_no))将原来的数组元素强制安装新的方式连接
