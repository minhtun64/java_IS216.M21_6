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
public class LoaiXe {

    public int themLoaiXe(String tenLoaiXe, String soLuongGhe) {
        int count = 1;
        // TODO add your handling code here:
        try ( Connection con = CheckOracleConnection.getMyConnection()) {

            String strCall = "{call Pro_themloaixe(?,?)}";
            CallableStatement caSt = con.prepareCall(strCall);

            caSt.setString(1, tenLoaiXe);
            caSt.setString(2, soLuongGhe);

            ResultSet rs = caSt.executeQuery();

            if (!rs.isBeforeFirst()) {
                count = 0;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }

    public int suaLoaiXe(String maLoaiXe, String tenLoaiXe, String soLuongGhe) {
        int count = 1;
        // TODO add your handling code here:
        try ( Connection con = CheckOracleConnection.getMyConnection()) {

            String strCall = "{call Pro_capnhatloaixe(?,?,?)}";
            CallableStatement caSt = con.prepareCall(strCall);

            caSt.setString(1, maLoaiXe);
            caSt.setString(2, tenLoaiXe);
            caSt.setString(3, soLuongGhe);

            ResultSet rs = caSt.executeQuery();

            if (!rs.isBeforeFirst()) {
                count = 0;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return count;
    }

    public int xoaLoaiXe(String maLoaiXe) {
        int count = 1;
        // TODO add your handling code here:
        try ( Connection con = CheckOracleConnection.getMyConnection()) {

            String strCall = "{call Pro_huyloaixe(?)}";
            CallableStatement caSt = con.prepareCall(strCall);

            caSt.setString(1, maLoaiXe);

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
