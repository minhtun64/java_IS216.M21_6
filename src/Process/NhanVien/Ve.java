/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Process.NhanVien;

import ConnectDB.CheckOracleConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author DUNG
 */
public class Ve {

    public int XoaVe(String iddv) throws SQLException, ClassNotFoundException {
        int count = 1;
        try {
            Connection conn = CheckOracleConnection.getMyConnection();
            String sql = "{call Pro_themdatve_khachhang(?)}";
            PreparedStatement ps = conn.prepareStatement(sql);
            CallableStatement caSt = conn.prepareCall(sql);
            caSt.setString(1, iddv);
            ResultSet rs = caSt.executeQuery();

            if (!rs.isBeforeFirst()) {
                count = 0;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }

    public int XoaGiaVe(String IDTuyenXe, String IDLoaiXe) throws SQLException, ClassNotFoundException {
        int count = 1;
        try {
            Connection conn = CheckOracleConnection.getMyConnection();
            String sql = "{call Pro_xoagiave(?,?)}";
            PreparedStatement ps = conn.prepareStatement(sql);
            CallableStatement caSt = conn.prepareCall(sql);
            caSt.setString(1, IDTuyenXe);
            caSt.setString(2, IDLoaiXe);
            count = caSt.executeUpdate();

//            if (!rs.isBeforeFirst()) {
//                count = 0;
//            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return count;

    }

    public int CapNhatGiaVe(int IDLoaixe, int IDTuyenxe, String GiaVe) {
        int count = 1;
        try {
            Connection conn = CheckOracleConnection.getMyConnection();
            String strCall = "{call Pro_capnhatgiave(?,?,?)}";
            CallableStatement caSt = conn.prepareCall(strCall);
            caSt.setInt(1, IDLoaixe);
            caSt.setInt(2, IDTuyenxe);
            caSt.setString(3, GiaVe);

            ResultSet rs = caSt.executeQuery();

            if (!rs.isBeforeFirst()) {
                count = 0;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }

    public int ThanhToanDatVe(String IDDve) {
        int count = 1;
        try {
            Connection conn = CheckOracleConnection.getMyConnection();
            String strCall = "{call Pro_thanhtoanve(?)}";
            CallableStatement caSt = conn.prepareCall(strCall);
            caSt.setString(1, IDDve);
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

    public int XoaDatVe(String idve) throws SQLException, ClassNotFoundException {
        int count = 1;
        try {
            Connection conn = CheckOracleConnection.getMyConnection();
            String sql = "{call Pro_xoadatve(?)}";
            PreparedStatement ps = conn.prepareStatement(sql);
            CallableStatement caSt = conn.prepareCall(sql);
            caSt.setString(1, idve);
            count = caSt.executeUpdate();

//            if (!rs.isBeforeFirst()) {
//                count = 0;
//            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }

    public int ThemVe(String idhk, String idcx, String idve, String hovaten, String sodt, String cmnd, String email) throws SQLException, ClassNotFoundException {
        int count = 1;
        try {
            Connection conn = CheckOracleConnection.getMyConnection();
            String sql = "{call Pro_themdatve_khachhang(?,?,?,?,?,?,?)}";
            PreparedStatement ps = conn.prepareStatement(sql);
            CallableStatement caSt = conn.prepareCall(sql);

            caSt.setString(1, idhk);
            caSt.setString(2, idcx);
            caSt.setString(3, idve);
            caSt.setString(4, hovaten);
            caSt.setString(5, sodt);
            caSt.setString(6, cmnd);
            caSt.setString(7, email);

            ResultSet rs = caSt.executeQuery();

            if (!rs.isBeforeFirst()) {
                count = 0;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }

    public int ThemHoanVe(String IDDatve, String IDnhanvien) throws SQLException, ClassNotFoundException {
        int count = 0;
        try {
            Connection conn = CheckOracleConnection.getMyConnection();
            String sql = "{call Pro_themhoanve(?,?)}";
            CallableStatement caSt = conn.prepareCall(sql);
            caSt.setString(1, IDDatve);
            caSt.setString(2, IDnhanvien);
            count = caSt.executeUpdate();

        } catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }

    public int ThemGiaVe(int IDLoaixe, int IDTuyenxe, String GiaVe) {
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

    public int ThemDatVe(int IDVe, int IDNhanVien, String hvt, String sdt, String cmnd, String email) throws SQLException, ClassNotFoundException {
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
