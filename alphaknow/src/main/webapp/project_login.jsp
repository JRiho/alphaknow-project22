<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE jsp>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>로그인 페이지</title>
    <script src="js/loginScript.js"></script>
</head>

<style>
    body {
        margin: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        font-family: 'Malgun Gothic', 'Nanum Gothic', 'Gothic', sans-serif;
    }

    .screen {
        width: 1000px;
        height: 400px;
        text-align: center;
        margin-top: 300px;
    }

    .login_type {
        position: relative;
    }

    .login_type ul {
        margin: 0;
        padding: 0;
    }

    .login_type ul li {
        display: inline-block;
    }

    .inactive:hover {
        background: #cfcfcf;
        color: #777;
        border: 1px solid #bfbfbf;
        cursor: pointer;
    }

    .active {
        text-decoration: none;
        display: block;
        font-size: 12px;
        width: 180px;
        height: 19px;
        background: #fff;
        font-weight: 550;
        color: #777;
        border: 1px solid #dadada;
        cursor: pointer;
        text-align: center;
        line-height: 19px;
        border-radius: 15px;
    }

    .inactive {
        text-decoration: none;
        display: block;
        font-size: 12px;
        width: 180px;
        height: 19px;
        border: 1px solid #bfbfbf;
        text-align: center;
        line-height: 19px;
        background-color: #dadada;
        color: #777;
        border-radius: 15px;
    }

    #id_login {
        display: block;
    }

    #login {
        display: inline-block;
    }

    #id,
    #pass {
        width: 300px;
        height: 35px;
        margin-top: 40px;
        border-top: 0px;
        border-left: 0px;
        border-right: 0px;
        border-bottom: 1px solid #dadada;
        outline: none;
        text-indent: 40px;
    }

    #login_btn {
        float: right;
        margin-left: 50px;
        margin-top: 40px;
        border: 0px;
        width: 120px;
        height: 120px;
        font-weight: bold;
        border-radius: 10px;
        padding-top: 5px;
        padding-bottom: 5px;
        background-color: #1abc9c;
        color: white;
        font-size: 18px;
        cursor: pointer;
    }

    #login_btn:hover {
        background-color: #15a084;
    }

    input::placeholder {
        color: #bbbbbb;
        text-indent: 40px;
    }

    .chkbox {
        margin-top: 50px;
    }

    #findPass {
        border: 0;
        background-color: white;
        margin-left: 29%;
        text-decoration: none;
        color: #aaaaaa;
        cursor: pointer;
        font-size: 1em;
    }

    .id_container {
        position: relative;
        display: inline-block;
    }

    .id_container img {
        position: absolute;
        top: 70%;
        width: 40px;
        height: 40px;
        transform: translateY(-50%);
    }

    .pass_container {
        position: relative;
        display: inline-block;
    }

    .pass_container img {
        position: absolute;
        top: 70%;
        width: 40px;
        height: 40px;
        transform: translateY(-50%);
    }

    #qr_login {
        display: none;
        text-align: center;
        margin-top: 2%;
    }

    #qr_login img {
        background-color: #fff;
        width: 300px;
        height: 300px;
    }
</style>

<body width="100%">
    <div class="screen">
        <!-- 로그인 타입 선택; id/qr -->
        <div class="login_type">
            <ul>
                <li><a id="loginType_id" class="active">ID 로그인</a></li>
                <li><a id="loginType_qr" class="inactive">QR 로그인</a></li>
            </ul>
        </div>
        <div id="id_login">
            <!-- 아이디 및 비밀번호 입력 -->
            <div id="login">
                <div>
                    <div class="id_container">
                        <img src="img/id_icon.png" ondragstart="return false;">
                        <input type="text" name="userid" placeholder="아이디" id="id">
                    </div>
                    <!-- 로그인 버튼 -->
                    <input type="button" id="login_btn" value="로그인" 
                    onclick="login()" tabindex="-1">
                </div>
                <div class="pass_container">
                    <img src="img/pass_icon.png" ondragstart="return false;">
                    <input type="password" name="userpass" placeholder="비밀번호" id="pass">
                </div>
            </div>

            <div class="chkbox">
                <!-- id저장 -->
                <input type="checkbox" name="save" value="id저장">ID저장
                <!-- 비밀번호 찾기 -->
                <button type="button" id="findPass" onclick="openPopup()">비밀번호 찾기</button>
            </div>
        </div>

        <div id="qr_login">
            <img src="img/qrcode.png">
            <p>QR코드를 스캔해주세요.</p>
        </div>

    </div>
</body>

</html>