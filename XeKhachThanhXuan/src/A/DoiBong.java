/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Process;

import ConnectDB.ConnectionUtils;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.DefaultComboBoxModel;

/**
 *
 * @author nguyenminhnhut
 */
public class DoiBong {
    
    /**
     * Them doi bong cau a
     * 
     * @param maDoi
     * @param tenDoi
     * @param quocGia
     * @return 
     */
    public int themDoiBong(String maDoi, String tenDoi, String quocGia) {
        int i = 0;
        // TODO add your handling code here:
        try (Connection con = ConnectionUtils.getMyConnection()) {
        
//            String query = "INSERT INTO "
//                    + "DOIBONG(MAD,TENDOI,QUOCGIA)"
//                    +" VALUES('"
//                    +maDoi+"','"+tenDoi+"','"+quocGia+"')";

            String query = "INSERT INTO DOIBONG VALUES(?,?,?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, maDoi);
            ps.setString(2, tenDoi);
            ps.setString(3, quocGia);
            i = ps.executeUpdate();
//            Statement stat = con.createStatement();
//            i = stat.executeUpdate(query);
            
        }
        catch(Exception e){
            System.out.println(e);
        }
        return i;
    }  
    
    /**
     * ArrayList Lay danh sach doi bong
     * 
     * @return 
     */
    public HashMap<String,String> getListDoiBong() {
        HashMap<String,String> listDoiBong = new HashMap<>();
        
        try ( Connection con = ConnectionUtils.getMyConnection()) {
            String SQL = "SELECT DISTINCT MAD,TENDOI FROM DOIBONG ORDER BY MAD";
            Statement statement = con.createStatement();
            ResultSet rs = statement.executeQuery(SQL);
            while (rs.next()) {
                listDoiBong.put(rs.getString("MAD"),rs.getString("TENDOI"));
            }
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return listDoiBong;
    }
    
}
