<%@ page import="bean.Book" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: AST
  Date: 2023/4/19
  Time: 22:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
            integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
            crossorigin="anonymous"></script>
    <title>图书管理系统</title>
    <style>
        table {
            /*设置相邻单元格的边框间的距离*/
            border-spacing: 0;
            /*表格设置合并边框模型*/
            border-collapse: collapse;
            text-align: center;
        }

        /*关键设置 tbody出现滚动条*/
        table tbody {
            display: block;
            height: 50vh;
            overflow-y: scroll;
        }

        table thead,
        tbody tr {
            display: table;
            width: 100%;
            table-layout: fixed;
        }

        /*关键设置：滚动条默认宽度是16px 将thead的宽度减16px*/
        table thead {
            width: calc(100% - 1em)
        }
    </style>
</head>
<body>
<div class="alert alert-primary" role="alert">
    图书管理系统
</div>

<%
    String text = "";
    String type = "";
    String[] selected = {"", "", "", "", "", ""};
    int flag = 0;
    if (request.getParameter("ifsearch").equals("1")) {
        flag = 1;
        text = request.getParameter("text");
        type = request.getParameter("type");
        if (type.equals("索引条件")) {
            selected[0] = "selected";
        }
        if (type.equals("书名")) {
            selected[1] = "selected";
        }
        if (type.equals("作者")) {
            selected[2] = "selected";
        }
        if (type.equals("出版社")) {
            selected[3] = "selected";
        }
        if (type.equals("价格")) {
            selected[4] = "selected";
        }
        if (type.equals("ISBN")) {
            selected[5] = "selected";
        }
    }
%>

<div class="container input-group input-group-lg">
    <spam style="margin-top: 12px">
        索引：
    </spam>
    <select id="type" style="text-align:center;width: 20vh">
        <option <%=selected[0]%> value="null">索引条件</option>
        <option <%=selected[1]%> value="书名">书名</option>
        <option <%=selected[2]%> value="作者">作者</option>
        <option <%=selected[3]%> value="出版社">出版社</option>
        <option <%=selected[4]%> value="价格">价格</option>
        <option <%=selected[5]%> value="ISBN">ISBN</option>
    </select>
    <input type="text" id="text" class="form-control" aria-label="Sizing example input"
           aria-describedby="inputGroup-sizing-lg" value="<%=text%>">
    <button type="button" id="search" class="btn btn-outline-dark" onclick="Search()" disabled>搜索</button>
    <button type="button" class="btn btn-outline-danger" onclick="Reset()">清空</button>
    <%
        if (flag == 1) {
    %>
    <button type="button" class="btn btn-outline-success" onclick="BackMain()">返回图书列表</button>
    <%
        }
    %>
</div>

<div style="display: flex;justify-content: center;align-items: center">
    <div style="width: 185vh">
        <h2>图书列表：</h2>
        <div class="table-responsive shadow-lg p-3 mb-5 bg-white rounded">
            <table class="table table-striped table-md">
                <thead>
                <tr>
                    <th>#</th>
                    <th>ID</th>
                    <th>书名</th>
                    <th>作者</th>
                    <th>出版社</th>
                    <th>价格</th>
                    <th>ISBN</th>
                </tr>
                </thead>
                <tbody>
                <%
                    if (flag == 1) {
                        //System.out.println("ok");
                        List<Book> bookresult = (List<Book>) request.getAttribute("books");
                        for (Book tmp : bookresult) {
                %>
                <tr>
                    <td><input type="checkbox"></td>
                    <td><%=tmp.getID()%>
                    </td>
                    <td><%=tmp.getName()%>
                    </td>
                    <td><%=tmp.getAuthor()%>
                    </td>
                    <td><%=tmp.getPublisher()%>
                    </td>
                    <td><%=tmp.getPrice()%>
                    </td>
                    <td><%=tmp.getISBN()%>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
                <%@include file="List.jsp" %>
                <%
                    if (flag == 0) {
                        List<Book> books = new ArrayList<>();
                        while (rs.next()) {
                            try {
                                books.add(new Book(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getDouble(5), rs.getString(6)));
                            } catch (SQLException e) {
                                throw new RuntimeException(e);
                            }
                        }
                        for (Book tmp : books) {
                %>
                <tr>
                    <td><input type="checkbox"></td>
                    <td><%=tmp.getID()%>
                    </td>
                    <td><%=tmp.getName()%>
                    </td>
                    <td><%=tmp.getAuthor()%>
                    </td>
                    <td><%=tmp.getPublisher()%>
                    </td>
                    <td><%=tmp.getPrice()%>
                    </td>
                    <td><%=tmp.getISBN()%>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div style="text-align: right;margin-right: 100px">
    <button style="margin-right: 20px" type="button" class="btn btn-primary" data-toggle="modal" data-target="#addbook">
        添加书籍
    </button>
    <button style="margin-right: 20px" type="button" class="btn btn-warning" data-toggle="modal"
            data-target="#updatebook">修改书籍
    </button>
    <button style="margin-right: 20px" type="button" class="btn btn-danger">删除书籍</button>
</div>
<div class="modal fade" id="addbook" tabindex="-1" aria-labelledby="addbook" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">添加书籍</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="Name1" class="col-form-label">书名:</label>
                        <input type="text" class="form-control" id="Name1">
                    </div>
                    <div class="form-group">
                        <label for="Author1" class="col-form-label">作者:</label>
                        <input type="text" class="form-control" id="Author1">
                    </div>
                    <div class="form-group">
                        <label for="Publisher1" class="col-form-label">出版社:</label>
                        <textarea class="form-control" id="Publisher1"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="Price1" class="col-form-label">价格:</label>
                        <input type="text" class="form-control" id="Price1">
                    </div>
                    <div class="form-group">
                        <label for="ISBN1" class="col-form-label">ISBN:</label>
                        <input type="text" class="form-control" id="ISBN1">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary">确定</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="updatebook" tabindex="-1" aria-labelledby="updatebook" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">添加书籍</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="Name2" class="col-form-label">书名:</label>
                        <input type="text" class="form-control" id="Name2">
                    </div>
                    <div class="form-group">
                        <label for="Author2" class="col-form-label">作者:</label>
                        <input type="text" class="form-control" id="Author2">
                    </div>
                    <div class="form-group">
                        <label for="Publisher2" class="col-form-label">出版社:</label>
                        <textarea class="form-control" id="Publisher2"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="Price2" class="col-form-label">价格:</label>
                        <input type="text" class="form-control" id="Price2">
                    </div>
                    <div class="form-group">
                        <label for="ISBN2" class="col-form-label">ISBN:</label>
                        <input type="text" class="form-control" id="ISBN2">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary">确定</button>
            </div>
        </div>
    </div>
</div>

<script>
    $('#type').change(function () {
        if ($(this).children('option:selected').val() != "null") {
            $("#search").removeAttr("disabled");
        } else {
            $("#search").prop("disabled", "disabled");
        }
    });
    $("input[id=text]").on("input", function (evt) {
        if ($(this).val().trim().length && $('#type').children('option:selected').val() != "null") {
            $("#search").removeAttr("disabled");
        } else {
            $("#search").prop("disabled", "disabled");
        }
    });


    function Search() {
        const type = $('#type option:selected').val();
        const text = $('#text').val();
        window.location.href = "SearchServlet?type=" + type + "&" + "text=" + text;
    }

    function Reset() {
        document.getElementById("text").value = "";
    }

    function BackMain() {
        window.location.href = "Main.jsp?ifsearch=0"
    }
</script>

</body>
</html>
