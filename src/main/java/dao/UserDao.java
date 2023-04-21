package dao;

import util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {
    private final Connection con = new DatabaseConnection().getConnection();

    public boolean ifPass(String UserName, String PassWord) throws SQLException {
        PreparedStatement pstmt;
        String sql = "select * from login where UserName = ? and PassWord = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, UserName);
        pstmt.setString(2, PassWord);
        ResultSet rs = pstmt.executeQuery();
        return rs.next();
    }

}
