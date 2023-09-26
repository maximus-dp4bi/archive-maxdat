---Tables/Views
create table TS_CAHCO_SYSTEM_LKUP  
(
  sys_id                   NUMBER(10) not null,
  system_name              VARCHAR2(100),
  bus_avail_starttime      VARCHAR2(10),
  bus_avail_endtime        VARCHAR2(10),
  total_bus_avail_in_mins  NUMBER(10) not null,
  downtime_allowed_in_mins NUMBER(10) not null,
  active                   VARCHAR2(1)
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
alter table TS_CAHCO_SYSTEM_LKUP
  add primary key (SYS_ID)
  using index 
  tablespace MAXDAT_DATA
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


  
create table TS_CAHCO_TRACK_DOWNTIME  
(
  track_id                NUMBER(10) not null,
  sys_id                  NUMBER(10),
  d_date_id               NUMBER(10),  --incident_date
  scheduled               VARCHAR2(1),  --Y/N
  ticket_id               NUMBER(10),
  actual_downtime_in_mins NUMBER(10) not null,
  comments                VARCHAR2(500),
  D_PROJECT_ID            NUMBER(19, 0) NOT NULL, --needed for MicroStrategy Security filter, will lookup value in Insert DB Procedure
  D_PROGRAM_ID            NUMBER(19, 0) NOT NULL, --needed for MicroStrategy Security filter, will lookup value in Insert DB Procedure 
  ignore_flag             VARCHAR2(1),
  create_by               VARCHAR2(10), --transaction services audit column
  create_datetime         DATE not null,  --transaction services audit column
  last_updated_by         VARCHAR2(10),  --transaction services audit column
  last_updated_datetime   DATE not null   --transaction services audit column
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
alter table TS_CAHCO_TRACK_DOWNTIME
  add constraint TRACK_DOWNTIME_SYS_ID_FK foreign key (SYS_ID)
  references TS_CAHCO_SYSTEM_LKUP (SYS_ID);
  
CREATE OR REPLACE VIEW TS_CAHCO_SYSTEM_LKUP_SV AS
SELECT TS_CAHCO_SYSTEM_LKUP."SYS_ID"
      ,TS_CAHCO_SYSTEM_LKUP."SYSTEM_NAME"
      ,TS_CAHCO_SYSTEM_LKUP."BUS_AVAIL_STARTTIME"
      ,TS_CAHCO_SYSTEM_LKUP."BUS_AVAIL_ENDTIME"
      ,TS_CAHCO_SYSTEM_LKUP."TOTAL_BUS_AVAIL_IN_MINS"
      ,TS_CAHCO_SYSTEM_LKUP."DOWNTIME_ALLOWED_IN_MINS"
      ,TS_CAHCO_SYSTEM_LKUP."ACTIVE"
 FROM TS_CAHCO_SYSTEM_LKUP;
 
CREATE OR REPLACE VIEW TS_CAHCO_TRACK_DOWNTIME_SV AS
SELECT TRACK_ID
      ,SYS_ID
      ,D_DATE_ID
      ,CASE WHEN SCHEDULED = 'N' then 'No'
      WHEN SCHEDULED = 'Y' then 'Yes'
        ELSE 'No'
          END as SCHEDULED
      ,TICKET_ID
      ,ACTUAL_DOWNTIME_IN_MINS
      ,COMMENTS
      ,D_PROJECT_ID            
      ,D_PROGRAM_ID
      ,CASE WHEN ignore_flag = 'N' then 'No'
      WHEN ignore_flag = 'Y' then 'Yes'
        ELSE 'No'
          END as ignore_flag            
      ,create_by               
      ,create_datetime         
      ,last_updated_by         
      ,last_updated_datetime
 FROM TS_CAHCO_TRACK_DOWNTIME;
 
commit; 
 
/  
