<%@ page import="java.time.*" %>
<%@ page import="java.time.format.*" %>
<%--
  Created by IntelliJ IDEA.
  User: marco
  Date: 15/05/2022
  Time: 11:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../database.jsp" %>
<%@page import="com.example.carpooling.Functions" %>

<%
    if (session.getAttribute("username").equals("") || !session.getAttribute("ruolo").equals("a")) {
        response.sendRedirect("../../index.jsp");
        return;
    }

    Functions f = new Functions();

    int id = 0;
    String img = "";
    String sql = "SELECT idUtente, img FROM utenti WHERE username = '" + session.getAttribute("username") + "'";
    ResultSet rs = stmt.executeQuery(sql);

    if (rs.next()) {
        id = rs.getInt("idUtente");
        img = rs.getString("img");
    }
    rs.close();
%>

<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <!-- Bootstrap CSS -->
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
            crossorigin="anonymous"
    />

    <link href="../../css/style.css" rel="stylesheet"/>
    <link href="../../css/login.css" rel="stylesheet"/>
    <link rel="shortcut icon" href="../../icons/logo.png">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script>
        function policy(btn) {
            const a = btn.id;
            document.location.href = "acceptRefuseBooking.jsp?id=" + a;
        }

        function grade(btn) {
            const a = btn.id;
            document.location.href = "gradePassenger.jsp?id=" + a;
        }

        function del(btn) {
            const a = btn.id;
            document.location.href = "deleteBooking.jsp?id=" + a;
        }
    </script>
    <title>Car Pooling - Homepage Autista</title>
    <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
