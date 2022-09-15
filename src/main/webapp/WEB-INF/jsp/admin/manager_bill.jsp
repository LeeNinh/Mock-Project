<%@page import="java.text.DecimalFormat" %>
<%@page import="java.util.ArrayList" %>
<%@ page import="com.tainguyen.demo.model.BillDto" %>
<%@ page import="com.tainguyen.demo.repository.BillGet" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản lý hóa đơn</title>

    <!-- js -->
    <script src="${root}/js/jquery.min.js"></script>
    <!-- //js -->
    <!-- for bootstrap working -->
    <script type="text/javascript" src="${root}/js/bootstrap-3.1.1.min.js"></script>
    <!-- //for bootstrap working -->

    <c:set var="root" value="${pageContext.request.contextPath}"/>
    <link href="${root}/css/mos-style.css" rel='stylesheet' type='text/css'/>
    <link href="${root}/css/bootstrap.css" rel="stylesheet" type="text/css" media="all"/>
    <link href="${root}/css/style.css" rel="stylesheet" type="text/css" media="all"/>
</head>
<body>

<%
    BillGet billGet = new BillGet();
    String offset = request.getAttribute("offset") != null ? (String) request.getAttribute("offset") : "0";
    String limit = request.getAttribute("limit") != null ? (String) request.getAttribute("limit") : "10";
    // Search param
    String productCode = request.getAttribute("productCode") != null ? (String) request.getAttribute("productCode") : "";
    String productName = request.getAttribute("productName") != null ? (String) request.getAttribute("productName") : "";
    String customerName = request.getAttribute("customerName") != null ? (String) request.getAttribute("customerName") : "";
    String status = request.getAttribute("bill_status") != null ? (String) request.getAttribute("bill_status") : "";

    ArrayList<BillDto> billList = billGet.searchHistoryPaging(Integer.parseInt(offset), Integer.parseInt(limit),
            productCode, productName, customerName, status);
    DecimalFormat formatter = new DecimalFormat("###,###,###");
%>

