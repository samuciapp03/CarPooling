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
    if (session.getAttribute("username").equals("")) {
        response.sendRedirect("../index.jsp");
        return;
    }

    Functions f = new Functions();
    String img = "";
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
        <div class="height righe" id="nexttrips">
            <div class="wrapper fadeInDown">
                <div class="homeDiv">
                    <br/>
                    <h1
                            class="fadeIn first"
                            style="padding: 0px 10px 10px 10px; color: rgb(97, 95, 133)"
                    >
                        Your personal details
                    </h1>
                    <div class="cont overflow-auto home">
                        <%
                            String sql = "SELECT * FROM utenti WHERE username='" + session.getAttribute("username") + "'";
                            ResultSet rs = stmt.executeQuery(sql);
                            if (!rs.next()) {
                                out.write("<div class=\"container d-flex justify-content-center\">Personal information missing</div>");
                            } else {
                        %>
                        <table class="table">
                            <thead>
                            <tr>
                                <th scope="col" style="text-align: center">Field</th>
                                <th scope="col" style="text-align: center">Your detail</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                rs.beforeFirst();
                                while (rs.next()) {
                            %>
                            <tr>
                                <th style="text-align: center">Username
                                </th>
                                <td scope="row"
                                    class="d-flex justify-content-center"
                                    style="text-align: center"><%=rs.getString("username")%>
                                </td>
                            </tr>
                            <tr>
                                <th style="text-align: center">Name and Surname
                                </th>
                                <td scope="row"
                                    class="d-flex justify-content-center"
                                    style="text-align: center"><%=rs.getString("nome") + " " + rs.getString("cognome")%>
                                </td>
                            </tr>
                            <tr>
                                <th style="text-align: center">Date of birth
                                </th>
                                <td scope="row"
                                    class="d-flex justify-content-center"
                                    style="text-align: center"><%=f.renderDate(rs.getString("dataNascita"))%>
                                </td>
                            </tr>
                            <tr>
                                <th style="text-align: center">Email
                                </th>
                                <td scope="row"
                                    class="d-flex justify-content-center"
                                    style="text-align: center"><%=rs.getString("email")%>
                                </td>
                            </tr>
                            <tr>
                                <th style="text-align: center">Telephone
                                </th>
                                <td scope="row"
                                    class="d-flex justify-content-center"
                                    style="text-align: center"><%=rs.getString("tel")%>
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
