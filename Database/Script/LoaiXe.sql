--------------------------------------------------------
--  DDL for Sequence LOAIXE_ID
--------------------------------------------------------
CREATE SEQUENCE LOAIXE_ID
INCREMENT BY 1
MINVALUE 004
MAXVALUE 9999999999999999999999999999
NOCYCLE;
--------------------------------------------------------

-----  DDL for Table LOAIXE
--------------------------------------------------------
CREATE TABLE LOAIXE 
(
    ID_LoaiXe NUMBER, 
	TenLoaiXe VARCHAR2(50 BYTE) NOT NULL, 
	SoLuongGhe NUMBER NOT NULL,
    TinhTrang VARCHAR2(20) NOT NULL
) SEGMENT CREATION IMMEDIATE 
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
NOCOMPRESS LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS;
--------------------------------------------------------

--  DDL for Index LX_PK
--------------------------------------------------------
CREATE UNIQUE INDEX LX_PK ON LOAIXE (ID_LoaiXe) 
PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS;
--------------------------------------------------------

-----  Constraints for Table LOAIXE
--------------------------------------------------------
ALTER TABLE LOAIXE ADD CONSTRAINT LX_PK PRIMARY KEY (ID_LoaiXe)
USING INDEX LX_PK  ENABLE;
--------------------------------------------------------


--------------------------------------------------------
SET SERVEROUTPUT ON;
--------------------------------------------------------
-----  FUNCTIONS
--------------------------------------------------------
-----  Func_dieukien_huyloaixe
CREATE OR REPLACE FUNCTION DB_XEKHACH.Func_dieukien_huyloaixe (MALX IN  LOAIXE.ID_LoaiXe%TYPE) RETURN NUMBER
AS
    SLVeDat_LoaiXe INT:=0;
    NGAY DATE;
BEGIN
    SELECT current_date INTO NGAY
    FROM DUAL;
    
    SELECT COUNT(*) INTO SLVeDat_LoaiXe
    FROM VE v JOIN CHUYENXE c ON v.ID_ChuyenXe=c.ID_ChuyenXe
    WHERE c.ID_Xe IN (SELECT ID_Xe
                                        FROM XE
                                        WHERE ID_LoaiXe=MALX)
                    AND v.TinhTrang = 'Đã đặt' AND c.ThoiGianKH > NGAY;
    IF (SLVeDat_LoaiXe > 0) THEN
        RETURN 0;
    ELSE RETURN 1;
    END IF;
END;
/
--------------------------------------------------------

--------------------------------------------------------
-----  PROCEDURES
--------------------------------------------------------
-----  Pro_themloaixe
CREATE OR REPLACE PROCEDURE Pro_themloaixe (
                                            TENLX IN LOAIXE.TenLoaiXe%TYPE,
                                            SLG IN LOAIXE.SoLuongGhe%TYPE)
AS
BEGIN
    Insert into LOAIXE (ID_LoaiXe, TenLoaiXe, SoLuongGhe,TinhTrang)  values (LOAIXE_ID.NEXTVAL, TENLX,SLG,'Hoạt động');
    DBMS_OUTPUT.PUT_LINE('Them thanh cong');
    EXCEPTION 
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
------------------------------
-----  Pro_capnhatloaixe
CREATE OR REPLACE PROCEDURE Pro_capnhatloaixe (
                                            MALX IN LOAIXE.ID_LoaiXe%TYPE,
                                            TENLX IN LOAIXE.TenLoaiXe%TYPE,
                                            SLG IN LOAIXE.SoLuongGhe%TYPE)
AS
BEGIN
    UPDATE LOAIXE
    SET    TenLoaiXe=TENLX, SoLuongGhe=SLG
    WHERE ID_LoaiXe=MALX;
    DBMS_OUTPUT.PUT_LINE('Cap nhat thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
------------------------------
-----  Pro_huyloaixe
CREATE OR REPLACE PROCEDURE Pro_huyloaixe (MALX IN LOAIXE.ID_LoaiXe%TYPE)
AS
        NGAY DATE;
BEGIN
    IF (Func_dieukien_huyloaixe (MALX) = 1) THEN
        SELECT current_date INTO NGAY
        FROM DUAL;

        DELETE FROM VE
        WHERE ID_ChuyenXe IN (SELECT ID_ChuyenXe
                                                    FROM CHUYENXE c JOIN XE x ON c.ID_Xe=x.ID_XE
                                                    WHERE ID_LOAIXE=MALX AND ThoiGianKH > NGAY);
                                                    
        DELETE FROM CHUYENXE
        WHERE ID_Xe IN (SELECT ID_Xe
                                            FROM XE
                                            WHERE ID_LOAIXE=MALX)
                         AND ThoiGianKH > NGAY;                                            
        
        DELETE FROM GIAVE
        WHERE ID_LoaiXe=MALX;
        
        UPDATE XE SET TinhTrang='Đã hủy'
        WHERE ID_LoaiXe=MALX;
        
        UPDATE LOAIXE SET TinhTrang='Đã hủy'
        WHERE ID_LoaiXe=MALX;
                                                    
        DBMS_OUTPUT.PUT_LINE('Huy thanh cong!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Khong du dieu kien huy loai xe!');
    END IF;
    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/