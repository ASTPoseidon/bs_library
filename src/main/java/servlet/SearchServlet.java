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
import java.util.List;

@WebServlet(name = "SearchServlet", value = "/SearchServlet")
public class SearchServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        String text = request.getParameter("text");
        if (type.equals("书名")) {
            List<Book> books = null;
            try {
                books = new BookDao().findByName(text);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            request.setAttribute("books", books);
            request.getRequestDispatcher("Main.jsp?ifsearch=1").forward(request, response);
        }
        if (type.equals("作者")) {
            List<Book> books = null;
            try {
                books = new BookDao().findByAuthor(text);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            request.setAttribute("books", books);
            request.getRequestDispatcher("Main.jsp?ifsearch=1").forward(request, response);
        }
        if (type.equals("出版社")) {
            List<Book> books = null;
            try {
                books = new BookDao().findByPublisher(text);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            request.setAttribute("books", books);
            request.getRequestDispatcher("Main.jsp?ifsearch=1").forward(request, response);
        }
        if (type.equals("价格")) {
            List<Book> books = null;
            try {
                books = new BookDao().findByPrice(text);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            request.setAttribute("books", books);
            request.getRequestDispatcher("Main.jsp?ifsearch=1").forward(request, response);
        }
        if (type.equals("ISBN")) {
            List<Book> books = null;
            try {
                books = new BookDao().findByISBN(text);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            request.setAttribute("books", books);
            request.getRequestDispatcher("Main.jsp?ifsearch=1").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
