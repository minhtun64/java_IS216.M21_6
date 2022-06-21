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
import java.sql.Types;
import java.sql.SQLException;
import javax.swing.JOptionPane;
//import java.sql.Types;

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

    public int ThanhToanDatVe(String IDDve, String IDNV) {
        int count = 1;
        try {
            Connection conn = CheckOracleConnection.getMyConnection();
            String strCall = "{call Pro_thanhtoanve(?,?)}";
            CallableStatement caSt = conn.prepareCall(strCall);
            caSt.setString(1, IDDve);
            caSt.setString(2, IDNV);
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
        public int DieuKienThanhToanVe(String ID) {
        int count = -1;
        try {
            Connection conn = CheckOracleConnection.getMyConnection();
            String sql = "{?= call Func_dieukien_thanhtoanve(?)}";
            CallableStatement cstmt  = conn.prepareCall(sql);
            cstmt.registerOutParameter(1,Types.INTEGER);
            cstmt.setString(2, ID);
            cstmt.executeQuery();
            count=cstmt.getInt(1);

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
            ResultSet rs = caSt.executeQuery();
            if (!rs.isBeforeFirst()) {
                count = 0;
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }

    public int DieuKienHoanVe(String IDDatve) {
        int count = -1;
        try {
            Connection conn = CheckOracleConnection.getMyConnection();
            String sql = "{?= call Func_dieukien_hoanve(?)}";
            CallableStatement cstmt  = conn.prepareCall(sql);
            cstmt.registerOutParameter(1,Types.INTEGER);
            cstmt.setString(2, IDDatve);
            cstmt.executeQuery();
            count=cstmt.getInt(1);

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

    
    public int ThemVe_QuanLyVe(String maVe, String maNV, String hoTen, String sDT, String cMND, String eMail)
    {
        int count = 0;
        try {
            Connection conn = CheckOracleConnection.getMyConnection();
            String sql = "{call Pro_themdatve_nhanvien(?,?,?,?,?,?)}";
            CallableStatement caSt = conn.prepareCall(sql);
            caSt.setString(1, maVe);
            caSt.setString(2, maNV);
            caSt.setString(3, hoTen);
            caSt.setString(4, sDT);
            caSt.setString(5, cMND);
            caSt.setString(6, eMail);
            count = caSt.executeUpdate();
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
