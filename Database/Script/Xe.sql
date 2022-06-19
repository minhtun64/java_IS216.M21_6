--------------------------------------------------------
--  DDL for Sequence XE_ID
--------------------------------------------------------
CREATE SEQUENCE XE_ID
INCREMENT BY 1
MINVALUE 123
MAXVALUE 9999999999999999999999999999
NOCYCLE;
--------------------------------------------------------

-----  DDL for Table XE 
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

-----  DDL for Index XE_PK
--------------------------------------------------------
CREATE UNIQUE INDEX XE_PK ON XE (ID_Xe) 
PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS;
--------------------------------------------------------

-----  Constraints for Table XE
--------------------------------------------------------
ALTER TABLE XE ADD CONSTRAINT XE_PK PRIMARY KEY (ID_Xe)
USING INDEX XE_PK  ENABLE;
--------------------------------------------------------

-----  Ref Constraints for Table XE
--------------------------------------------------------
ALTER TABLE XE ADD CONSTRAINT XE_LX_FK FOREIGN KEY (ID_LoaiXe)
    REFERENCES LOAIXE (ID_LoaiXe) ON DELETE CASCADE ENABLE;
--------------------------------------------------------

--------------------------------------------------------

SET SERVEROUTPUT ON;
--------------------------------------------------------
-----  FUNCTIONS
--------------------------------------------------------
-----  Func_dieukien_huyxe
CREATE OR REPLACE FUNCTION Func_dieukien_huyxe (MAXE IN  XE.ID_Xe%TYPE) RETURN NUMBER
AS
    SLVeDat_Xe INT :=0;
    NGAY DATE;
BEGIN
    SELECT current_date INTO NGAY
    FROM DUAL;
    
    SELECT COUNT(*) INTO SLVeDat_Xe
    FROM VE v JOIN CHUYENXE c ON v.ID_ChuyenXe=c.ID_ChuyenXe
    WHERE c.ID_Xe=MaXe AND v.TinhTrang = 'Đã đặt' AND c.ThoiGianKH > NGAY;
    IF (SLVeDat_Xe > 0) THEN
        RETURN 0;
    ELSE RETURN 1;
    END IF;
END;
/
--------------------------------------------------------

--------------------------------------------------------
-----  PROCEDURES
----------------------------------------------
-----  Pro_themxe
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
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(' Khong xac dinh!');
END;
/
------------------------------
-----  Pro_capnhatxe
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
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
------------------------------
-----  Pro_huyxe
CREATE OR REPLACE PROCEDURE Pro_huyxe (MAXE IN XE.ID_Xe%TYPE)
AS
        NGAY DATE;
BEGIN
    IF (Func_dieukien_huyxe(MAXE) = 1) THEN
        SELECT current_date INTO NGAY
        FROM DUAL;
        
        DELETE FROM VE
        WHERE ID_ChuyenXe IN (SELECT ID_ChuyenXe
                                                    FROM CHUYENXE
                                                    WHERE ID_Xe=MAXE AND ThoiGianKH > NGAY);
        
        DELETE FROM CHUYENXE
        WHERE ID_Xe = MAXE AND ThoiGianKH > NGAY;                   
    
        UPDATE XE SET TinhTrang='Đã hủy'
        WHERE ID_Xe=MAXE;
                         
        DBMS_OUTPUT.PUT_LINE('Huy thanh cong!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Khong du dieu kien huy xe!');
    END IF;
    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
--------------------------------------------------------