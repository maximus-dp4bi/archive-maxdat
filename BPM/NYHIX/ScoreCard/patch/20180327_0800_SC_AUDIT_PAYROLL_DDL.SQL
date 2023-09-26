DROP TABLE DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT CASCADE CONSTRAINTS;

CREATE TABLE DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT
(
  RECORD_TYPE                   VARCHAR2(10 BYTE),
  RECORD_ACTION                 VARCHAR2(10 BYTE),
  TRANSACTION_DATE              DATE,
  PAYROLL_AUDIT_ID              NUMBER(13)      NOT NULL,
  PAYROLL_AUDIT_DATE            DATE            NOT NULL,
  PAYROLL_AUDIT_CREATE_DATE     DATE            NOT NULL,
  PAYROLL_AUDIT_CREATE_USER     VARCHAR2(100 BYTE) NOT NULL,
  PAYROLL_AUDIT_UPDATE_DATE     DATE            NOT NULL,
  PAYROLL_AUDIT_UPDATE_USER     VARCHAR2(100 BYTE) NOT NULL,
  AGENT_STAFF_ID                NUMBER          NOT NULL,
  CORRECT_PROJECT_CODE          VARCHAR2(3 BYTE) DEFAULT 'No',
  HOLIDAY_PTO_ENTRY_ACCURATE    VARCHAR2(3 BYTE) DEFAULT 'No',
  APPLICABLE_LEAVE_ACCURATE     VARCHAR2(3 BYTE) DEFAULT 'No',
  TOTAL_HOURS_ACCURATE          VARCHAR2(3 BYTE) DEFAULT 'No',
  TIMESHEET_REVISION_REQUIRED   VARCHAR2(3 BYTE) DEFAULT 'No',
  COACHING_OR_CORRECTIVE_STEPS  VARCHAR2(4000 BYTE),
  PAYROLL_AUDIT_SUMMARY         VARCHAR2(4000 BYTE),
  AUDIT_SYSTEM                  VARCHAR2(20 BYTE),
  PAYROLL_AUDIT_AMOUNT_OF_TIME  VARCHAR2(4000 BYTE)
)
TABLESPACE MAXDAT_DATA
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;


GRANT SELECT ON DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT TO MAXDAT_REPORTS;

---------------------------------------------------------------------
---------------------------------------------------------------------

DROP TABLE DP_SCORECARD.SC_AUDIT_PAYROLL CASCADE CONSTRAINTS;

CREATE TABLE DP_SCORECARD.SC_AUDIT_PAYROLL
(
  PAYROLL_AUDIT_ID              NUMBER(13)      NOT NULL,
  PAYROLL_AUDIT_DATE            DATE            NOT NULL,
  PAYROLL_AUDIT_CREATE_DATE     DATE            NOT NULL,
  PAYROLL_AUDIT_CREATE_USER     VARCHAR2(100 BYTE) NOT NULL,
  PAYROLL_AUDIT_UPDATE_DATE     DATE            NOT NULL,
  PAYROLL_AUDIT_UPDATE_USER     VARCHAR2(100 BYTE) NOT NULL,
  AGENT_STAFF_ID                NUMBER          NOT NULL,
  CORRECT_PROJECT_CODE          VARCHAR2(3 BYTE) DEFAULT 'No',
  HOLIDAY_PTO_ENTRY_ACCURATE    VARCHAR2(3 BYTE) DEFAULT 'No',
  APPLICABLE_LEAVE_ACCURATE     VARCHAR2(3 BYTE) DEFAULT 'No',
  TOTAL_HOURS_ACCURATE          VARCHAR2(3 BYTE) DEFAULT 'No',
  TIMESHEET_REVISION_REQUIRED   VARCHAR2(3 BYTE) DEFAULT 'No',
  COACHING_OR_CORRECTIVE_STEPS  VARCHAR2(4000 BYTE),
  PAYROLL_AUDIT_SUMMARY         VARCHAR2(4000 BYTE),
  AUDIT_SYSTEM                  VARCHAR2(20 BYTE),
  PAYROLL_AUDIT_AMOUNT_OF_TIME  VARCHAR2(4000 BYTE)
)
TABLESPACE MAXDAT_DATA
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;


CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_AIU_SC_AUDIT_PAYROLL 
AFTER INSERT OR UPDATE OR DELETE ON DP_SCORECARD.SC_AUDIT_PAYROLL 
for each row
BEGIN

IF UPDATING THEN 
 
	BEGIN
  
	IF :old.Payroll_Audit_Date				<>	:new.Payroll_Audit_Date				
	OR :old.Payroll_Audit_Create_Date		<>	:new.Payroll_Audit_Create_Date		
	OR :old.Payroll_Audit_Create_USER		<>	:new.Payroll_Audit_Create_USER		
	OR :old.Payroll_Audit_Update_Date		<>	:new.Payroll_Audit_Update_Date		
	OR :old.Payroll_Audit_Update_USER		<>	:new.Payroll_Audit_Update_USER		
	OR :old.agent_staff_id					<>	:new.agent_staff_id					
	OR	:OLD.Correct_Project_Code			<>	:NEW.Correct_Project_Code		
	OR	:OLD.Holiday_PTO_Entry_Accurate		<>	:NEW.Holiday_PTO_Entry_Accurate	
	OR	:OLD.Applicable_Leave_Accurate		<>	:NEW.Applicable_Leave_Accurate	
	OR	:OLD.Total_Hours_Accurate			<>	:NEW.Total_Hours_Accurate		
	OR	:OLD.Payroll_Audit_Amount_of_time	<>	:NEW.Payroll_Audit_Amount_of_time
	OR	:OLD.Timesheet_Revision_Required		<>	:NEW.Timesheet_Revision_Required	
	OR	:OLD.Coaching_or_Corrective_Steps 	<>	:NEW.Coaching_or_Corrective_Steps 
	OR  :old.Payroll_Audit_Summary			<>	:new.Payroll_Audit_Summary
	OR  :OLD.Audit_System					<>	:NEW.Audit_System
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
		Audit_System
		)					
		VALUES 
			('Update',
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
		:OLD.Audit_System
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
		Audit_System
		) 
     VALUES 
      ('Update',
      'Insert',
	  sysdate,
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
		:NEW.Audit_System
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
		Audit_System
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
		:NEW.Audit_System
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
		Audit_System
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
		:old.Audit_System
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


GRANT DELETE, INSERT, SELECT, UPDATE ON DP_SCORECARD.SC_AUDIT_PAYROLL TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_PAYROLL TO MAXDAT_READ_ONLY;

GRANT DELETE, INSERT, SELECT, UPDATE ON DP_SCORECARD.SC_AUDIT_PAYROLL TO MAXDAT_REPORTS;

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

DROP VIEW DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT_SV
(RECORD_TYPE, RECORD_ACTION, TRANSACTION_DATE, PAYROLL_AUDIT_ID, PAYROLL_AUDIT_DATE, 
 PAYROLL_AUDIT_CREATE_DATE, PAYROLL_AUDIT_CREATE_USER, PAYROLL_AUDIT_UPDATE_DATE, PAYROLL_AUDIT_UPDATE_USER, AGENT_STAFF_ID, 
 CORRECT_PROJECT_CODE, HOLIDAY_PTO_ENTRY_ACCURATE, APPLICABLE_LEAVE_ACCURATE, TOTAL_HOURS_ACCURATE, PAYROLL_AUDIT_AMOUNT_OF_TIME, 
 TIMESHEET_REVISION_REQUIRED, COACHING_OR_CORRECTIVE_STEPS, PAYROLL_AUDIT_SUMMARY, AUDIT_SYSTEM)
AS 
select RECORD_TYPE,RECORD_ACTION,TRANSACTION_DATE,PAYROLL_AUDIT_ID,
PAYROLL_AUDIT_DATE,PAYROLL_AUDIT_CREATE_DATE,PAYROLL_AUDIT_CREATE_USER,PAYROLL_AUDIT_UPDATE_DATE,PAYROLL_AUDIT_UPDATE_USER,AGENT_STAFF_ID,
CORRECT_PROJECT_CODE,HOLIDAY_PTO_ENTRY_ACCURATE,APPLICABLE_LEAVE_ACCURATE,TOTAL_HOURS_ACCURATE,
PAYROLL_AUDIT_AMOUNT_OF_TIME,TIMESHEET_REVISION_REQUIRED,COACHING_OR_CORRECTIVE_STEPS,PAYROLL_AUDIT_SUMMARY,AUDIT_SYSTEM 
from DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT;


GRANT SELECT ON DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT_SV TO MAXDAT_REPORTS;

------------------------------------------------------------------------------
------------------------------------------------------------------------------
DROP VIEW DP_SCORECARD.SC_AUDIT_PAYROLL_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SC_AUDIT_PAYROLL_SV
(PAYROLL_AUDIT_ID, PAYROLL_AUDIT_DATE, PAYROLL_AUDIT_CREATE_DATE, PAYROLL_AUDIT_CREATE_USER, PAYROLL_AUDIT_UPDATE_DATE, 
 PAYROLL_AUDIT_UPDATE_USER, AGENT_STAFF_ID, CORRECT_PROJECT_CODE, HOLIDAY_PTO_ENTRY_ACCURATE, APPLICABLE_LEAVE_ACCURATE, 
 TOTAL_HOURS_ACCURATE, PAYROLL_AUDIT_AMOUNT_OF_TIME, TIMESHEET_REVISION_REQUIRED, COACHING_OR_CORRECTIVE_STEPS, PAYROLL_AUDIT_SUMMARY, 
 AUDIT_SYSTEM)
AS 
SELECT PAYROLL_AUDIT_ID,PAYROLL_AUDIT_DATE,PAYROLL_AUDIT_CREATE_DATE,PAYROLL_AUDIT_CREATE_USER,PAYROLL_AUDIT_UPDATE_DATE,
PAYROLL_AUDIT_UPDATE_USER,AGENT_STAFF_ID,CORRECT_PROJECT_CODE,HOLIDAY_PTO_ENTRY_ACCURATE,APPLICABLE_LEAVE_ACCURATE,
TOTAL_HOURS_ACCURATE,PAYROLL_AUDIT_AMOUNT_OF_TIME,TIMESHEET_REVISION_REQUIRED,
COACHING_OR_CORRECTIVE_STEPS,PAYROLL_AUDIT_SUMMARY,AUDIT_SYSTEM 
FROM DP_SCORECARD.SC_AUDIT_PAYROLL;


GRANT DELETE, INSERT, SELECT, UPDATE ON DP_SCORECARD.SC_AUDIT_PAYROLL_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_PAYROLL_SV TO MAXDAT_READ_ONLY;

GRANT DELETE, INSERT, SELECT, UPDATE ON DP_SCORECARD.SC_AUDIT_PAYROLL_SV TO MAXDAT_REPORTS;

------------------------------------------------------------------------------
------------------------------------------------------------------------------
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
  IN_PAYROLL_AUDIT_AMOUNT_OF_TM  	IN	VARCHAR2
   )

