package service;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        HttpSession session = req.getSession();

        if(username!=null && password!=null && username.length()>0 && password.length()>0) {
            UserCheck userCheck = new UserCheck();
            if(userCheck.checkUser(username, password)) {
                session.setAttribute("isLogin", "true");
                session.setAttribute("username", username);
                resp.sendRedirect("index.jsp");
            }
            else {
                resp.setContentType("text/html");
                resp.getWriter().print("<script language='javascript'>" +
                        "alert('您输入的用户名或密码有误，请重新输入！');" +
                        "window.location.href='login.jsp';</script>");
            }
        }
        else
        {
            resp.sendRedirect("login.jsp");
        }
    }

}
