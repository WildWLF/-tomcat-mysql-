<%@ page import="java.util.List" %>
<%@ page import="vo.device" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.DeviceDao" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>设备管理</title>
    <style>
       body, html {
    font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 0;
    height: 100%;
    /* 使用渐变背景 */
    background: linear-gradient(rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.4)), url('imgs/3.jpg') no-repeat center center fixed;
    background-size: cover;
    color: #333;
}
        .return-link {
    color: #1a0dab;
    text-decoration: none;
    font-weight: bold;
}

.container {
    max-width: 1200px;
    margin: 50px auto;
    background: #fff;
    padding: 30px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
    display: flex;
    flex-direction: column;
    min-height: calc(100vh - 100px);
    transition: box-shadow 0.3s;
}

.container:hover {
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

h1, h2 {
    text-align: center;
    color: #2c3e50;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    font-weight: bold;
}

.form-group input {
    width: 100%;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 6px;
    transition: border-color 0.3s;
}

.form-group input:focus {
    border-color: #4CAF50;
    outline: none;
}

.form-group input[type="submit"] {
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: background-color 0.3s, transform 0.1s;
    padding: 14px 20px;
}

.form-group input[type="submit"]:hover {
    background-color: #45a049;
    transform: scale(1.05);
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 30px;
}

th, td {
    padding: 16px;
    border: 1px solid #f2f2f2;
    text-align: left;
}

th {
    background-color: #ecf0f1;
    color: #2c3e50;
    font-weight: bold;
}

tr:nth-child(even) {
    background-color: #fcfcfc;
}

a {
    color: #2980b9;
    text-decoration: none;
    transition: color 0.3s, text-decoration 0.3s;
}

a:hover {
    color: #1e64a2;
    text-decoration: underline;
}

@media (max-width: 768px) {
    .form-group input {
        width: calc(100% - 24px); /* Adjust padding */
    }
    h1, h2 {
        font-size: 1.8rem;
    }
    .form-group label {
        font-size: 1.2rem;
    }
    th, td {
        padding: 12px;
    }
}
       .add-button {
           background-color: #28a745;
           color: white;
           border: none;
           padding: 10px 20px;
           border-radius: 6px;
           cursor: pointer;
           font-size: 16px;
           margin-bottom: 20px;
       }

       .add-button:hover {
           background-color: #218838;
       }

       .modal-overlay {
           display: none;
           position: fixed;
           top: 0;
           left: 0;
           width: 100%;
           height: 100%;
           background: rgba(0, 0, 0, 0.5);
           z-index: 999;
       }

       .modal {
           display: none;
           position: fixed;
           top: 50%;
           left: 50%;
           transform: translate(-50%, -50%);
           background-color: white;
           padding: 20px;
           box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
           border-radius: 8px;
           z-index: 1000;
           width: 90%;
           max-width: 500px;
       }

       .modal-header {
           font-size: 18px;
           margin-bottom: 10px;
       }

       .modal-footer {
           margin-top: 20px;
           text-align: right;
       }
       @keyframes fadeIn {
           from {
               opacity: 0;
               transform: translate(-50%, -60%);
           }
           to {
               opacity: 1;
               transform: translate(-50%, -50%);
           }
       }
       .edit-button {
           background-color: #007bff;
           color: white;
           border: none;
           padding: 5px 10px;
           border-radius: 4px;
           cursor: pointer;
       }

       .edit-button:hover {
           background-color: #0056b3;
       }

       .return-button {
           position: absolute;
           top: 10px;
           right: 10px;
           background-color: #28a745; /* 绿色背景 */
           color: white; /* 白色文字 */
           border: none;
           padding: 8px 15px;
           font-size: 14px;
           border-radius: 5px;
           cursor: pointer;
       }

       .return-button:hover {
           background-color: #218838; /* 更深的绿色 */
       }
    </style>
</head>
<body>
<button class="return-button" onclick="window.location.href='index.jsp'">返回首页</button>

<%
    int maxId = 0;
    List<device> devices = (ArrayList<device>) request.getAttribute("devices");
    if (devices == null) {
        DeviceDao deviceDao = new DeviceDao();
        devices = deviceDao.getAllDevices();
    }
    pageContext.setAttribute("devices", devices);
%>
    <div class="container">
        <h1>设备管理</h1>

        <!-- 搜索设备 -->
        <form action="deviceServlet" method="get">
            <div class="form-group">
                <label for="deviceName">设备名称:</label>
                <input type="text" id="deviceName" name="deviceName">
            </div>
            <div class="form-group">
                <label for="deviceCode">设备编码:</label>
                <input type="text" id="deviceCode" name="deviceCode">
            </div>
            <div class="form-group">
                <label for="warehouseName">仓库名称:</label>
                <input type="text" id="warehouseName" name="warehouseName">
            </div>
            <div class="form-group">
                <label for="warehouseCode">仓库编码:</label>
                <input type="text" id="warehouseCode" name="warehouseCode">
            </div>
            <div class="form-group">
                <input type="submit" value="搜索">
            </div>
        </form>

        <!-- 设备列表 -->
        <h2>设备列表</h2>
        <button class="add-button" onclick="openAddModal()">添加设备</button>
        <table border="1">
            <tr>
                <th>设备名称</th>
                <th>设备编码</th>
                <th>仓库名称</th>
                <th>仓库编码</th>
                <th>最高温度</th>
                <th>最低温度</th>
                <th>最高湿度</th>
                <th>最低湿度</th>
                <th>操作</th>
            </tr>
            <%
                for(device dev:devices){
                    if(maxId < dev.getId()) maxId = dev.getId();
            %>
            <tr>
                <td><%=dev.getDeviceName()%></td>
                <td><%=dev.getDeviceCode()%></td>
                <td><%=dev.getWarehouseName()%></td>
                <td><%=dev.getWarehouseCode()%></td>
                <td><%=dev.getTempHighThreshold()%></td>
                <td><%=dev.getTempLowThreshold()%></td>
                <td><%=dev.getRhHighThreshold()%></td>
                <td><%=dev.getRhLowThreshold()%></td>
                <td>
                    <button class="edit_button" onclick="openModal('<%=dev.getId()%>','<%=dev.getDeviceName()%>','<%=dev.getDeviceCode()%>',
                            '<%=dev.getWarehouseName()%>','<%=dev.getWarehouseCode()%>','<%=dev.getTempHighThreshold()%>',
                            '<%=dev.getTempLowThreshold()%>','<%=dev.getRhHighThreshold()%>','<%=dev.getRhLowThreshold()%>')">
                        编辑
                    </button>
                </td>
            </tr>

            <%
                }
            %>
        </table>
    </div>


