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
    <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Pacifico"/>

    <title>Car Pooling</title>
</head>

<script type="text/javascript">
    function show_password() {
        if (document.getElementById('password').getAttribute('type') === 'password') {
            document.getElementById('password').setAttribute('type', 'text')
        } else {
            document.getElementById('password').setAttribute('type', 'password')
        }
    }
</script>

<body>
<div class="bg-image">
    <div class="overflow-auto cont">
        <div class="container">
            <div class="row gy-5 ">
                <div class="col-lg d-flex justify-content-center align-items-center fadeIn third height login">
                    <div class="animated-text b1">Travel</div>
                    <div class="animated-text b2">Share</div>
                    <div class="animated-text b3">Pooling</div>
                </div>
                <div class="col-lg d-flex justify-content-center height login">
                    <div class="wrapper fadeInDown">
                        <div class="formContent">
                            <!-- Login Form -->
                            <form method="post" action="loginCode.jsp">
                                <br/>
                                <input
                                        type="text"
                                        id="username"
                                        class="fadeIn second"
                                        name="username"
                                        placeholder="Username"
                                />
                                <input
                                        type="password"
                                        id="password"
                                        class="fadeIn third"
                                        name="password"
                                        placeholder="Password"
                                />
                                <input
                                        type="submit"
                                        class="fadeIn fourth"
                                        value="Log In"
                                />
                                <br><input class="form-check-input fadeIn fourth" type="checkbox"
                                           id="flexCheckDefault" onclick="show_password()"
                                           style="margin-bottom: 10px"/>
                                <label class="form-check-label fadeIn fourth" for="flexCheckDefault"
                                       style="color: white">
                                    Show password
                                </label><br>
                            </form>

                            <!-- Remind Passowrd -->
                            <div class="formFooter">
                                <a class="underlineHover" href="../registration/"
                                   style="padding-right: 15px;">Register</a>
                                <a class="underlineHover" href="../recuperoPassword/">Forgot
                                    Password?</a>
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
