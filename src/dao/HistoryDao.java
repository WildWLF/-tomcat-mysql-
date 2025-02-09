package dao;

import util.DBManager;
import vo.history;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HistoryDao {
        public List<Map<String, Object>> selectHistory(history history,String startTime,String endTime) {
            String deviceName = history.getDeviceName();
            String deviceCode = history.getDeviceCode();
            String warehouseName = history.getWarehouseName();
            String warehouseCode = history.getWarehouseCode();
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
            String sql = "select * from history where device_name like ? and device_code like ? and warehouse_name like ? and warehouse_code like ?" +
                    "and updated_at between ? and ?";
            try{
                conn = DBManager.getConnection();
                ps = conn.prepareStatement(sql);
                ps.setString(1, "%" + deviceName + "%");
                ps.setString(2, "%" + deviceCode + "%");
                ps.setString(3, "%" + warehouseName + "%" );
                ps.setString(4, "%" + warehouseCode + "%" );
                ps.setString(5, startTime);
                ps.setString(6, endTime);
                rs = ps.executeQuery();
                while(rs.next()){
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("deviceName", rs.getString("device_name"));
                    map.put("deviceCode", rs.getString("device_code"));
                    map.put("warehouseName", rs.getString("warehouse_name"));
                    map.put("warehouseCode", rs.getString("warehouse_code"));
                    map.put("temp",rs.getString("temp_data"));
                    map.put("humidity",rs.getString("humi_data"));
                    map.put("time", rs.getString("updated_at"));
                    list.add(map);
                }
                conn.close();
                ps.close();
                rs.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            return list;
        }

}
