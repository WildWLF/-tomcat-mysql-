<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>History</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            background-image: url('imgs/1.jpg');
            background-size: cover;
            background-position: center;
            color: #fff;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            margin-top: 50px;
            font-size: 36px;
            font-weight: bold;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.5);
        }

        h2 {
            color: #0095f6;
        }

        form {
            background-color: rgba(255, 255, 255, 0.7);
            padding: 30px;
            margin: 50px auto;
            width: 60%;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
        }

        label {
            font-size: 18px;
            margin-bottom: 5px;
            display: block;
            color: #333;
        }

        input[type="datetime-local"],
        input[type="text"],
        input[type="submit"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: rgba(255, 255, 255, 0.9);
            color: #333;
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        button {
            width: 48%;
            padding: 12px;
            margin: 10px 1%;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: rgba(255, 255, 255, 0.9);
            color: #333;
            cursor: pointer;
        }

        button:hover {
            background-color: #4CAF50;
            color: white;
        }

        table {
            width: 80%;
            margin: 30px auto;
            border-collapse: collapse;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 12px;
            text-align: center;
            font-size: 14px;
            color: #000;
        }

        th {
            background-color: #4CAF50;
            color: white;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .pagination {
            text-align: center;
            margin-top: 20px;
            font-size: 16px;
        }

        .pagination a {
            color: #4CAF50;
            padding: 10px 15px;
            margin: 0 5px;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            background-color: rgba(255, 255, 255, 0.6);
        }

        .pagination a:hover {
            background-color: #4CAF50;
            color: white;
        }

        .pagination .current {
            background-color: #4CAF50;
            color: white;
        }

        .pagination span {
            color: #000;
        }

        .container {
            text-align: center;
        }

        .chart-container {
            width: 80%;
            margin: 50px auto;
        }

        #chartContainer {
            display: none;
        }

        #tableContainer {
            display: block;
        }
        .return-button {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: #28a745; /* 绿色背景 */
            color: white; /* 白色文字 */
            border: none;
            padding: 5px 12px; /* 调整 padding 使按钮更窄 */
            font-size: 12px; /* 减小字体大小 */
            border-radius: 5px;
            cursor: pointer;
            width: auto; /* 使宽度自动适应内容 */
        }

        .return-button:hover {
            background-color: #218838; /* 更深的绿色 */
        }

    </style>
</head>
<body>
<button class="return-button" onclick="window.location.href='index.jsp'">返回首页</button>
<div class="container">
    <h1>搜索</h1>

    <form action="historyServlet" method="get">
        <label for="startTime">起始时间：</label>
        <input type="datetime-local" id="startTime" name="startTime"
               value="${param.startTime != null ? param.startTime : '2024-01-01T00:00'}">
        <br><br>

        <label for="endTime">终止时间</label>
        <input type="datetime-local" id="endTime" name="endTime"
               value="${param.endTime != null ? param.endTime : '2024-12-31T23:59'}">
        <br><br>

        <label for="deviceName">设备名称:</label>
        <input type="text" id="deviceName" name="deviceName"
               value="${param.deviceName != null ? param.deviceName : ''}">
        <br><br>

        <label for="deviceCode">设备编号：</label>
        <input type="text" id="deviceCode" name="deviceCode"
               value="${param.deviceCode != null ? param.deviceCode : ''}">
        <br><br>

        <label for="warehouseName">仓库名称：</label>
        <input type="text" id="warehouseName" name="warehouseName"
               value="${param.warehouseName != null ? param.warehouseName : ''}">
        <br><br>

        <label for="warehouseCode">仓库编号：</label>
        <input type="text" id="warehouseCode" name="warehouseCode"
               value="${param.warehouseCode != null ? param.warehouseCode : ''}">
        <br><br>

        <input type="submit" value="Search">
    </form>

    <div>
        <button onclick="toggleView('table')">查看表格</button>
        <button onclick="toggleView('chart')">查看图表</button>
    </div>

    <div id="chartContainer">
        <h2>数据图表</h2>
        <div class="chart-container">
            <canvas id="lineChart"></canvas>
        </div>
    </div>

    <div id="tableContainer">
        <c:if test="${not empty dataList}">
            <h2>搜索结果</h2>
            <table>
                <thead>
                <tr>
                    <th>设备名</th>
                    <th>设备编号</th>
                    <th>仓库名</th>
                    <th>仓库编号</th>
                    <th>温度</th>
                    <th>湿度</th>
                    <th>时间</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="data" items="${dataList}">
                    <tr>
                        <td>${data.deviceName}</td>
                        <td>${data.deviceCode}</td>
                        <td>${data.warehouseName}</td>
                        <td>${data.warehouseCode}</td>
                        <td>${data.temp}</td>
                        <td>${data.humidity}</td>
                        <td>${data.time}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <div class="pagination">
                <c:if test="${pagination.hasPreviousPage()}">
                    <a href="?startTime=${param.startTime}&endTime=${param.endTime}&deviceName=${param.deviceName}&deviceCode=${param.deviceCode}&warehouseName=${param.warehouseName}&warehouseCode=${param.warehouseCode}&page=${pagination.currentPage - 1}&pageSize=${pagination.pageSize}">上一页</a>
                </c:if>

                <span>Page ${pagination.currentPage} of ${pagination.totalPages}</span>

                <c:if test="${pagination.hasNextPage()}">
                    <a href="?startTime=${param.startTime}&endTime=${param.endTime}&deviceName=${param.deviceName}&deviceCode=${param.deviceCode}&warehouseName=${param.warehouseName}&warehouseCode=${param.warehouseCode}&page=${pagination.currentPage + 1}&pageSize=${pagination.pageSize}">下一页</a>
                </c:if>
            </div>
        </c:if>
    </div>

