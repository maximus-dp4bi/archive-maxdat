CREATE TABLE incidents_actions_taken
(incident_id NUMBER
 ,action_taken_record_num NUMBER
 ,action_taken_create_dt DATE
 ,action_taken_update_dt DATE
 ,action_taken_dt DATE
 ,action_type_cd VARCHAR2(32)
 ,action_type_desc VARCHAR2(256)
 ,action_taken_comment VARCHAR2(4000)
 ,staff_name VARCHAR2(200)
 ,role_name VARCHAR2(256)
 ,team_name VARCHAR2(100)
 ,unit_name VARCHAR2(100)) TABLESPACE MAXDAT_DATA;
 
CREATE UNIQUE INDEX incidents_actions_taken_idx1 ON INCIDENTS_ACTIONS_TAKEN (INCIDENT_ID,ACTION_TAKEN_RECORD_NUM) TABLESPACE MAXDAT_INDX;

grant select on INCIDENTS_ACTIONS_TAKEN to MAXDAT_READ_ONLY;

create or replace trigger TRG_BIU_INCI_ACTIONS_TAKEN 
before insert or update on INCIDENTS_ACTIONS_TAKEN 
for each row 
begin 
  if inserting then 
    :new.action_taken_create_dt := sysdate;
  end if;
  :new.action_taken_update_dt := sysdate;
end;
/

CREATE OR REPLACE VIEW D_INCIDENTS_ACTIONS_TAKEN_SV
AS
SELECT *
FROM incidents_actions_taken
with read only;

grant select on D_INCIDENTS_ACTIONS_TAKEN_SV to MAXDAT_READ_ONLY;