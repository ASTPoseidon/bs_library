package dao;

import bean.Book;
import util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookDao {
    private final Connection con = new DatabaseConnection().getConnection();

    public List<Book> findByName(String Name) throws SQLException {
        PreparedStatement pstmt;
        String sql = "select * from book where Name = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, Name);
        ResultSet rs = pstmt.executeQuery();
        List<Book> tmp = new ArrayList<>();
        while (rs.next()) {
            tmp.add(new Book(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getDouble(5), rs.getString(6)));
        }
        return tmp;
    }

    public List<Book> findByAuthor(String Author) throws SQLException {
        PreparedStatement pstmt;
        String sql = "select * from book where Author = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, Author);
        ResultSet rs = pstmt.executeQuery();
        List<Book> tmp = new ArrayList<>();
        while (rs.next()) {
            tmp.add(new Book(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getDouble(5), rs.getString(6)));
        }
        return tmp;
    }

    public List<Book> findByPublisher(String Publisher) throws SQLException {
        PreparedStatement pstmt;
        String sql = "select * from book where Publisher = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, Publisher);
        ResultSet rs = pstmt.executeQuery();
        List<Book> tmp = new ArrayList<>();
        while (rs.next()) {
            tmp.add(new Book(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getDouble(5), rs.getString(6)));
        }
        return tmp;
    }

    public List<Book> findByPrice(String Price) throws SQLException {
        PreparedStatement pstmt;
        String sql = "select * from book where Price = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, Price);
        ResultSet rs = pstmt.executeQuery();
        List<Book> tmp = new ArrayList<>();
        while (rs.next()) {
            tmp.add(new Book(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getDouble(5), rs.getString(6)));
        }
        return tmp;
    }

    public List<Book> findByISBN(String ISBN) throws SQLException {
        PreparedStatement pstmt;
        String sql = "select * from book where ISBN = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, ISBN);
        ResultSet rs = pstmt.executeQuery();
        List<Book> tmp = new ArrayList<>();
        while (rs.next()) {
            tmp.add(new Book(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getDouble(5), rs.getString(6)));
        }
        return tmp;
    }

    public boolean Insert(Book book) throws SQLException {
        PreparedStatement pstmt;
        String sql = "insert into book values (NULL,?,?,?,?,?)";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, book.getName());
        pstmt.setString(2, book.getAuthor());
        pstmt.setString(3, book.getPublisher());
        pstmt.setDouble(4, book.getPrice());
        pstmt.setString(5, book.getISBN());
        int rs = pstmt.executeUpdate();
        return rs == 1;
    }

    public boolean Update(Book book, int ID) throws SQLException {
        PreparedStatement pstmt;
        String sql = "UPDATE book set Name=? , Author=? , Publisher=? , Price=? , ISBN=? where ID=?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, book.getName());
        pstmt.setString(2, book.getAuthor());
        pstmt.setString(3, book.getPublisher());
        pstmt.setDouble(4, book.getPrice());
        pstmt.setString(5, book.getISBN());
        pstmt.setInt(6, ID);
        int rs = pstmt.executeUpdate();
        return rs == 1;
    }

    public boolean Delete(Book book) throws SQLException {
        PreparedStatement pstmt;
        String sql = "delete from book where ID=?";
        pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, book.getID());
        int rs = pstmt.executeUpdate();
        return rs == 1;
    }
}
