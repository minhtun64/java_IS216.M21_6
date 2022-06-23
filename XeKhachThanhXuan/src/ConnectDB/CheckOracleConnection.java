/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ConnectDB;

import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author duyta
 */
public class CheckOracleConnection {
    public static Connection getMyConnection() throws SQLException, ClassNotFoundException
    {
        return OracleConnection.getOracleConnection();
    }
    
    public static void main( String[]args) throws SQLException, ClassNotFoundException
    {
        System.out.println("Get connection...");
        Connection conn = CheckOracleConnection.getMyConnection();
        System.out.println("Get connection " + conn);
        System.out.println ("Done!");
    }
}
 