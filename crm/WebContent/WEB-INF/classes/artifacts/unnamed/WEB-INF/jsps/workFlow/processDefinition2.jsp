<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>流程规则管理</title>
<%@include file= "/WEB-INF/jsps/common.jsp"%>
<script type="text/javascript">
	// 页面加载完毕后
	$(function() {
		// 1、声明出页面需要使用的组件
		var processDefinitionDatagrid,processDefinitionDialog, processDefinitionDialogForm;
		// 2、把页面的组件，缓存到上面声明的变量中
		processDefinitionDatagrid = $("#processDefinitionDatagrid");
		processDefinitionDialog = $("#processDefinitionDialog");
		processDefinitionDialogForm = $("#processDefinitionDialogForm");
		// 4、创建一个"命令对象"，把当前模块所有的功能，都打包到这个对象上
		var cmdObj = {
			create : function() {
				 //清除表单
				  processDefinitionDialogForm.form("clear");
				  processDefinitionDialog.dialog("setTitle","部署新流程").dialog("center").dialog("open");
				
			},
			edit : function() {
				// 获取选中行数据
				var rowData = processDefinitionDatagrid.datagrid("getSelected");
				// 判断是否选中行
				if (!rowData) {
					jQuery.messager.alert("温馨提示", "请选中一行数据！！", "info");
					return;
				}
				// 清空对话框里面的表单内容
				processDefinitionForm.form("clear");
				// 加载数据：Easyui form的load方法，遵循一个“同名匹配”的原则
				processDefinitionForm.form("load", rowData);
				// 打开对话框
				processDefinitionDialog.dialog("open");
			},
			remove : function() {
				// 获取选中行数据
				var rowData = processDefinitionDatagrid.datagrid("getSelected");
				// 判断是否选中行
				if (!rowData) {
					jQuery.messager.alert("温馨提示", "请选中一行数据！！", "info");
					return;
				}
				jQuery.get("/processDefinition/delete?id="+rowData.id, function(data) {
					if (data.success) {//删除成功
						jQuery.messager.alert('消息提示', '删除成功!', 'info',
								function() {
									//调用重新加载数据的方法
									processDefinitionDatagrid.datagrid("reload");
								});//消息							
					} else {
						jQuery.messager.alert('错误提示', data.message, 'error');
					}
				}, 'json');
			},
			reload : function() {
				//调用重新加载数据的方法
				processDefinitionDatagrid.datagrid("reload");
			},
			save : function(){
				processDefinitionDialogForm.form('submit',{
			        url: "/workFlow/newDeploy",
			        onSubmit: function(){
			            return $(this).form('validate');
			        },
			        success: function(result){
			     	   //提交的返回值是Json字符串，不是Json对象，需要自己转换eval $.parseJSON JSON.parse
			            var result = $.parseJSON(result);
			            if (result.success){
			         	   //关闭对话框
			         	   processDefinitionDialog.dialog("close");
			         	   //给个提示信息
			         	   $.messager.alert('温馨提示','保存成功','info');
			         	    //刷新界面
			                processDefinitionDataGrid.datagrid('reload');
			            } else {
			         	   $.messager.alert('温馨提示',result.message,'error');
			            }
			        }
			    });
			},
			cancel : function() {
				//关闭对话框
				processDefinitionDialog.dialog("close");
			},
			search : function() {//简单搜索：查询条件必须少
				processDefinitionDatagrid.datagrid("load", $("#searchForm").serializeJSON());
			}
		};
		// 3、初始化组件
		//初始datagrid
		processDefinitionDatagrid.datagrid({    
		    url:'/workFlow/processDefinition/list',
		    title:'流程规则管理',    
		    fit:true,    
		    border:false,    
		    fitColumns:true,    
		    singleSelect:true,    
		    pagination:true,    
		    rownumbers:true,    
		    columns:[[    
		    	{field:'id',title:'流程规则ID',width:10},  
		        {field:'name',title:'流程规则名称',width:10}    
		        //{field:'sn',title:'标识',width:10}   
		       // {field:'permissions',title:'拥有权限',width:80,'formatter':arrayFormatter}    
		    ]],
		    toolbar: [{
		    	text:'部署新流程',
				iconCls: 'icon-add',
				handler: cmdObj['create']
			},{
		    	text:'删除',
				iconCls: 'icon-remove',
				handler: cmdObj['remove']
			},{
		    	text:'查询规则流程图',
				iconCls: 'icon-edit',
				handler: cmdObj['edit']
			},'-',{
				text:'刷新',
				iconCls: 'icon-reload',
				handler: cmdObj['reload']
			}]
		}); 
		
		//初始化dialog
		processDefinitionDialog.dialog({    
		    title: '添加或修改流程规则',    
		    width: 850,    
		    height: 420,    
		    closed: true,    
		    modal: true,
		    buttons:[{
				text:'保存',
				iconCls:'icon-ok',
				handler:cmdObj['save']
			},{
				text:'取消',
				iconCls:'icon-cancel',
				handler:cmdObj['cancel']
			}]   
		});
		// 初始化添加表单
		processDefinitionDialogForm.form({
			url : "/processDefinition/newDepoly",
			onSubmit : function() { // 在表单‘提交前’，做验证
				return processDefinitionForm.form("validate");
			},
			success : function(data) {//data是后台save方法返回的字符串
				// 把字符串转变成json对象
				data = jQuery.parseJSON(data);
				// 判断结果
				if (data.success) {
					// 关对话框
					processDefinitionDialog.dialog("close");
					jQuery.messager.alert("温馨提示", data.message, "info", function() {
						//调用重新加载数据的方法
						processDefinitionDatagrid.datagrid("reload");
					});
				} else {
					jQuery.messager.alert('错误提示', data.message, 'error');
				}
			}
		});
		// 5、对页面所有按钮，统一监听
		$("a[data-cmd]").on("click", function() {
			// 获取对应按钮的cmd信息 
			//var cmd = $(this).attr("data-cmd");
			var cmd = $(this).data("cmd");
			// console.debug(cmd);
			if (cmdObj[cmd]) {
				//组件的disabled禁用属性,无法控制事件.
				//判断按钮是否有禁用样式.
				if ($(this).hasClass("l-btn-disabled")) {
					return;
				}
				//动态的方法名称，就调用动态的方法
				cmdObj[cmd]();
			}
		});
	});
</script>
</head>
<body>
	<!-- 1、数据表格 -->
	<table id="processDefinitionDatagrid"></table>
	<!-- 2、添加编辑对话框 -->
	<div id="processDefinitionDialog">
		<form id="processDefinitionForm" method="post">
			<input name="id" type="hidden" />
			<table align="center" style="padding: 10px">
			  <tr>
			    <td>部署名称</td><td><input type="text" name="name"/></td>
			  </tr>
			  <tr>
			    <td>流程文件</td><td><input type="file" name="processFile"/></td>
			  </tr>
			</table>
		</form>
	</div>
</body>
</html>