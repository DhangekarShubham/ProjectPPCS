<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Change Password - Plant Control System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #fdf5e6; }
        .app-window { border: 2px solid #888; border-radius: 5px; background-color: #fff; margin-top: 20px; box-shadow: 0px 4px 8px rgba(0,0,0,0.2); }
        .window-header { background-color: #dcdcdc; padding: 5px 15px; font-weight: bold; border-bottom: 1px solid #888; color: #b22222; text-transform: uppercase; }
        .sidebar-panel { background-color: #d8bfd8; padding: 20px; min-height: 400px; border-right: 2px solid #888; }
        .main-panel { background-color: #87cefa; padding: 30px; display: flex; align-items: center; justify-content: center; }
        .action-btn { width: 100%; margin-bottom: 15px; background-color: #f8f9fa; border: 1px solid #999; box-shadow: 1px 1px 3px rgba(0,0,0,0.2); font-weight: bold; color: #333; }
        .action-btn:hover { background-color: #e2e6ea; }
        
        /* Form Specific Styling */
        .password-box { background-color: rgba(255,255,255,0.8); border: 1px solid #999; border-radius: 5px; padding: 30px; width: 100%; max-width: 500px; box-shadow: 0px 4px 6px rgba(0,0,0,0.1); }
        .input-label { font-size: 0.95rem; font-weight: bold; color: #333; }
    </style>
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <div class="container-fluid px-4 mb-5">
        <a href="dashboard.jsp" class="btn btn-sm btn-outline-dark mt-2">&larr; Back to Dashboard</a>
        <div class="row app-window mx-2">
            <div class="window-header">USER SECURITY - CHANGE PASSWORD</div>
            <div class="row m-0 p-0">
                
                <div class="col-md-2 sidebar-panel">
                    <button type="button" class="btn action-btn mt-2" onclick="submitPasswordForm()">Save</button>
                    <button type="button" class="btn action-btn" onclick="document.getElementById('pwdForm').reset();">Cancel</button>
                    <a href="dashboard.jsp" class="btn action-btn mt-5">Close</a>
                </div>

                <div class="col-md-10 main-panel">
                    
                    <div class="password-box">
                        <h5 class="text-center text-primary mb-4 border-bottom pb-2">Update Credentials</h5>
                        
                        <% 
                            String message = (String) request.getAttribute("message");
                            if(message != null) { 
                        %>
                            <div class="alert alert-info py-2 text-center" role="alert">
                                <%= message %>
                            </div>
                        <% } %>

                        <form action="ChangePasswordServlet" method="POST" id="pwdForm">
                            
                            <div class="row mb-3 align-items-center">
                                <label class="col-sm-5 text-end input-label">Username :</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control form-control-sm bg-light" name="username" 
                                           value="<%= session.getAttribute("username") != null ? session.getAttribute("username") : "Admin" %>" readonly>
                                </div>
                            </div>
                            
                            <hr class="my-3 text-muted">

                            <div class="row mb-3 align-items-center">
                                <label class="col-sm-5 text-end input-label">Old Password :</label>
                                <div class="col-sm-7">
                                    <input type="password" class="form-control form-control-sm" id="oldPwd" name="oldPassword" required>
                                </div>
                            </div>
                            
                            <div class="row mb-3 align-items-center">
                                <label class="col-sm-5 text-end input-label">New Password :</label>
                                <div class="col-sm-7">
                                    <input type="password" class="form-control form-control-sm" id="newPwd" name="newPassword" required>
                                </div>
                            </div>

                            <div class="row mb-3 align-items-center">
                                <label class="col-sm-5 text-end input-label">Confirm Password :</label>
                                <div class="col-sm-7">
                                    <input type="password" class="form-control form-control-sm" id="confirmPwd" name="confirmPassword" required>
                                </div>
                            </div>
                            
                            <button type="submit" id="hiddenSubmit" style="display: none;"></button>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function submitPasswordForm() {
            const oldPwd = document.getElementById('oldPwd').value;
            const newPwd = document.getElementById('newPwd').value;
            const confirmPwd = document.getElementById('confirmPwd').value;

            if (!oldPwd || !newPwd || !confirmPwd) {
                alert("Please fill in all password fields.");
                return;
            }

            if (newPwd !== confirmPwd) {
                alert("New Password and Confirm Password do not match!");
                document.getElementById('confirmPwd').focus();
                return;
            }
            
            if (oldPwd === newPwd) {
                alert("New Password cannot be the same as the Old Password.");
                document.getElementById('newPwd').focus();
                return;
            }

            // If everything is valid, submit the form
            document.getElementById('hiddenSubmit').click();
        }
    </script>
</body>
</html>