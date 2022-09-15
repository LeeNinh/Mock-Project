<%@page import="com.tainguyen.demo.repository.ProductRepo" %>
<%@ page import="com.tainguyen.demo.repository.CategoryGet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.tainguyen.demo.model.*" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tainguyen.demo.repository.ImageRepo" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cập nhật sản phẩm</title>

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
        error = request.getParameter("error");
    }
    ProductDisplayDto productDisplayDto = new ProductRepo().getProduct(Long.parseLong(request.getParameter("product_id")));

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
        <h3>CẬP NHẬT SẢN PHẨM</h3>

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
                <input id="productId" type="hidden" value="<%=productDisplayDto.getProductId()%>">
                <span class="pro-item-left"><b>Tên danh mục</b></span>
                <span class="pro-item-right">
                    <div>
                        <span></span>
                        <select name="maloai">
                            </option>
                            <%for (Category c : categoryget.getListCategory()) {%>
                            <option <%if (productDisplayDto.getCateId() == c.getCategoryID()) {%>
                                    selected="selected"
                                    <% } %>
                                    value="<%=c.getCategoryID()%>">
                                <%=c.getCategoryName()%>
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
                    <input type="text" class="sedang" name="maSanPham" id="productCode"
                           value="<%=productDisplayDto.getProductCode()%>"><%=error%>
                </span>
            </div>

            <div class="item-contain">
                <span class="pro-item-left"><b>Tên sản phẩm</b></span>
                <span class="pro-item-right">
                    <input type="text" class="sedang" name="tenSanPham" id="productName"
                           value="<%=productDisplayDto.getProductName()%>"><%=error%>
                </span>
            </div>

            <div class="item-contain">
                <span class="pro-item-left"><b>Hình đại diện</b></span>
                <span class="pro-item-right">
                    <span id="image-display">
                        <% for (int i = 0; i < productDisplayDto.getProductImageList().size(); i++) {%>
                                <img class='image productImage'
                                     src="<%=productDisplayDto.getProductImageList().get(i).getImageUrl()%>">
                        <%}%>
                    </span>
                    <button type="button" id="btn-select-image">Chọn ảnh</button>
                </span>
            </div>

            <div class="">
                <div class="item-contain">
                    <span class="pro-item-left"><b>Màu sắc</b></span>
                    <span class="pro-item-right">
                        <span id="image-display-color">
                             <% for (int i = 0; i < productDisplayDto.getProductColorImageList().size(); i++) {%>
                                <img class='image colorImage'
                                     src="<%=productDisplayDto.getProductColorImageList().get(i).getImageUrl()%>">
                             <%}%>
                        </span>
                        <input type="hidden" id="imagesProductColor" name="imageColor">
                        <button type="button" id="btn-select-image-color">Chọn ảnh</button>
                    </span>
                </div>

                <div class="item-contain">
                    <span class="pro-item-left"><b>Kích thước</b></span>
                    <span class="pro-item-right">
                        <span class="size-display">
                            <% int numberOfSize = productDisplayDto.getProductDetailList().size() / productDisplayDto.getProductColorImageList().size();
                                for (int i = 0; i < numberOfSize; i++) {%>
                                <div class="size-item"><%=productDisplayDto.getProductDetailList().get(i).getName()%></div>
                            <% }%>
                        </span>
                        <input type="hidden" class="sedang" name="sizeName">
                        <input type="text" class="sedang" id="sizeName">
                        <button type="button" id="btn-select-size">Thêm size</button>
                    </span>
                </div>

                <div class="item-contain">
                    <span class="pro-item-left"><b>Giá</b></span>
                    <span class="pro-item-right">
                        <input type="text" class="sedang" name="price" id="price">
                    </span>
                </div>

                <div class="item-contain">
                    <span class="pro-item-left"><b>Số lượng</b></span>
                    <span class="pro-item-right">
                        <input type="text" class="sedang" name="inventory" id="inventory">
                    </span>
                </div>

                <div>
                    <td>
                        <div id="btn-config" class="add-pro-detail">Thiết lập sản phẩm</div>
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
                    <tbody id="body-productEntity-config">
                    <%
                        long productColorId = productDisplayDto.getProductDetailList().get(0).getProductColorId();
                        ArrayList<ProductSizeEntity> sizesOfColor = new ArrayList();
                        for (int i = 0; i < productDisplayDto.getProductDetailList().size(); i++) {
                            if (productDisplayDto.getProductDetailList().get(i).getProductColorId() == productColorId) {
                                sizesOfColor.add(productDisplayDto.getProductDetailList().get(i));
                            } else {
                                break;
                            }
                        }

                        for (int i = 0; i < productDisplayDto.getProductColorImageList().size(); i++) {%>
                    <tr>
                        <td><img class='image'
                                 src="<%=productDisplayDto.getProductColorImageList().get(i).getImageUrl()%>"></td>
                        <td></td>
                        <td></td>
                    </tr>

                    <% for (int j = 0; j < sizesOfColor.size(); j++) {%>

                    <tr>
                        <td id="sizeName<%=i + "" + j%>"><%=sizesOfColor.get(j).getName()%></td>
                        <td>
                            <input id="price<%=i + "" + j%>" type="text" value="<%=sizesOfColor.get(j).getPrice()%>">
                        </td>
                        <td>
                            <input id="inventory<%=i + "" + j%>" type="text" value="<%=sizesOfColor.get(j).getInventory()%>">
                        </td>
                    </tr>
                    <%}%>
                    <%}%>
                    </tbody>
                </table>
            </div>

            <div class="item-contain">
                <span class="pro-item-left"><b>Mô tả chi tiết</b></span>
                <span class="pro-item-right">
                    <textarea type="text" placeholder="" name="mota" id="description"><%=productDisplayDto.getDescription()%></textarea>
                </span>
            </div>

            <div class="item-contain">
                <span class="pro-item-left"></span>
                <span class="pro-item-right">
                    <button id="insert" class="button">Cập nhật sản phẩm</button>
                </span>
            </div>
            <input type="hidden" id="count" name="count" value="0">
        </div>
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

<jsp:include page="footer.jsp"></jsp:include>

<script>
    var isProductImage;
    var imageProduct = [];
    var imageColors = [];
    var sizes = [];

    /** Initial imageProduct*/
    let imageProHtml = $('#image-display').find('.productImage');
    for (let i = 0; i < imageProHtml.length; i++) {
        let imageUrl = '/image?' + imageProHtml[i].src.split('?')[1];
        imageProduct.push(imageUrl);
    }

    /** Initial imageColors*/
    let imageColorHtml = $('#image-display-color').find('.colorImage');
    for (let i = 0; i < imageColorHtml.length; i++) {
        let imageUrl = '/image?' + imageColorHtml[i].src.split('?')[1];
        imageColors.push(imageUrl);
    }

    /** Initial sizes*/
    let sizesoHtml = $('.size-display').find('.size-item');
    for (let i = 0; i < sizesoHtml.length; i++) {
        sizes.push(sizesoHtml[i].innerHTML);
    }

    /** Thiết lập bảng sản phẩm chi tiết */
    $("#btn-config").click(function (e) {
        $('#body-productEntity-config').html('')

        let price = $("#price").val();
        let inventory = $("#inventory").val();

        if (imageColors.length != 0 && sizes.length != 0 &&
            price != '' && inventory != '') {
            for (let i = 0; i < imageColors.length; i++) {
                $('#body-productEntity-config').append(
                    '<tr>' +
                    '    <td><img class=\'image\' src=\"' + imageColors[i] + '\" ></td>' +
                    '    <td></td>' +
                    '    <td></td>' +
                    '</tr>'
                )
                for (let j = 0; j < sizes.length; j++) {
                    $('#body-productEntity-config').append(
                        '<tr>' +
                        '    <td id=\"sizeName' + i + j + '\">' + sizes[j] + '</td>' +
                        '    <td><input id=\"price' + i + j + '\" type="text" value=\"' + price + '\"></td>' +
                        '    <td><input id=\"inventory' + i + j + '\" type="text" value=\"' + inventory + '\"></td>' +
                        '</tr>'
                    )
                }
            }
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
        // Product id
        let productId = $('#productId').val();

        /** Form Data */
        var data = {
            cateId: '',
            productId: productId,
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
                let price = $('#price' + i + j).val();
                let inventory = $('#inventory' + i + j).val();

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
            url: '/update_product',
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

</script>

</body>
</html>
