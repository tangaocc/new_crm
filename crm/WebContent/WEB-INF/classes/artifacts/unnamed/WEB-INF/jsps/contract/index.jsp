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
<title>合同管理</title>
<script type="text/javascript">
	$(function() {

		// 1、声明出页面需要使用的组件
		var contractDatagrid, contractDatagridDlg, contractDatagridDlgForm,cg,contractSearchDatagridDlg,contractSearchDatagridDlgForm;
		// 2、把页面的组件，缓存到上面声明的变量中
		contractDatagrid = $("#contractDatagrid");
		contractDatagridDlg = $("#contractDatagridDlg");
		contractDatagridDlgForm = $("#contractDatagridDlgForm");
		cg = $("#cg");
		vg = $("#vg");
		contractSearchDatagridDlg = $("#contractSearchDatagridDlg");
		contractSearchDatagridDlgForm = $("#contractSearchDatagridDlgForm");

		// 3、初始化组件，修改组件的值
		var grid = cg.combogrid("grid");
		var pager = grid.datagrid("getPager");
		pager.pagination({
			"showRefresh":false,
		});
		// 4、创建一个"命令对象"，把当前模块所有的功能，都打包到这个对象上
		var cmdObj = {
			"contractRefresh" : function() {
				contractDatagrid.datagrid("reload");
			},
			"contractAdd" : function() {
				contractDatagridDlg.dialog('open').dialog('center').dialog(
						'setTitle', '添加订单');
				contractDatagridDlgForm.form('clear');
				$("#itemsDatagrid").datagrid('loadData', {total:0, rows:[]});
				$('#sel').combobox({
					url : '/employee/list',
					valueField : 'id',
					textField : 'text'
				});
			},
			"contractEdit" : function() {
				//获取选中红
				var row = contractDatagrid.datagrid('getSelected');
				//没有选中
				if (!row) {
					$.messager.alert('温馨提示', '请选中一行后,再操作!', 'error');
					return;
				}
				$('#itemsDatagrid').datagrid({'url':'/contract/getItems?id='+row.id});
				
				contractDatagridDlg.dialog('open').dialog('center').dialog(
						'setTitle', '编辑合同');
				
				contractDatagridDlgForm.form('clear');
				
				contractDatagridDlgForm.form('load', row);
				
				//回显
				if(row.seller){
					console.debug(row);
					vg.combogrid("setValue",row.seller.id);
				}
				if(row.signTime){
					$("#signTime").datebox("setValue", row.signTime);
				}
				if (row.customer) {
					cg.combogrid("setValue",row.customer.id);
				}
			},
			"contractCancel" : function() {
				contractDatagridDlg.dialog('close');
			},
			"contractSave" : function() {

				contractDatagridDlgForm.form('submit', {
					url : "/contract/save",
					onSubmit : function(param) {
						var rows = $('#itemsDatagrid').datagrid('getRows');
						if (rows.length == 0) {
							$.messager.alert('提示信息', '请至少输入一个合同明细', 'warning');
							return false;
						}
						for (var i = 0; i < rows.length ; i++) {
                        	//保存之前进行数据的校验 , 然后结束编辑并初始化编辑状态字段
                      		if($('#itemsDatagrid').datagrid('validateRow',i)){
                          	 	$('#itemsDatagrid').datagrid('endEdit', i);
                      		} else {
                      			$.messager.alert('提示信息', '合同明细的输入格式不正确', 'warning');
    							return false;
                      		}
//                         	console.debug(arr[i]);
                        	console.debug(rows[i]);
                        	param['details['+i+'].money'] = rows[i].money;
                        	param['details['+i+'].isPayment'] = rows[i].isPayment;
                        	param['details['+i+'].payTime'] = rows[i].payTime;
                        	console.debug(rows[i].money);
                        	console.debug(rows[i].isPayment);
                        	console.debug(rows[i].payTime);
						}
						contractDatagridDlg.dialog('close');
						contractDatagrid.datagrid('reload');
						$.messager.alert('温馨提示', '保存成功!', 'info');
						return $(this).form('validate');
					}
					
				})
			},
			"contractDel" : function() {
				//获取选中红
				var row = contractDatagrid.datagrid('getSelected');
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
							$.post('/contract/del', {
								id : row.id
							}, function(result) {
								if (result.success) {
									//删除成功给出提示,并重新加载表格
									$.messager.alert('温馨提示', '删除成功!', 'info');
									contractDatagrid.datagrid('reload');
								} else {
									//删除成功给出提示,并重新加载表格
									$.messager.alert('温馨提示', result.message,
											'error');
									contractDatagrid.datagrid('reload');
								}
							}, 'json');
						}
					});
				}
			},
			"searchForm": function() {
				//console.debug(employeeSearchForm.serializeArray());
				//console.debug(employeeSearchForm.serialize());
				var paramObj = $("#contractSearchForm").serializeForm();
				// 调用datagrid的load方法，load只能加载json对象数据
				contractDatagrid.datagrid("load",paramObj);
			},
			"advanceSearch":function(){
				contractSearchDatagridDlg.dialog('open').dialog('center').dialog('setTitle', '高级查询');
			},
			"contractSearchCancel":function(){
				contractDatagridDlgForm.form('clear');
				contractSearchDatagridDlg.dialog('close');
			},
			"contractSearchSave":function(){
				var paramObj = contractSearchDatagridDlgForm.serializeForm();
				// 调用datagrid的load方法，load只能加载json对象数据
				contractDatagrid.datagrid("load",paramObj);
			},
			"searchFormClear":function(){
				$("#contractSearchForm").form("clear");
				location.reload();
			},
			printGuarantee : function(){
				var row = contractDatagrid.datagrid('getSelected');
				if (!row) {
					$.messager.alert('消息提示', '打印合同必须选中一行!', 'info');
					return;
				}
				console.debug(row);
				$('#printDialog').dialog('open');
				var printHtml = "";
				printHtml += "<td>" + row.id + "</td>";
				printHtml += "<td>" + row.sum + "</td>";
				printHtml += "<td>" + row.signTime + "</td>";
				printHtml += "<td>" + row.customer.name + "</td>";
				printHtml += "<td>" + row.seller.realName + "</td>";
				printHtml += "<td>" + row.intro + "</td>";
				$("#printContractList").html(printHtml);
				$("#jiafang").html(row.seller.realName);
				$("#sn").html(row.sn);
				$("#time").html(row.signTime);
				$("#yifang").html(row.customer.name);
				
				$.get("/contract/getItems?id="+row.id,function(data){
					var itemHtml = "";
					for(var i=0;i<data.rows.length;i++){
						itemHtml += "<tr>";
						itemHtml += "<td>" + data.rows[i].money + "</td>";
						itemHtml += "<td>" + data.rows[i].scale.toPercent() + "</td>";
						itemHtml += "<td>" + data.rows[i].payTime + "</td>";
						itemHtml += "<td>" + (data.rows[i].isPayment==true ? "已付款":"未付款") + "</td>";
						itemHtml += "</tr>";
					}
					$("#contractItemList").html(itemHtml);
				});
			},
		};
		// 5、对页面所有按钮，统一监听
		//$("a[data-cmd]") 有data-cmd属性的a标签
		$("a[data-cmd]").click(function() {
			//区分到底是哪个A 通过a标签上面的data-cmd属性
			//data-cmd="contractAdd" html的语法data-xxx
			//Jquery提供一个data方法通过xxx获取它属性值
			var cmd = $(this).data("cmd");
			// 		   if(cmd=="contractAdd"){
			// 			   cmdObj.contractAdd();
			// 		   }
			// 		   else if(cmd=="contractEdit"){
			// 			   cmdObj.contractEdit();
			// 		   }

			if (cmd) {
				cmdObj[cmd]();
			}
		});
		contractDatagrid.datagrid({
            view: detailview,
            detailFormatter:function(index,row){
                return '<div style="padding:2px"><table class="ddv"></table></div>';
            },
            onExpandRow: function(index,row){
                var ddv = $(this).datagrid('getRowDetail',index).find('table.ddv');
                console.debug(row);
                console.debug(row.details);
                $(ddv).datagrid({
                    url:'/contract/getItems?id='+row.id,
                    fitColumns:true,
                    singleSelect:true,
                    rownumbers:true,
                    loadMsg:'',
                    height:'auto',
                    columns:[[
                        {field:'payTime',title:'付款时间',width:200},
                        {field:'money',title:'付款金额',width:100,align:'right'},
                        {field:'scale',title:'所占比例',width:100,align:'right'},
                        {field:'isPayment',title:'是否付款',formatter:payFormatter,width:100,align:'right'}
                    ]],
                    onResize:function(){
                    	contractDatagrid.datagrid('fixDetailRowHeight',index);
                    },
                    onLoadSuccess:function(){
                    }
                });
                contractDatagrid.datagrid('fixDetailRowHeight',index);
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
        function payFormatter(v,r,i){
        	//v:就是字段值：0  1
        	return  v==true?"<font color='green'>已支付</font>":"<font color='red'>代付款</font>";
        }
</script>
</head>
<body>
	<!-- 管理表格 -->
	<table id="contractDatagrid" title="合同管理" class="easyui-datagrid"
		url="/contract/list" toolbar="#contractDatagridToolbar"
		pagination="true" rownumbers="true" fitColumns="true"
		singleSelect="true" fit="true">
		<thead>
			<tr>
				<th field="id" width="40">Id</th>
				<th field="sn" width="40">合同单号</th>
				<th field="signTime" width="40">签订时间</th>
				<th field="sum" width="40">合同金额</th>
				<th field="intro" width="40">摘要</th>
				<th field="customer" formatter="objFormatter" width="40">合同客户</th>
				<th field="seller" formatter="objFormatter" width="40">营销人员</th>
			</tr>
		</thead>
	</table>


	<!-- 管理表格ToolBar -->
	<div id="contractDatagridToolbar">
		<a data-cmd="contractAdd" href="javascript:void(0)"
			class="easyui-linkbutton c2" iconCls="icon-add" plain="true">添加</a> <a
			data-cmd="contractEdit" href="javascript:void(0)"
			class="easyui-linkbutton c3" iconCls="icon-edit" plain="true">编辑</a>
		<a data-cmd="contractDel" href="javascript:void(0)"
			class="easyui-linkbutton c4" iconCls="icon-remove" plain="true">删除</a>
		<a data-cmd="contractRefresh" href="javascript:void(0)"
			class="easyui-linkbutton c6" iconCls="icon-reload" plain="true">刷新</a>
		<a data-cmd="printGuarantee" href="javascript:void(0)" class="easyui-linkbutton c3 leave" iconCls="icon-print">打印合同</a>
		<div>
			<form id="contractSearchForm" method="post"
				enctype="application/x-www-form-urlencoded">
				定金单号 : <input name="sn" style="width: 120px; height: 20px;"
					class="easyui-textbox"> 订单金额:<input name="sum"
					style="width: 120px; height: 20px;" class="easyui-textbox">
				<a href="#" class="easyui-linkbutton color-blue"
					iconCls="icon-search" data-cmd="searchForm">搜索</a> <a href="#"
					class="easyui-linkbutton color-blue" iconCls="icon-cut"
					data-cmd="searchFormClear">清空</a> 
			<a href="#" class="easyui-linkbutton color-blue" iconCls="icon-search"
					data-cmd="advanceSearch">高级查询</a>
			</form>
		</div>
	</div>

	<!-- 添加或编辑对话框 -->
	<div id="contractDatagridDlg" class="easyui-dialog"
		style="width: 580px; height: 400px" closed="true"
		buttons="#contractDatagridDlgButtons">
		<form id="contractDatagridDlgForm" method="post" novalidate
			style="margin: 0; padding: 20px 50px">
			<!-- 区分是添加还是编辑 -->
			<input type="hidden" name="id" />
			<font style="font-weight:bold;">合同</font>
			<hr>
			<br/>
			<table>
				<tr>
					<td>签订时间</td>
					<td><input name="signTime" type="text" class="easyui-datebox"
						required="required"> </input></td>
				</tr>
				<tr>
					<td>合同金额</td>
					<td><input id="sumInput" name="sum" class="easyui-textbox"
						required="required"></td>
				</tr>
				<tr>
					<td>摘要</td>
					<td><input name="intro" class="easyui-textbox"></td>
				</tr>
				<tr>
					<td>合同客户</td>
					<td><select id="cg" class="easyui-combogrid"
						name="customer.id" style="width: 145px;"
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
					<td><select id="vg" class="easyui-combogrid" name="seller.id"
						style="width: 145px;"
						data-options="    
			            panelWidth:450,   
			             fitColumns:'true', 
			             value:'006',  
			            idField:'id',    
			            textField:'username',    
			            url:'/employee/list',  
			            pagination:true,
			            mode:'remote',
			            columns:[[    
			                {field:'username',title:'名称',width:60},
			                {field:'realName',title:'真实姓名',width:60},    
			                {field:'tel',title:'电话',width:100},    
			                {field:'email',title:'邮箱',width:120} 
			            ]]    
			        "></select></td>
				</tr>
			</table>
			<br/>
			<font style="font-weight:bold;">合同明细</font>
			<hr>
			<br/>
			<table id="itemsDatagrid">
			</table>
			<!-- 添加或编辑对话框按钮 -->
			<div id="contractDatagridDlgButtons">
				<a data-cmd="contractSave" href="javascript:void(0)"
					class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">保存</a>
				<a data-cmd="contractCancel" href="javascript:void(0)"
					class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
			</div>
			<!-- 添加或编辑对话框按钮 -->
			<div id="contractSearchDatagridDlgButtons">
				<a data-cmd="contractSearchSave" href="javascript:void(0)"
					class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px">查询</a>
				<a data-cmd="contractSearchCancel" href="javascript:void(0)"
					class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
			</div>
		</form>
	</div>
	
	<!-- 高级查询对话框 -->
	<div id="contractSearchDatagridDlg" class="easyui-dialog"
		style="width: 400px" closed="true"
		buttons="#contractSearchDatagridDlgButtons">
		<form id="contractSearchDatagridDlgForm" method="post" novalidate
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
					<td><select id="vg" class="easyui-combogrid" name="seller.id"
						style="width: 145px;"
						data-options="    
			            panelWidth:450,   
			             fitColumns:'true', 
			             value:'006',  
			            idField:'id',    
			            textField:'username',    
			            url:'/employee/list',  
			            pagination:true,
			            mode:'remote',
			            columns:[[    
			                {field:'username',title:'名称',width:60},
			                {field:'realName',title:'真实姓名',width:60},    
			                {field:'tel',title:'电话',width:100},    
			                {field:'email',title:'邮箱',width:120} 
			            ]]    
			        "></select></td>
				</tr>
			</table>
		</form>
	</div>
	<!-- 打印的Dialog start -->
	<div id="printDialog"  iconCls="icon-print" title="打印合同" modal="true" class="easyui-dialog" style="width:700px; height:450px; padding: 10px 20px" closed="true">
		<a href="javascript:window.print();" style="text-decoration:underline;">点击打印</a>
		<table width=100%>
	        <tr>   
	            <th width="50" align="left"></th>   
	            <th width="50" align="right">合同编号：<span id="sn"></span></th>   
	        </tr>   
	        <tr>   
	            <th align="left">甲方：<span id="jiafang"></span></th>   
	            <th align="right">签订地点：梅赛德斯奔驰</th>   
	        </tr>   
	        <tr>   
	            <th align="left">乙方：<span id="yifang"></span></th>   
	            <th align="right">签订时间：<span id="time"></span></th>   
	        </tr>   
		</table>  
		
		<p style="font-size:14px;">甲乙双方经协商一致，就乙方向甲方购买事宜达成以下协议，双方共同遵守:</p>
		<table border="1" cellpadding="0" cellspacing="0" style="width:100%;border:1px solid #333;text-align:center;margin:20px 0 20px;font-size:16px;">
			<tr>
				<td colspan="6">合同概况总览</td>
			</tr>
			<tr>
				<th>合同编号</th>
				<th>定金金额</th>
				<th>签订时间</th>
				<th>客户</th>
				<th>销售人员</th>
				<th>备注</th>
			</tr>
			<tr id="printContractList"></tr>
		</table>
		<!-- <table border="1" cellpadding="0" cellspacing="0" style="width:100%;border:1px solid #333;text-align:center;margin:20px 0;font-size:16px;">
			<thead>
				<tr>
					<td colspan="4">合同明细列表</td>
				</tr>
				<tr>
					<th>付款金额</th>
					<th>所占比例</th>
					<th>付款时间</th>
					<th>是否已付款</th>
				</tr>
			</thead>
			<tbody id="contractItemList"></tbody>
		</table> -->
	<p style="font-size:14px;">
	1、汽车销售商向乙方出售的汽车，质量须符合国家颁布的汽车质量标准。
	</p>
	<p style="font-size:14px;">
　    2、汽车销售商向乙方出售的汽车，须是在《全国汽车、民用改装车和摩托车生产企业及产品目录》上备案的产品或经交通管理部门认可的汽车。
	</p>
	<p style="font-size:14px;">
　　3、汽车销售商向乙方出售汽车时须真实准确介绍所售车辆的基本情况。
	</p>
<p style="font-size:14px;">
　　4、乙方通过其它汽车销售商购买的车辆，乙方负有审查所购车辆证件，发票、手续是否齐全、真实，若因此而产生的风险及责任与甲方无关。
</p>
<p style="font-size:14px;">
　　5、乙方应对所购车辆的功能及外观进行认真检查、确认。
</p>
<p style="font-size:14px;">
　　6、如乙方所购车辆发生质量问题，甲方协助乙方或协助汽车销售商与生产厂家的维修站联系、解决。
		</p>
		<p style="font-size:14px;">
			甲方和乙双方合同信息如有变更，变更一方应在合同规定的相关付款期限前二十天内以书面方式通知对方，如未按时通知或通知有误应付相关及连带责任
		</p>
	</div>
<script type="text/javascript">  
$(function(){
    var editing ; //判断用户是否处于编辑状态
    var flag  ;      //判断新增和修改方法
    $('#itemsDatagrid').datagrid({
                height: '200px',
                width: '500px',
                fitColumns: true,
                striped: true ,                  
                rownumbers:true ,
                frozenColumns:[[
                        {field:'ck' , checkbox:true}                                    
                ]],
                columns:[[
                    {
                        field:'money' ,
                        title:'支付金额' ,
                        width: '80px',
                        align:'center' ,
                        editor:{
                            type:'validatebox' ,
                            options:{
                                required:true ,
                                missingMessage:'支付金额必填!'
                            }
                        }
                    },{
                        field:'scale' ,
                        title:'金额所占百分比' ,
                        width: '80px',
                        align:'center' ,
                        editor:{
                            type:'validatebox' ,
                            options:{
                                editable:false
                            }
                        }
                    },{
                        field:'isPayment' ,
                        width: '80px',
                        align:'center' ,
                        title:'是否支付' ,
                        formatter:function(value , record , index){
                            if(value == 0){
                                return '<span style=color:red; >待支付</span>' ;
                            } else if( value == 1){
                                return '<span style=color:green; >已支付</span>' ;
                            }
                        } ,
                        editor:{
                            type:'combobox' ,
                            options:{
                                data:[{id:1 , val:'已支付'},{id:0 , val:'待支付'}] ,
                                valueField:'id' ,
                                textField:'val' ,
                                required:true ,
                                missingMessage:'是否支付必填!'
                            }
                        }
                    },{
                        field:'payTime' ,
                        title:'支付时间' ,
                        align:'center' ,
                        width: '80px',
                        sortable : true ,
                        editor:{
                            type:'datebox' ,
                            options:{
                                required:true ,
                                missingMessage:'支付时间必填!' ,
                                editable:false
                            }
                        }
                    }
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
                             	//计算scale
                             	//明细的钱
                             	var mon = arr[i].money;
                             	
                             	var sum=$("#sumInput").val();
                             	console.debug("合同的钱");
                             	console.debug(sum);
                              	arr[i].scale = mon/sum;
                             	console.debug("钱；；；");
                              	console.debug(mon);
                             	$('#itemsDatagrid').datagrid('acceptChanges');
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