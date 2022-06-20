--------------------------------------------------------
-----  DDL for Table NGUOIQUANLY
--------------------------------------------------------
CREATE TABLE NGUOIQUANLY
(
    ID_NQL NUMBER,
    TenDangNhap VARCHAR2(30) NOT NULL,
    tenNQL VARCHAR2(30) NOT NULL,
    GioiTinh VARCHAR2(10) NOT NULL,
    NgaySinh DATE NOT NULL,
    NgayVaoLam DATE NOT NULL,
    SDT VARCHAR2(20) NOT NULL,
    Email VARCHAR2(100) NOT NULL
) SEGMENT CREATION IMMEDIATE 
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
NOCOMPRESS LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS;
--------------------------------------------------------

-----  DDL for Index NQL_PK
--------------------------------------------------------
CREATE UNIQUE INDEX NQL_PK ON NGUOIQUANLY (ID_NQL) 
PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS;
--------------------------------------------------------

-----  Constraints for Table NGUOIQUANLY
--------------------------------------------------------
ALTER TABLE NGUOIQUANLY ADD CONSTRAINT NQL_PK PRIMARY KEY (ID_NQL)
USING INDEX NQL_PK  ENABLE;
--------------------------------------------------------
  
-----  Ref Constraints for Table NGUOIQUANLY
--------------------------------------------------------
ALTER TABLE NGUOIQUANLY ADD CONSTRAINT NQL_TK_FK FOREIGN KEY (TenDangNhap)
	  REFERENCES TAIKHOAN (TenDangNhap);
--------------------------------------------------------

-----  TRIGGERS for Table NGUOIQUANLY
--------------------------------------------------------
-----  Trig_NQL_NGVL_NGSINH
CREATE OR REPLACE TRIGGER Trig_NQL_NGVL_NGSINH
BEFORE INSERT OR UPDATE ON NGUOIQUANLY
FOR EACH ROW
BEGIN
    IF (:new.NgaySinh > :new.NgayVaoLam) THEN
        RAISE_APPLICATION_ERROR (-20950, 'Ngay vao lam phai lon hon ngay sinh!');
    END IF;
END;
/
------------------------------
-----  Trig_NQL_18T
CREATE OR REPLACE TRIGGER Trig_NQL_18T
BEFORE INSERT OR UPDATE ON NGUOIQUANLY
FOR EACH ROW
DECLARE Tuoi INT :=0;
BEGIN
    Tuoi := months_between(:new.NgayVaoLam, :new.NgaySinh)/12;
    IF (Tuoi < 18) THEN
        RAISE_APPLICATION_ERROR (-20940, 'Nguoi quan ly phai tu du 18 tuoi tro len!');
    END IF;
END;
/
-----  Trig_NQL_GIOITINH
CREATE OR REPLACE TRIGGER Trig_NQL_GIOITINH
BEFORE INSERT OR UPDATE ON NGUOIQUANLY
FOR EACH ROW
BEGIN
    IF (:new.GioiTinh NOT IN ('Nam', 'Nữ')) THEN
        RAISE_APPLICATION_ERROR (-20969, 'Gioi tinh cua nguoi quan ly phai la nam hoac nu');
    END IF;
END;
/

--------------------------------------------------------