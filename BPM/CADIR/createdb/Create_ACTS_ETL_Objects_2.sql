-- ACTS Look up table CRED LICENSES 

CREATE TABLE ACTS_CRED_LICENSES
(
  LICENSE_ID      NUMBER(10) NOT NULL,
  LICENSE_NUMBER  VARCHAR2(45 CHAR),
  MD_ID           NUMBER(10),
  LICENSE_TYPE    VARCHAR2(45 CHAR),
  ISSUED_STATE    VARCHAR2(45 CHAR),
  ISSUED_DATE     DATE,
  EXPIRATION_DATE DATE,
  CREATED_DATE    DATE,
  CREATED_BY      VARCHAR2(45 CHAR),
  UPDATED_DATE    DATE,
  UPDATED_BY      VARCHAR2(45 CHAR)
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );     
  
create unique index ACTS_CRED_LICENSES_IX1 on ACTS_CRED_LICENSES (LICENSE_ID)
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );    
  
-- create or replace public synonym ACTS_CRED_LICENSES for MAXDAT_CADR.ACTS_CRED_LICENSES;  
grant select, insert, update, delete on MAXDAT_CADR.ACTS_CRED_LICENSES to MAXDAT_OLTP_SIUD;
grant select on MAXDAT_CADR.ACTS_CRED_LICENSES to MAXDAT_READ_ONLY;   
  
  
-- Create Semantic Views 

CREATE OR REPLACE VIEW D_ACTS_CRED_LICENSES_SV AS SELECT * FROM MAXDAT_CADR.ACTS_CRED_LICENSES WITH READ ONLY;

-- CREATE OR REPLACE PUBLIC SYNONYM D_ACTS_CRED_LICENSES_SV FOR MAXDAT_CADR.D_ACTS_CRED_LICENSES_SV ;
