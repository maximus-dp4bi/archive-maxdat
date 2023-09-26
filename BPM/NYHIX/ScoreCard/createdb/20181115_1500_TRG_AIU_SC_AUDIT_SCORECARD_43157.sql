CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_AIU_SC_AUDIT_SCORECARD
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
    Supervisor_staff_id
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
    :old.Supervisor_staff_id
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
    Supervisor_staff_id
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
    :new.Supervisor_staff_id
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
    Supervisor_staff_id
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
    :new.Supervisor_staff_id
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
    Supervisor_staff_id
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
    :old.Supervisor_staff_id
    );
    END IF;

END;
/
