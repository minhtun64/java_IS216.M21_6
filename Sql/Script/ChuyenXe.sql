--------------------------------------------------------
-----  DDL for Sequence CHUYENXE_ID
--------------------------------------------------------
CREATE SEQUENCE CHUYENXE_ID
  INCREMENT BY 1
  MINVALUE 100310
  MAXVALUE 9999999999999999999999999999
  NOCYCLE;
--------------------------------------------------------

-----  DDL for Table CHUYENXE
--------------------------------------------------------
CREATE TABLE CHUYENXE
(   
    ID_ChuyenXe NUMBER, 
    ID_TuyenXe NUMBER NOT NULL,
    ID_Xe NUMBER NOT NULL, 
	ID_NQL NUMBER NOT NULL, 
    DiemDi VARCHAR2(50 BYTE) NOT NULL, 
	DiemDen VARCHAR2(50 BYTE) NOT NULL,
    ThoiGianKH DATE NOT NULL,
    ThoiGianDen DATE NOT NULL,
    TaiXe VARCHAR2(50 BYTE) NOT NULL,
    PhuXe VARCHAR2(50 BYTE) NOT NULL,
    SLVeCon number,
    DoanhThu NUMBER NOT NULL
) SEGMENT CREATION IMMEDIATE 
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
NOCOMPRESS LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS;
--------------------------------------------------------

-----  DDL for Index CX_PK
--------------------------------------------------------
CREATE UNIQUE INDEX CX_PK ON CHUYENXE (ID_ChuyenXe) 
PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS;
--------------------------------------------------------

-----  Constraints for Table CHUYENXE
--------------------------------------------------------
ALTER TABLE CHUYENXE ADD CONSTRAINT CX_PK PRIMARY KEY (ID_ChuyenXe)
USING INDEX CX_PK  ENABLE;
--------------------------------------------------------

-----  Ref Constraints for Table CHUYENXE
--------------------------------------------------------     
ALTER TABLE CHUYENXE ADD CONSTRAINT CX_TX_FK FOREIGN KEY (ID_TuyenXe)
    REFERENCES TUYENXE (ID_TuyenXe) ON DELETE CASCADE ENABLE;
      
ALTER TABLE CHUYENXE ADD CONSTRAINT CX_XE_FK FOREIGN KEY (ID_Xe)
    REFERENCES XE (ID_Xe) ON DELETE CASCADE ENABLE;
      
ALTER TABLE CHUYENXE ADD CONSTRAINT CX_NQL_FK FOREIGN KEY (ID_NQL)
    REFERENCES NGUOIQUANLY (ID_NQL) ON DELETE CASCADE ENABLE;
--------------------------------------------------------

--------------------------------------------------------

SET SERVEROUTPUT ON;
--------------------------------------------------------
-----  FUNCTIONS
--------------------------------------------------------
-----  Func_dieukien_xoachuyenxe
CREATE OR REPLACE FUNCTION Func_dieukien_xoachuyenxe (MACX IN CHUYENXE.ID_ChuyenXe%TYPE) RETURN NUMBER
AS
    NGAY DATE;
    NGAYKH CHUYENXE.ThoiGianKH%TYPE;
    SLVeDat_ChuyenXe INT :=0;
BEGIN
    SELECT ThoiGianKH INTO NGAYKH
    FROM CHUYENXE
    WHERE ID_ChuyenXe = MACX;
    
    SELECT current_date INTO NGAY
    FROM DUAL;
    
    IF (NGAYKH < NGAY) THEN
        RETURN 0;
    ELSE
        SELECT COUNT(*) INTO SLVeDat_ChuyenXe
        FROM VE
        WHERE ID_ChuyenXe=MACX AND TinhTrang = 'Đã đặt';
        IF (SLVeDat_ChuyenXe > 0) THEN
            RETURN 0;
        END IF; 
    END IF;
    RETURN 1;
END;
/
--------------------------------------------------------

--------------------------------------------------------
-----  PROCEDURES
----------------------------------------------
-----  Pro_themchuyenxe
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
    MALX LOAIXE.ID_LOAIXE%TYPE;
    SLGHE LOAIXE.SoLuongGhe%TYPE;
    VTGHE VE.ViTriGhe%TYPE; 
BEGIN
    SELECT  ID_LoaiXe INTO MALX
    FROM XE
    WHERE ID_Xe= MAXE;
    
    SELECT SoLuongGhe INTO SLGHE
    FROM LOAIXE
    WHERE ID_LoaiXe= MALX;
    
    Insert into ChuyenXe (ID_ChuyenXe, ID_TuyenXe, ID_Xe, ID_NQL, DiemDi, DiemDen,
                        ThoiGianKH, ThoiGianDen, TaiXe, PhuXe, SLVeCon, DoanhThu)
        values (ChuyenXe_ID.NEXTVAL, MATX,MAXE, MANQL, DDI, DDEN, TGKH, TGDEN, TX, PX,SLGHE, 0);
    
    FOR VTGHE IN 1..SLGHE
    LOOP
        Insert into Ve (ID_Ve, ID_ChuyenXe, ViTriGhe, TinhTrang) values (VE_ID.NEXTVAL, ChuyenXe_ID.CURRVAL, VTGHE, 'Trống');
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Them thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Loi!');
    
END;
/
------------------------------
-----  Pro_capnhatchuyenxe
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
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
------------------------------
-----  Pro_xoachuyenxe
CREATE OR REPLACE PROCEDURE Pro_xoachuyenxe (MACX IN CHUYENXE.ID_ChuyenXe%TYPE)
AS
BEGIN
    IF (Func_dieukien_xoachuyenxe(MACX) = 1) THEN
        DELETE FROM VE
        WHERE ID_ChuyenXe=MACX;

        DELETE FROM CHUYENXE
        WHERE ID_ChuyenXe=MACX;
        
        DBMS_OUTPUT.PUT_LINE('Xoa thanh cong');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Khong du dieu kien xoa chuyen xe');
    END IF;
    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
--------------------------------------------------------