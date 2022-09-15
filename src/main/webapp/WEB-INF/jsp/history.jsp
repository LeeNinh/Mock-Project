<%@ page import="com.tainguyen.demo.model.User" %>
<%@ page import="com.tainguyen.demo.model.BillDto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.tainguyen.demo.repository.BillGet" %>
<%@ page import="com.tainguyen.demo.model.ProductSizeEntity" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>LIÊN HỆ CHÚNG TÔI</title>
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
    ArrayList<BillDto> listHistoryByUser = new ArrayList<>();

    User users = (User) session.getAttribute("user");
    if (users == null) {
        response.sendRedirect("/index");
    } else {
        long user_id = users.getUserID();

        BillGet billGet = new BillGet();
        listHistoryByUser = billGet.getHistoryByUser(user_id);
    }
%>

<jsp:include page="header.jsp"></jsp:include>
<div class="">
    <div class="page-header ml-1">
        <h3>ĐƠN HÀNG</h3>
    </div>
    <%
        for (BillDto billDto : listHistoryByUser) {
    %>

    <div class="d-flex flex-column mr-1 ml-1 mb-2 contain-history">
        <div class="d-flex contain-item">
            <input type="hidden" value="<%=billDto.getProductId()%>">
            <input class="billId" type="hidden" value="<%=billDto.getBillId()%>">
            <img src="<%=billDto.getProductImage().size() != 0 ? billDto.getProductImage().get(0).getImageUrl() : ""%>"
                 class="fashion-grid" alt="">
            <div class="d-flex flex-column mr-1 ml-1">
                <div class="item-contain">
                    <div class="item1">Mã sản phẩm: <%=billDto.getProductCode()%>
                    </div>
                </div>
                <div class="item-contain">
                    <div class="item1">Tên sản phẩm: <%=billDto.getProductName()%>
                    </div>
                </div>
                <div class="item-contain">
                    <div class="item1">Tổng Số lượng: <%=billDto.getTotalQuantity()%>
                    </div>
                </div>
                <div class="item-contain">
                    <div class="item1">Ngày: <%=billDto.getDate()%>
                    </div>
                </div>
                <div class="item-contain">
                    <div class="item1">Trạng
                        thái: <%=billDto.getStatus() == 1 ? "Chờ đặt" : billDto.getStatus() == 2 ? "Đã đặt" : billDto.getStatus() == 3 ?
                                "Về kho" : billDto.getStatus() == 4 ? "Đã giao cho khách" : billDto.getStatus() == 5 ?
                                "Đã hủy" : billDto.getStatus() == 6 ? "Chưa về đủ" : "false"
                        %>
                    </div>
                </div>
                <div class="item-contain">
                    <div class="item1">Ghi chú của user: <%=billDto.getUserNote()%>
                    </div>
                </div>
                <div class="item-contain">
                    <div class="item1">Ghi chú của admin: <%=billDto.getAdminNote()%>
                    </div>
                </div>
            </div>
        </div>
        <%if (billDto.getStatus() == 1) {%>
        <input class="billId" type="hidden" value="<%=billDto.getBillId()%>">
        <button class="btn btn-danger mr-1 ml-1 billCancel">Hủy đơn</button>
        <% } %>
    </div>
    <% } %>

    <!-- Modal mesage confirm-->
    <div class="modal fade" id="modalConfirm" role="dialog">
        <div class="modal-dialog" style="max-width: 800px;width: auto">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <span class="modal-title">Thông Báo</span>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body" id="modal-content-confirm">

                </div>
                <div style="display: none" id="conBillId"></div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Đóng</button>
                    <button type="button" class="btn btn-primary" id="acceptBillCancel">Đồng ý</button>
                </div>
            </div>

        </div>
    </div>

    <!-- Modal display bill detail -->
    <div class="modal fade" id="modal" role="dialog">
        <div class="modal-dialog" style="max-width: 800px;width: auto">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <span class="modal-title">Chi Tiết Đơn Hàng</span>
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

    <div class="clearfix"></div>
</div>

<div class="clearfix"></div>

<jsp:include page="footer.jsp"></jsp:include>
</body>

<script>
    $(document).ready(function () {
        // billEntity cancel show modal confirm
        $(".billCancel").click(function (e) {
            var billId = $(this).parent().find(".billId").val();
            $("#conBillId").html(billId);
            $("#modal-content-confirm").html('Bạn chắc chắn hủy đơn hàng ?');
            $('#modalConfirm').modal('show');
        })

        // billEntity cancel action
        $("#acceptBillCancel").click(function (e) {
            var billId = $('#conBillId').html();

            $.get('/billStatusMod',
                {
                    'billId': billId,
                    'billStatus': '5'
                },
                function (data) {
                    if (data == 'success') {
                        window.location.href = '/history';
                    }
                });
        })

        /** Display bill detail */
        $('.fashion-grid').on('click', function () {
            // get bill detail by bill id
            let billId = $(this).parent().find(".billId").val();

            $.get('/getBillDetailByBillId?billId=' + billId,
                function (data) {
                    $("#modal-content").html(data);
                    $('#modal').modal('show');
                });


        })
    })
</script>

</html>

