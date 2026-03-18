<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- Shubham -->
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Security Settings | Sugar ERP</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        :root {
            --primary-blue: #2563eb;
            --sidebar-dark: #1e293b;
            --bg-light: #f1f5f9;
            --border-color: #e2e8f0;
            --text-dark: #1e293b;
        }

        body { 
            background-color: var(--bg-light); 
            font-family: 'Inter', sans-serif; 
            color: var(--text-dark);
        }

        /* Unified App Window */
        .app-window { 
            background: #ffffff; 
            border-radius: 12px; 
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            margin-top: 30px;
            border: none;
        }

        .window-header { 
            background-color: #ffffff; 
            padding: 18px 25px; 
            font-weight: 700; 
            border-bottom: 1px solid var(--border-color); 
            color: var(--text-dark);
            display: flex;
            align-items: center;
        }
        
        .window-header i { color: var(--primary-blue); margin-right: 12px; }

        /* Dark Industry Sidebar */
        .sidebar-panel { 
            background-color: var(--sidebar-dark); 
            padding: 25px 15px; 
            min-height: 450px; 
        }

        .action-btn { 
            width: 100%; 
            margin-bottom: 12px; 
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1); 
            color: #cbd5e1;
            text-align: left;
            padding: 10px 15px;
            font-weight: 500;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            border-radius: 8px;
        }
        
        .action-btn i { margin-right: 10px; font-size: 1.1rem; }

        .action-btn:hover { 
            background-color: var(--primary-blue); 
            color: #ffffff;
            transform: translateX(5px);
        }

        /* Centered Security Form */
        .main-panel { background-color: #ffffff; padding: 40px; }

        .password-card { 
            background: #ffffff; 
            border: 1px solid var(--border-color); 
            border-radius: 12px; 
            padding: 35px; 
            width: 100%; 
            max-width: 550px; 
            box-shadow: 0 4px 12px rgba(0,0,0,0.03);
        }

        .input-label { 
            font-size: 0.85rem; 
            font-weight: 600; 
            color: #475569; 
            margin-bottom: 5px;
        }

        .form-control {
            border-radius: 8px;
            padding: 10px 15px;
            border: 1px solid #d1d5db;
        }

        .form-control:focus {
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1);
            border-color: var(--primary-blue);
        }

        .username-field { background-color: #f8fafc !important; font-weight: 600; color: var(--primary-blue); }

        .security-note { font-size: 0.8rem; color: #64748b; margin-top: 15px; }
    </style>
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <div class="container px-5">
        <div class="row app-window">
            <div class="window-header">
                <i class="bi bi-shield-lock-fill"></i> USER SECURITY - CREDENTIALS MANAGEMENT
            </div>
            
            <div class="d-flex p-0">
                <div class="sidebar-panel" style="width: 220px;">
                    <button type="button" class="btn action-btn" onclick="submitPasswordForm()">
                        <i class="bi bi-check-circle"></i> Save Changes
                    </button>
                    <button type="button" class="btn action-btn" onclick="document.getElementById('pwdForm').reset();">
                        <i class="bi bi-arrow-counterclockwise"></i> Reset Form
                    </button>
                    <a href="dashboard.jsp" class="btn action-btn mt-5 bg-danger text-white border-0">
                        <i class="bi bi-box-arrow-left"></i> Exit Security
                    </a>
                </div>

                <div class="flex-grow-1 main-panel d-flex justify-content-center">
                    
                    <div class="password-card">
                        <div class="text-center mb-4">
                            <div class="icon-circle mb-3 mx-auto bg-primary bg-opacity-10 text-primary rounded-circle d-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                                <i class="bi bi-key-fill fs-3"></i>
                            </div>
                            <h5 class="fw-bold">Update Password</h5>
                            <p class="text-muted small">Manage your account access and security</p>
                        </div>
                        
                        <% 
                            String message = (String) request.getAttribute("message");
                            if(message != null) { 
                        %>
                            <div class="alert alert-info border-0 rounded-3 small py-2 text-center" role="alert">
                                <i class="bi bi-info-circle me-2"></i> <%= message %>
                            </div>
                        <% } %>

                        <form action="ChangePasswordServlet" method="POST" id="pwdForm">
                            
                            <div class="mb-3">
                                <label class="input-label">Username</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-white border-end-0 text-muted"><i class="bi bi-person"></i></span>
                                    <input type="text" class="form-control border-start-0 username-field" name="username" 
                                           value="<%= session.getAttribute("username") != null ? session.getAttribute("username") : "Admin" %>" readonly>
                                </div>
                            </div>
                            
                            <hr class="my-4 opacity-50">

                            <div class="mb-3">
                                <label class="input-label">Old Password</label>
                                <input type="password" class="form-control" id="oldPwd" name="oldPassword" placeholder="••••••••" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="input-label">New Password</label>
                                <input type="password" class="form-control" id="newPwd" name="newPassword" placeholder="••••••••" required>
                            </div>

                            <div class="mb-3">
                                <label class="input-label">Confirm New Password</label>
                                <input type="password" class="form-control" id="confirmPwd" name="confirmPassword" placeholder="••••••••" required>
                            </div>
                            
                            <div class="security-note d-flex align-items-start">
                                <i class="bi bi-exclamation-triangle-fill me-2 text-warning"></i>
                                <span>Password must be updated periodically for security compliance.</span>
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

            // Simple validations for professional feel
            if (!oldPwd || !newPwd || !confirmPwd) {
                alert("All password fields are required.");
                return;
            }

            if (newPwd !== confirmPwd) {
                alert("Passwords do not match!");
                return;
            }
            
            if (oldPwd === newPwd) {
                alert("The new password must be different from the current one.");
                return;
            }

            document.getElementById('hiddenSubmit').click();
        }
    </script>
</body>
</html>