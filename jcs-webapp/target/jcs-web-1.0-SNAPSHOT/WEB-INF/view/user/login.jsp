<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="sp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>作业批改系统登录</title>
    <link rel="stylesheet" type="text/css" href="css/login.css"/>
    <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page"><script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <script type="application/javascript">
	  function toLogin(){
	      var pwd = $("input[name='username']").val();
		  var username = $("input[name='username']").val();
	      $.ajax({
			  url:'${pageContext.request.contextPath}/user/login.do',
			  data:$('#loginForm').serialize(),
			  success:function(){
			      window.location.href = '${pageContext.request.contextPath}/main.do';
              }

		  })
	  }
  </script>
  <body>
		<div id="container">
			<div id="title"></div>
			<div id="login">
				<form  method="post" id="loginForm">
					<table>
						<tr class="color_red">
							<td colspan="2" >${requestScope.loginMess }</td>
						</tr>
						<tr>
							<td>
								用户名：
							</td>
							<td><input type="text" name="username"/></td>
						</tr>
						<tr>
							<td>
								密码：
							</td>
							<td><input type="password" name="password"/></td>
						</tr>
						<tr>
							<td colspan="2">
								<button class="login1" type="button" onclick="toLogin()"></button>
								&nbsp;&nbsp;&nbsp;
								<button class="reset1" type="reset"></button>
								<span id="">
									登录
								</span>
								<a href="register.jsp">
									注册
								</a>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
  </body>
</html>
