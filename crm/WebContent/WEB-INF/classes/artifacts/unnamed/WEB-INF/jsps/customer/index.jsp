<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户管理</title>
<!-- 导入公共jsp，就拥有了公共配置：easyui,js,css -->
<%@include file="/WEB-INF/jsps/common.jsp"%>
<script src="/resources/js/highcharts/js/highcharts.js"></script>
<script src="/resources/js/highcharts/js/highcharts-3d.js"></script>
<script src="/resources/js/highcharts/js/modules/exporting.js"></script>
<script type="text/javascript">
	$(function() {
		// 1、声明出页面需要使用的组件

		var customerDataGrid, customerDialog, customerQueryDialog, customerTransferDialog,customerTraceDialog,
		customerDialogForm, customerQueryDialogForm, customerTransferDialogForm,customerTraceDialogForm;
		// 2、把页面的组件，缓存到上面声明的变量中
		customerDataGrid = $("#customerDataGrid");
		customerDialog = $("#customerDialog");
		customerQueryDialog = $("#customerQueryDialog");
		customerTransferDialog = $("#customerTransferDialog");
		customerTraceDialog = $("#customerTraceDialog");
		customerDialogForm = $("#customerDialogForm");
		customerTransferDialogForm = $("#customerTransferDialogForm");
		customerTraceDialogForm = $("#customerTraceDialogForm");
		customerQueryDialogForm = $("#customerQueryDialogForm");
		
		// 3、初始化组件，修改组件的值
		// 4、创建一个"命令对象"，把当前模块所有的功能，都打包到这个对象上
		var cmdObj = {

			"customerSearch" : function() {
				var paramObj = $("#customerSearchForm").serializeForm();
				customerDataGrid.datagrid('load', paramObj)
			},

			//高级查询
			"customerAdvancedSearch" : function() {

				customerQueryDialog.dialog('open').dialog('center').dialog(
						'setTitle', '查询客户');
				customerQueryDialogForm.form('clear');
				//加载外键数据
				$('#sss').combobox({
					url : '/customer/queryEmployee',
					valueField : 'id',
					textField : 'realName'
				});
				$('#jjj').combobox({
					url : '/customer/querySystemDictionaryItem',
					valueField : 'id',
					textField : 'intro'
				});
				$('#aaa').combobox({
					url : '/customer/querySystemDictionaryItem',
					valueField : 'id',
					textField : 'requence'
				});

				$('#ddd').combobox({
					url : '/customer/querySystemDictionaryItem',
					valueField : 'id',
					textField : 'name'
				});
				$('#ccc').combobox({
					url : '/customer/queryEmployee',
					valueField : 'id',
					textField : 'realName'
				});
			},

			//高级查询确认
			"customerQuerySave" : function() {
				customerDataGrid.datagrid('load', $("#customerQueryDialogForm")
						.serializeForm());
			},

			"customerQueryCancel" : function() {
				customerQueryDialog.dialog('close');
			},
			//客户移交
			"customerTransfer" : function() {
				//获取选中红
				var row = customerDataGrid.datagrid('getSelected');
				//没有选中
				if (!row) {
					$.messager.alert('温馨提示', '请选中一行后,再操作!', 'error');
					return;
				}

				customerTransferDialogForm.form('load', row);
				//alert(row.name);
				$('#AA').combobox({
					url : '/customer/queryEmployee',
					valueField : 'id',
					textField : 'text'
				});

				//回显外键
				if (row.inputUser) {
					$('#AA').combobox('setValue', row.inputUser.id);
				}
				//alert(row.name);
				$('#BB').combobox({
					url : '/customer/queryEmployee',
					valueField : 'id',
					textField : 'text'
				});

				//回显外键s
				if (row.seller) {
					$('#BB').combobox('setValue', row.seller.id);
				}
				customerTransferDialog.dialog('open').dialog('center').dialog(
						'setTitle', '移交客户');

			},
			//移交确认
			"customerTransferSave" : function() {
				customerTransferDialogForm.form('submit', {
					url : "/customerTransfer/save",
					success : function(result) {
						//提交表单获取到的字符串
						var result = $.parseJSON(result);

						if (result.success) {
							//保存成功给出提示,并重新加载表格
							customerTransferDialog.dialog('close');
							$.messager.alert('温馨提示', '移交成功!', 'info');
							customerTransferDataGrid.datagrid('reload');
						} else {
							//保存失败给出提示,并重新加载表格
							customerTransferDialog.dialog('close');
							$.messager.alert('温馨提示', result.message, 'error');
							customerTransferDataGrid.datagrid('reload');
						}
					}
				});
			},
			
			//取消
			"customerTransferCancel" : function() {
				customerTransferDialog.dialog('close');
			},

			//客户跟进
			"customerTrace" : function() {
				//获取选中红
				var row = customerDataGrid.datagrid('getSelected');
				//没有选中
				if (!row) {
					$.messager.alert('温馨提示', '请选中一行后,再操作!', 'error');
					return;
				}

				customerTraceDialogForm.form('load', row);
				//编辑重新加载
				$('#CC').combobox({
					url : '/customerTraceHistory/queryCustomer',
					valueField : 'id',
					textField : 'text'
				});

				
				//编辑重新加载
				$('#DD').combobox({
					url : '/customerTraceHistory/queryEmployee',
					valueField : 'id',
					textField : 'text'
				});

				
				$('#EE').combobox({
					url : '/customerTraceHistory/querySystemDictionaryItem',
					valueField : 'id',
					textField : 'text'
				});
				customerTraceDialog.dialog('open').dialog('center').dialog(
						'setTitle', '跟进客户');
			},
			//跟进确认
			
			
			"customerTraceSave" : function() {
				
				//获取选中行
				var row = customerDataGrid.datagrid('getSelected');
				
				customerTraceDialogForm.form('submit', {
					url : "/customerTraceHistory/save",
					success : function(result) {
						//提交表单获取到的字符串
						var result = $.parseJSON(result);

						if (result.success) {
							//保存成功给出提示,并重新加载表格
							customerTraceDialog.dialog('close');
							$.messager.alert('温馨提示', '跟进成功!', 'info');
							customerTraceDataGrid.datagrid('reload');
						} else {
							//保存失败给出提示,并重新加载表格
							customerTraceDialog.dialog('close');
							$.messager.alert('温馨提示', result.message, 'error');
							customerTraceDataGrid.datagrid('reload');
						}
					}
				});
			},
			
			//取消
			"customerTraceCancel" : function() {
				customerTraceDialog.dialog('close');
			},
			//资源池
			"customerPutResourcePool" : function() {
				//获取选中行
				var row = customerDataGrid.datagrid('getSelected');
				//没有选中
				if (!row) {
					$.messager.alert('温馨提示', '请选中一行后,再操作!', 'error');
					return;
				}
				//正式客户不发资源池请求
				if (row.state == 0) {
					$.messager.alert('温馨提示', '正式客户不能放入资源池哦!', 'info');
					return;
				}
				if (row.state == -1) {
					$.messager.alert('温馨提示', '潜在客户不能放入资源池哦!', 'info');
					return;
				}

				//$.messager.alert('警告', '警告消息');
				$.messager.confirm('温馨提示', '您确认要将'
						+ '<font style="color:red" size="2px">' + '{'
						+ row.name + '}' + '</font>' + '放入资源池吗？', function(r) {
					if (r) {

						//将选中客户保存到资源池
						var data = {
							"id":row.id,	
							"name" : row.name,
							"gender" : row.gender,
							"tel" : row.tel,
							"seller" : row.seller,
							"customerSource" : row.customerSource,
							"inputTime" : row.inputTime,

							"state" : row.state
						}

						$.ajax({
							type : "POST",
							url : "/customer/poolSave",
							dataType : "json",
							contentType : "application/json",
							data : JSON.stringify(data),
							success : function(data) {

							}
						})

						
						//删除选中客户
						$.post('/customer/delete', {
							"id" : row.id
						}, function(result) {
							if (result.success) {
								//删除成功给出提示,并重新加载表格
								$.messager.alert('温馨提示', '客户成功放入资源池!', 'info');
								customerDataGrid.datagrid('reload');
							} else {
								//删除成功给出提示,并重新加载表格
								$.messager.alert('温馨提示', result.message,
										'error');
								customerDataGrid.datagrid('reload');
							}
						}, 'json');
					}
				});
			},

			
			//饼图
			"customerSourceReport" : function() {
				$('#3dDlg').dialog('center').dialog('open').dialog('setTitle',
				'唉');
				var querString = "${pageContext.request.queryString}";
				//拿到后台数据
				$.get("/customer/source3d",querString,function(data) {
					$('#container').highcharts({
						chart : {
							type : 'pie',
							options3d : {
								enabled : true,
								formatter : customerFormatter,
								alpha : 45,
								beta : 0
							}
						},
						title : {
							text : '客户来源比例图' /* 饼图的名字 */
						},
						tooltip : {
							pointFormat : '{series.name}: <b>{point.percentage:.1f}%</b>'
						},
						plotOptions : {
							pie : {
								allowPointSelect : true,
								cursor : 'pointer',
								depth : 35,
								dataLabels : {
									enabled : true,
									format : '{point.name}'
								}
							}
						},
						series : [ {
							type : 'pie',
							name : '客户占用比例',
							data : data
						} ]
					});
				});
			},

			//添加
			"customerAdd" : function() {
				//清除表单
				customerDialogForm.form("clear");
				customerDialog.dialog("setTitle", "添加客户").dialog("center")
						.dialog("open");
				//打开dialog的时候：设置一个状态的默认值：defaultValue
				//$("#defaultValue").attr("checked",true);
				//$("#defaultValue").prop("checked", true);
				$('#ss').combobox({
					url : '/customer/queryEmployee',
					valueField : 'id',
					textField : 'realName'
				});
				$('#jj').combobox({
					url : '/customer/querySystemDictionaryItem',
					valueField : 'id',
					textField : 'intro'
				});
				$('#aa').combobox({
					url : '/customer/querySystemDictionaryItem',
					valueField : 'id',
					textField : 'requence'
				});

				$('#dd').combobox({
					url : '/customer/querySystemDictionaryItem',
					valueField : 'id',
					textField : 'name'
				});
				$('#cc').combobox({
					url : '/customer/queryEmployee',
					valueField : 'id',
					textField : 'realName'
				});
			},
			"customerRefresh" : function() {
				customerDataGrid.datagrid("reload");
			},
			"customerCancel" : function() {
				customerDialog.dialog("close");
			},
			"customerEdit" : function() {
				//必须选中一行
				var row = customerDataGrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('温馨提示', '请选中要修改行!', 'error');
					return;//如果没有数据做了提示信息就应该返回
				} else {

					//先清除
					customerDialogForm.form("clear");
					//回显
					customerDialogForm.form("load", row);
					//打开新增或编辑对话框
					customerDialog.dialog("setTitle", "编辑客户").dialog("center")
							.dialog("open");

					//编辑重新加载
					$('#ss').combobox({
						url : '/customer/queryEmployee',
						valueField : 'id',
						textField : 'realName'
					});

					//回显外键
					if (row.seller) {
						$('#ss').combobox('setValue', row.seller.id);
					}
					//编辑重新加载
					$('#jj').combobox({
						url : '/customer/querySystemDictionaryItem',
						valueField : 'id',
						textField : 'intro'
					});

					//回显外键
					if (row.job) {
						$('#jj').combobox('setValue', row.job.id);
					}
					//编辑重新加载
					$('#aa').combobox({
						url : '/customer/querySystemDictionaryItem',
						valueField : 'id',
						textField : 'requence'
					});

					//回显外键
					if (row.sakaryLevel) {
						$('#aa').combobox('setValue', row.salaryLevel.id);
					}

					$('#dd').combobox({
						url : '/customer/querySystemDictionaryItem',
						valueField : 'id',
						textField : 'name'
					});

					//回显外键
					if (row.inputUser) {
						$('#dd').combobox('setValue', row.customerSource.id);
					}

					//编辑重新加载
					$('#cc').combobox({
						url : '/customer/queryEmployee',
						valueField : 'id',
						textField : 'realName'
					});

					//回显外键
					if (row.inputUser) {
						$('#cc').combobox('setValue', row.inputUser.id);
					}

				}

			},
			"customerSave" : function() {
				customerDialogForm.form('submit', {
					url : "/customer/save",
					onSubmit : function() {
						return $(this).form('validate');
					},
					success : function(result) {
						//提交的返回值是Json字符串，不是Json对象，需要自己转换eval $.parseJSON JSON.parse
						var result = $.parseJSON(result);
						if (result.success) {
							//关闭对话框
							customerDialog.dialog("close");
							//给个提示信息
							$.messager.alert('温馨提示', '保存成功', 'info');
							//刷新界面
							customerDataGrid.datagrid('reload');
						} else {
							$.messager.alert('温馨提示', result.message, 'error');
						}
					}
				});
			},

			//删除
			"customerDelete" : function() {

				var row = customerDataGrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('温馨提示', '请选中要删除行!', 'error');
					return;//如果没有数据做了提示信息就应该返回
				}

				//正式客户不发资源池请求
				if (row.state == 0) {
					$.messager.alert('温馨提示', '正式客户不能删除哦!', 'info');
					return;
				}
				//潜在客户不发资源池请求
				if (row.state == -1) {
					$.messager.alert('温馨提示', '潜在客户不能删除哦!', 'info');
					return;
				}

				if (row) {
					$.messager.confirm('温馨提示', '您确定要删除该行数据吗?', function(r) {
						if (r) {
							$.post('/customer/delete', {
								id : row.id
							}, function(result) {
								//期望返回成功与否，如果有错需要返回错误提示信息 {"success":true,"message":"xxxx"}
								//可以封装一个类AjaxResult，里面有两个属性
								if (result.success) {
									//给个提示信息
									$.messager.alert('温馨提示', '删除成功', 'info');
									//刷新界面
									customerDataGrid.datagrid('reload');
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
			if (cmd && !$(this).hasClass("l-btn-disabled")) {
				cmdObj[cmd]();
			}
		});
	})
	
	
	//工作流操作时用于显示的Fomatter
	function oprFomatter(v,r,i){
		
		//不是跳转页面，而是发一个Ajax请求，响应回来后弹框提示即可
		if (r.state==-1) {//只有初始录入才能报备
			return "<a href='javascript:startProcess("+r.id+")' style='color:blue'>启动流程</a>";
		}else{
			return "启动流程";
		}
	}
	
	function startProcess(id){
		var url = "/customer/startProcess?businessObjId="+id;
		
		$.messager.confirm("操作提示","您确认启动流程吗?",function(b){
			if(b){
				//发起ajax请求完成启动流程
				$.get(url,function(data){
							//返回值是AjaxResult转换结果
							if (data.success) {
								//提示
								$.messager.alert("温馨提示","流程启动成功！","info");
								//刷新表格
								$('#customerDataGrid').datagrid("reload");
							}
							else{
								//提示
								$.messager.alert("温馨提示",data.message,"error");
							}
						  },"json");
			}
		})
	
	}
</script>

</head>
<body>
	<!-- 1 datagrid -->
	<table id="customerDataGrid" title="潜在客户列表" class="easyui-datagrid"
		fit="true" url="/customer/list" toolbar="#customerDataGridToolbar"
		pagination="true" rownumbers="true" fitColumns="true"
		singleSelect="true">
		<thead>
			<tr>
				
				<th field="name" width="50"">客户姓名</th>
				<th field="age" width="50">客户年龄</th>
				<th field="gender" width="50" formatter="genderFormatter">客户性别</th>
				<th field="tel" width="50">电话号码</th>
				<th field="email" width="50">邮箱</th>
				<th field="qq" width="50">QQ</th>
				<th field="wechat" width="50"">微信</th>
				<th field="inputTime" width="50">创建时间</th>
				<th field="seller" width="50" formatter="objFormatter">销售人员</th>
				<th field="job" width="50" formatter="dataFormatter">职业</th>
				<th field="salaryLevel" width="50" formatter="dataFormatter">收入水平</th>
				<th field="customerSource" width="50" formatter="dataFormatter">客户来源</th>
				<th field="inputUser" width="50" formatter="objFormatter">创建人</th>
				<th field="state" width="50" formatter="customerStateFormatter">客户状态</th>
				
				<th field="opr" width="50" formatter="oprFomatter">操作</th>
			</tr>
		</thead>
	</table>
	<!-- 2 toolBar -->
	<div id="customerDataGridToolbar">
		<a data-cmd="customerAdd" href="javascript:void(0)"
			class="easyui-linkbutton c2" iconCls="icon-add" plain="true">新增</a> <a
			data-cmd="customerEdit" href="javascript:void(0)"
			class="easyui-linkbutton c3" iconCls="icon-edit" plain="true">修改</a>
		<a data-cmd="customerDelete" href="javascript:void(0)"
			class="easyui-linkbutton c4" iconCls="icon-remove" plain="true">删除</a>
		<a data-cmd="customerRefresh" href="javascript:void(0)"
			class="easyui-linkbutton c5" iconCls="icon-reload" plain="true">刷新</a>
		<a data-cmd="customerTrace" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-tip" plain="true">跟进</a> <a
			data-cmd="customerTransfer" href="javascript:void(0)"
			class="easyui-linkbutton c7" iconCls="icon-redo" plain="true">移交</a>
		<a data-cmd="customerPutResourcePool" href="javascript:void(0)"
			class="easyui-linkbutton c8" iconCls="icon-cancel" plain="true">放入资源池</a>
		<a data-cmd="customerSourceReport" href="javascript:void(0)"
			class="easyui-linkbutton c1" iconCls="icon-sum" plain="true">客户来源报表</a>

		<form action="#" id="customerSearchForm">
			<!-- 关键字，状态 -->
			关键字：<input id="q" type="text" name="q"> 客户状态：<select
				name="state" id="state">
				<option value="-2">--请选择--</option>
				<option value="0">正式客户</option>
				
				<option value="3">无法跟进客户</option>
			</select> <a data-cmd="customerSearch" href="javascript:void(0)"
				class="easyui-linkbutton c1" iconCls="icon-search" plain="true">查询</a>
			<a data-cmd="customerAdvancedSearch" href="javascript:void(0)"
				class="easyui-linkbutton c7" iconCls="icon-search" plain="true">高级查询</a>
		</form>
	</div>

	<!-- 3 添加或编辑对话框 -->
	<div id="customerDialog" class="easyui-dialog" style="width: 400px ; height:300px"
		closed="true" buttons="#customerDialogButtons" >
		<form id="customerDialogForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<!--由于添加和编辑对话框是通过一个Form，以隐藏域的方式区分是添加还是修改 -->
			<input type="hidden" name="id">
				<table>
					<tr>
						<td>客户姓名</td>
						<td><input type="text" name="name" class="easyui-validatebox" required ="true"/></td>
					</tr>
					<tr>
						<td>客户年龄</td>
						<td><input type="text" name="age" class="easyui-numberbox" required ="true"/></td>
					</tr>
					<tr>
						<td>客户性别</td>
						<td>
						男:<input name="gender" type="radio" value="1">&nbsp;&nbsp;
						女:<input name="gender" type="radio" value="-1">&nbsp;&nbsp;
					       嘿嘿嘿:<input name="gender" type="radio" value="0">
						</td>
					</tr>
					<tr>
						<td>电话号码</td>
						<td><input type="text" name="tel" class="easyui-numberbox" required ="true"/></td>
					</tr>
					<tr>
						<td>邮箱</td>
						<td><input type="text" name="email" /></td>
					</tr>

					<tr>
						<td>QQ</td>
						<td><input type="text" name="qq" class="easyui-numberbox"/></td>
					</tr>
					<tr>
						<td>微信</td>
						<td><input type="text" name="wechat" /></td>
					</tr>
					<tr>
						<td>创建时间</td>
						<td><input type="text" name="inputTime" class= "easyui-datebox" required ="true"/></td>
					</tr>

					<tr>
						<td>客户状态</td>
						<td><select id="q" name="state" class="easyui-combobox required ="true""
							style="width: 145px;">
								<option value="-2">---请选择---</option>
								<option value="-1">潜在客户</option>
								<option value="0">正式客户</option>
								<option value="3">无法跟进客户</option>
						</select></td>
					</tr>
					<tr>
						<td>销售人员</td>
						<td><select id="ss" name="seller.id" style="width: 145px;" />
						</td>
					</tr>
					<tr>
						<td>职业</td>
						<td><select id="jj" name="job.id" style="width: 145px;" /></td>
					</tr>
					<tr>
						<td>收入水平</td>
						<td><select id="aa" name="salaryLevel.id"
							style="width: 145px;" /></td>
					</tr>
					<tr>
						<td>客户来源</td>
						<td><select id="dd" name="customerSource.id"
							style="width: 145px;"  required ="true"/></td>
					</tr>
					<tr>
						<td>创建人:</td>
						<td><select id="cc" name="inputUser.id" style="width: 145px;" required ="true"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<!-- 4 添加或编辑对话框buttons -->
		<div id="customerDialogButtons">
			<a data-cmd="customerSave" href="javascript:void(0)"
				class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">保存</a>
			<a data-cmd="customerCancel" href="javascript:void(0)"
				class="easyui-linkbutton" iconCls="icon-cancel"
				style="width: 90px">取消</a>
		</div>

		<!-- 5 高级查询对话框 -->
		<div id="customerQueryDialog" class="easyui-dialog"
			style="width: 400px" closed="true"
			buttons="#customerQueryDialogButtons">
			<form id="customerQueryDialogForm" method="post" novalidate
				style="margin: 0; padding: 20px 50px">
				<!--由于添加和编辑对话框是通过一个Form，以隐藏域的方式区分是添加还是修改 -->

				<table>
					<table>

						<tr>
							<td>关键字</td>
							<td><input type="q" name="q" /></td>
						</tr>

						<tr>
							<td>客户状态</td>
							<td><select id="q" name="state" class="easyui-combobox"
								style="width: 145px;">
									<option value="-2">--请选择--</option>
									<option value="-1">潜在客户</option>
									<option value="0">正式客户</option>
							
									<option value="3">无法跟进客户</option>
							</select></td>
						</tr>
						<tr>
							<td>销售人员</td>
							<td><select id="sss" name="sellerId" style="width: 145px;" />
							</td>
						</tr>
						<tr>
							<td>职业</td>
							<td><select id="jjj" name="jobId" style="width: 145px;" />
							</td>
						</tr>
						<tr>
							<td>收入水平</td>
							<td><select id="aaa" name="salaryLevelId"
								style="width: 145px;" /></td>
						</tr>
						<tr>
							<td>客户来源</td>
							<td><select id="ddd" name="customerSourceId"
								style="width: 145px;" /></td>
						</tr>
						<tr>
							<td>创建人:</td>
							<td><select id="ccc" name="inputUserId"
								style="width: 145px;" /></td>
						</tr>
					</table>
				</form>
			</div>
			<!-- 6 高级查询对话框buttons -->
			<div id="customerQueryDialogButtons">
			<a data-cmd="customerQuerySave" href="javascript:void(0)"
					class="easyui-linkbutton c6" iconCls="icon-ok"
					style="width: 90px">确认</a> <a data-cmd="customerQueryCancel"
					href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-cancel" style="width: 90px">取消</a>
			</div>

			<!-- 7 移交对话框 -->
			<div id="customerTransferDialog" class="easyui-dialog"
				style="width: 400px" closed="true"
				buttons="#customerTransferDialogButtons">
				<form id="customerTransferDialogForm" method="post" novalidate
					style="margin: 0; padding: 20px 50px">
					<!--由于添加和编辑对话框是通过一个Form，以隐藏域的方式区分是添加还是修改 -->

					<table>
						<table>

							<tr>
								<td>被移交客户</td>
								<td><input type="name" name="name" /></td>
							</tr>
							<tr>
								<td>老市场专员:</td>
								<td><input id="BB" name="oldSeller.id"
									class="easyui-combobox" style="width: 140px;"
									readonly="value" /></td>
							</tr>
							<tr>
								<td>新市场专员:</td>
								<td><select id="AA" name="newSeller.id"
									class="easyui-combobox" style="width: 140px;" /></td>
							</tr>
							<tr>
								<td>移交原因:</td>
								<td><textarea rows="3" cols="21" name="transReason"
										style="width: 140px;"></textarea></td>
							</tr>
						</table>
					</form>
				</div>
				<!--  移交对话框buttons -->
				<div id="customerTransferDialogButtons">
					<a data-cmd="customerTransferSave" href="javascript:void(0)"
						class="easyui-linkbutton c6" iconCls="icon-ok"
						style="width: 90px">移交</a> <a data-cmd="customerTransferCancel"
						href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-cancel" style="width: 90px">取消</a>
				</div>
				
				<!-- 8 跟进对话框 -->
			<div id="customerTraceDialog" class="easyui-dialog"
				style="width: 400px" closed="true"
				buttons="#customerTraceDialogButtons">
				<form id="customerTraceDialogForm" method="post" novalidate
					style="margin: 0; padding: 20px 50px">
					<!--由于添加和编辑对话框是通过一个Form，以隐藏域的方式区分是添加还是修改 -->

					<table>
						<table>

							<tr>
						<td>跟进时间</td>
						<td><input type="text" name="traceTime" /></td>
					</tr>
					<tr>
						<td>跟进效果</td>
						<td><select id="q" name="traceResult" class="easyui-combobox"
							style="width: 145px;">
								<option value="-2">---请选择---</option>
								<option value="-1">差</option>
								<option value="0">中</option>
								<option value="1">优</option>
						</select>
					</tr>
					<tr>
						<td>跟进主题</td>
						<td><input type="text" name="title" /></td>
					</tr>
					<tr>
						<td>备注</td>
						<td><input type="text" name="remark" /></td>
					</tr>
					
					<tr>
						<td>客户:</td>
						<td><select id="CC" name="customer.id" style="width: 145px;" />
						</td>
					</tr>
					<tr>
						<td>跟进人:</td>
						<td><select id="DD" name="traceUser.id" style="width: 145px;" />
						</td>
					</tr>
						
					<tr>
						<td>跟进方式</td>
						<td><select id="EE" name="traceType.id" style="width: 145px;">
							</td>
					</tr>
						</table>
					</form>
				</div>
				<!--  跟进对话框buttons -->
				<div id="customerTraceDialogButtons">
					<a data-cmd="customerTraceSave" href="javascript:void(0)"
						class="easyui-linkbutton c6" iconCls="icon-ok"
						style="width: 90px">确认</a> <a data-cmd="customerTraceCancel"
						href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-cancel" style="width: 90px">取消</a>
				</div>

				<div id="3dDlg" class="easyui-dialog" style="width: 500px"
					closed="true">

					<div id="container" style="height: 350px"
						formatter="customerFormatters"></div>

				</div>
</body>
</html>