--------------------------------------------------------
-----  DDL for Sequence HANHKHACH_ID
--------------------------------------------------------
CREATE SEQUENCE HANHKHACH_ID
  INCREMENT BY 1
  MINVALUE 1001051
  MAXVALUE 9999999999999999999999999999
  NOCYCLE;
  -------------------------------------------------------
  
-----  DDL for Table HANHKHACH
--------------------------------------------------------
CREATE TABLE HANHKHACH
(   
    ID_HanhKhach NUMBER, 
    TenHK VARCHAR2(30) NOT NULL,
    SDT VARCHAR2(20 BYTE) NOT NULL,
	CMND VARCHAR2(20 BYTE) NOT NULL, 
	Email VARCHAR2(100 BYTE) NOT NULL,
    TinhTrang VARCHAR(20) NOT NULL
) SEGMENT CREATION IMMEDIATE 
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
NOCOMPRESS LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS;
--------------------------------------------------------

-----  DDL for Index HK_PK
--------------------------------------------------------
CREATE UNIQUE INDEX HK_PK ON HANHKHACH (ID_HanhKhach) 
PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS;
--------------------------------------------------------

-----  Constraints for Table HANHKHACH
--------------------------------------------------------
ALTER TABLE HANHKHACH ADD CONSTRAINT HK_PK PRIMARY KEY (ID_HanhKhach)
USING INDEX HK_PK  ENABLE;
--------------------------------------------------------

SET SERVEROUTPUT ON;
--------------------------------------------------------
-----  PROCEDURES
----------------------------------------------
-----  Pro_capnhathanhkhach
CREATE OR REPLACE PROCEDURE Pro_capnhathanhkhach (
                                    HANHKHACH_MAKH IN HANHKHACH.ID_HanhKhach%TYPE,
                                    HANHKHACH_HOTEN IN HANHKHACH.TenHK%TYPE,
                                    HANHKHACH_SDT IN HANHKHACH.SDT%TYPE,
                                    HANHKHACH_CMND IN HANHKHACH.CMND%TYPE,
                                    HANHKHACH_EMAIL IN HANHKHACH.Email%TYPE)
AS
BEGIN
    UPDATE HANHKHACH
    SET    TenHK=HANHKHACH_HOTEN, SDT=HANHKHACH_SDT, 
                CMND=HANHKHACH_CMND, Email=HANHKHACH_EMAIL
    WHERE ID_HanhKhach=HANHKHACH_MAKH;
    DBMS_OUTPUT.PUT_LINE('Cap nhat thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
--------------------------------------------------------