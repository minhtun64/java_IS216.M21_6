/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ConnectDB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author duyta
 */
public class OracleConnection {
    
    public static Connection getOracleConnection ()
            throws ClassNotFoundException, SQLException
    {
        
        String hostName = "localhost";
        String sid = "orcl";
        String userName="c##TEST3";
        String password= "Square1";
        
        Class.forName("oracle.jdbc.driver.OracleDriver");
        String connectionURL ="jdbc:oracle:thin:@"+hostName+":1521:"+sid;
        Connection conn = DriverManager.getConnection(connectionURL, userName, password);
        return conn;

            
    }
}