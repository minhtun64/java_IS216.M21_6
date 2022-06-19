--------------------------------------------------------
-----  DDL for Sequence DATVE_ID
--------------------------------------------------------
CREATE SEQUENCE DATVE_ID
INCREMENT BY 1
MINVALUE 10044
MAXVALUE 9999999999999999999999999999
NOCYCLE;
--------------------------------------------------------

-----  DDL for Table DATVE
--------------------------------------------------------
CREATE TABLE DATVE
(	
    ID_DatVe NUMBER, 
    ID_HanhKhach NUMBER NOT NULL,
    ID_Ve NUMBER NOT NULL,
    ID_NhanVien NUMBER,
    NgayThem DATE NOT NULL,
    TongTien number NOT NULL,
    TinhTrang VARCHAR2(20) NOT NULL
) SEGMENT CREATION IMMEDIATE 
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
NOCOMPRESS LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS;
--------------------------------------------------------

-----  DDL for Index DV_PK
--------------------------------------------------------
CREATE UNIQUE INDEX DV_PK ON DATVE (ID_DatVe) 
PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS;
--------------------------------------------------------

-----  Constraints for Table DATVE
--------------------------------------------------------
ALTER TABLE DATVE ADD CONSTRAINT DV_PK PRIMARY KEY (ID_DatVe)
USING INDEX DV_PK  ENABLE;
--------------------------------------------------------

-----  Ref Constraints for Table DATVE
--------------------------------------------------------
ALTER TABLE DATVE ADD CONSTRAINT DV_HK_FK FOREIGN KEY (ID_HanhKhach)
    REFERENCES HANHKHACH (ID_HanhKhach) ON DELETE CASCADE ENABLE;

ALTER TABLE DATVE ADD CONSTRAINT DV_VE_FK FOREIGN KEY (ID_Ve)
    REFERENCES VE (ID_Ve) ON DELETE CASCADE ENABLE;
      
ALTER TABLE DATVE ADD CONSTRAINT DV_NV_FK FOREIGN KEY (ID_NhanVien)
    REFERENCES NHANVIEN (ID_NhanVien) ON DELETE CASCADE ENABLE;
--------------------------------------------------------


-----  TRIGGER for Table DATVE
--------------------------------------------------------
-----  Trig_CapNhatDoanhThu
CREATE OR REPLACE TRIGGER Trig_CapNhatDoanhThu
AFTER INSERT OR UPDATE ON DATVE
FOR EACH ROW
DECLARE MACX VE.ID_ChuyenXe%TYPE;
BEGIN
    SELECT ID_ChuyenXe INTO MACX
    FROM VE
    WHERE ID_Ve = :new.ID_Ve;
    
    IF (:new.TinhTrang = 'Đã thanh toán') THEN
        UPDATE CHUYENXE
        SET DoanhThu = DoanhThu + :new.TongTien
        WHERE ID_CHUYENXE = MACX;
        
        ELSIF (:new.TinhTrang = 'Đã hoàn') THEN
            UPDATE CHUYENXE
            SET DoanhThu = DoanhThu - :new.TongTien * 0.8
            WHERE ID_CHUYENXE = MACX;
    END IF;
END;
--------------------------------------------------------

SET SERVEROUTPUT  ON;
--------------------------------------------------------
-----  FUNCTIONS
--------------------------------------------------------
-----  Func_dieukien_thanhtoanve
CREATE OR REPLACE FUNCTION Func_dieukien_thanhtoanve (MADV IN DATVE.ID_DatVe%TYPE) RETURN NUMBER
AS
        NGAY DATE;
        MAVE DATVE.ID_Ve%TYPE;
        MACX VE.ID_ChuyenXe%TYPE;
        NGAYKH CHUYENXE.ThoiGianKH%TYPE;
        TINHTRANGVE DATVE.TinhTrang%TYPE;
