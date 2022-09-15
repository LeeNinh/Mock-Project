package com.tainguyen.demo.controllers;

import com.tainguyen.demo.model.BillDetailDto;
import com.tainguyen.demo.repository.BillDetailGet;
import com.tainguyen.demo.repository.BillGet;
import com.tainguyen.demo.repository.CategoryGet;
import com.tainguyen.demo.repository.UtilityRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;

@Controller
public class ManagerBill extends HttpServlet {

    @Autowired
    BillGet billGet;

    @Autowired
    BillDetailGet billDetailGet;

    @Autowired
    UtilityRepo utilityRepo;

    @GetMapping("/getBillPaging")
    protected String getBillPaging(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        String offset = request.getParameter("offset");
        String limit = request.getParameter("limit");
        String productCode = request.getParameter("productCode");
        String productName = request.getParameter("productName");
        String customerName = request.getParameter("customerName");
        String status = request.getParameter("bill_status");

        request.setAttribute("offset", offset);
        request.setAttribute("limit", limit);
        request.setAttribute("productCode", productCode);
        request.setAttribute("productName", productName);
        request.setAttribute("customerName", customerName);
        request.setAttribute("bill_status", status);

        return "admin/manager_bill";
    }

    @GetMapping("/getBillDetailByBillId")
    protected ResponseEntity getBillDetailByBillId(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        DecimalFormat formatter = new DecimalFormat("###,###,###");

        String billId = request.getParameter("billId");
        ArrayList<BillDetailDto> billDetailDtos = billDetailGet.getBillDetailByBillId(Long.parseLong(billId));
        
        String result = "";
        for (int i = 0; i < billDetailDtos.size(); i++) {
            result += "<div class='d-flex contain-item' style='word-break: break-all'>" +
                      "    <div>" +
                      "         <img src='" + billDetailDtos.get(i).getColorImageUrl() + "' class='fashion-grid'>" +
                      "    </div>" +
                      "    <div class='d-flex flex-column mr-1 ml-1'>" +
                      "        <div class='item-contain'>" +
                      "            <div class='item1'>Size: " + billDetailDtos.get(i).getSize() + "</div>" +
                      "        </div>" +
                      "        <div class='item-contain'>" +
                      "            <div class='item1'>Số lượng: " + billDetailDtos.get(i).getQuantity() + "</div>" +
                      "        </div>" +
                      "        <div class='item-contain'>" +
                      "            <div class='item1'>Giá: " + formatter.format(billDetailDtos.get(i).getPrice()) + " vnd</div>" +
                      "        </div>" +
                      "    </div>" +
                      "</div>";
        }

        return ResponseEntity.ok(result);
    }
}