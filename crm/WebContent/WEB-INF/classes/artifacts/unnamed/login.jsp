<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
<html lang="en">

<!-- Head -->
<head>

<title></title>

<!-- Meta-Tags -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="keywords" content="Valid Login Form Responsive, Login Form Web Template, Flat Pricing Tables, Flat Drop-Downs, Sign-Up Web Templates, Flat Web Templates, Login Sign-up Responsive Web Template, Smartphone Compatible Web Template, Free Web Designs for Nokia, Samsung, LG, Sony Ericsson, Motorola Web Design" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- //Meta-Tags -->
<%@ include file="WEB-INF/jsps/common.jsp"%>
<!-- Custom-Style-Sheet -->
<link rel="stylesheet" href="resources/css/login/bootstrap.css"	type="text/css" media="all">
<link rel="stylesheet" href="resources/css/login/validify.css"	type="text/css" media="all">
<link rel="stylesheet" href="resources/css/login/style.css"		type="text/css" media="all">
<!-- //Custom-Style-Sheet -->
<script type="text/javascript">
	$(function(){
		$(document.documentElement).on("keyup", function(event) {
			//console.debug(event.keyCode);
			var keyCode = event.keyCode;
			console.debug(keyCode);
			if (keyCode === 13) { // 捕获回车 
				submitForm(); // 提交表单
			}
		});
	});
</script>


<style type="text/css">
	@-webkit-keyframes AnimationName {
		0%{background-position:15% 0%}
		50%{background-position:86% 100%}
		100%{background-position:15% 0%}
	}

	@-moz-keyframes AnimationName {
		0%{background-position:15% 0%}
		50%{background-position:86% 100%}
		100%{background-position:15% 0%}
	}

	@keyframes AnimationName { 
		0%{background-position:15% 0%}
		50%{background-position:86% 100%}
		100%{background-position:15% 0%}
	}

	.textbox {
		margin: 20px 0;
		padding: 15px 5px;
		color: #fff;
		background-color: rgba(0, 0, 0, .25);
		border: 1px solid #CCC;
		border-radius: 0;
		box-shadow: none !important;
		transition: all .1s linear;
	}
	.btn-osx, button[disabled] {
		padding: 5px 10px;
		color: #fff;
		background-color: rgba(0, 0, 0, .1)!important;
		border: 1px solid rgba(255, 255, 255, .2);
		box-shadow: none !important;
		transition: all .2s linear;
		border-radius: 50%;
		font-size: 20px;
	}

	.btn-default:hover, .btn-default:focus, .btn-default.focus, .btn-default:active, .btn-default.active, .open > .dropdown-toggle.btn-default {
		color: #FFF;
		opacity: 1;
		border-color: #FFF!important;
	}

	@media screen and (max-width: 640px) {
		.textbox {
			margin: 20px 0;
			padding: 12px;
			font-size: 13px;
		}
	}

</style>
<!-- //Style -->

</head>
<!-- //Head -->

	<!-- Body -->
	<body>
	<script type="text/javascript">
		function submitForm() {
			$("#loginForm").form("submit", {
				url : "/login/in",
				success : function(data) {
					data = $.parseJSON(data);
					if (data.success) {
						location.href = "/main/index";
					} else {
						$.messager.alert("温馨提示", data.msg, "info", function() {
							if (data.errorCode == -100) {// 用户名错误
								$("input[name=username]").focus();
							} else if (data.errorCode == -101) {// 密码错误
								$("input[name=password]").focus();
							}
						});
					}
				}
			});
		}
		function resetForm() {
			$("#loginForm").form("clear");
		}
		
		// 检查自己是否是顶级页面 如果登录不是顶层窗口，登录要独占顶层窗口
		if (top != window) {// 如果不是顶级
			//把子页面的地址，赋值给顶级页面显示
			window.top.location.href = window.location.href;
		}
		
	</script>

		<h1>Mercedes Benz</h1>

		<div >

			<form id="loginForm" method="post" >
				<div  style="width: 300px ;  margin-left: auto; margin-right: auto;" >
					<input type="text" name="username"class="form-control agileinfo textbox easyui-validatebox" placeholder="用户名" /> 
				</div>
				<div style="width: 300px ;  margin-left: auto; margin-right: auto;">
					 <input type="password" name="password" class=" form-control agileinfo textbox easyui-validatebox" placeholder="密码" />
				</div>
				<div class="form-group w3-agile submit">
					<tr height="40">
						<td align="center"><a href="javascript:;" class="easyui-linkbutton c3" onclick="submitForm();">登陆</a> <a
							href="javascript:;" class="easyui-linkbutton c2" onclick="resetForm();">重置</a></td>
					</tr>
				</div>
				<div class="alert agileits-小贝壳网站模板 alert-success hidden" role="alert">Login Successful!</div>
			</form>

		</div>

		<div class="w3lsfooteragileits">
			<p> &copy; 2018 tencent by 唐傲  梁欢  黄虹 梁飞  张宸豪 | Design by <a href="http://www.smallseashell.com" target="=_blank"></a></p>
		</div>




	</body>
	<!-- //Body -->



</html>