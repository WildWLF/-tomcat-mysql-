<%@ page import="vo.warehouse" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.WarehouseDao" %>
<%@ page import="static sun.swing.MenuItemLayoutHelper.max" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>仓库管理</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            background-image: url('imgs/1.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
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
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h1, h2 {
            text-align: center;
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .form-group input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .form-group input[type="submit"]:hover {
            background-color: #45a049;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        a {
            color: #1a0dab;
            text-decoration: none;
            transition: text-decoration 0.3s;
        }

        a:hover {
            text-decoration: underline;
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

        .close-button {
            background-color: #ccc;
            color: black;
            border: none;
            padding: 5px 10px;
            border-radius: 4px;
            cursor: pointer;
        }

        .close-button:hover {
            background-color: #aaa;
        }
        .modal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: linear-gradient(135deg, #ffffff, #f9f9f9);
            padding: 30px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            border-radius: 12px;
            z-index: 1000;
            width: 90%;
            max-width: 500px;
        }

        .modal-header {
            color: #333;
            font-size: 20px;
            font-weight: bold;
        }

        .modal-footer button, .modal-footer input[type="submit"] {
            transition: all 0.3s ease-in-out;
        }

        .modal-footer button:hover {
            background-color: #d43636;
        }

        .modal-footer input[type="submit"]:hover {
            background-color: #3e8e41;
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

        /* 动画效果 */
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
    List<warehouse> warehouses = (ArrayList<warehouse>) request.getAttribute("warehouses");
    if (warehouses == null) {
        WarehouseDao warehouseDao = new WarehouseDao();
        warehouses = warehouseDao.getAllWarehouse();
    }
    pageContext.setAttribute("warehouses", warehouses);
%>
<div class="container">
    <h1>仓库管理</h1>
    <form action="warehouseServlet" method="get" class="form-container">
        <div class="form-group">
            <label for="warehouseName">仓库名称:</label>
            <input type="text" id="warehouseName" name="WarehouseName">
        </div>
        <div class="form-group">
            <label for="warehouseCode">仓库编码:</label>
            <input type="text" id="warehouseCode" name="WarehouseCode">
        </div>
        <div class="form-group">
            <input type="submit" value="搜索">
        </div>
    </form>

    <h2>仓库列表</h2>
    <button class="add-button" onclick="openAddModal()">添加仓库</button> <!-- Button to open the Add Warehouse modal -->

    <table>
        <thead>
        <tr>
            <th>仓库编码</th>
            <th>仓库名称</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (warehouse warehouse : warehouses) {
                if(maxId < warehouse.getId()) maxId = warehouse.getId();
        %>
        <tr>
            <td><%= warehouse.getWarehouseCode() %></td>
            <td><%= warehouse.getWarehouseName() %></td>
            <td>
                <button class="edit-button" onclick="openModal('<%= warehouse.getId() %>', '<%= warehouse.getWarehouseCode() %>', '<%= warehouse.getWarehouseName() %>')">编辑</button>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>


<!-- 编辑仓库弹窗 -->
<div class="modal-overlay" id="modal-overlay"></div>
<div class="modal" id="edit-modal" style="animation: fadeIn 0.3s;">
    <div class="modal-header" style="font-weight: bold; text-align: center; font-size: 20px; margin-bottom: 20px;">
        编辑仓库信息
    </div>
    <form action="warehouseServlet" method="post" id="edit-form" onsubmit="return validateEditForm()">
        <input type="hidden" id="edit-warehouse-id" name="WarehouseId">
        <div class="form-group">
            <label for="edit-warehouse-code" style="font-weight: bold; color: #333;">仓库编码:</label>
            <input type="text" id="edit-warehouse-code" name="WarehouseCode" required
                   style="padding: 10px; font-size: 16px; border: 1px solid #ddd; border-radius: 6px; width: 100%;">
        </div>
        <div class="form-group">
            <label for="edit-warehouse-name" style="font-weight: bold; color: #333;">仓库名称:</label>
            <input type="text" id="edit-warehouse-name" name="WarehouseName" required
                   style="padding: 10px; font-size: 16px; border: 1px solid #ddd; border-radius: 6px; width: 100%;">
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

<!-- 添加仓库弹窗 -->
<div class="modal-overlay" id="add-modal-overlay"></div>
<div class="modal" id="add-modal" style="animation: fadeIn 0.3s;">
    <div class="modal-header" style="font-weight: bold; text-align: center; font-size: 20px; margin-bottom: 20px;">
        添加新仓库
    </div>
    <form action="insertWarehouse" method="post" id="add-form" onsubmit="return validateAddForm()">
        <input type="hidden" name="MaxId" value="<%=maxId%>">
        <div class="form-group">
            <label for="add-warehouse-code" style="font-weight: bold; color: #333;">仓库编码:</label>
            <input type="text" id="add-warehouse-code" name="WarehouseCode" required
                   style="padding: 10px; font-size: 16px; border: 1px solid #ddd; border-radius: 6px; width: 100%;">
        </div>
        <div class="form-group">
            <label for="add-warehouse-name" style="font-weight: bold; color: #333;">仓库名称:</label>
            <input type="text" id="add-warehouse-name" name="WarehouseName" required
                   style="padding: 10px; font-size: 16px; border: 1px solid #ddd; border-radius: 6px; width: 100%;">
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

<script>
    function openModal(id, warehouseCode, warehouseName) {
        document.getElementById('edit-warehouse-id').value = id;
        document.getElementById('edit-warehouse-code').value = warehouseCode;
        document.getElementById('edit-warehouse-name').value = warehouseName;
        document.getElementById('modal-overlay').style.display = 'block';
        document.getElementById('edit-modal').style.display = 'block';
    }

    function closeModal() {
        document.getElementById('modal-overlay').style.display = 'none';
        document.getElementById('edit-modal').style.display = 'none';
    }

    function openAddModal() {
        document.getElementById('add-modal-overlay').style.display = 'block';
        document.getElementById('add-modal').style.display = 'block';
    }

    function closeAddModal() {
        document.getElementById('add-modal-overlay').style.display = 'none';
        document.getElementById('add-modal').style.display = 'none';
    }

    // 确保不为空
    function validateEditForm() {
        var warehouseCode = document.getElementById('edit-warehouse-code').value;
        var warehouseName = document.getElementById('edit-warehouse-name').value;

        if (warehouseCode.trim() === "" || warehouseName.trim() === "") {
            alert("仓库编码和仓库名称不能为空！");
            return false;
        }
        return true;
    }

    // 确保不为空
    function validateAddForm() {
        var warehouseCode = document.getElementById('add-warehouse-code').value;
        var warehouseName = document.getElementById('add-warehouse-name').value;

        if (warehouseCode.trim() === "" || warehouseName.trim() === "") {
            alert("仓库编码和仓库名称不能为空！");
            return false;
        }
        return true;
    }
</script>

</body>
</html>
