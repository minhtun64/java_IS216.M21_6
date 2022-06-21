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
public class GiaVe {

    public int themGiaVe(String maLoaiXe, String maTuyenXe, String giaVe) {
        int count = 1;
        // TODO add your handling code here:
        try ( Connection con = CheckOracleConnection.getMyConnection()) {

//            String query = "INSERT INTO "
//                    + "DOIBONG(MAD,TENDOI,QUOCGIA)"
//                    +" VALUES('"
//                    +maDoi+"','"+tenDoi+"','"+quocGia+"')";
//            String query = "INSERT INTO TUYENXE VALUES(?,?,?,?,?,?,?)";
//            PreparedStatement ps = con.prepareStatement(query);
            String strCall = "{call Pro_themgiave(?,?,?)}";
            CallableStatement caSt = con.prepareCall(strCall);

            caSt.setString(1, maLoaiXe);
            caSt.setString(2, maTuyenXe);
            caSt.setString(3, giaVe);
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

    public int suaGiaVe(String maLoaiXe, String maTuyenXe, String giaVe) {
        int count = 1;
        // TODO add your handling code here:
        try ( Connection con = CheckOracleConnection.getMyConnection()) {

//            String query = "INSERT INTO "
//                    + "DOIBONG(MAD,TENDOI,QUOCGIA)"
//                    +" VALUES('"
//                    +maDoi+"','"+tenDoi+"','"+quocGia+"')";
//            String query = "INSERT INTO TUYENXE VALUES(?,?,?,?,?,?,?)";
//            PreparedStatement ps = con.prepareStatement(query);
            String strCall = "{call Pro_capnhatgiave(?,?,?)}";
            CallableStatement caSt = con.prepareCall(strCall);

            caSt.setString(1, maLoaiXe);
            caSt.setString(2, maTuyenXe);
            caSt.setString(3, giaVe);
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
    
        public int xoaGiaVe(String maLoaiXe, String maTuyenXe) {
        int count = 1;
        // TODO add your handling code here:
        try ( Connection con = CheckOracleConnection.getMyConnection()) {

//            String query = "INSERT INTO "
//                    + "DOIBONG(MAD,TENDOI,QUOCGIA)"
//                    +" VALUES('"
//                    +maDoi+"','"+tenDoi+"','"+quocGia+"')";
//            String query = "INSERT INTO TUYENXE VALUES(?,?,?,?,?,?,?)";
//            PreparedStatement ps = con.prepareStatement(query);
            String strCall = "{call Pro_xoagiave(?,?)}";
            CallableStatement caSt = con.prepareCall(strCall);

            caSt.setString(1, maLoaiXe);
            caSt.setString(2, maTuyenXe);
  
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
