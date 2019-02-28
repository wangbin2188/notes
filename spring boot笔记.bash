spring boot笔记

# spring版本变迁：
1.Spring 1.0的改变了我们开发企业级Java应用程序的方式。Spring的依赖注入与声明式事务意味着组件之间再也不存在紧耦合，再也不用重量级的EJB了。
2.Spring 2.0，可以在配置里使用自定义的XML命名空间，更小、更简单易懂的配置文件让Spring本身更便于使用
3.Spring 2.5有了更优雅的面向注解的依赖注入模型。不用再去显式地声明应用程序组件了，也不再需要去继承某个基础的控制器类了。
4.Spring 3.0，有了一套基于Java的全新配置，它能够取代XML。在Spring 3.1里，一系列以@Enable开头的注解进一步完善了这一特性。
5.Spring 4.0对条件化配置提供了支持，根据应用程序的Classpath、环境和其他因素，运行时决策将决定使用哪些配置，忽略哪些配置。
################################ spring基础 ################################
spring四大原则：
1.使用pojo进行轻量级和最小侵入式开发
2.通过依赖注入和基于接口编程实现松耦合
3.通过aop和默认习惯进行声明式编程
4.使用aop和模板template减少模式化代码

声明bean的注解：
@Component 组件，无明确角色
@Service 在业务逻辑层使用(Service)
@Repository 在数据访问层使用（Dao）
@Controller 在展示层使用（SpringMVC）


@Configuration：
标明该类使用Spring基于Java的配置。声明当前类是一个配置类，相当于一个XML配置文件。
@Bean注解在方法上，声明当前方法的返回值是一个bean
主要原则是：
全局配置使用java配置（如数据库、MVC）；
业务Bean的配置使用注解配置（@Componet,@Service,@Repository,@Controller）



Spring支持@AspectJ的注解式切面编程：
1.@Aspect声明类是一个切面
2.使用@Before,@After,@Around等声明方法是advice
3.@Pointcut声明切入点的位置

@Scope描述的是spring容器新建Bean的方法：
1.Singleton:一个容器只有一个Bean实例，是spring的默认配置，全容器共享一个实例。
2.Prototype:每次调用都新建一个实例

Commons-io可以简化文件相关操作

################################ spring MVC ################################
@RequestMapping 用来处理映射web请求，可以注解在类和方法上；
注解在方法上的路径会继承注解在类上的路径，@RequestMapping支持servlet中的request和response作为参数。
@RequestBody 允许request的参数在request体中，而不是链接在地址后面，此注解放在参数前
@ResponseBody  支持将返回值放在response体内，而不是返回一个页面，此注解可放在返回值前或方法上
@PathVariable 用来接收路径参数，此注解放置在参数前
@RestController 是一个组合注解，组合了@Controller和@ResponseBody，返回的不是页面，而是一个json

################################ spring boot ################################
@ComponentScan：启用组件扫描，这样你写的Web控制器类和其他组件才能被自动发现并注册为Spring应用程序上下文里的Bean。
本章稍后会写一个简单的Spring MVC控制器，使用@Controller进行注解，这样组件扫描才能找到它。

@EnableAutoConfiguration ： 这个不起眼的小注解也可以称为咒语，就是这一行配置开启了Spring Boot自动配置
的魔力，让你不用再写成篇的配置了。

自动配置中使用的条件化注解
+--------------------------------+----------------------------------------------------------------------------+
|@Conditional					 |根据满足某一个条件创建一个Bean                                               |
|@ConditionalOnBean              |配置了某个特定Bean                                                          |
|@ConditionalOnMissingBean       |没有配置特定的Bean                                                          |
|@ConditionalOnClass             |Classpath里有指定的类                                                       |
|@ConditionalOnMissingClass      |Classpath里缺少指定的类                                                     |
|@ConditionalOnExpression        |给定的Spring Expression Language（SpEL）表达式计算结果为true                |
|@ConditionalOnJava              |Java的版本匹配特定值或者一个范围值                                          |
|@ConditionalOnJndi              |参数中给定的JNDI位置必须存在一个，如果没有给参数，则要有JNDIInitialContext  |
|@ConditionalOnProperty          |指定的配置属性要有一个明确的值                                              |
|@ConditionalOnResource          |Classpath里有指定的资源                                                     |
|@ConditionalOnWebApplication    |这是一个Web应用程序                                                         |
|@ConditionalOnNotWebApplication |这不是一个Web应用程序                                                       |
+--------------------------------+----------------------------------------------------------------------------+
一个简单的例子：
简单的条件类只有在Classpath里存在JdbcTemplate时才会生效：
package readinglist;
import org.springframework.context.annotation.Condition;
import org.springframework.context.annotation.ConditionContext;
import org.springframework.core.type.AnnotatedTypeMetadata;
public class JdbcTemplateCondition implements Condition {
	@Override
	public boolean matches(ConditionContext context,AnnotatedTypeMetadata metadata) {
	try {
		context.getClassLoader().loadClass("org.springframework.jdbc.core.JdbcTemplate");
		return true;
	} catch (Exception e) {
		return false;
	}
	}
}
当你用Java来声明Bean的时候，可以使用这个自定义条件类：
@Conditional(JdbcTemplateCondition.class)
public MyService myService() {
	
}
在这个例子里，只有当JdbcTemplateCondition类的条件成立时才会创建MyService这个Bean。也就是说MyService Bean创建的条件是Classpath里有JdbcTemplate。
@ImportResource可以加载XML配置
@ConfigurationProperties 加载properties文件内的配置，通过prefix指定配置前缀，locations指定文件位置
# 自定义配置文件，导入外部属性
@PropertySources({
        @PropertySource("classpath:custom/my.properties"),
        @PropertySource(value = "${my.properties}", ignoreResourceNotFound = true)})
