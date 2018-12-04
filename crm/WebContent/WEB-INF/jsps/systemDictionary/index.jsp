<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>数据字典管理</title>
<%@include file="/WEB-INF/jsps/common.jsp"%>
<script type="text/javascript" src="/resources/js/common.js"></script>
<script type="text/javascript"
	src="/resources/js/systemDictionary/systemDictionary.js"></script>
<script type="text/javascript"
	src="/resources/js/systemDictionary/systemDictionaryItem.js"></script>
<script type="text/javascript">
	function onClickRow(index, row) {
		var parentId = row.id;
		$("#systemDictionaryItemDatagrid").datagrid("load", {
			"parentId" : parentId
		})
	}
</script>
</head>
<!-- 以body作为父亲节点 -->
<body class="easyui-layout">
	<div data-options="region:'west',title:'字典目录'" style="width: 50%;">
		<!-- 1、数据表格 -->
		<table id="systemDictionaryDatagrid" class="easyui-datagrid"
			url="/systemDictionary/list" fit="true" border="false"
			fitColumns="true" singleSelect="true" pagination="true"
			rownumbers="true" toolbar="#datagridToolbar"
			data-options="onClickRow:onClickRow">
			<thead>
				<tr>
					<th field="name" width="10">字典目录名称</th>
					<th data-options="field:'sn',width:10">字典目录编号</th>
					<th data-options="field:'intro',width:10">字典目录简介</th>
					<th field="state" width="10" formatter="stateFormatter">状态</th>
				</tr>
			</thead>
		</table>
		<!-- 数据表格按钮 -->
		<div id="datagridToolbar">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-add" plain="true" data-cmd="systemDictionadd">添加</a> <a
				href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-edit" plain="true" data-cmd="systemDictionaryEdit">编辑</a>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-remove" plain="true" data-cmd="systemDictionaryDelete">删除</a>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-reload" plain="true"
				data-cmd="systemDictionaryRefresh">刷新</a>
			<div>
				<form id="searchForm" method="post">
					关键字：<input name="q" size="10" /> <a href="javascript:void(0)"
						class="easyui-linkbutton" iconCls="icon-search" plain="true"
						data-cmd="search">搜索</a>
				</form>
			</div>
		</div>
		<!-- 2、添加编辑对话框 -->
		<div id="systemDictionaryDialog" class="easyui-dialog"
			style="width: 360px; height: 260px; padding: 10px 20px"
			title="数据字典添加面板" buttons="#dialogButtons" closed="true"
			modal="true">
			<form id="systemDictionaryForm" method="post">
				<input name="id" type="hidden" />
				<div class="ftitle">数据字典信息</div>
				<table align="center">
					<tr>
						<td>字典目录名称：</td>
						<td><input name="name" style="width: 150px"
							class="easyui-validatebox" required="true" /></td>
					</tr>
					<tr>
						<td>字典目录编号:</td>
						<td><input class='easyui-validatebox' type='text' name='sn'></input></td>
					</tr>
					<tr>
						<td>字典目录编号:</td>
						<td><input class='easyui-validatebox' type='text'
							name='intro'></input></td>
					</tr>
					<tr>
						<td>状态:</td>
						<td><input class='easyui-validatebox' type='text'
							name='state'></input></td>
							
					</tr>

				</table>
			</form>
		</div>
		<!-- 对话框按钮 -->
		<div id="dialogButtons">
			<a href="javascript:void(0)" class="easyui-linkbutton c8"
				iconCls="icon-ok" data-cmd="systemDictionarySave"
				style="width: 90px">保存</a> <a href="javascript:void(0)"
				class="easyui-linkbutton" iconCls="icon-cancel" data-cmd="cancel"
				style="width: 90px">取消</a>
		</div>
	</div>

	<!--  ====lf==============================lf==============lf==================================================================================== -->
<div data-options="region:'east',iconCls:'icon-reload',title:'字典明细 '" style="width:50%;">
		<!-- 1、数据表格 -->
		<table id="systemDictionaryItemDatagrid" class="easyui-datagrid" url="/systemDictionaryItem/list"
			fit="true" border="false" fitColumns="true" singleSelect="true" pagination="true"
			rownumbers="true" toolbar="#datagridToolbar2">
			<thead>
				<tr>
					<th field="name" width="10">字典明细名称</th>
					<th data-options="field:'requence',width:10">字典明细序号</th>
					<th data-options="field:'intro',width:10">字典明细简介</th><!-- 
					<th data-options="field:'parent',width:10" formatter="objFormatter">字典目录</th> -->
					<th field="parent" width="10" formatter="objFormatter">字典明细名称</th>
	
				</tr>
			</thead>
		</table>
		<!-- 数据表格按钮 -->
		<div id="datagridToolbar2">
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" data-cmd="create2">添加</a> <a
				href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" data-cmd="edit2">编辑</a> <a
				href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" data-cmd="remove2">删除</a> <a
				href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" plain="true" data-cmd="reload2">刷新</a>
			<div>
				<form id="searchForm2" method="post">
					关键字：<input name="q" size="10" /> <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search"
						plain="true" data-cmd="search2">搜索</a>
				</form>
			</div>
		</div>
		<!-- 2、添加编辑对话框 -->
		<div id="systemDictionaryItemDialog" class="easyui-dialog" style="width: 360px; height: 260px; padding: 10px 20px"
			title="字典明细添加面板" buttons="#dialogButtons2" closed="true" modal="true">
			<form id="systemDictionaryItemForm" method="post">
				<input name="id" type="hidden" />
				<div class="ftitle">字典明细信息</div>
				<table align="center">
					<tr>
						<td>字典明细名称：</td>
						<td><input name="name" style="width: 150px" class="easyui-validatebox" required="true" /></td>
					</tr>
					<tr>
						<td>字典明细序号:</td>
						<td><input class='easyui-validatebox' type='text' name='requence'></input></td>
					</tr>
					<tr>
						<td>字典明细简介:</td>
						<td><input class='easyui-validatebox' type='text' name='intro'></input></td>
					</tr>
					<tr>
					<td>字典目录:</td>
					<td>
						<select
						id="menu" class="easyui-combogrid" name="parent.id"
						style="width: 200px;"
						data-options="    
			            panelWidth:450,   
			            fitColumns:'true',  
			            idField:'id', 
			            textField:'name',    
			            url:'/systemDictionary/list',  
			            pagination:true,
			            mode:'remote',
			            columns:[[    
			            <!--     {field:'sn;',title:'字典目录编号',width:60},  -->   
			                {field:'name',title:'字典目录名称',width:100},    
			                {field:'intro',title:'字典目录简介',width:100},    
			                {field:'state',title:'状态',width:120,formatter:stateFormatter} 
			            ]]    
			        "></select>   
					</td>
				</tr>
	
				</table>
			</form>
		</div>
		<!-- 对话框按钮 -->
		<div id="dialogButtons2">
			<a href="javascript:void(0)" class="easyui-linkbutton c8" iconCls="icon-ok" data-cmd="save2" style="width: 90px">保存</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" data-cmd="cancel2" style="width: 90px">取消</a>
		</div>
	</div>   
</body>
</html>