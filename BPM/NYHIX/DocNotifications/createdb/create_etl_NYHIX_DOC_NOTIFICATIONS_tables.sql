create table NYHIX_ETL_DOC_NOTIFICATIONS(
EDNDB_ID number(18,0) not null,
DOC_NOTIFICATION_ID number(18,0) not null,
KOFAX_DCN varchar2(256),
INSTANCE_STATUS varchar2(32) not null,
INSTANCE_START_DATE date,
INSTANCE_END_DATE date,
COMPLETE_DT date,
CANCEL_DT date,
CANCEL_BY_ID varchar2(32),
CANCEL_BY varchar2(100),
CANCEL_REASON  varchar2(100),
CANCEL_METHOD  varchar2(32),
CREATE_DT date,
CREATED_BY_ID varchar2(32),
CREATED_BY varchar2(100),
UPDATE_DT date,
UPDATED_BY_ID varchar2(32),
UPDATED_BY varchar2(100),
STATUS_CD varchar2(64),
STATUS varchar2(64),
HXID varchar2(64),
HX_ACCOUNT_ID varchar2(64),
ACCOUNT_ID number(18,0),
DESCRIPTION varchar2(512),
PROCESSED_IND varchar2(1) default 'N',
PROCESS_INSTANCE_ID number(18,0),
ERROR_CD varchar2(256),
NOTIFICATION_DT varchar2(64),
CHANNEL varchar2(100),
ASSD_PROCESS_DN date,
ASED_PROCESS_DN date,
ASF_VERIFY_DN varchar2(1)  default 'N' not null,
STG_EXTRACT_DATE date,
STAGE_DONE_DATE date,
STG_LAST_UPDATE_DATE date,
INSERTED varchar2(1) default 'N' not null,
UPDATED varchar2(1) default 'N' not null,
LAST_EVENT_DATE date
) tablespace MAXDAT_DATA parallel;

alter table  NYHIX_ETL_DOC_NOTIFICATIONS add primary key (DOC_NOTIFICATION_ID)  using index   tablespace MAXDAT_INDX;

create index NYHIX_ETL_DOCNOTIF_IX2 on NYHIX_ETL_DOC_NOTIFICATIONS (KOFAX_DCN) tablespace  MAXDAT_INDX ;
create index NYHIX_ETL_DOCNOTIF_IX3 on NYHIX_ETL_DOC_NOTIFICATIONS (STATUS_CD) tablespace  MAXDAT_INDX ;

grant select on NYHIX_ETL_DOC_NOTIFICATIONS to MAXDAT_READ_ONLY;


create table NYHIX_ETL_DOC_NOTIF_OLTP(
EDNDB_ID number(18,0) not null,
DOC_NOTIFICATION_ID number(18,0) not null,
KOFAX_DCN varchar2(256),
INSTANCE_STATUS varchar2(32) not null,
INSTANCE_START_DATE date,
INSTANCE_END_DATE date,
COMPLETE_DT date,
CANCEL_DT date,
CANCEL_BY_ID varchar2(32),
CANCEL_BY varchar2(100),
CANCEL_REASON  varchar2(100),
CANCEL_METHOD  varchar2(32),
CREATE_DT date,
CREATED_BY_ID varchar2(32),
CREATED_BY varchar2(100),
UPDATE_DT date,
UPDATED_BY_ID varchar2(32),
UPDATED_BY varchar2(100),
STATUS_CD varchar2(64),
STATUS varchar2(64),
HXID varchar2(64),
HX_ACCOUNT_ID varchar2(64),
ACCOUNT_ID number(18,0),
DESCRIPTION varchar2(512),
PROCESSED_IND varchar2(1) default 'N',
PROCESS_INSTANCE_ID number(18,0),
ERROR_CD varchar2(256),
NOTIFICATION_DT varchar2(64),
CHANNEL varchar2(100),
ASSD_PROCESS_DN date,
ASED_PROCESS_DN date,
ASF_VERIFY_DN varchar2(1)  default 'N' not null,
STG_EXTRACT_DATE date,
STAGE_DONE_DATE date,
STG_LAST_UPDATE_DATE date,
INSERTED varchar2(1) default 'N' not null,
UPDATED varchar2(1) default 'N' not null,
LAST_EVENT_DATE date
) tablespace MAXDAT_DATA parallel;

alter table  NYHIX_ETL_DOC_NOTIF_OLTP add primary key (DOC_NOTIFICATION_ID)  using index   tablespace MAXDAT_INDX;

grant select on NYHIX_ETL_DOC_NOTIF_OLTP to MAXDAT_READ_ONLY;


create table NYHIX_ETL_DOC_NOTIF_WIP_BPM(
EDNDB_ID number(18,0) not null,
DOC_NOTIFICATION_ID number(18,0) not null,
KOFAX_DCN varchar2(256),
INSTANCE_STATUS varchar2(32) not null,
INSTANCE_START_DATE date,
INSTANCE_END_DATE date,
COMPLETE_DT date,
CANCEL_DT date,
CANCEL_BY_ID varchar2(32),
CANCEL_BY varchar2(100),
CANCEL_REASON  varchar2(100),
CANCEL_METHOD  varchar2(32),
CREATE_DT date,
CREATED_BY_ID varchar2(32),
CREATED_BY varchar2(100),
UPDATE_DT date,
UPDATED_BY_ID varchar2(32),
UPDATED_BY varchar2(100),
STATUS_CD varchar2(64),
STATUS varchar2(64),
HXID varchar2(64),
HX_ACCOUNT_ID varchar2(64),
ACCOUNT_ID number(18,0),
DESCRIPTION varchar2(512),
PROCESSED_IND varchar2(1) default 'N',
PROCESS_INSTANCE_ID number(18,0),
ERROR_CD varchar2(256),
NOTIFICATION_DT varchar2(64),
CHANNEL varchar2(100),
ASSD_PROCESS_DN date,
ASED_PROCESS_DN date,
ASF_VERIFY_DN varchar2(1)  default 'N' not null,
STG_EXTRACT_DATE date,
STAGE_DONE_DATE date,
STG_LAST_UPDATE_DATE date,
INSERTED varchar2(1) default 'N' not null,
UPDATED varchar2(1) default 'N' not null,
LAST_EVENT_DATE date
) tablespace MAXDAT_DATA parallel;

alter table  NYHIX_ETL_DOC_NOTIF_WIP_BPM add primary key (DOC_NOTIFICATION_ID)  using index   tablespace MAXDAT_INDX;

grant select on NYHIX_ETL_DOC_NOTIF_WIP_BPM to MAXDAT_READ_ONLY;
