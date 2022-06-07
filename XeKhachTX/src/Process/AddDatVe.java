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
public class AddDatVe {
    public int add_DatVe(int IDVe, int IDNhanVien, String hvt, String sdt,String cmnd,String email) throws SQLException, ClassNotFoundException {
        int count = 1;
        try {
            Connection conn = CheckOracleConnection.getMyConnection();
            String sql = "{call Pro_themdatve_nhanvien(?,?,?,?,?,?)}";
            PreparedStatement ps = conn.prepareStatement(sql);
            CallableStatement caSt = conn.prepareCall(sql);

            caSt.setInt(1, IDVe);
            caSt.setInt(2, IDNhanVien);
            caSt.setString(3, hvt);
            caSt.setString(4, sdt);
            caSt.setString(5, cmnd);
            caSt.setString(6, email);

            count = caSt.executeUpdate();


        } catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }
}
