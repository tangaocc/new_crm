<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 导入公共jsp,里面导入了easyui相关的资源 -->
<%@include file="/WEB-INF/jsps/common.jsp"%>
<!-- 展示明细要用 -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/easyui/datagrid-detailview.js"></script>
<title>保修管理</title>
<script type="text/javascript">
	$(function() {

		// 1、声明出页面需要使用的组件
		var repairDatagrid, repairDatagridDlg, repairDatagridDlgForm,cg,repairSearchDatagridDlg,repairSearchDatagridDlgForm;
		// 2、把页面的组件，缓存到上面声明的变量中
		repairDatagrid = $("#repairDatagrid");
		repairDatagridDlg = $("#repairDatagridDlg");
		repairDatagridDlgForm = $("#repairDatagridDlgForm");
		cg = $("#cg");
		repairSearchDatagridDlg = $("#repairSearchDatagridDlg");
		repairSearchDatagridDlgForm = $("#repairSearchDatagridDlgForm");

		// 3、初始化组件，修改组件的值
		var grid = cg.combogrid("grid");
		var pager = grid.datagrid("getPager");
		pager.pagination({
			"showRefresh":false,
		});
		// 4、创建一个"命令对象"，把当前模块所有的功能，都打包到这个对象上
		var cmdObj = {
			"repairRefresh" : function() {
				repairDatagrid.datagrid("reload");
			},
			"repairAdd" : function() {
				repairDatagridDlg.dialog('open').dialog('center').dialog(
						'setTitle', '添加保修');
				repairDatagridDlgForm.form('clear');
				$("#itemsDatagrid").datagrid('loadData', {total:0, rows:[]});
				$('#sel').combobox({
					url : '/employee/list',
					valueField : 'id',
					textField : 'text'
				});
			},
			"repairEdit" : function() {
				//获取选中红
				var row = repairDatagrid.datagrid('getSelected');
				//没有选中
				if (!row) {
					$.messager.alert('温馨提示', '请选中一行后,再操作!', 'error');
					return;
				}
				$('#itemsDatagrid').datagrid({'url':'/repair/getItems?id='+row.id});
				
				repairDatagridDlg.dialog('open').dialog('center').dialog(
						'setTitle', '编辑保修单');
				
				repairDatagridDlgForm.form('clear');
				
				repairDatagridDlgForm.form('load', row);
				console.debug(row);
				$('#sel').combobox({
					url : '/employee/list',
					valueField : 'id',
					textField : 'text'
				});
				if(row.seller){
					$("#sel").combobox("select", row.seller.id);
				}
				if(row.signTime){
					$("#signTime").datebox("setValue", row.signTime);
				}
				if (row.customer) {
					console.debug(row.customer);
					cg.combogrid("setValue",row.customer.id);
				}
			},
			"repairCancel" : function() {
				repairDatagridDlg.dialog('close');
			},
			"repairSave" : function() {

				repairDatagridDlgForm.form('submit', {
					url : "/repair/save",
					onSubmit : function(param) {
						var rows = $('#itemsDatagrid').datagrid('getRows');
						if (rows.length == 0) {
							$.messager.alert('提示信息', '请至少输入一个保修明细', 'warning');
							return false;
						}
						for (var i = 0; i < rows.length ; i++) {
                        	//保存之前进行数据的校验 , 然后结束编辑并初始化编辑状态字段
                      		if($('#itemsDatagrid').datagrid('validateRow',i)){
                          	 	$('#itemsDatagrid').datagrid('endEdit', i);
                      		} else {
                      			$.messager.alert('提示信息', '保修明细的输入格式不正确', 'warning');
    							return false;
                      		}
                        	console.debug(rows[i]+"--------------");
                        	param['items['+i+'].repairTime'] = rows[i].repairTime;
                        	param['items['+i+'].repairText'] = rows[i].repairText;
                        	param['items['+i+'].settle'] = rows[i].settle;
                        	console.debug(rows[i].repairTime);
                        	console.debug(rows[i].repairText);
                        	console.debug(rows[i].settle);
						}
						repairDatagridDlg.dialog('close');
						repairDatagrid.datagrid('reload');
						$.messager.alert('温馨提示', '保存成功!', 'info');
						return $(this).form('validate');
					}
					
				})
			},
			"repairDel" : function() {
				//获取选中红
				var row = repairDatagrid.datagrid('getSelected');
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
							$.post('/repair/delete', {
								id : row.id
							}, function(result) {
								if (result.success) {
									//删除成功给出提示,并重新加载表格
									$.messager.alert('温馨提示', '删除成功!', 'info');
									repairDatagrid.datagrid('reload');
								} else {
									//删除成功给出提示,并重新加载表格
									$.messager.alert('温馨提示', result.message,
											'error');
									repairDatagrid.datagrid('reload');
								}
							}, 'json');
						}
					});
				}
			},
			"searchForm": function() {
				//console.debug(employeeSearchForm.serializeArray());
				//console.debug(employeeSearchForm.serialize());
				var paramObj = $("#repairSearchForm").serializeForm();
				// 调用datagrid的load方法，load只能加载json对象数据
				repairDatagrid.datagrid("load",paramObj);
			},
			"advanceSearch":function(){
				repairSearchDatagridDlg.dialog('open').dialog('center').dialog('setTitle', '高级查询');
			},
			"repairSearchCancel":function(){
				repairDatagridDlgForm.form('clear');
				repairSearchDatagridDlg.dialog('close');
			},
			"repairSearchSave":function(){
				var paramObj = repairSearchDatagridDlgForm.serializeForm();
				// 调用datagrid的load方法，load只能加载json对象数据
				repairDatagrid.datagrid("load",paramObj);
			},
			"searchFormClear":function(){
				$("#repairSearchForm").form("clear");
				location.reload();
			}
		};
		// 5、对页面所有按钮，统一监听
		//$("a[data-cmd]") 有data-cmd属性的a标签
		$("a[data-cmd]").click(function() {
			//区分到底是哪个A 通过a标签上面的data-cmd属性
			//data-cmd="repairAdd" html的语法data-xxx
			//Jquery提供一个data方法通过xxx获取它属性值
			var cmd = $(this).data("cmd");
			// 		   if(cmd=="repairAdd"){
			// 			   cmdObj.repairAdd();
			// 		   }
			// 		   else if(cmd=="repairEdit"){
			// 			   cmdObj.repairEdit();
			// 		   }

			if (cmd) {
				cmdObj[cmd]();
			}
		});
		repairDatagrid.datagrid({
            view: detailview,
            detailFormatter:function(index,row){
                return '<div style="padding:2px"><table class="ddv"></table></div>';
            },
            onExpandRow: function(index,row){
                var ddv = $(this).datagrid('getRowDetail',index).find('table.ddv');
                console.debug(row);
                console.debug(row.details);
                $(ddv).datagrid({
                    url:'/repair/getItems?id='+row.id,
//                     fitColumns:true,
                    singleSelect:true,
                    rownumbers:true,
                    loadMsg:'',
                    height:'auto',
                    columns:[[
                        {field:'repairTime',title:'保修时间',width:270},
                        {field:'repairText',title:'保修内容',width:270,align:'right'},
                        {field:'settle',title:'是否解决问题',formatter:settleFormatter,width:270,align:'right'}
                    ]],
                    onResize:function(){
                    	repairDatagrid.datagrid('fixDetailRowHeight',index);
                    },
                    onLoadSuccess:function(){
                    }
                });
                repairDatagrid.datagrid('fixDetailRowHeight',index);
            }
        
    	});
	})
	var editIndex = undefined;
        function endEditing(){
            if (editIndex == undefined){return true}
            if ($('#dg').datagrid('validateRow', editIndex)){
                $('#dg').datagrid('endEdit', editIndex);
                editIndex = undefined;
                return true;
            } else {
                return false;
            }
        }
        function onClickCell(index, field){
            if (editIndex != index){
                if (endEditing()){
                    $('#dg').datagrid('selectRow', index)
                            .datagrid('beginEdit', index);
                    var ed = $('#dg').datagrid('getEditor', {index:index,field:field});
                    if (ed){
                        ($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
                    }
                    editIndex = index;
                } else {
                    setTimeout(function(){
                        $('#dg').datagrid('selectRow', editIndex);
                    },0);
                }
            }
        }
        function onEndEdit(index, row){
            var ed = $(this).datagrid('getEditor', {
                index: index,
                field: 'productid'
            });
            row.productname = $(ed.target).combobox('getText');
        }
        function append(){
            if (endEditing()){
                $('#dg').datagrid('appendRow',{status:'P'});
                editIndex = $('#dg').datagrid('getRows').length-1;
                $('#dg').datagrid('selectRow', editIndex)
                        .datagrid('beginEdit', editIndex);
            }
        }
        function removeit(){
            if (editIndex == undefined){return}
            $('#dg').datagrid('cancelEdit', editIndex)
                    .datagrid('deleteRow', editIndex);
            editIndex = undefined;
        }
        function accept(){
            if (endEditing()){
                $('#dg').datagrid('acceptChanges');
            }
        }
        function reject(){
            $('#dg').datagrid('rejectChanges');
            editIndex = undefined;
        }
        function getChanges(){
            var rows = $('#dg').datagrid('getChanges');
            alert(rows.length+' rows are changed!');
        }
      //格式化状态显示
        function stateRepairFormatter(value, row, index) {
        	// 0表示正常,不是则不正常
        	return value == 0 ? "<span class='badge color-green' style='font-weight:bold;'>维修</span>": "<span class='badge color-red' style='font-weight:bold;'>过期</span>";
        }
      //是否解决问题
        function settleFormatter(value, row, index) {
        	// 0表示正常,不是则不正常
        	return value == 0 ? "<font style='color:green;font-weight:bold;'>已解决</font>": "<font style='color:red;font-weight:bold;'>未解决</font>";
        }
</script>
</head>
<body>
	<!-- 管理表格 -->
	<table id="repairDatagrid" title="保修单管理" class="easyui-datagrid"
		url="/repair/list" toolbar="#repairDatagridToolbar"
		pagination="true" rownumbers="true" fitColumns="true"
		singleSelect="true" fit="true">
		<thead>
			<tr>
				<th field="id" width="40">Id</th>
				<th field="sn" width="40">保修单号</th>
				<th field="repairTime" width="70">保修时间</th>
				<th field="state" formatter="stateRepairFormatter" width="40">保修状态</th>
				<th field="contract" formatter="objFormatter" width="40">合同单号</th>
				<th field="customer" formatter="objFormatter" width="40">保修客户</th>
			</tr>
		</thead>
	</table>


	<!-- 管理表格ToolBar -->
	<div id="repairDatagridToolbar">
		<a data-cmd="repairAdd" href="javascript:void(0)"
			class="easyui-linkbutton c2" iconCls="icon-add" plain="true">添加</a> <a
			data-cmd="repairEdit" href="javascript:void(0)"
			class="easyui-linkbutton c3" iconCls="icon-edit" plain="true">编辑</a>
		<a data-cmd="repairDel" href="javascript:void(0)"
			class="easyui-linkbutton c4" iconCls="icon-remove" plain="true">删除</a>
		<a data-cmd="repairRefresh" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-reload" plain="true">刷新</a>
		<div>
		</div>
	</div>

	<!-- 添加或编辑对话框 -->
	<div id="repairDatagridDlg" class="easyui-dialog"
		style="width: 500px; height: 400px" closed="true"
		buttons="#repairDatagridDlgButtons">
		<form id="repairDatagridDlgForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<!-- 区分是添加还是编辑 -->
			<input type="hidden" name="id" />
			<font style="font-weight:bold;">保修单</font>
			<hr>
			<br/>
			<table>
				<tr>
					<td>保修时间</td>
					<td><input name="repairTime" type="text" class="easyui-datebox"
						required="required"></td>
				</tr>
				<tr>
					<td>保修状态</td>
					<td><select id="state" name="state" class="easyui-combobox" style="width:126px;">
			        		<option value="0">过期</option>
			        		<option value="1">过期</option>
			        		<option value="2">维护</option>
        				</select></td>
				</tr>
				<tr>
					<td>保修客户</td>
					<td><select id="cg" class="easyui-combogrid"
						name="customer.id" style="width: 180px;"
						data-options="    
				            panelWidth:450,    
				            idField:'id', 
				            textField:'name',    
				            url:'/customer/list',   
				            fitColumns:true,
				            pagination:true,
				            columns:[[    
				                {field:'name',title:'客户姓名',width:60},    
				                {field:'age',title:'年龄',width:100},    
				                {field:'email',title:'邮箱',width:120},    
				                {field:'qq',title:'Qq',width:100}    
				            ]]    
        ">			</select>
					</td>
				</tr>
			<br/>
			</table>
			<font style="font-weight:bold;">保修单明细</font>
			<hr>
			<br/>
			<table id="itemsDatagrid">
			</table>
			<!-- 添加或编辑对话框按钮 -->
			<div id="repairDatagridDlgButtons">
				<a data-cmd="repairSave" href="javascript:void(0)"
					class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">保存</a>
				<a data-cmd="repairCancel" href="javascript:void(0)"
					class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
			</div>
			<!-- 添加或编辑对话框按钮 -->
			<div id="repairSearchDatagridDlgButtons">
				<a data-cmd="repairSearchSave" href="javascript:void(0)"
					class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">查询</a>
				<a data-cmd="repairSearchCancel" href="javascript:void(0)"
					class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
			</div>
		</form>
	</div>
	<!-- 高级查询对话框 -->
	<div id="repairSearchDatagridDlg" class="easyui-dialog"
		style="width: 400px" closed="true"
		buttons="#repairSearchDatagridDlgButtons">
		<form id="repairSearchDatagridDlgForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<table>
				<tr>
					<td>开始时间</td>
					<td><input name="beginTime" type="text" class="easyui-datebox">
						</input></td>
				</tr>
				<tr>
					<td>结束时间</td>
					<td><input name="endTime" type="text" class="easyui-datebox">
						</input></td>
				</tr>
				<tr>
					<td>定单金额</td>
					<td><input name="sum" class="easyui-textbox"></td>
				</tr>
				<tr>
					<td>摘要</td>
					<td><input name="q" class="easyui-textbox"></td>
				</tr>
				<!--         			 $('#cbb').combobox({     -->
				<!-- 	        		    url:'/repair/list',     -->

				<!-- 	        		    valueField:'id',     -->
				<!-- 	        		    textField:'text'    -->
				<!-- 	        		});   -->
				<tr>
					<td>订单客户</td>
					<td><select id="cg" class="easyui-combogrid" name="customerId"
						style="width: 180px;"
						data-options="    
				            panelWidth:450,    
				            idField:'id', 
				            textField:'name',    
				            url:'/customer/list',   
				            fitColumns:true,
				            pagination:true,
				            columns:[[    
				                {field:'name',title:'客户姓名',width:60},    
				                {field:'age',title:'年龄',width:100},    
				                {field:'email',title:'邮箱',width:120},    
				                {field:'qq',title:'Qq',width:100}    
				            ]]    
        "></select>
					</td>
				</tr>
				<tr>
					<td>营销人员</td>
					<td><input id="zzz" class="easyui-combobox" name="sellerId"
						data-options="valueField:'id',textField:'text',url:'/employee/list'" />
					</td>
				</tr>
			</table>
		</form>
	</div>
<script type="text/javascript">  
$(function(){
    var editing ; //判断用户是否处于编辑状态
    var flag  ;      //判断新增和修改方法
    $('#itemsDatagrid').datagrid({
                height: '200px',
                width: '400px',
                fitColumns: true  ,
                //url:'/repair/getItems?id=1' ,//数据来源
                striped: true ,       //            
                loadMsg: '数据正在加载,请耐心的等待...' ,
                rownumbers:true ,
                frozenColumns:[[
                        {field:'ck' , checkbox:true}                                    
                ]],
                columns:[[
                    {
                        field:'repairTime' ,
                        title:'保修时间' ,
                        width: '105px',
                        align:'center' ,
                        editor:{
                            type:'datebox' ,
                            options:{
                                required:true ,
                                missingMessage:'支付金额必填!'
                            }
                        }
                    },{
                        field:'repairText' ,
                        title:'保修内容' ,
                        width: '80px',
                        align:'center' ,
                        editor:{
                            type:'validatebox' ,
                            options:{
                                editable:true
                            }
                        }
                    },{
                        field:'settle' ,
                        width: '80px',
                        align:'center' ,
                        title:'是否解决问题' ,
                        formatter:function(value , record , index){
                            if(value == 0){
                                return '<span style=color:red; >已解决</span>' ;
                            } else if( value == 1){
                                return '<span style=color:green; >待支付</span>' ;
                            }
                        } ,
                        editor:{
                            type:'combobox' ,
                            options:{
                                data:[{id:1 , val:'已解决'},{id:0 , val:'待解决'}] ,
                                valueField:'id' ,
                                textField:'val' ,
                                required:true ,
                                missingMessage:'是否支付必填!'
                            }
                        }
                    },
                ]] ,
                onDblClickCell: function(index,field,value){
                	if($('#itemsDatagrid').datagrid('validateRow',editing)){
                        $('#itemsDatagrid').datagrid('endEdit', editing);
                        editing = undefined;
                        
                }
            		$(this).datagrid('beginEdit', index);
            		var ed = $(this).datagrid('getEditor', {index:index,field:field});
            		$(ed.target).focus();
            	},
                toolbar:[
                    {
                        text:'新增明细',
                        iconCls:'icon-add' ,
                        handler:function(){
                                     flag = 'add';
                                     //1 先取消所有的选中状态
                                     $('#itemsDatagrid').datagrid('unselectAll');
                                     //2追加一行
                                     $('#itemsDatagrid').datagrid('appendRow',{description:''});
                                     //3获取当前页的行号
                                     editing = $('#itemsDatagrid').datagrid('getRows').length -1;
                                     //4开启编辑状态
                                     $('#itemsDatagrid').datagrid('beginEdit', editing);
                                }
                    },{
                        text:'保存明细',
                        iconCls:'icon-save' ,
                        handler:function(){
                        	 var arr = $('#itemsDatagrid').datagrid('getRows');
                        	 for (var i = 0; i < arr.length ; i++) {
                          	//保存之前进行数据的校验 , 然后结束编辑并初始化编辑状态字段
                        		 if($('#itemsDatagrid').datagrid('validateRow',i)){
                             	$('#itemsDatagrid').datagrid('endEdit', i);
                        		}
                        	 }
                        }
                    },{
                        text:'删除明细',
                        iconCls:'icon-remove' ,
                        handler:function(){
                            var arr = $('#itemsDatagrid').datagrid('getSelections');
                            var row = $('#itemsDatagrid').datagrid('getSelected');
                            
                            if(arr.length <= 0 ){
                                $.messager.show({
                                    title:'提示信息',
                                    msg:'请选择进行删除操作!'
                                });                                            
                            } else {
                                $.messager.confirm('提示信息' , '确认删除?' , function(r){
                                    if(r){
                                    	for (var i=0; i < arr.length; i++) {
                                    		var index = $('#itemsDatagrid').datagrid('getRowIndex', arr[i]);
                                    		$('#itemsDatagrid').datagrid('deleteRow', index);
                                    	}
                                        
                                        $('#itemsDatagrid').datagrid('endEdit', editing);
                                        editing = undefined;
                                    } else {
                                         return ;
                                    }
                                });
                            }
                        }
                    },{
                        text:'取消操作',
                        iconCls:'icon-cancel' ,
                        handler:function(){
                            //回滚数据
                            $('#itemsDatagrid').datagrid('rejectChanges');
                            editing = undefined;
                        }
                    }    
                ] ,

        });
});

</script>
</body>
</html>