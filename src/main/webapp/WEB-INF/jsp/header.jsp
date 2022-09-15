<%@page import="java.text.DecimalFormat" %>
<%@page import="com.tainguyen.demo.model.Cart" %>
<%@page import="com.tainguyen.demo.model.User" %>
<%@page import="com.tainguyen.demo.model.Category" %>
<%@page import="com.tainguyen.demo.repository.CategoryGet" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>header</title>
</head>
<body>

<%

    CategoryGet categoryget = new CategoryGet();
    User user = null;
    if (session.getAttribute("user") != null) {
        user = (User) session.getAttribute("user");
    }

    Cart cart = (Cart) session.getAttribute("cart");
    if (cart == null) {
        cart = new Cart();
        session.setAttribute("cart", cart);
    }
    DecimalFormat formatter = new DecimalFormat("###,###,###");
%>
<div class="header">
    <div class="header-grid">
        <div class="container">
            <div class="header-left animated wow fadeInLeft" data-wow-delay=".5s">
                <ul>
                    <li><i class="glyphicon glyphicon-headphones"></i><a href="tel:0919966368">Hỗ trợ 24/7</a></li>
                </ul>
            </div>
            <div class="header-right animated wow fadeInRight" data-wow-delay=".5s">
                <div class="header-right2">
                    <ul style="margin-top: 7px">
                        <%if (user != null) { %>
                        <li><i class="glyphicon glyphicon-user"></i><a href="/myaccount">Chào <%=user.getUserName()%>
                        </a></li>
                        <% } %>
                        <%if (user == null) { %>
                        <li><i class="glyphicon glyphicon-pencil"></i><a href="/account/registerForm">Đăng Ký</a></li>
                        <li><i class="glyphicon glyphicon-log-in"></i><a href="/account/loginForm">Đăng Nhập</a></li>
                        <% } %>

                    </ul>
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    <div class="container">
        <div class="logo-nav">
            <nav class="navbar">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header nav_2">
                    <div class="navbar-brand logo-nav-left logo">
                        <span class="animated wow pulse" data-wow-delay=".5s">
                            <a href="/">
                                <img style="height: 150px" src="../img/iconWeb.jpg" alt="">
                            </a>
                        </span>
                    </div>
                    <button type="button" class="navbar-toggle collapsed navbar-toggle1" data-toggle="collapse"
                            data-target="#bs-megadropdown-tabs">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>
                <div class="d-flex">
                    <span class="phone-contain">
                        <div style="margin-right: 15px; padding-top: 6px">
                            <img src="../img/phoneTop.png">
                        </div>
                        <div class="phone-contact">
                            <span class="title">
                                Hotline
                            </span>
                            <span class="phone-top">
                                <a href="tel:0919966368" style="color: red; text-decoration: none">
                                    0919966368
                                </a>
                            </span>
                        </div>
                    </span>
                </div>
                <div class="d-flex search-contain">
                    <input class="input-search mr-1" type="text">
                    <button onclick="search()" class="btn-search mr-1">TÌM KIẾM</button>
                </div>
                <div class="collapse navbar-collapse" id="bs-megadropdown-tabs">
                    <div class="d-flex flex-column">
                        <ul class="nav navbar-nav" style="margin-left: 43px">
                            <li class="active"><a href="/" class="act">Trang Chủ</a></li>
                            <!-- Mega Menu -->
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dòng sản phẩm <b
                                        class="caret"></b></a>
                                <ul class="dropdown-menu multi">
                                    <div class="row">
                                        <div class="">
                                            <ul class="multi-column-dropdown">
                                                <h4>DUONG LIEN ORDER</h4>
                                                <%
                                                    for (Category c : categoryget.getListCategory()) {
                                                %>
                                                <li>
                                                    <a href="products?category=<%=c.getCategoryID()%>">
                                                        <img class="img-cate-header" src="<%=c.getCategoryImage()%>">
                                                        <span class="pl-1"><%=c.getCategoryName()%></span>
                                                    </a></li>
                                                <%
                                                    }
                                                %>

                                            </ul>
                                        </div>

                                        <div class="clearfix"></div>
                                    </div>
                                </ul>
                            </li>
                            <li><a href="/intro">Giới thiệu</a></li>
                            <li><a href="/conduct">Hướng dẫn mua hàng</a></li>
                            <%if (user != null) {%>
                            <li><a href="/history">Đơn hàng</a></li>
                            <%}%>
                            <li><a href="/contact">Góp ý</a></li>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>

    </div>
</div>
<script>
    function search() {
        var key = $('.input-search').val();
        window.location.href = "${root}/searchProductByName?key=" + key;
    }
</script>
</body>
</html>
