<%@page import="java.text.DecimalFormat" %>
<%@page import="java.util.Map" %>
<%@page import="com.tainguyen.demo.model.Item" %>
<%@page import="com.tainguyen.demo.model.Cart" %>
<%@ page import="com.tainguyen.demo.model.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Hutech SHOP</title>
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
    User users = (User) session.getAttribute("user");
    Cart cart = new Cart();
    DecimalFormat formatter = new DecimalFormat("###,###,###");
    if (users == null) {
        response.sendRedirect("/index");
    } else {
        cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);

        }
    }
%>
<jsp:include page="header.jsp"></jsp:include>

<div class="check-out">
    <div class="container">
        <table class="table">
            <tr>
                <th class="t-head">Hình ảnh</th>
                <th class="t-head ">Mặt Hàng</th>
                <th class="t-head">Giá</th>
                <th class="t-head">Số Lượng</th>
                <th class="t-head"></th>
            </tr>

            <%for (Map.Entry<Long, Item> list : cart.getCartItems().entrySet()) {%>
            <tr class="cross1">
                <td class="t-data">
                    <a href="single?productID=<%=list.getValue().getProductEntity().getProductID()%>" class="at-in">
                        <img src="<%=list.getValue().getProductEntity().getProductImage()%>" class="fashion-grid" alt="">
                    </a>
                </td>
                <td class="t-data">

                    <h3><%=list.getValue().getProductEntity().getProductName()%>
                    </h3>
                </td>
                <td class="t-data"><%=formatter.format(list.getValue().getProductEntity().getProductPrice())%> VNĐ</td>
                <td class="t-data">
                    <div class="quantity-checkout">
                        <div class="quantity-select">
                            <div class="productId"
                                 style="display: none"><%=list.getValue().getProductEntity().getProductID()%>
                            </div>

                            <div class="entry value-minus">&nbsp;</div>
                            <div class="entry value"><span class="span-1"><%=list.getValue().getQuantity()%></span>
                            </div>
                            <div class="entry value-plus active">&nbsp;</div>
                        </div>
                    </div>
                </td>

                <td class="t-data">
                    <a href="CartServlet?command=remove&productID=<%=list.getValue().getProductEntity().getProductID()%>">
                        <img src="img/circle.png" class="img-responsive " alt=""></a>
                </td>

            </tr>
            <% } %>

        </table>
        <div class=" cart-total">
            <ul class="total_price">
                <li class="last_price"><h2>Tổng Cộng</h2></li>
                <li class="last_price"><span id="total"><%=formatter.format(cart.totalCart())%></span> VNĐ</li>
                <div class="clearfix"></div>
            </ul>

            <div id="pay">Chốt đơn</div>
        </div>


    </div>
</div>

<!-- Modal mesage-->
<div class="modal fade" id="modal" role="dialog">
    <div class="modal-dialog" style="max-width: 800px;width: auto">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-title">Thông Báo</span>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body" id="modal-content">

            </div>
            <div class="modal-footer">
                <button id="btn-close" type="button" class="btn btn-primary" data-dismiss="modal">Đóng</button>
            </div>
        </div>

    </div>
</div>

<script>
    // quantity plus
    $('.value-plus').on('click', function () {
        var productID = $(this).parent().find('.productId').html();
        window.location.href = "/CartServlet?command=plus&productID=" + productID;
    });

    // quantity minus
    $('.value-minus').on('click', function () {
        var productID = $(this).parent().find('.productId').html();
        window.location.href = "/CartServlet?command=minus&productID=" + productID;
    });

    var isCheckoutSuccess = false;

    // Chốt đơn
    $('#pay').on('click', function () {
        $.post('/CheckOutServlet', {},
            function (data) {
                if (data == 'success') {
                    $('#modal-content').html('Chốt đơn thành công');
                    $('#modal').modal('show');
                    isCheckoutSuccess = true;
                } else {
                    $('#modal-content').html(data);
                    $('#modal').modal('show');
                }
            });
    })

    $('#btn-close').on('click', function () {
        if (isCheckoutSuccess)
            window.location.href = "/index"
    })
</script>

<div class="social animated wow fadeInUp" data-wow-delay=".1s">

</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
