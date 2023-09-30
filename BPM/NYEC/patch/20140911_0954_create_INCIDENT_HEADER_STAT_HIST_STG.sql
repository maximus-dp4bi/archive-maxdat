-- DWD 9/10/14 - Created for NYEC
--
-- Create table INCIDENT_HEADER_STAT_HIST_STG
create table INCIDENT_HEADER_STAT_HIST_STG (
  INCIDENT_HEADER_STAT_HIST_ID NUMBER(18) not null
, INCIDENT_HEADER_ID           NUMBER(18)
, STATUS_CD                    VARCHAR2(30)
, INCIDENT_STATUS              VARCHAR2(80)
, CREATED_BY                   VARCHAR2(80)
, CREATE_TS                    DATE
, CREATED_BY_STAFF_ID          NUMBER(18)
)
tablespace MAXDAT_DATA;

-- Create constraints 
alter table INCIDENT_HEADER_STAT_HIST_STG
  add primary key (INCIDENT_HEADER_STAT_HIST_ID)
  using index 
  tablespace MAXDAT_INDX;

-- Create indexes 
create index INC_HEAD_STAT_HIST_STG_IX1 on INCIDENT_HEADER_STAT_HIST_STG (INCIDENT_HEADER_ID)
  tablespace MAXDAT_INDX;

-- Grant object privileges 
grant select on INCIDENT_HEADER_STAT_HIST_STG to MAXDAT_READ_ONLY;

-- set up control for table
INSERT INTO corp_etl_control VALUES ('MAX_UPDATE_TS_INCIDENT_STATUS_HIST','D','2006/01/01','Starting date for Incident Status History',SYSDATE,SYSDATE);
COMMIT;
