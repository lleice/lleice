<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:jee="http://www.springframework.org/schema/jee"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:aop="http://www.springframework.org/schema/aop" xmlns:tx="http://www.springframework.org/schema/tx"
	xsi:schemaLocation="http://www.springframework.org/schema/beans 
    http://www.springframework.org/schema/beans/spring-beans-3.2.xsd
	http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-3.2.xsd 
    http://www.springframework.org/schema/aop 
    http://www.springframework.org/schema/aop/spring-aop.xsd
    http://www.springframework.org/schema/jee http://www.springframework.org/schema/jee/spring-jee-3.2.xsd
	http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx-3.0.xsd"
	default-lazy-init="true">

	<description>Spring公共配置 </description>

	<aop:aspectj-autoproxy />
	<context:annotation-config />

	<!--注解控测器 -->
	<context:component-scan base-package="${package}" />

	<!-- 使用annotation 自动注册bean, 并保证@Required、@Autowired的属性被注入 -->
	<context:component-scan base-package="${package}">
		<context:exclude-filter type="annotation"
			expression="org.springframework.stereotype.Controller" />
		<context:exclude-filter type="annotation"
			expression="org.springframework.web.bind.annotation.ControllerAdvice" />
		<!-- 对@Service扫描(防止事务失效) -->
		<context:exclude-filter type="annotation" expression="org.springframework.stereotype.Service"/>

	</context:component-scan>

	<!-- annotation默认的方法映射适配器 -->
	<bean id="handlerMapping"
		class="org.springframework.web.servlet.mvc.annotation.DefaultAnnotationHandlerMapping" />
	<bean id="handlerAdapter"
		class="org.springframework.web.servlet.mvc.annotation.AnnotationMethodHandlerAdapter" />

	<!-- MyBatis配置 -->
	<bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
		<property name="dataSource" ref="dataSource" />
		<property name="configLocation" value="classpath:mybatis-config.xml"></property>
		<!-- 自动扫描entity目录, 省掉Configuration.xml里的手工配置 -->
		<property name="typeAliasesPackage" value="${package}.entity" />
		<!-- 显式指定Mapper文件位置 -->
		<property name="mapperLocations" value="classpath:/mybatis/*.xml" />
	</bean>
	<!-- 扫描basePackage下所有以@MyBatisRepository标识的 接口 -->
	<bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
		<property name="basePackage" value="${package}" />
		<property name="annotationClass"
			value="${package}.repository.MyBatisRepository" />
		<property name="sqlSessionFactoryBeanName" value="sqlSessionFactory"></property>
	</bean>


	<bean id="transactionManager"
		class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
		<property name="dataSource" ref="dataSource" />
	</bean>

	<!-- 使用annotation定义事务 -->
	<tx:annotation-driven transaction-manager="transactionManager"
		proxy-target-class="true" />

	<tx:advice id="userTxAdvice" transaction-manager="transactionManager">
		<tx:attributes>
			<tx:method name="delete*" propagation="REQUIRED" read-only="false"
				rollback-for="java.lang.Exception" no-rollback-for="java.lang.RuntimeException" />
			<tx:method name="insert*" propagation="REQUIRED" read-only="false"
				rollback-for="java.lang.RuntimeException" />
			<tx:method name="update*" propagation="REQUIRED" read-only="false"
				rollback-for="java.lang.Exception" />
			<tx:method name="save*" propagation="REQUIRED" read-only="false"
				rollback-for="java.lang.Exception" />
			<tx:method name="register*" propagation="REQUIRED"
				read-only="false" rollback-for="java.lang.Exception" />
			<tx:method name="find*" propagation="SUPPORTS" />
			<tx:method name="get*" propagation="SUPPORTS" />
			<tx:method name="select*" propagation="SUPPORTS" />
		</tx:attributes>
	</tx:advice>

 <!-- 把事务控制在Service层  -->
 <aop:config>
		<aop:pointcut id="pc"
			expression="execution(public * ${package}.service.*.*(..))" /> 
		<aop:advisor pointcut-ref="pc" advice-ref="userTxAdvice" />
	</aop:config>

	<!-- JSR303 Validator定义 -->
	<bean id="validator"
		class="org.springframework.validation.beanvalidation.LocalValidatorFactoryBean" />

	<!-- 生产环境 -->
	<beans profile="production">
		<context:property-placeholder
			ignore-unresolvable="true" location="/WEB-INF/spring/application.properties" />

		<!-- 数据源配置, 使用Tomcat JDBC连接池 -->
		<bean id="dataSource" class="org.apache.tomcat.jdbc.pool.DataSource"
			destroy-method="close">
			<!-- Connection Info -->
			<property name="driverClassName" value="${jdbc.driver}" />
			<property name="url" value="${jdbc.url}" />
			<property name="username" value="${jdbc.username}" />
			<property name="password" value="${jdbc.password}" />

			<!-- Connection Pooling Info -->
			<property name="maxActive" value="${jdbc.pool.maxActive}" />
			<property name="maxIdle" value="${jdbc.pool.maxIdle}" />
			<property name="defaultAutoCommit" value="true" />
			<!-- 连接Idle半个小时后超时 -->
			<property name="timeBetweenEvictionRunsMillis" value="1800000" />
			<property name="minEvictableIdleTimeMillis" value="900000" />

			<property name="jmxEnabled" value="true" />
			<property name="jdbcInterceptors"
				value="org.apache.tomcat.jdbc.pool.interceptor.StatementFinalizer" />
			<property name="removeAbandoned" value="true" />
			<property name="removeAbandonedTimeout" value="6" />
			<property name="logAbandoned" value="true" />
			<property name="testOnBorrow" value="true" />
			<property name="testOnReturn" value="false" />
			<property name="testWhileIdle" value="true" />
			<property name="useEquals" value="false" />
			<property name="fairQueue" value="false" />
			<property name="validationInterval" value="300000" />
			<property name="validationQuery" value="SELECT 1" />
		</bean>

		<!-- 数据源配置,使用应用服务器的数据库连接池 -->
		<!--<jee:jndi-lookup id="dataSource" jndi-name="java:comp/env/jdbc/ExampleDB" 
			/> -->
	</beans>

	<!-- local development环境 -->
	<beans profile="development">
		<context:property-placeholder
			ignore-resource-not-found="true"
			location="/WEB-INF/spring/development-application.properties" />

		<!-- Tomcat JDBC连接池 -->
		<bean id="dataSource" class="org.apache.tomcat.jdbc.pool.DataSource"
			destroy-method="close">
			<!-- Connection Info -->
			<property name="driverClassName" value="${jdbc.driver}" />
			<property name="url" value="${jdbc.url}" />
			<property name="username" value="${jdbc.username}" />
			<property name="password" value="${jdbc.password}" />

			<!-- Connection Pooling Info -->
			<property name="maxActive" value="${jdbc.pool.maxActive}" />
			<property name="maxIdle" value="${jdbc.pool.maxIdle}" />
			<property name="defaultAutoCommit" value="true" />

			<property name="jmxEnabled" value="true" />
			<property name="jdbcInterceptors"
				value="org.apache.tomcat.jdbc.pool.interceptor.StatementFinalizer" />
			<property name="removeAbandoned" value="true" />
			<property name="removeAbandonedTimeout" value="60" />
			<property name="logAbandoned" value="true" />
			<property name="testOnBorrow" value="true" />
			<property name="testOnReturn" value="false" />
			<property name="testWhileIdle" value="true" />
			<property name="useEquals" value="false" />
			<property name="fairQueue" value="false" />
			<property name="validationInterval" value="300000" />
			<property name="validationQuery" value="SELECT SYSDATE() FROM DUAL" />
		</bean>
	</beans>

</beans>    
    