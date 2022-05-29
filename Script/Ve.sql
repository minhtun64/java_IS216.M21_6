--------------------------------------------------------
--  DDL for Sequence VE_ID
-------------------------------------------------------
CREATE SEQUENCE VE_ID
INCREMENT BY 1
MINVALUE 10044
MAXVALUE 9999999999999999999999999999
NOCYCLE;
--------------------------------------------------------

--  DDL for Table VE
--------------------------------------------------------
CREATE TABLE VE
(	ID_Ve NUMBER, 
    ID_HanhKhach NUMBER NOT NULL, 
	ID_ChuyenXe NUMBER NOT NULL, 
    ID_Ghe NUMBER NOT NULL, 
	ID_GiaVe NUMBER NOT NULL,
    ID_NhanVien NUMBER,
    NgayThem DATE NOT NULL,
    TinhTrang VARCHAR2(20) NOT NULL
) SEGMENT CREATION IMMEDIATE 
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
NOCOMPRESS LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS ;
--------------------------------------------------------

--  DDL for Index VE_PK
--------------------------------------------------------
CREATE UNIQUE INDEX VE_PK ON VE (ID_Ve) 
PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS;
--------------------------------------------------------

--  Constraints for Table VE
--------------------------------------------------------
ALTER TABLE VE ADD CONSTRAINT VE_PK PRIMARY KEY (ID_Ve)
USING INDEX VE_PK  ENABLE;
--------------------------------------------------------

--  Ref Constraints for Table VE
--------------------------------------------------------
ALTER TABLE VE ADD CONSTRAINT VE_HK_FK FOREIGN KEY (ID_HanhKhach)
    REFERENCES HANHKHACH (ID_HanhKhach) ON DELETE CASCADE ENABLE;
      
ALTER TABLE VE ADD CONSTRAINT VE_CK_FK FOREIGN KEY (ID_ChuyenXe)
    REFERENCES CHUYENXE (ID_ChuyenXe) ON DELETE CASCADE ENABLE;

ALTER TABLE VE ADD CONSTRAINT VE_GHE_FK FOREIGN KEY (ID_Ghe)
    REFERENCES GHE (ID_Ghe) ON DELETE CASCADE ENABLE;
      
ALTER TABLE VE ADD CONSTRAINT VE_GV_FK FOREIGN KEY (ID_GiaVe)
    REFERENCES GIAVE (ID_GiaVe) ON DELETE CASCADE ENABLE;
      
ALTER TABLE VE ADD CONSTRAINT VE_NV_FK FOREIGN KEY (ID_NhanVien)
    REFERENCES NHANVIEN (ID_NhanVien) ON DELETE CASCADE ENABLE;
--------------------------------------------------------

--TRIGGER for table VE
--------------------------------------------------------
--Trig_CapNhatDoanhThu
CREATE OR REPLACE TRIGGER Trig_CapNhatDoanhThu
AFTER INSERT OR UPDATE ON VE
FOR EACH ROW
DECLARE
GIAVE_ChuyenXe  NUMBER;
BEGIN
    SELECT GiaVe INTO GIAVE_ChuyenXe
    FROM GIAVE
    WHERE ID_GiaVe = :new.ID_GiaVe;

    IF (:new.TinhTrang = 'Đã thanh toán') THEN
        UPDATE CHUYENXE
        SET DOANHTHU = DOANHTHU + GIAVE_ChuyenXe
        WHERE ID_CHUYENXE = :new.ID_ChuyenXe;
        
        ELSIF (:new.TinhTrang = 'Đã hoàn') THEN
            UPDATE CHUYENXE
            SET DOANHTHU = DOANHTHU - GIAVE_ChuyenXe * 0.8
            WHERE ID_CHUYENXE = :new.ID_ChuyenXe;
    END IF;
END;
/
------------------------------
-- Trig_DieuKien_ThanhToanVe
CREATE OR REPLACE TRIGGER Trig_DieuKien_ThanhToanVe
BEFORE INSERT OR UPDATE ON VE
FOR EACH ROW
BEGIN
    IF (:new.TinhTrang = 'Đã thanh toán') THEN
        IF (:old.TinhTrang = 'Đã hoàn' OR :old.TinhTrang = 'Đã hủy') THEN
            RAISE_APPLICATION_ERROR (-20977, 'Khong the thanh toan ve da huy hoac da hoan');
        END IF;
    END IF;
