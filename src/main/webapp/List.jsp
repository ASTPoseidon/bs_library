<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: AST
  Date: 2023/4/20
  Time: 20:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/bs_library";
    String user = "root";
    String password = "guo2086443";
    Connection con = DriverManager.getConnection(url, user, password);

    String sql = "select * from book";
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery(sql);
%>
</body>
</html>
