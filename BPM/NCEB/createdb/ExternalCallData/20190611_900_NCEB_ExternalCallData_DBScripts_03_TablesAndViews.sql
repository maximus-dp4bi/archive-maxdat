--Tables
CREATE TABLE MAXDAT.TS_NCEB_EXT_CALL_DATA 
(
  EXT_CALL_ID                NUMBER(19, 0) NOT NULL 
, D_PROJECT_ID               NUMBER(19, 0) NOT NULL 
, D_PROGRAM_ID               NUMBER(19, 0) NOT NULL 
, D_DATE_ID                  NUMBER(19, 0) NOT NULL 
, blocked_calls              NUMBER  
, create_by                  VARCHAR2(10)
, create_datetime            DATE not null
, last_updated_by            VARCHAR2(10)
, last_updated_datetime      DATE not null 
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

alter table MAXDAT.TS_NCEB_EXT_CALL_DATA
  add primary key (EXT_CALL_ID)
  using index 
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




--Views
CREATE OR REPLACE VIEW MAXDAT.TS_NCEB_EXT_CALL_DATA_SV AS
select EXT_CALL_ID,
       D_PROJECT_ID,
       D_PROGRAM_ID,
       D_DATE_ID,
       blocked_calls,
       create_by,
       create_datetime,
       last_updated_by,
       last_updated_datetime
  from MAXDAT.TS_NCEB_EXT_CALL_DATA;
  
  commit;
  
  /
