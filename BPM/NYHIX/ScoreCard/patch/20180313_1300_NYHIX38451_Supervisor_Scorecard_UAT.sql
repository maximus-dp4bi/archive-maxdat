DROP SEQUENCE DP_SCORECARD.SEQ_SC_AUDIT_PAYROLL_ID;
DROP SEQUENCE DP_SCORECARD.SEQ_SC_AUDIT_SCORECARD_ID;

DROP VIEW DP_SCORECARD.SC_AUDIT_SYSTEM_LKUP_SV;
DROP TABLE DP_SCORECARD.SC_AUDIT_SYSTEM_LKUP CASCADE CONSTRAINTS;

DROP VIEW DP_SCORECARD.SC_AUDIT_TYPE_LKUP_SV;
DROP TABLE DP_SCORECARD.SC_AUDIT_TYPE_LKUP CASCADE CONSTRAINTS;

DROP VIEW DP_SCORECARD.SC_YES_NO_LKUP_SV;
DROP TABLE DP_SCORECARD.SC_YES_NO_LKUP CASCADE CONSTRAINTS;
 
DROP VIEW DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT_SV;
DROP TABLE DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT CASCADE CONSTRAINTS;

DROP VIEW DP_SCORECARD.SC_AUDIT_PAYROLL_SV;
DROP TABLE DP_SCORECARD.SC_AUDIT_PAYROLL;
 
DROP VIEW DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT_SV;
DROP TABLE DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT CASCADE CONSTRAINTS;

DROP VIEW DP_SCORECARD.SC_AUDIT_SCORECARD_SV;
DROP TABLE DP_SCORECARD.SC_AUDIT_SCORECARD CASCADE CONSTRAINTS;

drop TRIGGER DP_SCORECARD.TRG_AIU_SC_AUDIT_PAYROLL;
drop TRIGGER DP_SCORECARD.TRG_BIU_SC_AUDIT_PAYROLL;

drop TRIGGER DP_SCORECARD.TRG_AIU_SC_AUDIT_SCORECARD;
drop TRIGGER DP_SCORECARD.TRG_BIU_SC_AUDIT_SCORECARD;

drop view DP_SCORECARD.SC_AUDIT_HIERARCHY_JOB_LVLS_SV;

-- drop Procedure dp_scorecard.Insert_Attendance;

DROP VIEW DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV;

DROP VIEW DP_SCORECARD.SCORECARD_GOAL_SV;

DROP VIEW DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV;

DROP VIEW DP_SCORECARD.SCORECARD_SUPERVISOR_ATTND_SV;



 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- DROP SEQUENCE DP_SCORECARD.SEQ_SC_AUDIT_PAYROLL_ID;

CREATE SEQUENCE DP_SCORECARD.SEQ_SC_AUDIT_PAYROLL_ID
  START WITH 160
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;
  
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- DROP SEQUENCE DP_SCORECARD.SEQ_SC_AUDIT_SCORECARD_ID;

CREATE SEQUENCE DP_SCORECARD.SEQ_SC_AUDIT_SCORECARD_ID
  START WITH 120
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;

  
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- DROP TABLE DP_SCORECARD.SC_AUDIT_SYSTEM_LKUP CASCADE CONSTRAINTS;

