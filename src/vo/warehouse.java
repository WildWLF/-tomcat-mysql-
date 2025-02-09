package vo;

import java.time.LocalDateTime;

public class warehouse {
    private int id;
    private String warehouseName;
    private String warehouseCode;
    private String createBy;
    private String updateBy;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private LocalDateTime deleteAt;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getWarehouseName() {
        return warehouseName;
    }

    public void setWarehouseName(String warehouseName) {
        this.warehouseName = warehouseName;
    }

    public warehouse() {
    }

    public String getWarehouseCode() {
        return warehouseCode;
    }

    public void setWarehouseCode(String warehouseCode) {
        this.warehouseCode = warehouseCode;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public LocalDateTime getDeleteAt() {
        return deleteAt;
    }

    public void setDeleteAt(LocalDateTime deleteAt) {
        this.deleteAt = deleteAt;
    }

    public warehouse(int id, String warehouseName, String warehouseCode, String updateBy, LocalDateTime updatedAt) {
        this.id = id;
        this.warehouseName = warehouseName;
        this.warehouseCode = warehouseCode;
        this.updateBy = updateBy;
        this.updatedAt = updatedAt;
    }

    public warehouse(int id, String warehouseName, String warehouseCode, String createBy, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = id;
        this.warehouseName = warehouseName;
        this.warehouseCode = warehouseCode;
        this.createBy = createBy;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
}
