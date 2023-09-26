--------------------------------------------------------
--  DDL for TABLE SC_AUDIT_SCORECARD
--------------------------------------------------------
ALTER TABLE DP_SCORECARD.SC_AUDIT_SCORECARD
ADD DOCUMENT_UPLOAD_COMPLETED VARCHAR2(3) DEFAULT 'N/A';

ALTER TABLE DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT
ADD DOCUMENT_UPLOAD_COMPLETED VARCHAR2(3) DEFAULT 'N/A';

COMMIT;
--------------------------------------------------------------------------------
--------------------------------------------------------
--  DDL for VIEW SC_AUDIT_SCORECARD_SV
-------------------------------------------------------- 
CREATE OR REPLACE FORCE EDITIONABLE VIEW "DP_SCORECARD"."SC_AUDIT_SCORECARD_SV" (
    "SCORECARD_AUDIT_ID",
    "SCORECARD_AUDIT_DATE",
    "SCORECARD_AUDIT_CREATE_DATE",
    "SCORECARD_AUDIT_CREATE_USER",
    "SCORECARD_AUDIT_UPDATE_DATE",
    "SCORECARD_AUDIT_UPDATE_USER",
    "AGENT_STAFF_ID",
    "ATTEND_TRKR_UPDT_ACCURATELY",
    "CORRECTIVE_ACTIONS_UP_TO_DATE",
    "PERFORMANCE_TRKR_UP_TO_DATE",
    "GOALS_UPDATED",
    "SCORECARD_AUDIT_SUMMARY",
    "SUPERVISOR_STAFF_ID",
    "DOCUMENT_UPLOAD_COMPLETED"
) AS
    SELECT
        scorecard_audit_id,
        scorecard_audit_date,
        scorecard_audit_create_date,
        scorecard_audit_create_user,
        scorecard_audit_update_date,
        scorecard_audit_update_user,
        agent_staff_id,
        attend_trkr_updt_accurately,
        corrective_actions_up_to_date,
        performance_trkr_up_to_date,
        goals_updated,
        scorecard_audit_summary,
        supervisor_staff_id,
        DOCUMENT_UPLOAD_COMPLETED
    FROM
        dp_scorecard.sc_audit_scorecard;
        
grant select on "DP_SCORECARD"."SC_AUDIT_SCORECARD_SV" to MAXDAT;
grant select on "DP_SCORECARD"."SC_AUDIT_SCORECARD_SV" to MAXDAT_REPORTS;
grant select on "DP_SCORECARD"."SC_AUDIT_SCORECARD_SV" to MAXDAT_READ_ONLY;
grant select on "DP_SCORECARD"."SC_AUDIT_SCORECARD_SV" to DP_SCORECARD_READ_ONLY;


commit;

--------------------------------------------------------------------------------
--------------------------------------------------------
--  DDL for TRIGGER TRG_AIU_SC_AUDIT_SCORECARD
-------------------------------------------------------- 

create or replace TRIGGER DP_SCORECARD.TRG_AIU_SC_AUDIT_SCORECARD
AFTER INSERT OR UPDATE OR DELETE ON DP_SCORECARD.SC_AUDIT_SCORECARD
for each row
BEGIN

