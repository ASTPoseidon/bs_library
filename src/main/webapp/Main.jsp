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
                        List<Book> bookresult = (List<Book>) request.getAttribute("books");
                        for (Book tmp : bookresult) {
                %>
                <tr>
                    <td><input type="checkbox" name="checkbox" value="<%=tmp.getID()%>"></td>
                    <td id="<%=tmp.getID()%>_Name"><%=tmp.getName()%>
                    </td>
                    <td id="<%=tmp.getID()%>_Author"><%=tmp.getAuthor()%>
                    </td>
                    <td id="<%=tmp.getID()%>_Publisher"><%=tmp.getPublisher()%>
                    </td>
                    <td id="<%=tmp.getID()%>_Price"><%=tmp.getPrice()%>
                    </td>
                    <td id="<%=tmp.getID()%>_ISBN"><%=tmp.getISBN()%>
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
                    <td><input type="checkbox" name="checkbox" value="<%=tmp.getID()%>"></td>
                    <td id="<%=tmp.getID()%>_Name"><%=tmp.getName()%>
                    </td>
                    <td id="<%=tmp.getID()%>_Author"><%=tmp.getAuthor()%>
                    </td>
                    <td id="<%=tmp.getID()%>_Publisher"><%=tmp.getPublisher()%>
                    </td>
                    <td id="<%=tmp.getID()%>_Price"><%=tmp.getPrice()%>
                    </td>
                    <td id="<%=tmp.getID()%>_ISBN"><%=tmp.getISBN()%>
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
            data-target="#updatebook" id="update" onclick="UpdateBook()" disabled>修改书籍
    </button>
    <button style="margin-right: 20px" type="button" class="btn btn-danger" onclick="DeleteBook()">删除书籍</button>
    <div style="text-align: right">
        <small class="form-text text-muted">（仅有 1 个书籍被选中时，修改按钮激活）</small>
    </div>
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
            <small style="margin-left: 15px"
                   class="form-text text-muted">当一个或多个文本框未被填写时，确定按钮不可用</small>
            <div class="modal-body">
                <form action="InsertServlet" method="post">
                    <div class="form-group">
                        <label for="Name1" class="col-form-label">书名:</label>
                        <input type="text" class="form-control" id="Name1" name="Name1">
                    </div>
                    <div class="form-group">
                        <label for="Author1" class="col-form-label">作者:</label>
                        <input type="text" class="form-control" id="Author1" name="Author1">
                    </div>
                    <div class="form-group">
                        <label for="Publisher1" class="col-form-label">出版社:</label>
                        <textarea class="form-control" id="Publisher1" name="Publisher1"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="Price1" class="col-form-label">价格:</label>
                        <input type="text" class="form-control" id="Price1" name="Price1">
                    </div>
                    <div class="form-group">
                        <label for="ISBN1" class="col-form-label">ISBN:</label>
                        <input type="text" class="form-control" id="ISBN1" name="ISBN1">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                        <button type="submit" class="btn btn-primary" id="Submit1" disabled>确定</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="updatebook" tabindex="-1" aria-labelledby="updatebook" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">修改书籍</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <small style="margin-left: 15px"
                   class="form-text text-muted">当一个或多个文本框未被填写时，确定按钮不可用</small>
            <div class="modal-body">
                <form action="UpdateServlet" method="post">
                    <div class="form-group">
                        <input type="hidden" class="form-control" id="ID2" name="ID2" value="">
                    </div>
                    <div class="form-group">
                        <label for="Name2" class="col-form-label">书名:</label>
                        <input type="text" class="form-control" id="Name2" name="Name2">
                        <small class="form-text text-muted" id="Name3"></small>
                    </div>
                    <div class="form-group">
                        <label for="Author2" class="col-form-label">作者:</label>
                        <input type="text" class="form-control" id="Author2" name="Author2">
                        <small class="form-text text-muted" id="Author3"></small>
                    </div>
                    <div class="form-group">
                        <label for="Publisher2" class="col-form-label">出版社:</label>
                        <textarea class="form-control" id="Publisher2" name="Publisher2"></textarea>
                        <small class="form-text text-muted" id="Publisher3"></small>
                    </div>
                    <div class="form-group">
                        <label for="Price2" class="col-form-label">价格:</label>
                        <input type="text" class="form-control" id="Price2" name="Price2">
                        <small class="form-text text-muted" id="Price3"></small>
                    </div>
                    <div class="form-group">
                        <label for="ISBN2" class="col-form-label">ISBN:</label>
                        <input type="text" class="form-control" id="ISBN2" name="ISBN2">
                        <small class="form-text text-muted" id="ISBN3"></small>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                        <button type="submit" class="btn btn-primary" id="Submit2" disabled>确定</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>

<script>

    var Select = document.getElementById("type");
    var Input = document.getElementById("text");
    var SearchButton = document.getElementById("search");
    var UpdateButton = document.getElementById("update");
    var CheckBoxes = document.getElementsByName("checkbox");
    var Submit1 = document.getElementById("Submit1");
    var Submit2 = document.getElementById("Submit2");
    var Name1 = document.getElementById("Name1");
    var Author1 = document.getElementById("Author1");
    var Publisher1 = document.getElementById("Publisher1");
    var Price1 = document.getElementById("Price1");
    var ISBN1 = document.getElementById("ISBN1");
    var Name2 = document.getElementById("Name2");
    var Author2 = document.getElementById("Author2");
    var Publisher2 = document.getElementById("Publisher2");
    var Price2 = document.getElementById("Price2");
    var ISBN2 = document.getElementById("ISBN2");

    Select.addEventListener('change', function () {
        checkValidity();
    })

    Input.addEventListener('input', function () {
        checkValidity();
    })
    Name1.addEventListener('input', function () {
        checkValidity1();
    })
    Author1.addEventListener('input', function () {
        checkValidity1();
    })
    Publisher1.addEventListener('input', function () {
        checkValidity1();
    })
    Price1.addEventListener('input', function () {
        checkValidity1();
    })
    ISBN1.addEventListener('input', function () {
        checkValidity1();
    })
    Name2.addEventListener('input', function () {
        checkValidity2();
    })
    Author2.addEventListener('input', function () {
        checkValidity2();
    })
    Publisher2.addEventListener('input', function () {
        checkValidity2();
    })
    Price2.addEventListener('input', function () {
        checkValidity2();
    })
    ISBN2.addEventListener('input', function () {
        checkValidity2();
    })
    for (var i = 0; i < CheckBoxes.length; i++) {
        CheckBoxes[i].addEventListener('change', function () {
            checkValidity3();
        })
    }

    function checkValidity() {
        if (Select.value == "null" || Input.value.trim() == "") {
            SearchButton.disabled = true;
        } else {
            SearchButton.disabled = false;
        }
    }

    function checkValidity1() {
        if (Name1.value.trim() == "" || Author1.value.trim() == "" || Publisher1.value.trim() == "" || Price1.value.trim() == "" || ISBN1.value.trim() == "") {
            Submit1.disabled = true;
        } else {
            Submit1.disabled = false;
        }
    }

    function checkValidity2() {
        if (Name2.value.trim() == "" || Author2.value.trim() == "" || Publisher2.value.trim() == "" || Price2.value.trim() == "" || ISBN2.value.trim() == "") {
            Submit2.disabled = true;
        } else {
            Submit2.disabled = false;
        }
    }

    function checkValidity3() {
        var count = 0;
        for (var i = 0; i < CheckBoxes.length; i++) {
            if (CheckBoxes[i].checked) {
                count++;
            }
        }
        if (count == 1) {
            UpdateButton.disabled = false;
        } else {
            UpdateButton.disabled = true;
        }
    }


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

    function DeleteBook() {
        const checkbox = document.getElementsByName("checkbox");
        var list = "";
        for (var i = 0; i < checkbox.length; i++) {
            if (checkbox[i].checked) {
                list += checkbox[i].value + ",";
            }
        }
        list = list.slice(0, -1);
        window.location.href = "DeleteServlet?ID=" + list;
    }

    function UpdateBook() {
        const checkboxes = document.getElementsByName("checkbox");
        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked) {
                var checkbox = document.getElementsByName("checkbox")[i];
                break;
            }
        }
        var ID = document.getElementById("ID2").value = checkbox.value;
        var Name = ID + "_Name";
        var Author = ID + "_Author";
        var Publisher = ID + "_Publisher";
        var Price = ID + "_Price";
        var ISBN = ID + "_ISBN";
        document.getElementById("Name3").innerText = "当前书名为：" + document.getElementById(Name).innerHTML;
        document.getElementById("Author3").innerText = "当前作者为：" + document.getElementById(Author).innerHTML;
        document.getElementById("Publisher3").innerText = "当前出版社为：" + document.getElementById(Publisher).innerHTML;
        document.getElementById("Price3").innerText = "当前价格为：" + document.getElementById(Price).innerHTML;
        document.getElementById("ISBN3").innerText = "当前ISBN为：" + document.getElementById(ISBN).innerHTML;
        document.getElementById("Name2").value = document.getElementById(Name).innerHTML;
        document.getElementById("Author2").value = document.getElementById(Author).innerHTML;
        document.getElementById("Publisher2").value = document.getElementById(Publisher).innerHTML;
        document.getElementById("Price2").value = document.getElementById(Price).innerHTML;
        document.getElementById("ISBN2").value = document.getElementById(ISBN).innerHTML;
    }
</script>

</body>
</html>
