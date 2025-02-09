<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>登录</title>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      background-color: #fafafa;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }
    .container {
      background: white;
      padding: 30px;
      border: 1px solid #e6e6e6;
      border-radius: 12px;
      width: 320px;
      text-align: center;
      box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.05);
    }
    .container h2 {
      font-size: 24px;
      color: #333;
      margin-bottom: 20px;
    }
    form {
      display: flex;
      flex-direction: column;
      align-items: center;
    }
    input[type="text"], input[type="password"] {
      width: 100%;
      padding: 12px;
      margin: 10px 0;
      border: 1px solid #dbdbdb;
      border-radius: 8px;
      font-size: 14px;
      background: #fafafa;
    }
    input[type="text"]:focus, input[type="password"]:focus {
      outline: none;
      border-color: #b2b2b2;
    }
    .button {
      width: 100%;
      padding: 10px;
      margin: 10px 0;
      font-size: 16px;
      font-weight: bold;
      color: white;
      background-color: #0095f6;
      border: none;
      border-radius: 8px;
      cursor: pointer;
    }
    .button:hover {
      background-color: #007bbf;
    }
    .reset-button {
      background-color: #f44336;
    }
    .reset-button:hover {
      background-color: #d32f2f;
    }
    .register-link {
      margin-top: 15px;
      font-size: 14px;
      color: #262626;
    }
    .register-link a {
      color: #0095f6;
      text-decoration: none;
      font-weight: bold;
    }
    .register-link a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
<div class="container">
  <h2>登录</h2>
  <form action="loginServlet" method="post">
    <input type="text" name="username" placeholder="用户名" required />
    <input type="password" name="password" placeholder="密码" required />
    <button type="submit" class="button">登录</button>
    <button type="reset" class="button reset-button">重置</button>
  </form>
  <div class="register-link">
    没有账号？<a href="register.jsp">立即注册</a>
  </div>
</div>
</body>
</html>
