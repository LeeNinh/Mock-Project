<%@page import="com.tainguyen.demo.model.Category" %>
<%@page import="com.tainguyen.demo.repository.CategoryGet" %>
<%@ page import="com.tainguyen.demo.model.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.tainguyen.demo.model.ImageUrl" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tainguyen.demo.repository.ImageRepo" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cập nhật danh mục</title>

    <c:set var="root" value="${pageContext.request.contextPath}"/>
    <link href="${root}/css/mos-style.css" rel='stylesheet' type='text/css'/>
    <link href="${root}/css/style.css" rel="stylesheet" type="text/css" media="all"/>
    <link href="${root}/css/bootstrap.css" rel="stylesheet" type="text/css" media="all"/>
    <!-- js -->
    <script src="${root}/js/jquery.min.js"></script>
    <!-- //js -->
    <!-- cart -->
    <script src="${root}/js/simpleCart.min.js"></script>
    <!-- cart -->
    <!-- for bootstrap working -->
    <script type="text/javascript" src="${root}/js/bootstrap-3.1.1.min.js"></script>
    <!-- //for bootstrap working -->
    <!-- animation-effect -->
    <link href="${root}/css/animate.min.css" rel="stylesheet">
    <script src="${root}/js/wow.min.js"></script>
    <script>
        new WOW().init();
    </script>
    <!-- //animation-effect -->
    <link href='//fonts.googleapis.com/css?family=Cabin:400,500,600,700' rel='stylesheet' type='text/css'>
    <link href='//fonts.googleapis.com/css?family=Lato:400,100,300,700,900' rel='stylesheet' type='text/css'>

</head>
<body>

<%
    List<ImageUrl> imageList = new ArrayList();
    String error = "";
    if (request.getParameter("error") != null) {
        error = (String) request.getParameter("error");
    }
    Category category = new CategoryGet().getCategory(Long.parseLong(request.getParameter("category_id")));

    User useradmin = (User) session.getAttribute("useradmin");
    if (useradmin == null || !useradmin.getRole().equals("ROLE_ADMIN")) {
        response.sendRedirect("/admin/login");
    } else {
        ImageRepo imageRepo = new ImageRepo();
        imageList = imageRepo.getAllImageUrl();
    }
%>

<jsp:include page="header.jsp"></jsp:include>

<div>
    <div class="d-flex container">
        <jsp:include page="menu.jsp"></jsp:include>

        <div id="rightContent" class="d-flex flex-column">
            <h3>Cập nhật danh mục</h3>
            <form action="/update_category" method="post" enctype="multipart/form-data">
                <div class="container">
                    <div>
                        <span><input type="hidden" class="sedang" name="maDanhMuc"
                                     value="<%=category.getCategoryID()%>"><%=error%>
                        </span>
                    </div>

                    <%if (request.getAttribute("error") != null) {%>
                    <div class="item-contain">
                        <span class="pro-item-left">
                            <%=request.getAttribute("error")%>
                        </span>
                        <span></span>
                    </div>
                    <% } %>

                    <div class="item-contain">
                        <span class="pro-item-left"><b>Chọn ảnh đại diện</b></span>
                        <span class="pro-item-right">
                            <span id="image-display">
                                <img class='image' src='<%=category.getCategoryImage()%>'>
                                <input type="hidden" value='<%=category.getCategoryImage()%>' name="image">
                            </span>
                            <button type="button" id="btn-select-image" class="btn btn-primary">Chọn ảnh</button>
                        </span>
                    </div>

                    <div class="item-contain">
                        <span class="pro-item-left" style="float: right"><b>Tên danh mục</b></span>
                        <span class="pro-item-right">
                            <input type="text" class="sedang" name="tenDanhMuc" value="<%=category.getCategoryName()%>">
                        </span>
                    </div>

                    <div class="item-contain">
                        <span class="pro-item-left"></span>
                        <span class="pro-item-right">
                            <input type="submit" class="btn btn-primary" value="Lưu dữ liệu">
                        </span>
                    </div>

                </div>
            </form>
        </div>
        <div class="clear"></div>
    </div>


    <!-- Modal select image -->
    <div class="modal fade" id="modal" role="dialog">
        <div class="modal-dialog" style="max-width: 800px;width: auto">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <span class="modal-title">Chọn ảnh</span>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body" id="modal-content">
                    <div class="images-contain">
                        <%
                            for (int i = 0; i < imageList.size(); i++) {
                        %>

                        <div class="image-contain-item">
                            <input type="hidden" id="imageUrl" value="<%=imageList.get(i).getImageUrl()%>">
                            <img class="image" src="<%=imageList.get(i).getImageUrl()%>" alt="">
                            <div><%=imageList.get(i).getImageName()%>
                            </div>
                        </div>

                        <%}%>
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="btn-close" type="button" class="btn btn-primary" data-dismiss="modal">Đóng</button>
                </div>
            </div>

        </div>
    </div>

    <script>
        $('#btn-select-image').on('click', function () {
            $('#modal').modal('show');
        })

        $('.image').on('click', function () {
            var imageUrl = $(this).parent().find('#imageUrl').val();
            $('#image-display').html('' +
                '<img class=\'image\' src=\"' + imageUrl + '\" >' +
                '<input type="hidden" value="' + imageUrl + '" name=\"image\">');
            $('#modal').modal('hide');
        })
    </script>

    <jsp:include page="footer.jsp"></jsp:include>

</div>
</body>
</html>
