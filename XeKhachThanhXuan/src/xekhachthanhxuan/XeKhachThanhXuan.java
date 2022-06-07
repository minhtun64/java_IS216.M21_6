/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package xekhachthanhxuan;

import Connect_DB.CheckOracleConnection;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author duyta
 */
public class XeKhachThanhXuan {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
                
                try{
                    Connection conn = CheckOracleConnection.getConnection();
                   
                    String sql = "SELECT * FROM HOANVE";
                    Statement ps =conn.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery(sql);
                    while(rs.next()){
                        System.out.println(rs.getString(1));
                    }
                    
                }catch(SQLException e){
                    System.out.print(e);
                }   
    }
    
}
