/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Process.QuanLy.TuyenXe;

import ConnectDB.CheckOracleConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

/**
 *
 * @author duyta
 */
public class ChuyenXe {
    
        public int themChuyenXe(String maTuyenXe,  String maXe, String maNQL,
            String diemDi, String diemDen, String thoiGianKhoiHanh, String thoiGianDen, String taiXe, String phuXe) {
        int count = 1;
        // TODO add your handling code here:
        try ( Connection con = CheckOracleConnection.getMyConnection()) {

//            String query = "INSERT INTO "
//                    + "DOIBONG(MAD,TENDOI,QUOCGIA)"
//                    +" VALUES('"
//                    +maDoi+"','"+tenDoi+"','"+quocGia+"')";
//            String query = "INSERT INTO TUYENXE VALUES(?,?,?,?,?,?,?)";
//            PreparedStatement ps = con.prepareStatement(query);
            String strCall = "{call Pro_themchuyenxe (?,?,?,?,?,to_date(?, 'DD-MM-YYYY HH24:MI:SS'),to_date(?, 'DD-MM-YYYY HH24:MI:SS'),?,?)}";
            CallableStatement caSt = con.prepareCall(strCall);

            caSt.setString(1, maTuyenXe);
            caSt.setString(2, maXe);
            caSt.setString(3, maNQL);
            caSt.setString(4, diemDi);
            caSt.setString(5, diemDen);
            caSt.setString(6, thoiGianKhoiHanh);
            caSt.setString(7, thoiGianDen);
            caSt.setString(8, taiXe);
            caSt.setString(9, phuXe);

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

    public int suaChuyenXe(String maChuyenXe, String maTuyenXe, String maXe, String maNQL,
            String diemDi, String diemDen, String thoiGianKhoiHanh, String thoiGianDen, String taiXe, String phuXe) {
        int count = 1;
        // TODO add your handling code here:
        try ( Connection con = CheckOracleConnection.getMyConnection()) {

//            String query = "INSERT INTO "
//                    + "DOIBONG(MAD,TENDOI,QUOCGIA)"
//                    +" VALUES('"
//                    +maDoi+"','"+tenDoi+"','"+quocGia+"')";
//            String query = "INSERT INTO TUYENXE VALUES(?,?,?,?,?,?,?)";
//            PreparedStatement ps = con.prepareStatement(query);
            String strCall = "{call Pro_capnhatchuyenxe (?,?,?,?,?,?,to_date(?, 'DD-MM-YYYY HH24:MI:SS'),to_date(?, 'DD-MM-YYYY HH24:MI:SS'),?,?)}";
            CallableStatement caSt = con.prepareCall(strCall);

            caSt.setString(1, maChuyenXe);
            caSt.setString(2, maTuyenXe);
            caSt.setString(3, maXe);
            caSt.setString(4, maNQL);
            caSt.setString(5, diemDi);
            caSt.setString(6, diemDen);
            caSt.setString(7, thoiGianKhoiHanh);
            caSt.setString(8, thoiGianDen);
            caSt.setString(9, taiXe);
            caSt.setString(10, phuXe);

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
    
    public int xoaChuyenXe(String maChuyenXe) {
        int count = 1;
        // TODO add your handling code here:
        try ( Connection con = CheckOracleConnection.getMyConnection()) {

//            String query = "INSERT INTO "
//                    + "DOIBONG(MAD,TENDOI,QUOCGIA)"
//                    +" VALUES('"
//                    +maDoi+"','"+tenDoi+"','"+quocGia+"')";
//            String query = "INSERT INTO TUYENXE VALUES(?,?,?,?,?,?,?)";
//            PreparedStatement ps = con.prepareStatement(query);
            String strCall = "{call Pro_xoachuyenxe (?)}";
            CallableStatement caSt = con.prepareCall(strCall);

            caSt.setString(1, maChuyenXe);
   
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
