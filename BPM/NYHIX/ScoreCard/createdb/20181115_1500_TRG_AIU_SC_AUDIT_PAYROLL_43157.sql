CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_AIU_SC_AUDIT_PAYROLL
AFTER INSERT OR UPDATE OR DELETE ON DP_SCORECARD.SC_AUDIT_PAYROLL
for each row
BEGIN

IF UPDATING THEN

  BEGIN

  IF :old.Payroll_Audit_Date        <>  :new.Payroll_Audit_Date
  OR :old.Payroll_Audit_Create_Date    <>  :new.Payroll_Audit_Create_Date
  OR :old.Payroll_Audit_Create_USER    <>  :new.Payroll_Audit_Create_USER
  OR :old.Payroll_Audit_Update_Date    <>  :new.Payroll_Audit_Update_Date
  OR :old.Payroll_Audit_Update_USER    <>  :new.Payroll_Audit_Update_USER
  OR :old.agent_staff_id          <>  :new.agent_staff_id
  OR  :OLD.Correct_Project_Code      <>  :NEW.Correct_Project_Code
  OR  :OLD.Holiday_PTO_Entry_Accurate    <>  :NEW.Holiday_PTO_Entry_Accurate
  OR  :OLD.Applicable_Leave_Accurate    <>  :NEW.Applicable_Leave_Accurate
  OR  :OLD.Total_Hours_Accurate      <>  :NEW.Total_Hours_Accurate
  OR  :OLD.Payroll_Audit_Amount_of_time  <>  :NEW.Payroll_Audit_Amount_of_time
  OR  :OLD.Timesheet_Revision_Required    <>  :NEW.Timesheet_Revision_Required
  OR  :OLD.Coaching_or_Corrective_Steps   <>  :NEW.Coaching_or_Corrective_Steps
  OR  :old.Payroll_Audit_Summary      <>  :new.Payroll_Audit_Summary
  OR  :OLD.Audit_System          <>  :NEW.Audit_System
  OR  :OLD.Supervisor_Staff_ID      <>  :NEW.Supervisor_Staff_ID
  THEN
    INSERT INTO SC_AUDIT_PAYROLL_AUDIT
    (Record_type,
    Record_action,
    Transaction_Date,
    Payroll_Audit_ID,
    Payroll_Audit_Date,
    Payroll_Audit_Create_Date,
    Payroll_Audit_Create_USER,
    Payroll_Audit_Update_Date,
    Payroll_Audit_Update_USER,
    Agent_staff_id,
    Correct_Project_Code,
    Holiday_PTO_Entry_Accurate,
    Applicable_Leave_Accurate,
    Total_Hours_Accurate,
    Payroll_Audit_Amount_of_time,
    Timesheet_Revision_Required,
    Coaching_or_Corrective_Steps,
    Payroll_Audit_Summary,
    Audit_System,
    Supervisor_Staff_ID
    )
    VALUES
      ('Update',
       'Delete',
       sysdate,
       :OLD.Payroll_Audit_ID,
       :old.Payroll_Audit_Date,
       :old.Payroll_Audit_Create_Date,
       :old.Payroll_Audit_Create_USER,
       SYSDATE,
       :old.Payroll_Audit_Update_USER,
       :old.Agent_staff_id,
       :old.Correct_Project_Code,
       :old.Holiday_PTO_Entry_Accurate,
       :old.Applicable_Leave_Accurate,
       :old.Total_Hours_Accurate,
       :old.Payroll_Audit_Amount_of_time,
       :old.Timesheet_Revision_Required,
       :old.Coaching_or_Corrective_Steps,
       :old.Payroll_Audit_Summary,
       :OLD.Audit_System,
       :old.Supervisor_Staff_ID
      );

    INSERT INTO SC_AUDIT_PAYROLL_AUDIT
      (Record_type,
           Record_action,
           Transaction_Date,
           Payroll_Audit_ID,
           Payroll_Audit_Date,
           Payroll_Audit_Create_Date,
           Payroll_Audit_Create_USER,
           Payroll_Audit_Update_Date,
           Payroll_Audit_Update_USER,
           Agent_staff_id,
           Correct_Project_Code,
           Holiday_PTO_Entry_Accurate,
           Applicable_Leave_Accurate,
           Total_Hours_Accurate,
           Payroll_Audit_Amount_of_time,
           Timesheet_Revision_Required,
           Coaching_or_Corrective_Steps,
           Payroll_Audit_Summary,
           Audit_System,
           Supervisor_Staff_ID
    )
     VALUES
      ('Update',
       'Insert',
       sysdate,
       :NEW.Payroll_Audit_ID,
       :new.Payroll_Audit_Date,
       :new.Payroll_Audit_Create_Date,
       :new.Payroll_Audit_Create_USER,
       SYSDATE,
       NVL(:new.Payroll_Audit_Update_USER,USER),
       :new.Agent_staff_id,
       :NEW.Correct_Project_Code,
       :NEW.Holiday_PTO_Entry_Accurate,
       :NEW.Applicable_Leave_Accurate,
       :NEW.Total_Hours_Accurate,
       :NEW.Payroll_Audit_Amount_of_time,
       :NEW.Timesheet_Revision_Required,
       :NEW.Coaching_or_Corrective_Steps,
       :new.Payroll_Audit_Summary,
       :NEW.Audit_System,
       :New.Supervisor_Staff_ID
      );

  END IF;

  END;

