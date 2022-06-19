-------------------------------------------------------
-----  DDL for Sequence HOANVE_ID
-------------------------------------------------------
CREATE SEQUENCE HOANVE_ID
INCREMENT BY 1
MINVALUE 11011
MAXVALUE 9999999999999999999999999999
NOCYCLE;
--------------------------------------------------------

-----  DDL for Table HOANVE
--------------------------------------------------------
CREATE TABLE HOANVE
(	
    ID_HoanVe NUMBER, 
    ID_DatVe NUMBER NOT NULL, 
	ID_NhanVien NUMBER NOT NULL, 
    NgayHoan DATE NOT NULL, 
	PhiHV NUMBER NOT NULL,
    TienHV NUMBER NOT NULL
) SEGMENT CREATION IMMEDIATE 
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
NOCOMPRESS LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS;
--------------------------------------------------------

-----  DDL for Index HV_PK
--------------------------------------------------------
CREATE UNIQUE INDEX HV_PK ON HOANVE (ID_HoanVe) 
PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS;
--------------------------------------------------------

-----  Constraints for Table HOANVE
--------------------------------------------------------
ALTER TABLE HOANVE ADD CONSTRAINT HV_PK PRIMARY KEY (ID_HoanVe)
USING INDEX HV_PK  ENABLE;
--------------------------------------------------------

-----  Ref Constraints for Table HOANVE
--------------------------------------------------------
ALTER TABLE HOANVE ADD CONSTRAINT HV_DV_FK FOREIGN KEY (ID_DatVe)
    REFERENCES DATVE (ID_DatVe) ON DELETE CASCADE ENABLE;
      
ALTER TABLE HOANVE ADD CONSTRAINT HV_NV_FK FOREIGN KEY (ID_NhanVien)
    REFERENCES NHANVIEN (ID_NhanVien) ON DELETE CASCADE ENABLE;
--------------------------------------------------------

SET SERVEROUTPUT  ON;
------------------------------
-----  FUNCTIONS
--------------------------------------------------------
-----  Func_phihoanve
CREATE OR REPLACE FUNCTION Func_phihoanve (MADV IN DATVE.ID_DatVe%TYPE) RETURN NUMBER
AS
    NGAY DATE;
    KC_NGAY NUMBER;
    TIEN DATVE.TongTien%TYPE;
    PHIHOAN HOANVE.PhiHV%TYPE;
    MAVE DATVE.ID_Ve%TYPE;
    MACX VE.ID_ChuyenXe%TYPE;
    TGKH CHUYENXE.ThoiGianKH%TYPE;
BEGIN
    SELECT current_date INTO NGAY
    FROM DUAL;
    
    SELECT TongTien INTO  TIEN
    FROM DATVE
    WHERE ID_DaTVe = MADV;
    
    SELECT ID_Ve INTO MAVE
    FROM DATVE
    WHERE ID_DatVe = MADV;
    
    SELECT ID_ChuyenXe INTO MACX
    FROM VE
    WHERE ID_Ve = MAVE;
    
    SELECT ThoiGianKH INTO TGKH
    FROM CHUYENXE
    WHERE ID_ChuyenXe = MACX;
    
    KC_NGAY := TGKH - NGAY;
    
    IF (KC_NGAY > 30) THEN
        PHIHOAN := TIEN * 0.1;
    ELSIF (KC_NGAY > 15) THEN
        PHIHOAN := TIEN * 0.2;
    ELSE
        PHIHOAN := TIEN * 0.3;
    END IF;
    RETURN PHIHOAN;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
         DBMS_OUTPUT.PUT_LINE('KHONG CO DU LIEU');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('KHONG XAC DINH!');
END;
/
------------------------------
-----  Func_tienhoanve
CREATE OR REPLACE FUNCTION Func_tienhoanve (MADV IN DATVE.ID_DatVe%TYPE) RETURN NUMBER
AS
    NGAY DATE;
    KC_NGAY NUMBER;
    TIEN DATVE.TongTien%TYPE;
    TIENHOAN HOANVE.TienHV%TYPE;
    MAVE DATVE.ID_Ve%TYPE;
    MACX VE.ID_ChuyenXe%TYPE;
    TGKH CHUYENXE.ThoiGianKH%TYPE;
BEGIN
    SELECT current_date INTO NGAY
    FROM DUAL;
    
    SELECT TongTien INTO  TIEN
    FROM DATVE
    WHERE ID_DatVe = MADV;

    SELECT ID_Ve INTO MAVE
    FROM DATVE
    WHERE ID_DatVe = MADV;
    
    SELECT ID_ChuyenXe INTO MACX
    FROM VE
    WHERE ID_Ve = MAVE;
    
    SELECT ThoiGianKH INTO TGKH
    FROM CHUYENXE
    WHERE ID_ChuyenXe = MACX;
    
    KC_NGAY := TGKH - NGAY;
    
    IF (KC_NGAY > 30) THEN
        TIENHOAN := TIEN * 0.9;
    ELSIF (KC_NGAY > 15) THEN
        TIENHOAN := TIEN * 0.8;
    ELSE
        TIENHOAN := TIEN * 0.7;
    END IF;
    RETURN TIENHOAN;
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
-----  Pro_themhoanve
CREATE OR REPLACE PROCEDURE Pro_themhoanve (
                                            MADV  HOANVE.ID_DatVe%TYPE,
                                            MANV HOANVE.ID_NhanVien %TYPE)
AS
    NGAY DATE;
    MAVE DATVE.ID_Ve%TYPE;
    MACX  VE.ID_ChuyenXe%TYPE;
    MAHK DATVE.ID_HanhKhach%TYPE;
    PHV  HOANVE.PhiHV %TYPE;
    THV  HOANVE.TienHV %TYPE;
BEGIN
    IF (Func_dieukien_hoanve (MADV) = 1) THEN
        SELECT current_date INTO NGAY
        FROM DUAL;
        
        PHV:= Func_phihoanve (MADV);
        THV:= Func_tienhoanve (MADV);
        
        Insert into HOANVE (ID_HoanVe, ID_DatVe, ID_NhanVien, NgayHoan , PhiHV, TienHV) 
                values (HoanVe_ID.NEXTVAL, MADV, MANV, NGAY, PHV,THV);
        
        UPDATE DATVE
        SET TinhTrang = 'Đã hoàn'
        WHERE ID_DatVe = MADV;
    
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
    
        UPDATE HANHKHACH
        SET TinhTrang = 'Đã hủy'
        WHERE ID_HanhKhach = MAHK;
    
        DBMS_OUTPUT.PUT_LINE('Them thanh cong');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Khong du dieu kien hoan ve');
    END IF;
    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
--------------------------------------------------------