UML学习笔记
类图
默认的，字段和方法是由PlantUML自动分组的，你也可以使用: – .. == __这些分隔符手动进行分组
up、down、left、right定义线的起始方位。
PlantUML用下面的符号来表示类之间的关系： 
泛化，Generalization：<|–   extend
关联，Association：<–       
组合，Composition：*–      更强关联，具有相同的生命周期
聚合，Aggregation：o–      聚合关系是是一种比较强的关联关系，java中一般使用成员变量形式实现。对象之间存在着整体与部分的关系。
实现，Realization：<|..    implement
依赖，Dependency：<..      依赖关系是耦合度最弱的一种，在java中表现为局域变量、方法的形参，或者对静态方法的调用，

依赖-》关联-》聚合-》组合

用例图
note right of Admin : This is an example.

note right of (Use)
A note can also
be on several lines
end note

note "This note is connected\nto several objects." as N2
(Start) .. N2
N2 .. (Use)