END IF;

IF INSERTING THEN
    INSERT INTO SC_AUDIT_PAYROLL_AUDIT
      (Record_type,
    Record_action,
    Transaction_Date,
    Payroll_Audit_ID,
    Payroll_Audit_Date,
    Payroll_Audit_Create_Date,
    Payroll_Audit_Create_USER,
    Payroll_Audit_Update_Date,
    Payroll_Audit_Update_USER,
    Agent_staff_id,
    Correct_Project_Code,
    Holiday_PTO_Entry_Accurate,
    Applicable_Leave_Accurate,
    Total_Hours_Accurate,
    Payroll_Audit_Amount_of_time,
    Timesheet_Revision_Required,
    Coaching_or_Corrective_Steps,
    Payroll_Audit_Summary,
    Audit_System,
    Supervisor_Staff_ID
    )
     VALUES
      ('Insert',
      'Insert',
    sysdate,
    :NEW.Payroll_Audit_ID,
    :new.Payroll_Audit_Date,
    :new.Payroll_Audit_Create_Date,
    :new.Payroll_Audit_Create_USER,
    :new.Payroll_Audit_Update_Date,
    NVL(:new.Payroll_Audit_Update_USER,USER),
    :new.Agent_staff_id,
    :NEW.Correct_Project_Code,
    :NEW.Holiday_PTO_Entry_Accurate,
    :NEW.Applicable_Leave_Accurate,
    :NEW.Total_Hours_Accurate,
    :NEW.Payroll_Audit_Amount_of_time,
    :NEW.Timesheet_Revision_Required,
    :NEW.Coaching_or_Corrective_Steps,
    :new.Payroll_Audit_Summary,
    :NEW.Audit_System,
    :NEW.Supervisor_Staff_ID
    );

END IF;

IF DELETING THEN
        INSERT INTO SC_AUDIT_PAYROLL_AUDIT
        (Record_type,
        Record_action,
    Transaction_Date,
    Payroll_Audit_ID,
    Payroll_Audit_Date,
    Payroll_Audit_Create_Date,
    Payroll_Audit_Create_USER,
    Payroll_Audit_Update_Date,
    Payroll_Audit_Update_USER,
    Agent_staff_id,
    Correct_Project_Code,
    Holiday_PTO_Entry_Accurate,
    Applicable_Leave_Accurate,
    Total_Hours_Accurate,
    Payroll_Audit_Amount_of_time,
    Timesheet_Revision_Required,
    Coaching_or_Corrective_Steps,
    Payroll_Audit_Summary,
    Audit_System,
    Supervisor_Staff_ID
    )
        VALUES
            ('Delete',
            'Delete',
            sysdate,
            :OLD.Payroll_Audit_ID,
            :old.Payroll_Audit_Date,
            :old.Payroll_Audit_Create_Date,
            :old.Payroll_Audit_Create_USER,
            SYSDATE,
            :old.Payroll_Audit_Update_USER,
            :old.Agent_staff_id,
            :old.Correct_Project_Code,
            :old.Holiday_PTO_Entry_Accurate,
            :old.Applicable_Leave_Accurate,
            :old.Total_Hours_Accurate,
            :old.Payroll_Audit_Amount_of_time,
            :old.Timesheet_Revision_Required,
            :old.Coaching_or_Corrective_Steps,
            :old.Payroll_Audit_Summary,
            :old.Audit_System,
            :OLD.Supervisor_Staff_ID
    );
    END IF;

END;
/
