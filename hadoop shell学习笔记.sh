# 格式化hdfs
hadoop namenode -format
# 查看hadoop下的文件夹
hadoop fs -ls
# 创建hdfs文件夹
hadoop fs -mkdir /user/input
# 将本地文件file.txt 复制到新建文件夹
hadoop fs -put /user/wangbin/input/ip_data.txt wangbin
# 从hadoop复制到hadoop
# 从wangbin复制到wangbin
hadoop fs -put ip_list.txt /user/hadoop
# 从本地复制到hdfs
hadoop fs -copyFromLocal ip_data.txt /user/hadoop
# 从hdfs复制到本地
hadoop fs -copyToLocal sample.txt sample.txt
# 查看文件内容
hadoop fs -cat /user/output/outfile
# 查看顺序文件的内容
hadoop fs -text input/numbers.seq |head
# 从hdfs获取文件到本地
hadoop fs -get /user/output/ /home/hadoop_tp/
# 更改所有人
hadoop fs -chown -R wangbin:wangbin /user/wangbin
# 删除含有文件的文件夹
hadoop fs -rmr output
# 并行复制文件或文件夹，以MapReduce作业实现，-overwrite 覆盖目标文件，-update 仅更新发生变化的部分

hadoop distcp ip_data.txt ip_datav2.txt
# 打包project为jar包，上传文件
export HADOOP_CLASSPATH=mapReduceDemoV1.jar 
# 将hdfs上output目录下的多个文件合并成一个文件output-merge，并存储到本地
hadoop fs -getmerge output output-merge
# 确定input存在，且output不存在，执行jar包
hadoop MaxTemperature sample.txt output

# 使用参数方式导入第三方jar包
for i in `ls /root/libjars/*.jar`  
do  
        LIBJARS=$i,$LIBJARS  
        HADOOPCLASSPATH=$i:$HADOOPCLASSPATH  
done  
  
export LIBJARS=$LIBJARS  
export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$HADOOPCLASSPATH


