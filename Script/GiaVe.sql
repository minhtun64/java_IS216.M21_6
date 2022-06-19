--------------------------------------------------------
--  DDL for Sequence GIAVE_ID
-------------------------------------------------------
CREATE SEQUENCE GIAVE_ID
INCREMENT BY 1
MINVALUE 100000019
MAXVALUE 9999999999999999999999999999
NOCYCLE;
--------------------------------------------------------

--  DDL for Table GIAVE
--------------------------------------------------------
  CREATE TABLE GIAVE 
(   ID_GiaVe NUMBER, 
    ID_LoaiXe NUMBER NOT NULL, 
	ID_TuyenXe NUMBER NOT NULL, 
    GiaVe NUMBER NOT NULL,
    TinhTrang VARCHAR2(20) NOT NULL
) SEGMENT CREATION IMMEDIATE 
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
NOCOMPRESS LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS ;
--------------------------------------------------------

--  DDL for Index GIAVE_PK
--------------------------------------------------------
CREATE UNIQUE INDEX GV_PK ON GIAVE (ID_GiaVe) 
PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS ;
--------------------------------------------------------

--  Constraints for Table GIAVE
--------------------------------------------------------
ALTER TABLE GIAVE ADD CONSTRAINT GV_PK PRIMARY KEY (ID_GiaVe)
USING INDEX GV_PK  ENABLE;
--------------------------------------------------------

--  Ref Constraints for Table GIAVE
--------------------------------------------------------
ALTER TABLE GIAVE ADD CONSTRAINT GV_LX_FK FOREIGN KEY (ID_LoaiXe)
    REFERENCES LOAIXE (ID_LoaiXe) ON DELETE CASCADE ENABLE;
      
ALTER TABLE GIAVE ADD CONSTRAINT GV_TX_FK FOREIGN KEY (ID_TuyenXe)
    REFERENCES TUYENXE (ID_TuyenXe) ON DELETE CASCADE ENABLE;
--------------------------------------------------------

--  TRIGGER for Table GIAVE
--------------------------------------------------------
--  Trig_HuyGiaVe
CREATE OR REPLACE TRIGGER Trig_HuyGiaVe
BEFORE  UPDATE ON GIAVE
FOR EACH ROW
DECLARE SLVeMua_GiaVe INT :=0;
BEGIN
   IF (:new.tinhtrang = 'Đã hủy') THEN
        SELECT COUNT(*) INTO SLVeMua_GiaVe
        FROM VE v JOIN CHUYENXE c ON v.ID_ChuyenXe=c.ID_ChuyenXe
        WHERE v.ID_GiaVe=:new.ID_GiaVe AND v.TinhTrang IN ('Chưa thanh toán', 'Đã thanh toán') AND c.ThoiGianKH > current_date;
        IF (SLVeMua_GiaVe > 0) THEN
            RAISE_APPLICATION_ERROR (-20983, 'Khong the huy gia ve da co dat ve tuong lai');
        END IF;
    END IF;        
END;
/
--------------------------------------------------------

SET SERVEROUTPUT ON;
--------------------------------------------------------
--  PROCEDURE for table GIAVE
----------------------------------------------
--Pro_themgiave
CREATE OR REPLACE PROCEDURE Pro_themgiave(
                                            MALX IN   GIAVE.ID_LoaiXe%TYPE,
                                            MATX  IN GIAVE.ID_TuyenXe%TYPE,
                                            GV  IN GIAVE.GiaVe%TYPE)
AS                                          
BEGIN
    Insert into GIAVE (ID_GiaVe, ID_LoaiXe, ID_TuyenXe, GiaVe,TinhTrang)  values (GIAVE_ID.NEXTVAL,MALX, MATX,GV,'Hoạt động');
    DBMS_OUTPUT.PUT_LINE('Them thanh cong');  
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
------------------------------
--  Pro_capnhatgiave
CREATE OR REPLACE PROCEDURE Pro_capnhatgiave
                                                (MAGV IN GIAVE.ID_GiaVe%TYPE,
                                                MALX IN GIAVE.ID_LoaiXe%TYPE,
                                                MATX IN GIAVE.ID_TuyenXe%TYPE,
                                                GV IN GIAVE.GiaVe%TYPE)
AS
BEGIN
    UPDATE GIAVE
    SET    ID_LoaiXe=MALX, ID_TuyenXe=MATX, GiaVe=GV
    WHERE ID_GiaVe=MAGV;
    DBMS_OUTPUT.PUT_LINE('Cap nhat thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
------------------------------
--Pro_huygiave
CREATE OR REPLACE PROCEDURE Pro_huygiave(MAGV IN GIAVE.ID_GiaVe%TYPE)
AS
BEGIN
        UPDATE GIAVE SET TinhTrang='Đã hủy'
        WHERE ID_GiaVe=MAGV;
      
        DBMS_OUTPUT.PUT_LINE('Huy thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
--------------------------------------------------------

--  FUNCTION for table GIAVE
--------------------------------------------------------
--  Func_kiemtra_huygiave
CREATE OR REPLACE FUNCTION Func_kiemtra_huygiave (MAGV IN OUT  GIAVE.ID_GiaVe%TYPE) RETURN NUMBER
AS
    SLVeMua_GiaVe INT :=0;
BEGIN
    SELECT COUNT(*) INTO SLVeMua_GiaVe
    FROM VE v JOIN CHUYENXE c ON v.ID_ChuyenXe=c.ID_ChuyenXe
    WHERE v.ID_GiaVe=MAGV AND v.TinhTrang IN ('Chưa thanh toán', 'Đã thanh toán') AND c.ThoiGianKH > current_date;
    IF (SLVeMua_GiaVe > 0) THEN
        RETURN 0;
    ELSE RETURN 1;
    END IF;
END;
/
--------------------------------------------------------
