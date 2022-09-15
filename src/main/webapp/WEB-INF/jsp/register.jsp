<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đăng Ký</title>
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
    <link href="/css/style.css" rel="stylesheet" type="text/css" media="all"/>
    <!-- js -->
    <script src="/js/jquery.min.js"></script>
    <!-- //js -->
    <!-- cart -->
    <script src="/js/simpleCart.min.js"></script>
    <!-- cart -->
    <!-- for bootstrap working -->
    <script type="text/javascript" src="/js/bootstrap-3.1.1.min.js"></script>
    <!-- //for bootstrap working -->
    <!-- animation-effect -->
    <link href="/css/animate.min.css" rel="stylesheet">
    <script src="/js/wow.min.js"></script>
    <script>
        new WOW().init();
    </script>
    <!-- //animation-effect -->
    <link href='//fonts.googleapis.com/css?family=Cabin:400,500,600,700' rel='stylesheet' type='text/css'>
    <link href='//fonts.googleapis.com/css?family=Lato:400,100,300,700,900' rel='stylesheet' type='text/css'>

    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" type="text/javascript"></script>
    <script src='https://www.google.com/recaptcha/api.js'></script>
    <script type="text/javascript">
        $(document).ready(function () {

            var x_timer;
            $("#name").keyup(function (e) {
                clearTimeout(x_timer);
                var user_name = $(this).val();
                x_timer = setTimeout(function () {
                    check_username_ajax(user_name);
                }, 1000);
            });

            function check_username_ajax(username) {
                if (username == '') {
                    $("#user-result").html('').css('margin-bottom', '0').css('margin-top', '0');
                } else {
                    $("#user-result").html('<img src="/img/ajax-loader.gif" />');
                    $.post('/account/CheckUserName', {'username': username}, function (data) {
                        $("#user-result").html(data).css('margin-bottom', '1.5em').css('margin-top', '-1.5em');
                    });
                }
            }
        });

        function trim(str) {
            var str = str.replace(/^\s+|\s+$/g, "");
            return str;
        }

        function ValidCaptcha(a, b) {
            var a = trim(a);
            if (a == b) {
                return true;
            }
            return false;
        }

        function checkform(theform, b) {
            var why = "";
            var a = theform.input.value;
            if (a == "") {
                why += "Security code should not be empty.\n";
            }
            if (a != "") {
                if (!ValidCaptcha(a, b)) {
                    why += "Security code did not match.\n";
                }
            }
            if (why != "") {
                alert(why);
                return false;
            }
        }

        var a = Math.ceil(Math.random() * 9);
        var b = Math.ceil(Math.random() * 9);
        var code = a + b;

    </script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<div class="banner-top">
    <div class="login-title">
        ĐĂNG KÝ TÀI KHOẢN
    </div>
</div>

<div class="login">
    <div class="container">
        <form action="register" method="POST">
            <div class=" animated wow fadeInLeft" data-wow-delay=".5s">
                <%if (request.getAttribute("message") != null) {%>
                <div>
                    <p style="color:red"><%=request.getAttribute("message")%>
                    </p>
                </div>
                <% } %>
                <div class="login-mail">
                    <input type="text" placeholder="Tên đăng nhập" name="name" id="name" required>
                    <i class="glyphicon glyphicon-user"></i>
                </div>
                <div id="user-result"></div>

                <div class="d-flex" style="justify-content: space-between">
                    <div class="d-flex flex-column" style="width: 49%">
                        <div class="login-mail">
                            <input type="password" placeholder="Mật khẩu" name="pass" id="pass" required>
                            <i class="glyphicon glyphicon-lock"></i>
                            <span></span>
                        </div>
                        <span class='message'></span>
                    </div>
                    <div class="d-flex flex-column" style="width: 49%">
                        <div class="login-mail">
                            <input type="password" placeholder="Xác Nhận Mật khẩu" name="confirm_pass" id="confirm_pass"
                                   required>

                            <script>$('#pass, #confirm_pass').on('keyup', function () {
                                let pass = $('#pass').val();
                                let confirmPass = $('#confirm_pass').val();

                                if (pass == '' && confirmPass == '') {
                                    $('.message').html('').css('margin-bottom', '0').css('margin-top', '0');
                                    ;
                                } else {
                                    if (pass == confirmPass) {
                                        $('.message').html('Trùng khớp').css('color', 'green');
                                    } else {
                                        $('.message').html('Không trùng khớp').css('color', 'red');
                                    }
                                    $(".message").css('margin-bottom', '1.5em').css('margin-top', '-1.5em');
                                }
                            });

                            </script>
                            <i class="glyphicon glyphicon-lock"></i>
                        </div>
                        <span class='message'></span>
                    </div>

                </div>

                <div class="login-mail">
                    <input type="text" placeholder="Ngày sinh" name="biirthday" id="biirthday" required>

                    <i class="glyphicon glyphicon-phone"></i>
                </div>
                <div class="login-mail">
                    <input type="text" placeholder="Tên Zalo" name="zalo-name" id="zalo-name" required>

                    <i class="glyphicon glyphicon-phone"></i>
                </div>
                <div class="login-mail">
                    <input type="text" placeholder="Số điện thoại Zalo" name="zalo-phone" id="zalo-phone" required>

                    <i class="glyphicon glyphicon-phone"></i>
                </div>

                <div class="banner-top">
                    <div class="login-title">
                        THÔNG TIN NHẬN HÀNG
                    </div>
                </div>

                <div class="login-mail">
                    <input type="text" placeholder="Họ và tên" name="full-name" id="full-name" required>

                    <i class="glyphicon glyphicon-phone"></i>
                </div>

                <div class="login-mail">
                    <input type="text" placeholder="Số điện thoại" name="phone" id="phone" required>

                    <i class="glyphicon glyphicon-phone"></i>
                </div>

                <div class="login-mail">
                    <input type="text" placeholder="Địa chỉ nhận hàng" name="address" id="address" required>

                    <i class="glyphicon glyphicon-phone"></i>
                </div>

            </div>
            <div style="justify-content: center" class="d-flex">
                <div class="col-md-8 login-do animated wow fadeInRight" data-wow-delay=".5s">
                    <label class="hvr-sweep-to-top login-sub">
                        <input type="hidden" value="insert" name="command">
                        <input type="submit" value="Đăng Ký">
                    </label>

                    <a href="/account/loginForm" class="hvr-sweep-to-top override-before"
                       style="background: none; color: black; margin-top: 10px">
                        Đăng Nhập
                    </a>
                </div>
                <div class="clearfix"></div>
            </div>
        </form>
    </div>
</div>

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