BEGIN
    SELECT current_date INTO NGAY
    FROM DUAL;
    
    SELECT ID_VE INTO MAVE
    FROM DATVE
    WHERE ID_DATVE = MADV;
    
    SELECT ID_ChuyenXe INTO MACX
    FROM VE
    WHERE ID_VE = MAVE;

    SELECT ThoiGianKH INTO NGAYKH
    FROM CHUYENXE
    WHERE ID_ChuyenXe = MACX;
    
    SELECT TinhTrang INTO TINHTRANGVE
    FROM DATVE
    WHERE ID_DatVe = MADV;
    
    IF (NGAYKH < NGAY OR TINHTRANGVE IN ('Đã thanh toán','Đã hoàn')) THEN
        RETURN 0;
    ELSE
        RETURN 1;
    END IF;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
         DBMS_OUTPUT.PUT_LINE('KHONG CO DU LIEU');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('KHONG XAC DINH!');
END;
/
------------------------------
-----  Func_tinhtongtien
CREATE OR REPLACE FUNCTION Func_tinhtongtien (MACX IN CHUYENXE.ID_ChuyenXe%TYPE) RETURN NUMBER
AS
        MATX TUYENXE.ID_TuyenXe%TYPE;
        MAXE XE.ID_Xe%TYPE;
        MALX LOAIXE.ID_LoaiXe%TYPE;
        GIA GIAVE.GiaVe%TYPE;
BEGIN

    SELECT ID_TuyenXe INTO MATX
    FROM CHUYENXE
    WHERE ID_ChuyenXe = MACX;
    
    SELECT ID_Xe INTO MAXE
    FROM CHUYENXE
    WHERE ID_ChuyenXe = MACX;
    
    SELECT ID_LoaiXe INTO MALX
    FROM XE
    WHERE ID_Xe = MAXE;
    
    SELECT GiaVe INTO GIA
    FROM GIAVE
    WHERE ID_TuyenXe = MATX AND ID_LoaiXe = MALX;
    
    RETURN GIA;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
         DBMS_OUTPUT.PUT_LINE('KHONG CO DU LIEU');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('KHONG XAC DINH!');
END;
/
--------------------------------------------------------

--------------------------------------------------------
-----  PROCEDURES
--------------------------------------------------------
-----  Pro Sleep
CREATE OR REPLACE PROCEDURE sleep (in_time NUMBER )
AS
    NOW DATE;
BEGIN
    SELECT current_date INTO NOW
    FROM DUAL;

    LOOP
    EXIT WHEN NOW + (in_time * (1/86400)) <= current_date;
    END LOOP;
END;
/
------------------------------
-----  Pro_themdatve_khachhang
CREATE OR REPLACE PROCEDURE Pro_themdatve_khachhang (
                                        MAVE IN DATVE.ID_Ve%TYPE,
                                        HANHKHACH_HOTEN IN   HANHKHACH.TenHK%TYPE,
                                        HANHKHACH_SDT IN  HANHKHACH.SDT%TYPE,
                                        HANHKHACH_CMND IN HANHKHACH.CMND%TYPE,
                                        HANHKHACH_EMAIL IN  HANHKHACH.Email%TYPE)
AS
        NGAY DATE;
        GIA GIAVE.GiaVe%TYPE;
        MACX VE.ID_ChuyenXe%TYPE;
BEGIN
    Insert into HANHKHACH (ID_HanhKhach,TenHK, SDT, CMND, Email,TinhTrang)  
        values (HANHKHACH_ID.NEXTVAL, HANHKHACH_HOTEN, HANHKHACH_SDT, HANHKHACH_CMND, HANHKHACH_EMAIL,'Hoạt động');

    SELECT current_date INTO NGAY
    FROM DUAL;
    
    SELECT ID_ChuyenXe INTO MACX
    FROM VE
    WHERE ID_VE = MAVE; 
    
    GIA := Func_tinhtongtien(MACX);

    Insert into DATVE (ID_DatVe, ID_HanhKhach, ID_Ve, ID_NhanVien, NgayThem, TongTien, TinhTrang)  
        values (DATVE_ID.NEXTVAL, HANHKHACH_ID.CURRVAL, MAVE, null, NGAY, GIA, 'Chưa thanh toán');
    
    UPDATE VE
    SET TinhTrang = 'Đã đặt'
    WHERE ID_Ve = MAVE;
    
    UPDATE CHUYENXE
    SET SLVeCon = SLVeCon - 1
    WHERE ID_ChuyenXe = MACX;
    
    DBMS_OUTPUT.PUT_LINE('Them thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Loi!');
    
    Sleep(10);
    
