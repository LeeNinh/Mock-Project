<%@page import="java.text.DecimalFormat" %>
<%@page import="com.tainguyen.demo.repository.ProductRepo" %>
<%@page import="java.util.ArrayList" %>
<%@page import="com.tainguyen.demo.repository.CategoryGet" %>
<%@ page import="com.tainguyen.demo.model.User" %>
<%@ page import="com.tainguyen.demo.model.ProductDisplayDto" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản Lý Sản Phẩm</title>

    <link rel="stylesheet" href="/css/bootstrap.css" type="text/css"/>

    <!-- js -->
    <script src="${root}/js/jquery.min.js"></script>
    <!-- //js -->
    <!-- for bootstrap working -->
    <script type="text/javascript" src="${root}/js/bootstrap-3.1.1.min.js"></script>
    <!-- //for bootstrap working -->

    <c:set var="root" value="${pageContext.request.contextPath}"/>
    <link href="${root}/css/mos-style.css" rel='stylesheet' type='text/css'/>
    <link href="${root}/css/bootstrap.css" rel="stylesheet" type="text/css" media="all"/>
    <link href="${root}/css/style.css" rel="stylesheet" type="text/css" media="all"/>
</head>
<body>
<%
    ProductRepo productGet = new ProductRepo();
    ArrayList<ProductDisplayDto> listProductEntity = productGet.getListProduct();

    User useradmin = (User) session.getAttribute("useradmin");
    if (useradmin == null || !useradmin.getRole().equals("ROLE_ADMIN")) {
        response.sendRedirect("/admin/login");
    }
%>
<jsp:include page="header.jsp"></jsp:include>

<div class="d-flex container">

    <jsp:include page="menu.jsp"></jsp:include>

    <div id="rightContent">

        <h3>QUẢN LÝ SẢN PHẨM</h3>

        <button onclick="router()" class="btn btn-primary btn-router">Thêm sản phẩm</button>
        <table class="data">
            <tr class="data">
                <th class="data" width="30px">STT</th>
                <th class="data">Loại danh mục</th>
                <th class="data">Hình đại diện</th>
                <th class="data">Mã sản phẩm</th>
                <th class="data">Tên sản phẩm</th>
                <th class="data" width="75px">Tùy chọn</th>
            </tr>
            <%
                int count = 0;
                for (ProductDisplayDto productEntity : listProductEntity) {
                    count++;

            %>
            <tr class="data"
                    <%if (!productEntity.isActive()) {%>
                    style="background: #b3b1b1"
                    <%}%>
            >
                <td class="data" width="30px"><%=count%>
                </td>
                <td class="data"><%=productEntity.getProductName()%>
                </td>
                <td class="data"><img class="hinhql"
                                      src="<%=productEntity.getProductImageList().get(0).getImageUrl()%>"/></td>
                <td class="data"><%=productEntity.getProductCode()%>
                </td>
                <td class="data"><%=productEntity.getProductName()%>
                </td>
                <td class="data" width="90px">&nbsp;
                    <%if (productEntity.isActive()) {%>
                    <button class="btn btn-primary btn-active" onclick="switchActive(<%=productEntity.getProductId()%>, false)">Inactive</button>
                    <%} else {%>
                    <button class="btn btn-primary btn-active" onclick="switchActive(<%=productEntity.getProductId()%>, true)">Active</button>
                    <% } %>
                    <button class="btn btn-danger" onclick="deletePro(<%=productEntity.getProductId()%>)">Xóa</button>
                </td>
            </tr>
            <% }%>
        </table>
    </div>
    <div class="clear"></div>

</div>
<jsp:include page="footer.jsp"></jsp:include>

<script>
    function router() {
        window.location.href = "/admin/insert_product";
    }

    function deletePro(prodictId) {
        $.get('/delete_product?product_id=' + prodictId,
            function () {
                window.location.href = "/admin/manager_product";
            })
    }

    function switchActive (productId, isActive) {
        $.post('/switch_active',
            {
                'id': productId,
                'state': isActive
            },
            function (data) {
                if (data == 'active') {
                    alert('Active tài khoản thành công');
                } else if (data == 'inactive') {
                    alert('Inactive tài khoản thành công');
                } else {
                    alert('Thất bại');
                }

                window.location.href = "/admin/manager_product";
            });
    }

</script>

</body>
</html>
