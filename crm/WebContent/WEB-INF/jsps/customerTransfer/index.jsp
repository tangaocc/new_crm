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

		var customerTransferDataGrid, customerTransferDialog,customerTransferQueryDialog, customerTransferDialogForm,customerTransferQueryDialogForm;
		// 2、把页面的组件，缓存到上面声明的变量中
		customerTransferDataGrid = $("#customerTransferDataGrid");
		customerTransferDialog = $("#customerTransferDialog");
		customerTransferQueryDialog = $("#customerTransferQueryDialog");
		customerTransferDialogForm = $("#customerTransferDialogForm");
		customerTransferQueryDialogForm = $("#customerTransferQueryDialogForm");
		// 3、初始化组件，修改组件的值
		// 4、创建一个"命令对象"，把当前模块所有的功能，都打包到这个对象上
		var cmdObj = {

			"customerTransferSearch" : function() {
				var paramObj =$("#customerTransferSearchForm").serializeForm();
				customerTransferDataGrid.datagrid('load',paramObj)
			},

			//高级查询
			"customerTransferAdvancedSearch":function(){
				
				customerTransferQueryDialog.dialog('open').dialog('center').dialog('setTitle', '查询潜在客户');
				customerTransferQueryDialogForm.form('clear');
				//加载外键数据
				$('#ccc').combobox({
					url : '/customerTransfer/queryCustomer',
					valueField : 'id',
					textField : 'name'
				});
				$('#ttt').combobox({
					url : '/customerTransfer/queryEmployee',
					valueField : 'id',
					textField : 'realName'
				});
				$('#ooo').combobox({
					url : '/customerTransfer/queryEmployee',
					valueField : 'id',
					textField : 'realName'
				});
				$('#nnn').combobox({
					url : '/customerTransfer/queryEmployee',
					valueField : 'id',
					textField : 'realName'
				});
			},
			
			//高级查询确认
			"customerTransferQuerySave":function(){
				customerTransferDataGrid.datagrid('load',$("#customerTransferQueryDialogForm").serializeForm());
			},
			
			"customerTransferQueryCancel":function(){
				customerTransferQueryDialog.dialog('close');
			},
			
			"customerTransferAdd" : function() {
				//清除表单
				customerTransferDialogForm.form("clear");
				customerTransferDialog.dialog("setTitle", "添加潜在客户").dialog(
						"center").dialog("open");
				//打开dialog的时候：设置一个状态的默认值：defaultValue
				//$("#defaultValue").attr("checked",true);
				//$("#defaultValue").prop("checked", true);
				$('#cc').combobox({
					url : '/customerTransfer/queryCustomer',
					valueField : 'id',
					textField : 'name'
				});
				$('#tt').combobox({
					url : '/customerTransfer/queryEmployee',
					valueField : 'id',
					textField : 'realName'
				});
				$('#oo').combobox({
					url : '/customerTransfer/queryEmployee',
					valueField : 'id',
					textField : 'realName'
				});
				$('#nn').combobox({
					url : '/customerTransfer/queryEmployee',
					valueField : 'id',
					textField : 'realName'
				});

				
			},
			"customerTransferRefresh" : function() {
				customerTransferDataGrid.datagrid("reload");
			},
			"customerTransferCancel" : function() {
				customerTransferDialog.dialog("close");
			},
			"customerTransferEdit" : function() {
				//必须选中一行
				var row = customerTransferDataGrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('温馨提示', '请选中要修改行!', 'error');
					return;//如果没有数据做了提示信息就应该返回
				} else {

					//先清除
					customerTransferDialogForm.form("clear");
					//回显
					customerTransferDialogForm.form("load", row);
					//打开新增或编辑对话框
					customerTransferDialog.dialog("setTitle", "编辑潜在客户")
							.dialog("center").dialog("open");

					//编辑重新加载
					$('#cc').combobox({
						url : '/customerTransfer/queryCustomer',
						valueField : 'id',
						textField : 'name'
					});

					//回显外键
					if (row) {
						$('#cc').combobox('setValue', row.customer.id);
					}
					
					$('#tt').combobox({
						url : '/customerTransfer/queryEmployee',
						valueField : 'id',
						textField : 'realName'
					});

					//回显外键
					if (row) {
						$('#tt').combobox('setValue', row.transUser.id);
					}
					
					$('#oo').combobox({
						url : '/customerTransfer/queryEmployee',
						valueField : 'id',
						textField : 'realName'
					});

					//回显外键
					if (row) {
						$('#oo').combobox('setValue', row.oldSeller.realName);
					}
					
					$('#nn').combobox({
						url : '/customerTransfer/queryEmployee',
						valueField : 'id',
						textField : 'realName'
					});

					//回显外键
					if (row) {
						$('#nn').combobox('setValue', row.newSeller.id);
					}

				}

			},
			"customerTransferSave" : function() {
				customerTransferDialogForm.form('submit', {
					url : "/customerTransfer/save",
					onSubmit : function() {
						return $(this).form('validate');
					},
					success : function(result) {
						//提交的返回值是Json字符串，不是Json对象，需要自己转换eval $.parseJSON JSON.parse
						var result = $.parseJSON(result);
						if (result.success) {
							//关闭对话框
							customerTransferDialog.dialog("close");
							//给个提示信息
							$.messager.alert('温馨提示', '保存成功', 'info');
							//刷新界面
							customerTransferDataGrid.datagrid('reload');
						} else {
							$.messager.alert('温馨提示', result.message, 'error');
						}
					}
				});
			},
			
			
			
			
			//删除
			"customerTransferDelete" : function() {

				var row = customerTransferDataGrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('温馨提示', '请选中要删除行!', 'error');
					return;//如果没有数据做了提示信息就应该返回
				}
				if (row) {
					$.messager.confirm('温馨提示', '您确定要删除该行数据吗?', function(r) {
						if (r) {
							$.post('/customerTransfer/delete', {
								id : row.id
							}, function(result) {
								//期望返回成功与否，如果有错需要返回错误提示信息 {"success":true,"message":"xxxx"}
								//可以封装一个类AjaxResult，里面有两个属性
								if (result.success) {
									//给个提示信息
									$.messager.alert('温馨提示', '删除成功', 'info');
									//刷新界面
									customerTransferDataGrid
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
	 <table id="customerTransferDataGrid" title="部门列表" class="easyui-datagrid" 
	            fit="true"
	            url="/customerTransfer/list"
	            toolbar="#customerTransferDataGridToolbar" pagination="true"
	            rownumbers="true" fitColumns="true" singleSelect="true">
	        <thead>
	            <tr>
	                <th field="id" width="50">Id</th>
	                <th field="transTime" width="50">移交时间</th>
	                <th field="transReason" width="50">移交原因</th>
	                <th field="customer" width="50" formatter="objFormatter">客户</th>
	                <th field="transUser" width="50" formatter="objFormatter">移交人员</th>
	                <th field="oldSeller" width="50" formatter="objFormatter">老市场专员</th>
	                <th field="newSeller" width="50" formatter="objFormatter">新市场专员</th>
	            </tr>
	        </thead>
    </table>
	<!-- 2 toolBar -->
	<div id="customerTransferDataGridToolbar">
		<a data-cmd="customerTransferAdd" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a> <a
			data-cmd="customerTransferEdit" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a> <a
			data-cmd="customerTransferDelete" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a> <a
			data-cmd="customerTransferRefresh" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-reload" plain="true">刷新</a>
		<form action="#" id="customerTransferSearchForm">
   	    	<!-- 关键字，状态 -->
   	    	关键字：<input id="q" type="text" name="q"> 
   	    	客户状态：<select name="state" id="state">
   	    	     <option value="-2">--请选择--</option>
   	    	     <option value="0">正常</option>
   	    	     <option value="-1">禁用</option>
   	    	   </select>
   	    	     <a data-cmd="customerTransferSearch" href="javascript:void(0)" class="easyui-linkbutton c1" iconCls="icon-search" plain="true">查询</a>
   	    	     <a data-cmd="customerTransferAdvancedSearch" href="javascript:void(0)" class="easyui-linkbutton c7" iconCls="icon-search" plain="true">高级查询</a>
   	    </form>
	</div>

	<!-- 3 添加或编辑对话框 -->
	<div id="customerTransferDialog" class="easyui-dialog"
		style="width: 400px" closed="true"
		buttons="#customerTransferDialogButtons">
		<form id="customerTransferDialogForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<!--由于添加和编辑对话框是通过一个Form，以隐藏域的方式区分是添加还是修改 -->
			<input type="hidden" name="id">
			<table>
				<table>
					
					<tr>
						<td>移交时间</td>
						<td><input type="text" name="transTime" /></td>
					</tr>
					<tr>
						<td>移交原因</td>
						<td><input type="text" name="transReason" /></td>
					</tr>
					
					<tr>
						<td>客户</td>
						<td><select id="cc" name="customer.id" style="width: 145px;" />
						</td>
					</tr>
					<tr>
						<td>移交人员</td>
						<td><select id="tt" name="transUser.id" style="width: 145px;" />
						</td>
					</tr>
					<tr>
						<td>老市场专员</td>
						<td><select id="oo" name="oldSeller.id" style="width: 145px;" />
						</td>
					</tr>
					<tr>
						<td>新市场专员</td>
						<td><select id="nn" name="newSeller.id" style="width: 145px;" />
						</td>
					</tr>
					
					</tr>
				</table>
		</form>
	</div>
	<!-- 4 添加或编辑对话框buttons -->
	<div id="customerTransferDialogButtons">
		<a data-cmd="customerTransferSave" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">保存</a>
		<a data-cmd="customerTransferCancel" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" style="width: 90px">取消</a>
	</div>
	
	<!-- 5 高级查询对话框 -->
	<div id="customerTransferQueryDialog" class="easyui-dialog"
		style="width: 400px" closed="true"
		buttons="#customerTransferQueryDialogButtons">
		<form id="customerTransferQueryDialogForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<!--由于添加和编辑对话框是通过一个Form，以隐藏域的方式区分是添加还是修改 -->
			<!-- <input type="hidden" name="id"> -->
			<table>
				<table>
					
					<tr>
						<td>关键字</td>
						<td><input type="q" name="q" /></td>
					</tr>
					
					<tr>
						<td>客户</td>
						<td><select id="ccc" name="customerId" style="width: 145px;" />
						</td>
					</tr>
					<tr>
						<td>移交人员</td>
						<td><select id="ttt" name="transUserId" style="width: 145px;" />
						</td>
					</tr>
					<tr>
						<td>老市场专员</td>
						<td><select id="ooo" name="oldSellerId" style="width: 145px;" />
						</td>
					</tr>
					<tr>
						<td>新市场专员</td>
						<td><select id="nnn" name="newSelleId" style="width: 145px;" />
						</td>
					</tr>
					
					</tr>
				</table>
		</form>
	</div>
	<!-- 6 高级查询对话框buttons -->
	<div id="customerTransferQueryDialogButtons">
		<a data-cmd="customerTransferQuerySave" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">确认</a>
		<a data-cmd="customerTransferQueryCancel" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" style="width: 90px">取消</a>
	</div>
	
</body>
</html>