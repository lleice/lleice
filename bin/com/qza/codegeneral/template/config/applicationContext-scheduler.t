<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:task="http://www.springframework.org/schema/task"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.2.xsd
	http://www.springframework.org/schema/task http://www.springframework.org/schema/task/spring-task-3.2.xsd"
	default-lazy-init="true">

 <description>Spring Scheduled 定时器配置</description>

	 <task:scheduler id="springScheduler" pool-size="10"/>
	  <!--<task:scheduled-tasks scheduler="springScheduler">-->
	 	 
	 	<!--<task:scheduled ref="weatherScheduler" method="weatherImporter" cron="0 35 0,14 * * *"  /> -->
	 	<!-- <task:scheduled ref="hotelGBScheduler" method="tongchengHotelGBImporter" cron="0 0 7 * * ?" /> -->
	 	<!-- <task:scheduled ref="miaoYouTicketOpera" method="transMiaoYouScene" cron="0 0 5 * * ?" /> -->
<!-- 	<task:scheduled ref="hotelOrderScheduler" method="checkOrder" cron="0 0/1 *  * * ?"/> 
	   <task:scheduled ref="hotelScheduler" method="tongchengHotelDetailImporter" cron="0 0 3  * * ?"/>
	    <task:scheduled ref="ctripAirlineScheduler" method="ctripFlightCityImporter" cron="0 0/2 * * * ?" />
	  	<task:scheduled ref="hotelOrderScheduler" method="tongchengHotelOrderImporter" cron="0 0/1 *  * * ?"/>
	    <task:scheduled ref="ctripAirlineScheduler" method="ctripAirportImporter" cron="0 0/1 * * * ?" />
	    <task:scheduled ref="ctripAirlineScheduler" method="ctripAirlineImporter" cron="0 0/1 * * * ?" />
	    <task:scheduled ref="areaScheduler" method="tongchengCountyImporter"
			cron="0 0/1 * * * ?" />
	    <task:scheduled ref="areaScheduler" method="tongchengCityImporter"
			cron="0 0 1 * * ?" />
	    <task:scheduled ref="areaScheduler" method="tongchengAreaImporter" cron="0 0/1 *  * * ?"/>
	  	<task:scheduled ref="hotelBrandScheduler" method="tongchengHotelBrandImporter" cron="0 0/1 *  * * ?"/>
	    <task:scheduled ref="hotelCommentScheduler" method="tongchengHotelCommentImporter" cron="0 0/2 *  * * ?"/> 
	 	<task:scheduled ref="hotelServiceScheduler" method="tongchengHotelServiceImporter" cron="0 0/1 *  * * ?"/>
	  	 <task:scheduled ref="hotelBookingPolicyScheduler" method="tongchengHotelBookingPolicyImporter" cron="0 0/1 *  * * ?"/>
	  	<task:scheduled ref="hotelGuaranteePolicyScheduler" method="tongchengHotelGuaranteePolicyImporter" cron="0 0/1 *  * * ?"/>-->
		<!-- <task:scheduled ref="sceneScheduler" method="tongchengSceneThemeImporter" cron="0 42 11 * * ?"/>  -->
		<!-- <task:scheduled ref="sceneScheduler" method="tongchengSceneThemeTypeRelationImporter" cron="0 17 17 * * ?"/> --> 
		<!-- <task:scheduled ref="sceneScheduler" method="tongchengSceneImporter" cron="0 08 17 * * ?"/> -->
     	<!--  <task:scheduled ref="hotelTrafficScheduler" method="tongchengHotelTrafficImporter" cron="0 0/1 * * * ?" />
		<task:scheduled ref="hotelRoomScheduler" method="tongchengHotelRoomImporter" cron="0 0/1 *  * * ?" />
		<task:scheduled ref="hotelRoomPricePolicyScheduler" method="tongchengHotelRoomPricePolicyImporter" cron="0 0/1 * * * ?" /> 
		<task:scheduled ref="hotelBrandCitysScheduler" method="tongchengBrandCitysImporter" cron="0 0/1 * * * ?" /> 
		<task:scheduled ref="hotelImageScheduler" method="tongchengHotelImageImporter" cron="0 0/1 * * * ?" /> -->
	<!-- </task:scheduled-tasks>   -->
</beans>