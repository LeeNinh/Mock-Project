<%@page import="java.text.DecimalFormat" %>
<%@page import="com.tainguyen.demo.repository.CategoryGet" %>
<%@page import="com.tainguyen.demo.model.Category" %>
<%@page import="com.tainguyen.demo.model.ProductEntity" %>
<%@page import="com.tainguyen.demo.repository.ProductRepo" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tainguyen.demo.model.ProductDisplayDto" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>SẢN PHẨM</title>
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
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all"/>
    <link href="css/style.css" rel="stylesheet" type="text/css" media="all"/>
    <!-- js -->
    <script src="js/jquery.min.js"></script>
    <!-- //js -->
    <!-- cart -->
    <script src="js/simpleCart.min.js"></script>
    <!-- cart -->
    <!-- for bootstrap working -->
    <script type="text/javascript" src="js/bootstrap-3.1.1.min.js"></script>
    <!-- //for bootstrap working -->
    <!-- animation-effect -->
    <link href="css/animate.min.css" rel="stylesheet">
    <script src="js/wow.min.js"></script>
    <script>
        new WOW().init();
    </script>
    <!-- //animation-effect -->
    <link href='//fonts.googleapis.com/css?family=Cabin:400,500,600,700' rel='stylesheet' type='text/css'>
    <link href='//fonts.googleapis.com/css?family=Lato:400,100,300,700,900' rel='stylesheet' type='text/css'>
</head>
<body>
<%
    CategoryGet categoryget = new CategoryGet();
    ProductRepo productGet = new ProductRepo();

    String category_id = "";
    if (request.getParameter("category") != null) {
        category_id = request.getParameter("category");
    }

    String key = request.getAttribute("key") != null ? request.getAttribute("key").toString() : null;
    List<ProductDisplayDto> productEntityArrayList;
    if (key != null) {
        productEntityArrayList = productGet.searchByName(key);
    } else {
        productEntityArrayList = productGet.getListProductByCategory(Long.parseLong(category_id));
    }
    DecimalFormat formatter = new DecimalFormat("###,###,###");


%>
<jsp:include page="header.jsp"></jsp:include>

<div class="productEntity">
    <div class="container">
        <div class="col-md-3 productEntity-bottom">
            <!--categories-->
            <div class="categories animated wow fadeInUp animated" data-wow-delay=".5s">
                <h3>Loại Sản Phẩm</h3>
                <ul class="cate">
                    <%
                        for (Category c : categoryget.getListCategory()) {
                    %>
                    <li><i class="glyphicon glyphicon-menu-right"></i><a
                            href="products?category=<%=c.getCategoryID()%>"><%=c.getCategoryName()%>
                    </a></li>
                    <% } %>
                </ul>
            </div>
            <!--//menu-->
            <div class="sellers animated wow fadeInUp" data-wow-delay=".5s">

                <h3 class="best">Bán Chạy Nhất</h3>
                <div class="productEntity-head">
                    <%
                        for (ProductDisplayDto p : productGet.getProductsByNumber()) {
                    %>
                    <div class="productEntity-go">
                        <div class=" fashion-grid">
                            <a href="single?productID=<%=p.getProductId()%>">
                                <img class="img-responsive "
                                     src="<%=p.getProductImageList().get(0).getImageUrl()%>"
                                     alt=""></a>
                        </div>
                        <div class=" fashion-grid1">
                            <h6 class="best2">
                                <a href="single?productID=<%=p.getProductId()%>"><%=p.getProductName()%></a>
                            </h6>
                            <p><a href="CartServlet?command=plus&productID=<%=p.getProductId()%>"
                                  data-text="Thêm vào giỏ" class="but-hover1 item_add">Thêm vào giỏ</a></p>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <% } %>

                </div>
            </div>
        </div>

        <div class="col-md-9 animated wow fadeInRight" data-wow-delay=".5s">

            <div class="mid-popular">
                <%
                    for (ProductDisplayDto p : productEntityArrayList) {
                %>
                <div class="col-sm-4 item-grid item-gr  simpleCart_shelfItem">

                    <div class="grid-pro">
                        <div class=" grid-productEntity ">
                            <figure>
                                <a href="single?productID=<%=p.getProductId()%>">
                                    <div class="grid-img">
                                        <img src="<%=p.getProductImageList().get(0).getImageUrl()%>"
                                             class="img-responsive" alt="">
                                    </div>
                                </a>
                            </figure>
                        </div>
                        <div class="women">
                            <a href="#"><img src="" alt=""></a>
                            <h6><a href="single?productID=<%=p.getProductId()%>"><%=p.getProductName()%>
                            </a></h6>

                            <a href="CartServlet?command=plus&productID=<%=p.getProductId()%>" data-text="Thêm vào giỏ"
                               class="but-hover1 item_add">Thêm vào giỏ</a>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>

                <div class="clearfix"></div>
            </div>
        </div>

        <div class="clearfix"></div>
    </div>

    <div class="contact-contain">
        <a href="https://zalo.me/0919966368" target="_blank">
            <img src="./img/zalotu.png" class="contact-icon">
        </a>
        <br>
        <span class="phone-box">
    <a href="tel:0919966368">
        <span class="contact-icon">
        <img src="./img/telephone.png" style="width: 34px">
        </span>
    </a>
    </span>
    </div>

    <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
