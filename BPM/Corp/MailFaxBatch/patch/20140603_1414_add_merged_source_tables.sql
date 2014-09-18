declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CORP_ETL_MFB_SB_OLTP';
   if c = 1 then
      execute immediate 'drop table CORP_ETL_MFB_SB_OLTP cascade constraints';
   end if;
end;
/
create table CORP_ETL_MFB_SB_OLTP(
  BATCHGUID VARCHAR2(38) NOT NULL,
  EXTERNALBATCHID NUMBER NOT NULL,
  BATCHNAME VARCHAR2(255) NOT NULL,
  CREATIONSTATIONID VARCHAR2(32) NOT NULL,
  CREATIONUSERNAME VARCHAR2(80) NULL,
  CREATIONUSERID VARCHAR2(50) NOT NULL,
  BATCHCLASS VARCHAR2(32) NOT NULL,
  BATCHCLASSDES VARCHAR2(80) NULL,
  BATCHTYPE VARCHAR2(38) NULL,
  SOURCE_SERVER varchar2(255) null,
  STG_EXTRACT_DATE DATE DEFAULT SYSDATE NOT NULL)
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

comment on column CORP_ETL_MFB_SB_OLTP.BATCHGUID is 'Unique identifier for the batch in KOFAX.';
comment on column CORP_ETL_MFB_SB_OLTP.EXTERNALBATCHID is 'Batch ID in KOFAX.';
comment on column CORP_ETL_MFB_SB_OLTP.BATCHNAME is 'Name assigned to the batch when it is created.';
comment on column CORP_ETL_MFB_SB_OLTP.CREATIONSTATIONID is 'Identifies the KOFAX Capture station where the batch is created. The Station ID is assigned during the installation process.';
comment on column CORP_ETL_MFB_SB_OLTP.CREATIONUSERNAME is 'This is the Windows login name for the user who creates the batch.';
comment on column CORP_ETL_MFB_SB_OLTP.CREATIONUSERID is 'If the User Profiles feature is enabled, the KOFAX Capture login ID for the user who creates the batch.  If User Profiles are not enabled, this is the Windows login name for the user who creates the batch.';
comment on column CORP_ETL_MFB_SB_OLTP.BATCHCLASS is 'Name of the batch class.';
comment on column CORP_ETL_MFB_SB_OLTP.BATCHCLASSDES is 'Description of the batch class on which the batch is based. ';
comment on column CORP_ETL_MFB_SB_OLTP.BATCHTYPE is 'The type of batch. ';
comment on column CORP_ETL_MFB_SB_OLTP.SOURCE_SERVER is 'Database where this row originated.';

create or replace public synonym CORP_ETL_MFB_SB_OLTP for MAXDAT.CORP_ETL_MFB_SB_OLTP;
grant select on CORP_ETL_MFB_SB_OLTP to MAXDAT_READ_ONLY;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CORP_ETL_MFB_SBM_OLTP';
   if c = 1 then
      execute immediate 'drop table CORP_ETL_MFB_SBM_OLTP cascade constraints';
   end if;
end;
/
create table CORP_ETL_MFB_SBM_OLTP(
  BATCHMODULEID VARCHAR2(38) NOT NULL,
  BATCHGUID VARCHAR2(38) NOT NULL,
  MODULELAUNCHID VARCHAR2(38) NOT NULL,
  MODULECLOSEUNIQUEID VARCHAR2(38) NULL,
  MODULECLOSENAME VARCHAR2(32) NULL,
  STARTDATETIME DATE NOT NULL,
  ENDDATETIME DATE NULL,
  BATCHSTATUS NUMBER NOT NULL,
  PRIORITY NUMBER NOT NULL,
  DELETED VARCHAR2(1) NULL,
  PAGESPERDOCUMENT NUMBER NULL,
  PAGESSCANNED NUMBER NULL,
  PAGESDELETED NUMBER NULL,
  DOCUMENTSCREATED NUMBER NULL,
  DOCUMENTSDELETED NUMBER NULL,
  PAGESREPLACED NUMBER NULL,
  SOURCE_SERVER varchar2(255) null,
  STG_EXTRACT_DATE DATE DEFAULT SYSDATE NOT NULL)
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

