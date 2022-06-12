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
public class HanhKhach {

    public int SuaHanhKhach(int IDHanhKhach, String HoVaTen, String SoDT, String CMND, String Email) {
        int count = 1;
        try {
            Connection conn = CheckOracleConnection.getMyConnection();
            String strCall = "{call Pro_capnhathanhkhach(?,?,?,?,?)}";
            CallableStatement caSt = conn.prepareCall(strCall);
            caSt.setInt(1, IDHanhKhach);
            caSt.setString(2, HoVaTen);
            caSt.setString(3, SoDT);
            caSt.setString(4, CMND);
            caSt.setString(5, Email);

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
