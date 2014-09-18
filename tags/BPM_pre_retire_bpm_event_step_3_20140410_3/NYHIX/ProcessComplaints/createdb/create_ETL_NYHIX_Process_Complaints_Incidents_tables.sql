create table NYHX_ETL_COMPLAINTS_INCIDENTS
  (NECI_ID                          number not null,
   CHANNEL                          varchar2(80) not null,
   CREATED_BY_GROUP                 varchar2(80),
   CREATED_BY_NAME                  varchar2(100),
   INCIDENT_ID                      number(18,0) not null,
   TRACKING_NUMBER                  varchar2(32) not null,
   CREATE_DT                        date ,
   ASED_RESOLVE_INCIDENT_EES_CSS    date,
   ASSD_RESOLVE_INCIDENT_EES_CSS    date, 
   ASED_RESOLVE_INCIDENT_SUP        date,
   ASSD_RESOLVE_INCIDENT_SUP        date,
   ASED_RESOLVE_INCIDENT_DOH        date,      
   ASSD_RESOLVE_INCIDENT_DOH        date,      
   ASED_WITHDRAW_INCIDENT           date,
   ASSD_WITHDRAW_INCIDENT           date,
   ASED_PERFORM_FOLLOWUP            date,
   ASSD_PERFORM_FOLLOWUP            date,
   ABOUT_PLAN_CODE                  varchar2(32),
   ABOUT_PROVIDER_ID                number(18,0),
   ACTION_COMMENTS                  varchar2(4000),   
   ACTION_TYPE                      varchar2(64) ,
   CANCEL_BY	                      varchar2(80),
   CANCEL_DT                        date,
   CANCEL_METHOD                    varchar2(40),
   CANCEL_REASON	                  varchar2(40),
   CURRENT_TASK_ID                  number(18,0),
   DE_TASK_ID                       number(18,0),
   FOLLOWUP_FLAG                    varchar2(1),
   INCIDENT_ABOUT                   varchar2(80), 
   INCIDENT_DESCRIPTION             varchar2(4000),  
   INCIDENT_REASON                  varchar2(80),
   INCIDENT_STATUS                  varchar2(80),
   INCIDENT_STATUS_DT               date,
   INSTANCE_COMPLETE_DT             date,
   INSTANCE_STATUS                  varchar2(10) not null,
   LAST_UPDATE_BY_NAME              varchar2(100),
   LAST_UPDATE_BY_DT                date ,
   UPDATED_BY                       varchar2(80),
   CLIENT_ID                        number(18,0),
   OTHER_PARTY_NAME                 varchar2(64),
   PRIORITY                         varchar2(256),
   REPORTED_BY                      varchar2(80),
   REPORTER_RELATIONSHIP            varchar2(64),
   RESOLUTION_DESCRIPTION           varchar2(4000),
   RESOLUTION_TYPE                  varchar2(64),
   CASE_ID                          number(18,0),
   FORWARDED                        varchar2(1),
   INCIDENT_TYPE                    varchar2(80),
   FORWARDED_TO                     varchar2(50),
   GWF_RESOLVED_EES_CSS             varchar2(30),
   GWF_RESOLVED_SUP                 varchar2(1),
   GWF_FOLLOWUP_REQ                 varchar2(1),
   GWF_RETURN_TO_STATE              varchar2(1),
   ASF_RESOLVE_INCIDENT_EES_CSS     varchar2(1),
   ASF_RESOLVE_INCIDENT_SUP         varchar2(1),
   ASF_RESOLVE_INCIDENT_DOH         varchar2(1),
   ASF_PERFORM_FOLLOWUP             varchar2(1),
   ASF_WITHDRAW_INCIDENT            varchar2(1),
   STG_EXTRACT_DATE                 date default sysdate not null,
   STG_LAST_UPDATE_DATE             date default sysdate not null,
   MAX_INCI_STAT_HIST_ID            number(18,0),
   STAFF_TYPE_CD                    varchar2(20),
   STAGE_DONE_DT                    date,
   COMPLETE_DT                      date,
   FORWARD_DT                       date,
   RECEIVED_DT                      date,
   PLAN_NAME                        Varchar2(64),
   CURRENT_STEP                     varchar(256),
   REPORTER_NAME                    Varchar2(180),
   REPORTER_PHONE                   Varchar2(32),
   SLA_SATISFIED                    Varchar2(1),
   primary key (NECI_ID) using index tablespace MAXDAT_INDX,
   constraint CHECK_GWF_RESOLVED_SUP check (GWF_RESOLVED_SUP     in ('N','Y')) enable,
   constraint CHECK_GWF_FOLLOWUP_REQ check (GWF_FOLLOWUP_REQ     in ('N','Y')) enable,
   constraint CHECK_GWF_RETURN_TO_STATE check (GWF_RETURN_TO_STATE     in ('N','Y')) enable,
   constraint CHECK_ASF_RESOLVE_EES_CSS check (ASF_RESOLVE_INCIDENT_EES_CSS  in ('N','Y')) enable,
   constraint CHECK_ASF_RESOLVE_SUP check (ASF_RESOLVE_INCIDENT_SUP       in ('N','Y')) enable,
   constraint CHECK_ASF_RESOLVE_DOH check (ASF_RESOLVE_INCIDENT_DOH         in ('N','Y')) enable,
   constraint CHECK_ASF_PERFORM_FOLLOWUP check (ASF_PERFORM_FOLLOWUP    in ('N','Y')) enable,
   constraint CHECK_ASF_WITHDRAW_INCIDENT check (ASF_WITHDRAW_INCIDENT    in ('N','Y')) enable
   );
  
