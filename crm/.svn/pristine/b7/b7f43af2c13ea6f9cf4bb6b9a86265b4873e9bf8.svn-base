$(function() {
	var systemDictionaryItemDatagrid, systemDictionaryItemDialog, systemDictionaryItemForm;
	systemDictionaryItemDatagrid = $("#systemDictionaryItemDatagrid");
	systemDictionaryItemDialog = $("#systemDictionaryItemDialog");
	systemDictionaryItemForm = $("#systemDictionaryItemForm");
	 var grid = $("#menu").combogrid("grid");
	   //2)通过grid获取Pagination grid=list+Pagination
	   var pager = grid.datagrid("getPager");
			   //初始化Pagination的值  这是再easyui绿皮书中的demo
	   pager.pagination(
		{ 
		   'showPageList':false, 
		   'showRefresh':false,
		   'displayMsg':'',
		   'loading':true,
		 
		   //'layout':['list','sep','first','prev','next','links','manual','refresh','last']
		   
		}); 
	 
	systemDictionaryItemForm.form({
		url : "/systemDictionaryItem/save",
		onSubmit : function() {  
			return systemDictionaryItemForm.form("validate");
		},
		success : function(data) { 
			data = jQuery.parseJSON(data);
			if (data.success) {
				// 关对话框
				systemDictionaryItemDialog.dialog("close");
				jQuery.messager
						.alert("温馨提示", data.message, "info",
								function() {
									//调用重新加载数据的方法
									systemDictionaryItemDatagrid
											.datagrid("reload");
								});
			} else {
				jQuery.messager.alert('错误提示', data.message, 'error');
			}
		}
		
	});
	var cmdObj2 = {
		create2 : function() {
			// 清空对话框里面的表单内容
			systemDictionaryItemForm.form("clear");
			// 打开对话框
			systemDictionaryItemDialog.dialog("open");
		},
		edit2 : function() {
			// 获取选中行数据
			var rowData = systemDictionaryItemDatagrid
					.datagrid("getSelected");
			// 判断是否选中行
			if (!rowData) {
				jQuery.messager.alert("温馨提示", "请选中一行数据！！", "info");
				return;
			}
			systemDictionaryItemForm.form("clear");
			systemDictionaryItemForm.form("load", rowData);
			systemDictionaryItemDialog.dialog("open");
		},
		remove2 : function() {
			// 获取选中行数据
			var rowData = systemDictionaryItemDatagrid
					.datagrid("getSelected");
			// 判断是否选中行
			if (!rowData) {
				jQuery.messager.alert("温馨提示", "请选中一行数据！！", "info");
				return;
			}
			jQuery.get("/systemDictionaryItem/delete?id=" + rowData.id,
					function(data) {
						if (data.success) {//删除成功
							jQuery.messager.alert('消息提示', '删除成功!', 'info',
									function() {
										//调用重新加载数据的方法
										systemDictionaryItemDatagrid
												.datagrid("reload");
									}); 					
						} else {
							jQuery.messager.alert('错误提示', data.message,
									'error');
						}
					}, 'json');
		},
		reload2 : function() {
			//调用重新加载数据的方法
			systemDictionaryItemDatagrid.datagrid("reload");
		},
		save2 : function() {
			//提交表单
		//	alert("进入保存方法"	);
			systemDictionaryItemForm.submit();
		//	 $("#searchDialogForm").serializeForm();
		},
		cancel2 : function() {
			//关闭对话框
			systemDictionaryItemDialog.dialog("close");
		},
		search2 : function(){
			systemDictionaryItemDatagrid.datagrid("load", $("#searchForm2").serializeForm());
		}
	};
	$("a[data-cmd]").on("click", function() {
		var cmd = $(this).data("cmd");
		if (cmdObj2[cmd]) {
			if ($(this).hasClass("l-btn-disabled")) {
				return;
			}
			cmdObj2[cmd]();
		}
	});
});
