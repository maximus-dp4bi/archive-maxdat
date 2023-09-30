-- Alter table Issue Types

Alter table D_CRS_ISSUE_TYPES ADD ISSUE_SERVICE_TYPE VARCHAR2(255);


-- Alter table S_CRS_IMR_ISSUES_IN_DISPUTE

Alter table S_CRS_IMR_ISSUES_IN_DISPUTE ADD  DRUG_CLASS_ID            NUMBER(10);
Alter table S_CRS_IMR_ISSUES_IN_DISPUTE ADD  DRUG_NAME_OR_SERVICE_ID  NUMBER(10);
Alter table S_CRS_IMR_ISSUES_IN_DISPUTE ADD  DRUG_TYPE_ID             NUMBER(10);
Alter table S_CRS_IMR_ISSUES_IN_DISPUTE ADD  DRUG_OR_SERVICE_NAME     VARCHAR2(150);
Alter table S_CRS_IMR_ISSUES_IN_DISPUTE ADD  IS_THIS_A_DRUG           NUMBER(1);
Alter table S_CRS_IMR_ISSUES_IN_DISPUTE ADD  SUB_CLASS_ID	      NUMBER(10);
Alter table S_CRS_IMR_ISSUES_IN_DISPUTE ADD  SUB_SUB_CLASS_ID         NUMBER(10);
  
  
-- Create table D_CRS_DRUG_CLASS

create table D_CRS_DRUG_CLASS
(
  DRUG_CLASS_ID     NUMBER(19) not null,
  DRUG_CLASS_CODE   VARCHAR2(255),
  DRUG_CLASS_NAME   VARCHAR2(255)
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


-- Grant/Revoke object privileges 
grant select, insert, update on D_CRS_DRUG_CLASS to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on D_CRS_DRUG_CLASS to MAXDAT_OLTP_SIUD;
grant select on D_CRS_DRUG_CLASS to MAXDAT_READ_ONLY;


-- Create table D_CRS_DRUG_SERVICE_NAME

create table D_CRS_DRUG_SERVICE_NAME
(
  DRUG_SERVICE_ID        NUMBER(19) not null,
  DRUG_SERVICE_CODE      VARCHAR2(255),
  DRUG_SERVICE_NAME_ID   NUMBER(10),
  DRUG_SERVICE_NAME      VARCHAR2(300),
  DRUG_SERVICE_NAME_TYPE VARCHAR2(255)
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

-- Grant/Revoke object privileges 
grant select, insert, update on D_CRS_DRUG_SERVICE_NAME to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on D_CRS_DRUG_SERVICE_NAME to MAXDAT_OLTP_SIUD;
grant select on D_CRS_DRUG_SERVICE_NAME to MAXDAT_READ_ONLY;


-- Create table D_CRS_DRUG_TYPE

create table D_CRS_DRUG_TYPE
(
  DRUG_TYPE_ID    NUMBER(19) not null,
  DRUG_TYPE_CODE  VARCHAR2(255),
  DRUG_TYPE_NAME  VARCHAR2(255)
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

-- Grant/Revoke object privileges 
grant select, insert, update on D_CRS_DRUG_TYPE to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on D_CRS_DRUG_TYPE to MAXDAT_OLTP_SIUD;
grant select on D_CRS_DRUG_TYPE to MAXDAT_READ_ONLY;


-- Create table D_CRS_SUB_CLASS_CATEGORY

create table D_CRS_SUB_CLASS_CATEGORY
(
  SUB_CLASS_ID        NUMBER(19) not null,
  SUB_CLASS_CODE      VARCHAR2(255),
  SUB_CLASS_CATEGORY  VARCHAR2(255),
  SUB_CLASS_TYPE      VARCHAR2(255)
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

-- Grant/Revoke object privileges 
grant select, insert, update on D_CRS_SUB_CLASS_CATEGORY to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on D_CRS_SUB_CLASS_CATEGORY to MAXDAT_OLTP_SIUD;
grant select on D_CRS_SUB_CLASS_CATEGORY to MAXDAT_READ_ONLY;


-- Create table D_CRS_SUB_SUB_CLASS_CATEGORY

create table D_CRS_SUB_SUB_CLASS_CATEGORY
(
  SUB_SUB_CLASS_ID        NUMBER(19) not null,
  SUB_SUB_CLASS_CODE      VARCHAR2(255),
  SUB_SUB_CLASS_CATEGORY  VARCHAR2(255),
  SUB_SUB_CLASS_TYPE      VARCHAR2(255)
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

-- Grant/Revoke object privileges 
grant select, insert, update on D_CRS_SUB_SUB_CLASS_CATEGORY to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on D_CRS_SUB_SUB_CLASS_CATEGORY to MAXDAT_OLTP_SIUD;
grant select on D_CRS_SUB_SUB_CLASS_CATEGORY to MAXDAT_READ_ONLY;


-- CREATE SEMANTIC VIEWS 

CREATE OR REPLACE VIEW MAXDAT_CADR.D_CRS_ISSUE_TYPES_SV AS SELECT * FROM MAXDAT_CADR.D_CRS_ISSUE_TYPES WITH READ ONLY;
CREATE OR REPLACE VIEW MAXDAT_CADR.D_CRS_DRUG_CLASS_SV AS SELECT * FROM MAXDAT_CADR.D_CRS_DRUG_CLASS WITH READ ONLY;
CREATE OR REPLACE VIEW MAXDAT_CADR.D_CRS_DRUG_SERVICE_NAME_SV AS SELECT * FROM MAXDAT_CADR.D_CRS_DRUG_SERVICE_NAME WITH READ ONLY;
CREATE OR REPLACE VIEW MAXDAT_CADR.D_CRS_DRUG_TYPE_SV AS SELECT * FROM MAXDAT_CADR.D_CRS_DRUG_TYPE WITH READ ONLY;
CREATE OR REPLACE VIEW MAXDAT_CADR.D_CRS_SUB_CLASS_CATEGORY_SV AS SELECT * FROM MAXDAT_CADR.D_CRS_SUB_CLASS_CATEGORY WITH READ ONLY;
CREATE OR REPLACE VIEW MAXDAT_CADR.D_CRS_SUBSUB_CLASSCATEGORY_SV AS SELECT * FROM MAXDAT_CADR.D_CRS_SUB_SUB_CLASS_CATEGORY WITH READ ONLY;

CREATE OR REPLACE VIEW MAXDAT_CADR.S_CRS_IMR_ISSUES_IN_DISPUTE_SV AS SELECT * FROM MAXDAT_CADR.S_CRS_IMR_ISSUES_IN_DISPUTE WITH READ ONLY;

