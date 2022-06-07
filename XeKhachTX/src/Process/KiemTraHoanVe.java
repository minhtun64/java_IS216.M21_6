/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Process;

import Connect_DB.CheckOracleConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author DUNG
 */
public class KiemTraHoanVe {
    public int ktHoanVe(String iddatve)throws SQLException, ClassNotFoundException{
                    int count = 0;
                try{
                    Connection conn = CheckOracleConnection.getMyConnection();
                   
                    String sql = "{call Func_kiemtra_hoanve(?,?}";
                    CallableStatement caSt = conn.prepareCall(sql);
            caSt.setString(1, iddatve);

             count = caSt.executeUpdate();
            
        } catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }
}
