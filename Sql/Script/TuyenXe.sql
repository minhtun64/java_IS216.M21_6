--------------------------------------------------------
--  DDL for Sequence TUYENXE_ID
--------------------------------------------------------
CREATE SEQUENCE TUYENXE_ID
  INCREMENT BY 1
  MINVALUE 1007
  MAXVALUE 9999999999999999999999999999
  NOCYCLE;
--------------------------------------------------------

--  DDL for Table TUYENXE
--------------------------------------------------------
CREATE TABLE TUYENXE 
(
    ID_TuyenXe NUMBER, 
    TenTuyen VARCHAR2(50 BYTE) NOT NULL, 
	DiemDau VARCHAR2(50 BYTE) NOT NULL,
    DiemCuoi VARCHAR2(50 BYTE) NOT NULL,
    SoKm NUMBER NOT NULL,
    SoGioDi NUMBER NOT NULL,
    TinhTrang VARCHAR2(20) NOT NULL
) SEGMENT CREATION IMMEDIATE 
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
NOCOMPRESS LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS;
--------------------------------------------------------

--  DDL for Index TX_PK
--------------------------------------------------------
CREATE UNIQUE INDEX TX_PK ON TUYENXE (ID_TuyenXe) 
PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS;
--------------------------------------------------------

-----  Constraints for Table TUYENXE
--------------------------------------------------------
ALTER TABLE TUYENXE ADD CONSTRAINT TX_PK PRIMARY KEY (ID_TuyenXe)
USING INDEX TX_PK  ENABLE;
--------------------------------------------------------

--------------------------------------------------------

SET SERVEROUTPUT ON;
--------------------------------------------------------
-----  FUNCTIONS
--------------------------------------------------------
-----  Func_dieukien_huytuyenxe
CREATE OR REPLACE FUNCTION Func_dieukien_huytuyenxe (MATX IN TUYENXE.ID_TuyenXe%TYPE) RETURN NUMBER
AS
    SLVeDat_TuyenXe INT :=0;
    NGAY DATE;
BEGIN
    SELECT current_date INTO NGAY
    FROM DUAL;

    SELECT COUNT(*) INTO SLVeDat_TuyenXe
    FROM VE v JOIN CHUYENXE c ON v.ID_ChuyenXe=c.ID_ChuyenXe
    WHERE c.ID_TuyenXe=MATX AND v.TinhTrang = 'Đã đặt' AND c.ThoiGianKH > NGAY;
    IF (SLVeDat_TuyenXe > 0) THEN
        RETURN 0;
    ELSE RETURN 1;
    END IF;
END;
/
--------------------------------------------------------

--------------------------------------------------------
-----  PROCEDURES
----------------------------------------------
-----  Pro_themtuyenxe
CREATE OR REPLACE PROCEDURE Pro_themtuyenxe (
                                            TENTX IN  TUYENXE.TenTuyen%TYPE,
                                            DDAU  IN TUYENXE.DiemDau%TYPE,
                                            DCUOI  IN TUYENXE.DiemCuoi%TYPE,
                                            SKM  IN TUYENXE.SoKm%TYPE,
                                            SOGDI  IN TUYENXE.SoGioDi%TYPE)
AS
BEGIN
    Insert into TUYENXE (ID_TuyenXe,TenTuyen, DiemDau, DiemCuoi, SoKm, SoGioDi,TinhTrang)
        values (TUYENXE_ID.NEXTVAL, TENTX,DDAU,DCUOI,SKM,SOGDI,'Hoạt động');
    DBMS_OUTPUT.PUT_LINE('Them thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
------------------------------
-----  Pro_capnhattuyenxe
CREATE OR REPLACE PROCEDURE Pro_capnhattuyenxe (
                                            MATX IN TUYENXE.ID_TuyenXe%TYPE,
                                            TENTX IN  TUYENXE.TenTuyen%TYPE,
                                            DDAU  IN TUYENXE.DiemDau%TYPE,
                                            DCUOI  IN TUYENXE.DiemCuoi%TYPE,
                                            SKM  IN TUYENXE.SoKm%TYPE,
                                            SOGDI  IN TUYENXE.SoGioDi%TYPE)
AS
BEGIN
    UPDATE TUYENXE
    SET    TenTuyen=TENTX, DiemDau=DDAU, DiemCuoi=DCUOI, SoKm=SKM, SoGioDi=SOGDI
    WHERE ID_TuyenXe=MATX;
    DBMS_OUTPUT.PUT_LINE('Cap nhat thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
------------------------------
-----  Pro_huytuyenxe
CREATE OR REPLACE PROCEDURE Pro_huytuyenxe (MATX IN TUYENXE.ID_TuyenXe%TYPE)
AS
    NGAY DATE;
BEGIN
    IF (Func_dieukien_huytuyenxe(MATX) = 1) THEN
        SELECT current_date INTO NGAY
        FROM DUAL;
    
        DELETE FROM VE
        WHERE ID_ChuyenXe IN (SELECT ID_ChuyenXe
                                                        FROM CHUYENXE
                                                        WHERE ID_TUYENXE=MATX AND ThoiGianKH > NGAY);
        
        DELETE FROM CHUYENXE
        WHERE ID_TuyenXe=MATX AND ThoiGianKH > NGAY;
    
        DELETE FROM GIAVE
        WHERE ID_TuyenXe=MATX;
    
        UPDATE TUYENXE SET TinhTrang='Đã hủy'
        WHERE ID_TuyenXe=MATX;

        DBMS_OUTPUT.PUT_LINE('Huy thanh cong!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Khong du dieu kien huy tuyen xe!');
    END IF;
    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
--------------------------------------------------------