<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/WEB-INF/jsps/common.jsp"%>
<script type="text/javascript">
	//页面加载完毕后
	$(function() {
		// 1、声明出页面需要使用的组件
		var departmentDataGrid, departmentDialog, departmentDialogForm;
		// 2、把页面的组件，缓存到上面声明的变量中
		departmentDataGrid = $("#departmentDataGrid");
		departmentDialog = $("#departmentDialog");
		departmentDialogForm = $("#departmentDialogForm");
		searchDialogForm=$("#searchDialogForm");
		searchDialog=$("#searchDialog");
		// 3、初始化组件，修改组件的值!!
		//1）通过combogrid获取grid combogrid=combo+grid
	   var grid = $("#cg").combogrid("grid");
	   //2)通过grid获取Pagination grid=list+Pagination
	   var pager = grid.datagrid("getPager");
			   //初始化Pagination的值  这是再easyui绿皮书中的demo
	   pager.pagination(
		{ 
		   'showPageList':false, 
		   'showRefresh':false,
		   'displayMsg':'',
		   'loading':true,
		   
		}); 
		
		// 4、创建一个"命令对象"，把当前模块所有的功能，都打包到这个对象上
		var cmdObj = {
			"openDeptAdvanceDialog":function(){
				//清除表单
				searchDialogForm.form("clear");
				searchDialog.dialog("setTitle", "高级查询").dialog("center")
						.dialog("open");
				//打开dialog的时候：设置一个状态的默认值：defaultValue
				//$("#defaultValue").attr("checked",true);
				$("#defaultValue").prop("checked", true);
			},

			"departmentSearch":function() {
				var paramObj = $("#deptSearchForm").serializeForm();
				console.debug(paramObj)
				departmentDataGrid.datagrid('load',paramObj);
				
				
				
			},

			"departmentAdd" : function() {
				//清除表单
				departmentDialogForm.form("clear");
				departmentDialog.dialog("setTitle", "添加部门").dialog("center")
						.dialog("open");
				//打开dialog的时候：设置一个状态的默认值：defaultValue
				//$("#defaultValue").attr("checked",true);
		/* 		$("#defaultValue").prop("checked", true); */

				//打开dialog的时候，需要去加载一下combotree，不然数据可能不能及时更新：js方创建
				$('#cc').combotree({
					url : "/department/loadDepartmentTree",
					required : true
				});

			},
			"departmentEdit" : function() {
				//必须选中一行
				var row = departmentDataGrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('温馨提示', '请选中要修改行!', 'error');
					return;//如果没有数据做了提示信息就应该返回
				} else {

					//先清除
					departmentDialogForm.form("clear");
					//回显
					departmentDialogForm.form("load", row);
					
					//初始化-刷新部门树
			         $('#cc').combotree({    
					    url: '/department/loadDepartmentTree',    
					 });  
				   //上级部门回显
				   if (row.parent) {
				   	  $('#cc').combotree('setValue', row.parent.name);
				   }
				   //回显部门经理
				   if (row.manager) {
					  
				  	 $('#cg').combogrid('setValue', row.manager.id);
				    }
					
					//打开新增或编辑对话框
					departmentDialog.dialog("setTitle", "编辑部门")
							.dialog("center").dialog("open");

				}

			},
			"departmentSave" : function() {
				departmentDialogForm.form('submit', {
					url : "/department/save",
					onSubmit : function() {
						return $(this).form('validate');
					},
					success : function(result) {
						//提交的返回值是Json字符串，不是Json对象，需要自己转换eval $.parseJSON JSON.parse
						var result = $.parseJSON(result);
						if (result.success) {
							//关闭对话框
							departmentDialog.dialog("close");
							//给个提示信息
							$.messager.alert('温馨提示', '保存成功', 'info');
							//刷新界面
							departmentDataGrid.datagrid('reload');
						} else {
							$.messager.alert('温馨提示', result.message, 'error');
						}
					}
				});
			},
			"departmentDelete" : function() {

				var row = departmentDataGrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('温馨提示', '请选中要删除行!', 'error');
					return;//如果没有数据做了提示信息就应该返回
				}
				if (row) {
					$.messager.confirm('温馨提示', '您确定要删除该行数据吗?', function(r) {
						if (r) {
							$.post('/department/delete', {
								id : row.id
							}, function(result) {
								//期望返回成功与否，如果有错需要返回错误提示信息 {"success":true,"message":"xxxx"}
								//可以封装一个类AjaxResult，里面有两个属性
								if (result.success) {
									//给个提示信息
									$.messager.alert('温馨提示', '删除成功', 'info');
									//刷新界面
									departmentDataGrid.datagrid('reload');
								} else {
									$.messager.alert('温馨提示', result.message,
											'error');
								}
							}, 'json');
						}
					});
				}
			},
			"departmentRefresh" : function() {
				departmentDataGrid.datagrid("reload");
			},
			//导入excel
			"departmentImport":function(){				
				$("#downloadDlg").dialog("center").dialog("open");
			},
			//导出excel,下载不能用ajax.
			"departmentExport":function(){
				$("#downloaddp").dialog('center').dialog('open')
				.dialog('setTitle', '导出中,请稍后...');
				//开启进度条控制;
				start(true);
			},
			"departmentCancel" : function() {
				departmentDialog.dialog("close");
			},
			"searchSave":function(){
				var paramObj = $("#searchDialogForm").serializeForm();
				console.debug(paramObj)
				departmentDataGrid.datagrid('load',paramObj);
				searchDialog.dialog("close");
			},
			"searchCancel":function(){
				searchDialog.dialog("close");
			}
		}
		//加载资源进度条控制;
		function start(flag) {
			var i=0;
		  i = $('#p').progressbar('getValue') == 100 ? 0 : $('#p').progressbar('getValue');
		  var aa = setInterval(function() {
		    i++;
		    $('#p').progressbar('setValue', i);
		    $('#p').attr("data-percent", i);
		    if (i == 100) {
		      i = 0;
		      clearInterval(aa);
		      //发送请求.加载资源
		         $("#downloaddp").dialog('close');
		     	var param = $("#deptSearchForm").serializeForm();
				var q=param['q']
				var state=param['state']
		      location.href="/excel/deptExport?q="+q+"&state="+state;
		    	  //关闭对话框
		   
	    		
		      
		    }
		  }, 20)
		}; 
		
		// 5、对页面所有按钮，统一监听
		$("a[data-cmd]").click(function() {
			//5.1 获取cmd以便于区分是哪个超链接
			var cmd = $(this).data("cmd");//add
			if (cmd && !$(this).hasClass("l-btn-disabled")) {
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
</script>
</head>
<body>
	<!-- 1 datagrid -->
		<!-- 导入导出对话框进度条; -->
	<div id="downloaddp" class="easyui-dialog" style="overflow: hidden;"
		closed="true" >
		<!-- 进度条 -->
	<!-- 	<div id="p" class="easyui-progressbar progressbar-auto-color progressbar-animation" data-options="value:15" data-percent="15"></div> -->
		<!-- 进度条 -->
	<div id="p" class="easyui-progressbar" style="width:400px;"></div>
	</div>
	<!-- 1 datagrid -->
	<table id="departmentDataGrid"  class="easyui-datagrid"
		fit="true" url="/department/list" toolbar="#departmentDataGridToolbar"
		pagination="true" rownumbers="true" fitColumns="true"
		singleSelect="true">
		<thead>
			<tr>
				<!-- 显示数据：更加th的field对应显示 -->
				<th field="id" hidden=true width="50">id</th>
				<th field="name" width="50">部门名称</th>
				<th field="sn" width="50">部门编号</th>
				<th field="dirPath" width="50">路径</th>
				<th field="state" width="50" formatter="stateFormatter">部门状态</th>
				<th field="manager" width="50" formatter="objFormatter">部门经理</th>
				<th field="parent" width="50" formatter="objFormatter">上级部门</th>
			</tr>
		</thead>
	</table>
	<!-- 2 toolBar -->
	<div id="departmentDataGridToolbar" style="padding:5px 5px;">
	<!-- 	<a id="departmentAdd" data-cmd="departmentAdd"
			href="javascript:void(0)" class="easyui-linkbutton c8"
			iconCls="icon-add " plain="true" >新增</a> <a id="departmentEdit"
			data-cmd="departmentEdit" href="javascript:void(0)"
			class="easyui-linkbutton c3" iconCls="icon-edit" plain="true">修改</a>
		<a id="departmentDelete" data-cmd="departmentDelete"
			href="javascript:void(0)" class="easyui-linkbutton c5"
			iconCls="icon-remove" plain="true">删除</a> <a id="departmentRefresh"
			data-cmd="departmentRefresh" href="javascript:void(0)"
			class="easyui-linkbutton c7" iconCls="icon-reload" plain="true">刷新</a> -->
			<a id="departmentAdd" href="javascript:void(0)"
			class="easyui-linkbutton" iconCls="icon-add" data-cmd="departmentAdd" >新增</a> <a
			id="departmentEdit" href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit"  data-cmd="departmentEdit">修改</a> <a id="departmentDelete"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove"  data-cmd="departmentDelete">删除</a> <a id="departmentRefresh"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-reload"  data-cmd="departmentRefresh">刷新</a>
				<a id="departmentExport"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-redo" data-cmd="departmentImport">导入Excel</a>
			<a id="departmentExport"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-undo" data-cmd="departmentExport">导出Excel</a>
		<div>
			<form id="deptSearchForm" action="">
				<!-- 关键字，状态普通查询 -->
   	    	关键字：<input id="q" type="text" name="q"> 
   	    	状态：<select name="state" id="state">
   	    	     <option value="-2">全部</option>
   	    	     <option value="0">正常</option>
   	    	     <option value="-1">禁用</option>
   	    	   </select>
				<a href="javascript:void(0)" data-cmd="departmentSearch"
					class="easyui-linkbutton c1" iconCls="icon-search" >查询</a>
				<a href="javascript:void(0)" data-cmd="openDeptAdvanceDialog"
					class="easyui-linkbutton c2" iconCls="icon-search" plain="true">高级查询</a>
			</form>
		</div>
	</div>
		<!-- 导入导出表单 -->
	<div id="downloadDlg" class="easyui-dialog" style="width: 400px"
		closed="true" title="文件上传" >
		 <form id="downloadForm" action="/excel/deptUpload" method="post" enctype="multipart/form-data">
            <table>
                <tr>
                    <td>选择文件:</td>
                    <td><input name="file" class="f1 easyui-filebox" data-options="prompt:'请选择excel文件...',buttonText:'浏览', accept: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel'" style="width:200px"></input></td>
                    <td><input type="submit" value="上传" href="javascript:void(0)"></input></td>
                </tr>
                <tr>
                </tr>
            </table>
        </form>
	</div>








	<!-- 3 添加或编辑对话框  模态框！ -->
	<div id="departmentDialog" class="easyui-dialog" style="width: 400px"
		closed="true" buttons="#departmentDialogButtons">
		<form id="departmentDialogForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<!--由于添加和编辑对话框是通过一个Form，以隐藏域的方式区分是添加还是修改 -->
			<input type="hidden" name="id">
			<table>
				<tr>
					<td>部门名称:</td>
					<td><input name="name" type="text" /></td>
				</tr>
				<tr>
					<td>部门编号:</td>
					<td><input name="sn" type="text" /></td>
				</tr>
				<tr>
					<td>路径:</td>
					<td><input name="dirPath" type="text" /></td>
				</tr>
				<tr>
					<td>状态:</td>
					<td><input id="defaultValue" name="state" type="radio"
						value="0" />正常 <input name="state" type="radio" value="-1" /> 停用</td>
				</tr>
				<tr>
					<td>部门经理:</td>
					<td>
						<!-- private Employee manager;   不是给对象赋值而是给对象的ID属性赋值--> 
						<select
						id="cg" class="easyui-combogrid" name="manager.id"
						style="width: 200px;"
						data-options="    
			            panelWidth:450,   
			            fitColumns:'true', 
			              
			            idField:'id',    
			            textField:'realName',    
			            url:'/employee/list',  
			            pagination:true,
			            mode:'remote',
			            columns:[[    
			                {field:'id',title:'工号',width:60},    
			                {field:'realName',title:'姓名',width:100},    
			                {field:'dept',title:'管理部门',width:100,formatter:objFormatter},    
			                {field:'state',title:'状态',width:120,formatter:employeeState} 
			            ]]    
			        "></select>

					</td>
				</tr>
				<tr>
					<td>上级部门:</td>
					<td>
					<!-- <select id="cc" class="easyui-combotree" name="parent.id"
						style="width: 200px;"
						data-options="url:'/department/loadDepartmentTree'"></select> -->
					<select id="cc"  name="parent.id" style="width: 200px;"></select>
						
					</td>
				</tr>
			</table>

		</form>
	</div>
	<!-- 4 添加或编辑对话框buttons -->
	<div id="departmentDialogButtons">
		<a id="departmentSave" data-cmd="departmentSave"
			href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" style="width: 90px">保存</a> <a id="departmentCancel"
			data-cmd="departmentCancel" href="javascript:void(0)"
			class="easyui-linkbutton c5" iconCls="icon-cancel"
			style="width: 90px">取消</a>
	</div>
	<!-- 查询buttons -->
	<div id="searchDialogButtons">
		<a id="searchSave" data-cmd="searchSave"
			href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" style="width: 90px">提交</a> <a id="departmentCancel"
			data-cmd="searchCancel" href="javascript:void(0)"
			class="easyui-linkbutton c5" iconCls="icon-cancel"
			style="width: 90px">取消</a>
	</div>
	<!-- 高级查询弹出框 -->
	<div id="searchDialog" class="easyui-dialog" style="width: 400px"
		closed="true" buttons="#searchDialogButtons">
		<form id="searchDialogForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<!--由于添加和编辑对话框是通过一个Form，以隐藏域的方式区分是添加还是修改 -->
			<input type="hidden" name="id">
			<table>
				<tr>
					<td nowrap="nowrap">关键字</td>
					<td><input name="q" class="easyui-textbox"></td>
				</tr>
				<tr>
					<td>状态</td>
					<td><input id="stateDefaultChecked" formatter="stateFormatter"
						type="radio" name="state" value="0">正常 <input
						formatter="stateFormatter" name="state" type="radio" value="-1">停用
					</td>
				</tr>

				<tr>
					<td>上级部门</td>
					<td>
						<!--         				<input name="parent.id" class="easyui-textbox" > -->
						<select id="cc" name="parentId" style="width: 143px;"
						class="easyui-combotree" data-options="url:'/department/loadDepartmentTree'"></select>
					</td>
				</tr>
				<tr>
					<td>部门经理</td>
					<td>
						<!--  
							 idField:'id',   传递到后台属性名称 
					         textField:'username',  显示的内容
					         url:'datagrid_data.json', 表格数据url地址
					          fitColumns:true,   让所有列占满正行
					          mode:'remote',  当输入编号时,发送请求重新查询,q作为参数名称,把内容传递到后台
					          pagination:true 显示分页条
					            
					     --> <!-- <input name="manager.id" class="easyui-textbox" > -->
						<select id="cg" class="easyui-combogrid" name="managerId"
						style="width: 250px;"
						data-options="    
            panelWidth:450,        
            idField:'id',    
            textField:'realName',    
            url:'/employee/list', 
            mode:'remote',
            pagination:true,
            columns:[[    
                {field:'id',title:'工号',width:60},    
                {field:'realName',title:'真实姓名',width:60},    
                {field:'email',title:'邮箱',width:100},    
                {field:'state',title:'状态',width:120,formatter:stateFormatter},    
                
            ]]    
        "></select>

</body>
</html>