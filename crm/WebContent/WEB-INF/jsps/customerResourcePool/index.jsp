<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 导入公共jsp,里面导入了easyui相关的资源 -->
<%@include file="/WEB-INF/jsps/common.jsp"%>
<title>Insert title here</title>
<script type="text/javascript">
	$(function() {
		//1.定义easyui对象的变量;
		var customerDatagrid, customerDatagridDlg, customerDatagridDlgForm;
		//给每个对象变量赋值;
		customerDatagrid = $("#customerDatagrid");
		customerDatagridDlg = $('#customerDatagridDlg');
		customerQueryDatagridDlg = $('#customerQueryDatagridDlg');
		customerDatagridDlgForm=$('#customerDatagridDlgForm');
		customerQueryDatagridDlgForm=$('#customerQueryDatagridDlgForm');
		//初始化表格
		customerDatagrid.datagrid({});
		

		//2.把a标签的监听抽取出来,成一个json对象
		var cmdObj = {
			"customerRefresh" : function() {
				customerDatagrid.datagrid("reload");
			},
			
			"customerAdd":function() {
				customerDatagridDlg.dialog('open').dialog('center').dialog('setTitle', '添加客户');
				customerDatagridDlgForm.form('clear');
				
				//加载外键数据
				$('#cc').combobox({    
        		    url: '/customer/queryEmployee',
        		    valueField:'id',    
				    textField:'text'   
        		});
				$('#cc2').combobox({    
        		    url: '/customer/queryEmployee',
        		    valueField:'id',    
				    textField:'text'   
        		});
				
				$('#dd').combobox({    
        		    url: '/customer/querySystemDictionaryItem',
        		    valueField:'id',    
				    textField:'text'   
        		});
				$('#dd2').combobox({    
        		    url: '/customer/querySystemDictionaryItem',
        		    valueField:'id',    
				    textField:'text'   
        		});
				$('#dd3').combobox({    
        		    url: '/customer/querySystemDictionaryItem',
        		    valueField:'id',    
				    textField:'text'   
        		});
				
			},
			
			//编辑-打开一个对话框
			"customerEdit":function() {
				//获取选中红
				var row = customerDatagrid.datagrid('getSelected');
				//没有选中
				if (!row) {
					$.messager.alert('温馨提示', '请选中一行后,再操作!', 'error');
					return;
				}
				customerDatagridDlg.dialog('open').dialog('center').dialog('setTitle', '编辑客户');
				customerDatagridDlgForm.form('clear');
				//做回显
				customerDatagridDlgForm.form('load', row);
				
				//编辑重新加载
				$('#cc').combobox({    
        		    url: '/customer/queryEmployee',
        		    valueField:'id',    
				    textField:'text'   
        		});
				
				//回显外键
				if(row.inputUser){
	           	 	$('#cc').combobox('setValue', row.inputUser.id);
	            }
				
				$('#cc2').combobox({    
        		    url: '/customer/queryEmployee',
        		    valueField:'id',    
				    textField:'text'   
        		});
				
				//回显外键
				if(row.seller){
	           	 	$('#cc2').combobox('setValue', row.seller.id);
	            }
				
				$('#dd').combobox({    
        		    url: '/customer/querySystemDictionaryItem',
        		    valueField:'id',    
				    textField:'text'   
        		});
				
				//回显外键
				if(row.job){
	           	 	$('#dd').combobox('setValue', row.job.id);
	            }
				
				$('#dd2').combobox({    
        		    url: '/customer/querySystemDictionaryItem',
        		    valueField:'id',    
				    textField:'text'   
        		});
				
				//回显外键
				if(row.salaryLevel){
	           	 	$('#dd2').combobox('setValue', row.salaryLevel.id);
	            }
				$('#dd3').combobox({    
        		    url: '/customer/querySystemDictionaryItem',
        		    valueField:'id',    
				    textField:'text'   
        		});
				
				//回显外键
				if(row.customerSource){
	           	 	$('#dd3').combobox('setValue', row.customerSource.id);
	            }
				
			},
			
			//取消
			"customerCancel":function() {
				customerDatagridDlg.dialog('close');
			},
			//取消
			"customerQueryCancel":function() {
				customerQueryDatagridDlg.dialog('close');
			},
			
			"customerSave":function(){
				
				customerDatagridDlgForm.form('submit',{
		            url: "/customer/add",
		            success: function(result){
		            	 //提交表单获取到的字符串
		                var result = $.parseJSON(result);
		            	 
		                if (result.success){
		                	//保存成功给出提示,并重新加载表格
		                	customerDatagridDlg.dialog('close');
		               	 	$.messager.alert('温馨提示','保存成功!','info');
		               	 customerDatagrid.datagrid('reload');
		                } else {
		                	//保存失败给出提示,并重新加载表格
		                	customerDatagridDlg.dialog('close');
			               	 $.messager.alert('温馨提示',result.message,'error');
			               	customerDatagrid.datagrid('reload');
		                }
		            }
		        });
			},
			
			//高级查询
			"customerQuery":function(){
				
				customerQueryDatagridDlg.dialog('open').dialog('center').dialog('setTitle', '查询客户');
				customerDatagridDlgForm.form('clear');
				//加载外键数据
				$('#cc3').combobox({    
        		    url: '/customer/queryEmployee',
        		    valueField:'id',    
				    textField:'text'   
        		});
				$('#cc4').combobox({    
        		    url: '/customer/queryEmployee',
        		    valueField:'id',    
				    textField:'text'   
        		});
				
				$('#dd4').combobox({    
        		    url: '/customer/querySystemDictionaryItem',
        		    valueField:'id',    
				    textField:'text'   
        		});
				$('#dd5').combobox({    
        		    url: '/customer/querySystemDictionaryItem',
        		    valueField:'id',    
				    textField:'text'   
        		});
				$('#dd6').combobox({    
        		    url: '/customer/querySystemDictionaryItem',
        		    valueField:'id',    
				    textField:'text'   
        		});
				
			},
			
			//高级查询确认
			"customerQuerySure":function(){
				var param= $("#customerQueryDatagridDlgForm").serializeForm();
				console.debug(param);
				customerDatagrid.datagrid("load",param);
			},
			
			//简单查询
			"search":function(){
				//1 手动拼接json参数
			/*	var q =$("#q").val();
				var status = $("#status").val();
				//重新加载表格数据,并且传入参数
				customerDatagrid.datagrid("load",{
					"q":q,
					"status":status
				}),  */
				
				//2 自动把form转换为Json
				//3.封装到JQuery原型上面
				var param=$("#searchForm").serializeForm();
				customerDatagrid.datagrid("load",param);
				
			},
			
		
			//资源池
			"customerResourcePool" : function() {
				//获取选中行
				var row = customerDatagrid.datagrid('getSelected');
				//没有选中
				if (!row) {
					$.messager.alert('温馨提示', '请选中一行后,再操作!', 'error');
					return;
				}
				console.debug(row.name);
				
				
				//$.messager.alert('警告', '警告消息');
				$.messager.confirm('温馨提示', '您确认要将' + '<font style="color:red" size="2px">'+'{'+ row.name +'}' + '</font>' + '放入资源池吗？', function(r) {
					if (r) {
						
						//将选中客户保存到资源池
						var data = {
							"name" : row.name,
							"gender" : row.gender,
							"tel" : row.tel,
							"seller" : row.seller.id,
							"customerSource" : row.customerSource.id,
							"state" : row.state,
							"inputTime" : row.inputTime
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
								id : row.id
							}, function(result) {
								/* if (result.success) {
									//删除成功给出提示,并重新加载表格
									$.messager.alert('温馨提示', '删除成功!', 'info');
									customerDatagrid.datagrid('reload');
								} else {
									//删除成功给出提示,并重新加载表格
									$.messager.alert('温馨提示', result.message,
											'error');
									customerDatagrid.datagrid('reload');
								} */
							}, 'json');
						//customerDatagrid.datagrid('reload');

					}
				});
			},

			//删除
			"customerDel" : function() {
				//获取选中红
				var row = customerDatagrid.datagrid('getSelected');
				//没有选中
				if (!row) {
					$.messager.alert('温馨提示', '请选中一行后,再操作!', 'error');
					return;
				}
				if (row) {
					$.messager.confirm('温馨提示', '您确认删除改行数据吗?', function(r) {
						if (r) {
							//传入参数 id
							//返回值  只关心成功与否,失败后的提示信息{success:true,message:"删除失败!"}
							$.post('/customer/delPool', {
								id : row.id
							}, function(result) {
								if (result.success) {
									//删除成功给出提示,并重新加载表格
									$.messager.alert('温馨提示', '删除成功!', 'info');
									customerDatagrid.datagrid('reload');
								} else {
									//删除成功给出提示,并重新加载表格
									$.messager.alert('温馨提示', result.message,
											'error');
									customerDatagrid.datagrid('reload');
								}
							}, 'json');
						}
					});
				}
			}
		};

		//监听所有的a标签 
		$("a[data-cmd]").click(function() {
			var cmd = $(this).data("cmd");
			console.debug(cmd);
			if (cmd) {
				cmdObj[cmd]();
			}
		})

	})
