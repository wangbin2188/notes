列出当前自动化任务
crontab -l
编辑自动化列表
crontab -e
每天7：50开启ssh服务
50 7 * * * /sbin/service sshd start  
每两分钟执行一次任务
*/2 * * * * /usr/local/python27/bin/python2.7 /root/test.py>>/root/task.log
*/5 * * * *每五分钟执行  
*/30 * * * * /usr/local/python27/bin/python2.7 /root/live_update.py
1 5 * * * /usr/local/python27/bin/python2.7 /root/live_delete.py
0 * * * *  每小时执行     
0 0 * * *  每天执行        
0 0 * * 0  每周执行       
0 0 1 * *  每月执行        
0 0 1 1 *  每年执行 

* * * * * /usr/bin/python2.7 /root/live_update.py 
m h M y w      
把所有权限赋给file
chmod 777 file
指定目录搜索文件
find  path file
全站搜索文件
find / -name active_data.txt
find / -type f -size 0 -exec ls -l {} \; 查找系统中所有文件长度为0的普通文件，并列出它们的完整路径
建立软连接
ln -s  /usr/local/python27/bin/myblog myblog
如果后面是目录，则显示目录中内容的详细信息，如果后面是文件，则显示文件信息，类似于远程ll/ls
dir -l directory/file
查看磁盘使用情况
df
显示文件大小
du -h backup.sql
清屏
clear
连接两个文件中
join testfile_1 testfile_2
拆分大文件为小文件，每100行
split -100
按列连接文件
paste
删除文件中的空行
grep -v '^$' loss.txt >>lossv1.txt
cat -A file 显示特殊字符
cat -n file 显示行号

执行shell脚本：
sh **.sh 20160101 20160101
跳转：
ssh l-hive1.f.cn5
显示列名：
set hive.cli.print.header=true;

把SQL的查询结果赋给一个变量：
a=$()
echo $a 
今天的后n天日期：
date  +"%Y%m%d" -d  "+n days"          
今天的前n天日期：
date  +"%Y%m%d" -d  "-n days"  
今天的13个月之前：
last_13_month=$(date -d"13 month ago" +"%Y%m")        
date +%Y-%m-%d ==>2016-01-07
date +%Y%m%d  ==>20160107
批量重命名：
for var in *.txt; do mv "$var" "inter_${var%.txt}.txt"; done
wc 查看文件行数、字符数、大小
wc -l 查看文件行数 
cd ~回到home目录
cd -回到上一次的目录
mv a b 把文件a重命名为b
uniq file >new_file 把文件排重
cp -r $HIVE_PATH/lib/py      /home/q/python27/lib/python2.7/site-packages
find / -name 'chanel0502.txt' 通过文件名查找文件
正则表达式：以inter开头，16、7、18、19.txt结尾的文件
ls |grep ^inter.*1[6-9]\.txt$
删掉一个分区：
alter table f_analysis.pangolin_flight drop partition( dt>='20151221')

把当前文件复制到inter_suc文件夹中：
cp *.txt inter_suc/
压缩/解压缩一个文件夹中的所有文件：-c参数用于创建压缩文件，-x参数用于解压文件
tar -czvf inter_suc.tar.gz inter_suc/  压缩 
tar -xzvf py.tar.gz /root/etc          解压缩
insert into /insert overwrite into是简单插入，overwrite会删掉重复然后插入
从本地文件往数据库导入数据
load data local inpath './tran.txt' overwrite into table order_no_transform;
rm -rf 删除目录及目录下所有文件，不一一询问
cp -r dir1 dir2 复制dir1及内部所有文件为dir2 
HeadLinesSectionForm
######################
vim 进入编辑器
:set invlist 显示特殊字符
a i 进入insert模式
esc退出回到普通模式
：进入命令模式
/word  查找
：%s/vivian/sky/g  替换每一行中所有 vivian 为 sky 
:n1,n2s/word1/word2/g 将n1到n2行的word1替换为word2
:wq! 强制保存并退出
:q! 强制不保存退出
hjkl:左下上右
Ctrl+f =pagedown  
ctrl+b =pageup
gg 移动到文件第一行
G 移动到文件末行
100gg 移动到第100行
yy 复制当前行
dd 删除当前行
0 移动到行首
$ 移动到行尾
n<space> 向后移动n个字符
n<Enter> 向下移动n行
H	光标移动到这个屏幕的最上方那一行的第一个字符
M	光标移动到这个屏幕的中央那一行的第一个字符
L	光标移动到这个屏幕的最下方那一行的第一个字符
d1G	删除光标所在到第一行的所有数据
dG	删除光标所在到最后一行的所有数据
d$	删除游标所在处，到该行的最后一个字符
d0	那个是数字的 0 ，删除游标所在处，到该行的最前面一个字符
nyy	n 为数字。复制光标所在的向下 n 列，例如 20yy 则是复制 20 列(常用)
y1G	复制游标所在列到第一列的所有数据
yG	复制游标所在列到最后一列的所有数据
y0	复制光标所在的那个字符到该行行首的所有数据
y$	复制光标所在的那个字符到该行行尾的所有数据
x, X x 为向后删除一个字符 (相当亍 [del] 按键)， X 为向前删除一个字符
p, P p 为将已复制癿数据在光标下一行贴上，P 则为贴在游标上一行,
u 复原前一个劢作,后悔键
. 重复前一个动作
vim 跳转到某行 100G
vim 搜索字符 命令行状态下 ，n查找下一个
vim 利用fileformat选项，来转换种文件格式。例如，使用以下命令将名为readme.txt的MS-DOS格式的文件，转换为UNIX格式的文件。
:set fileformat=unix
# 向下找 
/char  
# 向上找 
?char
多行注释：
1. 进入命令行模式，按ctrl + v进入 visual block模式，然后按j, 或者k选中多行，把需要注释的行标记起来
2. 按大写字母I，再插入注释符，例如//
3. 按esc键就会全部注释了

