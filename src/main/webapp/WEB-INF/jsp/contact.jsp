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
<jsp:include page="header.jsp"></jsp:include>
<div class="contact">
    <div class="container">
        <div class="col-md-8 contact-grids1 animated wow fadeInRight" data-wow-delay=".5s">
            <form action="ContactServlet" method="post">
                <div class="contact-form2">
                    <h4>Họ và tên</h4>
                    <input type="text" placeholder="" name="name" required>

                </div>

                <div class="contact-form2">
                    <h4>Tiêu đề</h4>

                    <input type="text" name="title" placeholder="" required>

                </div>


                <div class="contact-me ">
                    <h4>Lời nhắn</h4>

                    <textarea type="text" name="message" placeholder="" required> </textarea>
                </div>
                <input type="hidden" name="command" value="insert">
                <input type="submit" value="Gửi Liên Hệ">
            </form>

        </div>

        <div class="col-md-4 contact-grids">
            <div class=" contact-grid animated wow fadeInLeft" data-wow-delay=".5s">
                <div class="contact-grid1">
                    <div class="contact-grid2 ">
                        <i class="glyphicon glyphicon-map-marker" aria-hidden="true"></i>
                    </div>
                    <div class="contact-grid3">
                        <h4>Địa Chỉ</h4>
                        127 Đinh Tiên Hoàng, phường Đông Thành, tp Ninh Bình
                    </div>
                </div>
            </div>
            <div class=" contact-grid animated wow fadeInUp" data-wow-delay=".5s">
                <div class="contact-grid1">
                    <div class="contact-grid2 contact-grid4">
                        <i class="glyphicon glyphicon-earphone" aria-hidden="true"></i>
                    </div>
                    <div class="contact-grid3">
                        <h4>Gọi Chúng Tôi</h4>
                        <p>0919 966 368<span>0918 531 868</span></p>
                    </div>
                </div>
            </div>
            <div class=" contact-grid animated wow fadeInRight" data-wow-delay=".5s">
                <div class="contact-grid1">
                    <div class="contact-grid2 contact-grid5">
                        <i class="glyphicon glyphicon-envelope" aria-hidden="true"></i>
                    </div>
                    <div class="contact-grid3">
                            <h4>Email</h4>
                        <p><a href="contactto:duongthilien.ytb@gmail.com">duongthilien.ytb@gmail.com</a></p>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
<div class="map">
    <iframe class="animated wow fadeInLeft" data-wow-delay=".5s"
            src="https://maps.google.com/maps?width=600&amp;height=300&amp;hl=en&amp;q=127%20%C4%90inh%20Ti%C3%AAn%20Ho%C3%A0ng%20ninh%20bi%CC%80nh+(shop)&amp;t=&amp;z=12&amp;ie=UTF8&amp;iwloc=B&amp;output=embed"
            frameborder="0" style="border:0" allowfullscreen></iframe>
</div>

<div class="clearfix"></div>


<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>

