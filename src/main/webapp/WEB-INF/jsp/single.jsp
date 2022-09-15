<%@page import="java.text.DecimalFormat" %>
<%@page import="com.tainguyen.demo.repository.CategoryGet" %>
<%@page import="com.tainguyen.demo.repository.ProductRepo" %>
<%@ page import="com.tainguyen.demo.model.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>THÔNG TIN SẢN PHẨM</title>
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
    <link href="/css/bootstrap.css" rel="stylesheet" type="text/css" media="all"/>
    <link href="/css/easyzoom.css" rel="stylesheet" type="text/css" media="all"/>
    <link href="/css/style.css" rel="stylesheet" type="text/css" media="all"/>
    <link rel="stylesheet" href="/css/starability-all.min.css">

    <!-- js -->
    <script src="/js/jquery.min.js"></script>
    <!-- //js -->
    <!-- cart -->
    <script src="/js/simpleCart.min.js"></script>
    <script src="/js/formatmoney.js"></script>
    <!-- cart -->
    <!-- for bootstrap working -->
    <script type="text/javascript" src="/js/bootstrap-3.1.1.min.js"></script>
    <!-- //for bootstrap working -->
    <!-- animation-effect -->
    <link href="/css/animate.min.css" rel="stylesheet">
    <script src="/js/wow.min.js"></script>
    <script src="/js/jquery.priceformat.min.js"></script>

    <script>
        new WOW().init();
    </script>
    <!-- //animation-effect -->
    <link href='//fonts.googleapis.com/css?family=Cabin:400,500,600,700' rel='stylesheet' type='text/css'>
    <link href='//fonts.googleapis.com/css?family=Lato:400,100,300,700,900' rel='stylesheet' type='text/css'>

    <meta property="fb:app_id" content="Your_App_ID"/>
    <meta property="fb:admins" content="User_ID"/>
</head>

