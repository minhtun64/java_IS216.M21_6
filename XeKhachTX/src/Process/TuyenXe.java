/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Process;

import Connect_DB.CheckOracleConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.CallableStatement;
import java.sql.ResultSet;

/**
 *
 * @author duyta
 */
public class TuyenXe {

    public int themTuyenXe( String tenTuyen, String diemDau, String diemCuoi,
            String soKm, String soGioDi) {
        int count = 1;
        // TODO add your handling code here:
        try ( Connection con = CheckOracleConnection.getMyConnection()) {

//            String query = "INSERT INTO "
//                    + "DOIBONG(MAD,TENDOI,QUOCGIA)"
//                    +" VALUES('"
//                    +maDoi+"','"+tenDoi+"','"+quocGia+"')";
//            String query = "INSERT INTO TUYENXE VALUES(?,?,?,?,?,?,?)";
//            PreparedStatement ps = con.prepareStatement(query);
            String strCall = "{call Pro_themtuyenxe(?,?,?,?,?)}";
            CallableStatement caSt = con.prepareCall(strCall);

            caSt.setString(1, tenTuyen);
            caSt.setString(2, diemDau);
            caSt.setString(3, diemCuoi);
            caSt.setString(4, soKm);
            caSt.setString(5, soGioDi);
     

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