取消多行注释：
1. 进入命令行模式，按ctrl + v进入 visual block模式，按字母l横向选中列的个数，例如 // 需要选中2列
2. 按字母j，或者k选中注释符号
3. 按d键就可全部取消注释
######################
grep
######################
即包含红包又包含绑定：cat workLog.txt |grep -n '红包'|grep '绑定'
包含红包但不包含绑定：cat workLog.txt |grep -n '红包'|grep -v '绑定'
以11开头的行：cat workLog.txt |grep -n '^11'
以红包结束的行：cat workLog.txt |grep -n '红包$'
Grep 命令用法大全：1、 参数： -I ：忽略大小写 -c ：打印匹配的行数 -l ：从多个文件中查找包含匹配项 -v ：查找不包含匹配项的行 -n：打印包含匹配项的行和行标 
Grep 命令用法大全：2、正则表达式\ 忽略正则表达式中特殊字符的原有含义 ^ 匹配正则表达式的开始行 $ 匹配正则表达式的结束行 \< 从匹配正则表达式的行开始 \> 到匹配正则表达式的行结束 [ ] 单个字符；如[A] 即A符合要求 [ - ] 范围 ；如[A-Z]即A，B，C一直到Z都符合要求 . 所有的单个字符 * 所有字符，长度可以为0 
文件中包含push的行：grep -n 'push' workLog.txt
grep '[239].' data.doc      #输出所有含有以2,3或9开头的，并且是两个数字的行
grep '^[^48]' data.doc      #不匹配行首是48的行
grep -c 'push' workLog.txt 统计包含push的次数
grep --color=auto 'push' workLog.txt 对搜索词显示颜色
grep -v 'a' test.txt 反向查询
######################
sed 
######################
1.选项与参数：
-n ：使用安静(silent)模式。在一般 sed 的用法中，所有来自 STDIN 的数据一般都会被列出到终端上。但如果加上 -n 参数后，则只有经过sed 特殊处理的那一行(或者动作)才会被列出来。
-e ：直接在命令列模式上进行 sed 的动作编辑；
-f ：直接将 sed 的动作写在一个文件内， -f filename 则可以运行 filename 内的 sed 动作；
-r ：sed 的动作支持的是延伸型正规表示法的语法。(默认是基础正规表示法语法)
-i ：直接修改读取的文件内容，而不是输出到终端。

2.function：
a ：新增， a 的后面可以接字串，而这些字串会在新的一行出现(目前的下一行)～
c ：取代， c 的后面可以接字串，这些字串可以取代 n1,n2 之间的行！
d ：删除，因为是删除啊，所以 d 后面通常不接任何咚咚；
i ：插入， i 的后面可以接字串，而这些字串会在新的一行出现(目前的上一行)；
p ：列印，亦即将某个选择的数据印出。通常 p 会与参数 sed -n 一起运行～
s ：取代，可以直接进行取代的工作哩！通常这个 s 的动作可以搭配正规表示法！

3.示例
sed '2,3d' user1 删除2~3行
sed '3,$d'  删除3到最后一行
sed '2i drink tea' user1 在第二行之前插入
sed '2,3c No 2-5 number' user1 把2~3行替换成‘2-5 number’
sed -n  '2,4p' user1 展示2~4行
sed -n '/wang/p' user1 查找并显示包含'wang'的行
sed -n '/aa/{s/aa/akk/};p' user1 查找并替换
sed -i 's/^M//g' loss910.txt 去掉windows文件中的^M字符，不能直接粘贴^M，ctrl+v,ctrl+m

######################
awk
######################
awk '{print $1,$2}' communitypostapp.txt  打印第一列和第二列
awk '$1>200' communitypostapp.txt         打印第一列大于200的行
awk '$9~/2016-10-01/' communitypostapp.txt 大于第九列等于2016-10-01的行
awk '{$2="";print $0}' appbusiness1205.txt  删除第二列
echo "aaa 5 70bbb 11 75ccc 50 60" | awk '{ if( $2 >=10 && $2<=20) {print $0} }'  第二列的值大于等于10小于等于20的打印出来

