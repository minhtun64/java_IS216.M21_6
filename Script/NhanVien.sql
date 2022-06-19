--------------------------------------------------------
--  DDL for Sequence NHANVIEN_ID
--------------------------------------------------------
CREATE SEQUENCE NHANVIEN_ID
  INCREMENT BY 1
  MINVALUE 10001009
  MAXVALUE 9999999999999999999999999999
  NOCYCLE;
--------------------------------------------------------

--  DDL for Table NHANVIEN
--------------------------------------------------------
CREATE TABLE NHANVIEN
(	
    ID_NhanVien NUMBER,
    ID_NQL NUMBER NOT NULL,
    ID_TaiKhoan NUMBER NOT NULL,
    TenNV VARCHAR2(30) NOT NULL,
    GioiTinh VARCHAR2(10) NOT NULL,
    NgaySinh DATE NOT NULL,
    NgayVaoLam DATE NOT NULL,
    SDT VARCHAR2(20) NOT NULL,
    Email VARCHAR2(100) NOT NULL,
    TinhTrang VARCHAR2(20) NOT NULL
) SEGMENT CREATION IMMEDIATE 
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
NOCOMPRESS LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS ;
--------------------------------------------------------

--  DDL for Index NV_PK
CREATE UNIQUE INDEX NV_PK ON NHANVIEN (ID_NhanVien) 
PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS ;
--------------------------------------------------------

--  Constraints for Table NHANVIEN
--------------------------------------------------------
ALTER TABLE NHANVIEN ADD CONSTRAINT NV_PK PRIMARY KEY (ID_NhanVien)
USING INDEX NV_PK  ENABLE;
--------------------------------------------------------

--  Ref Constraints for Table NHANVIEN
--------------------------------------------------------
ALTER TABLE NHANVIEN ADD CONSTRAINT NV_TK_FK FOREIGN KEY (ID_TaiKhoan )
	  REFERENCES TAIKHOAN (ID_TaiKhoan);
ALTER TABLE NHANVIEN ADD CONSTRAINT NV_QL_FK FOREIGN KEY (ID_NQL)
	  REFERENCES NGUOIQUANLY (ID_NQL) ON DELETE CASCADE ENABLE;
--------------------------------------------------------

--  TRIGGER for table NHANVIEN
--------------------------------------------------------
--  Trig_NV_NGVL_NGSINH
CREATE OR REPLACE TRIGGER Trig_NV_NGVL_NGSINH
BEFORE INSERT OR UPDATE ON NHANVIEN
FOR EACH ROW
BEGIN
    IF (:new.NgaySinh > :new.NgayVaoLam) THEN
        RAISE_APPLICATION_ERROR (-20987, 'Ngay vao lam phai lon hon ngay sinh!');
    END IF;
END;
/
------------------------------
--  Trig_NV_18T
CREATE OR REPLACE TRIGGER Trig_NV_18T
BEFORE INSERT OR UPDATE ON NHANVIEN
FOR EACH ROW
DECLARE Tuoi INT :=0;
BEGIN
    Tuoi := months_between(:new.NgayVaoLam, :new.NgaySinh)/12;
    IF (Tuoi < 18) THEN
        RAISE_APPLICATION_ERROR (-20986, 'Nhan vien phai tu du 18 tuoi tro len!');
    END IF;
END;
/
------------------------------
--  Trig_NV_GIOITINH
CREATE OR REPLACE TRIGGER Trig_NV_GIOITINH
BEFORE INSERT OR UPDATE ON NHANVIEN
FOR EACH ROW
BEGIN
    IF (:new.GioiTinh NOT IN ('Nam', 'Nu')) THEN
        RAISE_APPLICATION_ERROR (-20970, 'Gioi tinh cua nhan vien phai la nam hoac nu!');
    END IF;
END;
/
--------------------------------------------------------

SET SERVEROUTPUT  ON;
--  PROCEDURE for table NHANVIEN
--------------------------------------------------------
--  Pro_themnhanvien
CREATE OR REPLACE PROCEDURE Pro_themnhanvien (
                                            MANQL IN NHANVIEN.ID_NQL%TYPE,
                                            TNV IN NHANVIEN.TenNV%TYPE,
                                            GT IN NHANVIEN.GioiTinh%TYPE,
                                            NGSINH IN NHANVIEN.NgaySinh%TYPE,
                                            NGVL IN NHANVIEN.NgayVaoLam%TYPE,
                                            SODIENTHOAI IN NHANVIEN.SDT%TYPE,
                                            MAIL IN NHANVIEN.Email%TYPE,
                                            TDN IN TAIKHOAN.TenDangNhap%TYPE,
                                            MK IN TAIKHOAN.MatKhau%TYPE)
AS
BEGIN
    Insert into TAIKHOAN (ID_TaiKhoan,TenDangNhap,MatKhau,Role,TinhTrang)
        values (TAIKHOAN_ID.NEXTVAL,TDN,MK,1,'Hoạt động');
        
    Insert into NHANVIEN (ID_NhanVien,ID_NQL, ID_TaiKhoan, TenNV, GioiTinh, NgaySinh, NgayVaoLam, SDT, Email,TinhTrang)  
        values (NHANVIEN_ID.NEXTVAL,MANQL,TAIKHOAN_ID.CURRVAL,TNV,GT,NGSINH,NGVL,SODIENTHOAI,MAIL,'Hoạt động');
        
    DBMS_OUTPUT.PUT_LINE('Them thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(' Khong xac dinh!');
END;
/
------------------------------
--  Pro_capnhatnhanvien
CREATE OR REPLACE PROCEDURE Pro_capnhatnhanvien (
                                            MANV IN NHANVIEN.ID_NhanVien%TYPE,
                                            MANQL IN NHANVIEN.ID_NQL%TYPE,
                                           TNV IN NHANVIEN.TenNV%TYPE,
                                           GT IN NHANVIEN.GioiTinh%TYPE,
                                           NGSINH IN NHANVIEN.NgaySinh%TYPE,
                                           NGVL IN NHANVIEN.NgayVaoLam%TYPE,
                                           SODIENTHOAI IN NHANVIEN.SDT%TYPE,
                                           MAIL IN NHANVIEN.Email%TYPE)
AS
BEGIN
    UPDATE NHANVIEN
    SET    ID_NQL=MANQL, TenNV=TNV, GioiTinh=GT,
                NgaySinh=NGSINH, NgayVaoLam=NGVL, SDT=SODIENTHOAI, Email=MAIL       
    WHERE ID_NhanVien=MANV;
    
    DBMS_OUTPUT.PUT_LINE('Cap nhat thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
------------------------------
--  Pro_huynhanvien
CREATE OR REPLACE PROCEDURE Pro_huynhanvien(MANV IN NHANVIEN.ID_NhanVien%TYPE)
AS
    MaTK NHANVIEN.ID_TAIKHOAN%TYPE;
BEGIN
        UPDATE NHANVIEN SET TinhTrang='Đã hủy'
        WHERE ID_NhanVien=MANV;
        
        SELECT ID_TAIKHOAN INTO MATK
        FROM NHANVIEN
        WHERE ID_NhanVien=MANV;
        
        UPDATE TAIKHOAN SET TinhTrang='Đã hủy'
        WHERE ID_TaiKhoan=MATK;
        
        DBMS_OUTPUT.PUT_LINE('Huy thanh cong');
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Loi!');
END;
/
--------------------------------------------------------