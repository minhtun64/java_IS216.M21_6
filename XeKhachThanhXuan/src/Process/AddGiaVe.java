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
public class AddGiaVe {

//    public int add_GiaVe(int IDLoaiXe, int IDTuyenXe, String GiaVe) throws SQLException, ClassNotFoundException {
//        int count = 1;
//        try {
//            Connection conn = CheckOracleConnection.getMyConnection();
//            String sql = "{call Pro_themgiave(?,?,?)}";
//            PreparedStatement ps = conn.prepareStatement(sql);
//            CallableStatement caSt = conn.prepareCall(sql);
//            caSt.setInt(1, IDLoaiXe);
//            caSt.setInt(2, IDTuyenXe);
//            caSt.setString(3, GiaVe);
//            count = caSt.executeUpdate();
//        } catch (Exception e) {
//            System.out.println(e);
//        }
//        return count;
//    }
        public int add_GiaVe(int IDLoaixe, int IDTuyenxe, String GiaVe) {
        int count = 1;
        try {
            Connection conn = CheckOracleConnection.getMyConnection();
            String strCall = "{call Pro_themgiave(?,?,?)}";
            CallableStatement caSt = conn.prepareCall(strCall);
            caSt.setInt(1, IDLoaixe);
            caSt.setInt(2, IDTuyenxe);
            caSt.setString(3, GiaVe);

            count = caSt.executeUpdate();


        } catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }
}
