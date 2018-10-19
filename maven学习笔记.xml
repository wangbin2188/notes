<maven学习笔记>
<一.maven命令>
<!-- 构建命令 -->
mvn archetype:generate
mvn clean 清除原因的class和jar包
mvn clean compile 编译
mvn clean package 打包
mvn clean package -D maven.test.skip=true 打包且跳过测试阶段
mvn clean test 执行测试
mvn clean install 安装jar包到本地maven仓库
mvn install:install-file -DgroupId=org.pentaho -DartifactId=pentaho-aggdesigner-algorithm -Dversion=5.1.5-jhyde -Dpackaging=jar -Dfile=E:\log\pentaho-aggdesigner-algorithm-5.1.5-jhyde.jar
mvn deploy 将包上传到maven远程仓库，供大家使用
mvn site 生成项目站点文档
mvn help:describe -Dplugin=... 查看插件帮助信息
<!-- 优化依赖命令 -->
mvn dependency:list 列出依赖
mvn dependency:tree 列出依赖树
mvn dependency:analyze 分析依赖

<二.maven属性>
<!-- 1.内置属性 -->
${basedir} 项目根目录
${version} 版本

<!-- 2.POM属性 -->
${project.artifactId}
${project.build.sourceDirectory} 项目主代码目录，=>src/main/java
${project.testSourceDirectory} 项目测试代码目录，=>src/test/java
${project.build.directory} 项目构建输出目录 =>/target
${project.outputDirectory}  =>target/classes/
${project.testOutputDirectory} =>target/test/classes/
${project.groupId} 
${project.artifactId}
${project.version}
${project.build.finalName}

<!-- 3.自定义属性 -->
用户可以在<properties></properties>内进行自定义

<!-- 4.settings属性 -->
${settings.localReposity} =>用户本地仓库地址

<!-- 5.java系统属性 -->
${user.name} 用户目录

<!-- 6.环境变量属性 -->
${env.JAVA_HOME}
mvn help:system 可以查看所有环境变量

<三.依赖范围>
scope=compile 编译依赖范围
scope=test 测试依赖范围 =>JUnit
scope=provided 已提供依赖范围，编译、测试有效，运行无效 =>servlet-api
scope=runtime 运行时依赖，测试运行有效，编译无效 =>JDBC
scope=system 系统依赖范围
scope=import 导入依赖范围

<四.插件>
maven-compiler-plugin  maven基础插件，只能把源代码打入jar包
maven-shade-plugin 可以将依赖jar包一并打入jar包