END;
/
------------------------------
-- Trig_DieuKien_HoanVe
CREATE OR REPLACE TRIGGER Trig_DieuKien_HoanVe
BEFORE INSERT OR UPDATE ON VE
FOR EACH ROW
BEGIN
    IF (:new.TinhTrang = 'Đã hoàn') THEN
        IF (:old.TinhTrang = 'Đã hủy' OR :old.TinhTrang = 'Chưa thanh toán') THEN
            RAISE_APPLICATION_ERROR (-20975, 'Khong the hoan ve da huy hoac chua thanh toan');
        END IF;
    END IF;
END;
/
--------------------------------------------------------

SET SERVEROUTPUT  ON;
--  PROCEDURE for table VE
--------------------------------------------------------
--  Pro_thanhtoanve
CREATE OR REPLACE PROCEDURE Pro_thanhtoanve(MAVE IN VE.ID_Ve%TYPE)
AS
BEGIN
    UPDATE VE
    SET TinhTrang='Đã thanh toán'
    WHERE ID_Ve=MAVE;
    EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
------------------------------
--  Pro_themve_khachhang
CREATE OR REPLACE PROCEDURE Pro_themve_khachhang (
                                        MAKH IN VE.ID_HanhKhach%TYPE,
                                        MACX IN VE.ID_ChuyenXe%TYPE,
                                        MAGHE IN VE.ID_Ghe%TYPE,
                                        MAGV IN VE.ID_GiaVe%TYPE,
                                        HANHKHACH_HOTEN IN   HANHKHACH.TenHK%TYPE,
                                        HANHKHACH_SDT IN  HANHKHACH.SDT%TYPE,
                                        HANHKHACH_CMND IN HANHKHACH.CMND%TYPE,
                                        HANHKHACH_EMAIL IN  HANHKHACH.Email%TYPE)
