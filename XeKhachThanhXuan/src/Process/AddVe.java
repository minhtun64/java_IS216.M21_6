/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Process;

import Connect_DB.CheckOracleConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author DUNG
 */
public class AddVe {
     public int themVe(String idhk, String idcx, String idve , String hovaten, String sodt, String cmnd, String email) throws SQLException, ClassNotFoundException{
        int count = 1;
        try{
        Connection conn = CheckOracleConnection.getMyConnection();
        String sql ="{call Pro_themdatve_khachhang(?,?,?,?,?,?,?)}";
        PreparedStatement ps =conn.prepareStatement(sql);
        CallableStatement caSt = conn.prepareCall(sql);

            caSt.setString(1, idhk);
            caSt.setString(2, idcx);
            caSt.setString(3, idve);
            caSt.setString(4, hovaten);
            caSt.setString(5, sodt);
            caSt.setString(6, cmnd);
            caSt.setString(7, email);
            


            ResultSet rs = caSt.executeQuery();

            if (!rs.isBeforeFirst()) {
                count = 0;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }
}
