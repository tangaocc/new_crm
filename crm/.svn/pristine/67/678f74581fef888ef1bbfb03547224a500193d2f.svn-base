<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单管理</title>
<!-- 导入公共jsp，就拥有了公共配置：easyui,js,css -->
<%@include file="/WEB-INF/jsps/common.jsp"%>

<script type="text/javascript">
	$(function() {
		// 1、声明出页面需要使用的组件
		var contractItemDataGrid, contractItemDialog, contractItemDialogForm,contractDialog1
		// 2、把页面的组件，缓存到上面声明的变量中
		contractItemDataGrid = $("#contractItemDataGrid");
		contractItemDialog = $("#contractItemDialog");
		contractItemDialogForm = $("#contractItemDialogForm");
		contractDialog1 = $("#contractDialog1");
		// 4、创建一个"命令对象"，把当前模块所有的功能，都打包到这个对象上
		var cmdObj = {

			"contractItemAdd" : function() {

				//清除表单
				contractItemDialogForm.form("clear");
				contractItemDialog.dialog("setTitle", "添加订单").dialog("center").dialog(
						"open");
				//打开dialog的时候：设置一个状态的默认值：defaultValue
				//$("#defaultValue").attr("checked",true);
				$("#defaultValue").prop("checked", true);

			},
			"contractItemEdit" : function() {
				//必须选中一行
				var row = contractItemDataGrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('温馨提示', '请选中要修改行!', 'error');
					return;//如果没有数据做了提示信息就应该返回
				} else {

					//先清除
					contractItemDialogForm.form("clear");
					//回显
					contractItemDialogForm.form("load", row);

					//上级部门回显
					if (row.customer) {
						$('#cc').combogrid('setValue', row.customer.name);
					}
					//回显部门经理
					if (row.manager) {

						$('#cg').combogrid('setValue', row.manager.name);
					}

					//打开新增或编辑对话框
					contractItemDialog.dialog("setTitle", "编辑订单").dialog("center")
							.dialog("open");

				}

			},
			//生成合同
			"contractItemCreateContract":function(){
				//必须选中一行
				var row = contractItemDataGrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('温馨提示', '请选中要需要生成合同的订单!', 'error');
					return;//如果没有数据做了提示信息就应该返回
				}
				if (row.contract){
					$.messager.alert('温馨提示', '此订单已经生成合同', 'error');
					return;//如果没有数据做了提示信息就应该返回
				}
				$.post("/contractItem/newContract?id="+row.id,function(data){
					if(data.success){
						$.messager.alert('恭喜你', '成功生成合同！', 'info');
						$.post("/contractItem/changeState",{"id":row.id},function(result){
							contractItemDataGrid.datagrid('reload');
						},'json')
					}				
				})
			},
			//保存订单
			"contractItemSave" : function() {
				contractItemDialogForm.form('submit', {
					url : "/contractItem/save",
					onSubmit : function() {
						return $(this).form('validate');
					},
					success : function(result) {
						//提交的返回值是Json字符串，不是Json对象，需要自己转换eval $.parseJSON JSON.parse
						var result = $.parseJSON(result);
						if (result.success) {
							//关闭对话框
							contractItemDialog.dialog("close");
							//给个提示信息
							$.messager.alert('温馨提示', '保存成功', 'info');
							//刷新界面
							contractItemDataGrid.datagrid('reload');
						} else {
							$.messager.alert('温馨提示', result.message, 'error');
						}
					}
				});
			},
			"contractItemDelete" : function() {

				var row = contractItemDataGrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('温馨提示', '请选中要删除行!', 'error');
					return;//如果没有数据做了提示信息就应该返回
				}
				if (row) {
					$.messager.confirm('温馨提示', '您确定要删除该行数据吗?', function(r) {
						if (r) {
							$.post('/contractItem/delete', {
								id : row.id
							}, function(result) {
								//期望返回成功与否，如果有错需要返回错误提示信息 {"success":true,"message":"xxxx"}
								//可以封装一个类AjaxResult，里面有两个属性
								if (result.success) {
									//给个提示信息
									$.messager.alert('温馨提示', '删除成功', 'info');
									//刷新界面
									contractItemDataGrid.datagrid('reload');
								} else {
									$.messager.alert('温馨提示', result.message,
											'error');
								}
							}, 'json');
						}
					});
				}
			},
			"contractItemRefresh" : function() {
				contractItemDataGrid.datagrid("reload");
			},
			"contractItemCancel" : function() {
				contractItemDialog.dialog("close");
			},
			"contractItemSearch":function(){
				//扩展jquer原型方法
				var paramObj2 =$("#contractItemSearchForm").serializeForm();
				contractItemDataGrid.datagrid('load',paramObj2);
		},
		"openContractItemAdvanceDialog":function(){
			//弹出高级查询对话框
			$("#contractItemAdvanceSearchDialog").dialog("setTitle","高级查询")
			                                   .dialog("center")
			                                   .dialog("open");
		},
		//关闭高级查询对话框
		"contractItemAdvaceSearchCancel":function(){
			$("#contractItemAdvanceSearchDialog").dialog("close");
		}
		,
		//提交高级查询对话框
		"contractItemAdvaceSearch":function(){
			contractItemDataGrid.datagrid('load',
				$("#contractItemAdvanceSearchDialogForm").serializeForm())
		}
	}
		// 5、对页面所有按钮，统一监听
		$("a[data-cmd]").click(function() {
			//5.1 获取cmd以便于区分是哪个超链接
			var cmd = $(this).data("cmd");//add
			
			if (cmd && !$(this).hasClass("l-btn-disabled")) {
				cmdObj[cmd]();
			}
		});
	})
 	function isPaymentFormatter(v,r,i){
		//v:就是字段值：0  -1
		console.debug(v)
		return  v==true?"<font color='green'>已付款</font>":"<font color='red'>未付款</font>";
	} 
