package bean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

//数据库连接类
public class DatabaseConnection {
    //根据实际情况自行配置
    private static final String dbdriver = "com.mysql.cj.jdbc.Driver";
    private static final String dburl = "jdbc:mysql://localhost:3306/bs_library";
    private static final String dbuser = "root";
    private static final String password = "guo2086443";

    private Connection con;

    public DatabaseConnection() {
        try {
            Class.forName(dbdriver);
            this.con = DriverManager.getConnection(dburl, dbuser, password);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Connection getConnection() {
        return this.con;
    }

    public void close() {
        if (this.con != null) {
            try {
                this.con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
