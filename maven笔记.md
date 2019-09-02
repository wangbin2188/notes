Maven

idea自带maven的路径：

/Applications/IntelliJ IDEA.app/Contents/plugins/maven

```shell
sudo vim /etc/profile

export M2_HOME=/Applications/IntelliJ\ IDEA.app/Contents/plugins/maven/lib/maven3

export M2_HOME

export PATH=$PATH:$M2_HOME/bin

export PATH



source /etc/profile
#如果报错Permission denied，则进入命令文件所在目录
chmod +x mvn
```





社区版maven地址

/Applications/IntelliJ IDEA CE.app/Contents/plugins/maven/lib/maven3