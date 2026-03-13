package com.twd.sugarfactory.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.twd.sugarfactory.model.UserBean;
import com.twd.sugarfactory.service.LoginServiceImpl;
import com.twd.sugarfactory.serviceinterface.LoginService;



// Maps the servlet to the /login action from the JSP form
@WebServlet("/login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private LoginService loginService;

    public void init() {
        // Initialize the service layer
        loginService = new LoginServiceImpl();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. Retrieve data from the JSP form
        String uName = request.getParameter("username");
        String pWord = request.getParameter("password");
        String yCode = request.getParameter("yearCode");
        
        // 2. Populate the Bean Model
        UserBean user = new UserBean();
        user.setUsername(uName);
        user.setPassword(pWord);
        user.setYearCode(yCode);
        
        // 3. Pass to Service Layer for Validation
        boolean isValid = loginService.authenticateUser(user);
        
        // 4. Handle Routing based on result
        HttpSession session = request.getSession();
        
        if (isValid) {
            // Login Success: Save user info in session and redirect to dashboard
            session.setAttribute("loggedUser", uName);
            session.setAttribute("seasonYear", yCode);
            response.sendRedirect("dashboard.jsp"); // Create this JSP next!
        } else {
            // Login Failed: Set error and send back to login page
            session.setAttribute("login_error", "Invalid Username or Password!");
            response.sendRedirect("index.jsp");
        }
    }
}