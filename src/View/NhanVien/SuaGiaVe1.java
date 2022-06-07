/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package View.NhanVien;

import ConnectDB.CheckOracleConnection;
import Process.NhanVien.Ve1;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author DUNG
 */
public class SuaGiaVe1 extends javax.swing.JFrame {

    /**
     * Creates new form SGiaVe
     */
    public SuaGiaVe1() {
        initComponents();
        fillTable();
        ComboboxIDtuyen();
        ComboboxIDloai();

    }
    Connection conn;

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        B = new javax.swing.JPanel();
        jSeparator1 = new javax.swing.JSeparator();
        jLabel54 = new javax.swing.JLabel();
        jSeparator3 = new javax.swing.JSeparator();
        jPanel2 = new javax.swing.JPanel();
        jLabel4 = new javax.swing.JLabel();
        jLabel6 = new javax.swing.JLabel();
        GiaVe = new javax.swing.JTextField();
        jLabel9 = new javax.swing.JLabel();
        IDloaixe = new javax.swing.JComboBox<>();
        IDtuyenxe = new javax.swing.JComboBox<>();
        jPanel8 = new javax.swing.JPanel();
        jLabel40 = new javax.swing.JLabel();
        jPanel10 = new javax.swing.JPanel();
        jLabel42 = new javax.swing.JLabel();
        nutsua = new javax.swing.JButton();
        jScrollPane5 = new javax.swing.JScrollPane();
        danhsachgiave = new javax.swing.JTable();
        quaylai = new javax.swing.JButton();
        jLabel23 = new javax.swing.JLabel();
        jLabel59 = new javax.swing.JLabel();
        A = new javax.swing.JPanel();
        Logo2 = new javax.swing.JLabel();
        Home2 = new javax.swing.JPanel();
        jLabel8 = new javax.swing.JLabel();
        QL_GiaVe = new javax.swing.JPanel();
        jLabel20 = new javax.swing.JLabel();
        DangXuat = new javax.swing.JPanel();
        jLabel21 = new javax.swing.JLabel();
        QL_GiaVe2 = new javax.swing.JPanel();
        jLabel22 = new javax.swing.JLabel();
        QL_GiaVe6 = new javax.swing.JPanel();
        jLabel25 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        B.setBackground(new java.awt.Color(251, 250, 238));

        jSeparator1.setForeground(new java.awt.Color(205, 247, 247));

        jLabel54.setFont(new java.awt.Font("Lora SemiBold", 0, 12)); // NOI18N
        jLabel54.setText("Mời sửa giá vé!");

        jSeparator3.setForeground(new java.awt.Color(205, 247, 247));

        jPanel2.setBackground(new java.awt.Color(251, 250, 238));

        jLabel4.setFont(new java.awt.Font("Lora", 0, 14)); // NOI18N
        jLabel4.setText("ID loại xe");

        jLabel6.setFont(new java.awt.Font("Lora", 0, 14)); // NOI18N
        jLabel6.setText("ID tuyến xe");

