/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package View;

import ConnectDB.OracleConnection;
import java.awt.Container;
import java.sql.SQLException;
import java.util.HashMap;
import javax.swing.JFrame;
import static javax.swing.WindowConstants.DISPOSE_ON_CLOSE;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.view.JRViewer;

/**
 *
 * @author duyta
 */
public class ReportViewer extends JFrame {

        public ReportViewer(String fileName) throws
                SQLException {
            this(fileName, null);
        }

        public ReportViewer(String fileName, HashMap parameter) throws SQLException {
            super("View report");
            try {
                JasperReport jsr = JasperCompileManager.compileReport(fileName);
                JasperPrint print
                        = JasperFillManager.fillReport(jsr,
                                parameter, OracleConnection.getOracleConnection());
                JRViewer view = new JRViewer(print);
                Container c = getContentPane();
                c.add(view);
            } catch (ClassNotFoundException | SQLException
                    | JRException e) {
            }
            setBounds(10, 10, 600, 500);
            setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        }
    }