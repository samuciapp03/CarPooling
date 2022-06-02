<%--
  Created by IntelliJ IDEA.
  User: marco
  Date: 01/06/2022
  Time: 10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../database.jsp" %>
<%@page import="com.example.carpooling.Functions" %>

<%
    if (session.getAttribute("username").equals("") || !session.getAttribute("ruolo").equals("a")) {
        response.sendRedirect("index.jsp");
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

    int numViaggi = 0;
    float media = 0;

    sql = "SELECT COUNT(*) AS num FROM (viaggi v INNER JOIN automobili a ON v.idAutomobile=a.idAutomobile) INNER JOIN utenti u ON a.idUtente=u.idUtente WHERE v.completato='y' AND u.idUtente IN (SELECT idUtente FROM utenti WHERE username='" + session.getAttribute("username") + "')";
    rs = stmt.executeQuery(sql);

    if (rs.next()) {
        numViaggi = rs.getInt("num");
    }

    sql = "SELECT AVG(voto) AS avg FROM ((votazioniP vp INNER JOIN viaggi vi ON vp.idViaggio=vp.idViaggio) INNER JOIN automobili a ON a.idAutomobile = vi.idAutomobile) INNER JOIN utenti u ON a.idUtente=u.idUtente WHERE u.idUtente IN (SELECT idUtente FROM utenti WHERE username='" + session.getAttribute("username") + "')";
    rs = stmt.executeQuery(sql);

    if (rs.next()) {
        media = rs.getFloat("avg");
    }
    int integerPart = (int) media;
    float decimalPart = media - integerPart;
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

    <link href="../../css/style.css" rel="stylesheet"/>
    <link href="../../css/login.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>Profilo Driver</title>
    <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
</head>
<body>
<div class="bg-image">
    <div class="overflow-auto cont">
        <header>
            <br/>
            <nav id="navbar_top" class="navbar navbar-expand-lg navbar-dark">
                <div class="container">
                    <a class="navbar-brand" href="#">Car Pooling</a>
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
                                                    //out.write("http://gigachungus.duckdns.org/images/CarPooling/profile/" + img);
                                                    out.write("../../img/propic/" + img);
                                                else
                                                    //out.write("http://gigachungus.duckdns.org/images/CarPooling/profile/default.jpg");
                                                    out.write("../../img/default.jpeg");
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
                                    <a href="#" class="dropdown-item">Details</a>
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

    </div>
</div>
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"
></script>
</body>
</html>
