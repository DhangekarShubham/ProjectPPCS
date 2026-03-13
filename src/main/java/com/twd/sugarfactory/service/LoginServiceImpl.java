package com.twd.sugarfactory.service;

import com.twd.sugarfactory.dao.LoginDao;
import com.twd.sugarfactory.model.UserBean;
import com.twd.sugarfactory.serviceinterface.LoginService;

public class LoginServiceImpl implements LoginService {
    
    // Instantiate the DAO
    private LoginDao loginDao = new LoginDao();

    @Override
    public boolean authenticateUser(UserBean user) {
        // Business logic could go here (e.g., checking if the yearCode matches active seasons)
        // For now, we just pass to DAO
        return loginDao.validate(user);
    }
}