create unique index NYHX_ETL_COMPLAINTS_IX1 on NYHX_ETL_COMPLAINTS_INCIDENTS (INCIDENT_ID) tablespace MAXDAT_INDX;

create index IX_COMPLAINTS_COMPLETE_DT on NYHX_ETL_COMPLAINTS_INCIDENTS (INSTANCE_COMPLETE_DT) tablespace MAXDAT_INDX;
create index IX_COMPLAINTS_FOLLOWUP on NYHX_ETL_COMPLAINTS_INCIDENTS (ASF_PERFORM_FOLLOWUP) tablespace MAXDAT_INDX;
create index IX_COMPLAINTS_INS_STATUS on NYHX_ETL_COMPLAINTS_INCIDENTS (INSTANCE_STATUS) tablespace MAXDAT_INDX;
create index IX_COMPLAINTS_INCIDENT_STATUS on NYHX_ETL_COMPLAINTS_INCIDENTS (INCIDENT_STATUS) tablespace MAXDAT_INDX;
create index IX_COMPLAINTS_CANCEL on NYHX_ETL_COMPLAINTS_INCIDENTS (CANCEL_DT) tablespace MAXDAT_INDX;
create index IX_COMPLAINTS_FORWARDED_TO on NYHX_ETL_COMPLAINTS_INCIDENTS (FORWARDED_TO) tablespace MAXDAT_INDX;

create or replace public synonym NYHX_ETL_COMPLAINTS_INCIDENTS for NYHX_ETL_COMPLAINTS_INCIDENTS;
grant select on NYHX_ETL_COMPLAINTS_INCIDENTS to MAXDAT_READ_ONLY;


create table NYHX_ETL_COMPL_INCIDENTS_OLTP
  (NECI_ID                            number not null,
   CHANNEL                            varchar2(80)  not null,
   CREATED_BY_GROUP                   varchar2(80) ,
   CREATED_BY_NAME                    varchar2(100),
   INCIDENT_ID                        number(18,0)  not null,
   TRACKING_NUMBER                    varchar2(32)  not null,
   CREATE_DT                          date ,
   ASED_RESOLVE_INCIDENT_EES_CSS      date,
   ASSD_RESOLVE_INCIDENT_EES_CSS      date,
   ASED_RESOLVE_INCIDENT_SUP          date,
   ASSD_RESOLVE_INCIDENT_SUP          date,
   ASED_RESOLVE_INCIDENT_DOH          date,      
   ASSD_RESOLVE_INCIDENT_DOH          date,      
   ASED_WITHDRAW_INCIDENT             date,
   ASSD_WITHDRAW_INCIDENT             date,
   ASED_PERFORM_FOLLOWUP              date,
   ASSD_PERFORM_FOLLOWUP              date,
   ABOUT_PLAN_CODE                    varchar2(32),
   ABOUT_PROVIDER_ID                  number(18,0),
   ACTION_COMMENTS                    varchar2(4000),   
   ACTION_TYPE                        varchar2(64) ,
   CANCEL_BY	                        varchar2(80),
   CANCEL_DT                          date,
   CANCEL_METHOD                      varchar2(40),
   CANCEL_REASON	                    varchar2(40),
   CURRENT_TASK_ID                    number(18,0),
   DE_TASK_ID                         number(18,0),
   FOLLOWUP_FLAG                      varchar2(1),
   INCIDENT_ABOUT                     varchar2(80), 
   INCIDENT_DESCRIPTION               varchar2(4000),  
   INCIDENT_REASON                    varchar2(80),
   INCIDENT_STATUS                    varchar2(80),
   INCIDENT_STATUS_DT                 date,
   INSTANCE_COMPLETE_DT               date,
   INSTANCE_STATUS                    varchar2(10) not null,
   LAST_UPDATE_BY_NAME                varchar2(100),
   LAST_UPDATE_BY_DT                  date ,
   UPDATED_BY                         varchar2(80),
   CLIENT_ID                          number(18,0),
   OTHER_PARTY_NAME                   varchar2(64),
   PRIORITY                           varchar2(256),
   REPORTED_BY                        varchar2(80),
   REPORTER_RELATIONSHIP              varchar2(64),
   RESOLUTION_DESCRIPTION             varchar2(4000),
   RESOLUTION_TYPE                    varchar2(64),
   CASE_ID                            number(18,0),
   FORWARDED                          varchar2(1),
   INCIDENT_TYPE                      varchar2(80),
   FORWARDED_TO                       varchar2(50),
   GWF_RESOLVED_EES_CSS               varchar2(30),
   GWF_RESOLVED_SUP                   varchar2(1),
   GWF_FOLLOWUP_REQ                   varchar2(1),
   GWF_RETURN_TO_STATE                varchar2(1),
   ASF_RESOLVE_INCIDENT_EES_CSS       varchar2(1) ,
   ASF_RESOLVE_INCIDENT_SUP           varchar2(1) ,
   ASF_RESOLVE_INCIDENT_DOH           varchar2(1) ,
   ASF_PERFORM_FOLLOWUP               varchar2(1) ,
   ASF_WITHDRAW_INCIDENT              varchar2(1),
   STG_EXTRACT_DATE                   date default sysdate not null,
   STG_LAST_UPDATE_DATE               date default sysdate not null,
   MAX_INCI_STAT_HIST_ID              number(18,0),
   STAFF_TYPE_CD                      varchar2(20),
   STAGE_DONE_DT                      date,
   COMPLETE_DT                        date,
   FORWARD_DT                         date,
   RECEIVED_DT                        date,
   PLAN_NAME                          Varchar2(64),
   REPORTER_NAME                      Varchar2(180),
   REPORTER_PHONE                     Varchar2(32),
   SLA_SATISFIED                      Varchar2(1));
   
