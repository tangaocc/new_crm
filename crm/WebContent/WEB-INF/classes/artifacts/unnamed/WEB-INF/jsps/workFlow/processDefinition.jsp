<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>流程规则管理</title>
<!-- 导入公共jsp，就拥有了公共配置：easyui,js,css -->
<%@include file="/WEB-INF/jsps/common.jsp" %>
<script type="text/javascript">
	//页面加载完毕后
	$(function(){
	   // 1、声明出页面需要使用的组件
	   var processDefinitionDataGrid,processDefinitionDialog,viewProcessDiagramDialog,processDefinitionDialogForm;
	   // 2、把页面的组件，缓存到上面声明的变量中
	   processDefinitionDataGrid=$("#processDefinitionDataGrid");
	   processDefinitionDialog=$("#processDefinitionDialog");
	   viewProcessDiagramDialog=$("#viewProcessDiagramDialog");
	   processDefinitionDialogForm=$("#processDefinitionDialogForm");
	   // 3、初始化组件，修改组件的值
	   // 4、创建一个"命令对象"，把当前模块所有的功能，都打包到这个对象上
	   var cmdObj = {
			"processDefinitionAdd":function(){
			  //清除表单
			  processDefinitionDialogForm.form("clear");
			  processDefinitionDialog.dialog("setTitle","部署新流程").dialog("center").dialog("open");
			},
			"processDefinitionRefresh":function(){
			  processDefinitionDataGrid.datagrid("reload");
			},
			"processDefinitionCancel":function(){
				processDefinitionDialog.dialog("close");
			},
			"viewProcessDiagramCancel":function(){
				viewProcessDiagramDialog.dialog("close");
			},
			"processDefinitionEdit":function(){
				  var row = processDefinitionDataGrid.datagrid('getSelected');
				  if (!row) {
				   $.messager.alert('温馨提示','请选中要删除行!','error');
				   return;//如果没有数据做了提示信息就应该返回
				  }
				  
				  //动态拼接src并且设置图片src
				  var deploymentId = row.deploymentId;
				  var diagramResourceName = row.diagramResourceName;
				  var src ="/workFlow/viewProcessDiagram?deploymentId="+deploymentId+"&diagramResourceName="+diagramResourceName;
				  $("#img").attr("src",src)
				  //打开新增或编辑对话框
				  viewProcessDiagramDialog.dialog("setTitle","查看流图").dialog("center").dialog("open");
			},
			"processDefinitionSave":function(){
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
				         	   $.messager.alert('温馨提示','部署成功','info');
				         	    //刷新界面
				                processDefinitionDataGrid.datagrid('reload');
				            } else {
				         	   $.messager.alert('温馨提示',result.message,'error');
				            }
				        }
				    });
				},
				"processDefinitionDelete":function(){
					   
					   var row = processDefinitionDataGrid.datagrid('getSelected');
					   if (!row) {
						   $.messager.alert('温馨提示','请选中要删除行!','error');
						   return;//如果没有数据做了提示信息就应该返回
						}
				    if (row){
				        $.messager.confirm('温馨提示','您确定要删除该行数据吗?',function(r){
				            if (r){
				                $.post('/workFlow/processDefinition/delete',{deploymentId:row.deploymentId},function(result){
				             	   //期望返回成功与否，如果有错需要返回错误提示信息 {"success":true,"message":"xxxx"}
				             	   //可以封装一个类AjaxResult，里面有两个属性
				                    if (result.success){
				                 	   //给个提示信息
				                 	   $.messager.alert('温馨提示','删除成功','info');
				                 	    //刷新界面
				                        processDefinitionDataGrid.datagrid('reload');
				                    } else {
				                 	   $.messager.alert('温馨提示',result.message,'error');
				                    }
				                },'json');
				            }
				        });
				    }
				},
				"suspendProcessDefinition":function(){
					   
					   var row = processDefinitionDataGrid.datagrid('getSelected');
					   if (!row) {
						   $.messager.alert('温馨提示','请选中要挂起行!','error');
						   return;//如果没有数据做了提示信息就应该返回
						}
				    if (row){
				        $.messager.confirm('温馨提示','您确定要挂起该行数据吗?',function(r){
				            if (r){
				                $.post('/workFlow/processDefinition/suspend',{processDefinitionKey:row.key,pstate:row.pstate},function(result){
				             	   //期望返回成功与否，如果有错需要返回错误提示信息 {"success":true,"message":"xxxx"}
				             	   //可以封装一个类AjaxResult，里面有两个属性
				                    if (result.success){
				                 	   //给个提示信息
				                 	   $.messager.alert('温馨提示','挂起成功','info');
				                 	   row.pstate = -1;
				                 	   var pstate = row.pstate;
				                 	    //刷新界面
				                        processDefinitionDataGrid.datagrid('reload',{
				                        	pstate: -1
				                        });
				                    } else {
				                 	   $.messager.alert('温馨提示',result.message,'error');
				                    }
				                },'json');
				            }
				        });
				    }
				},
				"activateProcessDefinition":function(){
					   
					   var row = processDefinitionDataGrid.datagrid('getSelected');
					   if (!row) {
						   $.messager.alert('温馨提示','请选中要删除行!','error');
						   return;//如果没有数据做了提示信息就应该返回
						}
				    if (row){
				        $.messager.confirm('温馨提示','您确定要删除该行数据吗?',function(r){
				            if (r){
				                $.post('/workFlow/processDefinition/activate',{processDefinitionKey:row.key,pstate:row.pstate},function(result){
				             	   //期望返回成功与否，如果有错需要返回错误提示信息 {"success":true,"message":"xxxx"}
				             	   //可以封装一个类AjaxResult，里面有两个属性
				                    if (result.success){
				                 	   //给个提示信息
				                 	   $.messager.alert('温馨提示','激活成功','info');
				                 	  row.pstate = 0;
				                 	 
				                 	   var pstate = row.pstate;
				                 	    //刷新界面
				                        processDefinitionDataGrid.datagrid('reload',{
				                        	pstate: 0
				                        });
				                    } else {
				                 	   $.messager.alert('温馨提示',result.message,'error');
				                    }
				                },'json');
				            }
				        });
				    }
				},
				"processDefinitionSearch":function(){
					//方案3：扩展jquer原型方法
					var paramObj =$("#deptSearchForm").serializeForm();
					processDefinitionDataGrid.datagrid('load',paramObj)
				}
	   }
	   // 5、对页面所有按钮，统一监听
	   $("a[data-cmd]").click(function(){
		   //5.1 获取cmd以便于区分是哪个超链接
		   var cmd = $(this).data("cmd");//add
		   //方案2：动态调用
		   //判断定义了cmd，并且没有被禁用
		   if (cmd && !$(this).hasClass("l-btn-disabled")) 
		   {
		  	 cmdObj[cmd]();
		   }
	   });
	})
	
	function employeeState(v,r,i){
		if (v && v==-1) {
			return "<font style='color:red'>离职</font>"
		}
		
		return "<font style='color:green'>在职</font>"
	}
	
	
	
	
	function processDefinitionStateFormatter(v,r,i){
		//v:就是字段值：0  1
		if(v==-1){
			return "<font color='blue'>挂起</font>";
		}else if(v==0){
			return "<font color='green'>正常</font>";
		}
	}	
