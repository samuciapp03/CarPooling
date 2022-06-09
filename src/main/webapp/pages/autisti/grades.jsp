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

    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
    LocalDateTime now = LocalDateTime.now();

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
    <title>Car Pooling - Ratings autista</title>
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
                                <a class="nav-link" href="#"> Grades </a>
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
                                   style="color: white;transform: translateX(0px) !important;"
                                   onclick="window.location.href='tripAccept.jsp'">
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
                                                    out.write("http://gigachungus.duckdns.org:8080/images/CarPooling/profile/" + img);
                                                else
                                                    out.write("http://gigachungus.duckdns.org:8080/images/CarPooling/profile/default.jpg");
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
        <div class="row">
            <div class="height righe" id="gradethepassengers">
                <div class="wrapper fadeInDown">
                    <div class="homeDiv">
                        <br/>
                        <h1
                                class="fadeIn first"
                                style="padding: 0px 10px 10px 10px; color: rgb(97, 95, 133)"
                        >
                            Grade the passengers you took with you
                        </h1>
                        <div class="cont overflow-auto home">
                            <%
                                sql = "SELECT * FROM ((prenotazioni p INNER JOIN viaggi v ON p.idViaggio=v.idViaggio) INNER JOIN automobili a ON v.idAutomobile=a.idAutomobile) INNER JOIN utenti u ON u.idUtente=p.idUtente WHERE a.idUtente = " + id + " AND v.completato='y' AND p.stato='u' ORDER BY v.dataInizio DESC";
                                rs = stmt.executeQuery(sql);
                                if (!rs.next()) {
                                    out.write("<div class=\"container d-flex justify-content-center\">You did no trips</div>");
                                } else {
                            %>
                            <table class="table">
                                <thead>
                                <tr>
                                    <th scope="col" style="text-align: center">Passenger</th>
                                    <th scope="col" style="text-align: center">Trip</th>
                                    <th scope="col" style="text-align: center">Date</th>
                                    <th scope="col" style="text-align: center">Grade</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    rs.beforeFirst();
                                    while (rs.next()) {
                                %>
                                <tr>
                                    <th scope="row"
                                        style="text-align: center"><%=rs.getString("cognome") + " " + rs.getString("nome")%>
                                    </th>
                                    <td style="text-align: center"><%=rs.getString("partenza") + " - " + rs.getString("arrivo")%>
                                    </td>
                                    <td style="text-align: center"><%=f.renderDate(rs.getString("dataInizio"))%>
                                    </td>
                                    <td style="text-align: center">
                                        <button type="button"
                                                id="<%=rs.getString("idUtente") + "-" + rs.getString("idViaggio")%>"
                                                onclick="grade(this)"
                                                style="background: none;padding: 0px;border: none">
                                            <i class="fas fa-vote-yea" style="font-size:24px;color:darkgoldenrod"></i>
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
            <div class="height righe" id="yourratings">
                <div class="wrapper fadeInDown">
                    <div class="homeDiv">
                        <br/>
                        <h1
                                class="fadeIn first"
                                style="padding: 0px 10px 10px 10px; color: rgb(97, 95, 133)"
                        >
                            Your ratings
                        </h1>
                        <div class="cont overflow-auto home">
                            <%
                                sql = "SELECT * FROM ((viaggi vi INNER JOIN votazioniP vp ON vi.idViaggio = vp.idViaggio) INNER JOIN automobili a ON vi.idAutomobile=a.idAutomobile) INNER JOIN utenti u ON vp.idPasseggero=u.idUtente WHERE a.idUtente = " + id + " ORDER BY vi.dataInizio DESC";
                                rs = stmt.executeQuery(sql);
                                if (!rs.next()) {
                                    out.write("<div class=\"container d-flex justify-content-center\">You have no ratings</div>");
                                } else {
                            %>
                            <table class="table">
                                <thead>
                                <tr>
                                    <th scope="col" style="text-align: center">Passenger</th>
                                    <th scope="col" style="text-align: center">Trip</th>
                                    <th scope="col" style="text-align: center">Grade</th>
                                    <th scope="col" style="text-align: center">Review</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    rs.beforeFirst();
                                    while (rs.next()) {
                                %>
                                <tr>
                                    <th scope="row"
                                        style="text-align: center"><%=rs.getString("cognome") + " " + rs.getString("nome")%>
                                    </th>
                                    <td style="text-align: center"><%=rs.getString("partenza") + "-" + rs.getString("arrivo") + " in data " + f.renderDate(rs.getString("dataInizio"))%>
                                    </td>
                                    <td style="text-align: center"><%=rs.getString("voto")%>
                                    </td>
                                    <td style="text-align: center"><%=rs.getString("descrizione")%>
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
        </div>
    </div>
</div>
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"
></script>
</body>
</html>


