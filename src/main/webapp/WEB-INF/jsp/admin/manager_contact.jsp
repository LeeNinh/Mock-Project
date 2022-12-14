<%@page import="com.tainguyen.demo.model.Contact" %>
<%@page import="com.tainguyen.demo.repository.ContactGet" %>
<%@page import="java.util.ArrayList" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản Lý Liên Hệ</title>

    <c:set var="root" value="${pageContext.request.contextPath}"/>
    <link href="${root}/css/mos-style.css" rel='stylesheet' type='text/css'/>
    <link href="${root}/css/bootstrap.css" rel="stylesheet" type="text/css" media="all"/>
    <link href="${root}/css/style.css" rel="stylesheet" type="text/css" media="all"/>
</head>
<body>
<%
    ContactGet contactGet = new ContactGet();
    ArrayList<Contact> listContact = contactGet.getListContact();
%>
<jsp:include page="header.jsp"></jsp:include>

<div class="d-flex">

    <jsp:include page="menu.jsp"></jsp:include>

    <div id="rightContent">

        <h3>QUẢN LÝ LIÊN HỆ</h3>
        <div class="informasi">
            Hãy chỉnh sửa dữ liệu cẩn thận nhé ^^
        </div>


        <table class="data">
            <tr class="data">
                <th class="data" width="30px">STT</th>
                <th class="data">Mã liên hệ</th>
                <th class="data">Họ tên</th>
                <th class="data">Website</th>
                <th class="data">Email</th>
                <th class="data">Tiêu đề</th>
                <th class="data">Lời nhắn</th>
                <th class="data">Thời gian</th>


            </tr>
            <%
                int count = 0;
                for (Contact contact : listContact) {
                    count++;

            %>
            <tr class="data">
                <td class="data" width="30px"><%=count%>
                </td>
                <td class="data"><%=contact.getContactID()%>
                </td>
                <td class="data"><%=contact.getContactName()%>
                </td>
                <td class="data"><%=contact.getContactWeb()%>
                </td>
                <td class="data"><%=contact.getContactEmail()%>
                </td>
                <td class="data"><%=contact.getContactTitle()%>
                </td>
                <td class="data"><%=contact.getContactMessage()%>
                </td>
                <td class="data"><%=contact.getDate()%>
                </td>


            </tr>
            <% } %>
        </table>
    </div>
    <div class="clear"></div>
</div>
<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>
