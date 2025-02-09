<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>医药仓库温湿度监控系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://7npmedia.w3cschool.cn/w3.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f8ff; /* 浅蓝色背景 */
        }

        .w3-teal {
            background-color: #4682b4; /* 深蓝色背景 */
            color: white; /* 白色文字 */
        }

        .w3-button {
            border-radius: 5px; /* 圆角按钮 */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 按钮阴影 */
        }

        .logout-button {
            float: right;
            margin: 10px 20px;
            background-color: #ff6347; /* 红色背景 */
            color: white; /* 白色文字 */
            border: none;
            padding: 8px 15px;
            font-size: 14px;
            border-radius: 5px;
            cursor: pointer;
        }

        .logout-button:hover {
            background-color: #ff4500; /* 更深的红色 */
        }

        .image-text-container {
            display: flex;
            align-items: center;
            margin-top: 40px;
            padding: 20px;
            background-color: white; /* 白色背景 */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 容器阴影 */
            border-radius: 8px; /* 圆角容器 */
        }

        .image-text-container img {
            width: 45%;
            height: auto;
            border-radius: 8px; /* 圆角图片 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 图片阴影 */
        }

        .image-text-container .text {
            flex: 1;
            padding-left: 30px;
        }

        .image-text-container .text h2 {
            color: #4682b4; /* 深蓝色标题 */
        }

        .w3-container {
            padding: 20px;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .image-text-container {
                flex-direction: column; /* 垂直布局 */
                align-items: flex-start; /* 文本对齐到顶部 */
            }

            .image-text-container img {
                width: 100%;
                margin-bottom: 20px;
            }

            .image-text-container .text {
                padding-left: 0;
            }
        }
    </style>
</head>
<body>

<div class="w3-sidebar w3-bar-block" style="display:none" id="mySidebar">
    <button onclick="w3_close()" class="w3-bar-item w3-button w3-large">关闭 &times;</button>
    <a href="warehouse.jsp" class="w3-bar-item w3-button">仓库管理</a>
    <a href="device.jsp" class="w3-bar-item w3-button">设备管理</a>
    <a href="history.jsp" class="w3-bar-item w3-button">温湿度数据展示</a>
</div>

<div class="w3-teal">
    <button class="w3-button w3-teal w3-xlarge" onclick="w3_open()">☰</button>
    <button class="logout-button" onclick="confirmLogout()">退出登录</button>
    <div class="w3-container">
        <h1>医药仓库温湿度监控系统</h1>
    </div>
</div>

<!-- Image and Text Section -->
<div class="image-text-container">
    <img src="imgs/2.jpg" alt="医药仓库温湿度监控">
    <div class="text">
        <h2>医药仓库温湿度监控系统，采用先进的物联网技术，对医药仓库内的温湿度进行实时监测与控制。系统通过高精度传感器，全天候采集仓库内的温湿度数据，确保药品在适宜的环境下储存，保障药品的质量和疗效。实现仓库管理，设备管理以及温湿度数据展示</h2>
    </div>
</div>

<div class="w3-container">

</div>

<script>
    function w3_open() {
        document.getElementById("mySidebar").style.width = "250px";
        document.getElementById("mySidebar").style.display = "block";
    }

    function w3_close() {
        document.getElementById("mySidebar").style.display = "none";
    }

    function confirmLogout() {
        if (confirm("确定要退出登录吗？")) {
            location.href = 'logoutServlet';
        }
    }
</script>

</body>
</html>
