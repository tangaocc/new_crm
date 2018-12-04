<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>潜在客户管理</title>
<!-- 导入公共jsp，就拥有了公共配置：easyui,js,css -->
<%@include file="/WEB-INF/jsps/common.jsp"%>
<script type="text/javascript">
	$(function() {
		// 1、声明出页面需要使用的组件

		var potentialCustomerDataGrid, potentialCustomerDialog,potentialCustomerQueryDialog,potentialCustomerUpgradeDialog, potentialCustomerDialogForm,potentialCustomerQueryDialogForm,potentialCustomerUpgradeDialogForm;
		// 2、把页面的组件，缓存到上面声明的变量中
		potentialCustomerDataGrid = $("#potentialCustomerDataGrid");
		potentialCustomerDialog = $("#potentialCustomerDialog");
		potentialCustomerQueryDialog = $("#potentialCustomerQueryDialog");
		potentialCustomerUpgradeDialog = $("#potentialCustomerUpgradeDialog");
		potentialCustomerDialogForm = $("#potentialCustomerDialogForm");
		potentialCustomerQueryDialogForm = $("#potentialCustomerQueryDialogForm");
		potentialCustomerUpgradeDialogForm = $("#potentialCustomerUpgradeDialogForm");
		// 3、初始化组件，修改组件的值
		// 4、创建一个"命令对象"，把当前模块所有的功能，都打包到这个对象上
		var cmdObj = {

			"potentialCustomerSearch" : function() {
				var paramObj =$("#potentialCustomerSearchForm").serializeForm();
				potentialCustomerDataGrid.datagrid('load',paramObj)
			},
			
			//高级查询
			"potentialCustomerAdvancedSearch":function(){
				
				potentialCustomerQueryDialog.dialog('open').dialog('center').dialog('setTitle', '查询潜在客户');
				potentialCustomerQueryDialogForm.form('clear');
				//加载外键数据
				$('#ccc').combobox({    
        		    url: '/potentialCustomer/queryEmployee',
        		    valueField:'id',    
				    textField:'text'   
        		});
				
				$('#ddd').combobox({    
        		    url: '/potentialCustomer/querySystemDictionaryItem',
        		    valueField:'id',    
				    textField:'text'   
        		});
			},
			
			//高级查询确认
			"potentialCustomerQuerySave":function(){
				potentialCustomerDataGrid.datagrid('load',$("#potentialCustomerQueryDialogForm").serializeForm());
			},
			
			"potentialCustomerQueryCancel":function(){
				potentialCustomerQueryDialog.dialog('close');
			},
			
			//升级潜在客户
			"potentialCustomerUpgrade" : function() {
				//获取选中红
				var row = potentialCustomerDataGrid.datagrid('getSelected');
				//没有选中
				if (!row) {
					$.messager.alert('温馨提示', '请选中一行后,再操作!', 'error');
					return;
				}

				potentialCustomerUpgradeDialogForm.form('load', row);
				//alert(row.name);
				$('#SS').combobox({
						url : '/customer/queryEmployee',
						valueField : 'id',
						textField : 'realName'
					});

					
					//编辑重新加载
					$('#JJ').combobox({
						url : '/customer/querySystemDictionaryItem',
						valueField : 'id',
						textField : 'intro'
					});

					
					//编辑重新加载
					$('#AA').combobox({
						url : '/customer/querySystemDictionaryItem',
						valueField : 'id',
						textField : 'requence'
					});

					

					$('#DD').combobox({
						url : '/customer/querySystemDictionaryItem',
						valueField : 'id',
						textField : 'name'
					});

					
					//编辑重新加载
					$('#CC').combobox({
						url : '/customer/queryEmployee',
						valueField : 'id',
						textField : 'realName'
					});

					

				potentialCustomerUpgradeDialog.dialog('open').dialog('center').dialog(
						'setTitle', '移交客户');

			},
			//升级确认
			"potentialCustomerUpgradeSave" : function() {
				
				//获取选中行
				var row = potentialCustomerDataGrid.datagrid('getSelected');
				
				potentialCustomerUpgradeDialogForm.form('submit', {
					url : "/customer/save",
					success : function(result) {
						//提交表单获取到的字符串
						var result = $.parseJSON(result);

						if (result.success) {
							//保存成功给出提示,并重新加载表格
							$.post('/potentialCustomer/delete', {
							"id" : row.id
							}, function(results) {
							if (results.success) {
								//删除成功给出提示,并重新加载表格
								potentialCustomerUpgradeDialog.dialog('close');
								$.messager.alert('温馨提示', '升级成功!', 'info');
								potentialCustomerDataGrid.datagrid('reload');
							} else {
								//删除成功给出提示,并重新加载表格
								$.messager.alert('温馨提示', result.message,
										'error');
								potentialCustomerDataGrid.datagrid('reload');}
							}, 'json');
							
						} else {
							//保存失败给出提示,并重新加载表格
							potentialCustomerUpgradeDialog.dialog('close');
							$.messager.alert('温馨提示', result.message, 'error');
							potentialCustomerDataGrid.datagrid('reload');
						}
					}
				});
			},
			
			//取消
			"potentialCustomerUpgradeCancel" : function() {
				potentialCustomerUpgradeDialog.dialog('close');
			},

			
			
			"potentialCustomerAdd" : function() {
				//清除表单
				potentialCustomerDialogForm.form("clear");
				potentialCustomerDialog.dialog("setTitle", "添加潜在客户").dialog(
						"center").dialog("open");
				//打开dialog的时候：设置一个状态的默认值：defaultValue
				//$("#defaultValue").attr("checked",true);
				//$("#defaultValue").prop("checked", true);
				$('#cc').combobox({
					url : '/potentialCustomer/queryEmployee',
					valueField : 'id',
					textField : 'realName'
				});

				$('#dd').combobox({
					url : '/potentialCustomer/querySystemDictionaryItem',
					valueField : 'id',
					textField : 'name'
				});
			},
			"potentialCustomerRefresh" : function() {
				potentialCustomerDataGrid.datagrid("reload");
			},
			"potentialCustomerCancel" : function() {
				potentialCustomerDialog.dialog("close");
			},
			"potentialCustomerEdit" : function() {
				//必须选中一行
				var row = potentialCustomerDataGrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('温馨提示', '请选中要修改行!', 'error');
					return;//如果没有数据做了提示信息就应该返回
				} else {

					//先清除
					potentialCustomerDialogForm.form("clear");
					//回显
					potentialCustomerDialogForm.form("load", row);
					//打开新增或编辑对话框
					potentialCustomerDialog.dialog("setTitle", "编辑潜在客户")
							.dialog("center").dialog("open");

					//编辑重新加载
					$('#cc').combobox({
						url : '/potentialCustomer/queryEmployee',
						valueField : 'id',
						textField : 'realName'
					});

					//回显外键
					if (row) {
						$('#cc').combobox('setValue', row.inputUser.id);
					}

					$('#dd').combobox({
						url : '/potentialCustomer/querySystemDictionaryItem',
						valueField : 'id',
						textField : 'name'
					});

					//回显外键
					if (row.inputUser) {
						$('#dd').combobox('setValue', row.customerSource.id);
					}

				}

			},
			"potentialCustomerSave" : function() {
				potentialCustomerDialogForm.form('submit', {
					url : "/potentialCustomer/save",
					onSubmit : function() {
						return $(this).form('validate');
					},
					success : function(result) {
						//提交的返回值是Json字符串，不是Json对象，需要自己转换eval $.parseJSON JSON.parse
						var result = $.parseJSON(result);
						if (result.success) {
							//关闭对话框
							potentialCustomerDialog.dialog("close");
							//给个提示信息
							$.messager.alert('温馨提示', '保存成功', 'info');
							//刷新界面
							potentialCustomerDataGrid.datagrid('reload');
						} else {
							$.messager.alert('温馨提示', result.message, 'error');
						}
					}
				});
			},
			
			
			
			
			//删除
			"potentialCustomerDelete" : function() {

				var row = potentialCustomerDataGrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('温馨提示', '请选中要删除行!', 'error');
					return;//如果没有数据做了提示信息就应该返回
				}
				if (row) {
					$.messager.confirm('温馨提示', '您确定要删除该行数据吗?', function(r) {
						if (r) {
							$.post('/potentialCustomer/delete', {
								id : row.id
							}, function(result) {
								//期望返回成功与否，如果有错需要返回错误提示信息 {"success":true,"message":"xxxx"}
								//可以封装一个类AjaxResult，里面有两个属性
								if (result.success) {
									//给个提示信息
									$.messager.alert('温馨提示', '删除成功', 'info');
									//刷新界面
									potentialCustomerDataGrid
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
	<table id="potentialCustomerDataGrid" title="潜在客户列表"
		class="easyui-datagrid" fit="true" url="/potentialCustomer/list"
		toolbar="#potentialCustomerDataGridToolbar" pagination="true"
		rownumbers="true" fitColumns="true" singleSelect="true">
		<thead>

			<tr>
				
				<th field="customerSource" width="50" formatter="dataFormatter">客户来源</th>
				<th field="name" width="50">客户名称</th>
				<th field="successRate" width="50">成功机率</th>
				<th field="remark" width="50">客户描述</th>
				<th field="linkMan" width="50">联系人</th>
				<th field="linkManTel" width="50">联系电话</th>
				<th field="inputUser" width="50" formatter="objFormatter">创建人</th>
				<th field="inputTime" width="50">创建时间</th>
				<th field="state" width="50" formatter="customerStateFormatter">客户状态</th>
			</tr>
		</thead>
	</table>
	<!-- 2 toolBar -->
	<div id="potentialCustomerDataGridToolbar">
		<a data-cmd="potentialCustomerAdd" href="javascript:void(0)"
			class="easyui-linkbutton c1" iconCls="icon-add" plain="true">新增</a> <a
			data-cmd="potentialCustomerEdit" href="javascript:void(0)"
			class="easyui-linkbutton c2" iconCls="icon-edit" plain="true">修改</a> <a
			data-cmd="potentialCustomerDelete" href="javascript:void(0)"
			class="easyui-linkbutton c3" iconCls="icon-remove" plain="true">删除</a> <a
			data-cmd="potentialCustomerRefresh" href="javascript:void(0)"
			class="easyui-linkbutton c4" iconCls="icon-reload" plain="true">刷新</a>
			<a data-cmd="potentialCustomerUpgrade" href="javascript:void(0)"
			class="easyui-linkbutton c5" iconCls="icon-redo" plain="true">升为正式用户</a>
		<form action="#" id="potentialCustomerSearchForm">
   	    	<!-- 关键字，状态 -->
   	    	关键字：<input id="q" type="text" name="q"> 
   	    	客户状态：<select name="state" id="state">
   	    	     <option value="-888">--请选择--</option>
   	    	     <option value="0">正式客户</option>
   	    	     <option value="-1">潜在客户</option>
   	    	   </select>
   	    	     <a data-cmd="potentialCustomerSearch" href="javascript:void(0) " class="easyui-linkbutton c1" iconCls="icon-search" >查询</a>
   	    	     <a data-cmd="potentialCustomerAdvancedSearch" href="javascript:void(0) " class="easyui-linkbutton c7" iconCls="icon-search" >高级查询</a>
   	    </form>
	</div>

	<!-- 3 添加或编辑对话框 -->
	<div id="potentialCustomerDialog" class="easyui-dialog"
		style="width: 400px; height:300px" closed="true"
		buttons="#potentialCustomerDialogButtons">
		<form id="potentialCustomerDialogForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<!--由于添加和编辑对话框是通过一个Form，以隐藏域的方式区分是添加还是修改 -->
			<input type="hidden" name="id">
			<table>
				<table>
					<tr>
						<td>客户来源</td>
						<td><select id="dd" name="customerSource.id" style="width: 145px;">
							</td>
					</tr>
					<tr>
						<td>客户名称</td>
						<td><input type="text" name="name" class="easyui-validatebox" required ="true"/></td>
					</tr>
					<tr>
						<td>成功机率%</td>
						<td><input type="text" name="successRate" class="easyui-numberbox"  min=0 max=100  required ="true" /></td>
					</tr>
					<tr>
						<td>客户描述</td>
						<td><input type="text" name="remark" class="easyui-validatebox" required ="true"/></td>
					</tr>
					<tr>
						<td>联系人</td>
						<td><input type="text" name="linkMan" /></td>
					</tr>
					<tr>
						<td>联系电话</td>
						<td><input type="text" name="linkManTel" /></td>
					</tr>
					<tr>
						<td>创建人:</td>
						<td><select id="cc" name="inputUser.id" style="width: 145px;" required ="true"/>
						</td>
					</tr>
					<tr>
						<td>创建时间</td>
							<td><input  name="inputTime"  type= "text" class= "easyui-datebox" required ="true"/>  
						</td>
					</tr>

					<tr>
						<td>客户状态</td>
						<td><select id="s" name="state" class="easyui-combobox"
							style="width: 145px;" >
								
								<option value="-1">潜在客户</option>
								<option value="0">正式客户</option>
						</select></td>
					</tr>
				</table>
		</form>
	</div>
	<!-- 4 添加或编辑对话框buttons -->
	<div id="potentialCustomerDialogButtons">
		<a data-cmd="potentialCustomerSave" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">保存</a>
		<a data-cmd="potentialCustomerCancel" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" style="width: 90px">取消</a>
	</div>
	
	<!-- 5高级查询对话框 -->
	<div id="potentialCustomerQueryDialog" class="easyui-dialog"
		style="width: 400px; height:300px" closed="true"
		buttons="#potentialCustomerQueryDialogButtons">
		<form id="potentialCustomerQueryDialogForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<!--由于添加和编辑对话框是通过一个Form，以隐藏域的方式区分是添加还是修改 -->
			
			<table>
				<table>
					
					<tr>
						<td>关键字</td>
						<td><input in="q" type="text" name="q" class="easyui-textbox"/></td>
					</tr>
					<tr>
						<td>成功机率%</td>
						<td><input type="text" name="successRate" class="easyui-textbox"/></td>
					</tr>
					<tr>
						<td>创建人:</td>
						<td><select id="ccc" name="inputUserId" style="width: 145px;" />
						</td>
					</tr>
					
					<tr>
						<td>客户来源</td>
						<td><select id="ddd" name="customerSourceId" style="width: 145px;">
							</td>
					</tr>
					<tr>
						<td>客户状态</td>
						<td><select id="q" name="state" class="easyui-combobox"
							style="width: 145px;">
								<option value="-2">---请选择---</option>
								<option value="-1">潜在客户</option>
								<option value="0">正常客户</option>
						</select>
					</tr>
				</table>
		</form>
	</div>
	<!-- 6 添加或编辑对话框buttons -->
	<div id="potentialCustomerQueryDialogButtons">
		<a data-cmd="potentialCustomerQuerySave" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">确认</a>
		<a data-cmd="potentialCustomerQueryCancel" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-cancel" style="width: 90px">取消</a>
	</div>
	
	<!-- 7 升级对话框 -->
			<div id="potentialCustomerUpgradeDialog" class="easyui-dialog"
				style="width: 400px ; height:300px" closed="true"
				buttons="#potentialCustomerUpgradeDialogButtons" >   
				<form id="potentialCustomerUpgradeDialogForm" method="post" novalidate
					style="margin: 0; padding: 20px 50px">
					<!--由于添加和编辑对话框是通过一个Form，以隐藏域的方式区分是添加还是修改 -->

					
			<table>
					<tr>
						<td>客户姓名</td>
						<td><input type="text" name="name" class="easyui-validatebox" required ="true"/></td>
					</tr>
					<tr>
						<td>客户年龄</td>
						<td><input type="text" name="age" class="easyui-numberbox" required ="true"/></td>
					</tr>
					<tr>
						<td>客户性别</td>
						<td>
						男:<input name="gender" type="radio" value="1">&nbsp;&nbsp;
						女:<input name="gender" type="radio" value="-1">&nbsp;&nbsp;
					       嘿嘿嘿:<input name="gender" type="radio" value="0">
						</td>
					</tr>
					<tr>
						<td>电话号码</td>
						<td><input type="text" name="tel" class="easyui-numberbox" required ="true"/></td>
					</tr>
					<tr>
						<td>邮箱</td>
						<td><input type="text" name="email" /></td>
					</tr>

					<tr>
						<td>QQ</td>
						<td><input type="text" name="qq" class="easyui-numberbox"/></td>
					</tr>
					<tr>
						<td>微信</td>
						<td><input type="text" name="wechat" /></td>
					</tr>
					<tr>
						<td>创建时间</td>
						<td><input type="text" name="inputTime" class= "easyui-datebox" required ="true"/></td>
					</tr>

					<tr>
						<td>客户状态</td>
						<td><select id="q" name="state" class="easyui-combobox"
							style="width: 145px;">
								
								
								<option value="0">正式客户</option>
						</select></td>
					</tr>
					<tr>
						<td>销售人员</td>
						<td><select id="SS" name="seller.id" style="width: 145px;" />
						</td>
					</tr>
					<tr>
						<td>职业</td>
						<td><select id="JJ" name="job.id" style="width: 145px;" /></td>
					</tr>
					<tr>
						<td>收入水平</td>
						<td><select id="AA" name="salaryLevel.id"
							style="width: 145px;" /></td>
					</tr>
					<tr>
						<td>客户来源</td>
						<td><select id="DD" name="customerSource.id"
							style="width: 145px;" /></td>
					</tr>
					<tr>
						<td>创建人:</td>
						<td><select id="CC" name="inputUser.id" style="width: 145px;" required ="true"/>
						</td>
					</tr>
				</table>
					</form>
				</div>
				<!--  升级对话框buttons -->
				<div id="potentialCustomerUpgradeDialogButtons">
					<a data-cmd="potentialCustomerUpgradeSave" href="javascript:void(0)"
						class="easyui-linkbutton c6" iconCls="icon-ok"
						style="width: 90px">确认</a> <a data-cmd="potentialCustomerUpgradeCancel"
						href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-cancel" style="width: 90px">取消</a>
				</div>
</body>
</html>