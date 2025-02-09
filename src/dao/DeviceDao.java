package dao;

import util.DBManager;
import vo.device;
import vo.warehouse;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class DeviceDao {
    public List<device> getAllDevices(){
        List<device> devices = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String sql = "select * from device where delete_at is null";
        try {
            conn = DBManager.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
               device device = new device();
               device.setId(rs.getInt("id"));
               device.setDeviceName(rs.getString("device_name"));
               device.setDeviceCode(rs.getString("device_code"));
               device.setWarehouseName(rs.getString("warehouse_name"));
               device.setWarehouseCode(rs.getString("warehouse_code"));
               device.setTempHighThreshold(rs.getDouble("temp_high_threshold"));
               device.setTempLowThreshold(rs.getDouble("temp_low_threshold"));
               device.setRhHighThreshold(rs.getDouble("humi_high_threshold"));
               device.setRhLowThreshold(rs.getDouble("humi_low_threshold"));
               devices.add(device);
            }
            conn.close();
            stmt.close();
            rs.close();
            return devices;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<device> selectDevices(String deviceName,String deviceCode,String warehouseName,String warehouseCode){
        List<device> devices = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String sql = "select * from device where device_name like '%" + deviceName + "%' and device_code like '%" + deviceCode + "%' and warehouse_name like '%" + warehouseName + "%' and warehouse_code like '%" + warehouseCode + "%' ";
        try {
            conn = DBManager.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                device device = new device();
                device.setId(rs.getInt("id"));
                device.setDeviceName(rs.getString("device_name"));
                device.setDeviceCode(rs.getString("device_code"));
                device.setWarehouseName(rs.getString("warehouse_name"));
                device.setWarehouseCode(rs.getString("warehouse_code"));
                device.setTempHighThreshold(rs.getDouble("temp_high_threshold"));
                device.setTempLowThreshold(rs.getDouble("temp_low_threshold"));
                device.setRhHighThreshold(rs.getDouble("humi_high_threshold"));
                device.setRhLowThreshold(rs.getDouble("humi_low_threshold"));
                devices.add(device);
            }
            conn.close();
            stmt.close();
            rs.close();
            return devices;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateDevice(device device){
        Connection conn = null;
        PreparedStatement ps = null;
        int id = device.getId();
        String deviceName = device.getDeviceName();
        String deviceCode = device.getDeviceCode();
        String warehouseName = device.getWarehouseName();
        String warehouseCode = device.getWarehouseCode();
        double tempHighThreshold = device.getTempHighThreshold();
        double tempLowThreshold = device.getTempLowThreshold();
        double rhHighThreshold = device.getRhHighThreshold();
        double rhLowThreshold = device.getRhLowThreshold();
        String updateBy = device.getUpdateBy();
        Timestamp updatedAt = Timestamp.valueOf(device.getUpdatedAt());
        String sql = "update device set device_name = ?,device_code = ?,warehouse_name = ?,warehouse_code = ? , temp_high_threshold = ?, temp_low_threshold = ? " +
                ",humi_high_threshold = ?, humi_low_threshold = ?,update_by = ?,updated_at = ? where id = ?";
        try{
            conn = DBManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, deviceName);
            ps.setString(2, deviceCode);
            ps.setString(3, warehouseName);
            ps.setString(4, warehouseCode);
            ps.setDouble(5, tempHighThreshold);
            ps.setDouble(6, tempLowThreshold);
            ps.setDouble(7, rhHighThreshold);
            ps.setDouble(8, rhLowThreshold);
            ps.setString(9, updateBy);
            ps.setTimestamp(10, updatedAt);
            ps.setInt(11, id);
            ps.executeUpdate();

            sql = "update history set device_name = ?,device_code = ?,warehouse_name = ?,warehouse_code = ? where device_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, deviceName);
            ps.setString(2, deviceCode);
            ps.setString(3, warehouseName);
            ps.setString(4, warehouseCode);
            ps.setInt(5, id);
            ps.executeUpdate();
            ps.close();
            conn.close();
        }catch (SQLException e){
            e.printStackTrace();
        }
    }

    public boolean insertDevice(device device) {
        boolean flag = false;
        Connection conn = null;
        PreparedStatement ps = null;
        int id = device.getId();
        int warehouseId = device.getWarehouseId();
        String deviceName = device.getDeviceName();
        String deviceCode = device.getDeviceCode();
        String warehouseName = device.getWarehouseName();
        String warehouseCode = device.getWarehouseCode();
        double tempHighThreshold = device.getTempHighThreshold();
        double tempLowThreshold = device.getTempLowThreshold();
        double rhHighThreshold = device.getRhHighThreshold();
        double rhLowThreshold = device.getRhLowThreshold();
        String createBy = device.getUpdateBy();
        Timestamp createAt = Timestamp.valueOf(device.getUpdatedAt());
        Timestamp updatedAt = Timestamp.valueOf(device.getUpdatedAt());
        String sql = "insert into device (id, device_name, device_code, " +
                "warehouse_id,warehouse_name, warehouse_code, " +
                "temp_high_threshold, temp_low_threshold, " +
                "humi_high_threshold, humi_low_threshold," +
                "create_by, created_at,  updated_at) values (?,?,?,?,?,?,?,?,?,?,?,?,?)";
        try {
            conn = DBManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.setString(2, deviceName);
            ps.setString(3, deviceCode);
            ps.setInt(4, warehouseId);
            ps.setString(5, warehouseName);
            ps.setString(6, warehouseCode);
            ps.setDouble(7, tempHighThreshold);
            ps.setDouble(8, tempLowThreshold);
            ps.setDouble(9, rhHighThreshold);
            ps.setDouble(10, rhLowThreshold);
            ps.setString(11, createBy);
            ps.setTimestamp(12, createAt);
            ps.setTimestamp(13, updatedAt);
            flag = ps.executeUpdate() > 0;
            ps.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

}
