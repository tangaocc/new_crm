<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>部门管理</title>
<!-- 导入公共jsp，就拥有了公共配置：easyui,js,css -->
<%@include file="/WEB-INF/jsps/common.jsp" %>
<script type="text/javascript">
	$(function() {
		// 1、声明出页面需要使用的组件

		var customerTraceHistoryDataGrid, customerTraceHistoryDialog,customerTraceHistoryQueryDialog, customerTraceHistoryDialogForm,customerTraceHistoryQueryDialogForm;
		// 2、把页面的组件，缓存到上面声明的变量中
		customerTraceHistoryDataGrid = $("#customerTraceHistoryDataGrid");
		customerTraceHistoryDialog = $("#customerTraceHistoryDialog");
		customerTraceHistoryQueryDialog = $("#customerTraceHistoryQueryDialog");
		customerTraceHistoryDialogForm = $("#customerTraceHistoryDialogForm");
		customerTraceHistoryQueryDialogForm = $("#customerTraceHistoryQueryDialogForm");
		// 3、初始化组件，修改组件的值
		// 4、创建一个"命令对象"，把当前模块所有的功能，都打包到这个对象上
		var cmdObj = {

			"customerTraceHistorySearch" : function() {
				var paramObj =$("#customerTraceHistorySearchForm").serializeForm();
				customerTraceHistoryDataGrid.datagrid('load',paramObj)
			},
			
			//高级查询
			"customerTraceHistoryAdvancedSearch":function(){
				
				customerTraceHistoryQueryDialog.dialog('open').dialog('center').dialog('setTitle', '查询潜在客户');
				customerTraceHistoryQueryDialogForm.form('clear');
				//加载外键数据
				$('#ttt').combobox({
					url : '/customerTraceHistory/queryEmployee',
					valueField : 'id',
					textField : 'realName'
				});

				$('#ddd').combobox({
					url : '/customerTraceHistory/querySystemDictionaryItem',
					valueField : 'id',
					textField : 'name'
				});
			},
			
			//高级查询确认
			"customerTraceHistoryQuerySave":function(){
				customerTraceHistoryDataGrid.datagrid('load',$("#customerTraceHistoryQueryDialogForm").serializeForm());
			},
			
			"customerTraceHistoryQueryCancel":function(){
				customerTraceHistoryQueryDialog.dialog('close');
			},
			
			"customerTraceHistoryAdd" : function() {
				//清除表单
				customerTraceHistoryDialogForm.form("clear");
				customerTraceHistoryDialog.dialog("setTitle", "添加跟进历史").dialog(
						"center").dialog("open");
				//打开dialog的时候：设置一个状态的默认值：defaultValue
				//$("#defaultValue").attr("checked",true);
				//$("#defaultValue").prop("checked", true);
				
				$('#cc').combobox({
					url : '/customerTraceHistory/queryCustomer',
					valueField : 'id',
					textField : 'name'
				});
				$('#tt').combobox({
					url : '/customerTraceHistory/queryEmployee',
					valueField : 'id',
					textField : 'realName'
				});

				$('#dd').combobox({
					url : '/customerTraceHistory/querySystemDictionaryItem',
					valueField : 'id',
					textField : 'name'
				});
			},
			"customerTraceHistoryRefresh" : function() {
				customerTraceHistoryDataGrid.datagrid("reload");
			},
			"customerTraceHistoryCancel" : function() {
				customerTraceHistoryDialog.dialog("close");
			},
			"customerTraceHistoryEdit" : function() {
				//必须选中一行
				var row = customerTraceHistoryDataGrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('温馨提示', '请选中要修改行!', 'error');
					return;//如果没有数据做了提示信息就应该返回
				} else {

					//先清除
					customerTraceHistoryDialogForm.form("clear");
					//回显
					customerTraceHistoryDialogForm.form("load", row);
					//打开新增或编辑对话框
					customerTraceHistoryDialog.dialog("setTitle", "编辑跟进历史")
							.dialog("center").dialog("open");

					//编辑重新加载
					$('#cc').combobox({
						url : '/customerTraceHistory/queryCustomer',
						valueField : 'id',
						textField : 'name'
					});

					//回显外键
					if (row) {
						$('#cc').combobox('setValue', row.customer.id);
					}
					//编辑重新加载
					$('#tt').combobox({
						url : '/customerTraceHistory/queryEmployee',
						valueField : 'id',
						textField : 'realName'
					});

					//回显外键
					if (row) {
						$('#tt').combobox('setValue', row.traceUser.id);
					}

					$('#dd').combobox({
						url : '/customerTraceHistory/querySystemDictionaryItem',
						valueField : 'id',
						textField : 'name'
					});

					//回显外键
					if (row.inputUser) {
						$('#dd').combobox('setValue', row.traceType.id);
					}

				}

			},
			"customerTraceHistorySave" : function() {
				customerTraceHistoryDialogForm.form('submit', {
					url : "/customerTraceHistory/save",
					onSubmit : function() {
						return $(this).form('validate');
					},
					success : function(result) {
						//提交的返回值是Json字符串，不是Json对象，需要自己转换eval $.parseJSON JSON.parse
						var result = $.parseJSON(result);
						if (result.success) {
							//关闭对话框
							customerTraceHistoryDialog.dialog("close");
							//给个提示信息
							$.messager.alert('温馨提示', '保存成功', 'info');
							//刷新界面
							customerTraceHistoryDataGrid.datagrid('reload');
						} else {
							$.messager.alert('温馨提示', result.message, 'error');
						}
					}
				});
			},
			
			
			
			
			//删除
			"customerTraceHistoryDelete" : function() {

				var row = customerTraceHistoryDataGrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('温馨提示', '请选中要删除行!', 'error');
					return;//如果没有数据做了提示信息就应该返回
				}
				if (row) {
					$.messager.confirm('温馨提示', '您确定要删除该行数据吗?', function(r) {
						if (r) {
							$.post('/customerTraceHistory/delete', {
								id : row.id
							}, function(result) {
								//期望返回成功与否，如果有错需要返回错误提示信息 {"success":true,"message":"xxxx"}
								//可以封装一个类AjaxResult，里面有两个属性
								if (result.success) {
									//给个提示信息
									$.messager.alert('温馨提示', '删除成功', 'info');
									//刷新界面
									customerTraceHistoryDataGrid
											.datagrid('reload');
								} else {
									$.messager.alert('温馨提示', result.message,
											'error');
								}
							}, 'json');
						}
					});
				}
			}
		}
		// 5、对页面所有按钮，统一监听
		$("a[data-cmd]").click(function() {
			//5.1 获取cmd以便于区分是哪个超链接
			var cmd = $(this).data("cmd");//add
			//5.2 完成对应方法调用
			/*方案1：判断分别执行-垃圾
			if(cmd="add")
			{
			 cmdObj.add();
			}
			if(cmd="edit")
			{
			 cmdObj.edit();
			}*/
			//方案2：动态调用
			//判断定义了cmd，并且没有被禁用
			if (cmd && !$(this).hasClass("l-btn-disabled")) {
				cmdObj[cmd]();
			}
		});
	})
