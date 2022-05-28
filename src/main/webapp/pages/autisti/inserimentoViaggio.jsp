<%@include file="../database.jsp" %>

<%
    if (!session.getAttribute("ruolo").equals("a")) {
        response.sendRedirect("index.jsp");
        return;
    }

    int id = 0;
    String sql = "SELECT idUtente FROM utenti WHERE username='" + session.getAttribute("username") + "'";
    ResultSet rs = stmt.executeQuery(sql);
    if (rs.next()) {
        id = rs.getInt("idUtente");
    }
    rs.close();

    sql = "SELECT idAutomobile, marca, modello FROM automobili WHERE idUtente='" + id + "'";
    rs = stmt.executeQuery(sql);
%>

<html>
<head>
    <script>
        function mostra(str, id) {
            if (str.length == 0) {
                document.getElementById("risposta" + id).innerHTML = "";
                return;
            }

            if (window.XMLHttpRequest) {
                ajax = new XMLHttpRequest();
            } else {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

            ajax.onreadystatechange = function () {
                if (ajax.readyState == 4 && ajax.status == 200) {
                    document.getElementById("risposta" + id).innerHTML = ajax.responseText;
                }
            }
            ajax.open("POST", "../ricercaComuni.jsp?str=" + str, true);

            ajax.send();
        }

        function showStop() {
            if (document.getElementById("stops12").style.display == 'none') {
                document.getElementById("stops12").style.display = 'block';
            } else {
                document.getElementById("stops12").style.display = 'none';
            }
            document.getElementById("scroll").scrollTop = document.getElementById("scroll").scrollHeight;
        }
    </script>

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
    <title>Car Pooling - Insert trip</title>
</head>
<body>
<div class="bg-image">
    <div class="overflow-auto">
        <div class="container">
            <div class="container d-flex justify-content-center" style="height: 100vh">
                <div class="wrapper fadeIn">
                    <div class="formContent">
                        <form action="inserimentoViaggioCode.jsp" method="post" id="formTrip">
                            <br/>
                            <h1
                                    class="fadeIn first"
                                    style="padding-bottom: 18px; color: rgb(97, 95, 133)"
                            >
                                Insert trip
                            </h1>

                            <div class="overflow-auto" style="height: 50vh" id="scroll">
                                <input
                                        type="text"
                                        id="departure"
                                        class="fadeIn second"
                                        name="departure"
                                        placeholder="Departure"
                                        onkeyup="mostra(this.value,'1')"
                                        list="cities1"
                                />
                                <input
                                        type="text"
                                        id="destination"
                                        class="fadeIn second"
                                        name="destination"
                                        placeholder="Destination"
                                        onkeyup="mostra(this.value,'2')"
                                        list="cities2"
                                />
                                <br><br><label class="form-check-label fadein second" style="color: white">
                                Date of the trip
                            </label><br>
                                <input class="form-control fadeIn second" type="date" name="date"
                                       id="date"/><br><input
                                    type="time"
                                    id="time"
                                    class="inputStyle fadein second"
                                    name="time"
                                    placeholder="Departure Time"/>
                                <br><br>
                                <label class="form-check-label fadein second" style="color: white">
                                    Car
                                </label><br>
                                <select name="car" id="car" class="inputStyle fadein second">
                                    <% while (rs.next()) {
                                    %>
                                    <option value="<%=rs.getString("idAutomobile")%>"><%=rs.getString("marca") + " " + rs.getString("modello")%>
                                    </option>
                                    <%
                                        }
                                    %>
                                </select> <br><br>
                                <input
                                        type="number"
                                        id="duration"
                                        class="fadeIn second"
                                        name="duration"
                                        placeholder="Duration time"
                                        min="0"
                                />
                                <input
                                        type="number"
                                        id="contribution"
                                        class="fadeIn second"
                                        name="contribution"
                                        placeholder="Economic toll"
                                        min="0"
                                />
                                <input
                                        type="number"
                                        id="spots"
                                        class="fadeIn second"
                                        name="spots"
                                        placeholder="Available spots"
                                        min="0"
                                />
                                <br><br><input class="form-check-input" type="checkbox"
                                               id="backpacks"
                                               name="checkboxes" value="backpacks"/>
                                <label class="form-check-label" for="backpacks"
                                       style="color: white">
                                    Backpacks
                                </label><input class="form-check-input" type="checkbox"
                                               id="animals"
                                               name="checkboxes" value="animals"
                                               style="margin-left: 20px"/>
                                <label class="form-check-label" for="animals"
                                       style="color: white">
                                    Animals
                                </label><br><br>
                                <input class="form-check-input" type="checkbox"
                                       id="stops" onchange="showStop()"
                                       name="checkboxes" value="stops"/>
                                <label class="form-check-label" for="backpacks"
                                       style="color: white">
                                    Stops
                                </label>
                                <div id="stops12" style="display: none">
                                    <input
                                            type="text"
                                            id="stop1"
                                            name="stop1"
                                            placeholder="Spots 1"
                                            onkeyup="mostra(this.value,'3')"
                                            list="cities3"
                                    />
                                    <input
                                            type="text"
                                            id="stop2"
                                            name="stop2"
                                            placeholder="Spots 2"
                                            onkeyup="mostra(this.value,'4')"
                                            list="cities4"
                                    />
                                </div>

                                <datalist id="cities1">
                                    <option id="risposta1"></option>
                                </datalist>
                                <datalist id="cities2">
                                    <option id="risposta2"></option>
                                </datalist>
                                <datalist id="cities3">
                                    <option id="risposta3"></option>
                                </datalist>
                                <datalist id="cities4">
                                    <option id="risposta4"></option>
                                </datalist>
                            </div>
                        </form>
                        <div class="formFooter">
                            <a class="underlineHover cursor" onclick="history.back()"
                               style="padding-right: 15px;">Back</a>
                            <a class="underlineHover cursor"
                               onclick="document.getElementById('formTrip').submit()">Submit</a>
                        </div>
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
