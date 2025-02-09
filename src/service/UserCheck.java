package service;

import dao.UserDao;

public class UserCheck {
    public boolean checkUser(String username, String password) {
        UserDao userDao = new UserDao();
        return userDao.selectUser(username, password) != null;
    }
}
