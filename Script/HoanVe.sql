--------------------------------------------------------
--  DDL for Sequence HOANVE_ID
-------------------------------------------------------
CREATE SEQUENCE HOANVE_ID
INCREMENT BY 1
MINVALUE 11011
MAXVALUE 9999999999999999999999999999
NOCYCLE;
--------------------------------------------------------
--  DDL for Table HOANVE
--------------------------------------------------------
  CREATE TABLE HOANVE
(	ID_HoanVe NUMBER, 
    ID_Ve NUMBER NOT NULL, 
	ID_NhanVien NUMBER NOT NULL, 
    NgayHoan DATE NOT NULL, 
	PhiHV NUMBER NOT NULL,
    TienHV NUMBER NOT NULL
) SEGMENT CREATION IMMEDIATE 
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
NOCOMPRESS LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS ;
--------------------------------------------------------

--  DDL for Index HOANVE_PK
--------------------------------------------------------
  CREATE UNIQUE INDEX HV_PK ON HOANVE (ID_HoanVe) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE USERS ;
--------------------------------------------------------

--  Constraints for Table HOANVE
--------------------------------------------------------
  ALTER TABLE HOANVE ADD CONSTRAINT HV_PK PRIMARY KEY (ID_HoanVe)
  USING INDEX HV_PK  ENABLE;
--------------------------------------------------------

--  Ref Constraints for Table HOANVE
--------------------------------------------------------
  ALTER TABLE HOANVE ADD CONSTRAINT HV_VE_FK FOREIGN KEY (ID_Ve)
	  REFERENCES VE (ID_Ve) ON DELETE CASCADE ENABLE;
      
  ALTER TABLE HOANVE ADD CONSTRAINT HV_NV_FK FOREIGN KEY (ID_NhanVien)
	  REFERENCES NHANVIEN (ID_NhanVien) ON DELETE CASCADE ENABLE;
--------------------------------------------------------

SET SERVEROUTPUT  ON;
--  PROCEDURE for table HOANVE
--------------------------------------------------------
-----Pro_themhoanve
CREATE OR REPLACE PROCEDURE Pro_themhoanve (
                                            MAVE  HOANVE.ID_Ve%TYPE,
                                            MANV HOANVE.ID_NhanVien %TYPE,
                                            PHV  HOANVE.PhiHV %TYPE,
                                            THV  HOANVE.TienHV %TYPE)
AS
    MAGHE VE.ID_Ghe%TYPE;
    MAHK VE.ID_HanhKhach%TYPE;
BEGIN
    Insert into HOANVE (ID_HoanVe, ID_Ve, ID_NhanVien, NgayHoan , PhiHV, TienHV) 
        values (HoanVe_ID.NEXTVAL, MAVE, MANV, current_date, PHV,THV);
        
    UPDATE VE
    SET TinhTrang = 'Đã hoàn'
    WHERE ID_Ve = MAVE;
    
    SELECT ID_Ghe INTO MAGHE
    FROM VE
    WHERE ID_Ve = MAVE;
    
    UPDATE GHE
    SET TinhTrang = 'Trống'
    WHERE ID_Ghe = MAGHE;
    
    SELECT ID_HanhKhach INTO MAHK
    FROM VE
    WHERE ID_Ve = MAVE;
    
    UPDATE HANHKHACH
    SET TinhTrang = 'Đã hủy'
    WHERE ID_HanhKhach = MAHK;
    
    DBMS_OUTPUT.PUT_LINE('Them thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
--------------------------------------------------------
