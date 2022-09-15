<%--
  Created by IntelliJ IDEA.
  User: nguyenthetai
  Date: 19/02/2021
  Time: 17:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

</head>
<body class="container">
<jsp:include page="header.jsp"></jsp:include>

<div id="content_news">
    <div class="row">
        <div class="col-md-4 col-sm-12">
            <h2 class="news-title"> Tạo Mới Tin Tức</h2>
            <div class="input-group input-news-thumbnail">
                <input type="text" id="thumbnail_link" class="form-control" placeholder="Nhập link ảnh ở đây">
                <div class="input-group-btn">
                    <button class="btn btn-default" type="text" id="add_thumbnail"
                    style=" height: 34px;
                            margin-bottom: 0 !important">
                        <i class="glyphicon glyphicon-plus"></i>
                    </button>
                </div>
            </div>

            <div class="avatar">
                <img src="/default-thumbnail" id="display_thumbnail" class="rounded mx-auto d-block news-thumbnail"
                     alt="Thumbnail">
            </div>
        </div>

        <div class="col-md-8 col-sm-12">

            <form action="/addNews" method="post" id="form_add_news">
                <input type="hidden" value="" id="thumbnail_link_input" name="thumbnail"/>
                <input type="hidden" value="" id="news" name="news"/>
                <div class="form-group mt-2">
                    <label for="title">Tiêu Đề</label>
                    <input type="text" class="form-control" id="title" name="title" placeholder="Tiêu dề">
                </div>
                <div class="form-group">
                    <div id="editor">
                    </div>
                </div>

                <div class="btn-toolbar" role="toolbar">
                    <div class="btn-group" role="group" aria-label="Back">
                        <button type="button" id="news_list" class="btn btn-secondary">Trở về</button>
                    </div>
                    <div class="btn-group" role="group" aria-label="Save">
                        <button type="submit" class="btn btn-primary">Lưu</button>
                    </div>
                </div>
            </form>
        </div>

    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
<script>
    var editor;
    ClassicEditor
        .create( document.querySelector( '#editor' ), {
            ckfinder: {
                uploadUrl: '/ckeditor/upload'
            },
        } )
        .then( newEditor => {
            editor = newEditor;
        })
        .catch( error => {
            console.error('error' +  error );
        } );

    $("#news_list").click(function () {
        window.location.href = "/admin/news_list";
    });

    $("#add_thumbnail").click(function () {
        var thumbnail_link = $('#thumbnail_link').val();
        if (thumbnail_link == '' || thumbnail_link == undefined) return;
        $('#display_thumbnail').attr("src", thumbnail_link);
        $('#thumbnail_link_input').val(thumbnail_link);
    });

    $("#form_add_news").submit(function (){
        var content =  editor.getData();
        $("#news").val(content);
        return true;
    });

</script>
</body>
</html>
