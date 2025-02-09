package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;


public class DBManager {

    public static String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    public static String DB_URL = "jdbc:mysql://localhost:3306/keshe";
    public static String USER = "root";
    public static String PASS = "password";

    static {
        try{
            Class.forName(JDBC_DRIVER);
        }catch(ClassNotFoundException e){
            e.printStackTrace();
            System.out.println("驱动注册失败");
        }
    }

    public static Connection getConnection(){
        try{
            Connection connection = DriverManager.getConnection(DB_URL,USER,PASS);
            return connection;
        }catch(SQLException e){
            e.printStackTrace();
            System.out.println("数据库连接失败");
        }
        return null;
    }

    public static void close(Connection connection, Statement statement, ResultSet resultSet){
        try{
            if(resultSet != null){
                resultSet.close();
            }
            if(statement != null){
                statement.close();
            }
            if(connection != null){
                connection.close();
            }
            System.out.println("数据库连接关闭成功");
        }catch(SQLException e){
            e.printStackTrace();
        }
    }

    public static void close(Connection connection,ResultSet resultSet, PreparedStatement preparedStatement){
        try{
            if(preparedStatement != null){
                preparedStatement.close();
            }
            if(connection != null){
                connection.close();
            }
            if(resultSet != null){
                resultSet.close();
            }
            System.out.println("数据库连接关闭成功");
        }catch(SQLException e){
            e.printStackTrace();
        }
    }
}