</script>
</head>
<body>
	<!-- 1 datagrid -->
	 <table id="processDefinitionDataGrid" class="easyui-datagrid" 
	            fit="true"
	            url="/workFlow/processDefinition/list"
	            toolbar="#processDefinitionDataGridToolbar" pagination="true"
	            rownumbers="true" fitColumns="true" singleSelect="true">
	        <thead>
	            <tr>
	                <th field="id" width="50">编号</th>
	                <th field="name" width="50">名称</th>
	                <th field="key" width="50">键</th>
	                <th field="version" width="20">版本</th>
	                <th field="deploymentId" width="20">部署Id</th>
	                <th field="resourceName" width="50">流程定义文件名</th>
	                <th field="diagramResourceName" width="50" >流程图文件名</th>
	                <th field="description" width="60">描述</th>
	                <th field="pstate" width="20" formatter="processDefinitionStateFormatter">状态</th>
	            </tr>
	        </thead>
    </table>
	<!-- 2 toolBar -->
    <div id="processDefinitionDataGridToolbar">
        <a data-cmd="processDefinitionAdd" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" >部署新流程</a>
       	<a data-cmd="processDefinitionDelete" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
        <a data-cmd="suspendProcessDefinition" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-no" plain="true">挂起</a>
        <a data-cmd="activateProcessDefinition" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" plain="true">激活</a>
        <a data-cmd="processDefinitionEdit" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" >查询流程图</a>
        <a data-cmd="processDefinitionRefresh" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" plain="true">刷新</a>
    </div>
    
    <!-- 3 添加或编辑对话框 -->
    <div id="processDefinitionDialog" class="easyui-dialog" style="width:350px"
            closed="true" buttons="#processDefinitionDialogButtons">
        <form id="processDefinitionDialogForm" method="post" enctype="multipart/form-data" novalidate>
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
    <!-- 4 添加或编辑对话框buttons -->
    <div id="processDefinitionDialogButtons">
        <a data-cmd="processDefinitionSave" href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">保存</a>
        <a data-cmd="processDefinitionCancel" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" style="width:90px">取消</a>
    </div>
    
    <!-- 5 查看流程图对话框 -->
     <div id="viewProcessDiagramDialog" class="easyui-dialog" style="width:400px;height: 500px"
            closed="true" buttons="#viewProcessDiagramDialogButtons">
		<!--1)弹出"显示规则流程图"对话框,里面图片src写死 -->
		<!--<img src="/MyProcess.png"> -->
		<!--2)使用Controller来进行响应 -->
		<!--<img src="/workFlow/viewProcessDiagram?deploymentId=1&diagramResourceName=MyProcess.png">-->
		<!--3)使用js动态设置src-->
		<img id="img" src="">
    </div>
    
    <div id="viewProcessDiagramDialogButtons">
        <a data-cmd="viewProcessDiagramCancel" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" style="width:90px">关闭</a>
    </div>
    
</body>
</html>