<jsp:include page="header.jsp"></jsp:include>
<div class="d-flex">
    <jsp:include page="menu.jsp"></jsp:include>
    <input id="offset" type="hidden" value="<%=offset%>">
    <input id="limit" type="hidden" value="<%=limit%>">
    <input id="listSize" type="hidden" value="<%=billList == null ? 0 : billList.size()%>">
    <div id="rightContent">
        <h3>Quản lý hóa đơn</h3>

        <div class="contain-item d-flex">
            <div class="form-group d-flex" style="align-items: center">
                <label for="productCode">Mã sản phẩm:</label>
                <input type="text" class="ml-1 form-control" id="productCode" style="" value="<%=productCode%>">
            </div>
            <div class="form-group d-flex ml-2" style="align-items: center">
                <label for="productCode">Tên sản phẩm:</label>
                <input type="text" class="ml-1 form-control" id="productName" style="" value="<%=productName%>">
            </div>
        </div>
        <div class="contain-item d-flex">
            <div class="form-group d-flex" style="align-items: center">
                <label for="productCode">Khách hàng:</label>
                <input type="text" class="ml-1 form-control" id="customerName" style="" value="<%=customerName%>">
            </div>
            <div class="form-group d-flex ml-2" style="align-items: center">
                <label for="productCode">Trạng thái:</label>
                <select class="status" id="status">
                    <option <%if (status == null) {%>
                            selected="selected"
                            <% } %>
                    >
                    </option>
                    <option <%if (status.equals("1")) {%>
                            selected="selected"
                            <%=status%>
                            <% } %>
                            value="1">
                        Chờ đặt
                    </option>
                    <option <%if (status.equals("2")) {%>
                            selected="selected"
                            <% } %>
                            value="2">
                        Đã đặt
                    </option>
                    <option <%if (status.equals("3")) {%>
                            selected="selected"
                            <% } %>
                            value="3">
                        Về kho VN
                    </option>
                    <option <%if (status.equals("4")) {%>
                            selected="selected"
                            <% } %>
                            value="4">
                        Đã giao cho khách
                    </option>
                    <option <%if (status.equals("5")) {%>
                            selected="selected"
                            <% } %>
                            value="5">
                        Đã hủy
                    </option>
                    <option <%if (status.equals("6")) {%>
                            selected="selected"
                            <% } %>
                            value="6">
                        Chưa về đủ
                    </option>
                </select>
            </div>
        </div>
        <button id="btn-search" class="ml-1 btn btn-primary mr-1">Tìm Kiếm</button>
        <button id="exportExcel" class="ml-1 btn btn-primary mr-1">Export excel</button>
        <button id="exportPdf" class="ml-1 btn btn-primary mr-1">Export pdf</button>

        <table class="data">
            <tr class="data">
                <th class="data">STT</th>
                <th class="data"></th>
                <th class="data">Hình ảnh</th>
                <th class="data">Tên khách hàng</th>
                <th class="data">Sản phẩm</th>
                <th class="data">Tổng số lượng</th>
                <th class="data" style="min-width: 90px">Giảm giá</th>
                <th class="data">Tổng đơn hàng</th>
                <th class="data">Ngày order</th>
                <th class="data">Trạng thái</th>
                <th class="data">Ghi chú của user</th>
                <th class="data">Ghi chú của admin</th>
                <th class="data">Hành động</th>
            </tr>

            <%
                int count = 0;
                for (BillDto billDto : billList) {
                    count++;
            %>
            <tr class="data">
                <input class="billId" type="hidden" value="<%=billDto.getBillId()%>">
                <input class="billStatus" type="hidden" value="<%=billDto.getStatus()%>">
                <td class="data"><%=Integer.parseInt(offset) + count%></td>
                <td class="data">
                    <%if (billDto.getStatus() == 1 || billDto.getStatus() == 3) {%>
                        <input type="checkbox" class="select-bill">
                    <% } %>
                </td>
                <td class="data">
                    <img class="image" src="<%=billDto.getProductImage() != null ? billDto.getProductImage().get(0).getImageUrl() : ""%>" alt="">
                </td>
                <td class="data userName"><%=billDto.getUserName()%></td>
                <td class="data"><%=billDto.getProductCode()%> - <%=billDto.getProductName()%></td>
                <td class="data text-center"><%=billDto.getTotalQuantity()%></td>
                <td class="data text-center">
                    <input type="text"
                           class="discount"
                           onkeyup="inputCurrency(this)"
                           value="<%=formatter.format(billDto.getDiscount())%>"> vnđ
                </td>
                <td class="data text-right">
                    <%=formatter.format(billDto.getTotalPrice() - billDto.getDiscount())%> vnđ
                </td>
                <td class="data"><%=billDto.getDate()%></td>
                <td class="data">
                    <select class="status">
                        <option <%if (billDto.getStatus() == 1) {%>
                                selected="selected"
                                <% } %>
                                value="1">
                            Chờ đặt
                        </option>
                        <option <%if (billDto.getStatus() == 2) {%>
                                selected="selected"
                                <% } %>
                                value="2">
                            Đã đặt
                        </option>
                        <option <%if (billDto.getStatus() == 3) {%>
                                selected="selected"
                                <% } %>
                                value="3">
                            Về kho VN
                        </option>
                        <option <%if (billDto.getStatus() == 4) {%>
                                selected="selected"
                                <% } %>
                                value="4">
                            Đã giao cho khách
                        </option>
                        <option <%if (billDto.getStatus() == 5) {%>
                                selected="selected"
                                <% } %>
                                value="5">
                            Đã hủy
                        </option>
                        <option <%if (billDto.getStatus() == 6) {%>
                                selected="selected"
                                <% } %>
                                value="6">
                            Chưa về đủ
                        </option>
                    </select>
                </td>
                <td class="data"><%=billDto.getUserNote()%></td>
                <td class="data">
                    <textarea type="text" rows="5" class="adminNote"><%=billDto.getAdminNote()%></textarea>
                </td>
                <td class="data">
                    <button class="btn btn-primary btn-save">Lưu</button>
                </td>
            </tr>
            <%}%>
        </table>
        <button id="previousPage" class="btn btn-primary">Trang trước</button>
        <button id="nextPage" class="btn btn-primary">Trang sau</button>
    </div>
    <div class="clear"></div>
</div>

<!-- Modal display bill detail -->
<div class="modal fade" id="modalBillDetail" role="dialog">
    <div class="modal-dialog" style=" max-width: 800px;width: auto">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-title">Chi Tiết Đơn Hàng</span>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body" id="productDetailBody">

            </div>
            <div class="modal-footer">
                <button id="btn-close" type="button" class="btn btn-primary" data-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

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

