--------------------------------------------------------
--  DDL for Sequence CHUYENXE_ID
-------------------------------------------------------
CREATE SEQUENCE CHUYENXE_ID
  INCREMENT BY 1
  MINVALUE 100310
  MAXVALUE 9999999999999999999999999999
  NOCYCLE;
--------------------------------------------------------


--  DDL for Table CHUYENXE
--------------------------------------------------------
CREATE TABLE CHUYENXE
(   ID_ChuyenXe NUMBER, 
    ID_TuyenXe NUMBER NOT NULL,
    ID_Xe NUMBER NOT NULL, 
	ID_NQL NUMBER NOT NULL, 
    DiemDi VARCHAR2(50 BYTE) NOT NULL, 
	DiemDen VARCHAR2(50 BYTE) NOT NULL,
    ThoiGianKH DATE NOT NULL,
    ThoiGianDen DATE NOT NULL,
    TaiXe VARCHAR2(50 BYTE) NOT NULL,
    PhuXe VARCHAR2(50 BYTE) NOT NULL,
    DoanhThu NUMBER NOT NULL,
    TinhTrang VARCHAR2(20) NOT NULL
) SEGMENT CREATION IMMEDIATE 
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
NOCOMPRESS LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS;
--------------------------------------------------------

--  DDL for Index CHUYENXE_PK
--------------------------------------------------------
CREATE UNIQUE INDEX CX_PK ON CHUYENXE (ID_ChuyenXe) 
PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS;
--------------------------------------------------------

--  Constraints for Table CHUYENXE
--------------------------------------------------------
ALTER TABLE CHUYENXE ADD CONSTRAINT CX_PK PRIMARY KEY (ID_ChuyenXe)
USING INDEX CX_PK  ENABLE;
--------------------------------------------------------

--  Ref Constraints for Table CHUYENXE
--------------------------------------------------------     
ALTER TABLE CHUYENXE ADD CONSTRAINT CX_TX_FK FOREIGN KEY (ID_TuyenXe)
    REFERENCES TUYENXE (ID_TuyenXe) ON DELETE CASCADE ENABLE;
      
ALTER TABLE CHUYENXE ADD CONSTRAINT CX_XE_FK FOREIGN KEY (ID_Xe)
    REFERENCES XE (ID_Xe) ON DELETE CASCADE ENABLE;
      
ALTER TABLE CHUYENXE ADD CONSTRAINT CX_NQL_FK FOREIGN KEY (ID_NQL)
    REFERENCES NGUOIQUANLY (ID_NQL) ON DELETE CASCADE ENABLE;
--------------------------------------------------------

--TRIGGER for table CHUYENXE
--------------------------------------------------------
--  Trig_HuyChuyenXe
CREATE OR REPLACE TRIGGER Trig_HuyChuyenXe
BEFORE  UPDATE ON CHUYENXE
FOR EACH ROW
DECLARE SLGheDat_ChuyenXe INT :=0;
BEGIN
   IF (:new.tinhtrang = 'Đã hủy') THEN
        IF (:new.ThoiGianKH < current_date) THEN
            RAISE_APPLICATION_ERROR (-20981, 'Khong the huy chuyen xe da khoi hanh');
        ELSE
            SELECT COUNT(*) INTO SLGheDat_ChuyenXe
            FROM GHE
            WHERE ID_ChuyenXe=:new.ID_ChuyenXe AND TinhTrang = 'Đã đặt';
            IF (SLGheDat_ChuyenXe > 0) THEN
            RAISE_APPLICATION_ERROR (-20980, 'Khong the huy chuyen xe da co dat ve tuong lai');    
            END IF; 
        END IF;
    END IF;
END;
--------------------------------------------------------

SET SERVEROUTPUT ON;
--------------------------------------------------------
--  PROCEDURE for table CHUYENXE
----------------------------------------------
--  Pro_themchuyenxe
CREATE OR REPLACE PROCEDURE Pro_themchuyenxe (
                                                MATX IN CHUYENXE.ID_TuyenXe%TYPE,
                                                MAXE IN CHUYENXE.ID_Xe%TYPE,
                                                MANQL IN CHUYENXE.ID_NQL%TYPE,
                                                DDI IN CHUYENXE.DiemDi%TYPE, 
                                                DDEN IN CHUYENXE.DiemDen%TYPE,
                                                TGKH IN CHUYENXE.ThoiGianKH%TYPE,
                                                TGDEN IN  CHUYENXE.ThoiGianDen%TYPE,
                                                TX IN CHUYENXE.TaiXe%TYPE,
                                                PX IN CHUYENXE.PhuXe%TYPE)