</body>

<div class="modal-overlay" id="add-modal-overlay" style="display: none;"></div>
<div class="modal" id="add-modal" style="display: none; animation: fadeIn 0.3s;">
    <div class="modal-header" style="font-weight: bold; text-align: center; font-size: 20px; margin-bottom: 20px;">
        添加新设备
    </div>
    <form action="insertDevice" method="post" id="add-form">
        <input type="hidden" name="MaxId" value="<%=maxId%>">
        <input type="hidden" name="warehouseId" id="WarehouseId">
        <div class="form-group">
            <label for="add-device-name" style="font-weight: bold; color: #333;">设备名称:</label>
            <input type="text" id="add-device-name" name="DeviceName" required
                   style="padding: 8px; font-size: 16px; border: 1px solid #ddd; border-radius: 6px; width: 100%;">
        </div>
        <div class="form-group">
            <label for="add-device-code" style="font-weight: bold; color: #333;">设备编码:</label>
            <input type="text" id="add-device-code" name="DeviceCode" required
                   style="padding: 8px; font-size: 16px; border: 1px solid #ddd; border-radius: 6px; width: 100%;">
        </div>
        <div class="form-group">
            <label for="add-warehouse-name" style="font-weight: bold; color: #333;">仓库名称:</label>
            <input type="text" id="add-warehouse-name" name="WarehouseName" required
                   style="padding: 8px; font-size: 16px; border: 1px solid #ddd; border-radius: 6px; width: 100%;">
        </div>
        <div class="form-group">
            <label for="add-warehouse-code" style="font-weight: bold; color: #333;">仓库编码:</label>
            <input type="text" id="add-warehouse-code" name="WarehouseCode" required
                   style="padding: 8px; font-size: 16px; border: 1px solid #ddd; border-radius: 6px; width: 100%;">
        </div>
        <div class="form-group">
            <label for="add-temp-high-threshold" style="font-weight: bold; color: #333;">温度上阈值:</label>
            <input type="text" id="add-temp-high-threshold" name="TempHighThreshold" required
                   style="padding: 8px; font-size: 16px; border: 1px solid #ddd; border-radius: 6px; width: 100%;">
        </div>
        <div class="form-group">
            <label for="add-temp-low-threshold" style="font-weight: bold; color: #333;">温度下阈值:</label>
            <input type="text" id="add-temp-low-threshold" name="TempLowThreshold" required
                   style="padding: 8px; font-size: 16px; border: 1px solid #ddd; border-radius: 6px; width: 100%;">
        </div>
        <div class="form-group">
            <label for="add-rh-high-threshold" style="font-weight: bold; color: #333;">湿度上阈值:</label>
            <input type="text" id="add-rh-high-threshold" name="RhHighThreshold" required
                   style="padding: 8px; font-size: 16px; border: 1px solid #ddd; border-radius: 6px; width: 100%;">
        </div>
        <div class="form-group">
            <label for="add-rh-low-threshold" style="font-weight: bold; color: #333;">湿度下阈值:</label>
            <input type="text" id="add-rh-low-threshold" name="RhLowThreshold" required
                   style="padding: 8px; font-size: 16px; border: 1px solid #ddd; border-radius: 6px; width: 100%;">
        </div>
        <div class="modal-footer" style="margin-top: 20px; text-align: center;">
            <button type="button" class="close-button" onclick="closeAddModal()"
                    style="background-color: #ff4d4d; color: white; border: none; padding: 10px 20px; border-radius: 8px; cursor: pointer; font-size: 16px;">
                取消
            </button>
            <input type="submit" value="添加"
                   style="background-color: #4CAF50; color: white; border: none; padding: 10px 20px; border-radius: 8px; cursor: pointer; font-size: 16px; margin-left: 10px;">
        </div>
    </form>
