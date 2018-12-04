$(function() {
	var systemDictionaryDatagrid, systemDictionaryDialog, systemDictionaryForm;
	systemDictionaryDatagrid = $("#systemDictionaryDatagrid");
	systemDictionaryDialog = $("#systemDictionaryDialog");
	systemDictionaryForm = $("#systemDictionaryForm");
	// 组件初始化
	systemDictionaryForm.form({
		url : "/systemdictionary/save",
		onSubmit : function() { // 在表单‘提交前’，做验证
			return systemDictionaryForm.form("validate");
		},
		success : function(data) {
			// 转成json格式
			var data = jQuery.parseJSON(data);
			// 判断
			if (data.success) {
				systemDictionaryDialog.dialog("close");
				jQuery.messager.alert("温馨提示", data.message, "info", function() {
					// 调用重新加载数据的方法
					systemDictionaryDatagrid.datagrid('reload');
				});

			} else {
				jQuery.messager.alert('错误提示', data.message, 'error');
			}

		}

	});

	var cmdObj = {
		"systemDictionadd" : function() {
			systemDictionaryForm.form("clear");
			systemDictionaryDialog.dialog("open");

		},
		"systemDictionaryEdit" : function() {
		//	alert("修改");
			// 获取一行数据
			var row = systemDictionaryDatagrid.datagrid('getSelected');
			if (!row) {
				$.messager.alert('温馨提示', '请选中要修改行!', 'error');
				return;
			} else {
				systemDictionaryForm.form("clear");
				// 回显
				systemDictionaryForm.form("load", row);
				/*
				 * if (row.parent) { $('#cbb').combotree('setValue',
				 * row.parent.id); }
				 */
				// 打开新增或编辑对话框
				systemDictionaryDialog.dialog("setTitle", "编辑数据字典").dialog(
						"center").dialog("open");
			}
		},
		"systemDictionarySave" : function() {
		//	alert("保存按钮");
			systemDictionaryForm.submit();

		},
		 "systemDictionaryDelete" : function() {
			var row = systemDictionaryDatagrid.datagrid('getSelected');
			if (!row) {
				$.messager.alert('温馨提示', '请选中要删除行!', 'error');
				return;// 如果没有数据做了提示信息就应该返回
			}
			if (row) {
				$.messager.confirm('温馨提示', '您确定要删除该行数据吗?', function(r) {
					if (r) {
						$.post('/systemdictionary/delete', {
							id : row.id
						}, function(result) {
							// 期望返回成功与否，如果有错需要返回错误提示信息
							// {"success":true,"message":"xxxx"}
							// 可以封装一个类AjaxResult，里面有两个属性
							if (result.success) {
								// 给个提示信息
								$.messager.alert('温馨提示', '删除成功', 'info');
								// 刷新界面
								systemDictionaryDatagrid.datagrid('reload');
							} else {
								$.messager.alert('温馨提示', result.message,
										'error');
							}
						}, 'json');
					}
				});
			}
		}, 
		 "systemDictionaryRefresh" : function() {
			systemDictionaryDatagrid.datagrid("reload");
		},cancel : function() {
			//关闭对话框
			systemDictionaryDialog.dialog("close");
		},
		search : function(){
			systemDictionaryDatagrid.datagrid("load", $("#searchForm").serializeForm());
		}
 };
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
});