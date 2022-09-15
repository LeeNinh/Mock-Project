<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đăng Nhập</title>

    <c:set var="root" value="${pageContext.request.contextPath}"/>
    <link href="${root}/css/mos-style.css" rel='stylesheet' type='text/css'/>
    <link href="${root}/css/bootstrap.css" rel="stylesheet" type="text/css" media="all"/>

</head>
<body>

<div id="header">
</div>

<div id="loginForm">
    <div class="headLoginForm">
        Đăng nhập Admin
    </div>
    <div class="fieldLogin">
        <form action="/account/admin/login" method="post">
            <%if (request.getAttribute("error") != null) {%>
            <div>
                <p style="color:red; font-size: 23px"><%=request.getAttribute("error")%>
                </p>
            </div>
            <% } %>
            <label class="login">Tài khoản</label><br>
            <input type="text" class="login" name="username"><br>
            <label class="login">Mật khẩu</label><br>
            <input type="password" class="login" name="pass"><br>
            <input id="submit" type="submit" class="btn btn-primary" value="Đăng Nhập"
                style="font-size: 27px;
                        margin: 24px 0 0 170px;
                        padding: 10px 40px 10px 40px;">
        </form>
    </div>
</div>

</body>
</html>
