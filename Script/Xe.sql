--------------------------------------------------------
--  DDL for Sequence XE_ID
-------------------------------------------------------
CREATE SEQUENCE XE_ID
INCREMENT BY 1
MINVALUE 123
MAXVALUE 9999999999999999999999999999
NOCYCLE;
--------------------------------------------------------
--  DDL for Table XE 
--------------------------------------------------------
CREATE TABLE XE 
(
    ID_Xe NUMBER, 
    ID_LoaiXe NUMBER NOT NULL,
    TenXe VARCHAR2(50 BYTE) NOT NULL, 
	MauXe VARCHAR2(20 BYTE) NOT NULL,
    HangSX VARCHAR2(50 BYTE) NOT NULL,
    BienSo VARCHAR2(20 BYTE) NOT NULL,
    TinhTrang VARCHAR2(20) NOT NULL
) SEGMENT CREATION IMMEDIATE 
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
NOCOMPRESS LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS;
--------------------------------------------------------

--  DDL for Index XE_PK
--------------------------------------------------------
CREATE UNIQUE INDEX XE_PK ON XE (ID_Xe) 
PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS ;
--------------------------------------------------------

--  Constraints for Table XE
--------------------------------------------------------
ALTER TABLE XE ADD CONSTRAINT XE_PK PRIMARY KEY (ID_Xe)
USING INDEX XE_PK  ENABLE;
--------------------------------------------------------

--  Ref Constraints for Table XE
--------------------------------------------------------
ALTER TABLE XE ADD CONSTRAINT XE_LX_FK FOREIGN KEY (ID_LoaiXe)
    REFERENCES LOAIXE (ID_LoaiXe) ON DELETE CASCADE ENABLE;
--------------------------------------------------------


-- TRIGGER for Table XE
--------------------------------------------------------
--  Trig_HuyXe
CREATE OR REPLACE TRIGGER Trig_HuyXe
BEFORE  UPDATE ON XE
FOR EACH ROW
DECLARE SLGheDat_Xe INT :=0;
BEGIN
   IF (:new.tinhtrang = 'Đã hủy') THEN
        SELECT COUNT(*) INTO SLGheDat_Xe
        FROM GHE g JOIN CHUYENXE c ON g.ID_ChuyenXe=c.ID_ChuyenXe
        WHERE c.ID_Xe=:new.ID_Xe AND g.TinhTrang = 'Đã đặt' AND c.ThoiGianKH > current_date;
        IF (SLGheDat_Xe > 0) THEN
            RAISE_APPLICATION_ERROR (-20982, 'Khong the huy xe da co dat ve tuong lai');
        END IF;
    END IF;        
END;
/
--------------------------------------------------------

SET SERVEROUTPUT ON;
--------------------------------------------------------
--  PROCEDURE for table XE
----------------------------------------------
--  Pro_themxe
CREATE OR REPLACE PROCEDURE Pro_themxe (
                                        MALX IN XE.ID_LoaiXe%TYPE,
                                        TENX IN XE.TenXe%TYPE,
                                        MX IN XE.MauXe%TYPE,
                                        HSX  IN XE.HangSX%TYPE,
                                        BS IN XE.BienSo%TYPE)
AS
BEGIN
    Insert into XE (ID_Xe, ID_LoaiXe, TenXe, MauXe, HangSX, BienSo,TinhTrang)
        values (XE_ID.NEXTVAL, MALX,TENX,MX,HSX,BS,'Hoạt động');
    DBMS_OUTPUT.PUT_LINE(' Them thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' Khong xac dinh!');
END;
------------------------------
--  Pro_capnhatxe
CREATE OR REPLACE PROCEDURE Pro_capnhatxe (
                                        MAXE IN XE.ID_Xe%TYPE,
                                        MALX IN XE.ID_LoaiXe%TYPE, 
                                        TENX IN XE.TenXe%TYPE,
                                        MX IN XE.MauXe%TYPE,
                                        HSX  IN XE.HangSX%TYPE,
                                        BS IN XE.BienSo%TYPE)
AS
BEGIN
    UPDATE XE
    SET    ID_LoaiXe=MALX, TenXe=TENX, MauXe=MX, HangSX=HSX, BienSo=BS
    WHERE ID_Xe=MAXE;
    DBMS_OUTPUT.PUT_LINE('Cap nhat thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
------------------------------
--Pro_huyxe
CREATE OR REPLACE PROCEDURE Pro_huyxe (MAXE IN XE.ID_Xe%TYPE)
AS
BEGIN
        UPDATE XE SET TinhTrang='Đã hủy'
        WHERE ID_Xe=MAXE;
        
        UPDATE CHUYENXE SET TinhTrang='Đã hủy'
        WHERE ID_Xe = MAXE AND ThoiGianKH > current_date;
        
        UPDATE GHE SET TinhTrang='Đã hủy'
        WHERE ID_ChuyenXe IN (SELECT ID_ChuyenXe
                                                    FROM CHUYENXE
                                                    WHERE ID_Xe=MAXE AND ThoiGianKH > current_date);
                         
        DBMS_OUTPUT.PUT_LINE('Huy thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
--------------------------------------------------------

--  FUNCTION for table XE
--------------------------------------------------------
--  Func_kiemtra_huyxe
CREATE OR REPLACE FUNCTION Func_kiemtra_huyxe (MAXE IN OUT  XE.ID_Xe%TYPE) RETURN NUMBER
AS
    SLGheDat_Xe INT :=0;
BEGIN
    SELECT COUNT(*) INTO SLGheDat_Xe
    FROM GHE g JOIN CHUYENXE c ON g.ID_ChuyenXe=c.ID_ChuyenXe
    WHERE c.ID_Xe=MaXe AND g.TinhTrang = 'Đã đặt' AND c.ThoiGianKH > current_date;
    IF (SLGheDat_Xe > 0) THEN
        RETURN 0;
    ELSE RETURN 1;
    END IF;
END;
/
--------------------------------------------------------