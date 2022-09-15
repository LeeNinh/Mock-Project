<%@ page import="com.tainguyen.demo.model.User" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đăng Ký</title>
    <link rel="icon" href="../img/iconWeb.jpg">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="keywords" content="Classic Style Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template,
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design"/>
    <script type="application/x-javascript"> addEventListener("load", function () {
        setTimeout(hideURLbar, 0);
    }, false);

    function hideURLbar() {
        window.scrollTo(0, 1);
    } </script>
    <!-- //for-mobile-apps -->
    <link href="/css/bootstrap.css" rel="stylesheet" type="text/css" media="all"/>
    <link href="/css/style.css" rel="stylesheet" type="text/css" media="all"/>
    <!-- js -->
    <script src="/js/jquery.min.js"></script>
    <!-- //js -->
    <!-- cart -->
    <script src="/js/simpleCart.min.js"></script>
    <!-- cart -->
    <!-- for bootstrap working -->
    <script type="text/javascript" src="/js/bootstrap-3.1.1.min.js"></script>
    <!-- //for bootstrap working -->
    <!-- animation-effect -->
    <link href="/css/animate.min.css" rel="stylesheet">
    <script src="/js/wow.min.js"></script>
    <script>
        new WOW().init();
    </script>
    <!-- //animation-effect -->
    <link href='//fonts.googleapis.com/css?family=Cabin:400,500,600,700' rel='stylesheet' type='text/css'>
    <link href='//fonts.googleapis.com/css?family=Lato:400,100,300,700,900' rel='stylesheet' type='text/css'>

    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" type="text/javascript"></script>
    <script src='https://www.google.com/recaptcha/api.js'></script>
</head>

</head>
<%
    User users = (User) session.getAttribute("user");
    if (users != null) {
        response.sendRedirect("/index");
    }
%>
<body>
<jsp:include page="header.jsp"></jsp:include>

<div class="banner-top">
    <div class="login-title">
        ĐĂNG NHẬP
    </div>
</div>

<div class="login">
    <div class="container">
        <form action="login" method="POST">
            <div style="display: flex; justify-content: center">
                <div class="contain-form-login animated wow fadeInLeft" data-wow-delay=".5s">
                    <%if (request.getAttribute("error") != null) {%>
                    <div>
                        <p style="color:red"><%=request.getAttribute("error")%>
                        </p>
                    </div>
                    <% } %>
                    <%if (request.getAttribute("message") != null) {%>
                    <div>
                        <p style="color:green"><%=request.getAttribute("message")%>
                        </p>
                    </div>
                    <% } %>
                    <div class="login-mail">
                        <input type="text" placeholder="Tên tài khoản" name="username" required>
                        <i class="glyphicon glyphicon-envelope"></i>
                    </div>
                    <div class="login-mail">
                        <input type="password" placeholder="Mật khẩu" name="pass" required>
                        <i class="glyphicon glyphicon-lock"></i>
                    </div>
                    <div style="display: flex; justify-content: center">
                        <div class="col-md-8 login-do animated wow fadeInRight" data-wow-delay=".5s">
                            <p> Quên mật khẩu?</p>
                            <label class="hvr-sweep-to-top login-sub">
                                <input type="hidden" value="login" name="command">
                                <input type="submit" value="Đăng nhập">
                            </label>
                            <p>Bạn chưa có tài khoản ?</p>
                            <a href="/account/registerForm" class="hvr-sweep-to-top">Đăng ký</a>
                        </div>
                    </div>
                </div>
                <input type="hidden"
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}"/>
                <div class="clearfix"></div>
            </div>

            <div class="clearfix"></div>
        </form>

    </div>
</div>

<jsp:include page="./footer.jsp"></jsp:include>
</body>
</html>
