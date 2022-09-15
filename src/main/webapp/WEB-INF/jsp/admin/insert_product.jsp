<%@page import="com.tainguyen.demo.repository.CategoryGet" %>
<%@page import="com.tainguyen.demo.model.Category" %>
<%@ page import="com.tainguyen.demo.model.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.tainguyen.demo.model.ImageUrl" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tainguyen.demo.repository.ImageRepo" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Thêm sản phẩm</title>

    <c:set var="root" value="${pageContext.request.contextPath}"/>
    <link href="${root}/css/mos-style.css" rel='stylesheet' type='text/css'/>
    <link href="${root}/css/style.css" rel="stylesheet" type="text/css" media="all"/>
    <link href="${root}/css/bootstrap.css" rel="stylesheet" type="text/css" media="all"/>
    <!-- js -->
    <script src="${root}/js/jquery.min.js"></script>
    <!-- //js -->
    <!-- cart -->
    <script src="${root}/js/simpleCart.min.js"></script>
    <!-- cart -->
    <!-- for bootstrap working -->
    <script type="text/javascript" src="${root}/js/bootstrap-3.1.1.min.js"></script>
    <!-- //for bootstrap working -->
    <!-- animation-effect -->
    <link href="${root}/css/animate.min.css" rel="stylesheet">
    <script src="${root}/js/wow.min.js"></script>
    <script>
        new WOW().init();
    </script>
    <!-- //animation-effect -->
    <link href='//fonts.googleapis.com/css?family=Cabin:400,500,600,700' rel='stylesheet' type='text/css'>
    <link href='//fonts.googleapis.com/css?family=Lato:400,100,300,700,900' rel='stylesheet' type='text/css'>

</head>
<body>
<%
    List<ImageUrl> imageList = new ArrayList();
    CategoryGet categoryget = new CategoryGet();

    String error = "";
    if (request.getParameter("error") != null) {
        error = (String) request.getParameter("error");
    }

    User useradmin = (User) session.getAttribute("useradmin");
    if (useradmin == null || !useradmin.getRole().equals("ROLE_ADMIN")) {
        response.sendRedirect("/admin/login");
    } else {
        ImageRepo imageRepo = new ImageRepo();
        imageList = imageRepo.getAllImageUrl();
    }
%>
<jsp:include page="header.jsp"></jsp:include>


<div class="d-flex container">
    <jsp:include page="menu.jsp"></jsp:include>

    <div id="rightContent" class="d-flex flex-column">
        <h3>THÊM SẢN PHẨM MỚI</h3>

        <div class="container">
            <%if (request.getAttribute("error") != null) {%>
            <div>
                <span style="float: right; color: red">
                    <%=request.getAttribute("error")%>
                </span>
                <span></span>
            </div>
            <% } %>

            <div class="item-contain">
                <span class="pro-item-left"><b>Tên danh mục</b></span>
                <span class="pro-item-right">
                    <div>
                        <span></span>
                        <select name="maloai" id="categoryId">
                            <%
                                for (Category c : categoryget.getListCategory()) {%>
                            <option value="<%=c.getCategoryID()%>"><%=c.getCategoryName()%>
                            </option>
                            <% } %>
                        </select>
                    </div>
                    <input type="hidden" class="sedang" name=""><%=error%>
                </span>
            </div>

            <div class="item-contain">
                <span class="pro-item-left"><b>Mã sản phẩm</b></span>
                <span class="pro-item-right">
                    <input type="text" class="sedang" name="maSanPham" id="productCode" required><%=error%>
                </span>
            </div>

            <div class="item-contain">
                <span class="pro-item-left"><b>Tên sản phẩm</b></span>
                <span class="pro-item-right">
                    <input type="text" class="sedang" name="tenSanPham" id="productName" required><%=error%>
                </span>
            </div>

            <div class="item-contain">
                <span class="pro-item-left"><b>Hình đại diện</b></span>
                <span class="pro-item-right">
                    <span id="image-display">
                    </span>
                    <button type="button" id="btn-select-image" class="btn btn-primary">Chọn ảnh</button>
                </span>
            </div>

            <div class="">
                <div class="item-contain">
                    <span class="pro-item-left"><b>Màu sắc</b></span>
                    <span class="pro-item-right">
                        <span id="image-display-color">
                        </span>
                        <input type="hidden" id="imagesProductColor" name="imageColor">
                        <button type="button" id="btn-select-image-color" class="btn btn-primary">Chọn ảnh</button>
                    </span>
                </div>

                <div class="item-contain">
                    <span class="pro-item-left"><b>Kích thước</b></span>
                    <span class="pro-item-right">
                        <span class="size-display">
                        </span>
                        <input type="hidden" class="sedang" name="sizeName">
                        <input type="text" class="sedang" id="sizeName">
                        <button type="button" id="btn-select-size" class="btn btn-primary mt-2">Thêm size</button>
                    </span>
                </div>

                <div class="item-contain">
                    <span class="pro-item-left"><b>Giá</b></span>
                    <span class="pro-item-right">
                        <input type="text" class="sedang" name="price" id="price" onkeyup="inputCurrency(this)">
                    </span>
                </div>

                <div class="item-contain">
                    <span class="pro-item-left"><b>Số lượng</b></span>
                    <span class="pro-item-right">
                        <input type="text" class="sedang" name="inventory" id="inventory" onkeyup="inputCurrency(this)">
                    </span>
                </div>

                <div>
                    <td>
                        <div id="btn-config" class="btn btn-primary">Thiết lập sản phẩm</div>
                    </td>
                </div>
            </div>

            <div id="contai-productEntity-detail">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Phân loại hàng</th>
                        <th>Giá</th>
                        <th>Kho hàng</th>
                    </tr>
                    </thead>
                    <tbody id="body-productEntity-config"></tbody>
                </table>
            </div>

            <div class="item-contain">
                <span class="pro-item-left"><b>Mô tả chi tiết</b></span>
                <span class="pro-item-right">
                    <textarea type="text" placeholder="" name="mota" id="description"><%=error%></textarea>
                </span>
            </div>

            <div class="item-contain">
                <span class="pro-item-left"></span>
                <span class="pro-item-right">
                    <button id="insert" class="btn btn-primary">Thêm sản phẩm</button>
                </span>
                </di>
            </div>
            <input type="hidden" id="count" name="count" value="0">
        </div>
        <jsp:include page="footer.jsp"></jsp:include>
    </div>
