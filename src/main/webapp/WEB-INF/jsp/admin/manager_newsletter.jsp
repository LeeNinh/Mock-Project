<%@page import="com.tainguyen.demo.model.Newsletter" %>
<%@page import="com.tainguyen.demo.repository.NewsletterGet" %>
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
    NewsletterGet newsletterGet = new NewsletterGet();
    ArrayList<Newsletter> listNewsletter = newsletterGet.getListNewsletter();
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
                <th class="data">Mã số</th>
                <th class="data">Email</th>
                <th class="data">Thời gian</th>


            </tr>
            <%
                int count = 0;
                for (Newsletter newsletter : listNewsletter) {
                    count++;

            %>
            <tr class="data">
                <td class="data" width="30px"><%=count%>
                </td>
                <td class="data"><%=newsletter.getNewsletterID()%>
                </td>
                <td class="data"><%=newsletter.getNewsletterName()%>
                </td>
                <td class="data"><%=newsletter.getDate()%>
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