END;
/
------------------------------
-----  Pro_themdatve_nhanvien
CREATE OR REPLACE PROCEDURE Pro_themdatve_nhanvien (
                                        MAVE IN DATVE.ID_Ve%TYPE,
                                        MANV IN DATVE.ID_NhanVien%TYPE,
                                        HANHKHACH_HOTEN IN   HANHKHACH.TenHK%TYPE,
                                        HANHKHACH_SDT IN  HANHKHACH.SDT%TYPE,
                                        HANHKHACH_CMND IN HANHKHACH.CMND%TYPE,
                                        HANHKHACH_EMAIL IN  HANHKHACH.Email%TYPE)
AS
        NGAY DATE;
        GIA GIAVE.GiaVe%TYPE;
        MACX VE.ID_ChuyenXe%TYPE;
BEGIN
    Insert into HANHKHACH (ID_HanhKhach,TenHK, SDT, CMND, Email,TinhTrang)  
        values (HANHKHACH_ID.NEXTVAL, HANHKHACH_HOTEN, HANHKHACH_SDT, HANHKHACH_CMND, HANHKHACH_EMAIL,'Hoạt động');

    SELECT current_date INTO NGAY
    FROM DUAL;
    
    SELECT ID_ChuyenXe INTO MACX
    FROM VE
    WHERE ID_VE = MAVE; 
    
    GIA := Func_tinhtongtien(MACX);
    
    Insert into DATVE (ID_DatVe, ID_HanhKhach, ID_Ve, ID_NhanVien, NgayThem, TongTien, TinhTrang)  
        values (DATVE_ID.NEXTVAL, HANHKHACH_ID.CURRVAL, MAVE, MANV, NGAY, GIA, 'Đã thanh toán');
    
    UPDATE VE
    SET TinhTrang = 'Đã đặt'
    WHERE ID_Ve = MAVE;
    
    UPDATE CHUYENXE
    SET SLVeCon = SLVeCon - 1
    WHERE ID_ChuyenXe = MACX;
    
    DBMS_OUTPUT.PUT_LINE('Them thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Loi!');
        
    Sleep(10);
    
END;
/
------------------------------
-----  Pro_thanhtoanve
CREATE OR REPLACE PROCEDURE Pro_thanhtoanve (
                                                                MADV IN DATVE.ID_Ve%TYPE,
                                                                MANV IN DATVE.ID_Ve%TYPE)
AS
BEGIN
    IF (func_dieukien_thanhtoanve(MADV) = 1) THEN
        UPDATE DATVE
        SET TinhTrang='Đã thanh toán', ID_NhanVien=MANV
        WHERE ID_DatVe=MADV;
        
        DBMS_OUTPUT.PUT_LINE('Thanh toan ve thanh cong!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Khong du dieu kien thanh toan ve!');
    END IF;
    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
------------------------------
-----  Pro_xoadatve
CREATE OR REPLACE PROCEDURE Pro_xoadatve (MADV IN DATVE.ID_DatVe%TYPE)
AS
    MAVE DATVE.ID_Ve%TYPE;
    MACX  VE.ID_ChuyenXe%TYPE;
    MAHK DATVE.ID_HanhKhach%TYPE;
BEGIN
    
    SELECT ID_Ve INTO MAVE
    FROM DATVE
    WHERE ID_DatVe = MADV;
    
    SELECT ID_ChuyenXe INTO MACX
    FROM VE
    WHERE ID_Ve = MAVE;
    
    SELECT ID_HanhKhach INTO MAHK
    FROM DATVE
    WHERE ID_DatVe = MADV;
    
    UPDATE VE
    SET TinhTrang = 'Trống'
    WHERE ID_Ve = MAVE;
    
    UPDATE CHUYENXE
    SET SLVeCon = SLVeCon + 1
    WHERE ID_ChuyenXe = MACX;
    
    DELETE FROM DATVE
    WHERE ID_DatVe = MADV;
    
    DELETE FROM HANHKHACH
    WHERE ID_HanhKhach = MAHK;
    
    DBMS_OUTPUT.PUT_LINE('Huy thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
--------------------------------------------------------