<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.2.xsd"
	default-lazy-init="true">

	<bean id="javaMailSender" class="org.springframework.mail.javamail.JavaMailSenderImpl">
		<property name="host" value="smtp.qq.com" />
		<property name="username" value="webmaster@chineseml.net" />
		<property name="password" value="qiChinese136109qi" />
		<property name="defaultEncoding" value="UTF-8" />
		<property name="javaMailProperties">
			<props>
				<prop key="mail.smtp.auth">true</prop>
				<!-- gmail smtp server 配置 -->
				<prop key="mail.smtp.starttls.enable">true</prop>
				<prop key="mail.smtp.socketFactory.port">465</prop>
				<prop key="mail.smtp.socketFactory.class">javax.net.ssl.SSLSocketFactory</prop>
				<prop key="mail.smtp.socketFactory.fallback">false</prop>
			</props>
		</property>
	</bean>
</beans>