AS
 --  v_username varchar2(100);
BEGIN

	if IN_PAYROLL_AUDIT_ID IS NULL
	or Trunc(IN_PAYROLL_AUDIT_DATE) > trunc(sysdate)
	then
		null;
    elsif in_delete_flag = 1 then
		delete from dp_scorecard.SC_AUDIT_PAYROLL where PAYROLL_AUDIT_ID = IN_PAYROLL_AUDIT_ID;
		commit;
   else
       
       
       update dp_scorecard.SC_AUDIT_PAYROLL
          set 
		  PAYROLL_AUDIT_DATE           =	IN_PAYROLL_AUDIT_DATE,           
		  PAYROLL_AUDIT_UPDATE_DATE    =	sysdate,
		  PAYROLL_AUDIT_UPDATE_USER    =	IN_PAYROLL_AUDIT_UPDATE_USER,   
		  AGENT_STAFF_ID               =	IN_AGENT_STAFF_ID,               
		  CORRECT_PROJECT_CODE         =	IN_CORRECT_PROJECT_CODE,         
		  HOLIDAY_PTO_ENTRY_ACCURATE   =	IN_HOLIDAY_PTO_ENTRY_ACCURATE,   
		  APPLICABLE_LEAVE_ACCURATE    =	IN_APPLICABLE_LEAVE_ACCURATE,    
		  TOTAL_HOURS_ACCURATE         =	IN_TOTAL_HOURS_ACCURATE,         
		  TIMESHEET_REVISION_REQUIRED  =	IN_TIMESHEET_REVISION_REQUIRED,  
		  COACHING_OR_CORRECTIVE_STEPS =	IN_COACHING_OR_CORRECTIVE_STEP, 
		  PAYROLL_AUDIT_SUMMARY        =	IN_PAYROLL_AUDIT_SUMMARY,        
		  AUDIT_SYSTEM                 =	IN_AUDIT_SYSTEM,                 
		  PAYROLL_AUDIT_AMOUNT_OF_TIME =	IN_PAYROLL_AUDIT_AMOUNT_OF_TM 
        where PAYROLL_AUDIT_ID = IN_PAYROLL_AUDIT_ID;

       commit;

   end if;

