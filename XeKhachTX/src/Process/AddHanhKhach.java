/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Process;

import Connect_DB.CheckOracleConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import static javax.swing.text.html.HTML.Attribute.ID;
/**
 *
 * @author DUNG
 */
public class AddHanhKhach {
    
    public int themHanhKhach(String Ten, String SoDT, String CMND, String Email)throws SQLException, ClassNotFoundException{
        int countResult = 0;
        try {
            Connection conn = CheckOracleConnection.getMyConnection();
            String sql ="Insert INTO HANHKHACH values('"+Ten+"','"+SoDT+"','"+CMND+"','"+Email+"')";
            PreparedStatement ps =conn.prepareStatement(sql);
            countResult = ps.executeUpdate();

        } 
        catch (ClassNotFoundException ex) {
            System.out.println(ex);
            return countResult;
        } catch (SQLException e) {
            System.out.println(e);
            return countResult;
        }
        return countResult;
        
        
        
    }
    
//    public HashMap<String,String> getListHanhKhach(){
//      HashMap<String,String> listHanhKhach = new HashMap<>();
//      
//      try( Connection conn = CheckOracleConnection.getMyConnection())
//      {
//          String sql = "SELECT * FROM HANHKHACH";
//    }catch
//            {
//                
//            }
}
