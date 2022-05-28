<%--
  Created by IntelliJ IDEA.
  User: marco
  Date: 20/05/2022
  Time: 20:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (!session.getAttribute("ruolo").equals("a")) {
        response.sendRedirect("index.jsp");
        return;
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

    <link rel="stylesheet" href="../../css/style.css"/>
    <link rel="stylesheet" href="../../css/login.css"/>
    <title>Car Pooling - Insert auto</title>
</head>
<body>
<div class="bg-image">
    <div class="container">
        <div class="container d-flex justify-content-center" style="height: 100vh">
            <div class="wrapper fadeIn">
                <div class="formContent">
                    <form action="./inserimentoAutoCode.jsp" method="post" id="formAuto"
                          enctype="multipart/form-data">
                        <br/>
                        <h1
                                class="fadeIn first"
                                style="padding-bottom: 18px; color: rgb(97, 95, 133)"
                        >
                            Insert auto
                        </h1>

                        <div class="overflow-auto" style="height: 50vh">
                            <input
                                    type="text"
                                    id="marca"
                                    class="fadeIn second"
                                    name="marca"
                                    placeholder="Marca"
                            />
                            <input
                                    type="text"
                                    id="modello"
                                    class="fadeIn second"
                                    name="modello"
                                    placeholder="Modello"
                            />
                            <input
                                    type="text"
                                    id="targa"
                                    class="fadeIn second"
                                    name="targa"
                                    placeholder="Targa"
                            />
                            <input
                                    type="text"
                                    id="annoImm"
                                    class="fadeIn second"
                                    name="annoImm"
                                    placeholder="Year of matriculation"
                            />
                            <br><br>
                            <label class="form-check-label fadeIn second" style="color: white">
                                Photo
                            </label><br>
                            <input
                                    type="file"
                                    id="img"
                                    class="form-control fadeIn second"
                                    name="img"
                                    placeholder="img"
                            />
                        </div>
                    </form>
                    <div class="formFooter">
                        <a class="underlineHover cursor" onclick="history.back()"
                           style="padding-right: 15px;">Back</a>
                        <a class="underlineHover cursor"
                           onclick="document.getElementById('formAuto').submit()">Submit</a>
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
