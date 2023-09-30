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

DROP VIEW DP_SCORECARD.SC_AUDIT_SCORECARD_SV
DROP TABLE DP_SCORECARD.SC_AUDIT_SCORECARD CASCADE CONSTRAINTS;

 
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--DROP SEQUENCE DP_SCORECARD.SEQ_SC_AUDIT_PAYROLL_ID;

CREATE SEQUENCE DP_SCORECARD.SEQ_SC_AUDIT_PAYROLL_ID
  START WITH 160
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;
  
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--DROP SEQUENCE DP_SCORECARD.SEQ_SC_AUDIT_SCORECARD_ID;

CREATE SEQUENCE DP_SCORECARD.SEQ_SC_AUDIT_SCORECARD_ID
  START WITH 120
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;

  
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

--DROP VIEW DP_SCORECARD.SC_AUDIT_SYSTEM_LKUP_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SC_AUDIT_SYSTEM_LKUP_SV
(AUDIT_SYSTEM)
AS 
select AUDIT_SYSTEM from DP_SCORECARD.SC_AUDIT_system_lkup;


GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SYSTEM_LKUP_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SYSTEM_LKUP_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SYSTEM_LKUP_SV TO MAXDAT_REPORTS;

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

INSERT INTO DP_SCORECARD.SC_AUDIT_TYPE_lkup
VALUES ('Scorecard Audit');

INSERT INTO DP_SCORECARD.SC_AUDIT_TYPE_lkup
VALUES ('Payroll Audit');

commit;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--DROP VIEW DP_SCORECARD.SC_AUDIT_TYPE_LKUP_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SC_AUDIT_TYPE_LKUP_SV
(AUDIT_TYPE)
AS 
select AUDIT_TYPE from dp_scorecard.SC_AUDIT_TYPE_lkup;


GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TYPE_LKUP_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TYPE_LKUP_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TYPE_LKUP_SV TO MAXDAT_REPORTS;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--DROP TABLE DP_SCORECARD.SC_YES_NO_LKUP CASCADE CONSTRAINTS;

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

insert into DP_SCORECARD.SC_YES_NO_lkup
values ( 'Yes');

insert into DP_SCORECARD.SC_YES_NO_lkup
values ( 'No');

commit;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--DROP VIEW DP_SCORECARD.SC_YES_NO_LKUP_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SC_YES_NO_LKUP_SV
(YES_NO_VALUE)
AS 
select "YES_NO_VALUE" from DP_SCORECARD.SC_YES_NO_lkup;


GRANT SELECT ON DP_SCORECARD.SC_YES_NO_LKUP_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SC_YES_NO_LKUP_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SC_YES_NO_LKUP_SV TO MAXDAT_REPORTS;


-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--DROP TABLE DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT CASCADE CONSTRAINTS;

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

----------------------------------------------------------------------------
----------------------------------------------------------------------------

--DROP VIEW DP_SCORECARD.SC_AUDIT_PAYROLL_AUDIT_SV;

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

----------------------------------------------------------------------------
----------------------------------------------------------------------------

--DROP VIEW DP_SCORECARD.SC_AUDIT_PAYROLL_SV;

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

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--DROP VIEW DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT_SV;

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

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--DROP TABLE DP_SCORECARD.SC_AUDIT_SCORECARD CASCADE CONSTRAINTS;

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

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--DROP VIEW DP_SCORECARD.SC_AUDIT_SCORECARD_SV;

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


-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

