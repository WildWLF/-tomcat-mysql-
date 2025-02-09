package dao;

import util.DBManager;
import vo.warehouse;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class WarehouseDao {
    public List<warehouse> getAllWarehouse() {
        List<warehouse> list = new ArrayList<warehouse>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String sql = "select * from warehouse where delete_at is null";
        try {
            conn = DBManager.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                warehouse warehouse = new warehouse();
                warehouse.setId(rs.getInt("id"));
                warehouse.setWarehouseName(rs.getString("warehouse_name"));
                warehouse.setWarehouseCode(rs.getString("warehouse_code"));
                warehouse.setCreateBy(rs.getString("create_by"));
                warehouse.setUpdateBy(rs.getString("update_by"));
                warehouse.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                warehouse.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
                list.add(warehouse);
            }
            conn.close();
            stmt.close();
            rs.close();
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<warehouse> selectWarehouse(String warehouseName, String warehouseCode) {
        List<warehouse> list = new ArrayList<warehouse>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String sql = "select * from warehouse where warehouse_name like '%" + warehouseName + "%' and warehouse_code like '%" + warehouseCode + "%' ";
        try {
            conn = DBManager.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                warehouse warehouse = new warehouse();
                warehouse.setId(rs.getInt("id"));
                warehouse.setWarehouseName(rs.getString("warehouse_name"));
                warehouse.setWarehouseCode(rs.getString("warehouse_code"));
                warehouse.setCreateBy(rs.getString("create_by"));
                warehouse.setUpdateBy(rs.getString("update_by"));
                warehouse.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                warehouse.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
                list.add(warehouse);
            }
            conn.close();
            stmt.close();
            rs.close();
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    //修改仓库信息 同步修改多个数据库里的信息
    public boolean UpdateWarehouse(warehouse warehouse) {
        boolean flag = false;
        Connection conn = null;
        PreparedStatement ps = null;
        int id = warehouse.getId();
        String warehouseName = warehouse.getWarehouseName();
        String warehouseCode = warehouse.getWarehouseCode();
        String updateBy = warehouse.getUpdateBy();
        Timestamp updatedAt = Timestamp.valueOf(warehouse.getUpdatedAt());
        String sql = "update warehouse set warehouse_name = ? , warehouse_code = ? , update_by = ? ,updated_at = ? where id = ?";
        try {
            conn = DBManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, warehouseName);
            ps.setString(2, warehouseCode);
            ps.setString(3, updateBy);
            ps.setTimestamp(4, updatedAt);
            ps.setInt(5, id);
            flag = ps.executeUpdate() > 0;
            sql = "update device set warehouse_name = ? , warehouse_code = ?  where warehouse_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, warehouseName);
            ps.setString(2, warehouseCode);
            ps.setInt(3, id);
            flag = ps.executeUpdate() > 0;
            sql = "update history set warehouse_name = ? , warehouse_code = ?  where warehouse_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, warehouseName);
            ps.setString(2, warehouseCode);
            ps.setInt(3, id);
            flag = ps.executeUpdate() > 0;
            conn.close();
            ps.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return flag;
    }

    public boolean insertWarehouse(warehouse warehouse) {
        boolean flag = false;
        Connection conn = null;
        PreparedStatement ps = null;
        int id = warehouse.getId();
        String warehouseName = warehouse.getWarehouseName();
        String warehouseCode = warehouse.getWarehouseCode();
        String createBy = warehouse.getCreateBy();
        Timestamp createdAt = Timestamp.valueOf(warehouse.getCreatedAt());
        Timestamp updatedAt = Timestamp.valueOf(warehouse.getUpdatedAt());
        String sql = "insert into warehouse (id,warehouse_name,warehouse_code,create_by,created_at,updated_at) values (?,?,?,?,?,?)";
        try {
            conn = DBManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.setString(2,warehouseName);
            ps.setString(3,warehouseCode);
            ps.setString(4,createBy);
            ps.setTimestamp(5,createdAt);
            ps.setTimestamp(6,updatedAt);
            flag = ps.executeUpdate() > 0;
        }catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return flag;
    }

    public int selectByKey(String warehouseName,String warehouseCode) {
        int id = -1;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "select * from warehouse where warehouse_name = ? and warehouse_code = ?";
        try{
            conn = DBManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, warehouseName);
            ps.setString(2, warehouseCode);
            rs = ps.executeQuery();
            while (rs.next()) {
                id = rs.getInt("id");
            }
        }catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return id;
    }
}
