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
		var orderDataGrid, orderDialog, orderDialogForm,orderQueryDialogForm,contractDialog1
		// 2、把页面的组件，缓存到上面声明的变量中
		orderDataGrid = $("#orderDataGrid");
		orderDialog = $("#orderDialog");
		orderDialogForm = $("#orderDialogForm");
		orderQueryDialogForm = $("#orderQueryDialogForm");
		contractDialog1 = $("#contractDialog1");
		cg = $("#cg");
		vg = $("#vg");
		// 4、创建一个"命令对象"，把当前模块所有的功能，都打包到这个对象上
		var cmdObj = {

			"orderAdd" : function() {

				//清除表单
				orderDialogForm.form("clear");
				orderDialog.dialog("setTitle", "添加订单").dialog("center").dialog(
						"open");
				//打开dialog的时候：设置一个状态的默认值：defaultValue
				//$("#defaultValue").attr("checked",true);
				$("#defaultValue").prop("checked", true);

			},
			"orderEdit" : function() {
				//必须选中一行
				var row = orderDataGrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('温馨提示', '请选中要修改行!', 'error');
					return;//如果没有数据做了提示信息就应该返回
				} else {

					//先清除
					orderDialogForm.form("clear");
					//回显
					orderDialogForm.form("load", row);

					//回显
					if(row.seller){
						console.debug(row);
						vg.combogrid("setValue",row.seller.id);
					}
					if(row.signTime){
						$("#signTime").datebox("setValue", row.signTime);
					}
					if (row.customer) {
						cg.combogrid("setValue",row.customer.id);
					}

					//打开新增或编辑对话框
					orderDialog.dialog("setTitle", "编辑订单").dialog("center")
							.dialog("open");

				}

			},
			//生成合同
			"orderCreateContract":function(){
				//必须选中一行
				var row = orderDataGrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('温馨提示', '请选中要需要生成合同的订单!', 'error');
					return;//如果没有数据做了提示信息就应该返回
				}
				if (row.contract){
					$.messager.alert('温馨提示', '此订单已经生成合同', 'error');
					return;//如果没有数据做了提示信息就应该返回
				}
				$.post("/order/newContract?id="+row.id,function(data){
					console.debug(data)
					if(data.success){
						$.messager.alert('恭喜你', '成功生成合同！', 'info');
						var row = orderDataGrid.datagrid('getSelected');
						console.debug(row);
						$.post('/order/changeState', {
							"id" : row.id
						}, function(result) {
						}, 'json');
					}
					orderDataGrid.datagrid("reload");
				})
				
			},
			
			//保存订单
			"orderSave" : function() {
					
				orderDialogForm.form('submit', {
					url : "/order/save",
					onSubmit : function() {
						return $(this).form('validate');
					},
					success : function(result) {
						//提交的返回值是Json字符串，不是Json对象，需要自己转换eval $.parseJSON JSON.parse
						var result = $.parseJSON(result);
						console.debug(result);
						if (result.success) {
							//关闭对话框
							orderDialog.dialog("close");
							//给个提示信息
							$.messager.alert('温馨提示', '保存成功', 'info');
							//刷新界面
							orderDataGrid.datagrid('reload');
						} else {
							$.messager.alert('温馨提示', result.message, 'error');
						}
					}
				});
			},
			"orderDelete" : function() {

				var row = orderDataGrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('温馨提示', '请选中要删除行!', 'error');
					return;//如果没有数据做了提示信息就应该返回
				}
				if (row) {
					$.messager.confirm('温馨提示', '您确定要删除该行数据吗?', function(r) {
						if (r) {
							$.post('/order/delete', {
								id : row.id
							}, function(result) {
								//期望返回成功与否，如果有错需要返回错误提示信息 {"success":true,"message":"xxxx"}
								//可以封装一个类AjaxResult，里面有两个属性
								if (result.success) {
									//给个提示信息
									$.messager.alert('温馨提示', '删除成功', 'info');
									//刷新界面
									orderDataGrid.datagrid('reload');
								} else {
									$.messager.alert('温馨提示', result.message,
											'error');
								}
							}, 'json');
						}
					});
				}
			},
			"orderRefresh" : function() {
				orderDataGrid.datagrid("reload");
			},
			"orderCancel" : function() {
				orderDialog.dialog("close");
			},
			"orderSearch":function(){
				//扩展jquer原型方法
				var paramObj2 =$("#orderSearchForm").serializeForm();
				orderDataGrid.datagrid('load',paramObj2);
		},
		"openOrderAdvanceDialog":function(){
			orderQueryDialogForm.form("clear");
			 //打开dialog的时候：设置一个状态的默认值：defaultValue
			$("#defaultValue").prop("checked",true);
			 
			//弹出高级查询对话框
			$("#orderAdvanceSearchDialog").dialog("setTitle","高级查询")
			                                   .dialog("center")
			                                   .dialog("open");
		},
		//关闭高级查询对话框
		"orderAdvaceSearchCancel":function(){
			$("#orderAdvanceSearchDialog").dialog("close");
		}
		,
		//提交高级查询对话框
		"orderAdvaceSearch":function(){
			orderDataGrid.datagrid('load',$("#orderQueryDialogForm").serializeForm());
			$("#orderAdvanceSearchDialog").dialog("close");
		}
	}
		 // 5、对页面所有按钮，统一监听
		$("a[data-cmd]").click(function() {
			//5.1 获取cmd以便于区分是哪个超链接
			var cmd = $(this).data("cmd");//add
			//5.2 完成对应方法调用
			
			//方案2：动态调用
			//判断定义了cmd，并且没有被禁用
			if (cmd && !$(this).hasClass("l-btn-disabled")) {
				cmdObj[cmd]();
			}
		}); 
		
	})
	function stateFormatter(v,r,i){
		//v:就是字段值：0  -1
		console.debug(v)
		return  v==0?"<font color='green'>已生成合同</font>":"<font color='red'>未生成合同</font>";
	}
