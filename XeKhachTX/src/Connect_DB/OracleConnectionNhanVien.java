/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Connect_DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author DUNG
 */
public class OracleConnectionNhanVien {
        public static Connection getOracleConnection2 ()
            throws ClassNotFoundException, SQLException
    {
        String hostName = "localhost";
        String sid = "orcl";
        String userName="NHANVIEN";
        String password= "nhanvien";
        
        Class.forName("oracle.jdbc.driver.OracleDriver");
        String connectionURL ="jdbc:oracle:thin:@"+hostName+":1521:"+sid;
        Connection conn = DriverManager.getConnection(connectionURL, userName, password);
        return conn;
    }
}
