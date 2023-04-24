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

@WebServlet(name = "InsertServlet", value = "/InsertServlet")
public class InsertServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Book book = new Book(request.getParameter("Name1"), request.getParameter("Author1"), request.getParameter("Publisher1"), Double.parseDouble(request.getParameter("Price1")), request.getParameter("ISBN1"));
        try {
            boolean flag = new BookDao().Insert(book);
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
