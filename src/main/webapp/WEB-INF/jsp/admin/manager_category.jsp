<%@page import="java.util.ArrayList" %>
<%@page import="com.tainguyen.demo.model.Category" %>
<%@page import="com.tainguyen.demo.repository.CategoryGet" %>
<%@ page import="com.tainguyen.demo.model.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản Lý Danh Mục</title>

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

    CategoryGet categoryGet = new CategoryGet();
    ArrayList<Category> listCategory = categoryGet.getListCategory();
%>
<jsp:include page="header.jsp"></jsp:include>

<div>
    <div class="d-flex container">
        <jsp:include page="menu.jsp"></jsp:include>

        <div id="rightContent">

            <h3>QUẢN LÝ DANH MỤC</h3>

            <button onclick="router()" class="btn btn-primary btn-router">Thêm danh mục</button>
            <table class="data">
                <tr class="data">
                    <th class="data" width="30px">STT</th>
                    <th class="data">Hình ảnh</th>
                    <th class="data">Tên danh mục</th>

                    <th class="data" width="75px">Tùy chọn</th>
                </tr>
                <%
                    int count = 0;
                    for (Category category : listCategory) {
                        count++;

                %>
                <tr class="data">
                    <td class="data" width="30px"><%=count%>
                    </td>
                    <td class="data"><img class="hinhql" src="<%=category.getCategoryImage()%>"/>
                    </td>
                    <td class="data"><%=category.getCategoryName()%>
                    </td>

                    <td class="data" width="90px">
                        <center>
                            <a href="${root}/admin/update_category?command=update&category_id=<%=category.getCategoryID()%>">Sửa</a>&nbsp;&nbsp;
                            | &nbsp;&nbsp;
                            <a href="/delete_category?category_id=<%=category.getCategoryID()%>">Xóa</a>
                        </center>
                    </td>
                </tr>
                <% } %>
            </table>
        </div>
        <div class="clear"></div>
    </div>
    <jsp:include page="footer.jsp"></jsp:include>
</div>
<script>
    function router() {
        window.location.href = "/admin/insert_category";
    }
</script>
</body>
</html>
