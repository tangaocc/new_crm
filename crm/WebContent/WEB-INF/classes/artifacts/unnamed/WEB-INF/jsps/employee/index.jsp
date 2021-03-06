<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>部门管理</title>
<!-- 导入公共jsp，就拥有了公共配置：easyui,js,css -->
<%@include file="/WEB-INF/jsps/common.jsp"%>
<script type="text/javascript">
	
	
	$(function() {
		//1.定义easyui对象的变量;
		var employeeDataGrid, employeeDialog, employeeDialogForm, cg,
		selectedRoleForm,selectedRoleDataGrid,allRoleDataGrid;
		//给每个对象变量赋值;
		employeeDataGrid = $("#employeeDataGrid");
		employeeDialog = $('#employeeDialog');
		employeeDialogForm = $('#employeeDialogForm');
		selectedRoleForm = $('#selectedRoleForm');
		selectedRoleDataGrid = $('#selectedRoleDataGrid');
		allRoleDataGrid = $('#allRoleDataGrid');
		cg = $('#cg');
	
		//初始化表格
		employeeDataGrid.datagrid({});
	
		//初始化员工分页条选择框;
		var pager = employeeDataGrid.datagrid("getPager");
		pager.pagination({
			"showRefresh" : false,
			"showPageList" : false,
			"displayMsg" : ""
		})
	
		//初始化部门选择分页条;
		var gridCg = cg.combogrid('grid')
		var pagerCg = gridCg.datagrid("getPager");
		pagerCg.pagination({
			"showRefresh" : false,
			"showPageList" : false,
			"displayMsg" : ""
		})
//========================================================
		var cmdObj = {
			"employeeRefresh" : function() {
				employeeDataGrid.datagrid("reload");
			},
			"employeeCancel" : function() {
				employeeDialog.dialog("close");
			},
			"searchCancel" : function() {
				$("#searchDialog").dialog("close");
			},
			"employeeAdd" : function() {
				$("#employeeDialog").dialog("setTitle", "添加员工")
				.dialog("center").dialog("open");
				//清除表单
				$("#employeeDialogForm").form("clear");
				
				employeeDialogForm.form('clear');
				//$("#stateDefaultChecked").prop("checked", true);
				//清空已选权限的datagrid表格
				selectedRoleDataGrid.datagrid('loadData', { total: 0, rows:[]});
				//刷新所有权限的数据;
				allRoleDataGrid.datagrid("reload");
				
				
				
			},
			"employeeEdict" : function() {
				//必须选中一行
				var row = $('#employeeDataGrid').datagrid('getSelected');
				if (!row) {
					$.messager.alert('温馨提示', '请选中要修改行!', 'error');
					return;//如果没有数据做了提示信息就应该返回
				}

				//先清除
				$("#employeeDialogForm").form("clear");
				//回显
				$("#employeeDialogForm").form("load", row);
				if (row.department) {
					$("#cg").combogrid('setValue', row.department.name);
				}
				//打开对话框的时候，把已选权限给清空：直接传入空数据
				//$selectedPermsDatagrid.datagrid("loadData",[]);
				selectedRoleDataGrid.datagrid("loadData",{total:0,rows:[]});
				//回显：
				//$selectedPermsDatagrid.datagrid("loadData",rowData.permissions);
				selectedRoleDataGrid.datagrid("loadData",{total:0,rows:row.roles});
				
				//打开新增或编辑对话框
				$("#employeeDialog").dialog("setTitle", "编辑员工")
						.dialog("center").dialog("open");
			},
			"employeeSave" : function() {
				$('#employeeDialogForm').form('submit', {
					url : "/employee/save",
					onSubmit : function(param) {
						//return $(this).form('validate');
						// 获取选中表格的所有行
		        		var rowDatas = selectedRoleDataGrid.datagrid("getRows");
		        		console.debug(rowDatas);
		        		//从表格中，取出每行数据,遍历取得ID
		        		for (var i = 0; i < rowDatas.length; i++) {
		        			var rowData = rowDatas[i].id;
		        			/*
		        				param表示额外的参数:
		        				param.xx=xx;
		        				permissions[0].id=1;
				        	 	param可以表示当前提交的请求对应的对象里面的字段;
								这里就用来表示的是 Role里面的permissions字段,这是一个集合,可以通过索引
								取出集合里面的对象,通过对象.id给对象的字段赋值;
		        			
		        				因为后台的Role类中的集合是这样的:List<Permission> permissions
		        				所有拼装成指定提交格式 =》permissions[0].id =1,就相当于依次给集合里面的
		        				Permission的id赋值;
		        			*/
		        			//提价额外参数;
		        			param['roles['+i+'].id'] = rowData;
		        			
		        		}
		        		 //return employeeDialogForm.form("validate");
					},
					success : function(result) {
						//提交的返回值是Json字符串，不是Json对象，需要自己转换eval $.parseJSON JSON.parse
						var result = $.parseJSON(result);
						if (result.success) {
							//关闭对话框
							$("#employeeDialog").dialog("close");
							//给个提示信息
							$.messager.alert('温馨提示', '保存成功', 'info');
							//刷新界面
							$('#employeeDataGrid').datagrid('reload');
						} else {
							$.messager.alert('温馨提示', result.message, 'error');
						}
					}
				});
			},
			//导入excel
			"employeeImport":function(){				
				$("#downloadDlg").dialog("center").dialog("open");
			},
			//导出excel,下载不能用ajax.
			"employeeExport":function(){
				$("#downloaddp").dialog('center').dialog('open')
				.dialog('setTitle', '导出中,请稍后...');
				//开启进度条控制;
				start(true);
			},
			"searchButton" : function() {
				//3.封装到JQuery原型上面
				var param = $("#searchForm").serializeForm();
				$("#employeeDataGrid").datagrid("load", param)
			},
			//高级查询
			"gaojiSearch" : function() {
				//清除表单
				$("#searchDialogForm").form("clear");
				$("#searchDialog").dialog("setTitle", "高级查询").dialog("center")
						.dialog("open");
			},
			"searchSave" : function() {
				var paramObj = $("#searchDialogForm").serializeForm();
				console.debug(paramObj)
				$("#employeeDataGrid").datagrid('load', paramObj);
				$("#searchDialog").dialog("close");
			},
			"employeeDelete" : function() {

				var row = $('#employeeDataGrid').datagrid('getSelected');
				if (!row) {
					$.messager.alert('温馨提示', '请选中要删除行!', 'error');
					return;//如果没有数据做了提示信息就应该返回
				}
				if (row) {
					$.messager.confirm('温馨提示', '您确定要删除该行数据吗?', function(r) {
						if (r) {
							
							
							 $.post('/employee/delete', {
								id : row.id
							}, function(result) {
								
								//期望返回成功与否，如果有错需要返回错误提示信息 {"success":true,"message":"xxxx"}
								//可以封装一个类AjaxResult，里面有两个属性
								if (result.success) {
									//给个提示信息
									$.messager.alert('温馨提示', '删除成功', 'info');
									//刷新界面
									$('#employeeDataGrid').datagrid('reload');
								} else {
									$.messager.alert('温馨提示', result.message,
											'error');
								}
							}, 'json'); 
						}
					});
				}
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
		     	var param = $("#searchForm").serializeForm();
				var q=param['q']
				var state=param['state']
		      location.href="/excel/export?q="+q+"&state="+state;
		    	  //关闭对话框
		   
	    		
		      
		    }
		  }, 20)
		}; 
		
		
	/*
		添加或者编辑选择角色
	*/
	//从已选列表里面删除选择的
	selectedRoleDataGrid.datagrid({
		onDblClickRow:function(index,row){
				//双击删除已选
				selectedRoleDataGrid.datagrid("deleteRow",index);
	    }
	})
	//从所有权限列表选择权限
	allRoleDataGrid.datagrid({
		 onDblClickRow:function(index,row){
		    	var selectingId = row.id;
		    	console.debug("选择的id:"+selectingId);
		    	//判断表格是否有
		    	var rows = selectedRoleDataGrid.datagrid('getRows');
		    	//console.debug(rows[6]);
		    	for (var i = 0; i < rows.length; i++) {
		    		var id = rows[i].id;
		    		if (selectingId==id) {
		    		console.debug("已选择列表选择的id:"+id);
		    			$.messager.alert('错误提示','角色:【'+rows[i].name+'】 已存在!', 'error');
		    			return;
					}
				}
		    	//把选择的权限添加到已有里面去;
		    	selectedRoleDataGrid.datagrid('appendRow',row);
		    }
	});
		
		

	})
	
	
	//jq====================================

	
	
	
	function employeeFormatter(v, r, i) {
		if (v == -1) {
			return "<font style='color:red'>离职</font>"
		} else {
			return "<font style='color:green'>在职</font>"
		}
	}
	function objectFormatter(v, r, i) {
		if (v) {
			return v.name || v.realName
			//按需求添加
		}

	}//公共方法突然失效,写外面待完成后再看
