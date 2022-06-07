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
public class DeleteDatVe {
    public int xoaDatVe(int idve) throws SQLException, ClassNotFoundException{
        int count = 1;
        try{
        Connection conn = CheckOracleConnection.getMyConnection();
        String sql ="{call Pro_xoadatve(?)}";
        PreparedStatement ps =conn.prepareStatement(sql);
        CallableStatement caSt = conn.prepareCall(sql);
            caSt.setInt(1, idve);
            count = caSt.executeUpdate();

//            if (!rs.isBeforeFirst()) {
//                count = 0;
//            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }
}