CREATE TABLE DP_SCORECARD.SC_AUDIT_SYSTEM_LKUP
(
  AUDIT_SYSTEM  VARCHAR2(20 BYTE)
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


GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SYSTEM_LKUP TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SYSTEM_LKUP TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SYSTEM_LKUP TO MAXDAT_REPORTS;  
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SYSTEM_LKUP TO DP_SCORECARD_READ_ONLY;

Insert into DP_SCORECARD.SC_AUDIT_SYSTEM_LKUP
   (AUDIT_SYSTEM)
 Values
   ('Fieldglass');
   
Insert into DP_SCORECARD.SC_AUDIT_SYSTEM_LKUP
   (AUDIT_SYSTEM)
 Values
   ('Deltek');

COMMIT;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- DROP VIEW DP_SCORECARD.SC_AUDIT_SYSTEM_LKUP_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SC_AUDIT_SYSTEM_LKUP_SV
(AUDIT_SYSTEM)
AS 
select AUDIT_SYSTEM from DP_SCORECARD.SC_AUDIT_system_lkup;


GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SYSTEM_LKUP_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SYSTEM_LKUP_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SYSTEM_LKUP_SV TO MAXDAT_REPORTS;
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SYSTEM_LKUP_SV TO dp_scorecard_READ_ONLY;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- DROP TABLE DP_SCORECARD.SC_AUDIT_TYPE_LKUP CASCADE CONSTRAINTS;

CREATE TABLE DP_SCORECARD.SC_AUDIT_TYPE_LKUP
(
  AUDIT_TYPE  VARCHAR2(20 BYTE)
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

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TYPE_LKUP TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TYPE_LKUP TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TYPE_LKUP TO MAXDAT_REPORTS;
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TYPE_LKUP TO DP_SCORECARD_READ_ONLY;

INSERT INTO DP_SCORECARD.SC_AUDIT_TYPE_lkup
VALUES ('Scorecard Audit');

INSERT INTO DP_SCORECARD.SC_AUDIT_TYPE_lkup
VALUES ('Payroll Audit');

commit;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------


-- DROP VIEW DP_SCORECARD.SC_AUDIT_TYPE_LKUP_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SC_AUDIT_TYPE_LKUP_SV
(AUDIT_TYPE)
AS 
select AUDIT_TYPE from dp_scorecard.SC_AUDIT_TYPE_lkup;


GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TYPE_LKUP_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TYPE_LKUP_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TYPE_LKUP_SV TO MAXDAT_REPORTS;
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TYPE_LKUP_SV TO DP_SCORECARD_READ_ONLY;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- DROP TABLE DP_SCORECARD.SC_YES_NO_LKUP CASCADE CONSTRAINTS;

CREATE TABLE DP_SCORECARD.SC_YES_NO_LKUP
(
  YES_NO_VALUE  VARCHAR2(3 BYTE)
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


GRANT SELECT ON DP_SCORECARD.SC_YES_NO_LKUP TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SC_YES_NO_LKUP TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SC_YES_NO_LKUP TO MAXDAT_REPORTS;
GRANT SELECT ON DP_SCORECARD.SC_YES_NO_LKUP TO DP_SCORECARD_READ_ONLY;

insert into DP_SCORECARD.SC_YES_NO_lkup
values ( 'Yes');

insert into DP_SCORECARD.SC_YES_NO_lkup
values ( 'No');

commit;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- DROP VIEW DP_SCORECARD.SC_YES_NO_LKUP_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SC_YES_NO_LKUP_SV
(YES_NO_VALUE)
AS 
select YES_NO_VALUE from DP_SCORECARD.SC_YES_NO_lkup;


GRANT SELECT ON DP_SCORECARD.SC_YES_NO_LKUP_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SC_YES_NO_LKUP_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SC_YES_NO_LKUP_SV TO MAXDAT_REPORTS;
GRANT SELECT ON DP_SCORECARD.SC_YES_NO_LKUP_SV TO DP_SCORECARD_READ_ONLY;


-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- DROP TABLE DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT CASCADE CONSTRAINTS;

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
  PAYROLL_AUDIT_AMOUNT_OF_TIME  NUMBER
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
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT TO DP_SCORECARD_READ_ONLY;

----------------------------------------------------------------------------
----------------------------------------------------------------------------

-- DROP VIEW DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT_SV;

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
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT_SV TO DP_SCORECARD_READ_ONLY;

----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------

-- DROP TABLE DP_SCORECARD.SC_AUDIT_PAYROLL CASCADE CONSTRAINTS;

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
  PAYROLL_AUDIT_AMOUNT_OF_TIME  NUMBER
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

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- drop TRIGGER DP_SCORECARD.TRG_AIU_SC_AUDIT_PAYROLL;


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

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- drop TRIGGER DP_SCORECARD.TRG_BIU_SC_AUDIT_PAYROLL;

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
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_PAYROLL TO DP_SCORECARD_READ_ONLY;

----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------

-- DROP VIEW DP_SCORECARD.SC_AUDIT_PAYROLL_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SC_AUDIT_PAYROLL_SV
(PAYROLL_AUDIT_ID, PAYROLL_AUDIT_DATE, PAYROLL_AUDIT_CREATE_DATE, PAYROLL_AUDIT_CREATE_USER, PAYROLL_AUDIT_UPDATE_DATE, 
 PAYROLL_AUDIT_UPDATE_USER, AGENT_STAFF_ID, CORRECT_PROJECT_CODE, HOLIDAY_PTO_ENTRY_ACCURATE, APPLICABLE_LEAVE_ACCURATE, 
 TOTAL_HOURS_ACCURATE, PAYROLL_AUDIT_AMOUNT_OF_TIME, TIMESHEET_REVISION_REQUIRED, 
 COACHING_OR_CORRECTIVE_STEPS, PAYROLL_AUDIT_SUMMARY, 
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
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_PAYROLL_SV TO DP_SCORECARD_READ_ONLY;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- DROP TABLE DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT CASCADE CONSTRAINTS;

CREATE TABLE DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT
(
  RECORD_TYPE                    VARCHAR2(10 BYTE),
  RECORD_ACTION                  VARCHAR2(10 BYTE),
  TRANSACTION_DATE               DATE,
  SCORECARD_AUDIT_ID             NUMBER(13)     NOT NULL,
  SCORECARD_AUDIT_DATE           DATE           NOT NULL,
  SCORECARD_AUDIT_CREATE_DATE    DATE           NOT NULL,
  SCORECARD_AUDIT_CREATE_USER    VARCHAR2(100 BYTE) NOT NULL,
  SCORECARD_AUDIT_UPDATE_DATE    DATE           NOT NULL,
  SCORECARD_AUDIT_UPDATE_USER    VARCHAR2(100 BYTE) NOT NULL,
  AGENT_STAFF_ID                 NUMBER         NOT NULL,
  ATTEND_TRKR_UPDT_ACCURATELY    VARCHAR2(3 BYTE) DEFAULT 'No',
  CORRECTIVE_ACTIONS_UP_TO_DATE  VARCHAR2(3 BYTE) DEFAULT 'No',
  PERFORMANCE_TRKR_UP_TO_DATE    VARCHAR2(3 BYTE) DEFAULT 'No',
  GOALS_UPDATED                  VARCHAR2(3 BYTE) DEFAULT 'No',
  SCORECARD_AUDIT_SUMMARY        VARCHAR2(4000 BYTE)
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


GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT TO MAXDAT_REPORTS;
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT TO DP_SCORECARD_READ_ONLY;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- DROP VIEW DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT_SV
(RECORD_TYPE, RECORD_ACTION, TRANSACTION_DATE, SCORECARD_AUDIT_ID, SCORECARD_AUDIT_DATE, 
 SCORECARD_AUDIT_CREATE_DATE, SCORECARD_AUDIT_CREATE_USER, SCORECARD_AUDIT_UPDATE_DATE, SCORECARD_AUDIT_UPDATE_USER, AGENT_STAFF_ID, 
 ATTEND_TRKR_UPDT_ACCURATELY, CORRECTIVE_ACTIONS_UP_TO_DATE, PERFORMANCE_TRKR_UP_TO_DATE, GOALS_UPDATED, SCORECARD_AUDIT_SUMMARY)
AS 
SELECT RECORD_TYPE,RECORD_ACTION,TRANSACTION_DATE,SCORECARD_AUDIT_ID,SCORECARD_AUDIT_DATE,
SCORECARD_AUDIT_CREATE_DATE,SCORECARD_AUDIT_CREATE_USER,SCORECARD_AUDIT_UPDATE_DATE,SCORECARD_AUDIT_UPDATE_USER,AGENT_STAFF_ID,
ATTEND_TRKR_UPDT_ACCURATELY,CORRECTIVE_ACTIONS_UP_TO_DATE,PERFORMANCE_TRKR_UP_TO_DATE,GOALS_UPDATED,SCORECARD_AUDIT_SUMMARY
 FROM DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT;


GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT_SV TO MAXDAT_REPORTS;
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT_SV TO DP_SCORECARD_READ_ONLY;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- DROP TABLE DP_SCORECARD.SC_AUDIT_SCORECARD CASCADE CONSTRAINTS;

CREATE TABLE DP_SCORECARD.SC_AUDIT_SCORECARD
(
  SCORECARD_AUDIT_ID             NUMBER(13)     NOT NULL,
  SCORECARD_AUDIT_DATE           DATE           NOT NULL,
  SCORECARD_AUDIT_CREATE_DATE    DATE           NOT NULL,
  SCORECARD_AUDIT_CREATE_USER    VARCHAR2(100 BYTE) NOT NULL,
  SCORECARD_AUDIT_UPDATE_DATE    DATE           NOT NULL,
  SCORECARD_AUDIT_UPDATE_USER    VARCHAR2(100 BYTE) NOT NULL,
  AGENT_STAFF_ID                 NUMBER         NOT NULL,
  ATTEND_TRKR_UPDT_ACCURATELY    VARCHAR2(3 BYTE) DEFAULT 'No',
  CORRECTIVE_ACTIONS_UP_TO_DATE  VARCHAR2(3 BYTE) DEFAULT 'No',
  PERFORMANCE_TRKR_UP_TO_DATE    VARCHAR2(3 BYTE) DEFAULT 'No',
  GOALS_UPDATED                  VARCHAR2(3 BYTE) DEFAULT 'No',
  SCORECARD_AUDIT_SUMMARY        VARCHAR2(4000 BYTE)
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

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- drop TRIGGER DP_SCORECARD.TRG_AIU_SC_AUDIT_SCORECARD;

CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_AIU_SC_AUDIT_SCORECARD 
AFTER INSERT OR UPDATE OR DELETE ON DP_SCORECARD.SC_AUDIT_SCORECARD 
for each row
BEGIN

IF UPDATING THEN 
 
	BEGIN
  
	IF :old.Scorecard_Audit_Date				<> :new.Scorecard_Audit_Date				
	OR :old.Scorecard_Audit_Create_Date			<> :new.Scorecard_Audit_Create_Date			
	OR :old.Scorecard_Audit_Create_USER			<> :new.Scorecard_Audit_Create_USER			
	OR :old.Scorecard_Audit_Update_Date			<> :new.Scorecard_Audit_Update_Date			
	OR :old.Scorecard_Audit_Update_USER			<> :new.Scorecard_Audit_Update_USER			
	OR :old.agent_staff_id						<> :new.agent_staff_id						
	OR :old.Attend_Trkr_UPDT_Accurately			<> :new.Attend_Trkr_UPDT_Accurately			
	OR :old.Corrective_Actions_up_to_date		<> :new.Corrective_Actions_up_to_date		
	OR :old.Performance_Trkr_Up_to_Date			<> :new.Performance_Trkr_Up_to_Date			
	OR :old.Goals_Updated						<> :new.Goals_Updated						
	OR :old.Scorecard_Audit_Summary				<> :new.Scorecard_Audit_Summary				
	THEN
		INSERT INTO SC_AUDIT_SCORECARD_AUDIT
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
		Scorecard_Audit_Summary			
		)			
		VALUES 
			('Update',
			'Delete',
			sysdate,
		:old.Scorecard_Audit_ID,				
		:old.Scorecard_Audit_Date,			
		:old.Scorecard_Audit_Create_Date,		
		:old.Scorecard_Audit_Create_USER,		
		:old.Scorecard_Audit_Update_Date,		
		:old.Scorecard_Audit_Update_USER,		
		:old.Agent_staff_id,					
		:old.Attend_Trkr_UPDT_Accurately,		
		:old.Corrective_Actions_up_to_date,	
		:old.Performance_Trkr_Up_to_Date,		
		:old.Goals_Updated,					
		:old.Scorecard_Audit_Summary			
			);      

 INSERT INTO SC_AUDIT_SCORECARD_AUDIT
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
		Scorecard_Audit_Summary			
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
		:new.Scorecard_Audit_Update_USER,		
		:new.Agent_staff_id,					
		:new.Attend_Trkr_UPDT_Accurately,		
		:new.Corrective_Actions_up_to_date,	
		:new.Performance_Trkr_Up_to_Date,		
		:new.Goals_Updated,					
		:new.Scorecard_Audit_Summary			
      );
      
	END IF;
	
	END;
	
END IF;

IF INSERTING THEN 
    INSERT INTO SC_AUDIT_SCORECARD_AUDIT
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
		Scorecard_Audit_Summary			
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
		:new.Scorecard_Audit_Update_USER,		
		:new.Agent_staff_id,					
		:new.Attend_Trkr_UPDT_Accurately,		
		:new.Corrective_Actions_up_to_date,	
		:new.Performance_Trkr_Up_to_Date,		
		:new.Goals_Updated,					
		:new.Scorecard_Audit_Summary			
		);					
        
END IF;

IF DELETING THEN 
        INSERT INTO SC_AUDIT_SCORECARD_AUDIT
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
		Scorecard_Audit_Summary			
		) 
        VALUES 
            ('Delete',
            'Delete',
			sysdate,
		:old.Scorecard_Audit_ID,				
		:old.Scorecard_Audit_Date,			
		:old.Scorecard_Audit_Create_Date,		
		:old.Scorecard_Audit_Create_USER,		
		:old.Scorecard_Audit_Update_Date,		
		:old.Scorecard_Audit_Update_USER,		
		:old.Agent_staff_id,					
		:old.Attend_Trkr_UPDT_Accurately,		
		:old.Corrective_Actions_up_to_date,	
		:old.Performance_Trkr_Up_to_Date,		
		:old.Goals_Updated,					
		:old.Scorecard_Audit_Summary			
		);
    END IF;

END;
/

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- drop TRIGGER DP_SCORECARD.TRG_BIU_SC_AUDIT_SCORECARD;

CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_BIU_SC_AUDIT_SCORECARD
BEFORE INSERT OR UPDATE ON DP_SCORECARD.SC_AUDIT_SCORECARD
FOR EACH ROW
BEGIN
	:new.Scorecard_Audit_Update_Date := sysdate;

	IF :NEW.SCORECARD_AUDIT_UPDATE_USER IS NULL
		THEN :NEW.SCORECARD_AUDIT_UPDATE_USER := USER;
	END IF;

	IF INSERTING THEN
		:new.Scorecard_Audit_ID			 := DP_SCORECARD.SEQ_SC_AUDIT_SCORECARD_ID.nextval;
		:new.Scorecard_Audit_Create_Date := sysdate;
		:new.Scorecard_Audit_Create_USER := nvl(:new.Scorecard_Audit_update_USER,user);
  END IF;


end;
/


GRANT DELETE, INSERT, SELECT, UPDATE ON DP_SCORECARD.SC_AUDIT_SCORECARD TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SCORECARD TO MAXDAT_READ_ONLY;
GRANT DELETE, INSERT, SELECT, UPDATE ON DP_SCORECARD.SC_AUDIT_SCORECARD TO MAXDAT_REPORTS;
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SCORECARD TO DP_SCORECARD_READ_ONLY;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- DROP VIEW DP_SCORECARD.SC_AUDIT_SCORECARD_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SC_AUDIT_SCORECARD_SV
(SCORECARD_AUDIT_ID, SCORECARD_AUDIT_DATE, SCORECARD_AUDIT_CREATE_DATE, SCORECARD_AUDIT_CREATE_USER, SCORECARD_AUDIT_UPDATE_DATE, 
 SCORECARD_AUDIT_UPDATE_USER, AGENT_STAFF_ID, ATTEND_TRKR_UPDT_ACCURATELY, CORRECTIVE_ACTIONS_UP_TO_DATE, PERFORMANCE_TRKR_UP_TO_DATE, 
 GOALS_UPDATED, SCORECARD_AUDIT_SUMMARY)
AS 
SELECT SCORECARD_AUDIT_ID,SCORECARD_AUDIT_DATE,SCORECARD_AUDIT_CREATE_DATE,SCORECARD_AUDIT_CREATE_USER,SCORECARD_AUDIT_UPDATE_DATE,
SCORECARD_AUDIT_UPDATE_USER,AGENT_STAFF_ID,ATTEND_TRKR_UPDT_ACCURATELY,CORRECTIVE_ACTIONS_UP_TO_DATE,PERFORMANCE_TRKR_UP_TO_DATE,
GOALS_UPDATED,SCORECARD_AUDIT_SUMMARY 
FROM DP_SCORECARD.SC_AUDIT_scorecard;


GRANT DELETE, INSERT, SELECT, UPDATE ON DP_SCORECARD.SC_AUDIT_SCORECARD_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SCORECARD_SV TO MAXDAT_READ_ONLY;
GRANT DELETE, INSERT, SELECT, UPDATE ON DP_SCORECARD.SC_AUDIT_SCORECARD_SV TO MAXDAT_REPORTS;
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SCORECARD_SV TO DP_SCORECARD_READ_ONLY;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- drop DP_SCORECARD.SC_AUDIT_HIERARCHY_JOB_LVLS_SV

CREATE OR REPLACE VIEW DP_SCORECARD.SC_AUDIT_HIERARCHY_JOB_LVLS_SV
AS
SELECT JOB_LVL, JOB_CODE, JOB_TITLE
FROM (
    SELECT '1' AS JOB_LVL, JOB_CLASSIFICATION_CODE_ID AS JOB_CODE, CODE AS JOB_TITLE
    FROM DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV 
    WHERE ( TRUNC(SYSDATE) BETWEEN TRUNC(OWNER_DATE) AND TRUNC(NVL(DELETE_DATE,SYSDATE)) )
    AND CODE IN ('Sr. Director')
    union
    SELECT '2' AS CODE_LVL, JOB_CLASSIFICATION_CODE_ID, CODE
    FROM DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV 
    WHERE ( TRUNC(SYSDATE) BETWEEN TRUNC(OWNER_DATE) AND TRUNC(NVL(DELETE_DATE,SYSDATE)) )
    AND CODE IN ('Director')
    UNION
    SELECT '3' AS CODE_LVL, JOB_CLASSIFICATION_CODE_ID, CODE
    FROM DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV 
    WHERE ( TRUNC(SYSDATE) BETWEEN TRUNC(OWNER_DATE) AND TRUNC(NVL(DELETE_DATE,SYSDATE)) )
    AND CODE IN ('Sr. Manager')
    UNION
    SELECT '4' AS CODE_LVL, JOB_CLASSIFICATION_CODE_ID, CODE
    FROM  DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV 
    WHERE ( TRUNC(SYSDATE) BETWEEN TRUNC(OWNER_DATE) AND TRUNC(NVL(DELETE_DATE,SYSDATE)) )
    AND JOB_CLASSIFICATION_CODE_ID IN (1057,1018,1044)
    UNION
    SELECT '5' AS CODE_LVL, JOB_CLASSIFICATION_CODE_ID, CODE
    FROM  DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV 
    WHERE ( TRUNC(SYSDATE) BETWEEN TRUNC(OWNER_DATE) AND TRUNC(NVL(DELETE_DATE,SYSDATE)) )
    AND JOB_CLASSIFICATION_CODE_ID IN (1058,1031)
    UNION
    SELECT '6' AS CODE_LVL, JOB_CLASSIFICATION_CODE_ID, CODE
    FROM  DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV
    WHERE ( TRUNC(SYSDATE) BETWEEN TRUNC(OWNER_DATE) AND TRUNC(NVL(DELETE_DATE,SYSDATE)) )
    AND JOB_CLASSIFICATION_CODE_ID 
	IN ('1068','1059','1054','1053','1024','1011','1010','1009','1008','1043','1019','1013','1012',
	    '1056','1047','1028','1025','1061','1032','1033','1060','1039','1063','1038','1037','1035',
		'1052','1030','1022','1020','1046','1055','1026','1023','1027','1045','1051','1050','1049',
		'1048','1017','1016','1015','1014'
		)
    )
;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_HIERARCHY_JOB_LVLS_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_HIERARCHY_JOB_LVLS_SV  TO MAXDAT_REPORTS;
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_HIERARCHY_JOB_LVLS_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SC_AUDIT_HIERARCHY_JOB_LVLS_SV TO DP_SCORECARD_READ_ONLY;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- drop Procedure dp_scorecard.Insert_Attendance

create or replace Procedure dp_scorecard.Insert_Attendance
   ( in_staff_id in number
   , in_absence_type_id in number
   , in_datetime in date
   , in_NATIONAL_ID	in NUMBER )

AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/ScoreCard/patch/20170929_1610_SC_ATTENDANCE_DDL_PRD3.sql $';
  	SVN_REVISION varchar2(20) := '$Revision: 21344 $';
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2017-09-27 11:12:30 -0400 (Wed, 27 Sep 2017) $';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';


   v_incentive_flag varchar2(1);
   v_username varchar2(100);

   cursor c1 is
   select incentive_flag from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where sc_all_id=in_absence_type_id;

BEGIN

   open c1;
   fetch c1 into v_incentive_flag;

   if c1%notfound then
      v_incentive_flag := NULL;
   end if;

   if  in_staff_id is null or in_absence_type_id is null or in_datetime is null or in_NATIONAL_ID is null then
     /*do nothing*/
      null;
   else
      --get username
      select name into v_username from
      (
        SELECT 'ADMIN' as NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE admin_id=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_director_natid=in_NATIONAL_ID
        UNION
        SELECT director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE director_natid=in_NATIONAL_ID
        UNION
        SELECT sr_manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_manager_natid=in_NATIONAL_ID
        UNION
        SELECT manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE manager_natid=in_NATIONAL_ID
        UNION
        SELECT supervisor_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE supervisor_natid=in_NATIONAL_ID
      );

      --insert into pp_bo_scorecard. added where clause to prevent user from adding dates before staff's hire date or future dates
      insert into dp_scorecard.sc_attendance
        (sc_attendance_id, staff_id, entry_date, sc_all_id, absence_type, point_value, create_by, create_datetime, incentive_flag, last_updated_by, LAST_UPDATED_DATETIME)
        (select SEQ_SCAS_ID.nextval,
                in_staff_id,
                trunc(in_datetime),
                in_absence_type_id,
                (select absence_type from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where sc_all_id=in_absence_type_id),
                (select point_value from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where sc_all_id=in_absence_type_id),
                v_username,
                sysdate,
                v_incentive_flag,
                v_username,
                sysdate
          from dual
          where (
                trunc(sysdate) >= (select min(dates)
                                from ( select min(dates) dates
                                        from DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV 
                                        where staff_staff_id=5255 
                                        and sc_attendance_id=0
                                       union  -- << added to allow for staff i.e. supervisors who do not have 
                                              -- an entry in DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV 
                                       select trunc(sysdate) from dual 
                                        )
                                )       
          and trunc(in_datetime) <= trunc(sysdate)
				));

       commit;

       --call procedure to recalculate running totals for this staff id
       --DP_SCORECARD.Calc_Attendance_Score(in_staff_id)
       --call procedure to populate monthly score table
       --DP_SCORECARD.Update_Sc_Attendance_Mthly(in_staff_id)

       DP_SCORECARD.Calc_Attendance_Score_PKG.CALC_ATTENDANCE_SCORE(in_staff_id);

   end if;

   close c1;

END;
/

grant execute on dp_scorecard.Insert_Attendance to MAXDAT;
grant execute on dp_scorecard.Insert_Attendance to MAXDAT_REPORTS;

grant debug dp_scorecard.Insert_Attendance to DP_SCORECARD_READ_ONLY;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- DROP VIEW DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV
AS 
select    ca.staff_id as search_staff_id, 
          sh.manager_staff_id,
          sh.manager_name,
		  SH.MANAGER_NATID,
          sh.supervisor_staff_id,
          sh.supervisor_name,
          sh.staff_staff_id,
          sh.staff_staff_name,
          sh.staff_natid,
          ca.ca_id,
          ca.ca_entry_date,
          ca.cal_id,
          cal.correction_action_type,
          ca.unsatisfactory_behavior,
          ca.comments,
          ca.create_by,
          ca.create_datetime,
          ca.last_updated_by,
          ca.LAST_UPDATED_DATETIME
      from dp_scorecard.sc_corrective_action ca
      join dp_scorecard.sc_corrective_action_lkup cal on ca.cal_id=cal.cal_id
      left outer join (
                select 
                staff_staff_id as SEARCH_staff_id,
                manager_staff_id,
                manager_name,
				MANAGER_NATID,
                supervisor_staff_id,
                supervisor_natid,
                supervisor_name,
                staff_staff_id,
                staff_staff_name,
                staff_natid
            from dp_scorecard.scorecard_hierarchy
            union
                select
                supervisor_staff_id as SEARCH_staff_id,
                manager_staff_id,
                manager_name,
				MANAGER_NATID,
                supervisor_staff_id,
                supervisor_natid,
                supervisor_name,
                null as staff_staff_id,
                null as staff_staff_name,
                null as staff_natid
            from dp_scorecard.scorecard_hierarchy
            ) sh
            on ca.staff_id=sh.SEARCH_staff_id
      ;


GRANT SELECT ON DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV TO MAXDAT_REPORTS;
GRANT SELECT ON DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV TO DP_SCORECARD_READ_ONLY;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- DROP VIEW DP_SCORECARD.SCORECARD_GOAL_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_GOAL_SV
AS 
select
		G.staff_id     AS SEARCH_staff_id,
       sh.manager_staff_id,
       sh.manager_name,
	   SH.MANAGER_NATID,
       sh.supervisor_staff_id,
       sh.supervisor_name,
       sh.staff_staff_id,
       sh.staff_staff_name,
       sh.staff_natid,
       g.goal_id,
       g.staff_id,
       g.goal_entry_date,
       g.gtl_id,
       g.goal_description,
       g.goal_date,
       g.progress_note,
       g.create_by,
       g.create_datetime,
       g.last_updated_by,
       g.LAST_UPDATED_DATETIME
  from dp_scorecard.sc_goal g
  join dp_scorecard.sc_goal_type_lkup gtl on g.gtl_id=gtl.gtl_id
  left outer join (
                select 
                staff_staff_id as SEARCH_staff_id,
                manager_staff_id,
                manager_name,
				MANAGER_NATID,
                supervisor_staff_id,
                supervisor_natid,
                supervisor_name,
                staff_staff_id,
                staff_staff_name,
                staff_natid
            from dp_scorecard.scorecard_hierarchy
            union
                select
                supervisor_staff_id as SEARCH_staff_id,
                manager_staff_id,
                manager_name,
				MANAGER_NATID,
                supervisor_staff_id,
                supervisor_natid,
                supervisor_name,
                null as staff_staff_id,
                null as staff_staff_name,
                null as staff_natid
            from dp_scorecard.scorecard_hierarchy
            ) sh
		on g.staff_id=sh.SEARCH_staff_id;


GRANT SELECT ON DP_SCORECARD.SCORECARD_GOAL_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SCORECARD_GOAL_SV TO MAXDAT_REPORTS;
GRANT SELECT ON DP_SCORECARD.SCORECARD_GOAL_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_GOAL_SV TO DP_SCORECARD_READ_ONLY;


-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- DROP VIEW DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV
AS 
select
			pt.STAFF_ID AS SEARCH_staff_id,	
           sh.manager_staff_id,
           sh.manager_name,
		   SH.MANAGER_NATID,
           sh.supervisor_staff_id,
           sh.supervisor_name,
           sh.staff_staff_id,
           sh.staff_staff_name,
           sh.staff_natid,
           pt.pt_id,
           pt.pt_entry_date,
           pt.dl_id,
           dl.discussion_topic,
           pt.comments,
           pt.create_by,
           pt.create_datetime,
           pt.last_updated_by,
           pt.LAST_UPDATED_DATETIME
    from dp_scorecard.sc_performance_tracker pt
    join dp_scorecard.sc_discussion_lkup dl on pt.dl_id=dl.dl_id
  left outer join (
                select 
                staff_staff_id as SEARCH_staff_id,
                manager_staff_id,
                manager_name,
				MANAGER_NATID,
                supervisor_staff_id,
                supervisor_natid,
                supervisor_name,
                staff_staff_id,
                staff_staff_name,
                staff_natid
            from dp_scorecard.scorecard_hierarchy
            union
                select
                supervisor_staff_id as SEARCH_staff_id,
                manager_staff_id,
                manager_name,
				MANAGER_NATID,
                supervisor_staff_id,
                supervisor_natid,
                supervisor_name,
                null as staff_staff_id,
                null as staff_staff_name,
                null as staff_natid
            from dp_scorecard.scorecard_hierarchy
            ) sh
	on pt.staff_id=sh.SEARCH_staff_id;


GRANT SELECT ON DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV TO MAXDAT_REPORTS;
GRANT SELECT ON DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV TO DP_SCORECARD_READ_ONLY;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- DROP VIEW DP_SCORECARD.SCORECARD_SUPERVISOR_ATTND_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_SUPERVISOR_ATTND_SV
AS
SELECT  ATT.STAFF_ID AS SEARCH_STAFF_ID, 
        SH.MANAGER_STAFF_ID,
        SH.MANAGER_NAME,
		SH.MANAGER_NATID,
        SH.SUPERVISOR_STAFF_ID,
        SH.SUPERVISOR_NAME,
        SH.STAFF_STAFF_ID,
        SH.STAFF_STAFF_NAME,
        SH.STAFF_NATID,
        ATT.ENTRY_DATE        DATES, 
		ATT.CREATE_DATETIME, 
		ATT.SC_ATTENDANCE_ID, 
		ATT.INCENTIVE_FLAG, 
		LKUP.ABSENCE_TYPE
		--ATT.BALANCE, 
		--ATT.INCENTIVE_BALANCE, 
		--ATT.TOTAL_BALANCE, 
		--ATT.CREATE_BY, 
		--ATT.LAST_UPDATED_BY, 
		--ATT.LAST_UPDATED_DATETIME
FROM DP_SCORECARD.SC_ATTENDANCE ATT
JOIN DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP LKUP ON LKUP.SC_ALL_ID = ATT.SC_ALL_ID
LEFT OUTER JOIN ( 
                SELECT 
                STAFF_STAFF_ID AS SEARCH_STAFF_ID,
                MANAGER_STAFF_ID,
                MANAGER_NAME,
				MANAGER_NATID,
                SUPERVISOR_STAFF_ID,
                SUPERVISOR_NATID,
                SUPERVISOR_NAME,
                STAFF_STAFF_ID,
                STAFF_STAFF_NAME,
                STAFF_NATID
            FROM DP_SCORECARD.SCORECARD_HIERARCHY
            UNION
                SELECT
                SUPERVISOR_STAFF_ID AS SEARCH_STAFF_ID,
                MANAGER_STAFF_ID,
                MANAGER_NAME,
				MANAGER_NATID,
                SUPERVISOR_STAFF_ID,
                SUPERVISOR_NATID,
                SUPERVISOR_NAME,
                NULL AS STAFF_STAFF_ID,
                NULL AS STAFF_STAFF_NAME,
                NULL AS STAFF_NATID
            FROM DP_SCORECARD.SCORECARD_HIERARCHY
            ) SH
            ON ATT.STAFF_ID=SH.SEARCH_STAFF_ID;


GRANT SELECT ON DP_SCORECARD.SCORECARD_SUPERVISOR_ATTND_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SCORECARD_SUPERVISOR_ATTND_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SCORECARD_SUPERVISOR_ATTND_SV TO MAXDAT_REPORTS;
GRANT SELECT ON DP_SCORECARD.SCORECARD_SUPERVISOR_ATTND_SV TO DP_SCORECARD_READ_ONLY;
 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

CREATE OR REPLACE Procedure DP_SCORECARD.Update_SC_AUDIT_PAYROLL
   (
  IN_DELETE_FLAG					IN  NUMBER, 	-- REQUIRED 	-- if = 1 then delete else update
  IN_PAYROLL_AUDIT_ID              	IN	NUMBER,     -- REQUIRED 	-- PRIMARY KEY
  IN_PAYROLL_AUDIT_UPDATE_USER     	IN	VARCHAR2,   -- REQUIRED 	-- the staff_id of the user performing the update
  IN_PAYROLL_AUDIT_DATE            	IN	DATE,
  IN_AGENT_STAFF_ID                	IN	NUMBER,
  IN_CORRECT_PROJECT_CODE          	IN	VARCHAR2,
  IN_HOLIDAY_PTO_ENTRY_ACCURATE    	IN	VARCHAR2,
  IN_APPLICABLE_LEAVE_ACCURATE     	IN	VARCHAR2,
  IN_TOTAL_HOURS_ACCURATE          	IN	VARCHAR2,
  IN_TIMESHEET_REVISION_REQUIRED   	IN	VARCHAR2,
  IN_COACHING_OR_CORRECTIVE_STEPS  	IN	VARCHAR2,
  IN_PAYROLL_AUDIT_SUMMARY         	IN	VARCHAR2,
  IN_AUDIT_SYSTEM                  	IN	VARCHAR2,
  IN_PAYROLL_AUDIT_AMOUNT_OF_TIME  	IN	NUMBER
   )

AS
 --  v_username varchar2(100);
BEGIN

	if IN_DELETE_FLAG IS NULL
	or IN_PAYROLL_AUDIT_ID IS NULL
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
		  COACHING_OR_CORRECTIVE_STEPS =	IN_COACHING_OR_CORRECTIVE_STEPS, 
		  PAYROLL_AUDIT_SUMMARY        =	IN_PAYROLL_AUDIT_SUMMARY,        
		  AUDIT_SYSTEM                 =	IN_AUDIT_SYSTEM,                 
		  PAYROLL_AUDIT_AMOUNT_OF_TIME =	IN_PAYROLL_AUDIT_AMOUNT_OF_TIME 
        where PAYROLL_AUDIT_ID = IN_PAYROLL_AUDIT_ID;

       commit;

   end if;

END;
/

GRANT EXECUTE ON DP_SCORECARD.Update_SC_AUDIT_PAYROLL TO MAXDAT;
GRANT EXECUTE ON DP_SCORECARD.Update_SC_AUDIT_PAYROLL TO MAXDAT_REPORTS;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

CREATE OR REPLACE Procedure DP_SCORECARD.INSERT_SC_AUDIT_PAYROLL
   (
  IN_PAYROLL_AUDIT_create_USER     IN	VARCHAR2,   -- REQUIRED 	-- the staff_id of the user performing the insert
  IN_PAYROLL_AUDIT_DATE            IN	DATE,
  IN_AGENT_STAFF_ID                IN	NUMBER,
  IN_CORRECT_PROJECT_CODE          IN	VARCHAR2,
  IN_HOLIDAY_PTO_ENTRY_ACCURATE    IN	VARCHAR2,
  IN_APPLICABLE_LEAVE_ACCURATE     IN	VARCHAR2,
  IN_TOTAL_HOURS_ACCURATE          IN	VARCHAR2,
  IN_TIMESHEET_REVISION_REQUIRED   IN	VARCHAR2,
  IN_COACHING_OR_CORRECTIVE_STEPS  IN	VARCHAR2,
  IN_PAYROLL_AUDIT_SUMMARY         IN	VARCHAR2,
  IN_AUDIT_SYSTEM                  IN	VARCHAR2,
  IN_PAYROLL_AUDIT_AMOUNT_OF_TIME  IN	NUMBER
   )

AS
 --  v_username varchar2(100);
BEGIN

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
		IN_COACHING_OR_CORRECTIVE_STEPS, 
		IN_PAYROLL_AUDIT_SUMMARY,        
		IN_AUDIT_SYSTEM,                 
		IN_PAYROLL_AUDIT_AMOUNT_OF_TIME 
	);
		
	commit;
END;
/

GRANT EXECUTE ON DP_SCORECARD.INSERT_SC_AUDIT_PAYROLL TO MAXDAT;
GRANT EXECUTE ON DP_SCORECARD.INSERT_SC_AUDIT_PAYROLL TO MAXDAT_REPORTS;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
  
CREATE OR REPLACE Procedure DP_SCORECARD.Update_SC_AUDIT_SCORECARD
   (
  IN_DELETE_FLAG					in  NUMBER, 	-- REQUIRED -- if = 1 then delete else update
  IN_SCORECARD_AUDIT_ID             in NUMBER,			-- REQUIRED -- PRIMARY KEY
  IN_SCORECARD_AUDIT_UPDATE_USER    in VARCHAR2,     	-- REQUIRED	-- STAFF_ID OF THE PERSON PERFORMINT THE UPDATE
  IN_SCORECARD_AUDIT_DATE           in DATE,
  IN_AGENT_STAFF_ID                 in NUMBER,
  IN_ATTEND_TRKR_UPDT_ACCURATELY    in VARCHAR2,
  IN_CORRECTIVE_ACTIONS_UP_TO_DATE  in VARCHAR2,
  IN_PERFORMANCE_TRKR_UP_TO_DATE    in VARCHAR2,
  IN_GOALS_UPDATED                  in VARCHAR2,
  IN_SCORECARD_AUDIT_SUMMARY        in VARCHAR2
   )

   
AS
--   v_username varchar2(100);
BEGIN

	if IN_DELETE_FLAG IS NULL
	or IN_SCORECARD_AUDIT_ID IS NULL
	then
		null;
    elsif in_delete_flag = 1 then
		delete from dp_scorecard.SC_AUDIT_SCORECARD where SCORECARD_AUDIT_ID = IN_SCORECARD_AUDIT_ID;
		commit;
   else
       
       update dp_scorecard.SC_AUDIT_SCORECARD
          set 
		  SCORECARD_AUDIT_DATE           = IN_SCORECARD_AUDIT_DATE,         
		  SCORECARD_AUDIT_UPDATE_USER    = IN_SCORECARD_AUDIT_UPDATE_USER,  
		  AGENT_STAFF_ID                 = IN_AGENT_STAFF_ID,               
		  ATTEND_TRKR_UPDT_ACCURATELY    = IN_ATTEND_TRKR_UPDT_ACCURATELY,  
		  CORRECTIVE_ACTIONS_UP_TO_DATE  = IN_CORRECTIVE_ACTIONS_UP_TO_DATE,
		  PERFORMANCE_TRKR_UP_TO_DATE    = IN_PERFORMANCE_TRKR_UP_TO_DATE,  
		  GOALS_UPDATED                  = IN_GOALS_UPDATED,                
		  SCORECARD_AUDIT_SUMMARY        = IN_SCORECARD_AUDIT_SUMMARY      
        where SCORECARD_AUDIT_ID = IN_SCORECARD_AUDIT_ID;

       commit;

   end if;

END;
/
  
GRANT EXECUTE ON DP_SCORECARD.Update_SC_AUDIT_SCORECARD TO MAXDAT;
GRANT EXECUTE ON DP_SCORECARD.Update_SC_AUDIT_SCORECARD TO MAXDAT_REPORTS;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
  
CREATE OR REPLACE Procedure DP_SCORECARD.INSERT_SC_AUDIT_SCORECARD
   (
  IN_SCORECARD_AUDIT_create_USER    in VARCHAR2,     	-- REQUIRED	-- STAFF_ID OF THE PERSON PERFORMINT THE UPDATE
  IN_SCORECARD_AUDIT_DATE           in DATE,
  IN_AGENT_STAFF_ID                 in NUMBER,
  IN_ATTEND_TRKR_UPDT_ACCURATELY    in VARCHAR2,
  IN_CORRECTIVE_ACTIONS_UP_TO_DATE  in VARCHAR2,
  IN_PERFORMANCE_TRKR_UP_TO_DATE    in VARCHAR2,
  IN_GOALS_UPDATED                  in VARCHAR2,
  IN_SCORECARD_AUDIT_SUMMARY        in VARCHAR2
   )
   
AS
--   v_username varchar2(100);
BEGIN

	insert into dp_scorecard.SC_AUDIT_SCORECARD
		(
		SCORECARD_AUDIT_create_USER, 
		SCORECARD_AUDIT_create_date,
		SCORECARD_AUDIT_update_USER, 
		SCORECARD_AUDIT_update_date,
		--
		SCORECARD_AUDIT_DATE,          
		AGENT_STAFF_ID,                
		ATTEND_TRKR_UPDT_ACCURATELY,   
		CORRECTIVE_ACTIONS_UP_TO_DATE, 
		PERFORMANCE_TRKR_UP_TO_DATE,   
		GOALS_UPDATED,                 
		SCORECARD_AUDIT_SUMMARY       
		)
	values
		(
		IN_SCORECARD_AUDIT_create_USER,    
		sysdate,
		IN_SCORECARD_AUDIT_create_USER,    
		sysdate,
		--
		IN_SCORECARD_AUDIT_DATE,           
		IN_AGENT_STAFF_ID,                 
		IN_ATTEND_TRKR_UPDT_ACCURATELY,    
		IN_CORRECTIVE_ACTIONS_UP_TO_DATE, 
		IN_PERFORMANCE_TRKR_UP_TO_DATE,    
		IN_GOALS_UPDATED,                  
		IN_SCORECARD_AUDIT_SUMMARY        
		);
		
    commit;

END;
/
  
GRANT EXECUTE ON DP_SCORECARD.INSERT_SC_AUDIT_SCORECARD TO MAXDAT;
GRANT EXECUTE ON DP_SCORECARD.INSERT_SC_AUDIT_SCORECARD TO MAXDAT_REPORTS;