</head>
<body>
<div class="bg-image">
    <div class="overflow-auto cont">
        <header>
            <br/>
            <nav id="navbar_top" class="navbar navbar-expand-lg navbar-dark">
                <div class="container">
                    <a class="navbar-brand" href="index.jsp">Car Pooling</a>
                    <button
                            class="navbar-toggler"
                            type="button"
                            data-bs-toggle="collapse"
                            data-bs-target="#main_nav"
                    >
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="main_nav">
                        <ul class="navbar-nav">
                            <li class="nav-item d-flex align-items-center">
                                <a class="nav-link" href="index.jsp"> Trips </a>
                            </li>
                            <li class="nav-item d-flex align-items-center">
                                <a class="nav-link" href="grades.jsp"> Grades </a>
                            </li>
                        </ul>
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item d-flex align-items-center">
                                <a class="nav-link" href="inserimentoAuto.jsp"> Insert car </a>
                            </li>
                            <li class="nav-item d-flex align-items-center">
                                <a class="nav-link" href="inserimentoViaggio.jsp"> Insert trip </a>
                            </li>
                            <li class="nav-item d-flex align-items-center profileIcon">
                                <a class="fa fa-bell cursor"
                                   routerLink="/backoffice/jobs"
                                   routerLinkActive="active"
                                   data-bs-toggle="dropdown"
                                   style="color: white; transform: translateX(0px) !important;">
                                    <%
                                        sql = "SELECT * FROM ((prenotazioni p INNER JOIN viaggi v ON v.idViaggio = p.idViaggio) INNER JOIN automobili a ON v.idAutomobile = a.idAutomobile) INNER JOIN utenti u ON p.idUtente = u.idUtente WHERE p.stato='?' AND a.idUtente=" + id + " ORDER BY v.dataInizio ASC";
                                        rs = stmt.executeQuery(sql);
                                        if (rs.next()) {
                                            out.write(" " + (rs.getFetchSize() + 1));
                                        }
                                    %>
                                </a>
                            </li>

                            <div class="dropdown">
                                <a
                                        class="d-flex align-items-center nav-link dropdown-toggle"
                                        routerLink="/backoffice/jobs"
                                        routerLinkActive="active"
                                        data-bs-toggle="dropdown"
                                >
                                    <img
                                            src="<%
                                                if (!img.equals(""))
                                                    out.write("http://carpooling.samuelciappesoni.it:8080/images/CarPooling/profile/" + img);
                                                else
                                                    out.write("http://carpooling.samuelciappesoni.it:8080/images/CarPooling/profile/default.jpg");
                                            %>"
                                            class="iconos profileImage cursor"
                                            alt="hammer"
                                    />
                                    <text
                                            class="my-0"
                                            style="padding-left: 10px; cursor: pointer"
                                    ><%=session.getAttribute("username")%>
                                    </text>
                                </a>
                                <div class="dropdown-menu">
                                    <a href="detailsPage.jsp" class="dropdown-item">Details</a>
                                    <div class="dropdown-divider"></div>
                                    <a href="../../index.jsp" class="dropdown-item">Logout</a>
                                </div>
                            </div>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>
        <br>
        <div class="container-xl" style="height: 75vh">
            <div class="wrapper fadeInDown" style="height: 50vh">
                <div class="homeDiv">
                    <br/>
                    <h1
                            class="fadeIn first"
                            style="padding: 0px 10px 10px 10px; color: rgb(97, 95, 133)"
                    >
                        Attent to accept trips
                    </h1>
                    <div class="cont overflow-auto home">
                        <%
                            sql = "SELECT * FROM ((prenotazioni p INNER JOIN viaggi v ON v.idViaggio = p.idViaggio) INNER JOIN automobili a ON v.idAutomobile = a.idAutomobile) INNER JOIN utenti u ON p.idUtente = u.idUtente WHERE p.stato='?' AND a.idUtente=" + id + " ORDER BY v.dataInizio ASC";
                            rs = stmt.executeQuery(sql);
                            if (!rs.next()) {
                                out.write("<div class=\"container d-flex justify-content-center\">There are no request</div>");
                            } else {
                        %>
                        <table class="table">
                            <thead>
                            <tr>
                                <th scope="col" style="text-align: center">Surname and Name</th>
                                <th scope="col" style="text-align: center">Departure</th>
                                <th scope="col" style="text-align: center">Destination</th>
                                <th scope="col" style="text-align: center">Date and Time</th>
                                <th scope="col" style="text-align: center">Accept</th>
                                <th scope="col" style="text-align: center">Decline</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                rs.beforeFirst();
                                while (rs.next()) {
                            %>
                            <tr>

                                <th scope="row" style="text-align: center">
                                    <text data-toggle="modal"
                                          data-target="#modalDiv"
                                          class="cursor"
                                          onclick="popModal('<%=rs.getString("idUtente")%>', '<%=rs.getString("cognome") + " " + rs.getString("nome")%>');"
                                          style="text-decoration-line: underline;"><%=rs.getString("cognome") + " " + rs.getString("nome")%>
                                    </text>
                                </th>
                                <td style="text-align: center"><%=rs.getString("partenza")%>
                                </td>
                                <td style="text-align: center"><%=rs.getString("arrivo")%>
                                </td>
                                <td style="text-align: center"><%=f.renderDate(rs.getString("dataInizio")) + " alle " + rs.getString("oraPartenza")%>
                                </td>
                                <td style="text-align: center">
                                    <button type="button" id="y<%=rs.getString("idPrenotazione")%>"
                                            onclick="policy(this)"
                                            style="background: none;padding: 0px;border: none">
                                        <i class="fa fa-check" style="font-size:24px;color:green"></i>
                                    </button>
                                </td>
                                <td style="text-align: center">
                                    <button type="button" id="n<%=rs.getString("idPrenotazione")%>"
                                            onclick="policy(this)"
                                            style="background: none;padding: 0px;border: none">
                                        <i class="fa fa-close" style="font-size:24px;color:red"></i>
                                    </button>
                                </td>
                            </tr>
                            <% }
                            }%>
                            </tbody>
                        </table>
                        <br/>
                    </div>
                    <br/><br/>
                </div>
            </div>
        </div>

        <script>
            function popModal(id, nome) {

                document.getElementById('modalLabel').innerText = 'Reviews of ' + nome;
                $('#modalBody').load("../reviewUser.jsp?id=" + id + "&type=pas");
            }
        </script>

        <!-- Modal -->
        <div
                class="modal fade"
                id="modalDiv"
                tabindex="-1"
                role="dialog"
                aria-labelledby="modalLabel"
                aria-hidden="true"
        >
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalLabel"></h5>
                        <button
                                type="button"
                                class="close"
                                data-dismiss="modal"
                                aria-label="Close"
                        >
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="modalBody">Loading...</div>
                    </div>
                    <div class="modal-footer">
                        <button
                                type="button"
                                class="btn btn-secondary"
                                data-dismiss="modal"
                        >
                            Close
                        </button>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
<script
        src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"
></script>
<script
        src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"
></script>
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"
></script>

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"
></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</body>
</html>


