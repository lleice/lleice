<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans" 
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xmlns:context="http://www.springframework.org/schema/context" 
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.2.xsd
	 http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-3.2.xsd 
	"
	default-lazy-init="true">

	<description>Shiro安全配置</description>
	
	<context:property-placeholder ignore-unresolvable="true" location="classpath:config.properties" />

	<!-- 配置权限管理器 -->
	<bean id="securityManager" class="org.apache.shiro.web.mgt.DefaultWebSecurityManager">
		<!-- ref对应我们写的realm  shiroDbRealm --> 
		<property name="realm" ref="shiroDbRealm" />
		<!-- 使用下面配置的缓存管理器 -->
		<property name="cacheManager" ref="shiroEhcacheManager" />
		<!-- 使用rememberMe管理器 -->
		<property name="rememberMeManager" ref="rememberMeManager"/>
	</bean>

	<!-- 項目自定义的Realm, 所有accountService依赖的dao都需要用depends-on声明  -->
	<bean id="shiroDbRealm" class="${package}.shiro.ShiroDbRealm"></bean>
	
	<!-- 会话Cookie模板 -->
    <bean id="sessionIdCookie" class="org.apache.shiro.web.servlet.SimpleCookie">
        <constructor-arg value="sid"/>
        <property name="httpOnly" value="true"/>
        <property name="maxAge" value="-1"/>
    </bean>

    <bean id="rememberMeCookie" class="org.apache.shiro.web.servlet.SimpleCookie">
        <constructor-arg value="rememberMe"/>
        <property name="httpOnly" value="true"/>
        <property name="path" value="/"/>
        <property name="domain" value="${shiro.cookies.domain}"/>
        <property name="maxAge" value="${shiro.cookies.maxAge}"/><!--  2592000 = 30天 -->
    </bean>

    <!-- rememberMe管理器 -->
    <bean id="rememberMeManager" class="org.apache.shiro.web.mgt.CookieRememberMeManager">
        <!-- rememberMe cookie加密的密钥 建议每个项目都不一样 默认AES算法 密钥长度（128 256 512 位）-->
        <property name="cipherKey"
                  value="#{T(org.apache.shiro.codec.Base64).decode('4AvVhmFLUs0KTA3Kprsdag==')}"/>
        <property name="cookie" ref="rememberMeCookie"/>
    </bean>
	
	<!-- 自定义对 shiro的连接约束,结合shiroFilter实现动态获取资源 -->
    <bean id="chainDefinitionSectionMetaSource" class="${package}.shiro.ChainDefinitionSectionMetaSource">
    <!-- 默认的连接配置 -->
    <property name="filterChainDefinitions">
        <value>
            /logout = logout
            /* = anon
			<!-- anon表示此地址不需要任何权限即可访问 -->  
<!-- 			/acct/login = authc -->
<!-- 			/webLogin/web_login = authc,captchaAuthc -->
<!-- 			/acct/error/403 = authc -->
<!-- 			/bookPlay/** = authc  -->
<!-- 			/acct = user -->
<!-- 			/acct/** = user -->
			  <!-- /acctOwner = role[admin] -->
			 <!--  /acct = role[admin] -->
<!-- 			/acctOwner/** = user -->
            <!-- /index = perms[security:index] -->
        </value>
    </property>
    </bean>
    	
	<!-- 配置shiro的过滤器工厂类，id- shiroFilter要和我们在web.xml中配置的过滤器一致 --> 
	<bean id="shiroFilter" class="org.apache.shiro.spring.web.ShiroFilterFactoryBean"> 
	    <!-- 调用我们配置的权限管理器 -->   
		<property name="securityManager" ref="securityManager" />
		<!-- 配置我们的登录请求地址 -->
		<property name="loginUrl" value="${shiro.loginUrl}" />
		<!-- 配置我们在登录页登录成功后的跳转地址，如果你访问的是非/login地址，则跳到您访问的地址 -->  
		<property name="successUrl" value="${shiro.successUrl}" />
		 <!-- 如果您请求的资源不再您的权限范围，则跳转到/403请求地址-->
        <property name="unauthorizedUrl" value="${shiro.unauthorizedUrl}"/> 
        <!-- shiro连接约束配置,在这里使用自定义的动态获取资源类 -->
        <property name="filterChainDefinitionMap" ref="chainDefinitionSectionMetaSource" />
	</bean>
	 
	<!-- 用户授权信息Cache, 采用EhCache -->
	<bean id="shiroEhcacheManager" class="org.apache.shiro.cache.ehcache.EhCacheManager">
		<property name="cacheManagerConfigFile" value="classpath:/security/ehcache-shiro.xml"/>
	</bean>
	
	<!-- 保证实现了Shiro内部lifecycle函数的bean执行 -->
	<bean id="lifecycleBeanPostProcessor" class="org.apache.shiro.spring.LifecycleBeanPostProcessor"/>
	
</beans>