</div>

<div class="modal-overlay" id="modal-overlay"></div>
<div class="modal" id="edit-modal" style="animation: fadeIn 0.3s;">
    <div class="modal-header" style="font-weight: bold; text-align: center; font-size: 20px; margin-bottom: 20px;">
        编辑设备信息
    </div>
    <form action="deviceServlet" method="post" id="edit-form">
        <input type="hidden" name="deviceId" id="edit-device-id">
        <div class="form-group">
            <label for="edit-device-name" style="font-weight: bold; color: #333;">设备名称:</label>
            <input type="text" id="edit-device-name" name="deviceName" required
                   style="padding: 8px; font-size: 16px; border: 1px solid #ddd; border-radius: 6px; width: 100%;">
        </div>
        <div class="form-group">
            <label for="edit-device-code" style="font-weight: bold; color: #333;">设备编码:</label>
            <input type="text" id="edit-device-code" name="deviceCode" required
                   style="padding: 8px; font-size: 16px; border: 1px solid #ddd; border-radius: 6px; width: 100%;">
        </div>
        <div class="form-group">
            <label for="edit-warehouse-name" style="font-weight: bold; color: #333;">仓库名称:</label>
            <input type="text" id="edit-warehouse-name" name="warehouseName" required
                   style="padding: 8px; font-size: 16px; border: 1px solid #ddd; border-radius: 6px; width: 100%;">
        </div>
        <div class="form-group">
            <label for="edit-warehouse-code" style="font-weight: bold; color: #333;">仓库编码:</label>
            <input type="text" id="edit-warehouse-code" name="warehouseCode" required
                   style="padding: 8px; font-size: 16px; border: 1px solid #ddd; border-radius: 6px; width: 100%;">
        </div>
        <div class="form-group">
            <label for="edit-temp-high-threshold" style="font-weight: bold; color: #333;">温度上阈值:</label>
            <input type="text" id="edit-temp-high-threshold" name="TempHighThreshold" required
                   style="padding: 8px; font-size: 16px; border: 1px solid #ddd; border-radius: 6px; width: 100%;">
        </div>
        <div class="form-group">
            <label for="edit-temp-low-threshold" style="font-weight: bold; color: #333;">温度下阈值:</label>
            <input type="text" id="edit-temp-low-threshold" name="TempLowThreshold" required
                   style="padding: 8px; font-size: 16px; border: 1px solid #ddd; border-radius: 6px; width: 100%;">
        </div>
        <div class="form-group">
            <label for="edit-rh-high-threshold" style="font-weight: bold; color: #333;">湿度上阈值:</label>
            <input type="text" id="edit-rh-high-threshold" name="RhHighThreshold" required
                   style="padding: 8px; font-size: 16px; border: 1px solid #ddd; border-radius: 6px; width: 100%;">
        </div>
        <div class="form-group">
            <label for="edit-rh-low-threshold" style="font-weight: bold; color: #333;">湿度下阈值:</label>
            <input type="text" id="edit-rh-low-threshold" name="RhLowThreshold" required
                   style="padding: 8px; font-size: 16px; border: 1px solid #ddd; border-radius: 6px; width: 100%;">
        </div>
            <div class="modal-footer" style="margin-top: 20px; text-align: center;">
                <button type="button" class="close-button" onclick="closeModal()"
                        style="background-color: #ff4d4d; color: white; border: none; padding: 10px 20px; border-radius: 8px; cursor: pointer; font-size: 16px;">
                    取消
                </button>
                <input type="submit" value="确认"
                       style="background-color: #4CAF50; color: white; border: none; padding: 10px 20px; border-radius: 8px; cursor: pointer; font-size: 16px; margin-left: 10px;">
            </div>
    </form>
