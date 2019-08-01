**git笔记**

```shell
git学习笔记
1.安装git,创建ssh key,把本地内容推送到远程git仓库
	ssh-keygen -t rsa -C "youremail@example.com"
	# git remote add origin git@github.com:wangbin2188/databoard.git
2.进入git bash
3.进入E盘
	cd E:
	mkdir local_github
4.将E:/local_github 作为本地git仓库
	git init 
5.在本地仓库目录（E:/local_github）新加read.txt
6.添加文件,git add命令实际上就是把要提交的所有修改放到暂存区（Stage）
	git add read.txt 
7.提交git,git commit就可以一次性把暂存区的所有修改提交到分支
	git commit -m "say some things about your change"
8.修改read.txt ,打印出更新且未提交的内容
	git status 
9.如果想知道改了哪些内容，
	git diff read.txt 
10.对更新内容第二次提交：
	git add read.txt;
	git commit -m "some commit"
11.想显示从最近到最远的提交日志
	git log
12.想要回退到上一版本,上100个版本
	git reset --hard HEAD^
	git reset --hard HEAD~100
13.又后悔了，想改回来,(版本号)
	git reset --hard ae1327cf19d5d830b7edbe85ff9c9907c03077fa
14.查看每次更新的版本号
	git reflog
15.当你改乱了工作区某个文件的内容，想直接丢弃工作区的修改时，用命令
	git checkout -- file。
16.当你不但改乱了工作区某个文件的内容，还添加到了暂存区时，想丢弃修改，分两步，第一步用命令
	git reset HEAD <file>，就回到了场景15，第二步按场景15操作。
17.删除了本地文件，想要同步到git仓库
	git rm test.txt
	git commit -m "test removed"
18.误删了文件，想要从仓库恢复
	git checkout -- test.txt 
19.链接到远程github,从远程库克隆
	git clone git@github.com:wangbin2188/databoard.git
20.修改了本地代码，提交到远程库,大功告成！
	git remote add origin git@github.com:wangbin2188/databoard.git
	git push -u origin master 

```



```shell
# 修改并提交
git add wangbin_test.py 

git commit -m 'add wangbin_test.py

git push origin wangbin01_dev
#推送不允许是强制推送
git push -f origin migration-pro2


#命令显示从最近到最远的提交日志

git log

```

```shell
# 放弃修改
#后悔药1:可以丢弃工作区的修改，（场景：修改了还没有add）

git checkout — file

git checkout其实是用版本库里的版本替换工作区的版本

#后悔药2:可以丢弃暂存区的修改，回退到上一个版本（场景：add了，还未commit,HEAD指版本库当前版本）

git reset HEAD <file>

#后悔药3:版本回退，（场景：已经commit，尚未推送到远程库，HEAD^是版本库上一个版本）

git re**set** --hard HEAD^ 

git re**set** --hard 1094a
```





```shell
#拉取远程内容
#通常git clone拉去的是远端master主分支
#查看远程分支

git branch -r

#拉取远端任意分支

git checkout -b new_branch origin/new_branch

#切换到某个分支

git checkout branch_name

#合并指定分支到当前分支

git merge <name>
```





```shell
# 操作分支
#推送本地分支python3_version到远程wangbin01_dev

git push origin python3_version:wangbin01_dev

#查看所有分支

git branch -a 

#删除远程分支

git push origin --delete chapater6 

#删除本地分支

git branch -d chapater6 

#命令可以查看工作区和版本库里面最新版本的区别

git diff HEAD — readme.txt



#假如要将A分支上面的commit添加到B分支上面，我们可以要先切换到B分支上面。

git checkout B

#将上面的commit id的提交添加到B分支上面

git cherry-pick <commit id> 
```





```shell
#fetch和pull的区别
#下载所有远程内容到本地，但不合并到HEAD
git fetch <remote>
#下载所有远程内容到本地，并merge到HEAD，其实git pull=git fetch+git merge
git pull <remote> <branch>

#从远程的origin仓库的master分支下载代码到本地的origin master
git fetch origin master 
#比较本地的仓库和远程参考的区别
git log -p master.. origin/master
#把远程下载下来的代码合并到本地仓库，远程的和本地的合并
git merge origin/master

#把某个分支上的内容都拉取到本地
git pull origin dev(远程分支名称)
```

