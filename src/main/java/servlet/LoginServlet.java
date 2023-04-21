package servlet;

import dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Content-type", "text/html;charset=UTF-8");
        PrintWriter pw = response.getWriter();
        String UserName = request.getParameter("UserName");
        String PassWord = request.getParameter("PassWord");
        try {
            if (new UserDao().ifPass(UserName, PassWord)) {//正规这里应该传User对象
                request.setAttribute("UserName", UserName);
                pw.print("<h1>登陆成功</h1>");
                request.getRequestDispatcher("Main.jsp?ifsearch=0").forward(request, response);
            } else {
                pw.print("<h1>登陆失败</h1>");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
