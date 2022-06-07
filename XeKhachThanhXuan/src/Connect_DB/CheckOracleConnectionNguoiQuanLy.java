/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Connect_DB;

import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author DUNG
 */
public class CheckOracleConnectionNguoiQuanLy {
        public static Connection getMyConnectionNguoiQuanLy() throws SQLException, ClassNotFoundException
    {
        return OracleConnection.getOracleConnectionNguoiQuanLy();
    }
    
    public static void main( String[]args) throws SQLException, ClassNotFoundException
    {
        System.out.println("Get connection...");
        Connection conn = CheckOracleConnection.getMyConnection();
        System.out.println("Get connection " + conn);
        System.out.println ("Done!");
    }
}
