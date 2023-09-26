set echo on

CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_AIU_SC_AUDIT_PAYROLL
AFTER INSERT OR UPDATE OR DELETE ON DP_SCORECARD.SC_AUDIT_PAYROLL
for each row
BEGIN

IF UPDATING THEN

	BEGIN

	IF 	:OLD.Payroll_Audit_Date				<>	:NEW.Payroll_Audit_Date
	OR 	:OLD.Payroll_Audit_Create_Date		<>	:NEW.Payroll_Audit_Create_Date
	OR 	:OLD.Payroll_Audit_Create_USER		<>	:NEW.Payroll_Audit_Create_USER
	OR 	:OLD.Payroll_Audit_Update_Date		<>	:NEW.Payroll_Audit_Update_Date
	OR 	:OLD.Payroll_Audit_Update_USER		<>	:NEW.Payroll_Audit_Update_USER
	OR 	:OLD.Agent_staff_id					<>	:NEW.Agent_staff_id
	OR	:OLD.Correct_Project_Code			<>	:NEW.Correct_Project_Code
	OR	:OLD.Holiday_PTO_Entry_Accurate		<>	:NEW.Holiday_PTO_Entry_Accurate
	OR	:OLD.Applicable_Leave_Accurate		<>	:NEW.Applicable_Leave_Accurate
	OR	:OLD.Total_Hours_Accurate			<>	:NEW.Total_Hours_Accurate
	OR	:OLD.Payroll_Audit_Amount_of_time	<>	:NEW.Payroll_Audit_Amount_of_time
	OR	:OLD.Timesheet_Revision_Required	<>	:NEW.Timesheet_Revision_Required
	OR	:OLD.Coaching_or_Corrective_Steps 	<>	:NEW.Coaching_or_Corrective_Steps
	OR  :OLD.Payroll_Audit_Summary			<>	:NEW.Payroll_Audit_Summary
	OR  :OLD.Audit_System					<>	:NEW.Audit_System
	OR  :OLD.Supervisor_Staff_ID			<>	:NEW.Supervisor_Staff_ID
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
			:OLD.Payroll_Audit_Date,
			:OLD.Payroll_Audit_Create_Date,
			:OLD.Payroll_Audit_Create_USER,
			:OLD.Payroll_Audit_Update_Date,
			:OLD.Payroll_Audit_Update_USER,
			:OLD.Agent_staff_id,
			:OLD.Correct_Project_Code,
			:OLD.Holiday_PTO_Entry_Accurate,
			:OLD.Applicable_Leave_Accurate,
			:OLD.Total_Hours_Accurate,
			:OLD.Payroll_Audit_Amount_of_time,
			:OLD.Timesheet_Revision_Required,
			:OLD.Coaching_or_Corrective_Steps,
			:OLD.Payroll_Audit_Summary,
			:OLD.Audit_System,
			:OLD.Supervisor_Staff_ID
			);

    INSERT INTO SC_AUDIT_PAYROLL_AUDIT
      (	Record_type,
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
		SYSDATE,
		:NEW.Payroll_Audit_ID,
		:new.Payroll_Audit_Date,
		:new.Payroll_Audit_Create_Date,
		:new.Payroll_Audit_Create_USER,
		:new.Payroll_Audit_Update_Date,
		:new.Payroll_Audit_Update_USER,
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
		:NEW.Payroll_Audit_Date,
		:NEW.Payroll_Audit_Create_Date,
		:NEW.Payroll_Audit_Create_USER,
		:NEW.Payroll_Audit_Update_Date,
		:NEW.Payroll_Audit_Update_USER,
		:NEW.Agent_staff_id,
		:NEW.Correct_Project_Code,
		:NEW.Holiday_PTO_Entry_Accurate,
		:NEW.Applicable_Leave_Accurate,
		:NEW.Total_Hours_Accurate,
		:NEW.Payroll_Audit_Amount_of_time,
		:NEW.Timesheet_Revision_Required,
		:NEW.Coaching_or_Corrective_Steps,
		:NEW.Payroll_Audit_Summary,
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
		:old.Payroll_Audit_Update_Date,
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

CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_BIU_SC_AUDIT_PAYROLL
BEFORE INSERT OR UPDATE ON DP_SCORECARD.SC_AUDIT_PAYROLL
FOR EACH ROW
BEGIN
 :new.Payroll_Audit_Update_Date := sysdate;

 IF :new.Payroll_Audit_Update_USER IS NULL
	THEN :new.Payroll_Audit_Update_USER := USER;
 END IF;

 IF INSERTING THEN
	:new.Payroll_Audit_ID			:= DP_SCORECARD.SEQ_SC_AUDIT_PAYROLL_ID.nextval;
    :new.Payroll_Audit_Create_Date := sysdate;
    :new.Payroll_Audit_Create_USER := NVL( :new.Payroll_Audit_Create_USER, user);
  END IF;

end;
/

CREATE OR REPLACE Procedure DP_SCORECARD.INSERT_SC_AUDIT_PAYROLL
   (
  IN_PAYROLL_AUDIT_create_USER     	IN	VARCHAR2,
  IN_PAYROLL_AUDIT_DATE            	IN	DATE,
  IN_AGENT_STAFF_ID                	IN	NUMBER,
  IN_CORRECT_PROJECT_CODE          	IN	VARCHAR2,
  IN_HOLIDAY_PTO_ENTRY_ACCURATE    	IN	VARCHAR2,
  IN_APPLICABLE_LEAVE_ACCURATE     	IN	VARCHAR2,
  IN_TOTAL_HOURS_ACCURATE          	IN	VARCHAR2,
  IN_TIMESHEET_REVISION_REQUIRED   	IN	VARCHAR2,
  IN_COACHING_OR_CORRECTIVE_STEP  	IN	VARCHAR2,
  IN_PAYROLL_AUDIT_SUMMARY         	IN	VARCHAR2,
  IN_AUDIT_SYSTEM                  	IN	VARCHAR2,
  IN_PAYROLL_AUDIT_AMOUNT_OF_TM  	IN	VARCHAR2,
  IN_Supervisor_Staff_ID			IN	NUMBER
   )

AS
 --  v_username varchar2(100);
 
	LV_SUPERVISOR_STAFF_ID    number(10) := 0;
	
BEGIN

    -- DO THE INSERT

	if Trunc(IN_PAYROLL_AUDIT_DATE) > trunc(sysdate)
	then
		null;
	else

    LV_SUPERVISOR_STAFF_ID := FIND_SUPERVISOR_STAFF_ID(IN_AGENT_STAFF_ID, IN_PAYROLL_AUDIT_DATE, IN_SUPERVISOR_STAFF_ID);    



	INSERT INTO dp_scorecard.SC_AUDIT_PAYROLL
     (
		PAYROLL_AUDIT_CREATE_USER,
		PAYROLL_AUDIT_CREATE_DATE,
		PAYROLL_AUDIT_UPDATE_USER,
		PAYROLL_AUDIT_UPDATE_DATE,
		PAYROLL_AUDIT_DATE,
		AGENT_STAFF_ID,
		CORRECT_PROJECT_CODE,
		HOLIDAY_PTO_ENTRY_ACCURATE,
		APPLICABLE_LEAVE_ACCURATE,
		TOTAL_HOURS_ACCURATE,
		TIMESHEET_REVISION_REQUIRED,
		COACHING_OR_CORRECTIVE_STEPS,
		PAYROLL_AUDIT_SUMMARY,
		AUDIT_SYSTEM,
		PAYROLL_AUDIT_AMOUNT_OF_TIME,
		Supervisor_Staff_ID
    )
	values
		(
		IN_PAYROLL_AUDIT_create_USER,
        sysdate,
		IN_PAYROLL_AUDIT_create_USER,
		sysdate,
		IN_PAYROLL_AUDIT_DATE,
		IN_AGENT_STAFF_ID,
		IN_CORRECT_PROJECT_CODE,
		IN_HOLIDAY_PTO_ENTRY_ACCURATE,
		IN_APPLICABLE_LEAVE_ACCURATE,
		IN_TOTAL_HOURS_ACCURATE,
		IN_TIMESHEET_REVISION_REQUIRED,
		IN_COACHING_OR_CORRECTIVE_STEP,
		IN_PAYROLL_AUDIT_SUMMARY,
		IN_AUDIT_SYSTEM,
		IN_PAYROLL_AUDIT_AMOUNT_OF_TM,
		LV_Supervisor_Staff_ID
	);

	end if;

	commit;

END;
/


CREATE OR REPLACE Procedure DP_SCORECARD.Update_SC_AUDIT_PAYROLL
   (
  IN_DELETE_FLAG					IN  NUMBER,
  IN_PAYROLL_AUDIT_ID              	IN	NUMBER,
  IN_PAYROLL_AUDIT_UPDATE_USER     	IN	VARCHAR2,
  IN_PAYROLL_AUDIT_DATE            	IN	DATE,
  IN_AGENT_STAFF_ID                	IN	NUMBER,
  IN_CORRECT_PROJECT_CODE          	IN	VARCHAR2,
  IN_HOLIDAY_PTO_ENTRY_ACCURATE    	IN	VARCHAR2,
  IN_APPLICABLE_LEAVE_ACCURATE     	IN	VARCHAR2,
  IN_TOTAL_HOURS_ACCURATE          	IN	VARCHAR2,
  IN_TIMESHEET_REVISION_REQUIRED   	IN	VARCHAR2,
  IN_COACHING_OR_CORRECTIVE_STEP  	IN	VARCHAR2,
  IN_PAYROLL_AUDIT_SUMMARY         	IN	VARCHAR2,
  IN_AUDIT_SYSTEM                  	IN	VARCHAR2,
  IN_PAYROLL_AUDIT_AMOUNT_OF_TM  	IN	VARCHAR2,
  IN_SUPERVISOR_STAFF_ID			IN	NUMBER
   )

AS
 --  v_username varchar2(100);
	LV_SUPERVISOR_STAFF_ID    number(10) := 0;
	

BEGIN

	if IN_PAYROLL_AUDIT_ID IS NULL
	or Trunc(IN_PAYROLL_AUDIT_DATE) > trunc(sysdate)
	THEN
		NULL;
		
    ELSIF in_delete_flag = 1 
		THEN
		
			DELETE FROM DP_SCORECARD.SC_AUDIT_PAYROLL WHERE PAYROLL_AUDIT_ID = IN_PAYROLL_AUDIT_ID;
		
			COMMIT;
   ELSE

    LV_SUPERVISOR_STAFF_ID := FIND_SUPERVISOR_STAFF_ID(IN_AGENT_STAFF_ID, IN_PAYROLL_AUDIT_DATE, IN_SUPERVISOR_STAFF_ID);    

    update dp_scorecard.SC_AUDIT_PAYROLL
          set
		  PAYROLL_AUDIT_DATE           	=	IN_PAYROLL_AUDIT_DATE,
		  PAYROLL_AUDIT_UPDATE_DATE    	=	sysdate,
		  PAYROLL_AUDIT_UPDATE_USER    	=	IN_PAYROLL_AUDIT_UPDATE_USER,
		  AGENT_STAFF_ID               	=	IN_AGENT_STAFF_ID,
		  CORRECT_PROJECT_CODE         	=	IN_CORRECT_PROJECT_CODE,
		  HOLIDAY_PTO_ENTRY_ACCURATE   	=	IN_HOLIDAY_PTO_ENTRY_ACCURATE,
		  APPLICABLE_LEAVE_ACCURATE    	=	IN_APPLICABLE_LEAVE_ACCURATE,
		  TOTAL_HOURS_ACCURATE         	=	IN_TOTAL_HOURS_ACCURATE,
		  TIMESHEET_REVISION_REQUIRED  	=	IN_TIMESHEET_REVISION_REQUIRED,
		  COACHING_OR_CORRECTIVE_STEPS 	=	IN_COACHING_OR_CORRECTIVE_STEP,
		  PAYROLL_AUDIT_SUMMARY        	=	IN_PAYROLL_AUDIT_SUMMARY,
		  AUDIT_SYSTEM                 	=	IN_AUDIT_SYSTEM,
		  PAYROLL_AUDIT_AMOUNT_OF_TIME 	=	IN_PAYROLL_AUDIT_AMOUNT_OF_TM,
		  Supervisor_Staff_ID			=	LV_SUPERVISOR_STAFF_ID
        where PAYROLL_AUDIT_ID = IN_PAYROLL_AUDIT_ID;

       commit;

   end if;

END;
/


DROP VIEW DP_SCORECARD.SC_AUDIT_PAYROLL_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SC_AUDIT_PAYROLL_SV
(PAYROLL_AUDIT_ID, PAYROLL_AUDIT_DATE, PAYROLL_AUDIT_CREATE_DATE, PAYROLL_AUDIT_CREATE_USER, PAYROLL_AUDIT_UPDATE_DATE, 
 PAYROLL_AUDIT_UPDATE_USER, AGENT_STAFF_ID, CORRECT_PROJECT_CODE, HOLIDAY_PTO_ENTRY_ACCURATE, APPLICABLE_LEAVE_ACCURATE, 
 TOTAL_HOURS_ACCURATE, PAYROLL_AUDIT_AMOUNT_OF_TIME, TIMESHEET_REVISION_REQUIRED, COACHING_OR_CORRECTIVE_STEPS, PAYROLL_AUDIT_SUMMARY, 
 AUDIT_SYSTEM,Supervisor_Staff_ID)
AS 
SELECT PAYROLL_AUDIT_ID,PAYROLL_AUDIT_DATE,PAYROLL_AUDIT_CREATE_DATE,PAYROLL_AUDIT_CREATE_USER,PAYROLL_AUDIT_UPDATE_DATE,
PAYROLL_AUDIT_UPDATE_USER,AGENT_STAFF_ID,CORRECT_PROJECT_CODE,HOLIDAY_PTO_ENTRY_ACCURATE,APPLICABLE_LEAVE_ACCURATE,
TOTAL_HOURS_ACCURATE,PAYROLL_AUDIT_AMOUNT_OF_TIME,TIMESHEET_REVISION_REQUIRED,
COACHING_OR_CORRECTIVE_STEPS,PAYROLL_AUDIT_SUMMARY,AUDIT_SYSTEM,Supervisor_Staff_ID
FROM DP_SCORECARD.SC_AUDIT_PAYROLL;


GRANT INSERT, SELECT, UPDATE ON DP_SCORECARD.SC_AUDIT_PAYROLL_SV TO DP_SCORECARD_OLTP_SIU;

GRANT DELETE, INSERT, SELECT, UPDATE ON DP_SCORECARD.SC_AUDIT_PAYROLL_SV TO DP_SCORECARD_OLTP_SIUD;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_PAYROLL_SV TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_PAYROLL_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_PAYROLL_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_PAYROLL_SV TO MAXDAT_REPORTS;


DROP VIEW DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT_SV
(RECORD_TYPE, RECORD_ACTION, TRANSACTION_DATE, PAYROLL_AUDIT_ID, PAYROLL_AUDIT_DATE, 
 PAYROLL_AUDIT_CREATE_DATE, PAYROLL_AUDIT_CREATE_USER, PAYROLL_AUDIT_UPDATE_DATE, PAYROLL_AUDIT_UPDATE_USER, AGENT_STAFF_ID, 
 CORRECT_PROJECT_CODE, HOLIDAY_PTO_ENTRY_ACCURATE, APPLICABLE_LEAVE_ACCURATE, TOTAL_HOURS_ACCURATE, PAYROLL_AUDIT_AMOUNT_OF_TIME, 
 TIMESHEET_REVISION_REQUIRED, COACHING_OR_CORRECTIVE_STEPS, PAYROLL_AUDIT_SUMMARY, AUDIT_SYSTEM, Supervisor_Staff_ID)
AS 
select RECORD_TYPE,RECORD_ACTION,TRANSACTION_DATE,PAYROLL_AUDIT_ID,
PAYROLL_AUDIT_DATE,PAYROLL_AUDIT_CREATE_DATE,PAYROLL_AUDIT_CREATE_USER,PAYROLL_AUDIT_UPDATE_DATE,PAYROLL_AUDIT_UPDATE_USER,AGENT_STAFF_ID,
CORRECT_PROJECT_CODE,HOLIDAY_PTO_ENTRY_ACCURATE,APPLICABLE_LEAVE_ACCURATE,TOTAL_HOURS_ACCURATE,
PAYROLL_AUDIT_AMOUNT_OF_TIME,TIMESHEET_REVISION_REQUIRED,COACHING_OR_CORRECTIVE_STEPS,PAYROLL_AUDIT_SUMMARY,AUDIT_SYSTEM, Supervisor_Staff_ID
from DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT;


GRANT INSERT, SELECT, UPDATE ON DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT_SV TO DP_SCORECARD_OLTP_SIU;

GRANT DELETE, INSERT, SELECT, UPDATE ON DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT_SV TO DP_SCORECARD_OLTP_SIUD;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT_SV TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT_SV TO MAXDAT_REPORTS;

