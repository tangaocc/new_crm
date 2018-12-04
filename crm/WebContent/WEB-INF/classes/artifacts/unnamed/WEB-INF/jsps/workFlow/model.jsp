<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>流程模型管理</title>
<!-- 
	统一步骤：
	* 引入通用资源"WebContent/WEB-INF/views/common.jsp"
	-------在页面加载完毕后----------
	1、声明页面中，哪些组件需要获取后，使用的
	2、获取需要使用的组件，并缓存
	3、初始化
	4、创建一个命令对象，来管理页面中，需要调用的方法
	5、对页面中所有按钮，统一添加事件（如何区分不同按钮的逻辑？？）
 -->
<%@ include file="/WEB-INF/jsps/common.jsp" %>
<script type="text/javascript">
    //---页面加载完毕后---
	$(function(){
		// 1. 声明页面中可能会用到组件
		var modelGrid,modelDlg,modelForm,selectedPermissiongrid,allPermissiongrid;
		
		// 2. 缓存页面组件
		modelGrid = $("#modelGrid");
		modelDlg = $("#modelDlg");
		modelForm = $("#modelForm");
		selectedPermissiongrid = $("#selectedPermissiongrid");
		allPermissiongrid = $("#allPermissiongrid");

		// 3. 定义一个事件处理对象,把事件相关的逻辑都封装到一个对象上(命令对象)
		var cmdObj = {
				create:function(){
						//console.debug('create:function');
						//reset : 重置为初始值(定义方式:1.input的value属性写死;2.使用form的load方法加载后的属性)
						//clear : 清空
					//modelForm.form("clear");
					$("#sn").val('');
					$("#name").val('');
					// 清空表格,加载空数据
					selectedPermissiongrid.datagrid("loadData",{rows:[]});
					
					modelDlg.dialog("open");
				},
				deploy:function(){
					// 获取行选中数据
					var rowData = modelGrid.datagrid("getSelected");
					// 判断
					if(!rowData){
						$.messager.alert("温馨提示","请选中一行!!","info");
						return;
					}
					var url = "/workflow/model/deploy/"+rowData.id
					$.get(url,function(data){
								if (data.success) {
									//提示
									$.messager.alert("温馨提示","部署成功!","info");
									//刷新表格
									modelGrid.datagrid("reload")
								}else{
									//提示
									$.messager.alert("温馨提示",data.message,"error");
								}
							  },"json");
				},
				edit:function(){
						//console.debug('edit:function');
					// 获取行选中数据
					var rowData = modelGrid.datagrid("getSelected");
					// 判断
					if(!rowData){
						$.messager.alert("温馨提示","请选中一行!!","info");
						return;
					}
					window.open("/resources/js/wf/modeler.html?modelId="+rowData.id);
					
				},
				del:function(){
						//console.debug('del:function');
				},
				refresh : function(){
					modelGrid.datagrid("reload");
				},
				save: function(){
					modelForm.submit();
				},
				cancel : function(){
					modelDlg.dialog("close");
				}
				
			};
		// 4. 初始化组件
		modelGrid.datagrid({
				url:"/workflow/model/list",
				fit:true,
				border:false,
				fitColumns:true	,
				striped:true,
				toolbar:[{
					text:"新建模型",
					iconCls:"icon-add",
					plain:true,
					handler:cmdObj['create']
				},{
					text:"编辑模型",
					iconCls:"icon-edit",
					plain:true,
					handler:cmdObj['edit']
				},{
					text:"删除模型",
					iconCls:"icon-remove",
					plain:true,
					handler:cmdObj['del']
				},{
					text:"部署流程",
					iconCls:"icon-remove",
					plain:true,
					handler:cmdObj['deploy']
				},{
					text:"刷新",
					iconCls:"icon-reload",
					plain:true,
					handler:cmdObj['refresh']
				}],//"#modelTb",
				rownumbers:true,
				singleSelect:true,
				pagination:true,
				columns:[[
			          {field:'id',title:'ID',width:1},    
			          {field:'name',title:'名称',width:1},    
			          {field:'key',title:'KEY',width:1},    
			          {field:'createTime',title:'创建时间',width:1},    
			          {field:'description',title:'描述',width:1}
     
	          ]]
		});
		
		modelDlg.dialog({
			width: 400,
			height: 220,
			title:"部署新流程",
			closed:true,
			modal:true,
			buttons:[{
				text:"创建模型",
				iconCls:"icon-save",
				handler:cmdObj['save']
			},{
				text:"取消",
				iconCls:"icon-cancel",
				handler:cmdObj['cancel']
			}]//"#modelDlgBtn"
		});
		
		/* modelForm.form({
			url:"/workflow/model/create",
			success:function(data){
				// 把响应结果转换成JSON对象
				data = $.parseJSON(data);
				if(data.success){
					// 关闭对话框
					modelDlg.dialog("close");
					// 提示,刷新
					$.messager.alert("温馨提示",data.message,"info",function(){
						// 刷新表格数据
						modelGrid.datagrid("reload");
					});
				}else{
					$.messager.alert("温馨提示",data.message,"info",function(){
						// 根据错误码,定位到单元格
					});
				}
			}
		}); */
		
	});
</script>
</head>
<body>
	<!-- 1. 表格-->
	<table id="modelGrid">
	</table>
	<!-- 2. 对话框-->
	<div id="modelDlg" >
		<font style="font-weight: bold;"></font>
		<form id="modelForm" action="/workflow/model/create" method="post" enctype="application/x-www-form-urlencoded">
			<table align="center" style="margin-top: 10px;">
				<tr>
					<td>模型名称：</td>
					<td><input name="name"></td>
				</tr>
				<tr>
					<td>模型KEY：</td>
					<td><input name="key"></td>
				</tr>
				<tr>
					<td>描述：</td>
					<td><input name="description"></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>