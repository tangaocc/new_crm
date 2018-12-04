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
	   var personalTaskDataGrid,personalTaskDialog,viewProcessDiagramDialog,personalTaskDialogForm;
	   // 2、把页面的组件，缓存到上面声明的变量中
	   personalTaskDataGrid=$("#personalTaskDataGrid");
	   personalTaskDialog=$("#personalTaskDialog");
	   viewProcessDiagramDialog=$("#viewProcessDiagramDialog");
	   personalTaskDialogForm=$("#personalTaskDialogForm");
	   // 3、初始化组件，修改组件的值
	   // 4、创建一个"命令对象"，把当前模块所有的功能，都打包到这个对象上
	   var cmdObj = {
			"personalTaskAdd":function(){
			  //清除表单
			  personalTaskDialogForm.form("clear");
			  personalTaskDialog.dialog("setTitle","部署新流程").dialog("center").dialog("open");
			},
			"personalTaskRefresh":function(){
			  personalTaskDataGrid.datagrid("reload");
			},
			"personalTaskCancel":function(){
				personalTaskDialog.dialog("close");
			},
			"viewProcessDiagramCancel":function(){
				viewProcessDiagramDialog.dialog("close");
			},
			"personalTaskEdit":function(){
				  var row = personalTaskDataGrid.datagrid('getSelected');
				  if (!row) {
				   $.messager.alert('温馨提示','请选中要删除行!','error');
				   return;//如果没有数据做了提示信息就应该返回
				  }
				  
				  //动态拼接src并且设置图片src
				  var taskId = row.id;
				 // var diagramResourceName = row.diagramResourceName;
				  var src ="/workFlow/viewCurrentImage?taskId="+taskId;
				  		$("#imgTask").attr("src",src);
				  		 //访问后台获取需要标识红框的坐标
				  		 src="/workFlow/coordXY?taskId="+taskId; 

				  $.get(src,function(currentActivityCoordinates){//获取坐标
						 //绘制小红框
						$("#divImgId").css({border:"1px solid red",position:"absolute",height:currentActivityCoordinates.Height+"px",width:currentActivityCoordinates.Width+"px",left:currentActivityCoordinates.X+"px",top:currentActivityCoordinates.Y+"px"});
						  //打开新增或编辑对话框
						  viewProcessDiagramDialog.dialog("setTitle","查看流图").dialog("center").dialog("open");
						
						 
					 });
				
				 /* function viewProcessByTask(taskID){
					 var src="/workflow/viewProcessByTaskID?taskId="+taskID;
					 $("#imgTask").attr("src",src);//设置src标签的属性,显示图片
					 
					 //访问后台获取需要标识红框的坐标
					 src="/workflow/coordXY?taskId="+taskID; 
					 $.get(src,function(data){//获取坐标
						 //绘制小红框
						$("#divImgId").css({border:"1px solid red",position:"absolute",height:data.Height+"px",width:data.Width+"px",left:data.X+"px",top:data.Y+"px"});
						
						 $("#viewTaskImg").dialog("open");//打开模态框
					 });
				} */
			},
			"personalTaskComplete":function(){
				 var row = personalTaskDataGrid.datagrid('getSelected');
				  if (!row) {
				   $.messager.alert('温馨提示','请选中要办理的任务!','error');
				   return;//如果没有数据做了提示信息就应该返回
				  }
				//发送Ajax请求，传递taskId完成任务办理，响应AjaxResult返回结果，做提示
				var url ="/workFlow/completeTask?taskId="+row.id+"&flag=true";
				$.get(url,function(data){
					if (data.success) {
					     //提示
						 $.messager.alert('温馨提示','办理成功','info');
					     //关闭对话框
						 $("#personalTaskDialog").dialog("close");
					     //刷新表格
						 personalTaskDataGrid.datagrid('reload');
					}else{
						  //提示
						 $.messager.alert('温馨提示',data.message,'error');
					     //关闭对话框
						 personalTaskDialog.dialog("close");
					}
				  },"json");
			},
			"personalTaskCompleteFalse":function(){
				 var row = personalTaskDataGrid.datagrid('getSelected');
				  if (!row) {
				   $.messager.alert('温馨提示','请选中要办理的任务!','error');
				   return;//如果没有数据做了提示信息就应该返回
				  }
				//发送Ajax请求，传递taskId完成任务办理，响应AjaxResult返回结果，做提示
				var url ="/workFlow/completeTask?taskId="+row.id+"&flag=false";
				$.get(url,function(data){
					if (data.success) {
					     //提示
						 $.messager.alert('温馨提示','办理成功','info');
					     //关闭对话框
						 $("#personalTaskDialog").dialog("close");
					     //刷新表格
						 personalTaskDataGrid.datagrid('reload');
					}else{
						  //提示
						 $.messager.alert('温馨提示',data.message,'error');
					     //关闭对话框
						 personalTaskDialog.dialog("close");
					}
				  },"json");
			},
			/* 
			"personalTaskComplete":function(){
				var row = personalTaskDataGrid.datagrid('getSelected');
				   if (!row) {
					   $.messager.alert('温馨提示','请选中要办理的任务行!','error');
					   return;//如果没有数据做了提示信息就应该返回
					}	
				 //发送Ajax请求，传递taskId完成任务办理，响应AjaxResult返回结果，做提示
				var url ="/workFlow/completeTask?taskId="+row.id;
				 $.get(url,function(data){
					 if (data.success) {
					     //提示
						 $.messager.alert('温馨提示','办理成功','info');
					     //关闭对话框
						 $("#personalTaskDialog").dialog("close");
					     //刷新表格
						 personalTaskDataGrid.datagrid('reload');
					}else{
						  //提示
						 $.messager.alert('温馨提示',data.message,'error');
					     //关闭对话框
						 $("#personalTaskDialog").dialog("close");
					}
				 },"json");
			},
			*/
			"personalTaskDelete":function(){
				   
				   var row = personalTaskDataGrid.datagrid('getSelected');
				   if (!row) {
					   $.messager.alert('温馨提示','请选中要删除行!','error');
					   return;//如果没有数据做了提示信息就应该返回
					}
			    if (row){
			        $.messager.confirm('温馨提示','您确定要删除该行数据吗?',function(r){
			            if (r){
			                $.post('/workFlow/personalTask/delete',{deploymentId:row.deploymentId},function(result){
			             	   //期望返回成功与否，如果有错需要返回错误提示信息 {"success":true,"message":"xxxx"}
			             	   //可以封装一个类AjaxResult，里面有两个属性
			                    if (result.success){
			                 	   //给个提示信息
			                 	   $.messager.alert('温馨提示','删除成功','info');
			                 	    //刷新界面
			                        personalTaskDataGrid.datagrid('reload');
			                    } else {
			                 	   $.messager.alert('温馨提示',result.message,'error');
			                    }
			                },'json');
			            }
			        });
			    }
			},
			
			"personalTaskSearch":function(){
				//方案3：扩展jquer原型方法
				var paramObj =$("#deptSearchForm").serializeForm();
				personalTaskDataGrid.datagrid('load',paramObj)
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
	
	
	
	
	
	//打开任务详情对话框
	function openTaskDetailDialog(formKey,businessObjType,businessObjId){
		//加载动态表单
		
	/* 	$("#personalTaskDialog").dialog({
			buttons:[{
				text:'办理事务',
				handler:function(){
					//动态生成任务完成按钮
					$.get("/workFlow/completeTask",{taskId:taskId},function(data){
						if (data.success) {
							$.messager.alert("温馨提示",data.messager,"info",function(){
								$("#personalTaskDataGrid").datagrid("load");
							})
						}
					})
				
				}
			},{
				text:'关闭',
				handler:function(){
					$("#personalTaskDialog").dialog("close");
				}
			}]
			
			
		}) */
		//1)通过formKey加载表单结构
		//$('#personalTaskDialog').dialog('refresh',formKey);
		//问题2:404错误 webinf不能直接访问
		//var url = "/workFlow/loadForm?formKey="+formKey;
		//$('#personalTaskDialog').dialog('refresh',url);
		//问题1：发了两次请求 不要使用refresh直接修改href属性
		var url = "/workFlow/loadForm?formKey="+formKey;
		$('#personalTaskDialog').dialog({
			"href":url,
			//form加载完毕后，再获取数据
			"onLoad":function(){
				var url = "/"+businessObjType+"/loadFormData?id="+businessObjId;//首字母小写
				//2)通过businessObjType和businessObjId获取表单数据
				$.get(url,function(data){
					//获取form表单
					var taskForm = $("#personalTaskDialog").find("#personalTaskDialogForm");
					//融合
					taskForm.form("load",data);
					
					
					
					
					
					
				  },"json");
				//3)把它们融合在一起形成完整表单
			}
		});
		$("#personalTaskDialog").dialog("setTitle","查看任务详情").dialog("center").dialog("open");
	}
	
	
	
	
	
	function oprFormatter(v,r,i){
		
		//优秀实践，写一个拷两个
 		return "<a href='javascript:openTaskDetailDialog(\""+r.formKey+"\",\""+r.businessObjType+"\",\""+r.businessObjId+"\")'>办理</a>   | <a href='#'>查看流程图</a>"
	}
	
	
	function personalTaskStateFormatter(v,r,i){
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
	 <table id="personalTaskDataGrid" class="easyui-datagrid" title="待办任务管理"
	            fit="true"
	            url="/workFlow/personalTask/list"
	            toolbar="#personalTaskDataGridToolbar" pagination="true"
	            rownumbers="true" fitColumns="true" singleSelect="true">
	        <thead>
	            <tr>
	            	<th field="id" width="50">编号</th>
	                <th field="name" width="50">名称</th>
	                <th field="assignee" width="50">办理者</th>
	                <th field="createTime" width="60">创建时间</th>
	                <!-- <th field="diagramResourceName" width="50" >流程图文件名</th> -->
	                <th field="description" width="80">描述</th>
	                <th field="opr" width="80" formatter="oprFormatter">操作</th>
	            </tr>
	        </thead>
    </table>
	<!-- 2 toolBar -->
       <div id="personalTaskDataGridToolbar">
       	<a data-cmd="personalTaskOpen" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-man" plain="true">办理</a>
        <a data-cmd="personalTaskEdit"   href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" >查询任务流程图</a>
        
       
        <a data-cmd="personalTaskRefresh" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" plain="true">刷新</a>
    </div>
    
    <!-- 3 任务详情对话框 -->
    <div id="personalTaskDialog" class="easyui-dialog" style="width:350px;height: 250px"
            closed="true" buttons="#personalTaskDialogButtons">
          <!-- 动态加载表单 -->
    </div>
    
    <!-- 4 添加或编辑对话框buttons -->
    <div id="personalTaskDialogButtons">
        <a data-cmd="personalTaskComplete" href="javascript:void(0)" data-options="flag:true" class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">完成任务</a>
        <a data-cmd="personalTaskCompleteFalse"   href="javascript:void(0)" data-options="flag:false"  class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">驳回任务</a>
        
        <a data-cmd="personalTaskCancel" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" style="width:90px">关闭</a>
    </div>
    
    
    
    
    
    <!-- 5 查看流程图对话框 -->
     <div id="viewProcessDiagramDialog" class="easyui-dialog" style="width:400px;height: 500px"
            closed="true" buttons="#viewProcessDiagramDialogButtons">
		<!--1)弹出"显示规则流程图"对话框,里面图片src写死 -->
		<!--<img src="/MyProcess.png"> -->
		<!--2)使用Controller来进行响应 -->
		<!--<img src="/workFlow/viewProcessDiagram?deploymentId=1&diagramResourceName=MyProcess.png">-->
		<!--3)使用js动态设置src-->
		<img style="position: absolute;top:0px;left: 0px;" id="imgTask" src="">
		<!-- 2.根据当前活动的坐标，动态绘制DIV -->
		<!-- <div style="position: absolute;
							border:1px solid red;
							top:100px;
							left:11px;
							width:189px;
							height:101px;"></div> -->
							
		<div id="divImgId" ></div>
    </div>
    
    <div id="viewProcessDiagramDialogButtons">
        <a data-cmd="viewProcessDiagramCancel" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" style="width:90px">关闭</a>
    </div>
    
</body>
</html>