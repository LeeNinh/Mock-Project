<%@page import="com.tainguyen.demo.model.User" %>
<%@page import="com.tainguyen.demo.repository.UserGet" %>
<%@page import="java.util.ArrayList" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản Lý Tài Khoản</title>

    <!-- js -->
    <script src="/js/jquery.min.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <!-- //js -->
    <!-- for bootstrap working -->
    <script type="text/javascript" src="/js/bootstrap-3.1.1.min.js"></script>
    <!-- //for bootstrap working -->

    <c:set var="root" value="${pageContext.request.contextPath}"/>
    <link href="${root}/css/mos-style.css" rel='stylesheet' type='text/css'/>
    <link href="${root}/css/bootstrap.css" rel="stylesheet" type="text/css" media="all"/>
    <link href="${root}/css/style.css" rel="stylesheet" type="text/css" media="all"/>
</head>
<body>
<%
    UserGet userGet = new UserGet();
    ArrayList<User> listUser = userGet.getListUser();

    User useradmin = (User) session.getAttribute("useradmin");
    if (useradmin == null || !useradmin.getRole().equals("ROLE_ADMIN")) {
        response.sendRedirect("/admin/login");
    }
%>
<jsp:include page="header.jsp"></jsp:include>

<div class="d-flex container">

    <jsp:include page="menu.jsp"></jsp:include>

    <div id="rightContent">

        <h3>QUẢN LÝ DANH MỤC</h3>
        <div class="informasi">
            Mật khẩu sau khi reset là: 12345678
        </div>
        <table class="data">
            <tr class="data">
                <th class="data" width="30px">STT</th>
                <th class="data">UserName</th>
                <th class="data">Ngày sinh</th>
                <th class="data">Tên Zalo</th>
                <th class="data">Số điện thoại Zalo</th>
                <th class="data">Họ và tên</th>
                <th class="data">Điện thoại</th>
                <th class="data">Địa chỉ</th>
                <th class="data">Trạng tháỉ</th>
                <th class="data">Hành động</th>
            </tr>
            <%
                int count = 0;
                for (User user : listUser) {
                    count++;

            %>
            <tr class="data"
                    <%if (!user.getIsActive()) {%>
                        style="background: #b3b1b1"
                    <%}%>>
                <td class="data" width="30px"><%=count%>
                </td>
                <td class="data"><%=user.getUserName()%>
                </td>
                <td class="data"><%=user.getBirthday()%>
                </td>
                <td class="data"><%=user.getZaloName()%>
                </td>
                <td class="data"><%=user.getZaloPhoneNumber()%>
                </td>
                <td class="data"><%=user.getFullName()%>
                </td>
                <td class="data"><%=user.getPhoneNumber()%>
                </td>
                <td class="data"><%=user.getAddress()%>
                </td>
                <td class="data isActive"><%=user.getIsActive() ? "Active" : "Inactive"%></td>
                <td class="data">
                    <input class="userID" type="hidden" value="<%=user.getUserID()%>">
                    <%if (user.getIsActive()) {%>
                    <button class="btn btn-primary btn-active">Inactive</button>
                    <%} else {%>
                    <button class="btn btn-primary btn-active">Active</button>
                    <% } %>

                    <button class="btn btn-primary btn-reset">Reset pass</button>
                </td>
            </tr>
            <% } %>
        </table>
    </div>
    <div class="clear"></div>

    <!-- Modal mesage-->
    <div class="modal fade" id="modal-mess" role="dialog">
        <div class="modal-dialog width-modal-message">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <span class="modal-title">Thông Báo</span>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body" id="modal-mess-content">

                </div>
                <div class="modal-footer">
                    <button id="btn-mess-close" type="button" class="btn btn-primary" data-dismiss="modal">Đóng</button>
                </div>
            </div>

        </div>
    </div>

    <!-- Modal confirm-->
    <div class="modal fade" id="modal-con" role="dialog">
        <div class="modal-dialog width-modal-message">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <span class="modal-title">Thông Báo</span>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body" id="modal-con-content">

                </div>
                <div class="modal-footer">
                    <button id="btn-con-close" type="button" class="btn btn-primary" data-dismiss="modal">Đóng</button>
                    <button id="btn-con-ok" type="button" class="btn btn-primary" data-dismiss="modal">Đồng ý</button>
                </div>
            </div>

        </div>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
<script>
    $("#btn-mess-close").click(function () {
        window.location.href = "/admin/manager_user";
    });

    $(".btn-active").click(function (e) {
        var userId = $(this).parent().find('.userID').val();
        var isActive = $(this).parent().parent().find('.isActive').html();
        $.post('/account/activeAccount',
            {
                'id': userId,
                'state': isActive
            },
            function (data) {
                const modalMessage = $('#modal-mess-content');

                if (data == 'active') {
                    // modalMessage.html('Active tài khoản thành công');
                    alert("Active tài khoản thành công")
                } else if (data == 'inactive') {
                    // modalMessage.html('Inactive tài khoản thành công');
                    alert("Inactive tài khoản thành công")
                } else {
                    // modalMessage.html('Active tài khoản thất bại');
                    alert("Active tài khoản thất bại")
                }

                // $('#modal-mess').modal('show');
            });
    })

    var userIdCurrent
    $("#btn-con-ok").click(function (e) {

        $.post('/account/resetPassword',
            {
                'id': userIdCurrent,
            },
            function (data) {
                // const modalMessage = $('#modal-mess-content');

                if (data == 'success') {
                    // modalMessage.html('Reset mật khẩu thành công');
                    alert("Reset mật khẩu thành công")
                } else {
                    // modalMessage.html('Reset mật khẩu thất bại');
                    alert("Reset mật khẩu thất bại")
                }
                // $('#modal-mess').modal('show');
            });
    })

    $(".btn-reset").click(function (e) {
        userIdCurrent = $(this).parent().find('.userID').val();
        $('#modal-con-content').html('Bạn chắc chắn muốn reset password tài khoản này chứ ?');
        $('#modal-con').modal('show');
    })
</script>
</body>
</html>
