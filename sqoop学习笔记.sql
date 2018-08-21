sqoop学习笔记
sqoop import --connect jdbc:mysql://dbip/chart \
--username dbuser --password dbpw --table push_appindex \
--hive-import --hive-overwrite \
--hive-database ycapp --hive-table appindex \
--fields-terminated-by '\t'



#hive->mysql
#bug处理小计：
#1.分隔符问题，hive默认分隔符'\001',mysql需要指定分隔符;
#2.hive分区表分区字段在hdfs中是没有数据的，这一点和mysql中的字段要考虑对齐问题
#3.hive发到mysql,是以hdfs到mysql的方式进行的
#4.从mysql导入时需要设置分隔符：--fields-terminated-by '\t'
#5.从hdfs向mysql导出是也需要设置分隔符：--input-fields-terminated-by '\t' 
mysql -h 'dbip' -p'dbpw' -u'dbuser' --port dbport -e "delete from ycapp_push.daily_active_users"
yesterday=20180620
sqoop export  --connect jdbc:mysql://dbip:dbport/ycapp_push?useSSL=false \
--username dbuser  \
--password dbpw  \
--table daily_active_users \
--columns "dvid,uid,carnumber,vincode,cityid,cityname,token" \
--export-dir /user/hive/warehouse/databoard.db/ycapp_push_msg/day=20180620 \
--input-fields-terminated-by '\t'  



  
-- sqoop 导入hive分区表-更新日期
sqoop import --connect jdbc:mysql://dbip:dbport/ycapp_video \
--username dbuser --password dbpw --table video_list  \
--hive-import --incremental lastmodified --check-column creater_time  --last-value '2018-04-12 00:00:00'  \
--hive-database formal_db --hive-table mysql_video_list \
--hive-partition-key   dt  --hive-partition-value  '20180522' \
--fields-terminated-by '\t' 

-- sqoop 导入hive分区表-最大id
sqoop import --connect jdbc:mysql://dbip:dbport/ycapp_video \
--username dbuser --password dbpw --table video_list  \
--hive-import --incremental append --check-column id  --last-value 2090555  \
--hive-database formal_db --hive-table mysql_video_list \
--hive-partition-key   dt  --hive-partition-value  '20180522' \
--fields-terminated-by '\t' 

-- 按时间戳增量导入 

sqoop import --connect jdbc:mysql://dbip/chart \
--username dbuser --password dbpw --table push_appindex  \
--hive-import --incremental lastmodified --check-column dt  --last-value '2018-04-12'  \
--hive-database ycapp --hive-table appindex \
--fields-terminated-by '\t'

-- 按id增量导入

sqoop import --connect jdbc:mysql://dbip/chart \
--username dbuser --password dbpw --table push_appindex  \
--hive-import --incremental append  --check-column id --last-value 14057  \
--hive-database ycapp --hive-table appindex \
--fields-terminated-by '\t'

-- 导入hive分区表
--append  --hive-import   --hive-partition-key   KEY  --hive-partition-value  VALUE 

-- 使用Sqoop从MySQL导入数据到HBase
sqoop import --connect jdbc:mysql://dbip/angel --username dbuser --password dbpw \ 
--query "SELECT * FROM xi WHERE 1=1 AND \$CONDITIONS" \ \ 
--hbase-table hxi --hbase-create-table \ 
--hbase-row-key id --split-by date -m 7 \ 
--column-family aitanjupt
-- 嵌入SQL语句
 --query 'SELECT a.*, b.* FROM a JOIN b on (a.id == b.id) WHERE $CONDITIONS' \
 
 
 -- 导入所有的表sqoop-import-all-tables
 sqoop import-all-tables --connect jdbc:mysql://db.foo.com/corp
 
 -- 把数据从hive导入mysql
 sqoop export \
 --connect jdbc:mysql://localhost:3306/test \
 --username dbuser --password dbpw \
 --table uv_info \
 --export-dir /user/hive/warehouse/uv/dt=2011-08-03
 
 -- 将hive表pms.yhd_categ_prior导出到mysql的YHD_CATEG_PRIOR表中
 sqoop export \
--connect jdbc:mysql://dbip:dpport/market \
--username dbuser \
--password dbpw \
--table YHD_CATEG_PRIOR \
--export-dir /user/hive/pms/yhd_categ_prior \
--columns category_id,category_name,category_level,default_import_categ_prior,user_import_categ_prior,default_eliminate_categ_prior,user_eliminate_categ_prior \
--update-mode allowinsert \
--update-key category_id \
--fields-terminated-by '\001' \
--lines-terminated-by '\n' \
--input-null-string '\\N' \
--input-null-non-string '\\N'

 
sqoop export  \
--connect "jdbc:mysql://dbip:3306/databoard?useUnicode=true&characterEncoding=utf-8"\
--username dbuser \
--password dbpw \
--table app_base \
--m 1 \
--export-dir /data/bglogs/databoardshells/data/output/ \
--input-fields-terminated-by '\t'\
--columns="dt,c_key,c_value,client" 

mysql  -u'dbuser' -p'dbpw' -h'dbip' --default-character-set=utf8  -e"load data local infile '/data/bglogs/databoardshells/data/output/part-00000' into table databoard.app_base(dt,c_key,c_value,client)" 