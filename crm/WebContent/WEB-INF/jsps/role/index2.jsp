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
   var roleDataGrid,roleDialog,roleDialogForm,allPermsDatagrid,selectedPermsDatagrid;
   // 2、把页面的组件，缓存到上面声明的变量中
    roleDataGrid=$("#roleDataGrid");
    roleDialog=$("#roleDialog");
    roleDialogForm=$("#roleDialogForm");
	$allPermsDatagrid = $("#allPermsDatagrid");
	$selectedPermsDatagrid = $("#selectedPermsDatagrid");
   // 3、初始化组件，修改组件的值
   
   // 4、创建一个"命令对象"，把当前模块所有的功能，都打包到这个对象上
   var cmdObj = {
		"roleAdd":function(){
		  //清除表单
		  roleDialogForm.form("clear");
		  roleDialog.dialog("setTitle","添加部门").dialog("center").dialog("open");
	      //打开dialog的时候：设置一个状态的默认值：defaultValue
	      //$("#defaultValue").attr("checked",true);
	      $("#defaultValue").prop("checked",true);
	      
	      //打开dialog的时候，需要去加载一下combotree，不然数据可能不能及时更新：js方创建
	  /*     $('#cc').combotree({    
	    	    url: "/role/loadDepartmentTree",    
	    	    required: true   
	    	});  */
		},
		"roleRefresh":function(){
		  roleDataGrid.datagrid("reload");
		},
		"roleCancel":function(){
			roleDialog.dialog("close");
		},
		"roleEdit":function(){
			  //必须选中一行
			   var row = roleDataGrid.datagrid('getSelected');
			   if (!row) {
				   $.messager.alert('温馨提示','请选中要修改行!','error');
				   return;//如果没有数据做了提示信息就应该返回
				}else{
					
				   //先清除
				   roleDialogForm.form("clear");
				   //回显
				  roleDialogForm.form("load",row);
				  //打开新增或编辑对话框
				  roleDialog.dialog("setTitle","编辑部门").dialog("center").dialog("open");
				   
				  $('#cc').combotree({    
			    	    url: "/role/loadDepartmentTree",    
			    	    required: true   
			    	}); 
				  //combotree的回显：部门的id,使用setValue
		         $('#cc').combotree('setValue', row.parent.id);
				
				  //combogrid的回显：经理的id,使用setValue
		         $('#combogrid').combogrid('setValue','');
				 $('#combogrid').combogrid('setValue', row.manager.id);
					
				   
				  
					
				} 
		   
			   
		},
		
		
		/* roleForm.form({
			url : "/role/save",
			onSubmit : function(param) {
				// 获取选中表格的所有行
				var rowDatas = selectedPermissionDatagrid.datagrid("getRows");
				console.debug(rowDatas);
				// 从表格中，取出每行数据,遍历取得ID
				for (var i = 0; i < rowDatas.length; i++) {
					var rowData = rowDatas[i];
					// 拼接成指定提交格式 =》permissions[0].id =1;
					param['permissions[' + i + '].id'] = rowData.id;
				}
		       return roleForm.form("validate");
			},
			success : function(data) {
				// 把响应结果转换成JSON对象
				data = $.parseJSON(data);
				if (data.success) {
					// 关闭对话框
					roleDialog.dialog("close");
					// 提示,刷新
					$.messager.alert("温馨提示", data.msg, "info", function() {
						// 刷新表格数据
						roleDatagrid.datagrid("reload");
					});
				} else {
					$.messager.alert('错误提示', data.msg, 'error');
				}
			}
		});
 */
		
		
		//保存按钮
		"roleSave":function(){
					roleDialogForm.form('submit',{
			        url: "/role/save",
			        onSubmit: function(){
			            return $(this).form('validate');
			        },
			        success: function(result){
			     	   //提交的返回值是Json字符串，不是Json对象，需要自己转换eval $.parseJSON JSON.parse
			            var result = $.parseJSON(result);
			            if (result.success){
			         	   //关闭对话框
			         	   roleDialog.dialog("close");
			         	   //给个提示信息
			         	   $.messager.alert('温馨提示','保存成功','info');
			         	    //刷新界面
			                roleDataGrid.datagrid('reload');
			            } else {
			         	   $.messager.alert('温馨提示',result.message,'error');
			            }
			        }
			    });
			},
			"roleDelete":function(){
				   
				   var row = roleDataGrid.datagrid('getSelected');
				   if (!row) {
					   $.messager.alert('温馨提示','请选中要删除行!','error');
					   return;//如果没有数据做了提示信息就应该返回
					}
			    if (row){
			        $.messager.confirm('温馨提示','您确定要删除该行数据吗?',function(r){
			            if (r){
			                $.post('/role/delete',{id:row.id},function(result){
			             	   //期望返回成功与否，如果有错需要返回错误提示信息 {"success":true,"message":"xxxx"}
			             	   //可以封装一个类AjaxResult，里面有两个属性
			                    if (result.success){
			                 	   //给个提示信息
			                 	   $.messager.alert('温馨提示','删除成功','info');
			                 	    //刷新界面
			                        roleDataGrid.datagrid('reload');
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
   
   
   
 //已选权限
	$selectedPermsDatagrid.datagrid({    
		title:"已选权限", 
		width : 400,
		height : 300,
		border:"false", 
		fitColumns:"true",
		singleSelect:"true",
		rownumbers:"true",
		onDblClickRow:function(index,row){
			//给已选权限的datagrid注册一个双击事件：双击就删除这行数据：
			$selectedPermsDatagrid.datagrid("deleteRow",index);
		},
	    columns:[[    
	    	{field:'sn',title:'权限编号',width:10},    
	        {field:'name',title:'权限名称',width:10},    
	        {field:'resource',title:'资源地址',width:10},    
	        {field:'state',title:'状态',width:10}      
	    ]]    
	});
	//所有权限
	$allPermsDatagrid.datagrid({    
	    url:"/permission/list",
		title:"所有权限",
		width : 400,
		height : 300,
		border:"false", 
		fitColumns:"true",
		singleSelect:"true",
		pagination:"true",
		rownumbers:"true",
		onDblClickRow:function(index,row){
			//index:是这个datagrid的索引，row：点击的行记录
			//把这行直接追加到已选权限：做一个判断：已经添加了的权限，不能重复添加：
			//获取已经添加的所有的权限和当前点击的权限，遍历已经添加的权限，判断id是否存在：
			var getRows = $selectedPermsDatagrid.datagrid("getRows");
	        //getRows是数组：
	        for (var i = 0; i < getRows.length; i++) {
	        	//获取当前遍历的id
	        	var curId = getRows[i].id;
	        	if(curId==row.id){
	        		//如果当前遍历行的id和选中行的id一样，就表示已经存在了数据，直接弹出提示，并返回
	        		$.messager.alert('错误提示', "不能重复添加!!!", 'info');
	        		return ;
	        	}
			}
	        //把选中行追加到已选权限的datagrid上
	        $selectedPermsDatagrid.datagrid("appendRow",row);
		},
	    columns:[[    
	        {field:'sn',title:'权限编号',width:10},    
	        {field:'name',title:'权限名称',width:10},    
	        {field:'resource',title:'资源地址',width:10},    
	        {field:'state',title:'状态',width:10}    
	    ]]    
	});
   
   
})






</script>
</head>
<body>
<!-- 1 datagrid -->
	 
	<!-- 1 datagrid -->
	 <table id="roleDataGrid" title="权限列表" class="easyui-datagrid" 
	            fit="true"
	            url="/role/list"
	            toolbar="#roleDataGridToolbar" pagination="true"
	            rownumbers="true" fitColumns="true" singleSelect="true">
	        <thead>
	            <tr>
	                <!-- 显示数据：更加th的field对应显示 -->
	                <th field="id" hidden=true width="50">id</th>
	                <th field="name" width="50">角色名称</th>
	                <th field="sn" width="50">角色编号</th>
	                <th field="resource" width="50">路径</th>
	                <th field="permissions" formatter=arrayFormatter width="50">拥有权限</th>
	                
	                
	                
	            </tr>
	        </thead>
    </table>
	<!-- 2 toolBar -->
    <div id="roleDataGridToolbar">
        <a id="roleAdd" data-cmd="roleAdd" href="javascript:void(0)" class="easyui-linkbutton c1" iconCls="icon-add " plain="true" >新增</a>
        <a id="roleEdit" data-cmd="roleEdit"  href="javascript:void(0)" class="easyui-linkbutton c3" iconCls="icon-edit" plain="true" >修改</a>
        <a id="roleDelete" data-cmd="roleDelete" href="javascript:void(0)" class="easyui-linkbutton c5" iconCls="icon-remove" plain="true">删除</a>
        <a id="roleRefresh" data-cmd="roleRefresh" href="javascript:void(0)" class="easyui-linkbutton c7" iconCls="icon-reload" plain="true">刷新</a>
    </div>
    
    <!-- 3 添加或编辑对话框  模态框！ -->
    <div id="roleDialog"  class="easyui-dialog" style="width:400px"
            closed="true" buttons="#roleDialogButtons">
        <form id="roleDialogForm" method="post" novalidate style="margin:0;padding:20px 50px">
			<!--由于添加和编辑对话框是通过一个Form，以隐藏域的方式区分是添加还是修改 -->
			<input type="hidden" name="id">
			<table>
			   <tr>
        	    <td>角色名称:</td><td> <input name="name" type="text"/></td>
        	  </tr>
        	  <tr>
        	    <td>角色编号:</td><td> <input name="sn" type="text"/></td>
        	  </tr>
        	  <tr>
        	    <td>路径:</td><td> <input name="resource" type="text"/></td>
        	  </tr>
        	  <tr>
        	    <td>状态:</td>
        	    <td>
        	             <input id="defaultValue" name="state" type="radio" value="0"/>正常
        	             <input name="state" type="radio" value="-1"/> 停用
        	     </td>
        	  </tr>
        	  
        	  <tr>
				  <td>
				   <table id="selectedPermsDatagrid" ></table>
				  </td>
			      <td> <table id="allPermsDatagrid" ></table></td>
			</tr>
        	 
			</table>

        </form>
    </div>
    <!-- 4 添加或编辑对话框buttons -->
    <div id="roleDialogButtons">
        <a id="roleSave" data-cmd="roleSave" href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">保存</a>
        <a id="roleCancel" data-cmd="roleCancel" href="javascript:void(0)" class="easyui-linkbutton c5" iconCls="icon-cancel" style="width:90px">取消</a>
    </div>
	
</body>
</html>