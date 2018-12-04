<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://shiro.apache.org/tags" prefix="shiro"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/jsps/common.jsp"%>
<script type="text/javascript">
	$(function() {
		/* 多事件的回调函数都包含'node'参数，其具备如下属性：

		id：绑定节点的标识值。
		text：显示的节点文本。
		iconCls：显示的节点图标CSS类ID。
		checked：该节点是否被选中。
		state：节点状态，'open' 或 'closed'。
		attributes：绑定该节点的自定义属性。
		target：目标DOM对象。 */

		//通过js方式创建左侧的树组件
		var index = 0;
		$("#tt")
				.tree(
						{
							//url:"/resources/js/tree.json",
							url : "/systemMenu/left",
							onClick : function(node) {
								//获取子节点;
								var cd = node.children;
								//判断当有子节点的菜单才去执行加载数据的步骤;
								if (node.url) {
									index++;
									//console.debug(index);
									//获取字节的url属性的值;
									var url = node.url;
									console.debug(url);
									var text = node.text;
									var iconCls = node.iconCls;
									//判断当前选项卡是否出存在,调用exists方法;根据标题或索引判断;
									if (!$("#tabs").tabs("exists", text)) {
										$("#tabs")
												.tabs(
														'add',
														{
															title : text,
															iconCls : iconCls,
															closable : true,
															content : '<iframe src="'
																	+ url
																	+ '" frameborder="0" style="width: 100%;height: 100%"></iframe>'
														})
									} else {
										//存在就选中当前选项卡;掉用方法,;select;参数是标题或索引
										$("#tabs").tabs("select", text)
									}
								}
							}
						/* onClick:function(node){
							//如果有children直接return，不然会有无限循环的tree
							if (node.children) {
								return;
							}
							
							//判断是否已经打开
							//判断是不是第一次添加
							var title = node.text;
							//返回值为节点node,获取到url,进行页面的跳转
							var url = node.url;
							//判断是否存在该选项卡
							var flag = $("#tabs").tabs("exists",title);
							if (flag) {
								//已经打开，则选中这个选项卡面板
								$("#tabs").tabs("select",title);
								return;
							}
							
							//打开一个xinde选项卡面板
							$("#tabs").tabs("add",{
								title:node.text,
								iconCls:node.iconCls,
								closable:true,
								content:'<iframe src="'+url+'" style="width:100%;height:100%;border:none"></iframe>'
							});
						}  */
						});
		//绑定右键菜单事件
		//新增main主页选择一键删除删除tabs
		$(".easyui-tabs").bind('contextmenu', function(e) {

			e.preventDefault();

			$('#rcmenu').menu('show', {

				left : e.pageX,

				top : e.pageY

			});

		});

		//关闭所有标签页  

		$("#closeall").bind("click", function() {

			var tablist = $('#tabs').tabs('tabs');

			console.log(tablist);

			//  return; 

			for (var i = tablist.length - 1; i >= 1; i--) {

				$('#tabs').tabs('close', i);

			}

		});

		//关闭其他页面（先关闭右侧，再关闭左侧）  

		$("#closeother").bind("click", function() {

			var tablist = $('#tabs').tabs('tabs');

			var tab = $('#tabs').tabs('getSelected');

			var index = $('#tabs').tabs('getTabIndex', tab);

			for (var i = tablist.length - 1; i > index; i--) {

				$('#tabs').tabs('close', i);

			}

			var num = index - 1;

			if (num < 1) {

				return;

			} else {

				for (var i = num; i >= 1; i--) {

					$('#tabs').tabs('close', i);

				}

				$("#tabs").tabs("select", 1);

			}

		});

		//关闭右边的选项卡

		$("#closeright").bind("click", function() {

			var tablist = $('#tabs').tabs('tabs');

			var tab = $('#tabs').tabs('getSelected');

			var index = $('#tabs').tabs('getTabIndex', tab);

			for (var i = tablist.length - 1; i > index; i--) {

				$('#tabs').tabs('close', i);

			}

		});

		//关闭右边的选项卡

		$("#closeleft").bind("click", function() {

			var tablist = $('#tabs').tabs('tabs');

			var tab = $('#tabs').tabs('getSelected');

			var index = $('#tabs').tabs('getTabIndex', tab);

			var num = index - 1;

			if (num < 1) {

				return;

			} else {

				for (var i = num; i >= 1; i--) {

					$('#tabs').tabs('close', i);

				}

				$("#tabs").tabs("select", 1);

			}

		});
		//设置主题;
		$("#themesChange")
				.combobox(
						{
							onChange : function(newValue, oldValue) {
								if ("主题切换" == newValue) {
									return;
								}
								var href = "${pageContext.request.contextPath}/resources/js/easyui/themes/"
										+ newValue + "/easyui.css"
								$("#themesCg").attr("href", href);
								var $iframe = $('iframe');

								if ($iframe.length > 0) {

									for (var i = 0; i < $iframe.length; i++) {

										var ifr = $iframe[i];

										$(ifr).contents().find('#themesCg')
												.attr('href', href);

									}

								}

								/* <option selected="selected">主题切换</option>   
								 <option value="default">简约主题</option>   
								 <option value="black">黑灰相间</option>   
								 <option value="ui-sunny">活力青春</option>   
								 <option value="ui-dark-hive">炫酷黑</option>   
								 <option value="gray">灰白空间</option>   
								 <option value="metro">纯白无暇</option>      */
								//如果不是高级主题,就改变颜色且清空;
							}
						})

	});
