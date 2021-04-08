<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>LOGIN</title>

    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../admin/AdminLTE/plugins/fontawesome-free/css/all.min.css">
    <!-- icheck bootstrap -->
    <link rel="stylesheet" href="http://127.0.0.1/admin/AdminLTE/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="http://127.0.0.1/admin/AdminLTE/dist/css/adminlte.min.css">
</head>
<body class="hold-transition login-page">
<div class="login-box">

    <div class="login-logo">
        <a href="../../index2.html">LOGIN</a>
    </div>

    <!-- /.login-logo -->
    <div class="card">
        <div class="card-body login-card-body">
            <p class="login-box-msg">Sign in to start your session</p>

            <form action="../../index3.html" method="post" id="form1">
                <div class="input-group mb-3">
                    <input type="email" class="form-control" placeholder="Email" id="loginName" name="loginName">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-envelope"></span>
                        </div>
                    </div>
                </div>
                <div class="input-group mb-3">
                    <input type="password" class="form-control" placeholder="Password" id="Password" name="Password">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-lock"></span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-8">
                        <div class="icheck-primary">
                            <input type="checkbox" id="remember">
                            <label for="remember">
                                Remember Me
                            </label>
                        </div>
                    </div>
                    <!-- /.col -->
                    <div class="col-4">
                        <button type="button" class="btn btn-primary btn-block" id="login_btn" data-toggle="modal" >Sign In</button>
                    </div>
                    <!-- /.col data-target="#myModal" -->
                </div>
            </form>

            <div class="social-auth-links text-center mb-3">
                <p>- OR -</p>
                <a href="#" class="btn btn-block btn-primary">
                    <i class="fab fa-facebook mr-2"></i> Sign in using Facebook
                </a>
                <a href="#" class="btn btn-block btn-danger">
                    <i class="fab fa-google-plus mr-2"></i> Sign in using Google+
                </a>
            </div>
            <!-- /.social-auth-links -->

            <p class="mb-1">
                <a href="forgot-password.html">I forgot my password</a>
            </p>
            <p class="mb-0">
                <a href="register.html" class="text-center">Register a new membership</a>
            </p>
        </div>
        <!-- /.login-card-body -->
    </div>
    {{--<x-alert message="xxxx" type="alert"/>--}}

</div>
<!-- /.login-box -->
<!-- Button trigger modal -->

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                ...
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>
<!-- jQuery -->
<script src="http://127.0.0.1/admin/AdminLTE/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="http://127.0.0.1/admin/AdminLTE/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="http://127.0.0.1/admin/AdminLTE/dist/js/adminlte.min.js"></script>

<SCRIPT>
    $(document).ready(function() {
        /**
         * 登录
         */
        $("#login_btn").click(function(){
            var name = $("#loginName").val()
            var password = $("#Password").val()

            if( !name || !password ){
                //alert("name or password is empty")

                $('#exampleModal').modal('show')
                // $('#exampleModal').on('show.bs.modal', function (e) {
                //     // do something...
                //     alert("name or password is empty")
                // })
                return;
            }
            $.ajax({
                //请求方式
                type: 'POST',
                //请求的媒体类型
                datatype:  'json',
                //请求地址
                async: false,
                url: 'http://127.0.0.1/admin/login_do',
                //数据，json字符串
                data: $('#form1').serialize(),
                //data:'111',
                //请求成功
                success: function (result) {
                    //console.log(result);
                    ajaxData = result;
                    document.location.reload();
                },
                //请求失败，包含具体的错误信息
                error: function (e) {
                    console.log(e.status);
                    console.log(e.responseText);
                }
            })
        })
        //
        function upload(obj){
            var files = obj.files ;
            var formData = new FormData();
            for(var i = 0;i<files.length;i++){
                //alert(files[i])
                formData.append("file", files[i]);
            }
            upObject = formData
            //alert(formData)
            // $.ajax({
            //     url: "1.php",
            //     type: "POST",
            //     data:formData,
            //     cache:false,         //不设置缓存
            //     processData: false,  // 不处理数据
            //     contentType: false   // 不设置内容类型
            // });
        }
    })
</SCRIPT>

</body>
</html>
