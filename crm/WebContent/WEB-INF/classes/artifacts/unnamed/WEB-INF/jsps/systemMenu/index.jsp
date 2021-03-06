<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/WEB-INF/jsps/common.jsp"%>
<title>系统菜单</title>
</head>
<script type="text/javascript">
//页面加载完毕后
// 1、声明出页面需要使用的组件
 // 2、把页面的组件，缓存到上面声明的变量中
 // 3、初始化组件，修改组件的值
 // 4、创建一个"命令对象"，把当前模块所有的功能，都打包到这个对象上
 // 5、对页面所有按钮，统一监听

$(function(){
	var systermMenuDatagrid, menudlg, menufm;
	systermMenuDatagrid = $("#systermMenuDatagrid");
	menudlg = $('#menudlg');
	menufm = $('#menufm');	
	var cmdObj = {
			"cancel":function(){
				menudlg.dialog('close');
			},
			"reloadMenu":function() {
				systermMenuDatagrid.datagrid("reload");
			},
			"newMenu":function() {
				menudlg.dialog('open').dialog('center').dialog('setTitle', '新增菜单');
				menufm.form('clear');			
				$('#cbb').combobox({    
				    url:'/systemMenu/getselect',    
				    valueField:'id',    
				    textField:'name'   
				}); 
			},
			"editMenu":function() {
				var row = systermMenuDatagrid.datagrid('getSelected');
				if (row) {
					menudlg.dialog('open').dialog('center').dialog('setTitle', '编辑菜单');
					menufm.form('load', row);
					$('#cbb').combobox({    
					    url:'/systemMenu/getselect',    
					    valueField:'id',    
					    textField:'text'   
					}); 
					if (row.parent) {
						$('#cbb').combobox("setValue",row.parent.id);
					}
					
				}else {
					$.messager.alert('温馨提示', '请选中一行后,再操作!', 'error');
				}
			},"saveMenu":function () {
				menufm.form('submit', {
					url : "/systemMenu/save",
					success : function(result) {
						var result = eval('(' + result + ')');
						if (result.success) {
							menudlg.dialog('close');
							menufm.form('clear');
							systermMenuDatagrid.datagrid('reload');
							$.messager.alert('温馨提示', result.message, 'info');
						} else {
							menudlg.dialog('close');
							systermMenuDatagrid.datagrid('reload');
							$.messager.alert('温馨提示', result.message, 'error')
						}
					}
				})
			},"delMenu":function () {
				var row = systermMenuDatagrid.datagrid('getSelected');
				if (row) {
					$.messager.confirm('确认框', '你确定要删除吗?', function(r) {
						if (r) {
							$.post('/systemMenu/del', {
								id : row.id
							}, function(result) {
								if (result.success) {
									menudlg.dialog('close');
									systermMenuDatagrid.datagrid('reload');
									$.messager.alert('温馨提示', result.message, 'info');
								} else {
									menudlg.dialog('close');
									systermMenuDatagrid.datagrid('reload');
									$.messager.alert('温馨提示', result.message, 'error')
								}
							}, 'json');
						}
					});
				} else {
					$.messager.alert('温馨提示', '请选中一行后,再操作!', 'error');
				}
			},
			"search":function(){
				//console.debug($("#searchForm").serializeArray());  表单的标签要加name
				var param= $("#searchForm").serializeForm();
				//console.debug(param);
				 systermMenuDatagrid.datagrid('load',param);
			}
	}
	
	

	// 5、对页面所有按钮，统一监听		
	$("a[data-cmd]").click(function(){
		var cmd = $(this).data("cmd");
		if (cmd) {
			cmdObj[cmd]();
		}
	})	
	
	
	
})



		


</script>
<body>

	<table id="systermMenuDatagrid" title="系统菜单" class="easyui-datagrid"
		fit=true url="/systemMenu/list" toolbar="#toolbar" pagination="true"
		rownumbers="true" fitColumns="true" singleSelect="true">
		<thead>
			<tr>
				<th field="sn" width="50">菜单编号</th>
				<th field="name" width="50">菜单名称</th>
				<th field="parent" formatter="objFormatter" width="50">上级菜单</th>
				<th field="icon" width="50">图标</th>
				<th field="url" width="50">地址</th>
				<th field="intro" width="50">简介</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<a data-cmd="newMenu"  href="javascript:void(0)" class="easyui-linkbutton"iconCls="icon-add" plain="true">新增</a> 
		<a data-cmd="editMenu" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true">编辑</a> 
		<a data-cmd="delMenu" href="javascript:void(0)" class="easyui-linkbutton"iconCls="icon-remove" plain="true">删除</a> 
		<a data-cmd="reloadMenu" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" plain="true">刷新</a>
		
		<form  id ="searchForm" >
				关键字:<input id="q" name="q" type="text" class="easyui-textbox">	
				<a  data-cmd="search"  href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true">查询</a>	
		</form>
	</div>


	<div id="menudlg" class="easyui-dialog" style="width: 400px"
		closed="true" buttons="#dlg-buttons">
		<form id="menufm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<table>
				<input type="hidden" name="id" />
				<tr>
					<td>菜单编号</td>
					<td><input name="sn" class="easyui-textbox" required="true"></td>
				</tr>

				<tr>
					<td>菜单名称</td>
					<td><input name="name" class="easyui-textbox" required="true"></td>
				</tr>


				<tr>
					<td>上级菜单</td>
					<td>
						<input id="cbb" name="parent.id">  
					</td>
				</tr>

				<tr>
					<td>图标</td>
					<td><input name="icon" class="easyui-textbox" required="true"></td>
				</tr>

				<tr>
					<td>地址</td>
					<td><input name="url" class="easyui-textbox" ></td>
				</tr>


				<tr>
					<td>简介</td>
					<td><input name="intro" class="easyui-textbox"
						required="true"></td>
				</tr>
			</table>

		</form>
	</div>
	<div id="dlg-buttons">
		<a data-cmd="saveMenu" href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok"  style="width: 90px">保存</a> 
		<a data-cmd="cancel" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" style="width: 90px">取消</a>
	</div>


</body>
</html>