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
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "DeleteServlet", value = "/DeleteServlet")
public class DeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ID = request.getParameter("ID");
        String[] list = ID.split(",");
        List<Book> books = new ArrayList<>();
        for (int i = 0; i < list.length; i++) {
            books.add(new Book(Integer.valueOf(list[i])));
        }
        boolean flag = true;
        for (Book tmp : books) {
            try {
                if (!new BookDao().Delete(tmp)) {
                    flag = false;
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        response.sendRedirect("Main.jsp?ifsearch=0");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
