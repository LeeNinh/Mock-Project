package com.tainguyen.demo.repository;

import com.tainguyen.demo.connect.DBConnect;
import com.tainguyen.demo.model.BillDto;
import com.tainguyen.demo.model.BillEntity;
import org.springframework.stereotype.Component;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@Component
public class BillGet {
    ProductImageRepo productImageRepo = new ProductImageRepo();

    BillDetailGet billDetailGet = new BillDetailGet();

    public boolean insertBill(BillEntity billEntity) {
        Connection connection = DBConnect.getConnecttion();
        String sql = "INSERT INTO bill (bill_id, user_id, product_id, bill.date, user_note, admin_note," +
                " total_quantity, total_price, status, discount) " +
                " VALUES(?,?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, billEntity.getBillId());
            ps.setLong(2, billEntity.getUserId());
            ps.setLong(3, billEntity.getProductId());
            ps.setTimestamp(4, billEntity.getDate());
            ps.setString(5, billEntity.getUserNote());
            ps.setString(6, billEntity.getAdminNote());
            ps.setInt(7, billEntity.getTotalQuantity());
            ps.setLong(8, billEntity.getTotalPrice());
            ps.setInt(9, billEntity.getStatus());
            ps.setInt(10, 0);

            ps.executeUpdate();
            connection.close();
        } catch (SQLException exp) {
            return false;
        }
        return true;
    }

    /**
     *
     */
    public ArrayList<BillDto> getHistoryByUser(long userId) {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "select bill_id, bill.product_id, user_id, product_code, product_name, " +
                    " bill.date, status, total_quantity, total_price, user_note, admin_note " +
                    " from bill left join product on bill.product_id = product.product_id " +
                    " where bill.user_id = ?" +
                    " order by bill.date desc";

            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, userId);

            ResultSet rs = ps.executeQuery();
            ArrayList<BillDto> list = new ArrayList<>();
            while (rs.next()) {
                BillDto history = new BillDto();

                history.setBillId(rs.getLong("bill_id"));
                history.setProductId(rs.getLong("product_id"));
                history.setUserId(rs.getLong("user_id"));
                history.setProductCode(rs.getString("product_code"));
                history.setProductName(rs.getString("product_name"));
                history.setDate(rs.getString("date"));
                history.setStatus(rs.getInt("status"));
                history.setTotalQuantity(rs.getInt("total_quantity"));
                history.setTotalPrice(rs.getInt("total_price"));
                history.setUserNote(rs.getString("user_note") == null ? "" : rs.getString("user_note"));
                history.setAdminNote(rs.getString("admin_note") == null ? "" : rs.getString("admin_note"));

                list.add(history);
            }

            // Duyệt sản phẩm
            for (int i = 0; i < list.size(); i++) {
                // Lấy danh sách ảnh của sản phẩm
                list.get(i).setProductImage(productImageRepo.getImageByProductId(list.get(i).getProductId()));

                // Lấy thông tin của 1 size
                list.get(i).setBillDetailDtos(billDetailGet.getBillDetailByProductId(list.get(i).getProductId()));
            }

            return list;
        } catch (SQLException ex) {
            Logger.getLogger(BillGet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // search history paging yêu cầu chỉ search
    public ArrayList<BillDto> searchHistoryPaging(Integer offset, Integer limit, String productCode, String productName,
                                                  String userName, String status) {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "select bill_id, bill.product_id, users.user_name, product_code, product_name, " +
                    " bill.date, status, total_quantity, total_price, user_note, admin_note, discount " +
                    " from bill left join product on bill.product_id = product.product_id " +
                    " left join users on users.user_id = bill.user_id" +
                    " where product_code like ? and product_name like ?" +
                    " and users.user_name like ? ";

            if (!status.equals("")) {
                sql += " and status = ? ";
            }

            sql += " order by bill.date desc limit " + offset + ", " + limit;

            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, "%" + productCode + "%");
            ps.setString(2, "%" + productName + "%");
            ps.setString(3, "%" + userName + "%");

            if (!status.equals("")) {
                ps.setInt(4, Integer.parseInt(status));
            }

            ResultSet rs = ps.executeQuery();
            ArrayList<BillDto> list = new ArrayList<>();
            while (rs.next()) {
                BillDto history = new BillDto();

                history.setBillId(rs.getLong("bill_id"));
                history.setProductId(rs.getLong("product_id"));
                history.setUserName(rs.getString("user_name"));
                history.setProductCode(rs.getString("product_code"));
                history.setProductName(rs.getString("product_name"));
                history.setDate(rs.getString("date"));
                history.setStatus(rs.getInt("status"));
                history.setTotalQuantity(rs.getInt("total_quantity"));
                history.setTotalPrice(rs.getInt("total_price"));
                history.setUserNote(rs.getString("user_note") == null ? "" : rs.getString("user_note"));
                history.setAdminNote(rs.getString("admin_note") == null ? "" : rs.getString("admin_note"));
                history.setDiscount(rs.getInt("discount"));

                list.add(history);
            }

            // Lấy danh sách ảnh của sản phẩm
            for (int i = 0; i < list.size(); i++) {
                list.get(i).setProductImage(productImageRepo.getImageByProductId(list.get(i).getProductId()));
            }

            return list;
        } catch (SQLException ex) {
            Logger.getLogger(BillGet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // bill status modified
    public void billMod(long billId, int status) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "UPDATE duonglien.bill set bill.status = ?" +
                " where bill_id = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setLong(1, status);
        ps.setLong(2, billId);

        ps.executeUpdate();
    }

    // bill modified
    public void billMod(long billId, int status, int discount, String adminNote) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "UPDATE duonglien.bill set bill.status = ?, admin_note = ?, discount = ?" +
                " where bill_id = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setLong(1, status);
        ps.setString(2, adminNote);
        ps.setLong(3, discount);
        ps.setLong(4, billId);

        ps.executeUpdate();
    }

    public ArrayList<BillDto> getHistoryByIds(List<String> ids) {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "select bill_id, bill.product_id, users.user_name, product_code, product_name, " +
                    " bill.date, status, total_quantity, total_price, user_note, admin_note, discount," +
                    " users.phone_number, users.address " +
                    " from bill " +
                    " left join product on bill.product_id = product.product_id " +
                    " left join users on users.user_id = bill.user_id ";

            if (ids.size() != 0) {
                sql += " where bill.bill_id = '" + ids.get(0) + "'";
                for (int i = 1; i < ids.size(); i++) {
                    sql += " or bill.bill_id = '" + ids.get(i) + "'";
                }
            } else {
                return null;
            }

            PreparedStatement ps = connection.prepareCall(sql);

            ResultSet rs = ps.executeQuery();
            ArrayList<BillDto> list = new ArrayList<>();
            while (rs.next()) {
                BillDto history = new BillDto();

                history.setBillId(rs.getLong("bill_id"));
                history.setProductId(rs.getLong("product_id"));
                history.setUserName(rs.getString("user_name"));
                history.setPhoneNumber(rs.getString("phone_number"));
                history.setAddress(rs.getString("address"));
                history.setProductCode(rs.getString("product_code"));
                history.setProductName(rs.getString("product_name"));
                history.setDate(rs.getString("date"));
                history.setStatus(rs.getInt("status"));
                history.setTotalQuantity(rs.getInt("total_quantity"));
                history.setTotalPrice(rs.getInt("total_price"));
                history.setUserNote(rs.getString("user_note") == null ? "" : rs.getString("user_note"));
                history.setAdminNote(rs.getString("admin_note") == null ? "" : rs.getString("admin_note"));
                history.setAdminNote(rs.getString("admin_note") == null ? "" : rs.getString("admin_note"));
                history.setDiscount(rs.getInt("discount"));

                list.add(history);
            }

            for (int i = 0; i < list.size(); i++) {
                // Lấy danh sách ảnh của sản phẩm
//                list.get(i).setProductImage(productImageRepo.getImageByProductId(list.get(i).getProductId()));

                // Lấy thông tin của bill detail
                list.get(i).setBillDetailDtos(billDetailGet.getBillDetailByBillId(list.get(i).getBillId()));
            }


            return list;
        } catch (SQLException ex) {
            Logger.getLogger(BillGet.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }
}