secureCRT颜色设置
选项-会话选项-终端-仿真：勾选ANSI颜色
选项-会话选项-终端-外观：勾选使用颜色
# 从网址下载文件
wget http:...
# 跨服务器复制文件
scp -r /home/hadoop target_ip:/home/
# 在HDFS建文件夹
hdfs dfs -mkdir -p /user/wangbin/input
# 使用超级账户
su -l hdfs
# 在root账户下授权用户HDFS有对hadoop文件夹下的读写权限。
setfacl -m u:hdfs:rx /home/hadoop
# 把5000-8文件放在HDFS的input文件夹
hdfs dfs -put /home/hadoop/wangbin/5000-8.txt /user/wangbin/input
nohup command param & 在后台静默执行
top 监视进程活动与系统负载等信息
free 用于显示当前系统中内存的使用量信息
kill -9 pid 杀死进程
killall httpd 杀死httpd服务所有进程
id 显示用户的ID，以及所属群组的ID
ps 命令用于显示当前进程 (process) 的状态
ps -aux |grep java 显示所有java进程
shutdown 关机
reboot 重启
poweroff 关机
login 登录
logout 登出
logname 登录名
last -10 最近10个在线用户
alias 用于设置指令别名
cut num1 num2 命令用于显示每行从 num1 到 num2 的文字
split 命令用于将一个文件分割成数个
file filename 辨识文件信息
cmp 比较两个文件是否有差异
read  用于从标准输入读取数值
rcp 命令用于复制远程文件或目录
pidof sshd 查询sshd的pid
ifconfig 用于获取网卡配置与网络状态等信息
uname 命令用于查看系统内核与系统版本等信息
uptime 用于查看系统的负载信息
history 命令用于显示历史执行过的命令
history -c 清除历史命令
sosreport 命令用于收集系统配置及架构信息并输出诊断文档
more 以翻页形式查看纯文本
tr 用于替换文本文件中的字符（单个字符，非字符串），格式为“tr [原始字符] [目标字符]”
stat 命令用于查看文件的具体存储信息和时间等信息
touch filename 创建空白文件，可修改文件读写日期
dd命令用于按照指定大小和个数的数据块来复制文件或转换文件
dd if=/dev/zero of=560_file count=1 bs=560M  从/dev/zero设备文件中取出一个大小为560MB的数据块，然后保存成名为560_file的文件
at 11:30 指定未来某个时刻执行某命令，ctrl+d 完成编辑
at -l 查看当前任务
atrm num 删除指定任务
export WORKDIR=/tmp/test 将变量提升为全局变量 仅登陆当次有效
# 二、管道符与重定向
命令 < 文件	将文件作为命令的标准输入
命令 << 分界符	从标准输入中读入，直到遇见分界符才停止
命令 < 文件1 > 文件2	将文件1作为命令的标准输入并将标准输出到文件2
命令 > 文件	将标准输出重定向到一个文件中（清空原有文件的数据）
命令 2> 文件	将错误输出重定向到一个文件中（清空原有文件的数据）
命令 >> 文件	将标准输出重定向到一个文件中（追加到原有内容的后面）
命令 2>> 文件	将错误输出重定向到一个文件中（追加到原有内容的后面）
命令 >> 文件 2>&1 或 命令 &>> 文件	将标准输出与错误输出共同写入到文件中（追加到原有内容的后面）
#三、用户与权限
useradd  [参数] 新建用户
groupadd 新建用户组 
usermod 修改用户属性
passwd 命令用于修改用户密码、过期时间、认证信息
userdel命令用于删除用户，格式为“userdel [选项] 用户名
chattr命令用于设置文件的隐藏权限
lsattr命令用于显示文件的隐藏权限
setfacl命令用于管理文件的ACL规则
getfacl命令用于显示文件上设置的ACL信息
# 四、磁盘划分
/boot	开机所需文件—内核、开机菜单以及所需配置文件等
/dev	以文件形式存放任何设备与接口
/etc	配置文件
/home	用户主目录
/bin	存放单用户模式下还可以操作的命令
/lib	开机时用到的函数库，以及/bin与/sbin下面的命令要调用的函数
/sbin	开机过程中需要的命令
/media	用于挂载设备文件的目录
/opt	放置第三方的软件
/root	系统管理员的家目录
/srv	一些网络服务的数据文件目录
/tmp	任何人均可使用的“共享”临时目录
/proc	虚拟文件系统，例如系统内核、进程、外部设备及网络状态等
/usr/local	用户自行安装的软件
/usr/sbin	Linux系统开机时不会使用到的软件/命令/脚本
/usr/share	帮助与说明文件，也可放置共享文件
/var	主要存放经常变化的文件，如日志
/lost+found	当文件系统发生错误时，将一些丢失的文件片段存放在这里