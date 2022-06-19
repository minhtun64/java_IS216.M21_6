--------------------------------------------------------
--  DDL for Sequence GHE_ID
CREATE SEQUENCE GHE_ID
  INCREMENT BY 1
  MINVALUE 200961
  MAXVALUE 9999999999999999999999999999
  NOCYCLE;
--------------------------------------------------------

--  DDL for Table GHE
--------------------------------------------------------
  CREATE TABLE GHE
(	
    ID_Ghe NUMBER, 
    ID_ChuyenXe NUMBER NOT NULL,
    TenGhe VARCHAR2(10) NOT NULL,
	TinhTrang VARCHAR2(20) NOT NULL
) SEGMENT CREATION IMMEDIATE 
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
NOCOMPRESS LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS ;
--------------------------------------------------------

--  DDL for Index GHE_PK
--------------------------------------------------------
CREATE UNIQUE INDEX GHE_PK ON GHE (ID_Ghe) 
PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS ;
--------------------------------------------------------

--  Constraints for Table GHE
--------------------------------------------------------
ALTER TABLE GHE ADD CONSTRAINT GHE_PK PRIMARY KEY (ID_Ghe)
USING INDEX GHE_PK  ENABLE;
--------------------------------------------------------

--  Ref Constraints for Table GHE
--------------------------------------------------------
ALTER TABLE GHE ADD CONSTRAINT GHE_CX_FK FOREIGN KEY (ID_ChuyenXe)
	  REFERENCES CHUYENXE (ID_ChuyenXe) ON DELETE CASCADE ENABLE;
      
 
--TRIGGER for table GHE
--------------------------------------------------------
--  Trig_HuyGhe
CREATE OR REPLACE TRIGGER Trig_HuyGhe
BEFORE  UPDATE ON GHE
FOR EACH ROW
DECLARE Ngay DATE;
BEGIN
   IF (:new.tinhtrang = 'Đã hủy') THEN
        SELECT THOIGIANKH INTO Ngay
        FROM CHUYENXE
        WHERE ID_ChuyenXe=:new.ID_ChuyenXe;
        
        IF (Ngay < current_date) THEN
            RAISE_APPLICATION_ERROR (-20978, 'Khong the huy ghe cua chuyen xe da khoi hanh');
        ELSE
            IF (:old.tinhtrang = 'Đã đặt') THEN
                RAISE_APPLICATION_ERROR (-20979, 'Khong the huy ghe da co dat ve tuong lai');
            END IF;
        END IF; 
    END IF;
END;
/
---------------------
CREATE OR REPLACE TRIGGER   Trig_SoLuongGhe
BEFORE INSERT
ON GHE FOR EACH ROW
DECLARE SLGHE_LOAIXE NUMBER:=0;
                    TONGSOGHE_CHUYENXE NUMBER:=0;
BEGIN
    SELECT SoLuongGhe INTO SLGHE_LOAIXE
    FROM (CHUYENXE cx JOIN XE x ON cx.ID_Xe=x.ID_Xe) JOIN LOAIXE lx ON lx.ID_LoaiXe=x.ID_LoaiXe
    WHERE ID_ChuyenXe=:new.ID_ChuyenXe;
    
    SELECT COUNT(*) INTO TONGSOGHE_CHUYENXE
    FROM GHE
    WHERE ID_ChuyenXe=:new.ID_ChuyenXe;
     
     IF(SLGHE_LOAIXE < TONGSOGHE_CHUYENXE) THEN
            DBMS_OUTPUT.PUT_LINE('Vuot qua so luong ghe cua xe');
    END IF;
END;
/
--------------------------------------------------------

SET SERVEROUTPUT ON;
--------------------------------------------------------
--  PROCEDURE for table CHUYENXE
----------------------------------------------
--  Pro_themghe
CREATE OR REPLACE PROCEDURE Pro_themghe (
                                        MACX  IN OUT GHE.ID_ChuyenXe%TYPE,
                                        TGHE IN OUT GHE.TenGhe%TYPE)
AS                                            
BEGIN
    Insert into GHE (ID_Ghe, ID_ChuyenXe,TenGhe, TinhTrang) values (GHE_ID.NEXTVAL,MACX,TGHE,'Trống');
    DBMS_OUTPUT.PUT_LINE('Them thanh cong'); 
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
----------------------------------------------
--  Pro_capnhatghe
CREATE OR REPLACE PROCEDURE Pro_capnhatghe (
                                        MAGHE IN GHE.ID_Ghe%TYPE,
                                        MACX IN GHE.ID_ChuyenXe%TYPE,
                                        TGHE IN OUT GHE.TenGhe%TYPE)
AS
BEGIN
    UPDATE GHE
    SET   ID_ChuyenXe=MACX, TenGhe=TGHE
    WHERE ID_Ghe=MAGHE;
    DBMS_OUTPUT.PUT_LINE('Cap nhat thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
----------------------------------------------
-- Pro_huyghe
CREATE OR REPLACE PROCEDURE Pro_huyghe (MAGHE IN GHE.ID_Ghe%TYPE)
AS
BEGIN
        UPDATE GHE SET TinhTrang='Đã hủy'
        WHERE ID_Ghe=MAGHE;
        
        DBMS_OUTPUT.PUT_LINE('Huy thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
--------------------------------------------------------

--  FUNCTION for table GHE
--------------------------------------------------------
--  Func_kiemtra_huyghe
CREATE OR REPLACE FUNCTION Func_kiemtra_huyghe (MAGHE IN GHE.ID_Ghe%TYPE) RETURN NUMBER
AS
    MACX GHE.ID_ChuyenXe%TYPE;
    NGAYKH CHUYENXE.ThoiGianKH%TYPE;
    TT GHE.TinhTrang%TYPE;
BEGIN
    SELECT ID_ChuyenXe INTO MACX
    FROM GHE
    WHERE ID_Ghe=MAGHE;

    SELECT ThoiGianKH INTO NGAYKH
    FROM CHUYENXE
    WHERE ID_ChuyenXe=MACX;
        
    IF (NGAYKH < current_date) THEN
        RETURN 0;
    ELSE
        IF (TT = 'Đã đặt') THEN
            RETURN 0;
        END IF;
    RETURN 1;    
    END IF; 
END;
/
--------------------------------------------------------