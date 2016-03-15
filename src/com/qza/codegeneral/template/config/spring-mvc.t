<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:context="http://www.springframework.org/schema/context"
	xmlns:mvc="http://www.springframework.org/schema/mvc"
	xsi:schemaLocation="http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc-3.2.xsd
		http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.2.xsd
		http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-3.2.xsd">

	<!-- 自动扫描且只扫描@Controller -->
	<context:component-scan base-package="${package}"
		use-default-filters="false">
		<context:include-filter type="annotation"
			expression="org.springframework.stereotype.Controller" />
		<context:include-filter type="annotation"
			expression="org.springframework.web.bind.annotation.ControllerAdvice" />
		<!-- 自动扫描@Service(防止事务失效) -->
		<context:include-filter type="annotation" expression="org.springframework.stereotype.Service"/>
	</context:component-scan>

	<mvc:annotation-driven
		content-negotiation-manager="contentNegotiationManager">
		<mvc:message-converters register-defaults="true">
			<!-- 将StringHttpMessageConverter的默认编码设为UTF-8 -->
			<bean class="org.springframework.http.converter.StringHttpMessageConverter">
				<constructor-arg value="UTF-8" />
			</bean>
		</mvc:message-converters>
	</mvc:annotation-driven>

	<!-- REST中根据URL后缀自动判定Content-Type及相应的View -->
	<bean id="contentNegotiationManager"
		class="org.springframework.web.accept.ContentNegotiationManagerFactoryBean">
		<property name="mediaTypes">
			<value>
				json=application/json
				xml=application/xml
			</value>
		</property>
	</bean>

	<!-- 定义JSP文件的位置 -->
	<bean
		class="org.springframework.web.servlet.view.InternalResourceViewResolver">
		<property name="prefix" value="/WEB-INF/views/" />
		<property name="suffix" value=".jsp" />
		<property name="order" value="0" />
	</bean>
	
	<!-- 配置freeMarker视图解析器 -->  
    <bean id="viewResolverFtl" class="org.springframework.web.servlet.view.freemarker.FreeMarkerViewResolver">  
        <property name="viewClass" value="org.springframework.web.servlet.view.freemarker.FreeMarkerView"/>  
        <property name="contentType" value="text/html; charset=utf-8"/>  
        <property name="cache" value="true" /> 
        <property name="requestContextAttribute" value="request"/> <!-- 此处等同于JSP中的request -->
        <property name="suffix" value=".ftl" /> <!-- 配置模板的文件格式 -->
        <property name="order" value="1"/>  
    </bean> 
    
    <!-- 配置freeMarker的模板路径 -->  
    <bean id="freemarkerConfig" class="org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer">  
        <property name="templateLoaderPath" value="/WEB-INF/ftl/" />  
        <property name="freemarkerVariables">  
            <map>  
                <entry key="xml_escape" value-ref="fmXmlEscape" />  
            </map>  
        </property>  
        <property name="defaultEncoding" value="utf-8" />  
        <property name="freemarkerSettings">  
            <props>  
                <prop key="template_update_delay">3600</prop> <!-- 正式环境中配置3600秒更新一次 -->
                <prop key="whitespace_stripping">true</prop> <!-- 去除多余的空格 -->
                <prop key="date_format">yyyy-MM-dd</prop> <!-- 显示短日期格式 -->
                <prop key="time_format">HH:mm:ss</prop> <!-- 显示时间格式 -->
                <prop key="datetime_format">yyyy-MM-dd HH:mm:ss</prop> <!-- 显示完整日期格式 -->
                <prop key="number_format">#0.####</prop> <!-- 数字显示格式 -->
                <prop key="boolean_format">true,false</prop> <!-- Boolean值显示 -->
                <prop key="classic_compatible">true</prop> <!-- 如果变量为null,转化为空字符串 -->
            </props>  
        </property>  
    </bean>
          
    <bean id="fmXmlEscape" class="freemarker.template.utility.XmlEscape"/>       	


	<!-- 容器默认的DefaultServletHandler处理 所有静态内容与无RequestMapping处理的URL -->
	<mvc:default-servlet-handler />

	<!-- 定义无需Controller的url<->view直接映射 -->
	<mvc:view-controller path="/" view-name="redirect:/index" />

	<!-- 将Controller抛出的异常转到特定View, 保持SiteMesh的装饰效果 -->
	<bean
		class="org.springframework.web.servlet.handler.SimpleMappingExceptionResolver">
		<property name="exceptionMappings">
			<props>
				<prop key="java.lang.Throwable">error/500</prop>
			</props>
		</property>
	</bean>

	<!-- 文件上传 -->
	<bean id="multipartResolver"
		class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
	    <property name="maxUploadSize"><value>104857600</value></property>  
	</bean>
    
	<!-- 
			支持 Shiro对Controller的方法级AOP安全控制 begin -->
		<bean
			class="org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator"
			depends-on="lifecycleBeanPostProcessor">
			<property name="proxyTargetClass" value="true" />
		</bean>

		<bean
			class="org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor">
			<property name="securityManager" ref="securityManager" />
		</bean>
		<!-- end -->

</beans>
