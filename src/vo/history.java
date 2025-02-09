package vo;

import java.sql.Timestamp;
import java.time.LocalDateTime;

public class history {
    private String warehouseName;
    private String warehouseCode;
    private String deviceName;
    private String deviceCode;
    private double temp;
    private double humidity;
    private LocalDateTime updatedAt;

    public String getWarehouseName() {
        return warehouseName;
    }

    public void setWarehouseName(String warehouseName) {
        this.warehouseName = warehouseName;
    }

    public String getWarehouseCode() {
        return warehouseCode;
    }

    public void setWarehouseCode(String warehouseCode) {
        this.warehouseCode = warehouseCode;
    }

    public String getDeviceName() {
        return deviceName;
    }

    public void setDeviceName(String deviceName) {
        this.deviceName = deviceName;
    }

    public String getDeviceCode() {
        return deviceCode;
    }

    public void setDeviceCode(String deviceCode) {
        this.deviceCode = deviceCode;
    }

    public double getTemp() {
        return temp;
    }

    public void setTemp(double temp) {
        this.temp = temp;
    }

    public double getHumidity() {
        return humidity;
    }

    public void setHumidity(double humidity) {
        this.humidity = humidity;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public history() {
    }

    public history(String warehouseName, String warehouseCode, String deviceName, String deviceCode) {
        this.warehouseName = warehouseName;
        this.warehouseCode = warehouseCode;
        this.deviceName = deviceName;
        this.deviceCode = deviceCode;
    }
}