AS
BEGIN
    Insert into HANHKHACH (ID_HanhKhach,TenHK, SDT, CMND, Email,TinhTrang)  
        values (HANHKHACH_ID.NEXTVAL, HANHKHACH_HOTEN, HANHKHACH_SDT, HANHKHACH_CMND, HANHKHACH_EMAIL,'Hoạt động');

    Insert into VE (ID_Ve,ID_HanhKhach, ID_ChuyenXe, ID_Ghe, ID_GiaVe, ID_NhanVien, NgayThem, TinhTrang)  
        values (VE_ID.NEXTVAL,HANHKHACH_ID.CURRVAL,MACX,MAGHE,MAGV,null,current_date,'Chưa thanh toán');
    DBMS_OUTPUT.PUT_LINE('Them thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
------------------------------
--  Pro_themve_nhanvien
CREATE OR REPLACE PROCEDURE Pro_themve_nhanvien (
                                        MAKH IN VE.ID_HanhKhach%TYPE,
                                        MACX IN VE.ID_ChuyenXe%TYPE,
                                        MAGHE IN VE.ID_Ghe%TYPE,
                                        MAGV IN VE.ID_GiaVe%TYPE,
                                        MANV IN VE.ID_NhanVien%TYPE,
                                        HANHKHACH_HOTEN IN   HANHKHACH.TenHK%TYPE,
                                        HANHKHACH_SDT IN  HANHKHACH.SDT%TYPE,
                                        HANHKHACH_CMND IN HANHKHACH.CMND%TYPE,
                                        HANHKHACH_EMAIL IN  HANHKHACH.Email%TYPE)
AS
BEGIN
    Insert into HANHKHACH (ID_HanhKhach,TenHK, SDT, CMND, Email,TinhTrang)  
        values (HANHKHACH_ID.NEXTVAL, HANHKHACH_HOTEN, HANHKHACH_SDT, HANHKHACH_CMND, HANHKHACH_EMAIL,'Hoạt động');
    
    Insert into VE (ID_Ve,ID_HanhKhach, ID_ChuyenXe, ID_Ghe, ID_GiaVe, ID_NhanVien, NgayThem, TinhTrang)  
        values (VE_ID.NEXTVAL,HANHKHACH_ID.CURRVAL,MACX,MAGHE,MAGV,MANV,current_date,'Đã thanh toán');
    DBMS_OUTPUT.PUT_LINE('Them thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
------------------------------
--  Pro_huyve
CREATE OR REPLACE PROCEDURE Pro_huyve (MAVE IN VE.ID_Ve%TYPE)
AS
MAHK VE.ID_HanhKhach%TYPE;
BEGIN
    UPDATE VE
    SET TinhTrang = 'Đã hủy'
    WHERE ID_Ve = MAVE;
    
    SELECT ID_HanhKhach INTO MAHK
    FROM VE
    WHERE ID_Ve = MAVE;
    
    UPDATE HANHKHACH
    SET TinhTrang = 'Đã hủy'
    WHERE ID_HanhKhach = MAHK;
    
    DBMS_OUTPUT.PUT_LINE('Huy thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
--------------------------------------------------------
--FUNCTION for table VE
--------------------------------------------------------
--  Func_kiemtra_thanhtoanve
CREATE OR REPLACE FUNCTION Func_kiemtra_thanhtoanve (MAVE  IN VE.ID_Ve%TYPE) RETURN NUMBER
AS
MACX VE.ID_CHUYENXE%TYPE;
NGAYKH CHUYENXE.THOIGIANKH%TYPE;
TINHTRANGVE VE.TINHTRANG%TYPE;
BEGIN
    SELECT ID_CHUYENXE INTO MACX
    FROM VE
    WHERE ID_VE = MAVE;

    SELECT ThoiGianKH INTO  NGAYKH
    FROM CHUYENXE
    WHERE ID_ChuyenXe = MACX;
    
    SELECT TINHTRANG INTO TINHTRANGVE
    FROM VE
    WHERE ID_VE = MAVE;
    
    IF (NGAYKH < current_date OR TINHTRANGVE IN ('Đã hủy', 'Đã thanh toán','Đã hoàn')) THEN
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
--  Func_kiemtra_hoanve
CREATE OR REPLACE FUNCTION Func_kiemtra_hoanve (MAVE  IN VE.ID_Ve%TYPE) RETURN NUMBER
AS
MACX VE.ID_ChuyenXe%TYPE;
NGAYKH CHUYENXE.ThoiGianKH%TYPE;
TINHTRANGVE VE.TinhTrang%TYPE;
BEGIN
    SELECT ID_CHUYENXE INTO MACX
    FROM VE
    WHERE ID_VE = MAVE;

    SELECT ThoiGianKH INTO  NGAYKH
    FROM CHUYENXE
    WHERE ID_ChuyenXe = MACX;
    
    SELECT TINHTRANG INTO TINHTRANGVE
    FROM VE
    WHERE ID_VE = MAVE;
    
    IF (NGAYKH < current_date OR TINHTRANGVE IN ('Đã hủy', 'Chưa thanh toán','Đã hoàn')) THEN
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
--  Func_phihoanve
CREATE OR REPLACE FUNCTION Func_phihoanve (MAVE  IN VE.ID_Ve%TYPE) RETURN NUMBER
AS
MAGV VE.ID_GiaVe%TYPE;
GIA GIAVE.GiaVe%TYPE;
PHIHOAN HOANVE.PhiHV%TYPE;
BEGIN
    SELECT ID_GiaVe INTO MAGV
    FROM VE
    WHERE ID_Ve = MAVE;

    SELECT GiaVe INTO  GIA
    FROM GIAVE
    WHERE ID_GiaVe = MAGV;
    
    PHIHOAN := GIA * 0.2;
    
    RETURN PHIHOAN;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
         DBMS_OUTPUT.PUT_LINE('KHONG CO DU LIEU');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('KHONG XAC DINH!');
END;
/
--  Func_tienhoanve
CREATE OR REPLACE FUNCTION Func_tienhoanve (MAVE  IN VE.ID_Ve%TYPE) RETURN NUMBER
AS
MAGV VE.ID_GiaVe%TYPE;
GIA GIAVE.GiaVe%TYPE;
TIENHOAN HOANVE.TienHV%TYPE;
BEGIN
    SELECT ID_GiaVe INTO MAGV
    FROM VE
    WHERE ID_Ve = MAVE;

    SELECT GiaVe INTO  GIA
    FROM GIAVE
    WHERE ID_GiaVe = MAGV;
    
    TIENHOAN := GIA * 0.8;
    
    RETURN TIENHOAN;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
         DBMS_OUTPUT.PUT_LINE('KHONG CO DU LIEU');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('KHONG XAC DINH!');
END;
/
--------------------------------------------------------