</script>
</head>
<body>
	<!-- 1 datagrid -->
	<table id="employeeDataGrid" class="easyui-datagrid" fit="true"
		url="/employee/list" toolbar="#employeeDataGridToolbar"
		pagination="true" rownumbers="true" fitColumns="true"
		singleSelect="true">
		<thead>
			<tr>
				<th field="id" width="50">Id</th>
				<th field="username" width="50">员工账号</th>
				<th field="realName" width="50">真实姓名</th>
				<!-- <th field="password" width="50">密码</th> -->
				<th field="tel" width="50">电话</th>
				<th field="email" width="50">邮箱</th>

				<th field="department" width="50" formatter="objFormatter">部门</th>


				
				<th field="inputTime" width="50">录入时间</th>
				<th field="state" width="50" formatter="employeeFormatter">状态</th>
				<th field="roles" width="50" formatter="arrayFormatter">拥有角色</th>
				 
				<!-- 格式化代码在common.js中 -->
			</tr>
		</thead>
	</table>
	<!-- 2 toolBar -->
	<div id="employeeDataGridToolbar">
	
		<shiro:hasPermission name="employee:save">
				<a id="employeeAdd" href="javascript:void(0)"
					class="easyui-linkbutton" iconCls="icon-add" plain="true"
					data-cmd="employeeAdd">新增</a>
		</shiro:hasPermission>
		<shiro:hasPermission name="employee:save">
			 <a id="employeeEdit"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" plain="true" data-cmd="employeeEdict">修改</a> 
		</shiro:hasPermission>
		<shiro:hasPermission name="employee:delete">
			<a id="employeeDelete" href="javascript:void(0)"
					class="easyui-linkbutton" iconCls="icon-remove" plain="true"
					data-cmd="employeeDelete">删除</a> 
		</shiro:hasPermission>
			
			<a id="employeeRefresh" href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-reload" plain="true" data-cmd="employeeRefresh">刷新</a>
			<a id="employeeExport"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-redo" data-cmd="employeeImport">导入Excel</a>
			<a id="employeeExport"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-undo" data-cmd="employeeExport">导出Excel</a>
		<!-- 普通查询 -->

		<form id="searchForm">
			关键字:<input id="q" type="text" name="q"
				class="easyui-textbox textbox-radius" />状态: <select id="state"
				name="state" class="easyui-combobox" style="width: 70px;">
				<option value="-2" selected="true">全部</option>
				<option value="0">正常</option>
				<option value="-1">离职</option>
			</select> <a id="searchButton" data-cmd="searchButton"
				href="javascript:void(0)" class="easyui-linkbutton c1"
				iconCla="icon-srarch">查询</a> <a data-cmd="gaojiSearch"
				id="gaojiSearch" href="javascript:void(0)"
				class="easyui-linkbutton c2" iconCls="icon-search">高级查询</a>
		</form>
	</div>
		<!-- 导入导出对话框进度条; -->
	<div id="downloaddp" class="easyui-dialog" style="overflow: hidden;"
		closed="true" >
		<!-- 进度条 -->
	<!-- 	<div id="p" class="easyui-progressbar progressbar-auto-color progressbar-animation" data-options="value:15" data-percent="15"></div> -->
		<!-- 进度条 -->
	<div id="p" class="easyui-progressbar" style="width:400px;"></div>
	</div>
	
	<!-- 3 添加或编辑对话框 -->
	<div id="employeeDialog" class="easyui-dialog" style="width: 1200px"
		closed="true" buttons="#employeeDialogButtons">
		<form id="employeeDialogForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<!-- 已选角色的form:这个单独选择,拿到当前行的ID,保存当前用户的权限 -->
			<div class="easyui-layout" style="width: 1100px; height: 300px;">

				<div data-options="region:'west',split:true" title="基础数据"
					iconCls:'icon-ok'" style="width: 300px; ">
					<!-- 区分是添加还是编辑 -->
					<br />


					<!--由于添加和编辑对话框是通过一个Form，以隐藏域的方式区分是添加还是修改 -->
					<input type="hidden" name="id">

					<table style="margin: auto;">
						<tr>
							<td>员工账号</td>
							<td><input type="text" name="username" /></td>
						</tr>
						<tr>
							<td>密码</td>
							<td><input type="text" name="password" /></td>
						</tr>
						<tr>
							<td>真实姓名</td>
							<td><input type="text" name="realName" /></td>
						</tr>
						<tr>
							<td>电话</td>
							<td><input type="text" name="tel" /></td>
						</tr>
						<tr>
							<td>邮箱</td>
							<td><input type="text" name="email" /></td>
						</tr>
						<tr>
							<td>录入时间</td>
							<td><input type="text" name="inputTime"
								class="easyui-datebox textbox-radius" size="18" /></td>
						</tr>
						<tr>
							<td>状态:</td>
							<td><input id="defaultValue" name="state" type="radio"
								value="0" />正常 <input name="state" type="radio" value="-1" />
								停用</td>
						</tr>
						<tr>
							<td>部门:</td>
							<td><select id="cg" class="easyui-combogrid"
								name="department.id" style="width: 120px;"
								data-options="    
						            panelWidth:400,        
						            idField:'id',    
						            textField:'name',    
						            url:'/department/list', 
						            mode:'remote',
						            pagination:true,
						            columns:[[    
						                {field:'name',title:'部门名字',width:200},    
						                {field:'sn',title:'部门标识',width:200},    
						            ]]">
							</select></td>
						</tr>
					</table>
				</div>

				<!-- 已选角色 -->
				<div data-options="region:'center',title:'角色信息-已选角色',iconCls:'icon-ok'" style="width: 450px;"padding: 10px;">
					<form id="selectedRoleForm" method="post" novalidate
									style="margin: 0; padding: 20px 50px;background-color: LightCyan;">
						<table id="selectedRoleDataGrid" class="easyui-datagrid"
							url="/role/loadRoleByEmpId" rownumbers="true" fitColumns="true"
							singleSelect="false" fit="true" >
							<thead>
								<tr>
									<th field="id" width="50" hidden="true">id</th>
									<th field="name" width="50">角色名称</th>
									<th field="sn" width="50">角色标识</th>
								</tr>
							</thead>
						</table>
					</form>
				</div>
				<!-- 所有角色 -->
				<div
					data-options="region:'east',split:true,title:'所有角色',collapsible:false,iconCls:'icon-ok'"
					 style="width: 430px; padding: 10px">
					<table id="allRoleDataGrid" class="easyui-datagrid"
						pagination="true" url="/role/list" rownumbers="true"
						fitColumns="true" singleSelect="false" fit="true">
						<thead>
							<tr>
								<th field="id" width="50" hidden="true">id</th>
								<th field="name" width="50">角色名称</th>
								<th field="sn" width="50">角色编号</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</form>
	</div>




	<%-- 
	<!-- 添加或编辑对话框 -->
	<div id="employeeDatagridDlg" class="easyui-dialog"
		style="width: 1200px" closed="true"
		buttons="#employeeDatagridDlgButtons">
		<form id="employeeDatagridDlgForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
				<!-- 已选角色的form:这个单独选择,拿到当前行的ID,保存当前用户的权限 -->
				<div class="easyui-layout" style="width: 1100px; height: 350px;">
				<div data-options="region:'west',split:true" title="基础数据" style="width:300px;background-color: LightCyan;">
				<!-- 区分是添加还是编辑 -->
						<br/>
						<input type="hidden" name="id" />
					<table style="margin: auto;">
						<tr>
							<td>用户名:</td>
							<td><input name="username" class="easyui-textbox"
								required="true"></td>
						</tr>
						<tr>
							<td>真实名字:</td>
							<td><input name="realName" class="easyui-textbox"
								required="true"></td>
						</tr>
						<tr>
							<td>密码:</td>
							<td><input name="password" class="easyui-textbox"
								required="true"></td>
						</tr>
						<tr>
							<td>电话:</td>
							<td><input name="tel" class="easyui-textbox"></td>
						</tr>
						<tr>
							<td>入职时间:</td>
							<td><input name="inputTime" class="easyui-datebox"></td>
						</tr>
						<tr>
							<td>邮箱:</td>
							<td><input name="email" class="easyui-textbox" required="true"></td>
						</tr>
						<tr>
							<td>状态:</td>
							<td><input id="stateDefaultChecked" formatter="stateFormatter"
								type="radio" name="state" value="0">正常 <input
								formatter="stateFormatter" name="state" type="radio" value="-1">离职
							</td>
						</tr>
						<tr>
							<td>部门:</td>
							<td><select id="cg" class="easyui-combogrid"
								name="department.id" style="width: 120px;"
								data-options="    
						            panelWidth:400,        
						            idField:'id',    
						            textField:'name',    
						            url:'/department/list', 
						           
						            mode:'remote',
						            <!-- 添加一个属性 -->
						            pagination:true,
						            columns:[[    
						                {field:'name',title:'部门名字',width:200},    
						                {field:'sn',title:'部门标识',width:200},    
						            ]]">
							</select></td>
						</tr>
					</table>
				</div>
				<!-- 已选角色 -->
				<div data-options="region:'center',title:'角色信息-已选角色',iconCls:'icon-ok'" style="width: 450px;
					style="padding: 10px;">
					<form id="selectedRoleForm" method="post"
						novalidate style="margin: 0; padding: 20px 50px;">
							<table id="selectedRoleDatagrid" class="easyui-datagrid"
								url="/role/loadRoleByEmpId" rownumbers="true"
								fitColumns="true" singleSelect="false" fit="true">
								<thead>
									<tr>
										<th field="id" width="50" hidden="true">id</th>
										<th field="name" width="50">角色名称</th>
										<th field="sn" width="50">角色标识</th>
									</tr>
								</thead>
							</table>
					</form>
				</div>
				<!-- 所有角色 -->
				<div
					data-options="region:'east',split:true,title:'所有角色',collapsible:false"
					style="width: 430px; padding: 10px">
					<table id="allRoleDatagrid" class="easyui-datagrid"
						pagination="true" url="/role/list" rownumbers="true"
						fitColumns="true" singleSelect="false" fit="true">
						<thead>
							<tr>
								<th field="id" width="50" hidden="true">id</th>
								<th field="name" width="50">角色名称</th>
								<th field="sn" width="50">角色编号</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</form>
	</div>
	
	
	
	 --%>
	
	
	
	
	
	<!-- 4 添加或编辑对话框buttons -->
	<div id="employeeDialogButtons">
		<a id="employeeSave" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px"
			data-cmd="employeeSave">保存</a> <a id="employeeCancel"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" style="width: 90px" data-cmd="employeeCancel">取消</a>
	</div>
	<!-- 4 高级查询buttons -->
	<div id="searchButtons">
		<a id="searchSave" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px"
			data-cmd="searchSave">确定</a> <a id="searchCancel"
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" style="width: 90px" data-cmd="searchCancel">取消</a>
	</div>
	<!-- 高级查询 -->
	<div id="searchDialog" class="easyui-dialog" style="width: 400px"
		closed="true" buttons="#searchButtons">
		<form id="searchDialogForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<!--由于添加和编辑对话框是通过一个Form，以隐藏域的方式区分是添加还是修改 -->
			<input type="hidden" name="id">
			<table>
				<tr>
					<td>关键字</td>
					<td><input type="text" name="q" class="easyui-textbox" /></td>
				</tr>
				<tr>
					<td>状态:</td>
					<td><input id="defaultValue" name="state" type="radio"
						value="0" />在职 <input name="state" type="radio" value="-1" /> 离职</td>
				</tr>
				<tr>
					<td>部门:</td>
					<td><select id="cg" class="easyui-combogrid" name="deptId"
						style="width: 120px;"
						data-options="    
						            panelWidth:400,        
						            idField:'id',    
						            textField:'name',    
						            url:'/department/list', 
						           
						            mode:'remote',
						            <!-- 添加一个属性 -->
						            pagination:true,
						            columns:[[    
						                {field:'name',title:'部门名字',width:200},    
						                {field:'sn',title:'部门标识',width:200},    
						            ]]">
					</select></td>
				</tr>
			</table>

		</form>
	</div>
		<!-- 导入导出表单 -->
	<div id="downloadDlg" class="easyui-dialog" style="width: 400px"
		closed="true" title="文件上传" >
		 <form id="downloadForm" action="/excel/upload" method="post" enctype="multipart/form-data">
            <table>
                <tr>
                    <td>选择文件:</td>
                    <td><input name="file" class="f1 easyui-filebox" data-options="prompt:'请选择excel文件...',buttonText:'浏览', accept: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel'" style="width:200px"></input></td>
                    <td><input type="submit" value="上传" href="javascript:void(0)" onclick="start(true)"></input></td>
                </tr>
                <tr>
                </tr>
            </table>
        </form>
	</div>
</body>
</html>