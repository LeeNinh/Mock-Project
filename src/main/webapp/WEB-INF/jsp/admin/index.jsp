<%@ page import="com.tainguyen.demo.model.User" %>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>TRANG QUẢN TRỊ</title>

    <c:set var="root" value="${pageContext.request.contextPath}"/>
    <link href="${root}/css/mos-style.css" rel='stylesheet' type='text/css'/>
    <link href="${root}/css/bootstrap.css" rel="stylesheet" type="text/css" media="all"/>
    <link href="${root}/css/style.css" rel="stylesheet" type="text/css" media="all"/>
</head>
<body>
<%
    User useradmin = (User) session.getAttribute("useradmin");
    if (useradmin == null || !useradmin.getRole().equals("ROLE_ADMIN")) {
        response.sendRedirect("/admin/login");
    }
%>
<jsp:include page="header.jsp"></jsp:include>

<div class="container">
    <div class="d-flex">
        <jsp:include page="menu.jsp"></jsp:include>

        <jsp:include page="content.jsp"></jsp:include>
    </div>
    <jsp:include page="footer.jsp"></jsp:include>
</div>

</body>
</html>