IF UPDATING THEN

  BEGIN

  IF :old.Scorecard_Audit_Date        <> :new.Scorecard_Audit_Date
  OR :old.Scorecard_Audit_Create_Date      <> :new.Scorecard_Audit_Create_Date
  OR :old.Scorecard_Audit_Create_USER      <> :new.Scorecard_Audit_Create_USER
  OR :old.Scorecard_Audit_Update_Date      <> :new.Scorecard_Audit_Update_Date
  OR :old.Scorecard_Audit_Update_USER      <> :new.Scorecard_Audit_Update_USER
  OR :old.agent_staff_id            <> :new.agent_staff_id
  OR :old.Attend_Trkr_UPDT_Accurately      <> :new.Attend_Trkr_UPDT_Accurately
  OR :old.Corrective_Actions_up_to_date    <> :new.Corrective_Actions_up_to_date
  OR :old.Performance_Trkr_Up_to_Date      <> :new.Performance_Trkr_Up_to_Date
  OR :old.Goals_Updated            <> :new.Goals_Updated
  OR :old.Scorecard_Audit_Summary        <> :new.Scorecard_Audit_Summary
  OR :old.Supervisor_Staff_ID         <> :new.Supervisor_Staff_ID
  OR :old.DOCUMENT_UPLOAD_COMPLETED         <> :new.DOCUMENT_UPLOAD_COMPLETED
  THEN
    INSERT INTO DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT
    (Record_type,
    Record_action,
    TRANSACTION_DATE,
    Scorecard_Audit_ID,
    Scorecard_Audit_Date,
    Scorecard_Audit_Create_Date,
    Scorecard_Audit_Create_USER,
    Scorecard_Audit_Update_Date,
    Scorecard_Audit_Update_USER,
    Agent_staff_id,
    Attend_Trkr_UPDT_Accurately,
    Corrective_Actions_up_to_date,
    Performance_Trkr_Up_to_Date,
    Goals_Updated,
    Scorecard_Audit_Summary,
    Supervisor_staff_id,
    DOCUMENT_UPLOAD_COMPLETED
    )
    VALUES
      ('Update',
      'Delete',
      sysdate,
    :old.Scorecard_Audit_ID,
    :old.Scorecard_Audit_Date,
    :old.Scorecard_Audit_Create_Date,
    :old.Scorecard_Audit_Create_USER,
    SYSDATE,
    :old.Scorecard_Audit_Update_USER,
    :old.Agent_staff_id,
    :old.Attend_Trkr_UPDT_Accurately,
    :old.Corrective_Actions_up_to_date,
    :old.Performance_Trkr_Up_to_Date,
    :old.Goals_Updated,
    :old.Scorecard_Audit_Summary,
    :old.Supervisor_staff_id,
    :old.DOCUMENT_UPLOAD_COMPLETED
      );

 INSERT INTO DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT
   (Record_type,
   Record_action,
    TRANSACTION_DATE,
    Scorecard_Audit_ID,
    Scorecard_Audit_Date,
    Scorecard_Audit_Create_Date,
    Scorecard_Audit_Create_USER,
    Scorecard_Audit_Update_Date,
    Scorecard_Audit_Update_USER,
    Agent_staff_id,
    Attend_Trkr_UPDT_Accurately,
    Corrective_Actions_up_to_date,
    Performance_Trkr_Up_to_Date,
    Goals_Updated,
    Scorecard_Audit_Summary,
    Supervisor_staff_id,
    DOCUMENT_UPLOAD_COMPLETED
    )
     VALUES
      ('Update',
      'Insert',
    sysdate,
    :new.Scorecard_Audit_ID,
    :new.Scorecard_Audit_Date,
    :new.Scorecard_Audit_Create_Date,
    :new.Scorecard_Audit_Create_USER,
    :new.Scorecard_Audit_Update_Date,
    NVL(:new.Scorecard_Audit_Update_USER,USER),
    :new.Agent_staff_id,
    :new.Attend_Trkr_UPDT_Accurately,
    :new.Corrective_Actions_up_to_date,
    :new.Performance_Trkr_Up_to_Date,
    :new.Goals_Updated,
    :new.Scorecard_Audit_Summary,
    :new.Supervisor_staff_id,
    :new.DOCUMENT_UPLOAD_COMPLETED
      );

  END IF;

  END;

END IF;

IF INSERTING THEN
    INSERT INTO DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT
      (Record_type,
    Record_action,
    TRANSACTION_DATE,
    Scorecard_Audit_ID,
    Scorecard_Audit_Date,
    Scorecard_Audit_Create_Date,
    Scorecard_Audit_Create_USER,
    Scorecard_Audit_Update_Date,
    Scorecard_Audit_Update_USER,
    Agent_staff_id,
    Attend_Trkr_UPDT_Accurately,
    Corrective_Actions_up_to_date,
    Performance_Trkr_Up_to_Date,
    Goals_Updated,
    Scorecard_Audit_Summary,
    Supervisor_staff_id,
    DOCUMENT_UPLOAD_COMPLETED
    )
     VALUES
      ('Insert',
      'Insert',
    sysdate,
    :new.Scorecard_Audit_ID,
    :new.Scorecard_Audit_Date,
    :new.Scorecard_Audit_Create_Date,
    :new.Scorecard_Audit_Create_USER,
    :new.Scorecard_Audit_Update_Date,
    NVL(:new.Scorecard_Audit_Update_USER,USER),
    :new.Agent_staff_id,
    :new.Attend_Trkr_UPDT_Accurately,
    :new.Corrective_Actions_up_to_date,
    :new.Performance_Trkr_Up_to_Date,
    :new.Goals_Updated,
    :new.Scorecard_Audit_Summary,
    :new.Supervisor_staff_id,
    :new.DOCUMENT_UPLOAD_COMPLETED
    );

END IF;

IF DELETING THEN
        INSERT INTO DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT
        (Record_type,
        Record_action,
    TRANSACTION_DATE,
    Scorecard_Audit_ID,
    Scorecard_Audit_Date,
    Scorecard_Audit_Create_Date,
    Scorecard_Audit_Create_USER,
    Scorecard_Audit_Update_Date,
    Scorecard_Audit_Update_USER,
    Agent_staff_id,
    Attend_Trkr_UPDT_Accurately,
    Corrective_Actions_up_to_date,
    Performance_Trkr_Up_to_Date,
    Goals_Updated,
    Scorecard_Audit_Summary,
    Supervisor_staff_id,
    DOCUMENT_UPLOAD_COMPLETED
    )
        VALUES
            ('Delete',
            'Delete',
      sysdate,
    :old.Scorecard_Audit_ID,
    :old.Scorecard_Audit_Date,
    :old.Scorecard_Audit_Create_Date,
    :old.Scorecard_Audit_Create_USER,
    SYSDATE,
    :old.Scorecard_Audit_Update_USER,
    :old.Agent_staff_id,
    :old.Attend_Trkr_UPDT_Accurately,
    :old.Corrective_Actions_up_to_date,
    :old.Performance_Trkr_Up_to_Date,
    :old.Goals_Updated,
    :old.Scorecard_Audit_Summary,
    :old.Supervisor_staff_id,
    :old.DOCUMENT_UPLOAD_COMPLETED
    );
    END IF;

END;
/
commit;

----------------------------------------------------------------
