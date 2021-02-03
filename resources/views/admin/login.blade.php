<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>AdminLTE 3 | Log in</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../admin/AdminLTE/plugins/fontawesome-free/css/all.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- icheck bootstrap -->
    <link rel="stylesheet" href="../../admin/AdminLTE/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../admin/AdminLTE/dist/css/adminlte.min.css">
    <!-- Google Font: Source Sans Pro -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
</head>
<body class="hold-transition login-page">
<div class="login-box">
    <div class="login-logo">
        <a href="../../admin/AdminLTE/../../admin/AdminLTE/index2.html">管理系统</a>
    </div>
    <div class="card">
        <div class="card-body login-card-body">
            <p class="login-box-msg">用户登录</p>
            <form action="./Login" method="post">
                <div class="input-group mb-3">
                    <input type="text" class="form-control" name="loginName" placeholder="name" id="loginName">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-envelope"></span>
                        </div>
                    </div>
                </div>
                <div class="input-group mb-3">
                    <input type="password"  name="loginPwd" class="form-control" placeholder="Password" id="Password">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-lock"></span>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-8">
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" name="validCode" placeholder="验证码">
                            <div class="input-group-append">
                                <div class="input-group-text">
                                    <span class="fas fa-envelope"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-4">
                        <img id="captchImg" src="../../admin/AdminLTE/captche" onclick="refresh();">
                    </div>
                </div>
                <div class="row">
                    <div class="col-4">
                        <button type="button" class="btn btn-primary btn-block" id="login_btn">登录</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- jQuery -->
<script src="../../admin/AdminLTE/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../admin/AdminLTE/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../../admin/AdminLTE/dist/js/adminlte.min.js"></script>

<script>
    $(document).ready(function() {
        $("#login_btn").click(function(){
            var name = $("#loginName").val()
            var password = $("#Password").val()
            if( !name || !password ){
                alert("empty")
                return;
            }


        })

        $.ajax({
            headers: {
                "app-id": "666666"
            },
            //请求方式
            type: requestType,
            //请求的媒体类型
            contentType: isFile ? false : "application/json;charset=UTF-8",
            //请求地址
            async: false,
            url: url,
            //数据，json字符串
            data: isFile ? data : JSON.stringify(data),
            //请求成功
            success: function (result) {
                //console.log(result);
                ajaxData = result;
            },
            //请求失败，包含具体的错误信息
            error: function (e) {
                console.log(e.status);
                console.log(e.responseText);
            }
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

</script>

</body>
</html>
