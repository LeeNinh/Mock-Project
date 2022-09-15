<%@page import="java.util.ArrayList" %>
<%@ page import="com.tainguyen.demo.model.News" %>
<%@ page import="com.tainguyen.demo.repository.NewsRepository" %>
<%@ page import="com.tainguyen.demo.model.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Tin tuc</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <c:set var="root" value="${pageContext.request.contextPath}"/>

    <!-- js -->
    <script src="${root}/js/jquery.min.js"></script>

    <link href="${root}/css/mos-style.css" rel='stylesheet' type='text/css'/>
    <link href="${root}/css/bootstrap.css" rel="stylesheet" type="text/css" media="all"/>
    <link href="${root}/css/style.css" rel="stylesheet" type="text/css" media="all"/>
    <link href="${root}/css/news.css" rel="stylesheet" type="text/css" media="all"/>
</head>
<body>

<%
    User useradmin = (User) session.getAttribute("useradmin");
    if (useradmin == null || !useradmin.getRole().equals("ROLE_ADMIN")) {
        response.sendRedirect("/admin/login");
    }

    NewsRepository newsRepository = new NewsRepository();
    String offset = request.getAttribute("offset") != null ? (String) request.getAttribute("offset") : "0";
    String limit = request.getAttribute("limit") != null ? (String) request.getAttribute("limit") : "10";

    ArrayList<News> newsArrayList = newsRepository.getListNews(Integer.parseInt(limit), Integer.parseInt(offset));
%>
<jsp:include page="header.jsp"></jsp:include>
<div class="d-flex container">
    <jsp:include page="menu.jsp"></jsp:include>
    <input id="offset" type="hidden" value="<%=offset%>">
    <input id="limit" type="hidden" value="<%=limit%>">
    <input id="listSize" type="hidden" value="<%=newsArrayList.size()%>">
    <div class="content" id="content_news">
        <a class="btn btn-primary" href="/admin/add_news" role="button">Tạo mới bài viết</a>
        <a class="list-group">
                <%for (News news : newsArrayList) {%>
            <a href="/news?news_id=<%=news.getId()%>"
               class="list-group-item list-group-item-action flex-column align-items-start">
                <div class="news-item">
                    <div class="avatar">
                        <img src="<%=news.thumbnail()%>" class="rounded mx-auto d-block" alt="Thumbnail">
                    </div>
                    <div class="brief-content">
                        <div class="d-flex w-100 justify-content-between">
                            <h4 class="mb-1"><%=news.getTitle()%>
                            </h4>
                        </div>
                        <p><small><%=news.createTime()%>
                        </small></p>
                        <p class="mb-1 block-brief"><%=news.briefContent()%>
                        </p>
                    </div>
                </div>
            </a>
                <%}%>
            <div class="news-footer">
                <button id="previousPage" class="btn btn-primary">Trang trước</button>
                <button id="nextPage" class="btn btn-primary">Trang sau</button>
            </div>
    </div>
</div>

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>

<script>
    $("#previousPage").click(function () {
        let offset = Number($("#offset").val()) - 10;
        let limit = $("#limit").val();
        if (offset < 0) {
            offset = 0;
            return;
        }
        window.location.href = "/news_list?offset=" + offset + "&limit=" + limit;
    });

    $("#nextPage").click(function () {
        let offset = Number($("#offset").val()) + 10;
        let limit = $("#limit").val();
        let listSize = $("#listSize").val();

        if (listSize < 10) {
            offset -= 10;
            return;
        }

        window.location.href = "/news_list?offset=" + offset + "&limit=" + limit;
    });
</script>
