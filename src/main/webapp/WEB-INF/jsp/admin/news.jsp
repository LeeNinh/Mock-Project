<%@ page import="com.tainguyen.demo.model.News" %>
<%@ page import="com.tainguyen.demo.repository.NewsRepository" %>
<%@ page import="com.tainguyen.demo.model.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>News</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <c:set var="root" value="${pageContext.request.contextPath}"/>
    <!-- js -->
    <script src="${root}/js/jquery.min.js"></script>
    <link href="${root}/css/mos-style.css" rel='stylesheet' type='text/css'/>
    <script src="https://cdn.ckeditor.com/ckeditor5/27.0.0/classic/ckeditor.js"></script>
    <script src="https://ckeditor.com/apps/ckfinder/3.5.0/ckfinder.js"></script>
    <link href="${root}/css/bootstrap.css" rel="stylesheet" type="text/css" media="all"/>
    <link href="${root}/css/style.css" rel="stylesheet" type="text/css" media="all"/>
    <link href="${root}/css/news.css" rel="stylesheet" type="text/css" media="all"/>
    <style>
        img {
            width: inherit;
        }
    </style>
</head>
<body class="container">
<%
    User useradmin = (User) session.getAttribute("useradmin");
    if (useradmin == null || !useradmin.getRole().equals("ROLE_ADMIN")) {
        response.sendRedirect("/admin/login");
    }

    NewsRepository newsRepository = new NewsRepository();
    Long newsId = (Long) request.getAttribute("news_id");
    News news = newsRepository.getNewsById(newsId);
%>
<jsp:include page="header.jsp"></jsp:include>

<div id="content_news">

    <div id="news_view">
        <div class="btn-toolbar" role="toolbar">
            <div class="btn-group" role="group" aria-label="Back">
                <button type="button" id="news_list" class="btn btn-secondary">Quay lại</button>
            </div>
            <div class="btn-group" role="group" aria-label="Save">
                <button type="button" class="btn btn-info" id="edit">Chỉnh sửa</button>
            </div>
            <div class="btn-group" role="group" aria-label="Save">
                <button type="button" class="btn btn-danger" id="delete">Xóa</button>
            </div>
            <div class="btn-group" role="group" aria-label="Use">
                <button type="button" class="btn btn-danger" id="use">Giới thiệu</button>
            </div>
        </div>

        <h2 class="news-title"><%=news.getTitle()%>
        </h2>
        <input id="news_id" type="hidden" value="<%=news.getId()%>">
        <div class="ck ck-content ck-editor__editable ck-rounded-corners ck-editor__editable_inline ck-blurred">
            <%=news.getContent()%>
        </div>

    </div>

    <div id="news_edit">

        <div class="row">
            <h2 class="news-title">Chỉnh sửa tin tức</h2>

            <div class="col-md-4 col-sm-12">
                <div class="input-group input-news-thumbnail">
                    <input type="text" id="thumbnail_link" class="form-control" placeholder="Nhập link ảnh ở đây">
                    <div class="input-group-btn">
                        <button class="btn btn-default" type="text" id="add_thumbnail"
                                style=" height: 34px; margin-bottom: 0 !important">
                            <i class="glyphicon glyphicon-plus"></i>
                        </button>
                    </div>
                </div>

                <div class="avatar">
                    <img src="<%=news.thumbnail()%>" id="display_thumbnail"
                         class="rounded mx-auto d-block news-thumbnail"
                         alt="Thumbnail">
                </div>
            </div>

            <div class="col-md-8 col-sm-12">

                <form action="/editNews" method="post" id="form_edit_news">
                    <input type="hidden" value="<%=news.getThumbnail()%>" id="thumbnail_link_input" name="thumbnail"/>
                    <input type="hidden" value="" id="news" name="news"/>
                    <input id="id" name="news_id" type="hidden" value="<%=news.getId()%>">
                    <div class="form-group">
                        <label for="title">Tiêu đề</label>
                        <input type="text" class="form-control" id="title" name="title" placeholder="Tiêu đề"
                               value="<%=news.getTitle()%>">
                    </div>
                    <div class="form-group">
                        <div id="editor"></div>
                    </div>

                    <div class="btn-toolbar" role="toolbar">
                        <div class="btn-group" role="group" aria-label="Back">
                            <button type="button" id="done" class="btn btn-secondary">Quay lại</button>
                        </div>
                        <div class="btn-group" role="group" aria-label="Save">
                            <button type="submit" class="btn btn-primary">Lưu</button>
                        </div>
                    </div>
                </form>
            </div>

        </div>
    </div>

</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>

<script>
    var editor = null;
    var c = `<%=news.getContent()%>`;
    ClassicEditor
        .create( document.querySelector( '#editor' ), {
            ckfinder: {
                uploadUrl: '/ckeditor/upload'
            },
        } )
        .then( newEditor => {
            editor = newEditor;
            editor.setData(c);
            $("#news_edit").hide();
        })
        .catch( error => {
            console.error('error' +  error );
        } );

    $("#delete").click(function () {
        var _delete = confirm("Bạn có muốn xoá bài viết này không?");
        var news_id = $("#news_id").val();
        if (_delete) {
            window.location.href = "/delete_news?news_id=" + news_id;
        }

    });

    $("#edit").click(function () {
        $("#news_view").hide();
        $("#news_edit").show();
    });

    $("#done").click(function () {
        $("#news_view").show();
        $("#news_edit").hide();
    });

    $("#news_list").click(function () {
        window.location.href = "/admin/news_list";
    });

    $("#add_thumbnail").click(function () {
        var thumbnail_link = $('#thumbnail_link').val();
        if (thumbnail_link == '' || thumbnail_link == undefined) return;
        $('#display_thumbnail').attr("src", thumbnail_link);
        $('#thumbnail_link_input').val(thumbnail_link);
    });

    $("#use").click(function () {
        var _pick = confirm("Bạn có muốn chọn bài viết này làm bài giới thiệu không?");
        var news_id = $("#news_id").val();
        if (_pick)
        window.location.href = "/pick_news?news_id=" + news_id;
    });

    $("#form_edit_news").submit(function (){
        var content =  editor.getData();
        $("#news").val(content);
        return true;
    });
</script>
