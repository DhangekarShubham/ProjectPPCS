<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header>
    <div class="headerpanel">
        <div class="logopanel">
            <h2><a href="dashboard.jsp">Sugar ERP</a></h2>
        </div>
        
        <div class="headerbar">
            <a id="menuToggle" class="menutoggle"><i class="fa fa-bars"></i></a>

            <div class="text-center w-100">
                <h3 class="factory-header-title">Shri. Chhatrapati S.S.K. Ltd, Bhavaninagar</h3>
            </div>

            <div class="header-right d-flex align-items-center pe-4">
                <a href="#" class="text-white me-4 position-relative" style="font-size: 18px;">
                    <i class="fa fa-bell"></i>
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.6rem;">3</span>
                </a>
                
                <div class="dropdown">
                    <a href="#" class="d-flex align-items-center text-decoration-none text-white dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false" style="font-size: 13px; font-weight: 600;">
                        <span class="me-2 text-uppercase"><%= session.getAttribute("username") != null ? session.getAttribute("username") : "Admin" %></span>
                        <img src="assets/images/photos/loggeduser.png" alt="User" class="rounded-circle" width="32" height="32" onerror="this.src='https://ui-avatars.com/api/?name=Admin&background=259dab&color=fff';">
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                        <li><a class="dropdown-item" href="#"><i class="fa fa-user me-2 text-muted"></i> My Profile</a></li>
                        <li><a class="dropdown-item ajax-link" href="change_password.jsp"><i class="fa fa-lock me-2 text-muted"></i> Change Password</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="logout.jsp"><i class="fa fa-sign-out me-2"></i> Log Out</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</header>