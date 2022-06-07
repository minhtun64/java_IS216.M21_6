/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Process.KhachHang.DatVe;

import ConnectDB.CheckOracleConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

/**
 *
 * @author duyta
 */
public class DatVe {

    public int datVe(String maVe, String hoTen, String sDT,
            String cMND, String eMail) {
        int count = 1;
        // TODO add your handling code here:
        try ( Connection con = CheckOracleConnection.getMyConnection()) {

//            String query = "INSERT INTO "
//                    + "DOIBONG(MAD,TENDOI,QUOCGIA)"
//                    +" VALUES('"
//                    +maDoi+"','"+tenDoi+"','"+quocGia+"')";
//            String query = "INSERT INTO TUYENXE VALUES(?,?,?,?,?,?,?)";
//            PreparedStatement ps = con.prepareStatement(query);
            String strCall = "{call Pro_themdatve_khachhang(?,?,?,?,?)}";
            CallableStatement caSt = con.prepareCall(strCall);

            caSt.setString(1, maVe);
            caSt.setString(2, hoTen);
            caSt.setString(3, sDT);
            caSt.setString(4, cMND);
            caSt.setString(5, eMail);

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
