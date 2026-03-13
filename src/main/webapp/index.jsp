<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="loginApp">
<head>
    <meta charset="UTF-8">
    <title>Shri. Chhatrapati S.S.K. Ltd - Login</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    
    <script src="js/loginApp.js"></script>

    <style>
        /* CSS to mimic the photo you uploaded */
        body, html {
            height: 100%;
            margin: 0;
            font-family: Arial, sans-serif;
        }
        .signwrapper {
            background-image: url('images/background.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }
        .sign-overlay {
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background-color: rgba(0, 0, 0, 0.5); /* Dark overlay to make panel pop */
            z-index: 1;
        }
        .panel.signin {
            position: relative;
            z-index: 2;
            width: 350px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 8px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.5);
            overflow: hidden;
            border: none;
        }
        .panel-heading {
            background-color: #2c3e50; /* Factory theme dark blue */
            padding: 20px;
            text-align: center;
            color: white;
        }
        .panel-title {
            margin-top: 10px;
            font-size: 16px;
        }
        .panel-body {
            padding: 25px;
        }
        .input-group-addon {
            background-color: #eee;
            color: #555;
        }
        .mb10 { margin-bottom: 15px; }
        .nomargin { margin-bottom: 10px; }
        .forgot {
            display: block;
            text-align: right;
            font-size: 12px;
            margin-bottom: 15px;
            color: #337ab7;
        }
        .btn-quirk {
            background-color: #27ae60;
            color: white;
            font-weight: bold;
            transition: all 0.3s;
        }
        .btn-quirk:hover {
            background-color: #219150;
        }
        .error-msg {
            color: red;
            font-size: 14px;
            text-align: center;
            display: block;
            margin-top: 10px;
        }
    </style>
</head>

<body class="signwrapper" ng-controller="LoginController">
    <div class="sign-overlay"></div>
    
    <div class="panel signin">
        <div class="panel-heading">
            <img alt="Factory Logo" src="images/logo.png" class="img-responsive" style="margin: 0 auto; max-height: 60px;">   
            <h4 class="panel-title">Welcome! Please sign in.</h4>
        </div>
        <div class="panel-body">
            <form action="login" method="POST" name="loginForm" ng-submit="validateForm($event)">
                <div class="form-group mb10">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                        <input type="text" name="username" ng-model="user.username" class="form-control" placeholder="Enter Username" required>
                    </div>
                </div>
                <div class="form-group mb10">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                        <input type="password" name="password" ng-model="user.password" class="form-control" placeholder="Enter Password" required>
                    </div>
                </div>
                <div class="form-group nomargin">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                        <input type="text" id="vyearCode" name="yearCode" ng-model="user.yearCode" class="form-control" placeholder="Enter Year (e.g., 2025-2026)">
                    </div>
                </div>
                <div><a href="#" class="forgot">Forgot password?</a></div>
                <div class="form-group">
                    <button type="submit" class="btn btn-success btn-quirk btn-block">Sign In</button>
                </div>
            </form>
            
            <% if(session.getAttribute("login_error") != null) { %>
                <span class="error-msg"><%=session.getAttribute("login_error")%></span>
                <% session.removeAttribute("login_error"); %> <% } %>
            
            <span class="error-msg" ng-show="clientError">{{clientError}}</span>
        </div>
    </div>
</body>
</html>