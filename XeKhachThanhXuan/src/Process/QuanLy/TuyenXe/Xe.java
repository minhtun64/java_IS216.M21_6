/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Process.QuanLy.TuyenXe;

import ConnectDB.CheckOracleConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Types;


/**
 *
 * @author duyta
 */
public class Xe {

    public int themXe(String maLoaiXe, String tenXe, String mauXe,
            String hangSanXuat, String bienSo) {
        int count = 1;
        // TODO add your handling code here:
        try ( Connection con = CheckOracleConnection.getMyConnection()) {

            String strCall = "{call Pro_themxe(?,?,?,?,?)}";
            CallableStatement caSt = con.prepareCall(strCall);

            caSt.setString(1, maLoaiXe);
            caSt.setString(2, tenXe);
            caSt.setString(3, mauXe);
            caSt.setString(4, hangSanXuat);
            caSt.setString(5, bienSo);

            ResultSet rs = caSt.executeQuery();

            if (!rs.isBeforeFirst()) {
                count = 0;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }

    public int suaXe(String maXe,String maLoaiXe, String tenXe, String mauXe,
            String hangSanXuat, String bienSo) {
        int count = 1;
        // TODO add your handling code here:
        try ( Connection con = CheckOracleConnection.getMyConnection()) {

            String strCall = "{call Pro_capnhatxe(?,?,?,?,?,?)}";
            CallableStatement caSt = con.prepareCall(strCall);
            caSt.setString(1, maXe);
            caSt.setString(2, maLoaiXe);
            caSt.setString(3, tenXe);
            caSt.setString(4, mauXe);
            caSt.setString(5, hangSanXuat);
            caSt.setString(6, bienSo);
            

            ResultSet rs = caSt.executeQuery();

            if (!rs.isBeforeFirst()) {
                count = 0;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }
    
       public int xoaXe(String maXe) {
        int count = 1;
        // TODO add your handling code here:
        try ( Connection con = CheckOracleConnection.getMyConnection()) {

            String strCall = "{call Pro_huyxe(?)}";
            CallableStatement caSt = con.prepareCall(strCall);
            caSt.setString(1, maXe);
        
            ResultSet rs = caSt.executeQuery();

            if (!rs.isBeforeFirst()) {
                count = 0;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }
       public int DieuKienHuyXe(String maXe) {
        int count = -1;
        try {
            Connection conn = CheckOracleConnection.getMyConnection();
            String sql = "{?= call Func_dieukien_huyloaixe(?)}";
            CallableStatement cstmt = conn.prepareCall(sql);
            cstmt.registerOutParameter(1, Types.INTEGER);
            cstmt.setString(2, maXe);
            cstmt.executeQuery();
            count = cstmt.getInt(1);

        } catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }
}