create index IX_COMPLAINTS_COMPLETE_DT2 on NYHX_ETL_COMPL_INCIDENTS_OLTP (INSTANCE_COMPLETE_DT) tablespace MAXDAT_INDX;
create index IX_COMPLAINTS_INCIDENT_ID2 on NYHX_ETL_COMPL_INCIDENTS_OLTP (INCIDENT_ID) tablespace MAXDAT_INDX;
create index IX_COMPLAINTS_INS_STATUS2 on NYHX_ETL_COMPL_INCIDENTS_OLTP (INSTANCE_STATUS) tablespace MAXDAT_INDX;
create index IX_COMPLAINTS_INCIDENT_STATUS2 on NYHX_ETL_COMPL_INCIDENTS_OLTP (INCIDENT_STATUS) tablespace MAXDAT_INDX;
create index IX_COMPLAINTS_CANCEL2 on NYHX_ETL_COMPL_INCIDENTS_OLTP (CANCEL_DT) tablespace MAXDAT_INDX;
create index IX_COMPLAINTS_FOLLOWUP2 on NYHX_ETL_COMPL_INCIDENTS_OLTP (ASF_PERFORM_FOLLOWUP) tablespace MAXDAT_INDX;
create index IX_COMPLAINTS_FORWARDED_TO2 on NYHX_ETL_COMPLAINTS_INCIDENTS (FORWARDED_TO) tablespace MAXDAT_INDX;
   