</div>


<!-- Modal select image -->
<div class="modal fade" id="modal" role="dialog">
    <div class="modal-dialog" style="max-width: 800px;width: auto">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-title">Chọn ảnh</span>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body" id="modal-content">
                <div class="images-contain">
                    <%
                        for (int i = 0; i < imageList.size(); i++) {
                    %>

                    <div class="image-contain-item">
                        <input type="hidden" id="imageUrl" value="<%=imageList.get(i).getImageUrl()%>">
                        <img class="image image-select" src="<%=imageList.get(i).getImageUrl()%>" alt="">
                        <div><%=imageList.get(i).getImageName()%>
                        </div>
                    </div>

                    <%}%>
                </div>
            </div>
            <div class="modal-footer">
                <button id="btn-close" type="button" class="btn btn-primary" data-dismiss="modal">Đóng</button>
            </div>
        </div>

    </div>
</div>

<script>
    var isProductImage;
    var imageColors = [];
    var imageProduct = [];
    var sizes = [];

    /** Thiết lập bảng sản phẩm chi tiết */
    $("#btn-config").click(function (e) {
        let price = $("#price").val();
        let inventory = $("#inventory").val();

        if (imageColors.length != 0 && sizes.length != 0 &&
            price != '' && inventory != '') {
            $('#body-productEntity-config').html('')
            for (let i = 0; i < imageColors.length; i++) {
                $('#body-productEntity-config').append(
                    '<tr>' +
                    '    <td><img class=\'image\' src=\"' + imageColors[i] + '\" ></td>' +
                    '    <td></td>' +
                    '    <td></td>' +
                    '</tr>'
                )
                let imageName = imageColors[i].substr(0, imageColors[i].indexOf(".")).replaceAll("/image?fileName=", "")

                for (let j = 0; j < sizes.length; j++) {
                    $('#body-productEntity-config').append(
                        '<tr>' +
                        '    <td id=\"sizeName' + i + j + '\">' + imageName + " - " + sizes[j] + '</td>' +
                        '    <td><input id=\"price' + i + j + '\" type="text" value=\"' + price + '\" onkeyup="inputCurrency(this)"></td>' +
                        '    <td><input id=\"inventory' + i + j + '\" type="text" value=\"' + inventory + '\" onkeyup="inputCurrency(this)"></td>' +
                        '</tr>'
                    )
                }
            }
        } else {
            alert("Bạn chưa nhập đủ thông tin !!!")
        }

    })

    /** Mở modal để thêm ảnh cho màu */
    $('#btn-select-image-color').on('click', function () {
        isProductImage = false;
        $('#modal').modal('show');
    })

    /** Mở modal để thêm ảnh cho sản phẩm */
    $('#btn-select-image').on('click', function () {
        isProductImage = true;
        $('#modal').modal('show');
    })

    /** Thêm ảnh cho sản phẩm hoặc ảnh cho màu dựa vào isProductImage */
    $('.image-select').on('click', function () {
        var imageUrl = $(this).parent().find('#imageUrl').val();

        if (isProductImage) {
            // Kiểm tra nếu ảnh đã được chọn rồi thì sẽ không được chọn nữa
            let check = true;
            for (let i = 0; i < imageProduct.length; i++) {
                if (imageUrl == imageProduct[i]) {
                    check = false;
                    break;
                }
            }
            if (check) {
                $('#image-display').append(
                    '<img class=\'image productImage\' src=\"' + imageUrl + '\" >');
                imageProduct.push(imageUrl);
                $('#modal').modal('hide');
            } else {
                alert('Bạn đã thêm ảnh này rồi !!')
            }

        } else {
            // Kiểm tra nếu ảnh đã được chọn rồi thì sẽ không được chọn nữa
            let check = true;
            for (let i = 0; i < imageColors.length; i++) {
                if (imageUrl == imageColors[i]) {
                    check = false;
                    break;
                }
            }
            if (check) {
                $('#image-display-color').append(
                    '<img class=\'image colorImage\' src=\"' + imageUrl + '\" >');
                imageColors.push(imageUrl);
                $('#modal').modal('hide');
            } else {
                alert('Bạn đã thêm ảnh này rồi !!')
            }
        }

    })

    /** Xóa productImage */
    $('#image-display').on('click', '.productImage', function () {
        let productImageSrc = $(this).attr('src');
        for (let i = 0; i < imageProduct.length; i++) {
            if (productImageSrc == imageProduct[i]) {
                imageProduct.splice(i, 1);
                break;
            }
        }
        $(this).remove('.productImage');
    })

    /** Xóa productColor */
    $('#image-display-color').on('click', '.colorImage', function () {
        let colorImageSrc = $(this).attr('src');
        for (let i = 0; i < imageColors.length; i++) {
            if (colorImageSrc == imageColors[i]) {
                imageColors.splice(i, 1);
                break;
            }
        }
        $(this).remove('.colorImage');
    })

    /** Xóa size name */
    $('.size-display').on('click', '.size-item', function () {
        let sizeItem = $(this).html();
        for (let i = 0; i < sizes.length; i++) {
            if (sizeItem == sizes[i]) {
                sizes.splice(i, 1);
                break;
            }
        }
        $(this).remove('.size-item');
        console.log('sizeItem')
        console.log(sizeItem)
    })

    /** Thêm size name */
    $('#btn-select-size').on('click', function () {
        var sizeVal = $('#sizeName').val();

        if (sizeVal != '') {
            $('.size-display').append(
                '<div class=\"size-item\">' + sizeVal + '</div>');

            sizes.push(sizeVal);

            $('#sizeName').val('')
        }
    })

    /** Gửi data lên server */
    $('#insert').on('click', function () {

        /** Form Data */
        var data = {
            cateId: '',
            productCode: '',
            productName: '',
            productImage: [],
            productColorImage: [],
            productDetail: [],
            description: ''
        };

        /** Set productEntity field */
        data.cateId = $('#categoryId').val();
        data.productCode = $('#productCode').val();
        data.productName = $('#productName').val();
        data.description = $('#description').val();

        /** Push list product image to data by object */
        for (let i = 0; i < imageProduct.length; i++) {
            let productImage = {
                imageUrl: imageProduct[i]
            }

            data.productImage.push(productImage)
        }

        /** Push list color image to data by object */
        for (let i = 0; i < imageColors.length; i++) {
            let colorImage = {
                imageUrl: imageColors[i]
            }

            data.productColorImage.push(colorImage)
        }

        /** Validate */
        if (data.cateId == '' || data.productCode == '' || data.productName == '' ||
        data.productImage == [] || data.productColorImage == [] || data.productDetail == [] || data.description == '') {
            alert('Bạn chưa nhập đủ các trường');
            return;
        }
        /** Validate */
        if ($('#body-productEntity-config').html() == '') {
            alert('Bạn chưa thiết lập sản phẩm');
            return;
        }

        /**
         * Set productEntity detail field
         */
        for (let i = 0; i < imageColors.length; i++) {
            for (let j = 0; j < sizes.length; j++) {
                let sizeName = $('#sizeName' + i + j).html();
                let price = $('#price' + i + j).val().replaceAll(',', '');
                let inventory = $('#inventory' + i + j).val().replaceAll(',', '');

                let productDetail = {
                    imageColorUrl: imageColors[i],
                    sizeName: sizeName,
                    price: price,
                    inventory: inventory
                }
                data.productDetail.push(productDetail);
            }
        }

        $.ajax({
            url: '/insert_product',
            dataType: 'text',
            type: 'POST',
            cache: false,
            contentType: 'application/json',
            data: JSON.stringify(
                data
            ),

            success: function (data) {
                if (data == 'success') {
                    window.location.href = "/admin/manager_product";
                }
            },
            error: function (data) {
                alert('Có lỗi xảy ra')
            }
        })
    })

    /** Validate input currency*/
    function inputCurrency(event) {
        let inputValue = event.value.replaceAll(',', '');
        if (isNaN(inputValue) || inputValue.length > 11) {
            $(event).val(formatCurrency(inputValue.slice(0, inputValue.length - 1)));
        } else {
            $(event).val(formatCurrency(inputValue));
        }
    }

    /** Format currency */
    function formatCurrency(input) {
        var count = 1;
        for (let i = input.length - 1; i >= 0; i--) {
            if (count % 3 === 0 && i != 0) {
                input = input.slice(0, i) + ',' + input.slice(i, input.length);
                count = 1;
            } else {
                count++;
            }
        }
        return input;
    }

</script>

</body>
</html>
