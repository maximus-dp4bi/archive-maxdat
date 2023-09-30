-- Create table
create table MAXDAT.HCO_CRM_INCIDENTS
(
  Incidentid       VARCHAR2(40),
  BeneficiaryID    Varchar2(18),
  SubjectID        Varchar2(40),
  SubjectIDName    Varchar2(100),
  StateCode        Varchar2(1),
  Activity_id      Varchar2(40),
  Record_date      Date,
  Modified_date    Date,
  CreatedBy        Varchar2(100),
  CreatedbyName    Varchar2(100)
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
-- Create/Recreate indexes 
create index MAXDAT.HCO_CRM_INC_ACTVY_IDX1 on MAXDAT.HCO_CRM_INCIDENTS (ACTIVITY_ID)
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
  
-- Create/Recreate indexes 
create index MAXDAT.HCO_CRM_INC_ACTVY_IDX2 on MAXDAT.HCO_CRM_INCIDENTS (Incidentid)
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
  

-- Grant/Revoke object privileges 
grant select, insert, update on MAXDAT.HCO_CRM_INCIDENTS to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on MAXDAT.HCO_CRM_INCIDENTS to MAXDAT_OLTP_SIUD;
grant select on MAXDAT.HCO_CRM_INCIDENTS to MAXDAT_READ_ONLY;


-- Create table
create table MAXDAT.HCO_CRM_ACTIVITY
(
  Activity_id             Varchar2(40),
  HCO_Externalid          VARCHAR2(40),
  BeneficiaryID           Varchar2(18),
  SubjectIDName           Varchar2(100),
  RegardingObjectId       Varchar2(40),  
  RegardingObjectIdName   Varchar2(100),
  RegardingObjectTypeCode Varchar2(40),  
  Record_date      Date,
  Modified_date    Date,
  CreatedBy        Varchar2(100),
  CreatedbyName    Varchar2(100)
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
-- Create/Recreate indexes 
create index MAXDAT.HCO_CRM_ACTVY_IDX1 on MAXDAT.HCO_CRM_ACTIVITY (ACTIVITY_ID)
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

-- Grant/Revoke object privileges 
grant select, insert, update on MAXDAT.HCO_CRM_ACTIVITY to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on MAXDAT.HCO_CRM_ACTIVITY to MAXDAT_OLTP_SIUD;
grant select on MAXDAT.HCO_CRM_ACTIVITY to MAXDAT_READ_ONLY;


CREATE TABLE HCO_S_CRM_INCIDENTS_STG NOLOGGING AS SELECT * FROM HCO_CRM_INCIDENTS where rownum < 1;
CREATE TABLE HCO_S_CRM_ACTIVITY_STG  NOLOGGING AS SELECT * FROM HCO_CRM_ACTIVITY where rownum < 1;


create index MAXDAT.HCO_CRM_INC_STG_IDX1 on MAXDAT.HCO_S_CRM_INCIDENTS_STG (Incidentid)
  Nologging
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


grant select, insert, update on MAXDAT.HCO_S_CRM_INCIDENTS_STG to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on MAXDAT.HCO_S_CRM_INCIDENTS_STG to MAXDAT_OLTP_SIUD;
grant select on MAXDAT.HCO_S_CRM_INCIDENTS_STG to MAXDAT_READ_ONLY; 

grant select, insert, update on MAXDAT.HCO_S_CRM_ACTIVITY_STG to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on MAXDAT.HCO_S_CRM_ACTIVITY_STG to MAXDAT_OLTP_SIUD;
grant select on MAXDAT.HCO_S_CRM_ACTIVITY_STG to MAXDAT_READ_ONLY; 

CREATE OR REPLACE VIEW HCO_CRM_INCIDENTS_SV
AS SELECT 
  Incidentid,
  BeneficiaryID,
  SubjectID,
  SubjectIDName,
  StateCode,
  Activity_id,
  Record_date,
  Modified_date,
  CreatedBy,
  CreatedbyName
FROM HCO_CRM_INCIDENTS;

GRANT SELECT ON "HCO_CRM_INCIDENTS_SV" TO "MAXDAT_READ_ONLY";  
