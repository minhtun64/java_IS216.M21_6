/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Connect_DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author DUNG
 */
public class OracleConnection {

    public static Connection getOracleConnection()
            throws ClassNotFoundException, SQLException {
        String hostName = "localhost";
        String sid = "orcl";
        String userName = "DB_XEKHACH";
        String password = "userpass";

        Class.forName("oracle.jdbc.driver.OracleDriver");
        String connectionURL = "jdbc:oracle:thin:@" + hostName + ":1521:" + sid;
        Connection con = DriverManager.getConnection(connectionURL, userName, password);
        return con;
    }

    public static Connection getOracleConnectionNhanVien()
            throws ClassNotFoundException, SQLException {
        String hostName = "localhost";
        String sid = "orcl";
        String userName = "NHANVIEN";
        String password = "nhanvien";

        Class.forName("oracle.jdbc.driver.OracleDriver");
        String connectionURL = "jdbc:oracle:thin:@" + hostName + ":1521:" + sid;
        Connection conn = DriverManager.getConnection(connectionURL, userName, password);
        return conn;
    }

    public static Connection getOracleConnectionNguoiQuanLy()
            throws ClassNotFoundException, SQLException {
        String hostName = "localhost";
        String sid = "orcl";
        String userName = "NGUOIQUANLY";
        String password = "nguoiquanly";

        Class.forName("oracle.jdbc.driver.OracleDriver");
        String connectionURL = "jdbc:oracle:thin:@" + hostName + ":1521:" + sid;
        Connection connn = DriverManager.getConnection(connectionURL, userName, password);
        return connn;
    }
//    public int DangNhap_PhanQuyen(String Taikhoan, String Password) throws SQLException, ClassNotFoundException{
//        int n = 0;
//        try{
//        Connection conn = CheckOracleConnection.getMyConnection();
//        String sql ="SELECT * FROM TAIKHOAN WHERE TENDANGNHAP='"+Taikhoan+"' AND MATKHAU='"+Password+"'";
//        PreparedStatement ps =conn.prepareStatement(sql);
//        ResultSet rs = ps.executeQuery();
//        int role = 0;
//        while(rs.next()){
//                role = rs.getInt(3);
//        }
//        if(role==1){
//            n=1;
//            String hostName = "localhost";
//        String sid = "orcl";
//        String userName="NGUOIQUANLY";
//        String password= "nguoiquanly";
//        
//        Class.forName("oracle.jdbc.driver.OracleDriver");
//        String connectionURL ="jdbc:oracle:thin:@"+hostName+":1521:"+sid;
////        Connection conn = DriverManager.getConnection(connectionURL, userName, password);
////        return conn;
//        }
//        else {
//            n=0;
//            String hostName = "localhost";
//        String sid = "orcl";
//        String userName="NHANVIEN";
//        String password= "nhanvien";
//        
//        Class.forName("oracle.jdbc.driver.OracleDriver");
//        String connectionURL ="jdbc:oracle:thin:@"+hostName+":1521:"+sid;
////        Connection conn = DriverManager.getConnection(connectionURL, userName, password);
////        return conn;
//        }
//        }catch (ClassNotFoundException | SQLException e){
//            System.out.println(e);
//            return n;
//        }
//        return n;
//    }
}
