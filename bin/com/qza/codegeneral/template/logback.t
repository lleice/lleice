<?xml version="1.0" encoding="UTF-8"?>
<configuration>
	<appender name="console" class="ch.qos.logback.core.ConsoleAppender">
		<encoder>
			<pattern>%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n
			</pattern>
			<charset>UTF-8</charset>
		</encoder>
	</appender>

	<appender name="rollingFile"
		class="ch.qos.logback.core.rolling.RollingFileAppender">
		<file>/data/logs/${projectName}.log</file>
		<rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
			<fileNamePattern>/data/logs/${projectName}.%d{yyyy-MM-dd}.log
			</fileNamePattern>
		</rollingPolicy>
		<encoder>
			<pattern>%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n
			</pattern>
			<charset>UTF-8</charset>
		</encoder>
	</appender>

	<!-- project default level -->
	<logger name="${package}" level="INFO" />


	<logger name="jdbc.sqlonly">
		<level value="OFF" />
	</logger>

	<logger name="jdbc.sqltiming">
		<level value="INFO" />
	</logger>

	<logger name="jdbc.audit">
		<level value="OFF" />
	</logger>

	<logger name="jdbc.resultset">
		<level value="OFF" />
	</logger>

	<logger name="jdbc.connection">
		<level value="OFF" />
	</logger>

	<!--log4jdbc -->
	<!-- <logger name="jdbc.sqltiming" level="DEBUG" /> <logger name="com.ibatis" 
		level="DEBUG" /> <logger name="com.ibatis.common.jdbc.SimpleDataSource" level="DEBUG" 
		/> <logger name="com.ibatis.common.jdbc.ScriptRunner" level="INFO" /> <logger 
		name="com.ibatis.sqlmap.engine.impl.SqlMapClientDelegate" level="info" /> 
		<logger name="java.sql.Connection" level="INFO" /> <logger name="java.sql.Statement" 
		level="INFO" /> <logger name="java.sql.PreparedStatement" level="INFO" /> 
		<logger name="java.sql.ResultSet" level="INFO" /> -->
	<root level="INFO">
		<appender-ref ref="console" />
		<appender-ref ref="rollingFile" />
	</root>
</configuration>