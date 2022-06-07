/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Process;

import Connect_DB.CheckOracleConnection;
import java.util.Scanner;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

/**
 *
 * @author DUNG
 */
public class User {

    public int DangNhap(String TenDangNhap, String Password) throws SQLException, ClassNotFoundException{
        int n = 0;
        try{
        Connection conn = CheckOracleConnection.getMyConnection();
        String sql ="SELECT TENDANGNHAP, MATKHAU FROM TAIKHOAN WHERE TENDANGNHAP='"+TenDangNhap+"' AND MATKHAU='"+Password+"'";
        PreparedStatement ps =conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
//        String role = rs.getString("ROLE");
        if(rs.next()){
            n = 1;
            }
        }catch (ClassNotFoundException | SQLException e){
            System.out.println(e);
            return n;
        }
        return n;
    }
    public int DangNhap_PhanQuyen(String Taikhoan, String Password) throws SQLException, ClassNotFoundException{
        int n = 0;
        try{
        Connection conn = CheckOracleConnection.getMyConnection();
        String sql ="SELECT * FROM TAIKHOAN WHERE TENDANGNHAP='"+Taikhoan+"' AND MATKHAU='"+Password+"'";
        PreparedStatement ps =conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        int role = 0;
        while(rs.next()){
                role = rs.getInt(3);
        }
        if(role==1){
            n=1;
        }
        else {
            n=0;
        }
        }catch (ClassNotFoundException | SQLException e){
            System.out.println(e);
            return n;
        }
        return n;
    }
}