</div>



<script>

    function openModal(id,deviceName,deviceCode,warehouseName,warehouseCode,tempHighThreshold,tempLowThreshold,rhHighThreshold,rhLowThreshold){
        document.getElementById("edit-device-id").value = id;
        document.getElementById("edit-device-name").value = deviceName;
        document.getElementById("edit-device-code").value = deviceCode;
        document.getElementById("edit-warehouse-name").value = warehouseName;
        document.getElementById("edit-warehouse-code").value = warehouseCode;
        document.getElementById("edit-temp-high-threshold").value = tempHighThreshold;
        document.getElementById("edit-temp-low-threshold").value = tempLowThreshold;
        document.getElementById("edit-rh-high-threshold").value = rhHighThreshold;
        document.getElementById("edit-rh-low-threshold").value = rhLowThreshold;
        document.getElementById('modal-overlay').style.display = 'block';
        document.getElementById('edit-modal').style.display = 'block';
    }
    function closeModal(){
        document.getElementById('modal-overlay').style.display = 'none';
        document.getElementById('edit-modal').style.display = 'none';
    }
    function validateAddForm(e) {
        const tempHigh = parseFloat(document.getElementById('add-temp-high-threshold').value);
        const tempLow = parseFloat(document.getElementById('add-temp-low-threshold').value);
        const rhHigh = parseFloat(document.getElementById('add-rh-high-threshold').value);
        const rhLow = parseFloat(document.getElementById('add-rh-low-threshold').value);

        if (tempLow < -20 || tempLow > 40 || tempHigh < -20 || tempHigh > 40) {
            alert('温度阈值必须在 -20 到 40 之间！');
            return false;
        }

        if (rhLow < 0 || rhLow > 100 || rhHigh < 0 || rhHigh > 100) {
            alert('湿度阈值必须在 0 到 100 之间！');
            return false;
        }

        if (tempLow >= tempHigh) {
            alert('温度下阈值不得高于或等于温度上阈值！');
            return false;
        }

        if (rhLow >= rhHigh) {
            alert('湿度下阈值不得高于或等于湿度上阈值！');
            return false;
        }

        const warehouseName = document.getElementById('add-warehouse-name').value.trim();
        const warehouseCode = document.getElementById('add-warehouse-code').value.trim();

        if (!warehouseName || !warehouseCode) {
            alert('仓库名称和仓库编码不能为空！');
            return false;
        }

        const xhr = new XMLHttpRequest();
        xhr.open('GET', 'insertDevice?WarehouseName=' + warehouseName + '&WarehouseCode=' + warehouseCode, true);
        xhr.onload = function () {
            if (xhr.status === 200) {
                const response = xhr.responseText.trim();
                if (response.startsWith("SUCCESS")) {
                    document.getElementById('WarehouseId').value = response.split(",")[1]; // 提取仓库ID
                    document.getElementById('add-form').submit(); // 提交表单
                } else if (response === "FAILURE") {
                    alert('仓库不存在，请检查仓库名称和编码！');
                } else {
                    alert('服务器发生错误，请稍后重试！');
                }
            } else {
                alert('无法连接到服务器，请稍后重试！');
            }
        };
        xhr.onerror = function () {
            alert('无法连接到服务器，请检查网络！');
        };
        xhr.send();

        // 阻止默认提交，等待异步结果
        return false;
    }

    document.getElementById('add-form').addEventListener('submit', function (e) {
        if (!validateAddForm()) {
            e.preventDefault(); // 阻止表单提交
        }
    });
    function openAddModal() {
        document.getElementById('add-modal-overlay').style.display = 'block';
        document.getElementById('add-modal').style.display = 'block';
    }

    function closeAddModal() {
        document.getElementById('add-modal-overlay').style.display = 'none';
        document.getElementById('add-modal').style.display = 'none';
    }

    function validateEditForm(e) {
        const tempHigh = parseFloat(document.getElementById('edit-temp-high-threshold').value);
        const tempLow = parseFloat(document.getElementById('edit-temp-low-threshold').value);
        const rhHigh = parseFloat(document.getElementById('edit-rh-high-threshold').value);
        const rhLow = parseFloat(document.getElementById('edit-rh-low-threshold').value);

        // 温度和湿度阈值范围校验
        if (tempLow < -20 || tempLow > 40 || tempHigh < -20 || tempHigh > 40) {
            alert('温度阈值必须在 -20 到 40 之间！');
            return false;
        }

        if (rhLow < 0 || rhLow > 100 || rhHigh < 0 || rhHigh > 100) {
            alert('湿度阈值必须在 0 到 100 之间！');
            return false;
        }

        if (tempLow >= tempHigh) {
            alert('温度下阈值不得高于或等于温度上阈值！');
            return false;
        }

        if (rhLow >= rhHigh) {
            alert('湿度下阈值不得高于或等于湿度上阈值！');
            return false;
        }

        const warehouseName = document.getElementById('edit-warehouse-name').value.trim();
        const warehouseCode = document.getElementById('edit-warehouse-code').value.trim();

        if (!warehouseName || !warehouseCode) {
            alert('仓库名称和仓库编码不能为空！');
            return false;
        }

        // 验证仓库是否存在
        const xhr = new XMLHttpRequest();
        xhr.open('GET', 'insertDevice?WarehouseName=' + warehouseName + '&WarehouseCode=' + warehouseCode, true);
        xhr.onload = function () {
            if (xhr.status === 200) {
                const response = xhr.responseText.trim();
                if (response.startsWith("SUCCESS")) {
                    // 提取仓库ID并设置到隐藏字段（如果需要）
                    document.getElementById('edit-form').submit(); // 提交表单
                } else if (response === "FAILURE") {
                    alert('仓库不存在，请检查仓库名称和编码！');
                } else {
                    alert('服务器发生错误，请稍后重试！');
                }
            } else {
                alert('无法连接到服务器，请稍后重试！');
            }
        };
        xhr.onerror = function () {
            alert('无法连接到服务器，请检查网络！');
        };
        xhr.send();

        // 阻止默认提交，等待异步结果
        return false;
    }

    // 绑定编辑表单提交事件
    document.getElementById('edit-form').addEventListener('submit', function (e) {
        if (!validateEditForm()) {
            e.preventDefault(); // 阻止表单提交
        }
    });
</script>
</html>