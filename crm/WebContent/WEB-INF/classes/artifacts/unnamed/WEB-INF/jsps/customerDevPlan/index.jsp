<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>跟进计划管理</title>
<!-- 导入公共jsp，就拥有了公共配置：easyui,js,css -->
<%@include file="/WEB-INF/jsps/common.jsp" %>
<script type="text/javascript">
	$(function() {
		// 1、声明出页面需要使用的组件

		var customerDevPlanDataGrid, customerDevPlanDialog,customerDevPlanQueryDialog,customerDevPlanDialogForm,customerDevPlanQueryDialogForm;
		// 2、把页面的组件，缓存到上面声明的变量中
		customerDevPlanDataGrid = $("#customerDevPlanDataGrid");
		customerDevPlanDialog = $("#customerDevPlanDialog");
		customerDevPlanQueryDialog = $("#customerDevPlanQueryDialog");
		customerDevPlanDialogForm = $("#customerDevPlanDialogForm");
		customerDevPlanQueryDialogForm = $("#customerDevPlanQueryDialogForm");
		// 3、初始化组件，修改组件的值
		// 4、创建一个"命令对象"，把当前模块所有的功能，都打包到这个对象上
		var cmdObj = {

			"customerDevPlanSearch" : function() {
				var paramObj =$("#customerDevPlanSearchForm").serializeForm();
				customerDevPlanDataGrid.datagrid('load',paramObj)
			},
			
			//高级查询
			"customerAdvancedDevPlanSearch":function(){
				
				customerDevPlanQueryDialog.dialog('open').dialog('center').dialog('setTitle', '查询开发计划');
				customerDevPlanQueryDialogForm.form('clear');
				//加载外键数据
				$('#ppp').combobox({
					url : '/customerDevPlan/querySystemDictionaryItem',
					valueField : 'id',
					textField : 'name'
				});
				$('#ccc').combobox({
					url : '/customerDevPlan/queryPotentialCustomer',
					valueField : 'id',
					textField : 'name'
				});

				$('#iii').combobox({
					url : '/customerDevPlan/queryEmployee',
					valueField : 'id',
					textField : 'realName'
				});
			},
			
			//高级查询确认
			"customerDevPlanQuerySave":function(){
				customerDevPlanDataGrid.datagrid('load',$("#customerDevPlanQueryDialogForm").serializeForm());
			},
			
			"customerDevPlanQueryCancel":function(){
				customerDevPlanQueryDialog.dialog('close');
			},
			
			"customerDevPlanAdd" : function() {
				//清除表单
				customerDevPlanDialogForm.form("clear");
				customerDevPlanDialog.dialog("setTitle", "添加跟进计划").dialog(
						"center").dialog("open");
				//打开dialog的时候：设置一个状态的默认值：defaultValue
				//$("#defaultValue").attr("checked",true);
				//$("#defaultValue").prop("checked", true);
				$('#pp').combobox({
					url : '/customerDevPlan/querySystemDictionaryItem',
					valueField : 'id',
					textField : 'name'
				});
				$('#cc').combobox({
					url : '/customerDevPlan/queryPotentialCustomer',
					valueField : 'id',
					textField : 'name'
				});

				$('#ii').combobox({
					url : '/customerDevPlan/queryEmployee',
					valueField : 'id',
					textField : 'realName'
				});
			},
			"customerDevPlanRefresh" : function() {
				customerDevPlanDataGrid.datagrid("reload");
			},
			"customerDevPlanCancel" : function() {
				customerDevPlanDialog.dialog("close");
			},
			"customerDevPlanEdit" : function() {
				//必须选中一行
				var row = customerDevPlanDataGrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('温馨提示', '请选中要修改行!', 'error');
					return;//如果没有数据做了提示信息就应该返回
				} else {

					//先清除
					customerDevPlanDialogForm.form("clear");
					//回显
					customerDevPlanDialogForm.form("load", row);
					//打开新增或编辑对话框
					customerDevPlanDialog.dialog("setTitle", "编辑潜在客户")
							.dialog("center").dialog("open");

					

					$('#pp').combobox({
						url : '/customerDevPlan/queryPotentialCustomer',
						valueField : 'id',
						textField : 'name'
					});

					//回显外键
					if (row) {
						$('#pp').combobox('setValue', row.potentialCustomer.id);
					}
					$('#cc').combobox({
						url : '/customerDevPlan/querySystemDictionaryItem',
						valueField : 'id',
						textField : 'name'
					});

					//回显外键
					if (row) {
						$('#cc').combobox('setValue', row.planType.id);
					}
					//编辑重新加载
					$('#ii').combobox({
						url : '/customerDevPlan/queryEmployee',
						valueField : 'id',
						textField : 'realName'
					});

					//回显外键
					if (row) {
						$('#ii').combobox('setValue', row.inputUser.id);
					}
				}

			},
			"customerDevPlanSave" : function() {
				customerDevPlanDialogForm.form('submit', {
					url : "/customerDevPlan/save",
					onSubmit : function() {
						return $(this).form('validate');
					},
					success : function(result) {
						//提交的返回值是Json字符串，不是Json对象，需要自己转换eval $.parseJSON JSON.parse
						var result = $.parseJSON(result);
						if (result.success) {
							//关闭对话框
							customerDevPlanDialog.dialog("close");
							//给个提示信息
							$.messager.alert('温馨提示', '保存成功', 'info');
							//刷新界面
							customerDevPlanDataGrid.datagrid('reload');
						} else {
							$.messager.alert('温馨提示', result.message, 'error');
						}
					}
				});
			},
			
			
			
			
			//删除
			"customerDevPlanDelete" : function() {

				var row = customerDevPlanDataGrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('温馨提示', '请选中要删除行!', 'error');
					return;//如果没有数据做了提示信息就应该返回
				}
				if (row) {
					$.messager.confirm('温馨提示', '您确定要删除该行数据吗?', function(r) {
						if (r) {
							$.post('/customerDevPlan/delete', {
								id : row.id
							}, function(result) {
								//期望返回成功与否，如果有错需要返回错误提示信息 {"success":true,"message":"xxxx"}
								//可以封装一个类AjaxResult，里面有两个属性
								if (result.success) {
									//给个提示信息
									$.messager.alert('温馨提示', '删除成功', 'info');
									//刷新界面
									customerDevPlanDataGrid
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
	 <table id="customerDevPlanDataGrid" title="部门列表" class="easyui-datagrid" 
	            fit="true"
	            url="/customerDevPlan/list"
	            toolbar="#customerDevPlanDataGridToolbar" pagination="true"
	            rownumbers="true" fitColumns="true" singleSelect="true">
	        <thead>
	            <tr>
	                <th field="id" width="50">编号</th>
	                <th field="planTime" width="50">计划时间</th>
	                <th field="planSubject" width="50">计划主题</th>
	                <th field="planDetails" width="50">计划内容</th>
	                <th field="inputTime" width="50">创建时间</th>
	                <th field="planType" width="50" formatter="dataFormatter">计划实施方式</th>
	                <th field="potentialCustomer" width="50" formatter="potentialCustomerFormatter">潜在客户</th>
	                <th field="inputUser" width="50" formatter="objFormatter">创建人</th>
	            </tr>
	        </thead>
    </table>
	<!-- 2 toolBar -->
	<div id="customerDevPlanDataGridToolbar">
		<a data-cmd="customerDevPlanAdd" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a> <a
			data-cmd="customerDevPlanEdit" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a> <a
			data-cmd="customerDevPlanDelete" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a> <a
			data-cmd="customerDevPlanRefresh" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-reload" plain="true">刷新</a>
		<form action="#" id="customerDevPlanSearchForm">
   	    	<!-- 关键字，状态 -->
   	    	关键字：<input id="q" type="text" name="q"> 
   	    	客户状态：<select name="state" id="state">
   	    	     <option value="-2">--请选择--</option>
   	    	     <option value="0">正常</option>
   	    	     <option value="-1">禁用</option>
   	    	   </select>
   	    	     <a data-cmd="customerDevPlanSearch" href="javascript:void(0)" class="easyui-linkbutton c1" iconCls="icon-search" plain="true">查询</a>
   	    	     <a data-cmd="customerAdvancedDevPlanSearch" href="javascript:void(0)" class="easyui-linkbutton c7" iconCls="icon-search" plain="true">高级查询</a>
   	    </form>
	</div>

	<!-- 3 添加或编辑对话框 -->
	<div id="customerDevPlanDialog" class="easyui-dialog"
		style="width: 400px" closed="true"
		buttons="#customerDevPlanDialogButtons">
		<form id="customerDevPlanDialogForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<!--由于添加和编辑对话框是通过一个Form，以隐藏域的方式区分是添加还是修改 -->
			<input type="hidden" name="id">
			<table>
				<table>
					
					<tr>
						<td>计划时间</td>
						<td><input type="text" name="planTime" /></td>
					</tr>
					<tr>
						<td>计划主题</td>
						<td><input type="text" name="planSubject" /></td>
					</tr>
					<tr>
						<td>计划内容</td>
						<td><input type="text" name="planDetails" /></td>
					</tr>
					<tr>
						<td>创建时间</td>
						<td><input type="text" name="inputTime" /></td>
					</tr>
					
					<tr>
						<td>计划实施方式:</td>
						<td><select id="pp" name="planType.id" style="width: 145px;" />
						</td>
					</tr>
					<tr>
						<td>潜在客户:</td>
						<td><select id="cc" name="potentialCustomer.id" style="width: 145px;" />
						</td>
					</tr>
					<tr>
						<td>创建人:</td>
						<td><select id="ii" name="inputUser.id" style="width: 145px;" />
						</td>
					</tr>
					
					
				</table>
		</form>
	</div>
	<!-- 4 添加或编辑对话框buttons -->
	<div id="customerDevPlanDialogButtons">
		<a data-cmd="customerDevPlanSave" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">保存</a>
		<a data-cmd="customerDevPlanCancel" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" style="width: 90px">取消</a>
	</div>
	
	<!-- 5 高级查询对话框 -->
	<div id="customerDevPlanQueryDialog" class="easyui-dialog"
		style="width: 400px" closed="true"
		buttons="#customerDevPlanQueryDialogButtons">
		<form id="customerDevPlanQueryDialogForm" method="post" novalidate
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
						<td>计划实施方式:</td>
						<td><select id="ppp" name="planTypeId" style="width: 145px;" />
						</td>
					</tr>
					<tr>
						<td>潜在客户:</td>
						<td><select id="ccc" name="potentialCustomerId" style="width: 145px;" />
						</td>
					</tr>
					<tr>
						<td>创建人:</td>
						<td><select id="iii" name="inputUserId" style="width: 145px;" />
						</td>
					</tr>
					
					
				</table>
		</form>
	</div>
	<!-- 6 高级查询对话框buttons -->
	<div id="customerDevPlanQueryDialogButtons">
		<a data-cmd="customerDevPlanQuerySave" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">保存</a>
		<a data-cmd="customerDevPlanQueryCancel" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" style="width: 90px">取消</a>
	</div>
</body>
</html>