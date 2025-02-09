package vo;

import java.time.LocalDateTime;

public class device {
    private int id;
    private String deviceName;
    private String deviceCode;
    private String warehouseName;
    private String warehouseCode;
    private int warehouseId;
    private double tempHighThreshold;
    private double tempLowThreshold;
    private double rhHighThreshold;
    private double rhLowThreshold;
    private String crateBy;
    private String updateBy;
    private LocalDateTime cratedAt;
    private LocalDateTime updatedAt;

    public int getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(int warehouseId) {
        this.warehouseId = warehouseId;
    }

    public device(int id, String deviceName, String deviceCode, String warehouseName, String warehouseCode, int warehouseId, double tempHighThreshold, double tempLowThreshold, double rhHighThreshold, double rhLowThreshold, String crateBy, LocalDateTime cratedAt, LocalDateTime updatedAt) {
        this.id = id;
        this.deviceName = deviceName;
        this.deviceCode = deviceCode;
        this.warehouseName = warehouseName;
        this.warehouseCode = warehouseCode;
        this.warehouseId = warehouseId;
        this.tempHighThreshold = tempHighThreshold;
        this.tempLowThreshold = tempLowThreshold;
        this.rhHighThreshold = rhHighThreshold;
        this.rhLowThreshold = rhLowThreshold;
        this.crateBy = crateBy;
        this.cratedAt = cratedAt;
        this.updatedAt = updatedAt;
    }

    public device(int id, String deviceName, String deviceCode, String warehouseName, String warehouseCode, double tempHighThreshold, double tempLowThreshold, double rhHighThreshold, double rhLowThreshold, String crateBy, LocalDateTime cratedAt, LocalDateTime updatedAt) {
        this.id = id;
        this.deviceName = deviceName;
        this.deviceCode = deviceCode;
        this.warehouseName = warehouseName;
        this.warehouseCode = warehouseCode;
        this.tempHighThreshold = tempHighThreshold;
        this.tempLowThreshold = tempLowThreshold;
        this.rhHighThreshold = rhHighThreshold;
        this.rhLowThreshold = rhLowThreshold;
        this.crateBy = crateBy;
        this.cratedAt = cratedAt;
        this.updatedAt = updatedAt;
    }

    public device() {}
    public device(int id, String deviceName, String deviceCode, String warehouseName, String warehouseCode, double tempHighThreshold, double tempLowThreshold, double rhHighThreshold, double rhLowThreshold, String updateBy, LocalDateTime updatedAt) {
        this.id = id;
        this.deviceName = deviceName;
        this.deviceCode = deviceCode;
        this.warehouseName = warehouseName;
        this.warehouseCode = warehouseCode;
        this.tempHighThreshold = tempHighThreshold;
        this.tempLowThreshold = tempLowThreshold;
        this.rhHighThreshold = rhHighThreshold;
        this.rhLowThreshold = rhLowThreshold;
        this.updateBy = updateBy;
        this.updatedAt = updatedAt;
    }

    public String getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy;
    }

    public LocalDateTime getCratedAt() {
        return cratedAt;
    }

    public void setCratedAt(LocalDateTime cratedAt) {
        this.cratedAt = cratedAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getCrateBy() {
        return crateBy;
    }

    public void setCrateBy(String crateBy) {
        this.crateBy = crateBy;
    }

    public LocalDateTime getDeletedAt() {
        return deletedAt;
    }

    public void setDeletedAt(LocalDateTime deletedAt) {
        this.deletedAt = deletedAt;
    }

    private LocalDateTime deletedAt;
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public double getTempHighThreshold() {
        return tempHighThreshold;
    }

    public void setTempHighThreshold(double tempHighThreshold) {
        this.tempHighThreshold = tempHighThreshold;
    }

    public double getTempLowThreshold() {
        return tempLowThreshold;
    }

    public void setTempLowThreshold(double tempLowThreshold) {
        this.tempLowThreshold = tempLowThreshold;
    }

    public double getRhHighThreshold() {
        return rhHighThreshold;
    }

    public void setRhHighThreshold(double rhHighThreshold) {
        this.rhHighThreshold = rhHighThreshold;
    }

    public double getRhLowThreshold() {
        return rhLowThreshold;
    }

    public void setRhLowThreshold(double rhLowThreshold) {
        this.rhLowThreshold = rhLowThreshold;
    }
}
