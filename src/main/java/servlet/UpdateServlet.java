package servlet;

import bean.Book;
import dao.BookDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "UpdateServlet", value = "/UpdateServlet")
public class UpdateServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Book book = new Book(request.getParameter("Name2"), request.getParameter("Author2"), request.getParameter("Publisher2"), Double.parseDouble(request.getParameter("Price2")), request.getParameter("ISBN2"));
        int ID = Integer.valueOf(request.getParameter("ID2"));
        try {
            boolean flag = new BookDao().Update(book, ID);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        response.sendRedirect("Main.jsp?ifsearch=0");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
