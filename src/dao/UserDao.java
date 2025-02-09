package dao;

import service.UserRegister;
import util.DBManager;
import vo.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {
    public user selectUser(String username, String password) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        user user = new user();
        String sql = "select * from user where username=? and password=?";
        try{
            conn = DBManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1,username);
            ps.setString(2,password);
            rs = ps.executeQuery();
            if(rs.next()){
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                DBManager.close(conn,rs,ps);
                return user;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    public boolean selectByUsername(String username) {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "select * from user where username=?";
        boolean flag = false;
        try{
            conn = DBManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1,username);
            rs = ps.executeQuery();
            if(rs.next()){
                flag = true;
                DBManager.close(conn,rs,ps);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return flag;
    }

    public boolean insertUser(String username, String password,String email) {
        Connection conn = null;
        PreparedStatement ps = null;
        boolean flag = false;
        UserDao userDao = new UserDao();
        if(userDao.selectByUsername(username)) return false;
        String sql = "insert into user(username,password,email) values(?,?,?)";
        try{
            conn = DBManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1,username);
            ps.setString(2,password);
            ps.setString(3,email);
            int t = ps.executeUpdate();
            flag = t > 0;
            conn.close();
            ps.close();
        }catch (SQLException e){
            throw new RuntimeException(e);
        }
        return flag;
    }
}