</script>

<style type="text/css">
#bottom {
	text-align: center; /*文本左右居中*/
	font-size: 15px;
	font-weight: 600;
	/*文本上下居中   line-height=heigh的值*/
	line-height: 50px;
}

.logo {
	margin-top: 10px;
}

.logo_text {
	margin-top: 35px;
	color: #fff;
	font-size: 15px;
	margin-left: 5px;
}

.logo, .logo_text {
	float: left;
}

.logout {
	float: right;
	margin-top: 40px;
	margin-right: 5px;
	color: #fff;
}

.themes {
	float: right;
	margin-top: 60px;
	margin-right: 5px;
	color: #fff;
}
</style>
</head>
<body>

	<div id="rcmenu" class="easyui-menu" style="">

		<div id="closeall">关闭全部</div>

		<div id="closeother">关闭其他</div>

		<div id="closeright">当前页右侧全部关闭</div>

		<div id="closeleft">当前页左侧全部关闭</div>

	</div>
	<div class="easyui-layout" fit="true"
		style="width: 700px; height: 350px;">
		<div data-options="region:'north'"
			style="height: 100px; background: black; padding: 10px;">
			<div class="logo">
				<img alt="logo" src="/resources/imgs/mercedes-benz-logo-desktop.png"
					style="width: 259px; height: 64px;">
				<!-- height:64px; -->
			</div>
			<div class="logo_text"  style="padding:10px;">仁孚奔驰客户关系管理系统</div>
			<div class="themes">
				<select id="themesChange" class="easyui-combobox" name="themes"
					style="width: 90px; height: 20px; border-radius: 10px;">
					<option selected="selected">主题切换</option>
					<option value="default">简约主题</option>
					<option value="black">黑灰相间</option>
					<option value="ui-sunny">活力青春</option>
					<option value="ui-dark-hive">炫酷黑</option>
					<option value="gray">灰白空间</option>
					<option value="metro">纯白无暇</option>
				</select>
			</div>
			<div class="logout">
				<shiro:user>
					 欢迎${loginUser.username}登录,<a href="/logout">退出登录</a>
				</shiro:user>
			</div>


		</div>
		<!-- 底部版权区 -->
		<div id="bottom" data-options="region:'south'" style="height: 55px;">
			版权归源码时代Java精英班0310第九组所有 &copy; 2018-2118</div>

		<div data-options="region:'west'" title="功能菜单" style="width: 160px;">
			<ul id="tt"></ul>
		</div>
		<div data-options="region:'center',title:'控制台'">
            <div id="tabs" class="easyui-tabs" fit="true">
        		<div title="首页" style="overflow:hidden;">
        		           
        			
        			
        				<img alt="tupian" src="/resources/imgs/E-Class-Coupe2.jpg" style="width:1410px;height:500px ; ">
        			<!-- <div data-options="region:'center',title:'控制台'">
        			</div> -->
        			
        			
        		</div>
        	</div>
        	
    </div>
    
    </div>
</body>
</html>