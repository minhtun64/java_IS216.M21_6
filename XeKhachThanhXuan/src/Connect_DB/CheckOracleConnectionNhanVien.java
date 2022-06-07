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
public class CheckOracleConnectionNhanVien {
    public static Connection getMyConnectionNhanVien() throws SQLException, ClassNotFoundException
    {
        return OracleConnection.getOracleConnectionNhanVien();
    }
    
    public static void main( String[]args) throws SQLException, ClassNotFoundException
    {
        System.out.println("Get connection...");
        Connection conn = CheckOracleConnection.getMyConnection();
        System.out.println("Get connection " + conn);
        System.out.println ("Done!");
    }
}
