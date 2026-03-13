package com.twd.sugarfactory.serviceinterface;

import com.twd.sugarfactory.model.UserBean;

public interface LoginService {
    public boolean authenticateUser(UserBean user);
}