@Configuration
#想要覆盖Spring Boot的自动配置：
你所要做的仅仅是编写一个显式的配置。Spring Boot会发现你的配置，随后降低自动配置的优先级，以你的配置为准。
# 简单的例子：@ConditionalOnMissingBean注解是覆盖自动配置的关键。
@Bean
@ConditionalOnMissingBean(JdbcOperations.class)
public JdbcTemplate jdbcTemplate() {
	return new JdbcTemplate(this.dataSource);
}
jdbcTemplate()方法上添加了@Bean注解，在需要时可以配置出一个JdbcTemplate Bean。
但它上面还加了@ConditionalOnMissingBean注解，要求当前不存在JdbcOperations类型（JdbcTemplate实现了该接口）的Bean时才生效。
如果当前已经有一个JdbcOperations Bean了，条件即不满足，不会执行jdbcTemplate()方法。
# 一个简单的例子：
SpringBootWebSecurityConfiguration。以下是其中的一个代码片段：
@Configuration
@EnableConfigurationProperties
@ConditionalOnClass({ EnableWebSecurity.class })
@ConditionalOnMissingBean(WebSecurityConfiguration.class)
@ConditionalOnWebApplication
public class SpringBootWebSecurityConfiguration {
...
}
@ConditionalOnMissingBean 注解要求当下没有 WebSecurityConfiguration 类型的Bean。
虽然表面上我们并没有这么一个Bean，但通过在自定义的 SecurityConfig 类上添加@EnableWebSecurity注解，
我们实际上间接创建了一个WebSecurityConfiguration Bean。所以在自动配置时，这个Bean就已经存在了，
@ConditionalOnMissingBean条件不成立，SpringBoot WebSecurityConfiguration提供的配置就被跳过了。

#spring boot日志
springboot使用logback作为日志框架

# 表单验证
限制	说明
@Null	限制只能为null
@NotNull	限制必须不为null
@AssertFalse	限制必须为false
@AssertTrue	限制必须为true
@DecimalMax(value)	限制必须为一个不大于指定值的数字
@DecimalMin(value)	限制必须为一个不小于指定值的数字
@Digits(integer,fraction)	限制必须为一个小数，且整数部分的位数不能超过integer，小数部分的位数不能超过fraction
@Future	限制必须是一个将来的日期
@Max(value)	限制必须为一个不大于指定值的数字
@Min(value)	限制必须为一个不小于指定值的数字
@Past	限制必须是一个过去的日期
@Pattern(value)	限制必须符合指定的正则表达式
@Size(max,min)	限制字符长度必须在min到max之间
@Past	验证注解的元素值（日期类型）比当前时间早
@NotEmpty	验证注解的元素值不为null且不为空（字符串长度不为0、集合大小不为0）
@NotBlank	验证注解的元素值不为空（不为null、去除首位空格后长度为0），不同于@NotEmpty，@NotBlank只应用于字符串且在比较时会去除字符串的空格
@Email	验证注解的元素值是Email，也可以通过正则表达式和flag指定自定义的email格式

# spring boot注解
@SpringBootApplication将三个有用的注解组合在了一起：
1.@Configuration：标明该类使用Spring基于Java的配置。我们会更倾向于使用基于Java而不是XML的配置。
2.@ComponentScan：启用组件扫描，这样Web控制器类和其他组件才能被自动发现并注册为Spring应用程序上下文里的Bean。控制器，使用@Controller进行注解，这样组件扫描才能找到它。
3.@EnableAutoConfiguration ： 这个不起眼的小注解开启了Spring Boot自动配置的魔力。

# Spring Boot能从多种属性源获得属性，包括如下几处，按优先级排列。
(1) 命令行参数
(2) java:comp/env里的JNDI属性
(3) JVM系统属性
(4) 操作系统环境变量
(5) 随机生成的带random.*前缀的属性（在设置其他属性时，可以引用它们，比如"${random.long}"）
(6) 应用程序以外的application.properties或者appliaction.yml文件
(7) 打包在应用程序内的application.properties或者appliaction.yml文件
(8) 通过@PropertySource标注的属性源
(9) 默认属性

# 一个简单的例子，从主配置文件抽取自定义属性加载bean
我们可以在application.properties里设置该属性：
amazon.associateId=habuma-20

@Controller
@RequestMapping("/")
@ConfigurationProperties(prefix="amazon")
public class ReadingListController {
	private String associateId;
	...
	setter()
	getter()
}

# 更好的解决方案：
与其在ReadingListController里加载配置属性，还不如创建一个单独的Bean，为它加上@ConfigurationProperties注解，
让这个Bean收集所有配置属性。 AmazonProperties 就是一个例子，它用于加载Amazon相关的配置属性。

@Component
@ConfigurationProperties("amazon")
public class AmazonProperties {
	private String associateId;
	public void setAssociateId(String associateId) {
		this.associateId = associateId;
	}
	public String getAssociateId() {
		return associateId;
	}
}
有了加载amazon.associateId 配置属性的AmazonProperties 后， 我们可以调整ReadingListController，让它从注入的AmazonProperties中获取
Amazon Associate ID。

#spring actuator 默认是关闭的，如果想要打开，需要在配置文件加入：
management.endpoints.web.exposure.include=*
#如果要测试MVC，在单元测试中可以用mockMvc模拟url访问情况,测试类+@WebAppConfiguration
#如果要测试运行中的url，可以使用RestTemplate，测试类+@WebAppConfiguration