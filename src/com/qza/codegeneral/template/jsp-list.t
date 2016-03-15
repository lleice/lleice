<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>列表</title>
</head>
<body>  
	<!-- content start -->
	<div class="admin-content"> 
		<div class="am-cf am-padding">
			<div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">${className}</strong> / <small>列表页</small></div>
		</div>
		<!-- button and search -->
		<form id="${className}Form" name="${className}Form" class="form-inline" action="${ctx}/admin/${className}" method="post">
		<div class="am-g">
			<div class="am-u-sm-12 am-u-md-6">
				<div class="am-btn-toolbar">
					<div class="am-btn-group am-btn-group-xs">
						<a type="button" class="am-btn am-btn-default" href="${ctx}/admin/${className}/create"><span class="am-icon-plus"></span> 新增</a>  
						<button type="button" class="am-btn am-btn-default deletes" data-url="${ctx}/admin/${className}/deletes"><span class="am-icon-trash-o"></span> 删除</button>
					</div>
				</div>
			</div> 
			<div class="am-u-sm-12 am-u-md-3">
					<div class="am-input-group am-input-group-sm">
						<input type="text" class="am-form-field">
						<span class="am-input-group-btn">
							<button class="am-btn am-btn-default" type="submit">搜索</button>
						</span>
					</div>
			</div>
		</div>  
		</form>
		<!-- list -->
		<div class="am-g">
			<div class="am-u-sm-12"> 
				<table class="am-table am-table-striped am-table-hover table-main">
					<thead>
						<tr>
							<th class="table-check"><input class="keyCheckAll" type="checkbox" /></th>
${cgHead} 
							<th class="table-set">操作</th>
						</tr>
					</thead>
					<tbody> 
      					<c:forEach items="${list}" var="item">
						<tr>
							<td><input type="checkbox" class="keyCheck" value="${item.${primaryKey}}"></td>
${cgBody}
							<td>
								<div class="am-btn-toolbar">
									<div class="am-btn-group am-btn-group-xs">
										<a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="${ctx}/admin/${className}/update/${item.${primaryKey}}"><span class="am-icon-pencil-square-o"></span> 编辑</a> 
										<a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" href="${ctx}/admin/${className}/detail/${item.${primaryKey}}"><span class="am-icon-search"></span> 查看</a>
										<button type="button" class="am-btn am-btn-default delete" data-url="${ctx}/admin/${className}/delete/${item.${primaryKey}}"><span class="am-icon-trash-o"></span> 删除</button>
									</div>
								</div>
							</td>
						</tr> 
      					</c:forEach>
					</tbody>
				</table>  
				<tags:paginationAsync searchFormId="${className}Form" paginator="${paginator }"></tags:paginationAsync> 
			</div> 
		</div>
	</div>
	<!-- content end -->  
</body>
</html>