package filter;

import javax.servlet.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

public class LoginFilter implements Filter {
    String uncheckedUrls;

    public void init(FilterConfig filterConfig) throws ServletException {
        ServletContext servletContext = filterConfig.getServletContext();
        uncheckedUrls = servletContext.getInitParameter("uncheckedUrls");
    }
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String path = request.getServletPath();
        List<String> urls = Arrays.asList(uncheckedUrls.split(","));
        if(!urls.contains(path)) {
            HttpSession session = request.getSession();
            if(session == null || session.getAttribute("isLogin") == null || !session.getAttribute("isLogin").equals("true")){
                response.sendRedirect("login.jsp");
                return;
            }
        }
        filterChain.doFilter(request, response);
    }
}
