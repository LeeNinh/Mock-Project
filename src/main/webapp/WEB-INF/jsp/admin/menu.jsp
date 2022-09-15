<%@ page import="com.tainguyen.demo.model.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    User useradmin = (User) session.getAttribute("useradmin");
    if (useradmin == null || !useradmin.getRole().equals("ROLE_ADMIN")) {
        response.sendRedirect("/admin/login");
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>menu</title>
    </head>
    <body>

        <div id="leftBar" style="display: none">
            <ul>
                <li><a href="${root}/admin/index">Trang chủ</a></li>
                <li><a href="${root}/admin/upload_image">Upload ảnh</a></li>
                <li><a href="${root}/admin/manager_category">Danh mục</a></li>
                <li><a href="${root}/admin/manager_product">Sản phẩm</a></li>
                <li><a href="${root}/admin/manager_bill">Hóa đơn</a></li>
                <li><a href="${root}/admin/manager_user">Người dùng</a></li>
                <li><a href="${root}/admin/news_list">Tin tức </a></li>
            </ul>
        </div>

    </body>
</html>
