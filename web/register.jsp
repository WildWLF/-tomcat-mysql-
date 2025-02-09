<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>注册页面</title>
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
    h2 {
      font-size: 24px;
      color: #333;
      margin-bottom: 20px;
    }
    label {
      display: block;
      text-align: left;
      margin-bottom: 6px;
      font-size: 14px;
      font-weight: bold;
      color: #555;
    }
    input[type="text"], input[type="password"], input[type="email"] {
      width: 100%;
      padding: 10px;
      margin-bottom: 15px;
      border: 1px solid #dbdbdb;
      border-radius: 8px;
      font-size: 14px;
      background: #fafafa;
    }
    input[type="text"]:focus, input[type="password"]:focus, input[type="email"]:focus {
      border-color: #b2b2b2;
      outline: none;
      box-shadow: 0 0 5px rgba(178, 178, 178, 0.5);
    }
    button {
      width: 100%;
      padding: 12px;
      margin: 10px 0;
      font-size: 16px;
      font-weight: bold;
      color: white;
      background-color: #0095f6;
      border: none;
      border-radius: 8px;
      cursor: pointer;
    }
    button:hover {
      background-color: #007bbf;
    }
    .back-btn {
      background-color: #e0e0e0;
      color: #333;
    }
    .back-btn:hover {
      background-color: #bdbdbd;
    }
    .error-message {
      color: red;
      font-size: 13px;
      margin-top: -10px;
      margin-bottom: 10px;
      text-align: left;
    }
  </style>
</head>
<body>
<div class="container">
  <h2>注册</h2>
  <form>
    <label for="username">用户名：</label>
    <input type="text" id="username" name="username" onblur="verifyUserName()" placeholder="请输入用户名" required />
    <div id="usernameError" class="error-message"></div>

    <label for="email">邮箱：</label>
    <input type="email" id="email" name="email" onblur="verifyEmail()" placeholder="请输入邮箱" required />
    <div id="emailError" class="error-message"></div>

    <label for="password">密码：</label>
    <input type="password" id="password" name="password" placeholder="请输入密码" required />

    <label for="confirmPassword">确认密码：</label>
    <input type="password" id="confirmPassword" name="confirmPassword" onblur="verifyPasswordMatch()" placeholder="请再次输入密码" required />
    <div id="passwordError" class="error-message"></div>

    <button id="registerButton" type="button" onclick="userRegister(event)" disabled>注册</button>
    <button type="button" class="back-btn" onclick="window.location.href='login.jsp';">返回登录</button>
  </form>
</div>

<script>
  function verifyUserName() {
    var xmlrequest = new XMLHttpRequest();
    var username = document.getElementById("username").value;
    var usernameError = document.getElementById("usernameError");
    var registerButton = document.getElementById("registerButton");

    xmlrequest.open("GET", "verityUserName?username=" + username, true);
    xmlrequest.send();
    xmlrequest.onreadystatechange = function () {
      if (xmlrequest.readyState === 4 && xmlrequest.status === 200) {
        var result = xmlrequest.responseText;
        if (result === "true") {
          usernameError.textContent = "该用户名已被注册";
          registerButton.disabled = true;
        } else {
          usernameError.textContent = "";
          checkFormValidity();
        }
      }
    };
  }

  function verifyEmail() {
    var email = document.getElementById("email").value;
    var emailError = document.getElementById("emailError");
    var registerButton = document.getElementById("registerButton");
    var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (!emailRegex.test(email)) {
      emailError.textContent = "邮箱格式不正确";
      registerButton.disabled = true;
    } else {
      emailError.textContent = "";
      checkFormValidity();
    }
  }

  function verifyPasswordMatch() {
    var password = document.getElementById("password").value;
    var confirmPassword = document.getElementById("confirmPassword").value;
    var passwordError = document.getElementById("passwordError");

    if (password !== confirmPassword) {
      passwordError.textContent = "两次密码输入不一致";
      document.getElementById("registerButton").disabled = true;
    } else {
      passwordError.textContent = "";
      checkFormValidity();
    }
  }

  function checkFormValidity() {
    var usernameError = document.getElementById("usernameError").textContent;
    var emailError = document.getElementById("emailError").textContent;
    var passwordError = document.getElementById("passwordError").textContent;

    var username = document.getElementById("username").value;
    var email = document.getElementById("email").value;
    var password = document.getElementById("password").value;
    var confirmPassword = document.getElementById("confirmPassword").value;

    if (
            username.length > 0 &&
            email.length > 0 &&
            password.length > 0 &&
            confirmPassword.length > 0 &&
            usernameError === "" &&
            emailError === "" &&
            passwordError === ""
    ) {
      document.getElementById("registerButton").disabled = false;
    } else {
      document.getElementById("registerButton").disabled = true;
    }
  }

  function userRegister(event) {
    event.preventDefault();
    var xmr = new XMLHttpRequest();
    var username = document.getElementById("username").value;
    var email = document.getElementById("email").value;
    var password = document.getElementById("password").value;

    xmr.open("POST", "userRegister", true);
    xmr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    var data = "username=" + encodeURIComponent(username) + "&email=" + encodeURIComponent(email) + "&password=" + encodeURIComponent(password);

    xmr.onreadystatechange = function () {
      if (xmr.readyState === 4) {
        if (xmr.status === 200) {
          var response = xmr.responseText;
          if (response === "false") {
            alert("注册失败，用户名或邮箱已被注册，请重新输入");
          } else {
            alert("注册成功");
            window.location.href = "login.jsp";
          }
        } else {
          alert("请求失败，状态码：" + xmr.status);
        }
      }
    };
    xmr.send(data);
  }
</script>
</body>
</html>
