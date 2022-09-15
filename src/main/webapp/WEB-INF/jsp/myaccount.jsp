<%@page import="java.text.DecimalFormat" %>
<%@page import="com.tainguyen.demo.repository.UserGet" %>
<%@page import="java.util.ArrayList" %>
<%@page import="com.tainguyen.demo.model.User" %>
<%@ page import="com.tainguyen.demo.model.BillDto" %>
<%@ page import="com.tainguyen.demo.repository.BillGet" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>QUẢN LÝ TÀI KHOẢN</title>
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
    <!-- js -->
    <script src="js/jquery.min.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <!-- //js -->
    <!-- //for-mobile-apps -->
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all"/>
    <link href="css/style.css" rel="stylesheet" type="text/css" media="all"/>
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
    User user = new User();
    ArrayList<BillDto> listHistoryByUser = new ArrayList<>();

    DecimalFormat formatter = null;
    User users = (User) session.getAttribute("user");
    if (users == null) {
        response.sendRedirect("/index");
    } else {
        formatter = new DecimalFormat("###,###,###");
        long user_id = users.getUserID();

        BillGet billGet = new BillGet();

        user = new UserGet().getUser(user_id);
    }
%>
<jsp:include page="header.jsp"></jsp:include>

<div class="sap_tabs container">
    <div id="horizontalTab" style="display: block; margin: 0px">
        <ul class="resp-tabs-list">
            <li class="resp-tab-item " aria-controls="tab_item-0" role="tab">
                <span>Sửa thông tin cá nhân</span>
            </li>
            <li class="resp-tab-item" aria-controls="tab_item-1" role="tab">
                <span>
                    <i class="glyphicon glyphicon-info-sign"></i>
                    Thay đổi mật khẩu
                </span>
            </li>
            <li class="resp-tab-item" aria-controls="tab_item-3" role="tab">
                <a href="/account/logout" style="text-decoration: none; color: black">
                    <i class="glyphicon glyphicon-edit"></i>
                    Đăng xuất</a>
            </li>

            <div class="clearfix"></div>
        </ul>
        <div class="container">
            <input type="hidden" id="id" value="<%=user.getUserID()%>">

            <%--            tab Sửa thông tin cá nhân--%>
            <div class="tab-1 resp-tab-content resp-tab-content-active" aria-labelledby="tab_item-0"
                 style="display:block">
                <div aria-labelledby="tab_item-1">
                    <div class="">
                        <label>Ngày sinh</label>
                        <div class="login-mail">
                            <input type="text" name="biirthday" id="biirthday" value="<%=user.getBirthday()%>">
                            <input type="hidden" name="role" value="0">
                            <i class="glyphicon glyphicon-envelope"></i>
                            <%--                            <span id="user-result"></span>--%>
                        </div>
                        <label>Tên Zalo</label>
                        <div class="login-mail">
                            <input type="text" name="zalo-name" id="zalo-name" value="<%=user.getZaloName()%>">
                            <i class="glyphicon glyphicon-phone"></i>
                            <%--                            <span id="user-result"></span>--%>
                        </div>
                        <label>Số điện thoại Zalo</label>
                        <div class="login-mail">
                            <input type="text" name="zalo-phone" id="zalo-phone" value="<%=user.getZaloPhoneNumber()%>">
                            <i class="glyphicon glyphicon-phone"></i>
                            <%--                            <span id="user-result"></span>--%>
                        </div>
                        <label>Họ và tên</label>
                        <div class="login-mail">
                            <input type="text" name="full-name" id="full-name" value="<%=user.getFullName()%>">
                            <i class="glyphicon glyphicon-phone"></i>
                            <%--                            <span id="user-result"></span>--%>
                        </div>
                        <label>Số điện thoại</label>
                        <div class="login-mail">
                            <input type="text" name="phone" id="phone" value="<%=user.getPhoneNumber()%>">
                            <i class="glyphicon glyphicon-phone"></i>
                            <%--                            <span id="user-result"></span>--%>
                        </div>
                        <label>Địa chỉ nhận hàng</label>
                        <div class="login-mail">
                            <input type="text" name="address" id="address" value="<%=user.getAddress()%>">
                            <i class="glyphicon glyphicon-phone"></i>
                            <%--                            <span id="user-result"></span>--%>
                        </div>

                    </div>

                    <%--                    <input type="hidden" value="update" name="command">--%>
                    <div class="d-flex" style="justify-content: center">
                        <button id="update-user" class="btn btn-lg btn-info">
                            Cập Nhật Thông Tin
                        </button>
                    </div>

                    <div class="clearfix"></div>
                </div>
            </div>

            <%--            tab thay đổi mật khẩu--%>
            <div class="tab-1 resp-tab-content" aria-labelledby="tab_item-1">
                <input type="hidden" name="username" id="username" value="<%=user.getUserName()%>">
                <label>Mật khẩu cũ</label>
                <div class="login-mail">
                    <input type="password" name="old_pass" id="old_pass" value="">
                    <i class="glyphicon glyphicon-lock"></i>

                    <script>
                        var x_timer;
                        $('#old_pass').on('keyup', function () {
                            clearTimeout(x_timer);
                            x_timer = setTimeout(function () {
                                check_password();
                            }, 1000);
                        });

                        function check_password() {
                            $.post('/account/checkPassword',
                                {
                                    'username': $("#username").val(),
                                    'pass': $("#old_pass").val(),
                                },
                                function (data) {
                                    if (data == 'success') {
                                        $('#message1').html('Trùng khớp').css('color', 'green');
                                    } else {
                                        $('#message1').html('Mật khẩu cũ không chính xác').css('color', 'red');
                                    }
                                });
                        }
                    </script>

                </div>
                <div id='message1' style="margin-top: -1.5em"></div>

                <label style="margin-top: 1.5em">Mật khẩu mới</label>
                <div class="login-mail">
                    <input type="password" name="new_pass" id="new_pass" value="">
                    <i class="glyphicon glyphicon-lock"></i>
                </div>

                <label>Xác nhận mật khẩu mới</label>
                <div class="login-mail">
                    <input type="password" name="confirm_pass" id="confirm_pass"
                           value="">

                    <script>$('#new_pass, #confirm_pass').on('keyup', function () {
                        var pass = $('#confirm_pass').val();
                        var conPass = $('#new_pass').val()

                        if (pass && conPass && pass.length >= 8) {
                            if (pass == conPass) {
                                $('#message2').html('Trùng khớp').css('color', 'green');
                            } else
                                $('#message2').html('Không trùng khớp').css('color', 'red');
                        } else {
                            $('#message2').html('Mật khẩu phải có ít nhất 8 ký tự').css('color', 'red');
                        }
                    });
                    </script>

                    <i class="glyphicon glyphicon-lock"></i>
                </div>
                <div id='message2'></div>

                <div class="d-flex" style="justify-content: center">
                    <button id="update-pass" class="btn btn-lg btn-info">
                        Cập nhật mật khẩu
                    </button>
                </div>
                <div class="clearfix"></div>
            </div>

            <%--            tab lịch sử mua hàng--%>
