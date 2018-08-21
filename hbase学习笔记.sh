hbase shell 进入hbase命令行
list 显示HBASE表
status 系统上运行的服务器的细节和系统的状态
version 返回HBase系统使用的版本
table_help 引导如何使用表引用的命令
whoami 返回当前HBase用户
# 建表
create 'base_test','personal data','professional data'
disable 'emp' 禁用表 enable可以重新启用
is_disabled 'table name' 查看表是否被禁用
disable_all 'r.*' 禁用一系列表
describe 'emp' 表描述
alter 't1', NAME => 'f1', VERSIONS => 5  单元的最大数目设置为5
# 使用alter，可以设置和删除表范围，运算符，如MAX_FILESIZE，READONLY，MEMSTORE_FLUSHSIZE，DEFERRED_LOG_FLUSH等。
alter 'emp', READONLY 设置表为只读
alter 't1', METHOD => 'table_att_unset', NAME => 'MAX_FILESIZE'
alter 'table name', 'delete'=> 'column family'
# 删除列簇
alter 'employee','delete'=>'professional' 
exists 'emp' 判断表是否存在
drop 'emp' 删除表，删除表之前必须先禁用表
drop_all 't.*'  批量删除
put 'emp','1','personal data:name','raju' 插入数据
put 'emp','1','personal data:city','hyderabad'
put 'emp','1','personal data:city','Delhi' 更新row=1,personal data=city数据的值为Delhi
get 'emp', '1' 查询数据 
get 'emp', '1', {COLUMN=>'personal data:name'} 查询指定行、指定列
delete 'emp', '1', 'personal data:city'  删除数据
deleteall 'emp','1' 删除所有数据
count 'emp' 统计表的行数
truncate 'table name' 禁止删除并重新创建一个表
grant <user> <permissions> [<table> [<column family> [<column; qualifier>]] 
R - 代表读取权限
W - 代表写权限
X - 代表执行权限
C - 代表创建权限
A - 代表管理权限
grant 'Tutorialspoint', 'RWXCA' 
revoke命令用于撤销用户访问表的权限
revoke 'Tutorialspoint'
user_permission 'emp' 列出了emp表的所有用户权限。

# 新增列簇要先声明
disable 'emp'
alter 'emp', NAME => 'daily', VERSIONS =>1
enable 'emp'
# 为新列簇加入数据
put 'emp','2017-11-30','module:headline','375683'
put 'emp','2017-11-30','module:community','101464'
put 'emp','2017-11-30','module:car','443372'
put 'emp','2017-11-30','module:service','43633'
put 'emp','2017-11-30','module:my','90770'
put 'emp','2017-12-01','module:headline','369003'
put 'emp','2017-12-01','module:community','103500'
put 'emp','2017-12-01','module:car','437643'
put 'emp','2017-12-01','module:service','41259'
put 'emp','2017-12-01','module:my','91521'

# 查询数据——通过rowkey
get 'emp','2017-12-01'
get 'app_info_dvid','00003F39FFAB5CB6B2E31753A2B02220'
# 查询数据——通过rowkey+columnkey
get 'emp','2017-12-01',{COLUMN => 'basic:active'}
get 'emp','2017-12-01','basic:login'
get 'emp','2017-12-01',{COLUMN => 'basic:active', TIMESTAMP => 1513218051477}
get 'emp','2017-12-01',{COLUMN => 'basic:active', TIMESTAMP => 1513218051477,VERSIONS => 1}
# 查询数据——通过rowkey+多个columnkey
get 'emp','2017-12-01',{COLUMN =>['basic:active','basic:newadd']}

# 查询数据——通过rowkey+family
get 'emp','2017-12-01','basic'

# 查询行数
count 'emp'
# 删除正行
deleteall 'emp','row1'

# 按columkey查询
scan 'emp',{COLUMN => 'basic:active'}
scan 'emp',{COLUMN => ['basic:active','basic:newadd'],LIMIT => 2}

# rowkey模糊查询
scan 'emp',{FILTER=>org.apache.hadoop.hbase.filter.PrefixFilter.new(org.apache.hadoop.hbase.util.Bytes.toBytes('2017-12'))}

# 通过时间戳查询
scan 'emp',{TIMERANGE =>[1513218313453,1513218314019]}
# rowkey模糊查询——前缀过滤
scan 'emp',{ FILTER => "PrefixFilter ('2017-11')"}
# 查询rowkey中包含'12-0'的
import org.apache.hadoop.hbase.filter.CompareFilter
import org.apache.hadoop.hbase.filter.SubstringComparator
import org.apache.hadoop.hbase.filter.RowFilter
scan 'emp', {FILTER => RowFilter.new(CompareFilter::CompareOp.valueOf('EQUAL'), SubstringComparator.new('12-0'))}
# 查询rowkey 从2017-12-01开始，到2017-12-04截止，包含前不包含后
scan 'emp', {STARTROW=>'2017-12-01', STOPROW=>'2017-12-04'}
# 查询columnkey中前缀是'lo'
scan 'emp', FILTER=>"ColumnPrefixFilter('lo')"
# 查询value中包含'57'的
scan 'emp', FILTER=>"ValueFilter(=,'substring:57')"

# 计数器
incr 'emp', '2017-12-01', 'daily:hits', 1
incr 'emp', '2017-12-01', 'daily:hits'
# 获取计数器
get_counter 'emp', '2017-12-01', 'daily:hits'



# 存入json数据
create 'app_info','car'
put 'app_info','guide_qa','car:qa',''
put 'app_info','guide_qa_9.4','car:qa',''
deleteall 'app_info','guide_qa'


