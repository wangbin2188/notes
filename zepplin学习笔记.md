zepplin笔记

```shell
zepplin学习笔记

-- 附zepplin安装
1.首先我们要下载zeppelin的压缩包,当我们解压之后(这一台主机上面已经安装过了java的环境)
2.修改配置环境
进入conf/
将zeppelin-env.sh.template修改为zeppelin-env.sh
将zeppelin-site.xml.template修改为zeppelin-site.xml，修改端口为9090，(因为8080被spark占用了)
3.然后我们接下来修改conf/zeppelin-env.sh新增
export SPARK_MASTER_IP=172.20.4.64
export SPARK_LOCAL_IP=172.20.4.64
4.启动zeppelin
进入zeppelin:进入bin目录下执行./zeppelin-daemon.sh start
然后浏览器访问172.20.4.64:9090进入界面
5.-- zepplin有三个jar包太旧了，从spark里复制出来替换一下
cd /home/ztgame/soft/zeppelin/lib  
rm -f jackson-annotations-2.5.0.jar  
rm -f jackson-core-2.5.3.jar  
rm -f jackson-databind-2.5.3.jar  
cp /home/ztgame/soft/spark/jars/jackson-databind-2.6.5.jar /home/ztgame/soft/zeppelin/lib/  
cp /home/ztgame/soft/spark/jars/jackson-core-2.6.5.jar /home/ztgame/soft/zeppelin/lib/  
cp /home/ztgame/soft/spark/jars/jackson-annotations-2.6.5.jar /home/ztgame/soft/zeppelin/lib/ 

-- 给zepplin增加新的插件
./install-interpreter.sh --name jdbc
```

