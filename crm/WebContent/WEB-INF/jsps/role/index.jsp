<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Role管理</title>
<%@include file="/WEB-INF/jsps/common.jsp"%>
<script type="text/javascript">
	// 页面加载完毕后
	$(function() {
		// 1、声明出页面需要使用的组件
		var $roleDatagrid, $roleDialog, $roleDialogForm,$selectedPermsDatagrid,$allPermsDatagrid;
		// 2、把页面的组件，缓存到上面声明的变量中
		$roleDatagrid = $("#roleDatagrid");
		$roleDialog = $("#roleDialog");
		$allPermsDatagrid = $("#allPermsDatagrid");
		$selectedPermsDatagrid = $("#selectedPermsDatagrid");
		$roleDialogForm = $("#roleDialogForm");
		// 3、初始化组件
		// 初始化添加表单
		$roleDialogForm.form({
			url : "/role/save",
			onSubmit : function() { // 在表单‘提交前’，做验证
				return $roleDialogForm.form("validate");
			},
			success : function(data) {//data是后台save方法返回的字符串
				// 把字符串转变成json对象
				data = $.parseJSON(data);
				// 判断结果
				if (data.success) {
					// 关对话框
					$roleDialog.dialog("close");
					$.messager.alert("温馨提示", data.message, "info", function() {
						//调用重新加载数据的方法
						$roleDatagrid.datagrid("reload");
					});
				} else {
					$.messager.alert('错误提示', data.message, 'error');
				}
			}
		});
		// 4、创建一个"命令对象"，把当前模块所有的功能，都打包到这个对象上
		var cmdObj = {
			create : function() {
				// 清空对话框里面的表单内容
				$roleDialogForm.form("clear");
				// 打开对话框
				$roleDialog.dialog("setTitle", "添加角色").dialog("center").dialog("open");
				//打开对话框的时候，把已选权限给清空：直接传入空数据
				$selectedPermsDatagrid.datagrid("loadData",[]);
				
			},
			edit : function() {
				// 获取选中行数据
				var rowData = $roleDatagrid.datagrid("getSelected");
				// 判断是否选中行
				if (!rowData) {
					$.messager.alert("温馨提示", "请选中一行数据！！", "info");
					return;
				}
				// 清空对话框里面的表单内容
				$roleDialogForm.form("clear");
				// 加载数据：Easyui form的load方法，遵循一个“同名匹配”的原则
//				
				$roleDialogForm.form("load", rowData);
				
				//打开对话框的时候，把已选权限给清空：直接传入空数据
				//$selectedPermsDatagrid.datagrid("loadData",[]);
				$selectedPermsDatagrid.datagrid("loadData",{total:0,rows:[]});
				//回显：
				//$selectedPermsDatagrid.datagrid("loadData",rowData.permissions);
				$selectedPermsDatagrid.datagrid("loadData",{total:0,rows:rowData.permissions});
				$allPermsDatagrid.datagrid("load");
				
				// 打开对话框
				$roleDialog.dialog("open").dialog("setTitle","编辑角色").dialog("center");
			},
			remove : function() {
				// 获取选中行数据
				var rowData = $roleDatagrid.datagrid("getSelected");
				// 判断是否选中行
				if (!rowData) {
					$.messager.alert("温馨提示", "请选中一行数据！！", "info");
					return;
				}
				$.get("/role/delete",{id:rowData.id}, function(data) {
					if (data.success) {//删除成功
						$.messager.alert('消息提示', '删除成功!', 'info',
								function() {
									//调用重新加载数据的方法
									$roleDatagrid.datagrid("reload");
								});//消息							
					} else {
						$.messager.alert('错误提示', data.message, 'error');
					}
				}, 'json');
			},
			reload : function() {
				//调用重新加载数据的方法
				$roleDatagrid.datagrid("reload");
			},
			save : function() {
				//提交表单
				$roleDialogForm.submit();
			},
			cancel : function() {
				//关闭对话框
				$roleDialog.dialog("close");
			},
			search : function() {//简单搜索：查询条件必须少
				$roleDatagrid.datagrid("load", $("#searchForm").formSerJson());
			}
		};
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
		
		  
		////toolbar="#datagridToolbar"
			
		//js方式创建roleDatagrid：
		$roleDatagrid.datagrid({    
		    url:"/role/list",
			title:"Role管理", 
			fit:"true" ,
			border:"false", 
			fitColumns:"true",
			singleSelect:"true",
			pagination:"true",
			rownumbers:"true",
			toolbar: [{
				
				
				iconCls: 'icon-add',
				text:"添加",
				handler: cmdObj['create']
			},{
				iconCls: 'icon-edit',
				text:"编辑",
				handler: cmdObj['edit']
			},{
				iconCls: 'icon-remove',
				text:"删除",
				handler: cmdObj['remove']
			},{
				iconCls: 'icon-reload',
				text:"刷新",
				handler: cmdObj['reload']
			}],
		    columns:[[    
		        {field:'name',title:'Role名称',width:10},    
		        {field:'sn',title:'编号',width:10},    
		        {field:'permissions',title:'拥有权限',width:50,formatter:arrayFormatter}    
		    ]]    
		});
		//已选权限
		$selectedPermsDatagrid.datagrid({    
			title:"已选权限", 
			width : 500,
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
		    	{field:'id',title:'权限ID',width:10},
		    	{field:'sn',title:'权限编号',width:10},    
		        {field:'name',title:'权限名称',width:10},    
		        {field:'resource',title:'资源地址',width:10},    
		        {field:'state',title:'状态',width:5}      
		    ]]    
		});
		//所有权限
		$allPermsDatagrid.datagrid({    
		    url:"/permission/list",
			title:"所有权限",
			width : 500,
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
		    	{field:'id',title:'权限ID',width:10}, 
		        {field:'sn',title:'权限编号',width:10},    
		        {field:'name',title:'权限名称',width:10},    
		        {field:'resource',title:'资源地址',width:10},    
		        {field:'state',title:'状态',width:5}    
		    ]]    
		});
			
		//dialog的抽取：
		$roleDialog.dialog({    
			width : 1000,
			height : 420,   
		    title:"Role添加面板",
			buttons:[{
				text:'保存',
				iconCls: 'icon-ok',
				handler:cmdObj["save"]
			},{
				text:'关闭',
				iconCls: 'icon-no',
				handler:cmdObj["cancel"]
			}],
			closed:"true",
			modal:"true"
		}); 
		
		//form的抽取：
		$roleDialogForm.form({    
		    url:"/role/save",    
		    onSubmit: function(param){
		    	//param:形参：param.属性=值
		       /*也是同名匹配原则 
		        param.sn = 'value1';    
		        param.name = 'value2';  */ 
		        //需求：在提交role信息的时候，同时要提交与以选权限的关系的id值：一个角色可能有多个权限的id
		        /* List<Permission> permissions = new ArrayList<Permission>(); */
		        //Permission [id=1,
		        	// 前台：
					 //  permisisons[0].id=1
					 //  permisisons[1].id=2
					 //  permisisons[2].id=3。。。。
		    	//param['permissions[0].id']=1;
		        //动态赋值：
		        //获取所有的已选权限：
		    	var getRows = $selectedPermsDatagrid.datagrid("getRows");
		       //方案1
		       for (var i = 0; i < getRows.length; i++) {
		        	var curId = getRows[i].id;//当前行的权限的id
		        	param['permissions['+i+'].id']=curId;
				} 
				/* $.each() */
				
		    },
		    success:function(data){    
		    	//json字符串：
		    	var d = $.parseJSON(data);
		    	if (d.success) {//保存成功
					$.messager.alert('消息提示', '保存成功!', 'info',
							function() {
						       $roleDialog.dialog("close");
								//调用重新加载数据的方法
								$roleDatagrid.datagrid("reload");
							});//消息							
				} else {
					$.messager.alert('错误提示', d.message, 'error');
				}
		    	
		    } 
		});  
		
	});
</script>
</head>
<body>
	<!-- 1、list的数据表格 -->
	<table id="roleDatagrid" ></table>
	<!-- 2、添加编辑对话框 -->
	<div id="roleDialog" >
		<form id="roleDialogForm" method="post">
			<input name="id" type="hidden" />
			<table align="center">
			<tr>
				<td colspan="2">Role名称：<input name="name" class="easyui-validatebox" required="true" />
				 sn:<input class='easyui-validatebox' type='text' name='sn'></input>
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
</body>
</html>