/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Process.QuanLy.TuyenXe;

import ConnectDB.CheckOracleConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.lang.*;
import java.sql.Types;
import javax.swing.JOptionPane;

/**
 *
 * @author duyta
 */
public class TuyenXe {

    public int themTuyenXe(String tenTuyen, String diemDau, String diemCuoi,
            String soKm, String soGioDi) {
        int count = 1;
        // TODO add your handling code here:
        try ( Connection con = CheckOracleConnection.getMyConnection()) {

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
        } catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }

    public int suaTuyenXe(String iD, String tenTuyen, String diemDau, String diemCuoi,
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
            String strCall = "{call Pro_capnhattuyenxe(?,?,?,?,?,?)}";
            CallableStatement caSt = con.prepareCall(strCall);

            caSt.setString(1, iD);
            caSt.setString(2, tenTuyen);
            caSt.setString(3, diemDau);
            caSt.setString(4, diemCuoi);
            caSt.setString(5, soKm);
            caSt.setString(6, soGioDi);

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

    public int xoaTuyenXe(String iD) {
        int count = 1;
        // TODO add your handling code here:
        try ( Connection con = CheckOracleConnection.getMyConnection()) {

//            String query = "INSERT INTO "
//                    + "DOIBONG(MAD,TENDOI,QUOCGIA)"
//                    +" VALUES('"
//                    +maDoi+"','"+tenDoi+"','"+quocGia+"')";
//            String query = "INSERT INTO TUYENXE VALUES(?,?,?,?,?,?,?)";
//            PreparedStatement ps = con.prepareStatement(query);
            CallableStatement cstmt = con.prepareCall("{? = call Func_dieukien_huytuyenxe (?)}");
            //Registering the out parameter of the function (return type)
            cstmt.registerOutParameter(1, Types.INTEGER);
            //Setting the input parameters of the function
            cstmt.setString(2, iD);
            //Executing the statement
            cstmt.execute();
            int testxoatuyenxe = cstmt.getInt(1);
            System.out.println(testxoatuyenxe);

            if (testxoatuyenxe == 1) {
                String strCall = "{call Pro_huytuyenxe(?)}";
                CallableStatement caSt = con.prepareCall(strCall);
                caSt.setString(1, iD);
                ResultSet rs = caSt.executeQuery();

                if (!rs.isBeforeFirst()) {
                    count = 0;
                }
            } else {
                count = 0;
                JOptionPane.showMessageDialog(null, "Tuyến xe được chọn không đủ điều kiện xóa!");
            }

//            Statement stat = con.createStatement();
//            i = stat.executeUpdate(query);
        } catch (Exception e) {
            System.out.println(e);
            
        }
        return count;
    }
}
