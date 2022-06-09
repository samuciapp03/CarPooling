<%--
  Created by IntelliJ IDEA.
  User: marco
  Date: 09/06/2022
  Time: 10:44
  To change this template use File | Settings | File Templates.
--%>
<%
    if (session.getAttribute("code").equals("")) {
        response.sendRedirect("./index.jsp");
        return;
    }
%>

<html>
<!DOCTYPE html>
<html lang="en">
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

    <link rel="stylesheet" href="../../../css/style.css"/>
    <link rel="stylesheet" href="../../../css/login.css"/>
    <link rel="shortcut icon" href="../../../icons/logo.png">

    <title>Car Pooling - Confirm Code</title>
</head>
<body>
<div class="bg-image">
    <div class="container">
        <div
                class="container d-flex justify-content-center"
                style="height: 100vh"
        >
            <div class="wrapper fadeInDown">
                <div class="formContent">
                    <!-- Login Form -->
                    <form method="post" action="verificaCodiceCode.jsp">
                        <br/>
                        <h1
                                class="fadeIn first"
                                style="padding-bottom: 10px; color: rgb(97, 95, 133)"
                        >
                            Confirm code
                        </h1>
                        <input
                                type="text"
                                id="codice"
                                class="fadeIn second"
                                name="codice"
                                placeholder="Code"
                        />
                        <input type="submit" class="fadeIn third" value="Go"/>
                    </form>

                    <div class="formFooter">
                        <a class="underlineHover" href="../login/">Back Home</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Option 1: Bootstrap Bundle with Popper -->
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"
></script>
</body>
</html>
</html>
