<%@page import="java.text.DecimalFormat" %>
<%@page import="com.tainguyen.demo.model.ProductEntity" %>
<%@page import="com.tainguyen.demo.repository.ProductRepo" %>
<%@ page import="com.tainguyen.demo.repository.CategoryGet" %>
<%@ page import="com.tainguyen.demo.model.Category" %>
<%@ page import="com.tainguyen.demo.model.User" %>
<%@ page import="com.tainguyen.demo.model.ProductDisplayDto" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
</head>
<body>
<%
    CategoryGet categoryGet = new CategoryGet();
    ProductRepo productGet = new ProductRepo();

    DecimalFormat formatter = new DecimalFormat("###,###,###");

    User user = (User) session.getAttribute("user");

%>

<%--<img src="/img/backgound.jpg" alt="">--%>
<div class="container mb-5">
    <div class="flashsale-title">
        FLASH SALE
    </div>
    <div class="animated wow fadeInRight" data-wow-delay=".1s" style="margin-bottom: 15px">
        <%
            for (ProductDisplayDto p : productGet.getProductsByNumber()) {
        %>

        <div class="col-sm-4 item-grid simpleCart_shelfItem">
            <div class="grid-pro">
                <div class=" grid-productEntity ">
                    <figure>
                        <a href="single?productID=<%=p.getProductId()%>">
                            <div class="grid-img">
                                <img src="<%=p.getProductImageList().size() == 0 ? "" : p.getProductImageList().get(0).getImageUrl()%>"
                                     class="img-responsive" alt="">
                            </div>
                        </a>
                    </figure>
                </div>
                <div class="women">
                    <h6>
                        <a href="single?productID=<%=p.getProductId()%>"><%=p.getProductName()%>
                        </a>
                    </h6>

                    <a style="display: <%=user == null ? "inline-block" : "none"%>"
                       href="/account/loginForm"
                       data-text="Đăng nhâp để mua hàng" class="but-hover1 item_add">
                        Đăng nhâp để mua hàng
                    </a>

                </div>
            </div>
        </div>

        <% } %>
        <div class="clearfix"></div>
    </div>
</div>

<%--<div class="container mb-5">--%>
<%--    <div class="cate-title">--%>
<%--        DANH MỤC SẢN PHẨM--%>
<%--    </div>--%>
<%--    <div class="animated wow fadeInRight" data-wow-delay=".1s" style="margin-bottom: 15px">--%>
<%--        <%--%>
<%--            for (Category category : categoryGet.getList6Category()) {--%>
<%--        %>--%>

<%--        <div class="col-sm-4 item-grid simpleCart_shelfItem">--%>
<%--            <div class="grid-pro">--%>
<%--                <div class=" grid-productEntity ">--%>
<%--                    <figure>--%>
<%--                        <a href="/products?category=<%=category.getCategoryID()%>">--%>
<%--                            <div class="grid-img">--%>
<%--                                <img src="<%=category.getCategoryImage()%>" class="img-responsive" alt="">--%>
<%--                            </div>--%>
<%--                        </a>--%>
<%--                    </figure>--%>
<%--                </div>--%>
<%--                <div class="women">--%>
<%--                    <h6><a href="/products?category=<%=category.getCategoryID()%>"><%=category.getCategoryName()%>--%>
<%--                    </a></h6>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <% } %>--%>
<%--        <div class="clearfix"></div>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<div class="container">--%>
<%--    <div class="sale-title">--%>
<%--        SẢN PHẨM BÁN CHẠY--%>
<%--    </div>--%>
<%--    <div class="animated wow fadeInRight" data-wow-delay=".1s" style="margin-bottom: 15px">--%>
<%--        <%--%>
<%--            for (ProductDisplayDto p : productGet.getProductsByNumber()) {--%>
<%--        %>--%>

<%--        <div class="col-sm-4 item-grid simpleCart_shelfItem">--%>
<%--            <div class="grid-pro">--%>
<%--                <div class=" grid-productEntity ">--%>
<%--                    <figure>--%>
<%--                        <a href="single?productID=<%=p.getProductID()%>">--%>
<%--                            <div class="grid-img">--%>
<%--                                <img src="<%=p.getProductImageBack()%>" class="img-responsive" alt="">--%>
<%--                            </div>--%>
<%--                            <div class="grid-img">--%>
<%--                                <img src="<%=p.getProductImageForward()%>" alt="" width="132%" height="180"--%>
<%--                                     class="img-responsive">--%>
<%--                            </div>--%>
<%--                        </a>--%>
<%--                    </figure>--%>
<%--                </div>--%>
<%--                <div class="women">--%>

<%--                    <h6><a href="single?productID=<%=p.getProductID()%>"><%=p.getProductName()%>--%>
<%--                    </a></h6>--%>
<%--                    <p><em class="item_price"><%=formatter.format(p.getProductPrice())%> VNĐ</em></p>--%>
<%--                    <a style="display: <%=user == null ? "inline-block" : "none"%>"--%>
<%--                       href="/account/loginForm"--%>
<%--                       data-text="Đăng nhâp để mua hàng" class="but-hover1 item_add">--%>
<%--                        Đăng nhâp để mua hàng--%>
<%--                    </a>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <% } %>--%>
<%--        <div class="clearfix"></div>--%>
<%--    </div>--%>

<%--</div>--%>

</body>
</html>
