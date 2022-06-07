/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Process;

import Connect_DB.CheckOracleConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

/**
 *
 * @author DUNG
 */
public class EditDatVe {
    public int ThanhToan_DatVe(int IDve) {
        int count = 1;
        try {
            Connection conn = CheckOracleConnection.getMyConnection();
            String strCall = "{call Pro_thanhtoanve(?)}";
            CallableStatement caSt = conn.prepareCall(strCall);
            caSt.setInt(1, IDve);
            ResultSet rs = caSt.executeQuery();

            if (!rs.isBeforeFirst()) {
                count = 0;
            }

//            Statement stat = con.createStatement();
//            i = stat.executeUpdate(query);
        } catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }
}