</script>
</head>
<body>
	<!-- 1 datagrid -->
	<table id="contractItemDataGrid" title="订单列表" class="easyui-datagrid"
		fit="true" url="/contractItem/list" toolbar="#contractItemDataGridToolbar"
		pagination="true" rownumbers="true" fitColumns="true"
		singleSelect="true">
		<thead>
			<tr>
				<th field="id" width="50">Id</th>
				<th field="contract" formatter="objFormatter" width="50">所属合同</th>
				<th field="payTime" width="50">付款时间</th>
				<th field=money width="50">付款金额</th>
				<th field="scale" width="50">所占比例</th>
				<th field="isPayment" width="50" formatter="isPaymentFormatter">是否付款</th>
				<!-- 格式化代码在common.js中 -->
			</tr>
		</thead>
	</table>
	<!-- 2 toolBar -->
	<div id="contractItemDataGridToolbar">
		<a id="contractItemDelete" data-cmd="contractItemDelete" href="javascript:void(0)"
			class="easyui-linkbutton c5" iconCls="icon-remove" plain="true">删除</a>
		<a id="contractItemRefresh" data-cmd="contractItemRefresh" href="javascript:void(0)"
			class="easyui-linkbutton c7" iconCls="icon-reload" plain="true">刷新</a>
		<div>
			<form id="contractItemSearchForm" action="#">
				<!-- 关键字，状态 -->
				关键字：<input id="q" type="text" name="q"> 
				是否付款：<select name="isPaymentFormatter" id="state">
   	    	     <option value=null>--请选择--</option>
   	    	     <option value=true>已付款</option>
   	    	     <option value=false>未付款</option>
   	    	   	 </select>
				<a href="javascript:void(0)" data-cmd="contractItemSearch"
					class="easyui-linkbutton c3" iconCls="icon-search" plain="true">查询</a>
				<a href="javascript:void(0)" data-cmd="openContractItemAdvanceDialog"
					class="easyui-linkbutton c1" iconCls="icon-search" plain="true">高级查询</a>

			</form>
		</div>
	</div>
	<!-- 3 添加或编辑对话框 -->
	<div id="contractItemDialog" class="easyui-dialog" style="width: 400px"
		closed="true" buttons="#contractItemDialogButtons">
		<form id="contractItemDialogForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<!--由于添加和编辑对话框是通过一个Form，以隐藏域的方式区分是添加还是修改 -->
			<input type="hidden" name="id">
			<table>

				<tr>
					<td>签定时间:</td>
					<td><input name="signTime" type="text" class="easyui-datebox" /></td>
				</tr>
				<tr>
					<td>定金客户:</td>
				</tr>
				<tr>
					<td>定金金额:</td>
					<td><input name="sum" type="text" /></td>
				</tr>
				<tr>
					<td>状态:</td>
					<td><input id="defaultValue" name="state" type="radio"
						value="0" />已生成合同 <input name="state" type="radio" value="-1" />未生成合同</td>
				</tr>
				<tr>
					<td>摘要:</td>
					<td><input name="intro" type="text" /></td>
				</tr>
			</table>

		</form>
	</div>
	
		<!-- 3 高级查询框 -->
	<div id="contractItemAdvanceSearchDialog" class="easyui-dialog" style="width: 400px"
		closed="true" buttons="#contractItemAdvanceSearchDialogButtons">
		<form id="contractItemDialogForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<!--由于添加和编辑对话框是通过一个Form，以隐藏域的方式区分是添加还是修改 -->
			<input type="hidden" name="id">
			<table>
				<tr>
					<td>签定时间:</td>
					<td><input name="signTime" type="text" class="easyui-datebox" /></td>
				</tr>
			</table>

		</form>
	</div>
	
	<!-- 4 添加或编辑对话框buttons -->
	<div id="contractItemDialogButtons">
		<a id="contractItemSave" data-cmd="contractItemSave"
			href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" style="width: 90px">保存</a> <a id="contractItemCancel"
			data-cmd="contractItemCancel" href="javascript:void(0)"
			class="easyui-linkbutton c5" iconCls="icon-cancel"
			style="width: 90px">取消</a>
	</div>
	
	<!-- 高级查询对话框buttons -->
	<div id="contractItemAdvanceSearchDialogButtons">
        <a data-cmd="contractItemAdvaceSearch" href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">查询</a>
        <a data-cmd="contractItemAdvaceSearchCancel" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" style="width:90px">关闭</a>
    </div>

</body>
</html>