--------------------------------------------------------
--  DDL for Sequence TAIKHOAN_ID
--------------------------------------------------------
CREATE SEQUENCE TAIKHOAN_ID
INCREMENT BY 1
MINVALUE 200012
MAXVALUE 9999999999999999999999999999
NOCYCLE;
--------------------------------------------------------

--  DDL for Table TAIKHOAN
--------------------------------------------------------
CREATE TABLE TAIKHOAN 
(
    ID_TaiKhoan NUMBER,
    TenDangNhap VARCHAR2(30) NOT NULL,
    MatKhau VARCHAR2(10 BYTE) NOT NULL,
    Role NUMBER NOT NULL,
    TinhTrang VARCHAR2(20) NOT NULL
) SEGMENT CREATION IMMEDIATE 
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
NOCOMPRESS LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS ;
--------------------------------------------------------

--  DDL for Index TK_PK
--------------------------------------------------------
CREATE UNIQUE INDEX TK_PK ON TAIKHOAN (ID_TaiKhoan) 
TABLESPACE USERS;
--------------------------------------------------------