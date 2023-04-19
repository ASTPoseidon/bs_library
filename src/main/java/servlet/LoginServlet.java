package servlet;

import bean.User;
import dao.UserDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Content-type","text/html;charset=UTF-8");
        PrintWriter pw=response.getWriter();
        String UserName = request.getParameter("UserName");
        String PassWord = request.getParameter("PassWord");
        try {
            if (new UserDao().ifPass(UserName, PassWord)) {
                request.setAttribute("UserName",UserName);
                pw.print("<h1>登陆成功</h1>");
                response.sendRedirect("Main.jsp");
            }
            else {
                pw.print("<h1>登陆失败</h1>");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

        @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