<%--            <div class="tab-1 resp-tab-content" aria-labelledby="tab_item-2">--%>
<%--                <div class="page-header">--%>
<%--                    <h3>ĐƠN HÀNG</h3>--%>
<%--                </div>--%>

<%--                <%--%>
<%--                    for (History history : listHistoryByUser) {--%>
<%--                %>--%>

<%--                <div class="d-flex flex-column mr-1 ml-1 mb-2 contain-history">--%>
<%--                    <div class="d-flex contain-item">--%>
<%--                        <img src="<%=history.getImage()%>" class="fashion-grid" alt="">--%>
<%--                        <div class="d-flex flex-column mr-1">--%>
<%--                            <div class="item-contain">--%>
<%--                                <div class="item1">Mã sản phẩm: <%=history.getProductCode()%>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                            <div class="item-contain">--%>
<%--                                <div class="item1">Tên sản phẩm: <%=history.getProductName()%>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                            <div class="item-contain">--%>
<%--                                <div class="item1">Size/Màu: <%=history.getProductDetailName()%>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                            <div class="item-contain">--%>
<%--                                <div class="item1">Đơn giá: <%=history.getPrice()%>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                            <div class="item-contain">--%>
<%--                                <div class="item1">Số lượng: <%=history.getQuantity()%>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                            <div class="item-contain">--%>
<%--                                <div class="item1">Ngày: <%=history.getDate()%>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                            <div class="item-contain">--%>
<%--                                <div class="item1">Trạng thái: <%=history.getStatus() == 1 ? "Chờ đặt" : history.getStatus() == 2 ? "Đã đặt" : history.getStatus() == 3 ?--%>
<%--                                            "Về kho" : history.getStatus() == 4 ? "Đã giao cho khách" : history.getStatus() == 5 ? "Đã hủy" : "false"%>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                            <div class="item-contain">--%>
<%--                                <div class="item1">Ghi chú của user: <%=history.getUserNote()%>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                            <div class="item-contain">--%>
<%--                                <div class="item1">Ghi chú của admin: <%=history.getAdminNote()%>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <%if (history.getStatus() == 1) {%>--%>
<%--                    <input id="billId" type="hidden" value="<%=history.getBillId()%>">--%>
<%--                    <button class="btn btn-danger mr-1 ml-1 billCancel">Hủy đơn</button>--%>
<%--                    <% } %>--%>
<%--                </div>--%>
<%--                <% } %>--%>

<%--                <div class="clearfix"></div>--%>
<%--            </div>--%>
        </div>
    </div>
    <script src="js/easyResponsiveTabs.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#horizontalTab').easyResponsiveTabs({
                type: 'default', //Types: default, vertical, accordion
                width: 'auto', //auto or any width like 600px
                fit: true   // 100% fit in a container
            });
        });
    </script>
    <!---->
</div>

<div class="social animated wow fadeInUp" data-wow-delay=".1s">
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

<!-- Modal mesage success-->
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
                <button type="button" class="btn btn-primary" data-dismiss="modal">Đồng ý</button>
            </div>
        </div>

    </div>
</div>

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

</body>
<script>
    $(document).ready(function () {
        $("#update-user").click(function (e) {
            $.post('/account/updateInfo',
                {
                    'id': $("#id").val(),
                    'birthDay': $("#birthDay").val(),
                    'zalo-name': $("#zalo-name").val(),
                    'zalo-phone': $("#zalo-phone").val(),
                    'full-name': $("#full-name").val(),
                    'phone': $("#phone").val(),
                    'address': $("#address").val(),
                },
                function (data) {
                    if (data == 'success') {
                        // $('#modal-content').html('Cập nhật thông tin thành công')
                        // window.$('#modal').modal('show');
                        alert('Cập nhật thông tin thành công')
                    }
                });
        });

        $("#update-pass").click(function (e) {
            $.post('/account/updatePassword',
                {
                    'id': $("#id").val(),
                    'new_pass': $("#new_pass").val()
                },
                function (data) {
                    if (data == 'success') {
                        // $('#modal-content').html('Cập nhật mật khẩu thành công')
                        // window.$('#modal').modal('show');
                        alert('Cập nhật mật khẩu thành công')
                    }
                });
        })

    })
</script>
</html>