AS
BEGIN
    Insert into ChuyenXe (ID_ChuyenXe, ID_TuyenXe, ID_Xe, ID_NQL, DiemDi, DiemDen, ThoiGianKH, ThoiGianDen, TaiXe, PhuXe, DoanhThu, TinhTrang)
        values (ChuyenXe_ID.NEXTVAL, MATX,MAXE, MANQL, DDI, DDEN, TGKH, TGDEN, TX, PX, 0, 'Hoạt động');
    DBMS_OUTPUT.PUT_LINE('Them thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
----------------------------------------------
-- Pro_capnhatchuyenxe
CREATE OR REPLACE PROCEDURE Pro_capnhatchuyenxe (
                                                MACX IN CHUYENXE.ID_ChuyenXe%TYPE,
                                                MATX IN CHUYENXE.ID_TuyenXe%TYPE,
                                                MAXE IN CHUYENXE.ID_Xe%TYPE,
                                                MANQL IN CHUYENXE.ID_NQL%TYPE,
                                                DDI IN CHUYENXE.DiemDi%TYPE, 
                                                DDEN IN CHUYENXE.DiemDen%TYPE,
                                                TGKH IN CHUYENXE.ThoiGianKH%TYPE,
                                                TGDEN IN  CHUYENXE.ThoiGianDen%TYPE,
                                                TX IN CHUYENXE.TaiXe%TYPE,
                                                PX IN CHUYENXE.PhuXe%TYPE)
AS
BEGIN
    UPDATE CHUYENXE
    SET  ID_TuyenXe=MATX, ID_Xe=MAXE, ID_NQL=MANQL, DiemDi=DDI, DiemDen=DDEN,
            ThoiGianKH=TGKH, ThoiGianDen=TGDEN, TaiXe=TX, PhuXe=PX
    WHERE ID_ChuyenXe=MACX;
    DBMS_OUTPUT.PUT_LINE('Cap nhat thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
----------------------------------------------
-- Pro_huychuyenxe
CREATE OR REPLACE PROCEDURE Pro_huychuyenxe (MACX IN CHUYENXE.ID_ChuyenXe%TYPE)
AS
BEGIN
        UPDATE CHUYENXE SET TinhTrang='Đã hủy'
        WHERE ID_ChuyenXe=MACX;
        
        UPDATE GHE SET TinhTrang='Đã hủy'
        WHERE ID_ChuyenXe=MACX;
                         
        DBMS_OUTPUT.PUT_LINE('Huy thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
--------------------------------------------------------

-- FUNCTION for table CHUYENXE
--------------------------------------------------------
-- Func_kiemtra_fullghe
CREATE OR REPLACE FUNCTION Func_kiemtra_fullghe (MACX IN OUT  CHUYENXE.ID_ChuyenXe%TYPE) RETURN NUMBER
AS
    SLGHETRONG INT:=0;
BEGIN
    SELECT COUNT(*) INTO SLGHETRONG
    FROM GHE
    WHERE ID_ChuyenXe = MACX AND TinhTrang='Trống';
    IF (SLGHETRONG = 0) THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
         DBMS_OUTPUT.PUT_LINE(' KHONG CO DU LIEU');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' KHONG XAC DINH!');
END;
----------------------------------------------
--  Func_kiemtra_huychuyenxe
CREATE OR REPLACE FUNCTION Func_kiemtra_huychuyenxe (MACX IN CHUYENXE.ID_ChuyenXe%TYPE) RETURN NUMBER
AS
    NGAYKH CHUYENXE.ThoiGianKH%TYPE;
    SLGheDat_ChuyenXe INT :=0;
BEGIN
    SELECT ThoiGianKH INTO NGAYKH
    FROM CHUYENXE
    WHERE ID_ChuyenXe = MACX;
    
    IF (NGAYKH < current_date) THEN
        RETURN 1;
    ELSE
        SELECT COUNT(*) INTO SLGheDat_ChuyenXe
        FROM GHE
        WHERE ID_ChuyenXe=MACX AND TinhTrang = 'Đã đặt';
        IF (SLGheDat_ChuyenXe > 0) THEN
            RETURN 1;
        END IF; 
    END IF;
END;
/
--------------------------------------------------------
