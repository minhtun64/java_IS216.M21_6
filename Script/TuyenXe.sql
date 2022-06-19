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
TABLESPACE USERS ;
--------------------------------------------------------

--  DDL for Index TX_PK
--------------------------------------------------------
  CREATE UNIQUE INDEX TX_PK ON TUYENXE (ID_TuyenXe) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE USERS ;
--------------------------------------------------------

--  Constraints for Table TUYENXE
--------------------------------------------------------
ALTER TABLE TUYENXE ADD CONSTRAINT TX_PK PRIMARY KEY (ID_TuyenXe)
USING INDEX TX_PK  ENABLE;
--------------------------------------------------------

--  TRIGGER for Table TUYENXE
--------------------------------------------------------
--Trig_HuyTuyenXe
CREATE OR REPLACE TRIGGER Trig_HuyTuyenXe
BEFORE  UPDATE ON TUYENXE
FOR EACH ROW
DECLARE SLGheDat_Tuyen INT :=0;
BEGIN
   IF (:new.tinhtrang = 'Đã hủy') THEN
        SELECT COUNT(*) INTO SLGheDat_Tuyen
        FROM GHE g JOIN CHUYENXE c ON g.ID_ChuyenXe=c.ID_ChuyenXe
        WHERE c.ID_TuyenXe=:new.ID_tuyenxe AND g.TinhTrang = 'Đã đặt' AND c.ThoiGianKH > current_date;
        IF (SLGheDat_Tuyen > 0) THEN
            RAISE_APPLICATION_ERROR (-20985, 'Khong the huy tuyen da co dat ve tuong lai');
        END IF;
    END IF;        
END;
/
--------------------------------------------------------

SET SERVEROUTPUT ON;
--------------------------------------------------------
--  PROCEDURE for table TUYENXE
----------------------------------------------
--  Pro_themtuyenxe
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
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
------------------------------
--  Pro_capnhattuyenxe
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
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
------------------------------
--  Pro_huytuyenxe
CREATE OR REPLACE PROCEDURE Pro_huytuyenxe(MATX IN TUYENXE.ID_TuyenXe%TYPE)
AS 
BEGIN
    UPDATE TUYENXE SET TinhTrang='Đã hủy'
    WHERE ID_TuyenXe=MATX;
    
    UPDATE GIAVE SET TinhTrang='Đã hủy'
    WHERE ID_TuyenXe=MATX;
        
    UPDATE CHUYENXE SET TinhTrang='Đã hủy'
    WHERE ID_TuyenXe=MATX AND ThoiGianKH > current_date;
            
    UPDATE GHE SET TinhTrang='Đã hủy'
    WHERE ID_ChuyenXe IN (SELECT ID_ChuyenXe
                                                    FROM CHUYENXE
                                                    WHERE ID_TUYENXE=MATX AND ThoiGianKH > current_date);
    
    DBMS_OUTPUT.PUT_LINE('Huy thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
--------------------------------------------------------

--  FUNCTION for table TUYENXE 
--------------------------------------------------------
--  Func_kiemtra_huytuyenxe
CREATE OR REPLACE FUNCTION Func_kiemtra_huytuyenxe (MATX IN TUYENXE.ID_TuyenXe%TYPE) RETURN NUMBER
AS
    SLGheDat_Tuyen INT :=0;
BEGIN
    SELECT COUNT(*) INTO SLGheDat_Tuyen
    FROM GHE g JOIN CHUYENXE c ON g.ID_ChuyenXe=c.ID_ChuyenXe
    WHERE c.ID_TuyenXe=MATX AND g.TinhTrang = 'Đã đặt' AND c.ThoiGianKH > current_date;
    IF (SLGheDat_Tuyen > 0) THEN
        RETURN 0;
    ELSE RETURN 1;
    END IF;
END;
/
--------------------------------------------------------