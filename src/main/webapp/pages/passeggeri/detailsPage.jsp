<%--
  Created by IntelliJ IDEA.
  User: marco
  Date: 31/05/2022
  Time: 21:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../database.jsp" %>
<%@page import="com.example.carpooling.Functions" %>

<%
    if (session.getAttribute("username").equals("") || !session.getAttribute("ruolo").equals("p")) {
        response.sendRedirect("index.jsp");
        return;
    }

    Functions f = new Functions();
    String img = "";
    int numViaggi = 0;
    float media = 0;

    String sql = "";
    ResultSet rs = null;

    sql = "SELECT * FROM utenti WHERE username='" + session.getAttribute("username") + "'";
    rs = stmt.executeQuery(sql);

    if (rs.next()) {
        img = rs.getString("img");
    }

    sql = "SELECT COUNT(*) AS num FROM prenotazioni p INNER JOIN viaggi v ON p.idViaggio=v.idViaggio WHERE v.completato='y' AND p.idUtente IN (SELECT idUtente FROM utenti WHERE username='" + session.getAttribute("username") + "')";
    rs = stmt.executeQuery(sql);

    if (rs.next()) {
        numViaggi = rs.getInt("num");
    }

    sql = "SELECT AVG(votazioneA) AS avg FROM prenotazioni WHERE idUtente IN (SELECT idUtente FROM utenti WHERE username='" + session.getAttribute("username") + "')";
    rs = stmt.executeQuery(sql);

    if (rs.next()) {
        media = rs.getFloat("avg");
    }
%>
<html>
<head>
    <title>Personal Page</title>
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
    <title>Car Pooling - Passeggero</title>
    <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
</head>
<body>
<div class="bg-image">
    <div class="overflow-auto cont">
        <header>
            <br/>
            <nav id="navbar_top" class="navbar navbar-expand-lg navbar-dark">
                <div class="container">
                    <a class="navbar-brand" href="./">Car Pooling</a>
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
                                <a class="nav-link" href="index.jsp"> Your trips </a>
                            </li>
                            <li class="nav-item d-flex align-items-center">
                                <a class="nav-link" href="grades.jsp"> Grades </a>
                            </li>
                            <li class="nav-item d-flex align-items-center">
                                <a class="nav-link" href="allTrips.jsp"> Other trips </a>
                            </li>
                        </ul>
                        <ul class="navbar-nav ms-auto">
                            <div class="dropdown profileIcon">
                                <a
                                        class="nav-link d-flex align-items-center nav-link dropdown-toggle"
                                        routerLink="/backoffice/jobs"
                                        routerLinkActive="active"
                                        data-bs-toggle="dropdown"
                                >
                                    <img
                                            src="<%
                                                if (!img.equals(""))
                                                    out.write("http://api:8080/images/CarPooling/profile/" + img);
                                                else
                                                    out.write("http://api:8080/images/CarPooling/profile/default.jpg");
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
        <div class="row height cont">
            <div class="col-lg d-flex justify-content-center align-items-center">
                <img
                        src="<%
                                if (!img.equals(""))
                                    out.write("http://api:8080/images/CarPooling/profile/" + img);
                                else
                                    out.write("http://api:8080/images/CarPooling/profile/default.jpg");
                            %>"
                        class="iconos cursor"
                        style="width: 230px; height: 230px; border-radius: 115px;"
                        alt="hammer"
                        onclick="window.open('https://www.youtube.com/watch?v=dQw4w9WgXcQ', '_blank').focus();"
                />
            </div>
            <div class="col-lg-6 d-flex justify-content-center">
                <div class="wrapper fadeInDown">
                    <div class="formContent">
                        <div class="overflow-auto reg">
                            <br/>
                            <h1
                                    class="fadeIn first"
                                    style="padding: 0px 10px 10px 10px; color: rgb(97, 95, 133)"
                            >
                                Your personal details
                            </h1>
                            <%
                                sql = "SELECT * FROM utenti WHERE username='" + session.getAttribute("username") + "'";
                                rs = stmt.executeQuery(sql);
                                if (!rs.next()) {
                                    out.write("<div class=\"container d-flex justify-content-center\">Personal information missing</div>");
                                } else {
                                    rs.beforeFirst();
                                    while (rs.next()) {
                            %>
                            <label class="form-check-label fadeIn second" style="color: white">
                                Username
                            </label><br>
                            <text
                                    type="text"
                                    class="form-control inputStyle fadeIn second"
                            ><%=rs.getString("username")%>
                            </text>
                            <br><label class="form-check-label fadeIn second" style="color: white">
                            Surname and Name
                        </label><br>
                            <text
                                    type="text"
                                    class="form-control inputStyle fadeIn second"
                            ><%=rs.getString("cognome") + " " + rs.getString("nome")%>
                            </text>
                            <br><label class="form-check-label fadeIn second" style="color: white">
                            Date of birth
                        </label><br>
                            <text
                                    type="text"
                                    class="form-control inputStyle fadeIn second"
                            ><%=f.renderDate(rs.getString("dataNascita"))%>
                            </text>
                            <br><label class="form-check-label fadeIn second" style="color: white">
                            Email
                        </label><br>
                            <text
                                    type="text"
                                    class="form-control inputStyle fadeIn second"
                            ><%=rs.getString("email")%>
                            </text>
                            <br><label class="form-check-label fadeIn second" style="color: white">
                            Telephone
                        </label><br>
                            <text
                                    type="text"
                                    class="form-control inputStyle fadeIn second"
                            ><%=rs.getString("tel")%>
                            </text>
                            <br><label class="form-check-label fadeIn second" style="color: white">
                            Number of trips
                        </label><br>
                            <text
                                    type="text"
                                    class="form-control inputStyle fadeIn second"
                            ><%=numViaggi%>
                            </text>
                            <br><label class="form-check-label fadeIn second" style="color: white">
                            Average of review
                        </label><br>
                            <text
                                    type="text"
                                    class="form-control inputStyle fadeIn second"
                            ><%
                                for (int i = 0; i < 5; i++) {
                                    if (i < media && i + 1 > media) {
                                        out.write("<span class=\"fa fa-star fa-large nonchecked\"></span>\n<span class=\"fa fa-star fa-large split\"></span>\n");
                                    } else if (i < media) {
                                        out.write("<span class=\"fa fa-star fa-large checked\"></span>");
                                    } else if (i > media) {
                                        out.write("<span class=\"fa fa-star fa-large nonchecked\"></span>");
                                    } else if (i == media) {
                                        out.write("<span class=\"fa fa-star fa-large nonchecked\"></span>");
                                    }
                                }
                            %>
                            </text>
                            <br>
                            <% }
                            }%>
                            <br/>
                        </div>
                    </div>
                    <br/><br/>
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
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
</body>
</html>