<script>(function (d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s);
    js.id = id;
    js.src = "//connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v2.3&appId=Your_App_ID";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
</script>


<meta property="fb:app_id" content="396733747363745"/>
<meta property="fb:admins" content="100002505084014"/>
</head>

<body>

<div id="fb-root"></div>
<script>(function (d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s);
    js.id = id;
    js.src = "//connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v2.8&appId=396733747363745";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

<%
    ProductRepo productGet = new ProductRepo();
    ProductDisplayDto productDisplayDto = new ProductDisplayDto();
    String productID = "";
    if (request.getParameter("productID") != null) {
        productID = request.getParameter("productID");
        productDisplayDto = productGet.getProduct(Long.parseLong(productID));
    }
    long category_id = productDisplayDto.getCateId();
    CategoryGet categoryget = new CategoryGet();
    DecimalFormat formatter = new DecimalFormat("###,###,###");

    User user = (User) session.getAttribute("user");
%>

<jsp:include page="header.jsp"></jsp:include>

<div class="product">
    <input type="hidden" id="userId" value="<%=user == null ? null : user.getUserID()%>">
    <input type="hidden" id="productId" value="<%=user == null ? null : productDisplayDto.getProductId()%>">
    <input type="hidden" id="numberSizeInColor"
           value="<%=productDisplayDto.getProductDetailList().size() / productDisplayDto.getProductColorImageList().size()%>">
    <input type="hidden" id="totalSize"
           value="<%=productDisplayDto.getProductDetailList().size()%>">

    <div class="container">
        <div class="contain-product">
            <div class="col-md-3 product-bottom ">
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
                <div class="sellers animated wow fadeInDown" data-wow-delay=".5s">

                    <h3 class="best">Bán Chạy Nhất</h3>
                    <div class="product-head">
                        <%
                            for (ProductDisplayDto p : productGet.getProductsByNumber()) {
                        %>
                        <div class="product-go">
                            <div class=" fashion-grid">
                                <a href="single?productID=<%=p.getProductId()%>">
                                    <img class="img-responsive" src="<%=p.getProductImageList() == null ? "" :  p.getProductImageList().get(0).getImageUrl()%>"
                                         alt="">
                                </a>
                            </div>

                            <div class="fashion-grid1">
                                <h6 class="best2">
                                    <a href="single?productID=<%=p.getProductId()%>"><%=p.getProductName()%>
                                    </a>
                                </h6>

                                <p>
                                    <a style="display: <%=user == null ? "inline-block" : "none"%>"
                                       href="/account/loginForm"
                                       data-text="Đăng nhâp để mua hàng" class="but-hover1 item_add">
                                        Đăng nhâp để mua hàng
                                    </a>
                                </p>
                            </div>

                            <div class="clearfix"></div>
                        </div>
                        <% } %>


                    </div>
                </div>
                <!---->
            </div>
            <div class="col-md-9 animated wow fadeInRight" data-wow-delay=".5s">
                <div class="d-flex flex-column">
                    <div class="row">
                        <div class="col-md-5">
                            <div class="flexslider">
                                <ul class="slides">
                                    <%
                                        for (int i = 0; i < productDisplayDto.getProductImageList().size(); i++) {
                                    %>

                                    <li data-thumb="<%=productDisplayDto.getProductImageList().get(i).getImageUrl()%>">
                                        <div class="thumb-image">
                                            <img src="<%=productDisplayDto.getProductImageList().get(i).getImageUrl()%>"
                                                 data-imagezoom="true"
                                                 class="img-responsive">
                                        </div>
                                    </li>

                                    <%}%>
                                </ul>
                            </div>
                        </div>

                        <div class="col-md-7 single-top-in">
                            <div class="span_2_of_a1 simpleCart_shelfItem">
                                <h3><%=productDisplayDto.getProductName()%>
                                </h3>
                                <h6 class="mb-2 mt-02"><%=productDisplayDto.getProductCode()%>
                                </h6>

                                <h4>Chọn màu</h4>

                                <ul class="tab-list">
                                    <%
                                        for (int i = 0; i < productDisplayDto.getProductColorImageList().size(); i++) {
                                    %>
                                    <li class="tab-list-item tab-image-item<%=i%>">
                                        <input type="hidden" class="numberOfColor" value="<%=i%>">
                                        <img class="img-pro-detail"
                                             src="<%=productDisplayDto.getProductColorImageList().get(i).getImageUrl()%>">
                                    </li>
                                    <%}%>
                                    <div class="clearfix"></div>
                                </ul>

                                <div id="size-container">
                                    <h4>Chọn kích thước</h4>
                                    <%
                                        for (int i = 0; i < productDisplayDto.getProductDetailList().size(); i++) {
                                    %>
                                    <div class="numberOfSize<%=i%> size-container-item">
                                        <input class="color-id" type="hidden" value="<%=productDisplayDto.getProductDetailList().get(i).getProductColorId()%>">

                                        <div class="size-name-item flex-grow-1"><%=productDisplayDto.getProductDetailList().get(i).getName()%></div>
                                        <input class="size-name-id" type="hidden" value="<%=productDisplayDto.getProductDetailList().get(i).getProductSizeId()%>">

                                        <div class="size-price-item text-right"><%=formatter.format(productDisplayDto.getProductDetailList().get(i).getPrice())%> vnđ</div>
                                        <input class="size-price" type="hidden" value="<%=productDisplayDto.getProductDetailList().get(i).getPrice()%>">

                                        <div class="inventory text-right"><%=productDisplayDto.getProductDetailList().get(i).getInventory()%> sản phẩm</div>

                                        <div class="size-quantity">
                                            <button class="value-minus"
                                                    onclick="minus(this)">
                                                -
                                            </button>
                                            <input class="quantity" type="text"
                                                   value="0"
                                                   onkeyup="checkInputQuantity(this, <%=productDisplayDto.getProductDetailList().get(i).getInventory()%>)">
                                            <button class="value-plus"
                                                    onclick="plus(this, <%=productDisplayDto.getProductDetailList().get(i).getInventory()%>)">
                                                +
                                            </button>
                                        </div>
                                    </div>
                                    <%}%>
                                </div>

                                <div class="form-group">
                                    <label>Ghi chú</label>
                                    <textarea class="pl-1" rows="4" style="width: 100%"
                                              id="user-note"></textarea>
                                </div>
                                <div class="clearfix"></div>
                            </div>

                            <% if (user == null) {%>
                                <a href="/account/loginForm"
                                   data-text="Đăng nhâp để mua hàng" class="but-hover1 btn-add">
                                        Đăng nhâp để mua hàng
                                </a>
                            <% } else {
                                    if (productDisplayDto.isActive()) {%>
                                        <button onclick="checkout()"
                                                data-text="Đặt hàng" class="but-hover1 btn-add">
                                                    Đặt hàng
                                        </button>
                                    <%} else {%>
                                        <button onclick="checkout()"
                                                data-text="Đặt hàng" class="btn-add" disabled>
                                                    Tạm ngừng bán
                                        </button>
                                    <%}
                            }%>

                        </div>
                    </div>
                    <div>
                        <h2 class="mt-2 animated wow fadeInLeft" data-wow-delay=".5s">Mô Tả Sản Phẩm</h2>
                        <div>
                            <div class="facts animated wow fadeInDown" data-wow-delay=".5s">
                                <p><%=productDisplayDto.getDescription()%>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="clearfix"></div>
        <div class="page-header">
            <h3>SẢN PHẨM LIÊN QUAN</h3>
        </div>
        <div class=" col-md-si">
            <%
                for (ProductDisplayDto p : productGet.getListProductRelated(category_id, Long.parseLong(productID))) {
            %>
            <div class="col-sm-5 item-grid simpleCart_shelfItem">

                <div class="grid-pro">
                    <div class=" grid-product">
                        <figure>
                            <a href="single?productID=<%=p.getProductId()%>">
                                <div class="grid-img">
                                    <img src="<%=p.getProductImageList() == null ? "" : p.getProductImageList().get(0).getImageUrl()%>" class="img-responsive"
                                         alt="">
                                </div>
                            </a>
                        </figure>
                    </div>
                    <div class="women">
                        <h6><a href="single?productID=<%=p.getProductId()%>"><%=p.getProductName()%>
                        </a></h6>

                        <a style="display: <%=user == null ? "block" : "none"%>"
                           data-text="Đăng nhâp để mua hàng" class="but-hover1 item_add">
                            Đăng nhâp để mua hàng
                        </a>

                    </div>
                </div>

            </div>
            <% } %>

            <div class="clearfix"></div>
        </div>
        <div class="clearfix"></div>
    </div>
    <div class="clearfix"></div>
</div>
<jsp:include page="footer.jsp"></jsp:include>

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

<script src="/js/imagezoom.js"></script>

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script defer src="/js/jquery.flexslider.js"></script>
<link rel="stylesheet" href="/css/flexslider.css" type="text/css" media="screen"/>

<script>
    // Can also be used with $(document).ready()
    $(window).load(function () {
        $('.flexslider').flexslider({
            animation: "slide",
            controlNav: "thumbnails"
        });
    });

    // initialize
    $(function () {
        // Số thứ tự của ảnh được chọn
        let numberOfColor = 0;
        // Số lượng size trong 1 ảnh
        let numberSizeInColor = $('#numberSizeInColor').val();
        // Tổng số lượng size
        let totalSize = $('#totalSize').val();

        // hide all item
        for (let i = 0; i < totalSize; i++) {
            $('.numberOfSize' + i).hide();
        }

        // Vị trí của các size cần hiển thị
        let id = numberOfColor * numberSizeInColor;
        // Hiển thị size theo màu
        for (let i = 0; i < numberSizeInColor; i++) {
            $('.numberOfSize' + id).show();
            id++;
        }

        // Show border image selected
        $('.tab-image-item0').css('border', '1px solid #ff0000');
    });

    /** Hiển thị list size theo màu chọn */
    $('.img-pro-detail').on('click', function () {
        // Số thứ tự của ảnh được chọn
        let numberOfColor = $(this).parent().find('.numberOfColor').val();
        // Số lượng size trong 1 ảnh
        let numberSizeInColor = $('#numberSizeInColor').val();
        // Tổng số lượng size
        let totalSize = $('#totalSize').val();
        // Số lượng ảnh color
        let totalColorImage = totalSize / numberSizeInColor;

        // Hide all item
        for (let i = 0; i < totalSize; i++) {
            $('.numberOfSize' + i).hide();
        }

        // Vị trí của các size cần hiển thị
        let id = numberOfColor * numberSizeInColor;
        // Hiển thị size theo màu
        for (let i = 0; i < numberSizeInColor; i++) {
            $('.numberOfSize' + id).show();
            id++;
        }

        // Hide all image
        for (let i = 0; i < totalColorImage; i++) {
            $('.tab-image-item' + i).css('border', 'none');
        }

        // Show border image selected
        $('.tab-image-item' + numberOfColor).css('border', '1px solid #ff0000');
    })

    var isSuccess = false;

    /** Handle checkout event */
    function checkout() {
        let billDetailEntityList = [];

        let userId = $("#userId").val();
        let productId = $("#productId").val();
        let userNote = $("#user-note").val();

        let totalQuantity = 0, totalPrice = 0;
        // Tính tổng số sản phẩm order và tổng giá trị của đơn hàng
        for (let i = 0; i < $('#size-container').find('.size-container-item').size(); i++) {
            let sizes = $('#size-container').find('.numberOfSize' + i);

            let colorId = sizes.find('.color-id').val();
            let sizeNameId = sizes.find('.size-name-id').val();
            let sizePrice = sizes.find('.size-price').val();
            let sizeQuantity = sizes.find('.size-quantity .quantity').val();

            if (!isNaN(sizeQuantity) && sizeQuantity != 0) {
                console.log("Number(sizePrice):" + Number(sizePrice));
                console.log("sizeQuantity:" + sizeQuantity);

                totalPrice += Number(sizePrice) * sizeQuantity;
                totalQuantity += Number(sizeQuantity);

                let billDetailEntity = {
                    'productId': productId,
                    'colorId': colorId,
                    'sizeId': sizeNameId,
                    'quantity': sizeQuantity,
                }

                billDetailEntityList.push(billDetailEntity);
            }
        }

        // Validate
        if (totalQuantity == 0 | totalPrice == 0) {
            alert("Bạn chưa chọn sản phẩm")
            return;
        }

        $.ajax({
            url: '/checkout',
            dataType: 'text',
            type: 'POST',
            cache: false,
            contentType: 'application/json',
            data: JSON.stringify(
                {
                    'userId': userId,
                    'productId': productId,
                    'userNote': userNote,
                    'totalQuantity': totalQuantity,
                    'totalPrice': totalPrice,
                    'billDetailEntityList': billDetailEntityList
                }
            ),
            success: function (data) {
                alert(data);
                location.reload();
            },
            error: function (data) {
                alert(data)
                location.reload();
            }
        })
    }

    /** Validate input */
    function checkInputQuantity(event, inventory) {
        if (event.value > inventory || isNaN(event.value)) {
            $(event).val(inventory);
        }
    }

    /** Handle plus event */
    function plus(event, inventory) {
        let value = $(event).parent().find('.quantity');
        if (Number(value.val()) + 1 > inventory) {
            value.val(inventory);
        } else {
            value.val(Number(value.val()) + 1);
        }
    }

    /** Handle minus event */
    function minus(event) {
        let value = $(event).parent().find('.quantity');
        if (Number(value.val()) - 1 < 0) {
            value.val(0);
        } else {
            value.val(Number(value.val()) - 1);
        }
    }

</script>

</body>
</html>