create or replace public synonym NYHX_ETL_COMPL_INCIDENTS_OLTP for NYHX_ETL_COMPL_INCIDENTS_OLTP;
grant select on NYHX_ETL_COMPL_INCIDENTS_OLTP to MAXDAT_READ_ONLY;
   
   
create table NYHX_ETL_COMPL_INCIDN_WIP_BPM
  (NECI_ID                          number not null,
   CHANNEL                          varchar2(80)  not null,
   CREATED_BY_GROUP                 varchar2(80),
   CREATED_BY_NAME                  varchar2(100),
   INCIDENT_ID                      number(18,0)  not null,
   TRACKING_NUMBER                  varchar2(32)  not null,
   CREATE_DT                        date ,
   ASED_RESOLVE_INCIDENT_EES_CSS    date,
   ASSD_RESOLVE_INCIDENT_EES_CSS    date,
   ASED_RESOLVE_INCIDENT_SUP        date,
   ASSD_RESOLVE_INCIDENT_SUP        date,
   ASED_RESOLVE_INCIDENT_DOH        date,      
   ASSD_RESOLVE_INCIDENT_DOH        date,      
   ASED_WITHDRAW_INCIDENT           date,
   ASSD_WITHDRAW_INCIDENT           date,
   ASED_PERFORM_FOLLOWUP            date,
   ASSD_PERFORM_FOLLOWUP            date,
   ABOUT_PLAN_CODE                  varchar2(32),
   ABOUT_PROVIDER_ID                number(18,0),
   ACTION_COMMENTS                  varchar2(4000),   
   ACTION_TYPE                      varchar2(64) ,
   CANCEL_BY	                      varchar2(80),
   CANCEL_DT                        date,
   CANCEL_METHOD                    varchar2(40),
   CANCEL_REASON	                  varchar2(40),
   CURRENT_TASK_ID                  number(18,0),
   DE_TASK_ID                       number(18,0),
   FOLLOWUP_FLAG                    varchar2(1),
   INCIDENT_ABOUT                   varchar2(80), 
   INCIDENT_DESCRIPTION             varchar2(4000),  
   INCIDENT_REASON                  varchar2(80),
   INCIDENT_STATUS                  varchar2(80),
   INCIDENT_STATUS_DT               date,
   INSTANCE_COMPLETE_DT             date,
   INSTANCE_STATUS                  varchar2(10) not null,
   LAST_UPDATE_BY_NAME              varchar2(100),
   LAST_UPDATE_BY_DT                date ,
   UPDATED_BY                       varchar2(80),
   CLIENT_ID                        number(18,0),
   OTHER_PARTY_NAME                 varchar2(64),
   PRIORITY                         varchar2(256),
   REPORTED_BY                      varchar2(80),
   REPORTER_RELATIONSHIP            varchar2(64),
   RESOLUTION_DESCRIPTION           varchar2(4000),
   RESOLUTION_TYPE                  varchar2(64),
   CASE_ID                          number(18,0),
   FORWARDED                        varchar2(1),
   INCIDENT_TYPE                    varchar2(80),
   FORWARDED_TO                     varchar2(50),
   GWF_RESOLVED_EES_CSS             varchar2(30),
   GWF_RESOLVED_SUP                 varchar2(1),
   GWF_FOLLOWUP_REQ                 varchar2(1),
   GWF_RETURN_TO_STATE              varchar2(1),
   ASF_RESOLVE_INCIDENT_EES_CSS     varchar2(1) ,
   ASF_RESOLVE_INCIDENT_SUP         varchar2(1) ,
   ASF_RESOLVE_INCIDENT_DOH         varchar2(1) ,
   ASF_PERFORM_FOLLOWUP             varchar2(1) ,
   ASF_WITHDRAW_INCIDENT            varchar2(1) ,
   STG_EXTRACT_DATE                 date default sysdate not null,
   STG_LAST_UPDATE_DATE             date default sysdate not null,
   MAX_INCI_STAT_HIST_ID            number(18,0),
   STAFF_TYPE_CD                    varchar2(20),
    STAGE_DONE_DT                   date,
   COMPLETE_DT                      date,
   UPDATED                          varchar2(1),
   FORWARD_DT                       date,
   RECEIVED_DT                      date,
   PLAN_NAME                        Varchar2(64),
   REPORTER_NAME                    Varchar2(180),
   REPORTER_PHONE                   Varchar2(32),
   SLA_SATISFIED                    Varchar2(1));
   
create index IX_COMPLAINTS_COMPLETE_DT3 on NYHX_ETL_COMPL_INCIDN_WIP_BPM (INSTANCE_COMPLETE_DT) tablespace MAXDAT_INDX;
create index IX_COMPLAINTS_INCIDENT_ID3 on NYHX_ETL_COMPL_INCIDN_WIP_BPM (INCIDENT_ID) tablespace MAXDAT_INDX;
create index IX_COMPLAINTS_INS_STATUS3 on NYHX_ETL_COMPL_INCIDN_WIP_BPM (INSTANCE_STATUS) tablespace  MAXDAT_INDX;
create index IX_COMPLAINTS_INCIDENT_STATUS3 on NYHX_ETL_COMPL_INCIDN_WIP_BPM(INCIDENT_STATUS) tablespace MAXDAT_INDX;
create index IX_COMPLAINTS_CANCEL3 on NYHX_ETL_COMPL_INCIDN_WIP_BPM (CANCEL_DT) tablespace MAXDAT_INDX;
create index IX_COMPLAINTS_FOLLOWUP3 on NYHX_ETL_COMPL_INCIDN_WIP_BPM(ASF_PERFORM_FOLLOWUP) tablespace MAXDAT_INDX;
create index IX_COMPLAINTS_FORWARDED_TO3 on NYHX_ETL_COMPLAINTS_INCIDENTS(FORWARDED_TO) tablespace MAXDAT_INDX;

create or replace public synonym NYHX_ETL_COMPL_INCIDN_WIP_BPM for NYHX_ETL_COMPL_INCIDN_WIP_BPM;
grant select on NYHX_ETL_COMPL_INCIDN_WIP_BPM to MAXDAT_READ_ONLY;

