-- Create table
CREATE TABLE CC_HCO_IVR_RESPONSE
(
  IVR_RESPONSE_ID         NUMBER(10) NOT NULL,
  IVR_REQUEST_DATE        DATE,
  MAIL_REQUEST_COUNT      NUMBER(10) NOT NULL,
  MAIL_RESPONSE_COUNT     NUMBER(10) NOT NULL,
  FAX_REQUEST_COUNT       NUMBER(10) NOT NULL,
  FAX_RESPONSE_COUNT      NUMBER(10) NOT NULL,
  TOTAL_FAX_RESPONSE_TIME NUMBER(10,2)
)
TABLESPACE MAXDAT_DATA
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
grant select, insert, update on CC_HCO_IVR_RESPONSE to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on CC_HCO_IVR_RESPONSE to MAXDAT_OLTP_SIUD;
grant select on CC_HCO_IVR_RESPONSE to MAXDAT_READ_ONLY;


/*-- Create table
CREATE TABLE HCO_SYSTEM_LKUP
(
  SYS_ID                   NUMBER(10) NOT NULL,
  SYSTEM_NAME              VARCHAR2(100),
  BUS_AVAIL_STARTTIME      VARCHAR2(10),
  BUS_AVAIL_ENDTIME        VARCHAR2(10),
  TOTAL_BUS_AVAIL_IN_MINS  NUMBER(10) NOT NULL,
  DOWNTIME_ALLOWED_IN_MINS NUMBER(10) NOT NULL,
  ACTIVE                   VARCHAR2(1)
)
TABLESPACE MAXDAT_DATA
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table HCO_SYSTEM_LKUP
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
-- Grant/Revoke object privileges 
grant select, insert, update on HCO_SYSTEM_LKUP to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on HCO_SYSTEM_LKUP to MAXDAT_OLTP_SIUD;
grant select on HCO_SYSTEM_LKUP to MAXDAT_READ_ONLY;

-- Create table
CREATE TABLE HCO_TRACK_DOWNTIME
(
  TRACK_ID                NUMBER(10) NOT NULL,
  SYS_ID                  NUMBER(10),
  INCIDENT_DATE           DATE,
  SCHEDULED               VARCHAR2(1),
  TICKET_ID               NUMBER(10),
  ACTUAL_DOWNTIME_IN_MINS NUMBER(10) NOT NULL,
  COMMENTS                VARCHAR2(500)
)
TABLESPACE MAXDAT_DATA
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
  
-- Create/Recreate primary, unique and foreign key constraints 

alter table HCO_TRACK_DOWNTIME
  add constraint TRACK_SYS_ID_FK foreign key (SYS_ID)
  references HCO_SYSTEM_LKUP (SYS_ID);

-- Grant/Revoke object privileges 

grant select, insert, update on HCO_TRACK_DOWNTIME to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on HCO_TRACK_DOWNTIME to MAXDAT_OLTP_SIUD;
grant select on HCO_TRACK_DOWNTIME to MAXDAT_READ_ONLY;


CREATE OR REPLACE VIEW HCO_SYSTEM_LKUP_SV AS
SELECT HCO_SYSTEM_LKUP."SYS_ID"
      ,HCO_SYSTEM_LKUP."SYSTEM_NAME"
      ,HCO_SYSTEM_LKUP."BUS_AVAIL_STARTTIME"
      ,HCO_SYSTEM_LKUP."BUS_AVAIL_ENDTIME"
      ,HCO_SYSTEM_LKUP."TOTAL_BUS_AVAIL_IN_MINS"
      ,HCO_SYSTEM_LKUP."DOWNTIME_ALLOWED_IN_MINS"
      ,HCO_SYSTEM_LKUP."ACTIVE"
 FROM MAXDAT.HCO_SYSTEM_LKUP;
 
 
grant select on MAXDAT.HCO_SYSTEM_LKUP_SV to MAXDAT_READ_ONLY; 


CREATE OR REPLACE VIEW HCO_TRACK_DOWNTIME_SV AS
SELECT HCO_TRACK_DOWNTIME."TRACK_ID"
      ,HCO_TRACK_DOWNTIME."SYS_ID"
      ,HCO_TRACK_DOWNTIME."INCIDENT_DATE"
      ,HCO_TRACK_DOWNTIME."SCHEDULED"
      ,HCO_TRACK_DOWNTIME."TICKET_ID"
      ,HCO_TRACK_DOWNTIME."ACTUAL_DOWNTIME_IN_MINS"
      ,HCO_TRACK_DOWNTIME."COMMENTS"
 FROM MAXDAT.HCO_TRACK_DOWNTIME;
 
 grant select on MAXDAT.HCO_TRACK_DOWNTIME_SV to MAXDAT_READ_ONLY; */
 
