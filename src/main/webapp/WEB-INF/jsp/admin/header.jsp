<%@ page import="com.tainguyen.demo.model.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>header</title>
</head>
<body>
<%
    User useradmin = (User) session.getAttribute("useradmin");
    if (useradmin == null || !useradmin.getRole().equals("ROLE_ADMIN")) {
        response.sendRedirect("/admin/login");
    }
%>
<div id="header">
    <div class="inHeader">
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <ul class="nav navbar-nav">
                    <li><a href="${root}/admin/index">Trang chủ</a></li>
                    <li><a href="${root}/admin/upload_image">Upload ảnh</a></li>
                    <li><a href="${root}/admin/manager_category">Danh mục</a></li>
                    <li><a href="${root}/admin/manager_product">Sản Phẩm</a></li>
                    <li><a href="${root}/admin/manager_bill">Hóa Đơn</a></li>
                    <li><a href="${root}/admin/manager_user">Người Dùng</a></li>
                    <li><a href="${root}/admin/news_list">Tin Tức</a></li>
                </ul>
            </div>
        </nav>
        <div class="mosAdmin">
            <%if (useradmin != null) { %>
            Chào <%=useradmin.getUserName()%> <br>
            <% } %>
            <a href="/">DuongLienOrder</a>
        </div>
        <div class="clear"></div>
    </div>
</div>

</body>
</html>
