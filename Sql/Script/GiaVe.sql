--------------------------------------------------------
-----  DDL for Table GIAVE
--------------------------------------------------------
CREATE TABLE GIAVE 
(   
    ID_LoaiXe NUMBER NOT NULL, 
	ID_TuyenXe NUMBER NOT NULL, 
    GiaVe NUMBER NOT NULL
) SEGMENT CREATION IMMEDIATE 
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
NOCOMPRESS LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS;
--------------------------------------------------------

-----  DDL for Index GV_PK
--------------------------------------------------------
CREATE UNIQUE INDEX GV_PK ON GIAVE (ID_TuyenXe, ID_LoaiXe) 
PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS;
--------------------------------------------------------

-----  Constraints for Table GIAVE
--------------------------------------------------------
ALTER TABLE GIAVE ADD CONSTRAINT GV_PK PRIMARY KEY (ID_TuyenXe, ID_LoaiXe)
USING INDEX GV_PK  ENABLE;
--------------------------------------------------------

-----  Ref Constraints for Table GIAVE
--------------------------------------------------------
ALTER TABLE GIAVE ADD CONSTRAINT GV_LX_FK FOREIGN KEY (ID_LoaiXe)
    REFERENCES LOAIXE (ID_LoaiXe) ON DELETE CASCADE ENABLE;
      
ALTER TABLE GIAVE ADD CONSTRAINT GV_TX_FK FOREIGN KEY (ID_TuyenXe)
    REFERENCES TUYENXE (ID_TuyenXe) ON DELETE CASCADE ENABLE;
--------------------------------------------------------

--------------------------------------------------------

SET SERVEROUTPUT ON;
--------------------------------------------------------
-----  PROCEDURES
----------------------------------------------
-----  Pro_themgiave
CREATE OR REPLACE PROCEDURE Pro_themgiave (
                                            MALX IN   GIAVE.ID_LoaiXe%TYPE,
                                            MATX  IN GIAVE.ID_TuyenXe%TYPE,
                                            GV  IN GIAVE.GiaVe%TYPE)
AS                                          
BEGIN
    Insert into GIAVE (ID_LoaiXe, ID_TuyenXe, GiaVe)  values (MALX, MATX,GV);
    DBMS_OUTPUT.PUT_LINE('Them thanh cong');  
    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
------------------------------
-----  Pro_capnhatgiave
CREATE OR REPLACE PROCEDURE Pro_capnhatgiave (
                                                MALX IN GIAVE.ID_LoaiXe%TYPE,
                                                MATX IN GIAVE.ID_TuyenXe%TYPE,
                                                GV IN GIAVE.GiaVe%TYPE)
AS
BEGIN
    UPDATE GIAVE
    SET    GiaVe=GV
    WHERE ID_LoaiXe=MALX AND  ID_TuyenXe=MATX;
    DBMS_OUTPUT.PUT_LINE('Cap nhat thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
------------------------------
-----  Pro_xoagiave
CREATE OR REPLACE PROCEDURE Pro_xoagiave (
                                                            MATX IN GIAVE.ID_TuyenXe%TYPE,
                                                            MALX IN GIAVE.ID_LoaiXe%TYPE)
AS
BEGIN
        DELETE FROM  GIAVE
        WHERE ID_TuyenXe=MATX AND ID_LoaiXe = MALX;
      
        DBMS_OUTPUT.PUT_LINE('Xoa thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
--------------------------------------------------------
