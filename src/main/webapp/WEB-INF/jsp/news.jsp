<%@ page import="com.tainguyen.demo.model.News" %>
<%@ page import="com.tainguyen.demo.repository.NewsRepository" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>News</title>
    <link rel="icon" href="../img/iconWeb.jpg">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <c:set var="root" value="${pageContext.request.contextPath}"/>
    <!-- js -->
    <script src="${root}/js/jquery.min.js"></script>
    <link href="${root}/css/mos-style.css" rel='stylesheet' type='text/css'/>
    <script src="https://cdn.ckeditor.com/4.16.0/standard/ckeditor.js"></script>
    <link href="${root}/css/bootstrap.css" rel="stylesheet" type="text/css" media="all"/>
    <link href="${root}/css/style.css" rel="stylesheet" type="text/css" media="all"/>
    <link href="${root}/css/news.css" rel="stylesheet" type="text/css" media="all"/>

    <script src="https://cdn.ckeditor.com/ckeditor5/27.0.0/classic/ckeditor.js"></script>
    <script src="https://ckeditor.com/apps/ckfinder/3.5.0/ckfinder.js"></script>

    <style>
        img {
            width: inherit;
        }
    </style>
</head>
<body>
<%
    NewsRepository newsRepository = new NewsRepository();
    Long newsId = (Long) request.getAttribute("news_id");
    News news = newsRepository.getNewsById(newsId);
%>
<jsp:include page="header.jsp"></jsp:include>

<div id="content_news" class="container">

    <div id="news_view">
        <div class="btn-toolbar" role="toolbar">
            <div class="btn-group" role="group" aria-label="Back">
                <button type="button" id="news_list" class="btn btn-secondary">Tro ve</button>
            </div>
        </div>

        <h2 class="news-title"><%=news.getTitle()%>
        </h2>
        <input id="news_id" type="hidden" value="<%=news.getId()%>">
        <div class="ck ck-content ck-editor__editable ck-rounded-corners ck-editor__editable_inline ck-blurred">
            <%=news.getContent()%>
        </div>
    </div>

</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>

<script>

    $("#news_list").click(function () {
        window.location.href = "/conduct";
    });
</script>
