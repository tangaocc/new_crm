<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 导入公共jsp，就拥有了公共配置：easyui,js,css -->
<%@include file="/WEB-INF/jsps/common.jsp" %>
<title>部门管理</title>

<script type="text/javascript">
//页面加载完毕后
$(function(){
   // 1、声明出页面需要使用的组件
   var permissionDataGrid,permissionDialog,permissionDialogForm,permissionQueryDialog,permissionQueryDialogForm;
   // 2、把页面的组件，缓存到上面声明的变量中
   permissionDataGrid=$("#permissionDataGrid");
   permissionDialog=$("#permissionDialog");
   permissionDialogForm=$("#permissionDialogForm");
   permissionQueryDialog=$("#permissionQueryDialog");
   permissionQueryDialogForm=$("#permissionQueryDialogForm");
   
   // 3、初始化组件，修改组件的值
   
   
   // 4、创建一个"命令对象"，把当前模块所有的功能，都打包到这个对象上
   var cmdObj = {
		   
		
		"permissionSearch":function(){
			//方案3：讲方案2扩展到JQ原型方法  再放到common.jsp中
			var paramObj = $("#permSearchForm").serializeForm();
			permissionDataGrid.datagrid('load',paramObj); 
		 },  
		 //高级查询
		"permissionQueryBy":function(){
			permissionQueryDialogForm.form("clear");
			 //打开dialog的时候：设置一个状态的默认值：defaultValue
			$("#defaultValue").prop("checked",true);
			permissionQueryDialog.dialog("setTitle","高级查询权限").dialog("center").dialog("open");
			 
			
			 
			 
		 },  
		 
		 "permissionQuerySave":function(){
			 var param = $("#permissionQueryDialogForm").serializeForm();
				console.debug(param);
				//高级查询实现
				permissionDataGrid.datagrid("load",param);
				//关闭对话框
	         	   permissionQueryDialog.dialog("close");
			 
			/*  
			 permissionQueryDialogForm.form('submit',{
		        url: "/permission/list",
		        onSubmit: function(){
		            return $(this).form('validate');
		        },
		        success: function(result){
		     	   //提交的返回值是Json字符串，不是Json对象，需要自己转换eval $.parseJSON JSON.parse
		            var result = $.parseJSON(result);
		            if (result.success){
			         	//方案3：讲方案2扩展到JQ原型方法  再放到common.jsp中
			   			//var paramObj2 = $("#permissionQueryDialogForm").serializeForm();
			   			var paramObj2 = result.serializeForm();
		         	   //关闭对话框
		         	   permissionQueryDialog.dialog("close");
		         	   //给个提示信息
		         	   $.messager.alert('温馨提示','保存成功','info');
		         	    //刷新界面
			   			permissionDataGrid.datagrid('load',paramObj2); 
		               
		            } else {
		         	   $.messager.alert('温馨提示',result.message,'error');
		            }
		        }
		    }); */
		},
		"permissionQueryCancel":function(){
			permissionQueryDialog.dialog("close");
		},
		//加载资源;
		"loadPermissionResource":function(){
			$("#loadPermissionResourceDlg").dialog('center').dialog('open')
			.dialog('setTitle', '加载资源中...');
			
			//开启进度条控制;
			start();
		},
		//permissionADDS
		/* "permissionADDS":function(){
			//发送请求.加载资源
		      $.get("/permission/loadResource",function(result){
		    	  if(result.success){
		    		  //关闭对话框
		    		  $("#loadPermissionResourceDlg").dialog('close');
		    		  //加载成功刷新表格;
		    		  permissionDatagrid.datagrid('reload');
		    		  $.messager.alert('温馨提示', result.message,'info');
		    	  }else{
		    		  $("#loadPermissionResourceDlg").dialog('close');
		    		  $.messager.alert('温馨提示', result.message,'error');
		    	  }
		      },"json");
			  //$.messager.alert('温馨提示','批量保存成功！','info');
		}, */
		
		"permissionAdd":function(){
		  //清除表单
		  permissionDialogForm.form("clear");
		  permissionDialog.dialog("setTitle","添加权限").dialog("center").dialog("open");
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
				  permissionDialog.dialog("setTitle","编辑权限").dialog("center").dialog("open");
				   
				  /* $('#cc').combotree({    
			    	    url: "/permission/loadDepartmentTree",    
			    	    required: true   
			    	}); 
				  //combotree的回显：部门的id,使用setValue
		         $('#cc').combotree('setValue', row.parent.id);
				
				  //combogrid的回显：经理的id,使用setValue
		         $('#combogrid').combogrid('setValue',''); */
				 $('#cc').combogrid('setValue', row.state);
					
				   
				  
					
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
   
   
 /////加载资源进度条控制;
	var i = 0;
	function start() {
	  i = $('#p').progressbar('getValue') == 100 ? 0 : $('#p').progressbar('getValue');
	  var aa = setInterval(function() {
	    i++;
	    $('#p').progressbar('setValue', i);
	    $('#p').attr("data-percent", i);
	    if (i == 100) {
	      i = 0;
	      clearInterval(aa);
	      //发送请求.加载资源
	      $.get("/permission/loadResource",function(result){
	    	  if(result.success){
	    		  //关闭对话框
	    		  $("#loadPermissionResourceDlg").dialog('close');
	    		  //加载成功刷新表格;
	    		  permissionDataGrid.datagrid('reload');
	    		  $.messager.alert('温馨提示', result.message,'info');
	    	  }else{
	    		  $("#loadPermissionResourceDlg").dialog('close');
	    		  $.messager.alert('温馨提示', result.message,'error');
	    	  }
	      },"json");
	    }
	  }, 10)
	}; 
   
   
   
})


</script>
</head>
<body>
<!-- 1 datagrid -->
	 
	<!-- 1 datagrid -->
	 <table id="permissionDataGrid" title="权限列表" class="easyui-datagrid" 
	            fit="true"
	            url="/permission/list"
	            toolbar="#permissionDataGridToolbar" pagination="true"
	            rownumbers="true" fitColumns="true" singleSelect="true">
	        <thead>
	            <tr>
	                <!-- 显示数据：更加th的field对应显示 -->
	                <th field="id" hidden=true width="50">id</th>
	                <th field="name" width="50">权限名称</th>
	                <th field="sn" width="50">权限编号</th>
	                <th field="resource" width="50">路径</th>
	                <th field="state" width="50" formatter="stateFormatter" >状态</th>
	                
	            </tr>
	        </thead>
    </table>
	<!-- 2 toolBar -->
    <div id="permissionDataGridToolbar">
        <a id="permissionAdd" data-cmd="permissionAdd" href="javascript:void(0)" class="easyui-linkbutton c1" iconCls="icon-add " plain="true" >新增</a>
        <a id="permissionEdit" data-cmd="permissionEdit"  href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-edit" plain="true" >修改</a>
        <a id="permissionDelete" data-cmd="permissionDelete" href="javascript:void(0)" class="easyui-linkbutton c5" iconCls="icon-remove" plain="true">删除</a>
        <a id="permissionRefresh" data-cmd="permissionRefresh" href="javascript:void(0)" class="easyui-linkbutton c7" iconCls="icon-reload" plain="true">刷新</a>
        <!-- <a id="permissionADDS" data-cmd="permissionADDS" href="javascript:void(0)" class="easyui-linkbutton c8" iconCls="icon-add" plain="true">注解新增</a>
         -->
        <div>
        	<form id="permSearchForm" action="">
				<!-- 关键字，状态 -->
   	    	关键字：<input id="q" type="text" name="q"> 
   	    	状态：<select name="state" id="state">
   	    	     <option value="-2">--请选择--</option>
   	    	     <option value="0">正常</option>
   	    	     <option value="-1">禁用</option>
   	    	   </select>
				<a href="javascript:void(0)" data-cmd="permissionSearch"
					class="easyui-linkbutton c3" iconCls="icon-search" plain="true">查询</a>
				<a href="javascript:void(0)" data-cmd="permissionQueryBy"
					class="easyui-linkbutton c1" iconCls="icon-search" plain="true">高级查询</a>
					<a href="#" class="easyui-linkbutton color-blue border-radius c7"
					 iconCls="icon-reload" data-cmd="loadPermissionResource">加载注解权限</a>
			</form>
        
        </div>
        
        
    </div>
    
    <!-- 加载资源对话框 -->
	<div id="loadPermissionResourceDlg" class="easyui-dialog" style="width: 400px"
		closed="true">
		<!-- 进度条 -->
		<div id="p" class="easyui-progressbar progressbar-auto-color progressbar-animation c7" data-options="value:15" data-percent="15"></div>
	</div>
    
    
    
    <!-- 3 添加或编辑对话框  模态框！ -->
    <div id="permissionDialog"  class="easyui-dialog" style="width:400px"
            closed="true" buttons="#permissionDialogButtons">
        <form id="permissionDialogForm" method="post" novalidate style="margin:0;padding:20px 50px">
			<!--由于添加和编辑对话框是通过一个Form，以隐藏域的方式区分是添加还是修改 -->
			<input type="hidden" name="id">
			<table>
			   <tr>
        	    <td>权限名称:</td><td> 
        	    <input name="name" class="easyui-textbox" data-options="iconCls:'icon-sum'" style="width:150px"> 
        	    
        	    <!-- <input name="name" type="text"/></td> -->
        	  </tr>
        	  <tr>
        	  	<td>权限编号:</td><td>
        	  	<input name="sn" class="easyui-textbox" data-options="iconCls:'icon-filter'" style="width:150px"> 
        	  	</td>
        	    
        	    <!-- <td>权限编号:</td><td> <input name="sn" type="text"/></td> -->
        	  </tr>
        	  <tr>
        	    <td>路径:</td><td> 
        	  	<input name="resource" class="easyui-textbox"  style="width:150px"> 
        	  	</td>
        	  </tr>
        	  <tr>
        	  <td>状态:</td>
        	    <td>
        	             
        	             <!-- <input id="ccc" class="easyui-combobox" name="state"   
                             data-options="valueField:'id',textField:'state',url:'/permission/queryAll'" 
                             style="width:150px"/> --> 
                             
                             <select id="cc" class="easyui-combobox" name="state" style="width:200px;">   
							    <option value="0">正常</option>   
							    <option value="-1">禁用</option>   
							 </select> 
        	     </td>
        	  </tr>
<!--         	  <tr>
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
        <a id="permissionSave" data-cmd="permissionSave" href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">保存</a>
        <a id="permissionCancel" data-cmd="permissionCancel" href="javascript:void(0)" class="easyui-linkbutton c5" iconCls="icon-cancel" style="width:90px">取消</a>
    </div>
    
    
    
    
    
    
    
    <!--  
   		 高级查询的  模态框！
   		 
   		 
     -->
    <div id="permissionQueryDialog"  class="easyui-dialog" style="width:400px"
            closed="true" buttons="#permissionSearchDialogButtons">
        <form id="permissionQueryDialogForm" method="post" novalidate style="margin:0;padding:20px 50px">
			<!--由于添加和编辑对话框是通过一个Form，以隐藏域的方式区分是添加还是修改 -->
			<input type="hidden" name="id">
			<table>
			<tr>
					<td>关键字:</td>
					<td><input name="q" class="easyui-textbox"></td>
				</tr>
				<tr>
					<td>状态:</td>
					<td><select id="state" name="state">
							<option value="0">正常</option>
							<option value="-1" selected="selected">停用</option>
					</select></td>
				</tr>
<!-- 			   <tr>
        	    <td>权限名称:</td><td> <input id="q" type="text" name="q"/></td>
        	  </tr>
        	  <tr>
        	    <td>权限编号:</td><td> <input name="q" type="text"/></td>
        	  </tr>
        	  <tr>
        	    <td>路径:</td><td> <input id="resource" name="resource" type="text"/></td>
        	  </tr>
        	  <tr>
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
    <div id="permissionSearchDialogButtons">
        <a id="permissionQuerySave" data-cmd="permissionQuerySave" href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">保存</a>
        <a id="permissionQueryCancel" data-cmd="permissionQueryCancel" href="javascript:void(0)" class="easyui-linkbutton c5" iconCls="icon-cancel" style="width:90px">取消</a>
    </div>
	
</body>
</html>