/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Process;

import ConnectDB.ConnectionUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;
import java.util.HashMap;
import javax.swing.JTextField;

/**
 *
 * @author nguyenminhnhut
 */
public class GiaiDau {
    
    /**
     * Hàm thêm giải đấu
     * 
     * @param maGiai
     * @param tenGiai
     * @param ngayBD
     * @param ngayKT
     * @return 
     */
    public int themGiaiDau(String maGiai, String tenGiai, Date ngayBD, Date ngayKT)
    {
        int countResult = 0;
        
        try (Connection con = ConnectionUtils.getMyConnection()) {
         String query = "INSERT INTO GIAIDAU VALUES(?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, maGiai);
            ps.setString(2, tenGiai);
            ps.setDate(3, new java.sql.Date(ngayBD.getTime()));
            ps.setDate(4, new java.sql.Date(ngayKT.getTime()));
            countResult = ps.executeUpdate();   
        }
        catch(Exception e){
            System.out.println(e);
            return countResult;
        }
        
        return countResult;
    }
    
     /**
     * ArrayList Lấy danh sách các giải đấu
     * 
     * @return 
     */
    public HashMap<String,String> getListGiaiDau() {
        HashMap<String,String> listGiaiDau = new HashMap<>();
        
        try ( Connection con = ConnectionUtils.getMyConnection()) {
            String SQL = "SELECT DISTINCT MAG,TENGIAI FROM GIAIDAU ORDER BY MAG";
            Statement statement = con.createStatement();
            ResultSet rs = statement.executeQuery(SQL);
            while (rs.next()) {
                listGiaiDau.put(rs.getString("MAG"),rs.getString("TENGIAI"));
            }
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return listGiaiDau;
    }

}
