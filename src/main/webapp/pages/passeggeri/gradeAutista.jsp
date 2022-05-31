<%--
  Created by IntelliJ IDEA.
  User: marco
  Date: 26/05/2022
  Time: 17:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../database.jsp" %>
<%@page import="com.example.carpooling.Functions" %>

<%
    if (!session.getAttribute("ruolo").equals("p")) {
        response.sendRedirect("index.jsp");
        return;
    }

    Functions f = new Functions();

    String idViaggio = request.getParameter("id");
    session.setAttribute("idViaggio", idViaggio);

    int id = 0;
    String sql = "SELECT idUtente FROM utenti WHERE username = '" + session.getAttribute("username") + "'";
    ResultSet rs = stmt.executeQuery(sql);

    if (rs.next()) {
        id = rs.getInt("idUtente");
    }
%>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <!-- Bootstrap CSS -->
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
            crossorigin="anonymous"
    />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <link rel="stylesheet" href="../../css/style.css"/>
    <link rel="stylesheet" href="../../css/login.css"/>
    <title>Car Pooling - Insert auto</title>
</head>
<body>
<div class="bg-image">
    <div class="container">
        <div class="container d-flex justify-content-center" style="height: 100vh">
            <div class="wrapper fadeIn">
                <div class="formContent ">
                    <%
                        sql = "SELECT * FROM (viaggi v INNER JOIN automobili a ON v.idAutomobile=a.idAutomobile) INNER JOIN utenti u ON a.idUtente=u.idUtente WHERE v.idViaggio='" + idViaggio + "'";
                        rs = stmt.executeQuery(sql);

                        if (rs.next()) {
                    %>
                    <form method="post" action="gradeAutistaCode.jsp" id="formGrade">
                        <br/>
                        <h1
                                class="fadeIn first"
                                style="padding-bottom: 18px; color: rgb(97, 95, 133)"
                        >
                            Review <%=rs.getString("cognome")%> <%=rs.getString("nome")%>
                        </h1>

                        <div class="overflow-auto" style="height: 45vh">
                            <label class="form-check-label fadeIn second" style="color: white">
                                From <%=rs.getString("partenza")%> to <%=rs.getString("arrivo")%>
                            </label><br>
                            <label class="form-check-label fadeIn second" style="color: white">
                                In <%=f.renderDate(rs.getString("dataInizio"))%>
                            </label><br><br>
                            <%
                                }
                            %>
                            <div class="d-flex justify-content-center">
                                <div onmouseenter="unstar()" onmouseleave="star(document.getElementById('grade').value)"
                                     style="width: 130px">
                                    <span class="fa fa-star fa-lg fadeIn second" id="star1"
                                          onclick="star(1)"></span>
                                    <span class="fa fa-star fa-lg fadeIn second" id="star2" onclick="star(2)"></span>
                                    <span class="fa fa-star fa-lg fadeIn second" id="star3" onclick="star(3)"></span>
                                    <span class="fa fa-star fa-lg fadeIn second" id="star4" onclick="star(4)"></span>
                                    <span class="fa fa-star fa-lg fadeIn second" id="star5" onclick="star(5)"></span>
                                </div>
                            </div>
                            <br>
                            <input id="grade" name="grade" value="0" style="display: none;"/>
                            <textarea
                                    type="text"
                                    id="review"
                                    class="fadeIn second inputStyle"
                                    name="review"
                                    placeholder="Review"
                                    style="height: 210px; resize: none; text-align: left;"
                            ></textarea>
                        </div>
                    </form>
                    <div class="formFooter">
                        <a class="underlineHover cursor" onclick="history.back()"
                           style="padding-right: 15px;">Back</a>
                        <a class="underlineHover cursor"
                           onclick="document.getElementById('formGrade').submit()">Submit</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function star(n) {
        document.getElementById("grade").value = n.toString();
        for (let i = 1; i < 6; i++) {
            if (i <= n) {
                document.getElementById("star" + i).classList.add("checked");
            } else {
                document.getElementById("star" + i).classList.remove("checked");
            }
        }
    }

    function unstar() {
        for (let i = 1; i < 6; i++) {
            document.getElementById("star" + i).classList.remove("checked");
        }
    }
</script>

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"
></script>
</body>
</html>
