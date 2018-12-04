<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 导入公共jsp，就拥有了公共配置：easyui,js,css -->
<%@include file="/WEB-INF/jsps/common.jsp"%>
<title>部门管理</title>

<script type="text/javascript">
//页面加载完毕后
$(function(){
   // 1、声明出页面需要使用的组件
   var permissionDataGrid,permissionDialog,permissionDialogForm;
   // 2、把页面的组件，缓存到上面声明的变量中
   permissionDataGrid=$("#permissionDataGrid");
   permissionDialog=$("#permissionDialog");
   permissionDialogForm=$("#permissionDialogForm");
   // 3、初始化组件，修改组件的值
   // 4、创建一个"命令对象"，把当前模块所有的功能，都打包到这个对象上
   var cmdObj = {
		"permissionAdd":function(){
		  //清除表单
		  permissionDialogForm.form("clear");
		  permissionDialog.dialog("setTitle","添加部门").dialog("center").dialog("open");
	      //打开dialog的时候：设置一个状态的默认值：defaultValue
	      //$("#defaultValue").attr("checked",true);
	      $("#defaultValue").prop("checked",true);
	      
	      //打开dialog的时候，需要去加载一下combotree，不然数据可能不能及时更新：js方创建
	      $('#cc').combotree({    
	    	    url: "/permission/loadDepartmentTree",    
	    	    required: true   
	    	}); 
		},
		"permissionRefresh":function(){
		  permissionDataGrid.datagrid("reload");
		},
		"permissionCancel":function(){
			permissionDialog.dialog("close");
		},
		"permissionEdit":function(){
			  //必须选中一行
			   var row = permissionDataGrid.datagrid('getSelected');
			   if (!row) {
				   $.messager.alert('温馨提示','请选中要修改行!','error');
				   return;//如果没有数据做了提示信息就应该返回
				}else{
					
				   //先清除
				   permissionDialogForm.form("clear");
				   //回显
				  permissionDialogForm.form("load",row);
				  //打开新增或编辑对话框
				  permissionDialog.dialog("setTitle","编辑部门").dialog("center").dialog("open");
				   
				  $('#cc').combotree({    
			    	    url: "/permission/loadDepartmentTree",    
			    	    required: true   
			    	}); 
				  //combotree的回显：部门的id,使用setValue
		         $('#cc').combotree('setValue', row.parent.id);
				
				  //combogrid的回显：经理的id,使用setValue
		         $('#combogrid').combogrid('setValue','');
				 $('#combogrid').combogrid('setValue', row.manager.id);
					
				   
				  
					
				} 
		   
			   
		},
		"permissionSave":function(){
					permissionDialogForm.form('submit',{
			        url: "/permission/save",
			        onSubmit: function(){
			            return $(this).form('validate');
			        },
			        success: function(result){
			     	   //提交的返回值是Json字符串，不是Json对象，需要自己转换eval $.parseJSON JSON.parse
			            var result = $.parseJSON(result);
			            if (result.success){
			         	   //关闭对话框
			         	   permissionDialog.dialog("close");
			         	   //给个提示信息
			         	   $.messager.alert('温馨提示','保存成功','info');
			         	    //刷新界面
			                permissionDataGrid.datagrid('reload');
			            } else {
			         	   $.messager.alert('温馨提示',result.message,'error');
			            }
			        }
			    });
			},
			"permissionDelete":function(){
				   
				   var row = permissionDataGrid.datagrid('getSelected');
				   if (!row) {
					   $.messager.alert('温馨提示','请选中要删除行!','error');
					   return;//如果没有数据做了提示信息就应该返回
					}
			    if (row){
			        $.messager.confirm('温馨提示','您确定要删除该行数据吗?',function(r){
			            if (r){
			                $.post('/permission/delete',{id:row.id},function(result){
			             	   //期望返回成功与否，如果有错需要返回错误提示信息 {"success":true,"message":"xxxx"}
			             	   //可以封装一个类AjaxResult，里面有两个属性
			                    if (result.success){
			                 	   //给个提示信息
			                 	   $.messager.alert('温馨提示','删除成功','info');
			                 	    //刷新界面
			                        permissionDataGrid.datagrid('reload');
			                    } else {
			                 	   $.messager.alert('温馨提示',result.message,'error');
			                    }
			                },'json');
			            }
			        });
			    }
			}
   }
   // 5、对页面所有按钮，统一监听
   $("a[data-cmd]").click(function(){
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
	   if (cmd && !$(this).hasClass("l-btn-disabled")) 
	   {
	  	 cmdObj[cmd]();
	   }
   });
})


</script>
</head>
<body>
	<!-- 1 datagrid -->

	<!-- 1 datagrid -->
	<table id="permissionDataGrid" title="权限列表" class="easyui-datagrid"
		fit="true" url="/permission/list" toolbar="#permissionDataGridToolbar"
		pagination="true" rownumbers="true" fitColumns="true"
		singleSelect="true">
		<thead>
			<tr>
				<!-- 显示数据：更加th的field对应显示 -->
				<th field="id" hidden=true width="50">id</th>
				<th field="name" width="50">权限名称</th>
				<th field="sn" width="50">权限编号</th>
				<th field="resource" width="50">路径</th>

			</tr>
		</thead>
	</table>
	<!-- 2 toolBar -->
	<div id="permissionDataGridToolbar">
		<a id="permissionAdd" data-cmd="permissionAdd"
			href="javascript:void(0)" class="easyui-linkbutton c1"
			iconCls="icon-add " plain="true">新增</a> <a id="permissionEdit"
			data-cmd="permissionEdit" href="javascript:void(0)"
			class="easyui-linkbutton c3" iconCls="icon-edit" plain="true">修改</a>
		<a id="permissionDelete" data-cmd="permissionDelete"
			href="javascript:void(0)" class="easyui-linkbutton c5"
			iconCls="icon-remove" plain="true">删除</a> <a id="permissionRefresh"
			data-cmd="permissionRefresh" href="javascript:void(0)"
			class="easyui-linkbutton c7" iconCls="icon-reload" plain="true">刷新</a>
	</div>

	<!-- 3 添加或编辑对话框  模态框！ -->
	<div id="permissionDialog" class="easyui-dialog" style="width: 400px"
		closed="true" buttons="#permissionDialogButtons">
		<form id="permissionDialogForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<!--由于添加和编辑对话框是通过一个Form，以隐藏域的方式区分是添加还是修改 -->
			<input type="hidden" name="id">
			<table>
				<tr>
					<td>权限名称:</td>
					<td><input name="name" type="text" /></td>
				</tr>
				<tr>
					<td>权限编号:</td>
					<td><input name="sn" type="text" /></td>
				</tr>
				<tr>
					<td>路径:</td>
					<td><input name="resource" type="text" /></td>
				</tr>
				<!--  	  <tr>
        	    <td>状态:</td>
        	    <td>
        	             <input id="defaultValue" name="state" type="radio" value="0"/>正常
        	             <input name="state" type="radio" value="-1"/> 停用
        	     </td>
        	  </tr> -->

			</table>

		</form>
	</div>
	<!-- 4 添加或编辑对话框buttons -->
	<div id="permissionDialogButtons">
		<a id="permissionSave" data-cmd="permissionSave"
			href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" style="width: 90px">保存</a> <a id="permissionCancel"
			data-cmd="permissionCancel" href="javascript:void(0)"
			class="easyui-linkbutton c5" iconCls="icon-cancel"
			style="width: 90px">取消</a>
	</div>

</body>
</html>