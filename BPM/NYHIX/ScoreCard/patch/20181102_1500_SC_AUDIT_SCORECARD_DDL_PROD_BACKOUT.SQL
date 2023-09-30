-- ********************************************************************************
-- ********************************************************************************
-- These are the undo scripts
-- ********************************************************************************
-- ********************************************************************************

------------------------------------------------------------------
-- DROP THE CURRENT TRIGGERS FOR SC_AUDIT_SCORECARD 
------------------------------------------------------------------

--ALTER TABLE SC_AUDIT_SCORECARD 
DROP TRIGGER DP_SCORECARD.TRG_AIU_SC_AUDIT_SCORECARD; 

--- ALTER TABLE SC_AUDIT_SCORECARD 
DROP TRIGGER DP_SCORECARD.TRG_BIU_SC_AUDIT_SCORECARD;

------------------------------------------------------------------
-- DROP THE new column from the tables and views
------------------------------------------------------------------

alter table DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT
drop column SUPERVISOR_STAFF_ID;

alter table DP_SCORECARD.SC_AUDIT_SCORECARD
drop column SUPERVISOR_STAFF_ID;

--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- truncate the table and refresh from backup
--------------------------------------------------------------------------
--------------------------------------------------------------------------

TRUNCATE TABLE DP_SCORECARD.SC_AUDIT_SCORECARD;

TRUNCATE TABLE DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT;

--------------------------------------------------------------------------

INSERT INTO DP_SCORECARD.SC_AUDIT_SCORECARD
SELECT * FROM DP_SCORECARD.SC_AUDIT_SCORECARD_20181102_BAK;

COMMIT;

INSERT INTO DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT
SELECT * FROM DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT_20181102_BAK; 

COMMIT; 

------------------------------------------------------------------
-- recreate the views
------------------------------------------------------------------

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


GRANT INSERT, SELECT, UPDATE ON DP_SCORECARD.SC_AUDIT_SCORECARD_SV TO DP_SCORECARD_OLTP_SIU;

GRANT DELETE, INSERT, SELECT, UPDATE ON DP_SCORECARD.SC_AUDIT_SCORECARD_SV TO DP_SCORECARD_OLTP_SIUD;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SCORECARD_SV TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SCORECARD_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SCORECARD_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SCORECARD_SV TO MAXDAT_REPORTS;

------------------------------------------------------------------
------------------------------------------------------------------

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


GRANT INSERT, SELECT, UPDATE ON DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT_SV TO DP_SCORECARD_OLTP_SIU;

GRANT DELETE, INSERT, SELECT, UPDATE ON DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT_SV TO DP_SCORECARD_OLTP_SIUD;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT_SV TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT_SV TO MAXDAT_REPORTS;

------------------------------------------------------------------
------------------------------------------------------------------

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

----------------------------------------------------------------------
----------------------------------------------------------------------

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

----------------------------------------------------------------------
-- recrreate the procedures
----------------------------------------------------------------------

CREATE OR REPLACE Procedure DP_SCORECARD.INSERT_SC_AUDIT_SCORECARD
   (
  IN_SCORECARD_AUDIT_create_USER    in VARCHAR2,
  IN_SCORECARD_AUDIT_DATE           in DATE,
  IN_AGENT_STAFF_ID                 in NUMBER,
  IN_ATTEND_TRKR_UPDT_ACCURATELY    in VARCHAR2,
  IN_CORRECTIVE_ACTIONS_UP_TO_DT  in VARCHAR2,
  IN_PERFORMANCE_TRKR_UP_TO_DATE    in VARCHAR2,
  IN_GOALS_UPDATED                  in VARCHAR2,
  IN_SCORECARD_AUDIT_SUMMARY        in VARCHAR2
   )

AS
--   v_username varchar2(100);
BEGIN

	if Trunc(IN_SCORECARD_AUDIT_DATE) > trunc(sysdate)
	then
		null;
	else
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
		IN_CORRECTIVE_ACTIONS_UP_TO_DT,
		IN_PERFORMANCE_TRKR_UP_TO_DATE,
		IN_GOALS_UPDATED,
		IN_SCORECARD_AUDIT_SUMMARY
		);

	end if;

    commit;

END;
/

-------------------------------------------------------------------
-------------------------------------------------------------------

CREATE OR REPLACE Procedure DP_SCORECARD.Update_SC_AUDIT_SCORECARD
   (
  IN_DELETE_FLAG					in  NUMBER,
  IN_SCORECARD_AUDIT_ID             in NUMBER,
  IN_SCORECARD_AUDIT_UPDATE_USER    in VARCHAR2,
  IN_SCORECARD_AUDIT_DATE           in DATE,
  IN_AGENT_STAFF_ID                 in NUMBER,
  IN_ATTEND_TRKR_UPDT_ACCURATELY    in VARCHAR2,
  IN_CORRECTIVE_ACTIONS_UP_TO_DT  in VARCHAR2,
  IN_PERFORMANCE_TRKR_UP_TO_DATE    in VARCHAR2,
  IN_GOALS_UPDATED                  in VARCHAR2,
  IN_SCORECARD_AUDIT_SUMMARY        in VARCHAR2
   )


AS
 --  v_username varchar2(100);
BEGIN

	if IN_SCORECARD_AUDIT_ID IS NULL
	or Trunc(IN_SCORECARD_AUDIT_DATE) > trunc(sysdate)
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
		  CORRECTIVE_ACTIONS_UP_TO_DATE  = IN_CORRECTIVE_ACTIONS_UP_TO_DT,
		  PERFORMANCE_TRKR_UP_TO_DATE    = IN_PERFORMANCE_TRKR_UP_TO_DATE,
		  GOALS_UPDATED                  = IN_GOALS_UPDATED,
		  SCORECARD_AUDIT_SUMMARY        = IN_SCORECARD_AUDIT_SUMMARY
        where SCORECARD_AUDIT_ID = IN_SCORECARD_AUDIT_ID;

       commit;

   end if;

END;
/


