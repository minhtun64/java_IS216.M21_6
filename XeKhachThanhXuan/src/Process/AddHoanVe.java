/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Process;
import Connect_DB.CheckOracleConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author DUNG
 */
public class AddHoanVe {
    public int themHoanVe(String IDDatve, String IDnhanvien)throws SQLException, ClassNotFoundException{
                    int count = 0;
                try{
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
}

