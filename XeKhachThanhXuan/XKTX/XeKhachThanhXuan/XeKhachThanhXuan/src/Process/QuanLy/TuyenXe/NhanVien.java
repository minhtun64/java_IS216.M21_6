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
public class NhanVien {

    public int themNhanVien(String maNQL, String tenNhanVien, String gioiTinh,
            String ngaySinh, String ngayVaoLam, String sDT, String eMail,
            String tenDangNhap, String matKhau) {
        int count = 1;
        // TODO add your handling code here:
        try ( Connection con = CheckOracleConnection.getMyConnection()) {

            String strCall = "{call Pro_themnhanvien(?,?,?,to_date(?, 'DD-MM-YYYY'),to_date(?, 'DD-MM-YYYY'),?,?,?,?)}";
            CallableStatement caSt = con.prepareCall(strCall);

            caSt.setString(1, maNQL);
            caSt.setString(2, tenNhanVien);
            caSt.setString(3, gioiTinh);
            caSt.setString(4, ngaySinh);
            caSt.setString(5, ngayVaoLam);
            caSt.setString(6, sDT);
            caSt.setString(7, eMail);
            caSt.setString(8, tenDangNhap);
            caSt.setString(9, matKhau);

            ResultSet rs = caSt.executeQuery();

            if (!rs.isBeforeFirst()) {
                count = 0;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }
    
    public int suaNhanVien(String maNhanVien, String maNQL,String tenNhanVien, String gioiTinh,
            String ngaySinh, String ngayVaoLam, String sDT, String eMail) {
        int count = 1;
        // TODO add your handling code here:
        try ( Connection con = CheckOracleConnection.getMyConnection()) {

            String strCall = "{call Pro_capnhatnhanvien(?,?,?,?,to_date(?, 'DD-MM-YYYY'),to_date(?, 'DD-MM-YYYY'),?,?)}";
            CallableStatement caSt = con.prepareCall(strCall);

            caSt.setString(1, maNhanVien);
            caSt.setString(2, maNQL);
            caSt.setString(3, tenNhanVien);
            caSt.setString(4, gioiTinh);
            caSt.setString(5, ngaySinh);
            caSt.setString(6, ngayVaoLam);
            caSt.setString(7, sDT);
            caSt.setString(8, eMail);

            ResultSet rs = caSt.executeQuery();

            if (!rs.isBeforeFirst()) {
                count = 0;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }
    
      public int xoaNhanVien(String maNhanVien) {
        int count = 1;
        // TODO add your handling code here:
        try ( Connection con = CheckOracleConnection.getMyConnection()) {

            String strCall = "{call Pro_huynhanvien(?)}";
            CallableStatement caSt = con.prepareCall(strCall);

            caSt.setString(1, maNhanVien);

            ResultSet rs = caSt.executeQuery();

            if (!rs.isBeforeFirst()) {
                count = 0;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }
}
