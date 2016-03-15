<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${className}保存页面</title>
</head>
<body>  
	<!-- content start -->
	<div class="admin-content">   
		<div class="am-cf am-padding">  
			<div class="am-fl am-cf">
				<button type="button" class="am-btn am-icon-mail-reply-all" onClick="window.location = '${ctx}/admin/${className}'"></button>
				<strong class="am-text-primary am-text-lg">${className}</strong> / <small>详情</small>
			</div>
		</div>
		<div class="am-g am-margin-top">
${cgFieId} 
		</div>      
	</div>
	<!-- content end --> 
</body>
</html>