</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const labels = [];
        const temperatureData = [];
        const humidityData = [];

        <c:forEach var="data" items="${allData}">
        labels.push('${data.time}');
        temperatureData.push(${data.temp});
        humidityData.push(${data.humidity});
        </c:forEach>

        const ctx = document.getElementById('lineChart').getContext('2d');
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [
                    {
                        label: 'Temperature',
                        data: temperatureData,
                        borderColor: 'rgba(255, 99, 132, 1)',
                        backgroundColor: 'rgba(255, 99, 132, 0.2)',
                        fill: true,
                        tension: 0.1
                    },
                    {
                        label: 'Humidity',
                        data: humidityData,
                        borderColor: 'rgba(54, 162, 235, 1)',
                        backgroundColor: 'rgba(54, 162, 235, 0.2)',
                        fill: true,
                        tension: 0.1
                    }
                ]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                        labels: {
                            color: '#000000'
                        }
                    },
                    tooltip: {
                        callbacks: {
                            title: function (tooltipItem) {
                                return tooltipItem[0].label;
                            },
                            label: function (tooltipItem) {
                                return tooltipItem.datasetIndex === 0 ?
                                    'Temperature: ' + tooltipItem.raw + '°C' :
                                    'Humidity: ' + tooltipItem.raw + '%';
                            }
                        }
                    }
                },
                scales: {
                    x: {
                        type: 'category',
                        labels: labels,
                        title: {
                            display: true,
                            text: 'Time',
                            color: '#000000'
                        },
                        ticks: {
                            color: '#000000',
                            maxRotation: 45,
                            autoSkip: true,
                        }
                    },
                    y: {
                        title: {
                            display: true,
                            text: 'Values',
                            color: '#000000'
                        },
                        ticks: {
                            color: '#000000',
                            beginAtZero: false,
                            callback: function(value) {
                                return value.toFixed(2);
                            }
                        }
                    }
                },
                layout: {
                    padding: {
                        top: 20,
                        left: 30,
                        right: 30,
                        bottom: 20
                    }
                }
            },
            plugins: [
                {
                    id: 'whiteBackground',
                    beforeDraw: function (chart) {
                        const ctx = chart.ctx;
                        const { top, left, width, height } = chart.chartArea;
                        ctx.save();
                        ctx.fillStyle = 'rgba(255, 255, 255, 0.9)';
                        ctx.fillRect(left, top, width, height);
                        ctx.restore();
                    }
                }
            ]
        });
    });

    function toggleView(view) {
        if (view === 'chart') {
            document.getElementById('chartContainer').style.display = 'block';
            document.getElementById('tableContainer').style.display = 'none';
        } else {
            document.getElementById('chartContainer').style.display = 'none';
            document.getElementById('tableContainer').style.display = 'block';
        }
    }
</script>
</body>
</html>
