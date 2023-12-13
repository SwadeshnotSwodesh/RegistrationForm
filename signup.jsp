<%-- 
    Document   : signup
    Created on : 9 Nov 2023, 13:35:58
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>


        <!-- Compiled and minified CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

        <!-- Compiled and minified JavaScript -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

    </head>
    <body style="background: url(img/IMG_1391.jpg);background-size: cover;background-attachment: fixed;">


        <div class="container">

            <div class="row">
                <div class="col m6 offset-m3">

                    <div class="card">
                        <div class="card-content">
                            <h3 style="margin-top: 10px;" class="center-align">Register here!!!</h3>


                            <h5 id="msg" class="center-align"></h5>


                            <div class="form center-align">
                                <!--//creating form-->
                                <form action="Register" method="post" id="myform">
                                    <input type="text" name="user_name" placeholder="Enter user name">
                                    <input type="password" name="user_password" placeholder="Enter user password">
                                    <input type="email" name="user_email" placeholder="Enter user email">

                                    <div class="file-field input-field">
                                        <div class="btn">
                                            <span>File</span>
                                            <input type="file" name="user_image">
                                        </div>
                                        <div class="file-path-wrapper">
                                            <input class="file-path validate" type="text">
                                        </div>
                                    </div>


                                    <button type="submit" class="btn cyan">Submit</button>
                                </form>                                

                            </div>

                            <div class="loader center-align" style="margin-top:10px; display: none;">

                                <div class="preloader-wrapper big active">
                                    <div class="spinner-layer spinner-blue">
                                        <div class="circle-clipper left">
                                            <div class="circle"></div>
                                        </div><div class="gap-patch">
                                            <div class="circle"></div>
                                        </div><div class="circle-clipper right">
                                            <div class="circle"></div>
                                        </div>
                                    </div>

                                    <div class="spinner-layer spinner-red">
                                        <div class="circle-clipper left">
                                            <div class="circle"></div>
                                        </div><div class="gap-patch">
                                            <div class="circle"></div>
                                        </div><div class="circle-clipper right">
                                            <div class="circle"></div>
                                        </div>
                                    </div>

                                    <div class="spinner-layer spinner-yellow">
                                        <div class="circle-clipper left">
                                            <div class="circle"></div>
                                        </div><div class="gap-patch">
                                            <div class="circle"></div>
                                        </div><div class="circle-clipper right">
                                            <div class="circle"></div>
                                        </div>
                                    </div>

                                    <div class="spinner-layer spinner-green">
                                        <div class="circle-clipper left">
                                            <div class="circle"></div>
                                        </div><div class="gap-patch">
                                            <div class="circle"></div>
                                        </div><div class="circle-clipper right">
                                            <div class="circle"></div>
                                        </div>
                                    </div>
                                </div>

                                <h5>Please wait...</h5>


                            </div>
                        </div>
                    </div>
                </div>

            </div>


        </div>


        <script
            src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
        crossorigin="anonymous"></script>


        <script>
            $(document).ready(function ()
            {
                console.log("Page is ready...")

                $("#myform").on('submit', function (event) {
                    event.preventDefault();//this stops to go to another page

                   // var f = $(this).serialize();//this only works for the text data but not for image data
                   
                   let f=new FormData(this);//this is for the image

                   

                    console.log(f);

                    $(".loader").show();
                    $(".form").hide();

                    $.ajax(
                            {
                                url: "Register",
                                data: f,
                                type: 'POST',
                                success: function (data, textStatus, jqXHR) {

                                    console.log(data);
                                    console.log("Success...")
                                    $(".loader").hide();
                                    $(".form").show();

                                    if (data.trim()==='Done...')//the message here plays a crucial role for the printing in the Register.java
                                    {
                                        $('#msg').html("Successfully Registered!!!")
                                        $('#msg').addClass('green-text')
                                    } else
                                    {
                                        $('#msg').html("Something went wrong on server...")
                                        $('#msg').addClass('red-text')//this is for making the text red color
                                    }


                                },
                                error: function (jqXHR, textStatus, errorThrown)
                                {
                                    console.log(jqXHR.responseText);
                                    console.log("error...")
                                    $(".loader").hide();
                                    $(".form").show();
                                    $('#msg').html("Something went wrong on server!!!")
                                    $("#msg").addClass('red-text')

                                },
                                processData:false,
                                contentType:false
                            });
                });

            }
            );
        </script>
    </body>
</html>