        GiaVe.setFont(new java.awt.Font("Lora", 0, 14)); // NOI18N
        GiaVe.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(205, 247, 247)));

        jLabel9.setFont(new java.awt.Font("Lora", 0, 14)); // NOI18N
        jLabel9.setText("Giá vé");

        IDtuyenxe.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                IDtuyenxeActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel9)
                    .addComponent(jLabel4)
                    .addComponent(jLabel6))
                .addGap(34, 34, 34)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(IDloaixe, 0, 145, Short.MAX_VALUE)
                    .addComponent(IDtuyenxe, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(GiaVe))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(IDloaixe, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel4))
                .addGap(18, 18, 18)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel6)
                    .addComponent(IDtuyenxe, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGap(0, 11, Short.MAX_VALUE)
                        .addComponent(jLabel9))
                    .addComponent(GiaVe, javax.swing.GroupLayout.DEFAULT_SIZE, 30, Short.MAX_VALUE)))
        );

        jPanel8.setBackground(new java.awt.Color(251, 250, 238));

        javax.swing.GroupLayout jPanel8Layout = new javax.swing.GroupLayout(jPanel8);
        jPanel8.setLayout(jPanel8Layout);
        jPanel8Layout.setHorizontalGroup(
            jPanel8Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel8Layout.createSequentialGroup()
                .addGap(0, 0, Short.MAX_VALUE)
                .addComponent(jLabel40)
                .addGap(185, 185, 185))
        );
        jPanel8Layout.setVerticalGroup(
            jPanel8Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel8Layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(jLabel40)
                .addGap(58, 58, 58))
        );

        jPanel10.setBackground(new java.awt.Color(251, 250, 238));

        nutsua.setFont(new java.awt.Font("Lora SemiBold", 0, 14)); // NOI18N
        nutsua.setText("Sửa");
        nutsua.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                nutsuathem_quanlytuyenxeActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel10Layout = new javax.swing.GroupLayout(jPanel10);
        jPanel10.setLayout(jPanel10Layout);
        jPanel10Layout.setHorizontalGroup(
            jPanel10Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel10Layout.createSequentialGroup()
                .addGap(0, 0, Short.MAX_VALUE)
                .addComponent(jLabel42)
                .addGap(18, 18, 18)
                .addComponent(nutsua)
                .addContainerGap())
        );
        jPanel10Layout.setVerticalGroup(
            jPanel10Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel10Layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(jLabel42)
                .addGap(58, 58, 58))
            .addGroup(jPanel10Layout.createSequentialGroup()
                .addComponent(nutsua, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(0, 0, Short.MAX_VALUE))
        );

        danhsachgiave.setBackground(new java.awt.Color(251, 250, 238));
        danhsachgiave.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(205, 247, 247)));
        danhsachgiave.setFont(new java.awt.Font("Lora", 0, 12)); // NOI18N
        danhsachgiave.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "ID loại xe", "ID tuyến xe", "Giá vé"
            }
        ));
        danhsachgiave.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                danhsachgiaveMouseClicked(evt);
            }
        });
        jScrollPane5.setViewportView(danhsachgiave);

        quaylai.setFont(new java.awt.Font("Lora SemiBold", 0, 14)); // NOI18N
        quaylai.setText("Quay lại");
        quaylai.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                quaylaiActionPerformed(evt);
            }
        });

        jLabel23.setFont(new java.awt.Font("Lora", 2, 14)); // NOI18N
        jLabel23.setText("là minh chứng cho chất lượng dịch vụ của hãng xe Thanh Xuân");

        jLabel59.setFont(new java.awt.Font("Lora", 2, 14)); // NOI18N
        jLabel59.setText("Sự hài lòng của quý khách");

        javax.swing.GroupLayout BLayout = new javax.swing.GroupLayout(B);
        B.setLayout(BLayout);
        BLayout.setHorizontalGroup(
            BLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, BLayout.createSequentialGroup()
                .addGap(0, 0, Short.MAX_VALUE)
                .addComponent(jScrollPane5, javax.swing.GroupLayout.PREFERRED_SIZE, 612, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(66, 66, 66))
            .addGroup(BLayout.createSequentialGroup()
                .addGroup(BLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(BLayout.createSequentialGroup()
                        .addGap(147, 147, 147)
                        .addComponent(jPanel10, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(190, 190, 190)
                        .addComponent(quaylai)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jPanel8, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(BLayout.createSequentialGroup()
                        .addGap(200, 200, 200)
                        .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(BLayout.createSequentialGroup()
                        .addGap(126, 126, 126)
                        .addComponent(jLabel23))
                    .addGroup(BLayout.createSequentialGroup()
                        .addGap(250, 250, 250)
                        .addComponent(jLabel59)))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
            .addGroup(BLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(BLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(BLayout.createSequentialGroup()
                        .addGroup(BLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(BLayout.createSequentialGroup()
                                .addComponent(jLabel54)
                                .addGap(0, 0, Short.MAX_VALUE))
                            .addComponent(jSeparator3))
                        .addContainerGap())
                    .addGroup(BLayout.createSequentialGroup()
                        .addComponent(jSeparator1)
                        .addGap(29, 29, 29))))
        );
        BLayout.setVerticalGroup(
            BLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, BLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel54)
                .addGap(12, 12, 12)
                .addComponent(jSeparator1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(jScrollPane5, javax.swing.GroupLayout.PREFERRED_SIZE, 190, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(BLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(quaylai, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jPanel8, javax.swing.GroupLayout.PREFERRED_SIZE, 42, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jPanel10, javax.swing.GroupLayout.PREFERRED_SIZE, 42, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(16, 16, 16)
                .addComponent(jSeparator3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jLabel59)
                .addGap(6, 6, 6)
                .addComponent(jLabel23)
                .addContainerGap())
        );

        A.setBackground(new java.awt.Color(205, 247, 247));
        A.setPreferredSize(new java.awt.Dimension(220, 500));

        Logo2.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Resources/Icon/HÃNG XE KHÁCH (200 × 200 px).png"))); // NOI18N
        Logo2.setToolTipText("");

        Home2.setBackground(new java.awt.Color(251, 250, 238));
        Home2.setPreferredSize(new java.awt.Dimension(200, 20));
        Home2.setRequestFocusEnabled(false);

        jLabel8.setFont(new java.awt.Font("Lora SemiBold", 1, 12)); // NOI18N
        jLabel8.setText("        Trang chủ");

        javax.swing.GroupLayout Home2Layout = new javax.swing.GroupLayout(Home2);
        Home2.setLayout(Home2Layout);
        Home2Layout.setHorizontalGroup(
            Home2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(Home2Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel8)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        Home2Layout.setVerticalGroup(
            Home2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jLabel8, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, 26, Short.MAX_VALUE)
        );

        QL_GiaVe.setBackground(new java.awt.Color(251, 250, 238));
        QL_GiaVe.setPreferredSize(new java.awt.Dimension(200, 26));

        jLabel20.setFont(new java.awt.Font("Lora SemiBold", 1, 12)); // NOI18N
        jLabel20.setText("        Quản lý vé");

        javax.swing.GroupLayout QL_GiaVeLayout = new javax.swing.GroupLayout(QL_GiaVe);
        QL_GiaVe.setLayout(QL_GiaVeLayout);
        QL_GiaVeLayout.setHorizontalGroup(
            QL_GiaVeLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(QL_GiaVeLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel20)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        QL_GiaVeLayout.setVerticalGroup(
            QL_GiaVeLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jLabel20, javax.swing.GroupLayout.DEFAULT_SIZE, 26, Short.MAX_VALUE)
        );

        DangXuat.setBackground(new java.awt.Color(251, 250, 238));
        DangXuat.setPreferredSize(new java.awt.Dimension(200, 26));

        jLabel21.setFont(new java.awt.Font("Lora SemiBold", 1, 12)); // NOI18N
        jLabel21.setText("        Đăng xuất");

        javax.swing.GroupLayout DangXuatLayout = new javax.swing.GroupLayout(DangXuat);
        DangXuat.setLayout(DangXuatLayout);
        DangXuatLayout.setHorizontalGroup(
            DangXuatLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(DangXuatLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel21)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        DangXuatLayout.setVerticalGroup(
            DangXuatLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jLabel21, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, 26, Short.MAX_VALUE)
        );

        QL_GiaVe2.setBackground(new java.awt.Color(251, 250, 238));
        QL_GiaVe2.setPreferredSize(new java.awt.Dimension(200, 26));

        jLabel22.setFont(new java.awt.Font("Lora SemiBold", 0, 12)); // NOI18N
        jLabel22.setText("        Quản lý hành khách");

        javax.swing.GroupLayout QL_GiaVe2Layout = new javax.swing.GroupLayout(QL_GiaVe2);
        QL_GiaVe2.setLayout(QL_GiaVe2Layout);
        QL_GiaVe2Layout.setHorizontalGroup(
            QL_GiaVe2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(QL_GiaVe2Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel22)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        QL_GiaVe2Layout.setVerticalGroup(
            QL_GiaVe2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jLabel22, javax.swing.GroupLayout.DEFAULT_SIZE, 26, Short.MAX_VALUE)
        );

        QL_GiaVe6.setBackground(new java.awt.Color(251, 250, 238));
        QL_GiaVe6.setPreferredSize(new java.awt.Dimension(200, 26));

        jLabel25.setFont(new java.awt.Font("Lora SemiBold", 1, 12)); // NOI18N
        jLabel25.setText("        Quản lý hoàn vé");

        javax.swing.GroupLayout QL_GiaVe6Layout = new javax.swing.GroupLayout(QL_GiaVe6);
        QL_GiaVe6.setLayout(QL_GiaVe6Layout);
        QL_GiaVe6Layout.setHorizontalGroup(
            QL_GiaVe6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(QL_GiaVe6Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel25)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        QL_GiaVe6Layout.setVerticalGroup(
            QL_GiaVe6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jLabel25, javax.swing.GroupLayout.DEFAULT_SIZE, 26, Short.MAX_VALUE)
        );

        javax.swing.GroupLayout ALayout = new javax.swing.GroupLayout(A);
        A.setLayout(ALayout);
        ALayout.setHorizontalGroup(
            ALayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, ALayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(ALayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(QL_GiaVe6, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(QL_GiaVe2, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(DangXuat, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(QL_GiaVe, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(Logo2, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(Home2, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addGap(14, 14, 14))
        );
        ALayout.setVerticalGroup(
            ALayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(ALayout.createSequentialGroup()
                .addComponent(Logo2)
                .addGap(18, 18, 18)
                .addComponent(Home2, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(QL_GiaVe, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(QL_GiaVe6, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(QL_GiaVe2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(DangXuat, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(131, Short.MAX_VALUE))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addComponent(A, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(0, 0, 0)
                .addComponent(B, javax.swing.GroupLayout.PREFERRED_SIZE, 680, javax.swing.GroupLayout.PREFERRED_SIZE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(A, javax.swing.GroupLayout.DEFAULT_SIZE, 503, Short.MAX_VALUE)
            .addComponent(B, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void quaylaiActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_quaylaiActionPerformed
        // TODO add your handling code here:

    }//GEN-LAST:event_quaylaiActionPerformed

    private void nutsuathem_quanlytuyenxeActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_nutsuathem_quanlytuyenxeActionPerformed
        DefaultTableModel suagiave = (DefaultTableModel) danhsachgiave.getModel();
        int i = danhsachgiave.getSelectedRow();
        boolean flag = true;
        if (danhsachgiave.getSelectedRowCount() == 1) {
            String giave = GiaVe.getText();
            int idloaixe = Integer.valueOf((String) IDloaixe.getSelectedItem());
            int idtuyenxe = Integer.valueOf((String) IDtuyenxe.getSelectedItem());
            if (giave.equals("")) {
                JOptionPane.showMessageDialog(this, "Vui lòng nhập giá vé\n");
                flag = false;
            }
            if (flag == true) {
                String giavePattern = "\\d{1,50}";
                boolean flag3 = giave.matches(giavePattern);
                if (flag3 == false) {
                    JOptionPane.showMessageDialog(this, "Giá vé không hợp lệ");
                    flag = false;
                }
                if (flag == true) {
                    Ve1 sgiave = new Ve1();
                    int z = 0;
                    z = sgiave.CapNhatGiaVe(idloaixe, idtuyenxe, giave);
                    if (z > 0) {
                        JOptionPane.showMessageDialog(this, "Sửa thành công!", "Thông báo",
                                JOptionPane.INFORMATION_MESSAGE, null);
                    } else {
                        JOptionPane.showMessageDialog(null, "Error");
                    }
                }
            }
        } else {
            if (danhsachgiave.getSelectedRowCount() == 0) {
                JOptionPane.showMessageDialog(this, "Mời chọn 1 tuyến xe cần sửa!",
                        "Lỗi thao tác", JOptionPane.WARNING_MESSAGE, null);
            } else {
                JOptionPane.showMessageDialog(this, "Vui lòng chỉ chọn 1 tuyến xe cần sửa!",
                        "Lỗi thao tác", JOptionPane.WARNING_MESSAGE, null);
            }
        }

    }//GEN-LAST:event_nutsuathem_quanlytuyenxeActionPerformed

    private void danhsachgiaveMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_danhsachgiaveMouseClicked

    }//GEN-LAST:event_danhsachgiaveMouseClicked

    private void IDtuyenxeActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_IDtuyenxeActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_IDtuyenxeActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {

        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new SuaGiaVe1().setVisible(true);
            }
        });

    }

    public void fillTable() {
        try {
            Class.forName("oracle.jdbc.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "c##TEST3", "Square1");
            java.sql.Statement st = conn.createStatement();
            String sql = "SELECT ID_LOAIXE, ID_TUYENXE, GIAVE FROM GIAVE";
            ResultSet rs = st.executeQuery(sql);

            while (rs.next()) {
                String idloaixe = rs.getString("ID_LOAIXE");
                String idtuyenxe = rs.getString("ID_TUYENXE");
                String giave = String.valueOf(rs.getInt("GIAVE"));
                String tbData[] = {idloaixe, idtuyenxe, giave};
                //               String tbData[] = {diemdi, diemden};
                DefaultTableModel tblModel = (DefaultTableModel) danhsachgiave.getModel();

                tblModel.addRow(tbData);

            }

        } catch (ClassNotFoundException e) {
            JOptionPane.showMessageDialog(null, e);
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, e);
        }
    }

    public void ComboboxIDtuyen() {
        try {
            Connection conn = CheckOracleConnection.getMyConnection();
            String sql = "SELECT ID_TUYENXE FROM TUYENXE";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                IDtuyenxe.addItem(rs.getString(1));
            }
            rs.close();
            pstmt.close();
            conn.close();

        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(this, ex.getMessage());
            ex.printStackTrace();
        } catch (ClassNotFoundException ex) {
            JOptionPane.showMessageDialog(this, ex.getMessage());
            ex.printStackTrace();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(this, e.getMessage());
            e.printStackTrace();
        }
    }

    public void ComboboxIDloai() {
        try {
            Connection conn = CheckOracleConnection.getMyConnection();
            String sql = "SELECT ID_LOAIXE FROM LOAIXE";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                IDloaixe.addItem(rs.getString("ID_LOAIXE"));

            }
            rs.close();
            pstmt.close();
            conn.close();
        }
            catch (Exception e) {
            JOptionPane.showMessageDialog(this, e.getMessage());
            e.printStackTrace();
        }
        }
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JPanel A;
    private javax.swing.JPanel B;
    private javax.swing.JPanel DangXuat;
    private javax.swing.JTextField GiaVe;
    private javax.swing.JPanel Home2;
    private javax.swing.JComboBox<String> IDloaixe;
    private javax.swing.JComboBox<String> IDtuyenxe;
    private javax.swing.JLabel Logo2;
    private javax.swing.JPanel QL_GiaVe;
    private javax.swing.JPanel QL_GiaVe2;
    private javax.swing.JPanel QL_GiaVe6;
    private javax.swing.JTable danhsachgiave;
    private javax.swing.JLabel jLabel20;
    private javax.swing.JLabel jLabel21;
    private javax.swing.JLabel jLabel22;
    private javax.swing.JLabel jLabel23;
    private javax.swing.JLabel jLabel25;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel40;
    private javax.swing.JLabel jLabel42;
    private javax.swing.JLabel jLabel54;
    private javax.swing.JLabel jLabel59;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JPanel jPanel10;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel8;
    private javax.swing.JScrollPane jScrollPane5;
    private javax.swing.JSeparator jSeparator1;
    private javax.swing.JSeparator jSeparator3;
    private javax.swing.JButton nutsua;
    private javax.swing.JButton quaylai;
    // End of variables declaration//GEN-END:variables
}