<jsp:include page="footer.jsp"></jsp:include>
<script>
    $("#previousPage").click(function () {
        let offset = Number($("#offset").val()) - 10;
        let limit = $("#limit").val();
        if (offset < 0) {
            offset = 0;
        }
        window.location.href = "/getBillPaging?offset=" + offset + "&limit=" + limit;
    });

    $("#nextPage").click(function () {
        let offset = Number($("#offset").val()) + 10;
        let limit = $("#limit").val();
        let listSize = $("#listSize").val();

        if (listSize < 10) {
            offset -= 10;
        }

        window.location.href = "/getBillPaging?offset=" + offset + "&limit=" + limit;
    });

    $("#btn-search").click(function () {
        let offset = 0;
        let limit = 10;
        let productCode = $("#productCode").val();
        let productName = $("#productName").val();
        let customerName = $("#customerName").val();
        let status = $("#status").val();

        let url = "/getBillPaging?offset=" + offset + "&limit=" + limit;

        if (productCode != "") {
            url += "&productCode=" + productCode;
        }

        if (productName != "") {
            url += "&productName=" + productName;
        }

        if (customerName != "") {
            url += "&customerName=" + customerName;
        }

        if (status != "") {
            url += "&bill_status=" + status;
        }

        window.location.href = url;
    });

    $(".btn-save").click(function (e) {
        var status = $(this).parent().parent().find('.status').val();
        var billId = $(this).parent().parent().find('.billId').val();
        var discount = $(this).parent().parent().find('.discount').val().replaceAll(',', '');
        var adminNote = $(this).parent().parent().find('.adminNote').val();

        // Validate
        if (isNaN(discount)) {
            // $('#modal-mess-content').html("Tổng đơn hàng chỉ được nhập số");
            // $('#modal-mess').modal('show');
            alert("Tổng đơn hàng chỉ được nhập số")
            return;
        }

        $.get('/billMod',
            {
                'billId': billId,
                'billStatus': status,
                'discount': discount,
                'adminNote': adminNote
            },
            function (data) {
                if (data == 'success') {
                    // $("#modal-mess-content").html("Thay đổi trạng thái thành công")
                    alert("Thay đổi trạng thái thành công")
                    location.reload();
                } else {
                    // $("#modal-mess-content").html("Thay đổi trạng thái thất bại")
                    alert("Thay đổi trạng thái thất bại")
                    location.reload();
                }
                // $("#modal-mess").modal('show');
            })
    });

    /** Reload page after close message */
    $("#btn-mess-close").click(function () {
        location.reload();
    })

    /** Get billEntity detail and show popup */
    $(".image").click(function (e) {
        var billId = $(this).parent().parent().find('.billId').val();

        $.get('/getBillDetailByBillId',
            {
                'billId': billId
            },
            function (data) {
                $("#productDetailBody").html(data);
                window.$('#modalBillDetail').modal('show');
            });
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

    /** bill selected list */
    var billSelectedList = [];

    /** user selected list */
    var userSelectedList = [];

    /** status selected list */
    var statusSelectedList = [];

    /** Handle select bill */
    $(".select-bill").click(function (e) {
        let billId = $(this).parent().parent().find('.billId').val();
        let billStatus = $(this).parent().parent().find('.billStatus').val();
        let userName = $(this).parent().parent().find('.userName').text();
        let isChecked = $(this).is(":checked");

        if (isChecked) {
            billSelectedList.push(billId);
            userSelectedList.push(userName);
            statusSelectedList.push(billStatus);
        } else {
            for (let i = 0; i < billSelectedList.length; i++) {
                if (billId == billSelectedList[i]) {
                    billSelectedList.splice(i, 1);
                    userSelectedList.splice(i, 1);
                    statusSelectedList.splice(i, 1);
                    break;
                }
            }
        }

    })

    /** Export file (Excel) */
    $("#exportExcel").click(function exportFile () {
        debugger
        if (billSelectedList.length == 0) {
            alert("Bạn chưa chọn đơn cần xuất");
            return;
        }

        // Các đơn xuất pdf phải ở trạng thái "Chờ đặt"
        if (statusSelectedList.length > 1) {
            for (let i = 0; i < statusSelectedList.length; i++) {
                if (statusSelectedList[i] != 1) {
                    alert("Các đơn xuất excel phải ở trạng thái Chờ đặt")
                    return;
                }
            }
        }

        $.ajax({
            url: '/export_file_excel',
            type: 'POST',
            cache: false,
            contentType: 'application/json',
            data: JSON.stringify(
                {
                    'billList': billSelectedList,
                }
            ),

            success: function (data) {
                window.open("/download/1/" + data);
                location.reload();
            },
            error: function (err) {
                alert('Có lỗi xảy ra')
            }
        })
    })

    /** Export file (Pdf) */
    $("#exportPdf").click(function exportFile () {
        if (billSelectedList.length == 0) {
            alert("Bạn chưa chọn đơn cần xuất");
            return;
        }

        // Các đơn xuất pdf phải cùng 1 khách hàng
        if (userSelectedList.length > 1) {
            for (let i = 1; i < userSelectedList.length; i++) {
                if (userSelectedList[0] != userSelectedList[i]) {
                    alert("Các đơn xuất pdf phải cùng 1 khách hàng")
                    return;
                }
            }
        }

        // Các đơn xuất pdf phải ở trạng thái "Về kho VN"
        if (statusSelectedList.length > 1) {
            for (let i = 0; i < statusSelectedList.length; i++) {
                if (statusSelectedList[i] != 3) {
                    alert("Các đơn xuất pdf phải ở trạng thái Về kho VN")
                    return;
                }
            }
        }

        $.ajax({
            url: '/export_file_pdf',
            dataType: 'text',
            type: 'POST',
            cache: false,
            contentType: 'application/json',
            data: JSON.stringify(
                {
                    'billList': billSelectedList,
                }
            ),

            success: function (data) {
                window.open("/download/2/" + data);
                location.reload();
            },
            error: function (data) {
                alert('Có lỗi xảy ra')
            }
        })
    })

</script>
</body>
</html>