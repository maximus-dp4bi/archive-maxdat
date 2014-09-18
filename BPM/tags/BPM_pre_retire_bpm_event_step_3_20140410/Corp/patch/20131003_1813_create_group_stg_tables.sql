-- 10/3/13 B.Thai For NYEC Manage Work consolidation UAT ticket. NYEC-5403

CREATE TABLE GROUP_STEP_DEFINITION_STG
(
  GROUP_STEP_DEFINITION_ID NUMBER(18, 0) NOT NULL 
, EFFECTIVE_START_TS DATE 
, EFFECTIVE_END_TS DATE 
, FORWARDING_RULE_CD VARCHAR2(32 BYTE) 
, ESCALATION_RULE_CD VARCHAR2(32 BYTE) 
, GROUP_ID NUMBER(18, 0) 
, STEP_DEFINITION_ID NUMBER(18, 0) 
, CREATED_BY VARCHAR2(80 BYTE) 
, CREATE_TS DATE 
, UPDATED_BY VARCHAR2(80 BYTE) 
, UPDATE_TS DATE 
)
tablespace MAXDAT_DATA;

alter table  GROUP_STEP_DEFINITION_STG
  add constraint XPKGROUP_STEP_DEFINITION primary key (GROUP_STEP_DEFINITION_ID)
  using index tablespace MAXDAT_INDX;

create or replace public synonym GROUP_STEP_DEFINITION_STG for GROUP_STEP_DEFINITION_STG;

Grant select on GROUP_STEP_DEFINITION_STG to MAXDAT_READ_ONLY; 

CREATE TABLE GROUP_STEP_DEFN_DEFAULT_STG
(
GROUP_STEP_DEFN_DEFAULT_ID NUMBER(18, 0) NOT NULL
, EFFECTIVE_START_TS DATE
, EFFECTIVE_END_TS DATE
, STEP_DEFINITION_ID NUMBER(18, 0)
, GROUP_STEP_DEFINITION_ID NUMBER(18, 0)
)
tablespace MAXDAT_DATA;

alter table  GROUP_STEP_DEFN_DEFAULT_STG
  add constraint XPKGROUP_STEP_DEFN_DEFAULT primary key (GROUP_STEP_DEFN_DEFAULT_ID)
  using index tablespace MAXDAT_INDX;

create or replace public synonym GROUP_STEP_DEFN_DEFAULT_STG for GROUP_STEP_DEFN_DEFAULT_STG;
Grant select on GROUP_STEP_DEFN_DEFAULT_STG to MAXDAT_READ_ONLY; 

Grant select on groups_stg to MAXDAT_READ_ONLY;
Grant select on staff_stg to MAXDAT_READ_ONLY;