END;
/

show errors

grant execute on DP_SCORECARD.Update_SC_AUDIT_PAYROLL to maxdat;

grant execute on DP_SCORECARD.Update_SC_AUDIT_PAYROLL to maxdat_reports;

grant debug on DP_SCORECARD.Update_SC_AUDIT_PAYROLL to dp_scorecard_read_only;


CREATE OR REPLACE Procedure DP_SCORECARD.INSERT_SC_AUDIT_PAYROLL
   (
  IN_PAYROLL_AUDIT_create_USER     IN	VARCHAR2,   
  IN_PAYROLL_AUDIT_DATE            IN	DATE,
  IN_AGENT_STAFF_ID                IN	NUMBER,
  IN_CORRECT_PROJECT_CODE          IN	VARCHAR2,
  IN_HOLIDAY_PTO_ENTRY_ACCURATE    IN	VARCHAR2,
  IN_APPLICABLE_LEAVE_ACCURATE     IN	VARCHAR2,
  IN_TOTAL_HOURS_ACCURATE          IN	VARCHAR2,
  IN_TIMESHEET_REVISION_REQUIRED   IN	VARCHAR2,
  IN_COACHING_OR_CORRECTIVE_STEP  IN	VARCHAR2,
  IN_PAYROLL_AUDIT_SUMMARY         IN	VARCHAR2,
  IN_AUDIT_SYSTEM                  IN	VARCHAR2,
  IN_PAYROLL_AUDIT_AMOUNT_OF_TM  IN	VARCHAR2
   )

AS
 --  v_username varchar2(100);
BEGIN

	if Trunc(IN_PAYROLL_AUDIT_DATE) > trunc(sysdate)
	then 
		null;
	else
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
		PAYROLL_AUDIT_AMOUNT_OF_TIME 
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
		IN_PAYROLL_AUDIT_AMOUNT_OF_TM 
	);
	
	end if;	
	
	commit;
	
END;
/

show errors


grant execute on DP_SCORECARD.INSERT_SC_AUDIT_PAYROLL to MAXDAT;

grant execute on DP_SCORECARD.INSERT_SC_AUDIT_PAYROLL to MAXDAT_REPORTS;

grant DEBUG on DP_SCORECARD.INSERT_SC_AUDIT_PAYROLL to DP_SCORECARD_READ_ONLY;