</script>
</head>
<body>
	<!-- 1 datagrid -->
	<table id="orderDataGrid" title="订单列表" class="easyui-datagrid"
		fit="true" url="/order/list" toolbar="#orderDataGridToolbar"
		pagination="true" rownumbers="true" fitColumns="true"
		singleSelect="true">
		<thead>
			<tr>
				<th field="id" width="50">Id</th>
				<th field="sn" width="50">定金单号</th>
				<th field="customer" formatter="objFormatter" width="50">定金客户</th>
				<th field="signTime" width="50">签订时间</th>
				<th field="seller" formatter="objFormatter" width="50">营销人员</th>
				<th field="sum" width="50">定金金额</th>
				<th field="intro" width="50">摘要</th>
				<th field="state" width="50" formatter="stateFormatter">是否生成合同</th>
				<!-- 格式化代码在common.js中 -->
			</tr>
		</thead>
	</table>
	<!-- 2 toolBar -->
	<div id="orderDataGridToolbar">
		<a id="orderAdd" data-cmd="orderAdd" href="javascript:void(0)"
			class="easyui-linkbutton c1" iconCls="icon-add " plain="true">新增</a>
		<a id="orderEdit" data-cmd="orderEdit" href="javascript:void(0)"
			class="easyui-linkbutton c3" iconCls="icon-edit" plain="true">修改</a>
		<a id="orderDelete" data-cmd="orderDelete" href="javascript:void(0)"
			class="easyui-linkbutton c5" iconCls="icon-remove" plain="true">删除</a>
		<a id="orderRefresh" data-cmd="orderRefresh" href="javascript:void(0)"
			class="easyui-linkbutton c7" iconCls="icon-reload" plain="true">刷新</a>
		<a id="orderCreateContract" data-cmd="orderCreateContract" href="javascript:void(0)"
			class="easyui-linkbutton c8" iconCls="icon-reload" plain="true">生成合同</a>
		<div>
			<form id="orderSearchForm" action="#">
				<!-- 关键字，状态 -->
				关键字：<input id="q" type="text" name="q"> 
				状态：<select name="state" id="state">
   	    	     <option value="-2">--请选择--</option>
   	    	     <option value="0">已生成合同</option>
   	    	     <option value="-1">未生成合同</option>
   	    	   	 </select>
				<a href="javascript:void(0)" data-cmd="orderSearch"
					class="easyui-linkbutton c3" iconCls="icon-search" plain="true">查询</a>
				<a href="javascript:void(0)" data-cmd="openOrderAdvanceDialog"
					class="easyui-linkbutton c1" iconCls="icon-search" plain="true">高级查询</a>

			</form>
		</div>
	</div>
	<!-- 3 添加或编辑对话框 -->
	<div id="orderDialog" class="easyui-dialog" style="width: 400px"
		closed="true" buttons="#orderDialogButtons">
		<form id="orderDialogForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<!--由于添加和编辑对话框是通过一个Form，以隐藏域的方式区分是添加还是修改 -->
			<input type="hidden" name="id">
			<table>
				<tr>
					<td>营销人员:</td>
					<td><select id="vg" class="easyui-combogrid" name="seller.id"
						style="width: 145px;"
						data-options="    
			            panelWidth:450,   
			             fitColumns:'true', 
			             value:'006',  
			            idField:'id',    
			            textField:'username',    
			            url:'/employee/list',  
			            pagination:true,
			            mode:'remote',
			            columns:[[    
			                {field:'username',title:'名称',width:60},
			                {field:'realName',title:'真实姓名',width:60},    
			                {field:'tel',title:'电话',width:100},    
			                {field:'email',title:'邮箱',width:120} 
			            ]]    
			        "></select></td>
				</tr>
				<tr>
					<td>签定时间:</td>
					<td><input name="signTime" type="text" class="easyui-datebox" /></td>
				</tr>
				<tr>
					<td>定金客户:</td>
					<td><select
						id="cg" class="easyui-combogrid" name="customer.id"
						style="width: 145px;"
						data-options="    
			            panelWidth:450,   
			             fitColumns:'true',   
			            idField:'id',    
			            textField:'name',    
			            url:'/customer/list',  
			            pagination:true,
			            mode:'remote',
			            columns:[[    
			                {field:'name',title:'姓名',width:60},    
			                {field:'tel',title:'电话',width:100},    
			                {field:'age',title:'年龄',width:120},
			                {field:'qq',title:'qq',width:120}
			            ]]    
			        "></select>
			        </td>
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
	<!-- 3添加或编辑对话框buttons -->
	<div id="orderDialogButtons">
		<a id="orderSave" data-cmd="orderSave" href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" style="width: 90px">保存</a> 
			
			<a id="orderCancel"
			data-cmd="orderCancel" href="javascript:void(0)"
			class="easyui-linkbutton c5" iconCls="icon-cancel"
			style="width: 90px">取消</a>
	</div>
	
	
		<!-- 
		
		4 高级查询框orderQueryDialogForm 
		
		-->
	<div id="orderAdvanceSearchDialog" class="easyui-dialog" style="width: 400px"
		closed="true" buttons="#orderAdvanceSearchDialogButtons">
		
		<form id="orderQueryDialogForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<!--由于添加和编辑对话框是通过一个Form，以隐藏域的方式区分是添加还是修改 -->
			<input type="hidden" name="id">
			<table>
				<tr>
					<td>销售人员:</td>
					<td><select id="cg1" class="easyui-combogrid" name="sellerId"
						style="width: 145px;"
						data-options="    
			            panelWidth:450,   
			             fitColumns:'true',  
			            idField:'id',    
			            textField:'username',    
			            url:'/employee/list',  
			            pagination:true,
			            mode:'remote',
			            columns:[[    
			                {field:'username',title:'名称',width:60},
			                {field:'realName',title:'真实姓名',width:60},    
			                {field:'tel',title:'电话',width:100},    
			                {field:'email',title:'邮箱',width:120} 
			            ]]    
			        "></select></td>
				</tr>
				<tr>
					<td>签定时间:</td>
					<td><input name="signTime" type="text" class="easyui-datebox" /></td>
				</tr>
				<tr>
					<td>定金客户:</td>
					
					<td><select id="cg2" class="easyui-combogrid"
						name="customerId" style="width: 145px;"
						data-options="    
			            panelWidth:450,   
			            fitColumns:'true',   
			            idField:'id',    
			            textField:'name',    
			            url:'/customer/list',  
			            pagination:true,
			            mode:'remote',
			            columns:[[    
			                {field:'name',title:'名称',width:60},    
			                {field:'tel',title:'电话',width:100},    
			                {field:'email',title:'邮箱',width:120},
			                {field:'wechat',title:'微信',width:120}  
			            ]]    
			        "></select></td>
				</tr>
			</table>

		</form>
	</div>
	
	
	
	<!-- 5高级查询对话框buttons -->
	<div id="orderAdvanceSearchDialogButtons">
        <a data-cmd="orderAdvaceSearch" href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">查询</a>
        <a data-cmd="orderAdvaceSearchCancel" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" style="width:90px">关闭</a>
    </div>

</body>
</html>