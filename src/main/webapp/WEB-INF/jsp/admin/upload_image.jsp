<%@ page import="com.tainguyen.demo.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tainguyen.demo.repository.ImageRepo" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.tainguyen.demo.model.ImageUrl" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Thêm Thương Hiệu</title>

    <c:set var="root" value="${pageContext.request.contextPath}"/>
    <link href="${root}/css/mos-style.css" rel='stylesheet' type='text/css'/>
    <link href="${root}/css/style.css" rel="stylesheet" type="text/css" media="all"/>
    <link href="${root}/css/bootstrap.css" rel="stylesheet" type="text/css" media="all"/>

</head>
<body>
<%
    String error = "";
    ArrayList<ImageUrl> imageList = new ArrayList();

    if (request.getParameter("error") != null) {
        error = (String) request.getParameter("error");
    }

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

        <div id="rightContent">
            <h3>UPLOAD ẢNH</h3>

            <form action="/upload_image" method="post" enctype="multipart/form-data">
                <div><b>Chọn ảnh</b></div>
                <div>
                    <input type="file" placeholder="images/tênhình.jpg" class="sedang"
                           name="image"
                           id="image" multiple>
                </div>
                <br>
                <div><b>Ảnh đã upload</b></div>
                <div>
                    <div class="image-contain">
                        <%
                            for (int i = 0; i < imageList.size(); i++) {
                        %>

                        <div class="d-flex flex-column mr-1 ml-1 mb-2">
                            <img class="image" src="<%=imageList.get(i).getImageUrl()%>" alt="">
                            <div class="mt-02"><%=imageList.get(i).getImageName()%>
                            </div>
                        </div>

                        <%}%>
                    </div>
                </div>

                <div>
                    <input type="submit" class="button" value="Upload ảnh">
                </div>
            </form>
        </div>
        <div class="clear"></div>
    </div>
    <jsp:include page="footer.jsp"></jsp:include>

</div>


</body>
</html>

