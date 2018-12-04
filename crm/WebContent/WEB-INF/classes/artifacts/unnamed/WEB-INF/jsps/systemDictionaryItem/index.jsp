<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 导入公共jsp，就拥有了公共配置：easyui,js,css -->
<%@include file="/WEB-INF/jsps/common.jsp"%>
<title>数据字典明细</title>
<script type="text/javascript">
	

</script>

<script type="text/javascript">
	
</script>    
</head>
<body>
	<table id="systemDictionaryItemDataGrid" title="部门列表"
		class="easyui-datagrid" fit="true" url="/systemDictionaryItem/list"
		toolbar="#systemDictionaryItemToolbar" pagination="true"
		rownumbers="true" fitColumns="true" singleSelect="true">
		<thead>
			<tr>
				<!-- 显示数据：更加th的field对应显示 -->
				<th field="id" width="50">编号</th>
				<th field="name" width="50">字典明细名称</th>
				<th field="requence" width="50">字典明细序号</th>
				<th field="intro" width="50">字典明细简介</th>
				<th field="parent" width="50">字典目录</th>
			</tr>
		</thead>
	</table>
	<!-- 2 toolBar -->
	<div id="systemDictionaryItemToolbar">
		<a data-cmd="systemDictionadd" href="javascript:void(0)"
			class="easyui-linkbutton c1" iconCls="icon-add " plain="true">新增</a>
		<a data-cmd="systemDictionaryItemEdit" href="javascript:void(0)"
			class="easyui-linkbutton c3" iconCls="icon-edit" plain="true">修改</a>
		<a data-cmd="systemDictionaryItemDelete" href="javascript:void(0)"
			class="easyui-linkbutton c5" conCls="icon-remove" plain="true">删除</a>
		<a data-cmd="systemDictionaryItemRefresh" href="javascript:void(0)"
			class="easyui-linkbutton c7" iconCls="icon-reload" plain="true">刷新</a>
		<div>
			<form id="systemDictionaryItemSearchForm" action="">
				<!-- 关键字，状态 -->
				关键字：<input id="q" type="text" name="q"> <a
					href="javascript:void(0)" data-cmd="systemDictionaryItemSearch"
					class="easyui-linkbutton c3" iconCls="icon-search" plain="true">查询</a>
			</form>
		</div>
	</div>
	<!-- 模态框 -->
	<div id="systemDictionaryItemDialog" class="easyui-dialog"
		style="width: 400px" closed="true"
		buttons="#systemDictionaryItemDialogButtons">
		<form id="systemDictionaryItemFm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<table>
				<input type="hidden" name="id" />

				<tr>
					<td>字典明细名称</td>
					<td><input name="name" class="easyui-validatebox" required="true"></td>
				</tr>

				<tr>
					<td>字典明细序号</td>
					<td><input name="requence" class="easyui-validatebox"
						required="true"></td>
				</tr>

				<tr>
					<td>字典明细简介</td>
					<td><input name="intro" class="easyui-validatebox" required="true"></td>
				</tr>

				<tr>
					<td>字典目录</td>
					<td><input id="cbb" class="easyui-validatebox" name="parent.id"></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="systemDictionaryItemDialogButtons">
		<a id="systemDictionaryItemSave" data-cmd="systemDictionaryItemSave"
			href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" style="width: 90px">保存</a> <a id="systemDictionaryItemCancel"
			data-cmd="systemDictionaryItemCancel" href="javascript:void(0)"
			class="easyui-linkbutton c5" iconCls="icon-cancel"
			style="width: 90px">取消</a>
	</div>

</body>
</html>