<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0"/>

    <link rel="stylesheet" href="../../../css/style.css"/>
    <link rel="stylesheet" href="../../../css/login.css"/>

    <title>Car pooling - Registration</title>
</head>

<script type="text/javascript">
    function show_aut() {
        document.getElementById('autista').style.display = 'block';
        document.getElementById('passeggero').style.display = 'none';
    }

    function show_pas() {
        document.getElementById('autista').style.display = 'none';
        document.getElementById('passeggero').style.display = 'block';
    }

    function password() {
        if (document.getElementById('password1').getAttribute('type') === 'password') {
            document.getElementById('password1').setAttribute('type', 'text')
            document.getElementById('password2').setAttribute('type', 'text')
        } else {
            document.getElementById('password1').setAttribute('type', 'password')
            document.getElementById('password2').setAttribute('type', 'password')
        }
    }

    function passwordP() {
        if (document.getElementById('password1P').getAttribute('type') === 'password') {
            document.getElementById('password1P').setAttribute('type', 'text')
            document.getElementById('password2P').setAttribute('type', 'text')
        } else {
            document.getElementById('password1P').setAttribute('type', 'password')
            document.getElementById('password2P').setAttribute('type', 'password')
        }
    }
</script>

<body>
<div class="bg-image">
    <div class="overflow-auto">
        <div class="container">
            <div class="row gy-5">
                <div class="col-sm container d-flex justify-content-center height">
                    <div class="wrapper fadeInDown">
                        <div class="formContent">
                            <br/>
                            <h1
                                    class="fadeIn first"
                                    style="padding-bottom: 18px; color: rgb(97, 95, 133)"
                            >
                                Choose type of user
                            </h1>
                            <div class="fadeIn second" style="padding-bottom: 10px">
                                <input class="btn-check" name="user" type="radio" id="aut"
                                       onclick="show_aut();" style="margin-left: 10px">
                                <label class="btn btn-primary" for="aut">Autista</label>

                                <input class="btn-check" name="user" type="radio" id="pas"
                                       onclick="show_pas();">
                                <label class="btn btn-primary" for="pas">Passeggero</label>
                            </div>
                            <br>

                            <div class="formFooter">
                                <a class="underlineHover" href="../login/">Back</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg">
                    <div class="hide" id="autista">
                        <div class="wrapper fadeIn d-flex justify-content-center height">
                            <div class="formContent">
                                <form action="registrazioneAutistaCode.jsp" method="post" id="formAutista"
                                      enctype="multipart/form-data">
                                    <br/>
                                    <h1
                                            class="fadeIn first"
                                            style="padding-bottom: 18px; color: rgb(97, 95, 133)"
                                    >
                                        Autista
                                    </h1>

                                    <div class="overflow-auto reg">
                                        <input
                                                type="text"
                                                id="name"
                                                class="fadeIn second"
                                                name="name"
                                                placeholder="Name"
                                        />
                                        <input
                                                type="text"
                                                id="surname"
                                                class="fadeIn second"
                                                name="surname"
                                                placeholder="Surname"
                                        />
                                        <br><br><label class="form-check-label fadein second" style="color: white">
                                        Date of birth
                                    </label><br>
                                        <input class="form-control fadeIn second" type="date" name="date"
                                               id="date"/><br><br>
                                        <input
                                                type="text"
                                                id="email"
                                                class="fadeIn second"
                                                name="email"
                                                placeholder="Email"
                                        />
                                        <input
                                                type="text"
                                                id="telephone"
                                                class="fadeIn second"
                                                name="telephone"
                                                placeholder="Telephone"
                                        />
                                        <input
                                                type="text"
                                                id="ndriverslicence"
                                                class="fadeIn second"
                                                name="ndriverslicence"
                                                placeholder="N. driver licence"
                                        />
                                        <br><br><label class="form-check-label fadein second" style="color: white">
                                        Expire
                                    </label><br>
                                        <input
                                                type="month"
                                                id="expire"
                                                class="fadeIn second"
                                                name="expire"
                                                placeholder="Month"
                                        /><br><br>
                                        <input
                                                type="text"
                                                id="username"
                                                class="fadeIn second"
                                                name="username"
                                                placeholder="Username"
                                        />
                                        <input
                                                type="password"
                                                id="password1"
                                                class="fadeIn second"
                                                name="password1"
                                                placeholder="Password"
                                        />
                                        <input
                                                type="password"
                                                id="password2"
                                                class="fadeIn second"
                                                name="password2"
                                                placeholder="Repeat password"
                                                style="margin-bottom: 10px"
                                        />
                                        <br><input class="form-check-input" type="checkbox"
                                                   id="flexCheckDefault" onclick="password()"
                                                   style="margin-bottom: 10px"/>
                                        <label class="form-check-label" for="flexCheckDefault"
                                               style="color: white">
                                            Show password
                                        </label><br>
                                        <br>
                                        <label class="form-check-label" style="color: white">
                                            Photo
                                        </label><br>
                                        <input
                                                type="file"
                                                id="photo"
                                                class="form-control fadeIn second"
                                                name="photo"
                                                placeholder="Photo"
                                        />
                                        <br><br><label class="form-check-label" style="color: white">
                                        ID Card
                                    </label><br>
                                        <input
                                                type="file"
                                                id="idcard"
                                                class="form-control fadeIn second"
                                                name="idcard"
                                                placeholder="ID Card"
                                        />
                                    </div>
                                </form>
                                <div class="formFooter">
                                    <a class="underlineHover cursor"
                                       onclick="document.getElementById('formAutista').submit()">Submit</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="hide" id="passeggero">
                        <div class="wrapper fadeIn d-flex justify-content-center height">
                            <div class="formContent">
                                <form action="registrazionePasseggeroCode.jsp" method="post" id="formPasseggero"
                                      enctype="multipart/form-data">
                                    <br/>
                                    <h1
                                            class="fadeIn first"
                                            style="padding-bottom: 18px; color: rgb(97, 95, 133)"
                                    >
                                        Passeggero
                                    </h1>

                                    <div class="overflow-auto reg">
                                        <input
                                                type="text"
                                                id="nameP"
                                                class="fadeIn second"
                                                name="nameP"
                                                placeholder="Name"
                                        />
                                        <input
                                                type="text"
                                                id="surnameP"
                                                class="fadeIn second"
                                                name="surnameP"
                                                placeholder="Surname"
                                        />
                                        <br><br><label class="form-check-label fadein second" style="color: white">
                                        Date of birth
                                    </label><br>
                                        <input class="form-control fadeIn second" type="date" name="dateP"
                                               id="dateP"/><br><br>
                                        <input
                                                type="text"
                                                id="emailP"
                                                class="fadeIn second"
                                                name="emailP"
                                                placeholder="Email"
                                        />
                                        <input
                                                type="text"
                                                id="telephoneP"
                                                class="fadeIn second"
                                                name="telephoneP"
                                                placeholder="Telephone"
                                        /><br><br>
                                        <input
                                                type="text"
                                                id="usernameP"
                                                class="fadeIn second"
                                                name="usernameP"
                                                placeholder="Username"
                                        />
                                        <input
                                                type="password"
                                                id="password1P"
                                                class="fadeIn second"
                                                name="password1P"
                                                placeholder="Password"
                                        />
                                        <input
                                                type="password"
                                                id="password2P"
                                                class="fadeIn second"
                                                name="password2P"
                                                placeholder="Repeat password"
                                                style="margin-bottom: 10px"
                                        />
                                        <br><input class="form-check-input" type="checkbox"
                                                   id="flexCheckDefaultP" onclick="passwordP()"
                                                   style="margin-bottom: 10px"/>
                                        <label class="form-check-label" for="flexCheckDefaultP"
                                               style="color: white">
                                            Show password
                                        </label>
                                        <br><br><label class="form-check-label" style="color: white">
                                        Photo
                                    </label><br>
                                        <input
                                                type="file"
                                                id="photoP"
                                                class="form-control fadeIn second"
                                                name="photoP"
                                                placeholder="Photo"
                                        /><br>
                                    </div>
                                </form>
                                <div class="formFooter">
                                    <a class="underlineHover cursor"
                                       onclick="document.getElementById('formPasseggero').submit()">Submit</a>
                                </div>
                            </div>
                        </div>
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

