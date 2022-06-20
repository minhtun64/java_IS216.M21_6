--------------------------------------------------------
-----  DDL for Sequence VE_ID
--------------------------------------------------------
CREATE SEQUENCE VE_ID
INCREMENT BY 1
MINVALUE 201513
MAXVALUE 9999999999999999999999999999
NOCYCLE;
--------------------------------------------------------

-----  DDL for Table VE
--------------------------------------------------------
CREATE TABLE VE
(	
    ID_Ve NUMBER, 
    ID_ChuyenXe NUMBER NOT NULL,
    ViTriGhe NUMBER NOT NULL,
	TinhTrang VARCHAR2(20) NOT NULL
) SEGMENT CREATION IMMEDIATE 
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
NOCOMPRESS LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS;
--------------------------------------------------------

-----  DDL for Index VE_PK
--------------------------------------------------------
CREATE UNIQUE INDEX VE_PK ON VE (ID_Ve) 
PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE USERS;
--------------------------------------------------------

-----  Constraints for Table VE
--------------------------------------------------------
ALTER TABLE VE ADD CONSTRAINT VE_PK PRIMARY KEY (ID_Ve)
USING INDEX VE_PK  ENABLE;
--------------------------------------------------------

-----  Ref Constraints for Table VE 
--------------------------------------------------------
ALTER TABLE VE ADD CONSTRAINT VE_CX_FK FOREIGN KEY (ID_ChuyenXe)
	  REFERENCES CHUYENXE (ID_ChuyenXe) ON DELETE CASCADE ENABLE;
--------------------------------------------------------
