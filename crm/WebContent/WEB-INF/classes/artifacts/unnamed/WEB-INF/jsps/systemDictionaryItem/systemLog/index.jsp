<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/WEB-INF/jsps/common.jsp"%>
<title>系统日志</title>
</head>
<script type="text/javascript">

</script>
<body>

	<table id="systemLog" title="系统菜单" class="easyui-datagrid"
		fit=true url="/systemLog/list" toolbar="#toolbar" pagination="true"
		rownumbers="true" fitColumns="true" singleSelect="true">
		<thead>
			<tr>
				<th field="id" width="50">ID</th>
				<th field="opUser" width="50">操作用户</th>
				<th field="opTime"  width="50">操作时间</th>
				<th field="opIp" width="50">登录IP</th>
				<th field="function" width="50">使用功能</th>
				<th field="params" width="50">操作参数信息</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<form  id ="searchForm" >
				关键字:<input id="q" name="q" type="text" class="easyui-textbox">	
				<a  data-cmd="search"  href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true">查询</a>	
		</form>
	</div>



</body>
</html>