</script>
</head>
<body>
	<!-- 1 datagrid -->
	 <table id="customerTraceHistoryDataGrid" title="跟进历史列表" class="easyui-datagrid" 
	            fit="true"
	            url="/customerTraceHistory/list"
	            toolbar="#customerTraceHistoryDataGridToolbar" pagination="true"
	            rownumbers="true" fitColumns="true" singleSelect="true">
	        <thead>
	            <tr>
	                <th field="id" width="50">Id</th>
	                <th field="traceTime" width="50">跟进时间</th>
	                <th field="traceResult" width="50" formatter="traceResultFormatter">跟进效果</th>
	                <th field="title" width="50">跟进主题</th>
	                <th field="remark" width="50">备注</th>
	                <th field="customer" width="50" formatter="customerFormatter">客户</th>
	                <th field="traceUser" width="50" formatter="objFormatter">跟进人</th>
	                <th field="traceType" width="50" formatter="dataFormatter">跟进方式</th>
	            </tr>
	        </thead>
    </table>
	<!-- 2 toolBar -->
	<div id="customerTraceHistoryDataGridToolbar">
		<a data-cmd="customerTraceHistoryAdd" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a> <a
			data-cmd="customerTraceHistoryEdit" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a> <a
			data-cmd="customerTraceHistoryDelete" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a> <a
			data-cmd="customerTraceHistoryRefresh" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-reload" plain="true">刷新</a>
		<form action="#" id="customerTraceHistorySearchForm">
   	    	<!-- 关键字，状态 -->
   	    	关键字：<input id="q" type="text" name="q"> 
   	    	客户状态：<select name="state" id="state">
   	    	     <option value="-2">--请选择--</option>
   	    	     <option value="0">正常</option>
   	    	     <option value="-1">禁用</option>
   	    	   </select>
   	    	     <a data-cmd="customerTraceHistorySearch" href="javascript:void(0)" class="easyui-linkbutton c1" iconCls="icon-search" >查询</a>
   	    	     <a data-cmd="customerTraceHistoryAdvancedSearch" href="javascript:void(0)" class="easyui-linkbutton c7" iconCls="icon-search" >高级查询</a>
   	    </form>
	</div>

	<!-- 3 添加或编辑对话框 -->
	<div id="customerTraceHistoryDialog" class="easyui-dialog"
		style="width: 400px" closed="true"
		buttons="#customerTraceHistoryDialogButtons">
		<form id="customerTraceHistoryDialogForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<!--由于添加和编辑对话框是通过一个Form，以隐藏域的方式区分是添加还是修改 -->
			<input type="hidden" name="id">
			<table>
				<table>
					
					<tr>
						<td>跟进时间</td>
						<td><input type="text" name="traceTime" /></td>
					</tr>
					<tr>
						<td>跟进效果</td>
						<td><select id="q" name="traceResult" class="easyui-combobox"
							style="width: 145px;">
								<option value="-2">---请选择---option>
								<option value="-1">差</option>
								<option value="0">中</option>
								<option value="1">优</option>
						</select>
					</tr>
					<tr>
						<td>跟进主题</td>
						<td><input type="text" name="title" /></td>
					</tr>
					<tr>
						<td>备注</td>
						<td><input type="text" name="remark" /></td>
					</tr>
					
					<tr>
						<td>客户:</td>
						<td><select id="cc" name="customer.id" style="width: 145px;" />
						</td>
					</tr>
					<tr>
						<td>跟进人:</td>
						<td><select id="tt" name="traceUser.id" style="width: 145px;" />
						</td>
					</tr>
						
					<tr>
						<td>跟进方式</td>
						<td><select id="dd" name="traceType.id" style="width: 145px;">
							</td>
					</tr>
				</table>
		</form>
	</div>
	<!-- 4 添加或编辑对话框buttons -->
	<div id="customerTraceHistoryDialogButtons">
		<a data-cmd="customerTraceHistorySave" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">保存</a>
		<a data-cmd="customerTraceHistoryCancel" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" style="width: 90px">取消</a>
	</div>
	
	<!-- 5 高级查询对话框 -->
	<div id="customerTraceHistoryQueryDialog" class="easyui-dialog"
		style="width: 400px" closed="true"
		buttons="#customerTraceHistoryQueryDialogButtons">
		<form id="customerTraceHistoryQueryDialogForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<!--由于添加和编辑对话框是通过一个Form，以隐藏域的方式区分是添加还是修改 -->
			<input type="hidden" name="id">
			<table>
				<table>
					
					<tr>
						<td>跟进主题</td>
						<td><input type="text" name="title" /></td>
					</tr>
					
					
					<tr>
						<td>跟进人:</td>
						<td><select id="ttt" name="traceUserId" style="width: 145px;" />
						</td>
					</tr>
						
					<tr>
						<td>跟进方式</td>
						<td><select id="ddd" name="traceTypeId" style="width: 145px;">
							</td>
					</tr>
					
					<tr>
						<td>跟进效果</td>
						<td><select id="q" name="traceResult" class="easyui-combobox"
							style="width: 145px;">
								<option value="-2">---请选择---option>
								<option value="-1">差</option>
								<option value="0">中</option>
								<option value="1">优</option>
						</select>
					</tr>
				</table>
		</form>
	</div>
	<!-- 6 高级查询对话框buttons -->
	<div id="customerTraceHistoryQueryDialogButtons">
		<a data-cmd="customerTraceHistoryQuerySave" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">确认</a>
		<a data-cmd="customerTraceHistoryQueryCancel" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" style="width: 90px">取消</a>
	</div>
</body>
</html>