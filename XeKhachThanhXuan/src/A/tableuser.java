/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Process;


import ConnectDB.ConnectionUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author DUNG
 */
public class tableuser {
    private String username ;
    private String password ;
    public int themtaikhoan(String username, String password) throws SQLException
    {
        int count=1;
        try (Connection con = ConnectionUtils.getMyConnection()) {
            String SQL_query = "INSERT INTO TABLEUSER(USERNAME,PASSWORD)"
                    + " VALUES(?, ?)";
            PreparedStatement ps = con.prepareStatement(SQL_query);
            ps.setString(1, username);
            ps.setString(2, password); 
            ps.executeUpdate();           
        } catch (Exception e) {
            e.printStackTrace();
            count=0;            
        }
        return count;
    }
    public boolean Login(String username, String password) {
        try (Connection con = ConnectionUtils.getMyConnection()) {
            String SQL_query = "SELECT * FROM TABLEUSER WHERE TENDANGNHAP=? AND MATKHAU=?";
            PreparedStatement ps = con.prepareStatement(SQL_query);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            } else {
                return false;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    public String getUsername(String username) {
        String name = null;
        try (Connection con = ConnectionUtils.getMyConnection()) {
            String SQL_query = "SELECT TENDANGNHAP FROM TABLEUSER WHERE TENDANGNHAP=?";
            PreparedStatement ps = con.prepareStatement(SQL_query);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                name = rs.getString("TENDANGNHAP");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return name;
    }
}
