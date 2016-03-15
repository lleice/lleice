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
				<strong class="am-text-primary am-text-lg">${className}</strong> / <small>更新</small>
			</div>
		</div>
		<form id="myform" class="am-form" action="${ctx}/admin/${className}/update" method="post"> 
			<input type="hidden" name="id" value="${${className}.id}">
			<div class="am-g am-margin-top">
${cgFieId} 
			</div>    
		</form> 
		<div class="am-margin">
			<div class="am-g am-margin-top">
				<div class="am-u-sm-12 am-u-md-8 am-text-center"> 
					<button type="button" class="am-btn am-btn-primary am-btn-xs" onclick="ajaxFormSubmit('${ctx}/admin/${className}')">保  存</button> 
				</div> 
			</div>
		</div>    
	</div>
	<!-- content end --> 
</body>
</html>