</script>
</head>
<body>
	<!-- 管理表格 -->
	<table id="customerDatagrid" title="客户资源池管理" class="easyui-datagrid"
		url="/customer/listPool" toolbar="#customerDatagridToolbar" pagination="true" 
		rownumbers="true" fitColumns="true" singleSelect="true" fit="true">
	
		<thead>
			<tr>
				
				<th field="id" width="50">编号</th>
				<th field="name" width="50">名称</th>
				<th field="gender" width="50" formatter="genderFormatter">性别</th>
				<th field="tel" width="50">电话号码</th>
				<th field="customerSource" width="50" formatter="objFormatter">客户来源</th> 
				<th field="inputTime" width="50" >创建时间</th> 
				<th field="seller" width="50" formatter="objFormatter">营销人员</th>
				<!-- <th field="state" width="50" formatter="customerFormatter">状态</th> -->
			</tr>
		</thead>
	</table>

	 <!-- 管理表格ToolBar -->
	 <div id="customerDatagridToolbar">
        <a data-cmd="customerRefresh" href="javascript:void(0)" class="easyui-linkbutton c1" iconCls="icon-reload" plain="true">刷新</a>
        <a data-cmd="customerDel" href="javascript:void(0)" class="easyui-linkbutton c2" iconCls="icon-reload" plain="true">删除</a>
        <form id="searchForm">
        	关键字:<input id="q" type="text" name="q" class="easyui-textbox"/>
        	<a data-cmd="search" href="javascript:void(0)" class="easyui-linkbutton c3" iconCls="icon-search" plain="true">查询</a>
        	<a data-cmd="customerQuery" href="javascript:void(0)" class="easyui-linkbutton c4" iconCls="icon-search" plain="true">高级查询</a>
        </form>
    </div>

	<!-- 添加或编辑对话框 -->
	<div id="customerDatagridDlg" class="easyui-dialog" style="width: 400px"
		closed="true" buttons="#customerDatagridDlgButtons">
		<form id="customerDatagridDlgForm" method="post" novalidate
			style="margin: 0; padding: 20px 40px">
			<!-- 区分是添加还是编辑 -->
			<input type="hidden" name="id" />
			
			<table>
				<tr>
					<td>客户名称:</td>
					<td><input name="name" class="easyui-textbox" ></td>
				</tr>
				<tr>
					<td>性别:</td>
					<td>
						<select id="gender" class="easyui-combobox" name="gender" style="width:145px;">   
						    <option value="-2">---请选择---</option>
			        		<option value="0">未知</option>
			        		<option value="-1">女</option>  
			        		<option value="1">男</option>  
						</select> 
					</td>
				</tr>
				<tr>
					<td>年龄:</td>
					<td><input name="age" class="easyui-textbox" ></td>
				</tr>
				<tr>
					<td>联系电话:</td>
					<td><input name="tel" class="easyui-textbox" ></td>
				</tr>
				<tr>
					<td>邮箱:</td>
					<td><input name="email" class="easyui-textbox"></td>
				</tr>
				<tr>
					<td>QQ:</td>
					<td><input name="qq" class="easyui-textbox"></td>
				</tr>
				<tr>
					<td>微信:</td>
					<td><input name="wechat" class="easyui-textbox"></td>
				</tr>
				
				<tr>
					<td>创建时间:</td>
					<td>
					<input name="inputTime"  type= "text" class= "easyui-datebox" > </input>  
					</td>
				</tr>
				<tr>
					<td>客户状态:</td>
					<td>
						<select id="state" name="state" class="easyui-combobox" style="width:145px">
			        		<option value="-2">--请选择--</option>
			        		<option value="0">潜在客户</option>
			        		<option value="1">正式客户</option>
        				</select> 
					</td>
				</tr>
				
				<tr>
					<td>创建人:</td>
					<td>
					<select id="cc" name="inputUser.id" style="width:145px;"/>
					</td>
				</tr>
				<tr>
					<td>工作:</td>
					<td>
					<select id="dd" name="job.id" style="width:145px;"/>
					</td>
				</tr>
				<tr>
					<td>收入水平:</td>
					<td>
					<select id="dd2" name="salaryLevel.id" style="width:145px;"/>
					</td>
				</tr>
				<tr>
					<td>营销人员:</td>
					<td>
					<select id="cc2" name="seller.id" style="width:145px;"/>
					</td>
				</tr>
				
				<tr>
					<td>客户来源:</td>
					<td>
					<select id="dd3" name="customerSource.id" style="width:145px;"/>
					</td>
				</tr>
			</table>
		</form>
	</div>

	<!-- 添加或编辑对话框按钮 -->
	<div id="customerDatagridDlgButtons">
		<a data-cmd="customerSave" href="javascript:void(0)" class="easyui-linkbutton color-blue" iconCls="icon-ok" style="width: 90px">保存</a>
		<a data-cmd="customerCancel" href="javascript:void(0)" class="easyui-linkbutton color-darkblue" iconCls="icon-cancel">取消</a>
	</div>
	
	
	<!--查询弹出框  -->
		<div id="customerQueryDatagridDlg" class="easyui-dialog" style="width: 400px"
		closed="true" buttons="#customerQueryDatagridDlgButtons">
		<form id="customerQueryDatagridDlgForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<table>
				<tr>
					<td>关键字:</td>
					<td><input id="q" type="text" name="q" class="easyui-textbox"/></td>
				</tr>
				<tr>
					<td>性别:</td>
					<td>
						<select id="gender" class="easyui-combobox" name="gender" style="width:145px;">   
						    <option value="-2">---请选择---</option>
			        		<option value="0">未知</option>
			        		<option value="-1">女</option>  
			        		<option value="1">男</option>  
						</select> 
					</td>
				</tr>
				
				<tr>
					<td>年龄:</td>
					<td><input  type="text" name="age" class="easyui-textbox"/></td>
				</tr>
				
 				<tr> 
					<td>开始时间:</td> 
					<td><input  name="beginTime"  type= "text" class= "easyui-datebox" ></td>
				</tr> 
 				<tr> 
					<td>结束时间:</td> 
					<td><input  name="endTime"  type= "text" class= "easyui-datebox" ></td>
				</tr> 
				
				<!-- 第二个弹出框,需要加载外键,id不能与第一个弹出框定义的id相同 -->
				<tr>
					<td>创建人:</td>
					<td><select id="cc3" name="inputUserId" style="width:145px;"/></td>
				</tr>
				<tr>
					<td>营销人员:</td>
					<td><select id="cc4" name="sellerId" style="width:145px;"/></td>
				</tr>
				
				<tr>
					<td>客户来源:</td>
					<td><select id="dd4" name="customerSourceId" style="width:145px;"/></td>
				</tr>
				<tr>
					<td>收入水平:</td>
					<td><select id="dd5" name="salaryLeveId" style="width:145px;"/></td>
				</tr>
				<tr>
					<td>工作:</td>
					<td><select id="dd6" name="jobId" style="width:145px;"/></td>
				</tr>
				
				<tr>
        			<td>状态:</td>
        			<td>
        				<select id="q" class="easyui-combobox" name="state" style="width:100px;">   
						    <option value="-2">---请选择---</option>
			        		<option value="0">潜在客户</option>
			        		<option value="1">正式客户</option>  
						</select> 
        			</td>
        		</tr>
			</table>
		</form>
	</div>

	<!-- 添加或编辑对话框按钮 -->
	<div id="customerQueryDatagridDlgButtons">
		<a data-cmd="customerQuerySure" href="javascript:void(0)" class="easyui-linkbutton color-violet" iconCls="icon-ok" style="width: 90px">确认</a>
		<a data-cmd="customerQueryCancel" href="javascript:void(0)" class="easyui-linkbutton color-purple" iconCls="icon-cancel">取消</a>
	</div>
	
	<!--放入资源池  -->
		<form id="customerSourcePoolDlgForm" method="post" novalidate
			style="margin: 0; padding: 20px 40px">
			<input type="hidden" name="id" />
			
			<table>
				<tr>
					<td>客户名称:</td>
					<td><input name="customer.id" class="easyui-textbox" ></td>
				</tr>
				<tr>
					<td>性别:</td>
					<td>
						<select id="gender" class="easyui-combobox" name="gender" style="width:145px;">   
						    <option value="-2">---请选择---</option>
			        		<option value="0">未知</option>
			        		<option value="-1">女</option>  
			        		<option value="1">男</option>  
						</select> 
					</td>
				</tr>
				
				<tr>
					<td>联系电话:</td>
					<td><input name="tel" class="easyui-textbox" ></td>
				</tr>
				
				<tr>
					<td>移交时间:</td>
					<td>
					<input name="transferDate"  type= "text" class= "easyui-datebox" > </input>  
					</td>
				</tr>
				<tr>
					<td>状态:</td>
					<td>
						<select id="state" name="state" class="easyui-combobox" style="width:145px">
			        		<option value="-2">--请选择--</option>
			        		<option value="0">潜在客户</option>
			        		<option value="1">正式客户</option>
        				</select> 
					</td>
				</tr>
				
				<tr>
					<td>营销人员:</td>
					<td>
					<select id="A" name="seller.id" style="width:145px;"/>
					</td>
				</tr>
				<tr>
					<td>客户来源:</td>
					<td>
					<select id="dd3" name="customerSource.id" style="width:145px;"/>
					</td>
				</tr>
			</table>
		</form>
	</div>

    
    
	
	
	
	
	
	
	
</body>
</html>