/* 
***Moving these grants to 20170720_1200_CAHCO_TrackDowntime_DBScripts_00_Grants_to_Cisco_Enterprise_CC.sql since they need to be executed as CISCO_ENTERPRISE_CC
grant select on CISCO_ENTERPRISE_CC.CC_D_DATES_SV to MAXDAT_READ_ONLY;
 grant select on CISCO_ENTERPRISE_CC.CC_D_PROJECT_SV to MAXDAT_READ_ONLY;
 grant select on CISCO_ENTERPRISE_CC.CC_D_PROGRAM_SV to MAXDAT_READ_ONLY;
 
 grant select on CISCO_ENTERPRISE_CC.CC_D_DATES_SV to MAXDAT;
 grant select on CISCO_ENTERPRISE_CC.CC_D_PROJECT_SV to MAXDAT;
 grant select on CISCO_ENTERPRISE_CC.CC_D_PROGRAM_SV to MAXDAT;
 
 grant select on CISCO_ENTERPRISE_CC.CC_D_DATES_SV to PUBLIC;
 grant select on CISCO_ENTERPRISE_CC.CC_D_PROJECT_SV to PUBLIC;
 grant select on CISCO_ENTERPRISE_CC.CC_D_PROGRAM_SV to PUBLIC;
 
 */
 
 CREATE OR REPLACE VIEW CC_HCO_IVR_RESPONSE_SV AS
 SELECT CC_HCO_IVR_RESPONSE."IVR_RESPONSE_ID"
       ,CC_HCO_IVR_RESPONSE."IVR_REQUEST_DATE"
       ,CC_HCO_IVR_RESPONSE."MAIL_REQUEST_COUNT"
       ,CC_HCO_IVR_RESPONSE."MAIL_RESPONSE_COUNT"
       ,CC_HCO_IVR_RESPONSE."FAX_REQUEST_COUNT"
       ,CC_HCO_IVR_RESPONSE."FAX_RESPONSE_COUNT"
       ,CC_HCO_IVR_RESPONSE."TOTAL_FAX_RESPONSE_TIME"
       ,CISCO_ENTERPRISE_CC.CC_D_DATES_SV.D_DATE_ID "D_DATE_ID"
       ,CISCO_ENTERPRISE_CC.CC_D_PROJECT_SV.PROJECT_ID "D_PROJECT_ID"
       ,CISCO_ENTERPRISE_CC.CC_D_PROGRAM_SV.PROGRAM_ID "D_PROGRAM_ID"
  FROM CC_HCO_IVR_RESPONSE
       ,CISCO_ENTERPRISE_CC.CC_D_DATES_SV
       ,CISCO_ENTERPRISE_CC.CC_D_PROGRAM_SV
       ,CISCO_ENTERPRISE_CC.CC_D_PROJECT_SV
  WHERE CC_HCO_IVR_RESPONSE.IVR_REQUEST_DATE = CISCO_ENTERPRISE_CC.CC_D_DATES_SV.D_DATE(+)
   AND UPPER(CISCO_ENTERPRISE_CC.CC_D_PROGRAM_SV.PROGRAM_NAME) = 'MEDI-CAL'
  AND UPPER(CISCO_ENTERPRISE_CC.CC_D_PROJECT_SV.PROJECT_NAME) = 'CA HCO';
  
  grant select on CC_HCO_IVR_RESPONSE_SV to MAXDAT_READ_ONLY; 
  
  commit;
  
  /