comment on column CORP_ETL_MFB_SBM_OLTP.BATCHMODULEID is 'Unique identifier for the batch module.';
comment on column CORP_ETL_MFB_SBM_OLTP.BATCHGUID is 'Unique identifier for the batch.';
comment on column CORP_ETL_MFB_SBM_OLTP.MODULELAUNCHID is 'Unique value assigned to each KOFAX Capture processing module.';
comment on column CORP_ETL_MFB_SBM_OLTP.MODULECLOSEUNIQUEID is 'Unique identifier for the KOFAX Capture module next to launch. If that module has the same literal name as another module, this identifier distinguishes one module from the other.';
comment on column CORP_ETL_MFB_SBM_OLTP.MODULECLOSENAME is 'Literal name of the KOFAX Capture module that was launched next.';
comment on column CORP_ETL_MFB_SBM_OLTP.STARTDATETIME is 'Date and time when the module was launched. ';
comment on column CORP_ETL_MFB_SBM_OLTP.ENDDATETIME is 'Date and time when the module was closed. ';
comment on column CORP_ETL_MFB_SBM_OLTP.BATCHSTATUS is 'A value that identifies the status of the batch at the time the batch was closed. The possible values are: 2 - Ready, 4 - In Progress, 8 - Suspended, 32 - Error, 64 - Completed, 128 – Reserved.';
comment on column CORP_ETL_MFB_SBM_OLTP.PRIORITY is 'The priority of the batch.';
comment on column CORP_ETL_MFB_SBM_OLTP.DELETED is 'Flag that indicates that the batch was deleted during the current processing session. ';
comment on column CORP_ETL_MFB_SBM_OLTP.PAGESSCANNED is 'Flag that indicates the number of pages scanned changed during the current processing session.';
comment on column CORP_ETL_MFB_SBM_OLTP.PAGESDELETED is 'Flag that indicates that documents were created during the current processing session.';
comment on column CORP_ETL_MFB_SBM_OLTP.DOCUMENTSCREATED is 'Flag that indicates that documents were replaced during the current processing session';
comment on column CORP_ETL_MFB_SBM_OLTP.DOCUMENTSDELETED is 'Flag that indicates pages replaced during the current processing session.';
comment on column CORP_ETL_MFB_SBM_OLTP.PAGESREPLACED is 'Flag indicating that pages were deleted during at any time during processing. ';
comment on column CORP_ETL_MFB_SBM_OLTP.SOURCE_SERVER is 'Database where this row originated.';

create or replace public synonym CORP_ETL_MFB_SBM_OLTP for MAXDAT.CORP_ETL_MFB_SBM_OLTP;
grant select on CORP_ETL_MFB_SBM_OLTP to MAXDAT_READ_ONLY;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CORP_ETL_MFB_SML_OLTP';
   if c = 1 then
      execute immediate 'drop table CORP_ETL_MFB_SML_OLTP cascade constraints';
   end if;
end;
/
create table CORP_ETL_MFB_SML_OLTP(
  MODULELAUNCHID VARCHAR2(38) NOT NULL,
  STARTDATETIME DATE NOT NULL,
  ENDDATETIME DATE NULL,
  MODULEUNIQUEID VARCHAR2(38) NOT NULL,
  MODULENAME VARCHAR2(32) NULL,
  USERID VARCHAR2(32) NULL,
  USERNAME VARCHAR2(255) NULL,
  STATIONID VARCHAR2(32) NULL,
  SITENAME VARCHAR2(255) NULL,
  SITEID VARCHAR2(32) NULL,
  SOURCE_SERVER varchar2(255) null,
  STG_EXTRACT_DATE DATE DEFAULT SYSDATE NOT NULL)
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

comment on column CORP_ETL_MFB_SML_OLTP.MODULELAUNCHID is 'Unique value assigned to each KOFAX Capture processing module.';
comment on column CORP_ETL_MFB_SML_OLTP.STARTDATETIME is 'Date and time when the module was launched. ';
comment on column CORP_ETL_MFB_SML_OLTP.ENDDATETIME is 'Date and time when the module was closed. ';
comment on column CORP_ETL_MFB_SML_OLTP.MODULEUNIQUEID is 'Unique identifier for the KOFAX Capture module next to launch. If that module has the same literal name as another module, this identifier distinguishes one module from the other.';
comment on column CORP_ETL_MFB_SML_OLTP.MODULENAME is 'Literal name of the KOFAX Capture module that was launched next.';

create or replace public synonym CORP_ETL_MFB_SML_OLTP for MAXDAT.CORP_ETL_MFB_SML_OLTP;
grant select on CORP_ETL_MFB_SML_OLTP to MAXDAT_READ_ONLY;
