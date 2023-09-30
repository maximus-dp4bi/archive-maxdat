
-- Initial UAT version -- NOT IN PRODCUTION 
-- PACKAGE IN PRODUCTION IS PP_WFM_TASK_BO_30D_SYNC_PKG
DROP PACKAGE DP_SCORECARD.PP_WFM_TASK_BO_30_DAY_SYNC_PKG;

drop table DP_SCORECARD.PP_WFM_TASK_BO_SYNC_W30
-- USED BY
-- DP_SCORECARD	PACKAGE BODY	PP_WFM_TASK_BO_30_DAY_SYNC_PKG	VALID

-- TEST TABLE
DROP TABLE DP_SCORECARD.WFL_PP_WFM_TASK_BO;

-- CORRECT  table IS dp_scorecard.PP_WFM_TASK_AUDIT_PPK_TASK_ID
drop table dp_scorecard.PP_WFM_TASK_AUDIT_PPK_TASK

-- Table is NOT USED  was part of an test version of the sync process
drop table dp_scorecard.PP_WFM_TASK_AUDIT_SC_DELETES

----------------------------------------------------------
-- Test table and procedures used for parrallel testing 
----------------------------------------------------------

DROP TABLE DP_SCORECARD.SC_SUMMARY_CC_ROLLUP_V1;
--Owner	Type	Name	Status
--DP_SCORECARD	PROCEDURE	LOAD_SC_SUMMARY_CC_ROLLUP_V1XX	INVALID
--DP_SCORECARD	PROCEDURE	LOAD_SC_SUMMARY_CC_ROLLUP_V1X	INVALID
--DP_SCORECARD	PROCEDURE	LOAD_SC_SUMMARY_CC_ROLLUP_V1	INVALID

DROP TABLE DP_SCORECARD.SC_SUMMARY_CC_V1;
--Owner	Type	Name	Status
--DP_SCORECARD	PROCEDURE	LOAD_SC_SUMMARY_CC_V1XX	INVALID
--DP_SCORECARD	PROCEDURE	LOAD_SC_SUMMARY_CC_V1X	INVALID
--DP_SCORECARD	PROCEDURE	LOAD_SC_SUMMARY_CC_V1	INVALID

DROP PROCEDURE	DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP_V1XX;

DROP PROCEDURE	DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP_V1X;	

DROP PROCEDURE	DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP_V1;	

-------------------------------
-- CORRECT INDEX NAME
-- to match PRODUCTION
-------------------------------

DROP INDEX DP_SCORECARD.SC_HIER_MGR_STAFF_ID_NDX;

CREATE INDEX SC_HIER_MANG_STAFF_ID_NDX
	ON DP_SCORECARD.SCORECARD_HIERARCHY (MANAGER_STAFF_ID)
	TABLESPACE MAXDAT_INDX;

-------------------------------
-- CORRECT TABLE SPACE NAME
-- for the following indexes
-------------------------------

drop INDEX dp_scorecard.SCA_STAFF_ID;

CREATE INDEX SCA_STAFF_ID
	ON DP_SCORECARD.SC_ATTENDANCE (STAFF_ID)
	TABLESPACE MAXDAT_INDX;
--

drop INDEX dp_scorecard.CA_STAFF_ID;	
	
CREATE INDEX CA_STAFF_ID
	ON DP_SCORECARD.SC_CORRECTIVE_ACTION (STAFF_ID)
	TABLESPACE MAXDAT_INDX;
--

drop INDEX dp_scorecard.SC_GOAL_STAFF_ID;

CREATE INDEX SC_GOAL_STAFF_ID
	ON DP_SCORECARD.SC_GOAL (STAFF_ID)
	TABLESPACE MAXDAT_INDX;	

--
	
DROP INDEX DP_SCORECARD.PT_STAFF_ID;

CREATE INDEX PT_STAFF_ID
	ON DP_SCORECARD.SC_PERFORMANCE_TRACKER (STAFF_ID)
	TABLESPACE MAXDAT_INDX;
	

------------------------------------------------------
-- table and view are not used
-- were part of an erlier CR which was cancelled
------------------------------------------------------
	
DROP VIEW DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME_SV;

DROP TABLE DP_SCORECARD.PP_WFM_SC_LOGGED_IN_TIME;

--------------------------------------------------------

---------------------------------------------
-- change on the IF DELETING 
-- remove test for  absence_type like '***%'
---------------------------------------------

CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_AIU_SC_ATTENDANCE
AFTER INSERT OR UPDATE OR DELETE ON DP_SCORECARD.SC_ATTENDANCE
for each row
BEGIN

IF UPDATING THEN

	BEGIN

    --  :old.BALANCE          		--<< don't check these
    --  :old.INCENTIVE_BALANCE   	--<< don't check these
    --  :old.TOTAL_BALANCE        	--<< don't check these

	IF    :old.SC_ATTENDANCE_ID      <> :new.SC_ATTENDANCE_ID
    or  :old.STAFF_ID              <> :new.STAFF_ID
    or  :old.ENTRY_DATE            <> :new.ENTRY_DATE
    or  :old.SC_ALL_ID             <> :new.SC_ALL_ID
    or  :old.ABSENCE_TYPE          <> :new.ABSENCE_TYPE
    or  :old.POINT_VALUE           <> :new.POINT_VALUE
    or  :old.CREATE_BY             <> :new.CREATE_BY
    or  :old.CREATE_DATETIME       <> :new.CREATE_DATETIME
    or  :old.INCENTIVE_FLAG        <> :new.INCENTIVE_FLAG
    or  :old.LAST_UPDATED_BY       <> :new.LAST_UPDATED_BY
    or  :old.LAST_UPDATED_DATETIME <> :new.LAST_UPDATED_DATETIME
	THEN
		INSERT INTO SC_ATTENDANCE_AUDIT
		(Record_type
		,Record_action
		,SC_ATTENDANCE_ID
		,STAFF_ID
		,ENTRY_DATE
		,SC_ALL_ID
		,ABSENCE_TYPE
		,POINT_VALUE
		,CREATE_BY
		,CREATE_DATETIME
		,BALANCE
		,INCENTIVE_BALANCE
		,TOTAL_BALANCE
		,INCENTIVE_FLAG
		,LAST_UPDATED_BY
		,LAST_UPDATED_DATETIME
		,TRANSACTION_DATE)
		VALUES
			('Update'
			,'Delete'
			,:old.SC_ATTENDANCE_ID
			,:old.STAFF_ID
			,:old.ENTRY_DATE
			,:old.SC_ALL_ID
			,:old.ABSENCE_TYPE
			,:old.POINT_VALUE
			,:old.CREATE_BY
			,:old.CREATE_DATETIME
			,:old.BALANCE
			,:old.INCENTIVE_BALANCE
			,:old.TOTAL_BALANCE
			,:old.INCENTIVE_FLAG
			,:old.LAST_UPDATED_BY
			,:old.LAST_UPDATED_DATETIME
			,SYSDATE);

    INSERT INTO SC_ATTENDANCE_AUDIT
      (Record_type
      ,Record_action
      ,SC_ATTENDANCE_ID
      ,STAFF_ID
      ,ENTRY_DATE
      ,SC_ALL_ID
      ,ABSENCE_TYPE
      ,POINT_VALUE
      ,CREATE_BY
      ,CREATE_DATETIME
      ,BALANCE
      ,INCENTIVE_BALANCE
      ,TOTAL_BALANCE
      ,INCENTIVE_FLAG
      ,LAST_UPDATED_BY
      ,LAST_UPDATED_DATETIME
      ,TRANSACTION_DATE)
     VALUES
      ('Update'
      ,'Insert'
      ,:new.SC_ATTENDANCE_ID
      ,:new.STAFF_ID
      ,:new.ENTRY_DATE
      ,:new.SC_ALL_ID
      ,:new.ABSENCE_TYPE
      ,:new.POINT_VALUE
      ,:new.CREATE_BY
      ,:new.CREATE_DATETIME
      ,:new.BALANCE
      ,:new.INCENTIVE_BALANCE
      ,:new.TOTAL_BALANCE
      ,:new.INCENTIVE_FLAG
      ,:new.LAST_UPDATED_BY
      ,:new.LAST_UPDATED_DATETIME,
      SYSDATE);

	END IF;

	END;

END IF;

IF INSERTING THEN
    INSERT INTO SC_ATTENDANCE_AUDIT
      (Record_type
      ,Record_action
      ,SC_ATTENDANCE_ID
      ,STAFF_ID
      ,ENTRY_DATE
      ,SC_ALL_ID
      ,ABSENCE_TYPE
      ,POINT_VALUE
      ,CREATE_BY
      ,CREATE_DATETIME
      ,BALANCE
      ,INCENTIVE_BALANCE
      ,TOTAL_BALANCE
      ,INCENTIVE_FLAG
      ,LAST_UPDATED_BY
      ,LAST_UPDATED_DATETIME
      ,TRANSACTION_DATE)
     VALUES
      ('Insert'
      ,'Insert'
      ,:new.SC_ATTENDANCE_ID
      ,:new.STAFF_ID
      ,:new.ENTRY_DATE
      ,:new.SC_ALL_ID
      ,:new.ABSENCE_TYPE
      ,:new.POINT_VALUE
      ,:new.CREATE_BY
      ,:new.CREATE_DATETIME
      ,:new.BALANCE
      ,:new.INCENTIVE_BALANCE
      ,:new.TOTAL_BALANCE
      ,:new.INCENTIVE_FLAG
      ,:new.LAST_UPDATED_BY
      ,:new.LAST_UPDATED_DATETIME
      ,SYSDATE);

END IF;

IF DELETING THEN
        INSERT INTO SC_ATTENDANCE_AUDIT
        (Record_type
        ,Record_action
        ,SC_ATTENDANCE_ID
        ,STAFF_ID
        ,ENTRY_DATE
        ,SC_ALL_ID
        ,ABSENCE_TYPE
        ,POINT_VALUE
        ,CREATE_BY
        ,CREATE_DATETIME
        ,BALANCE
        ,INCENTIVE_BALANCE
        ,TOTAL_BALANCE
        ,INCENTIVE_FLAG
        ,LAST_UPDATED_BY
        ,LAST_UPDATED_DATETIME
        ,TRANSACTION_DATE)
        VALUES
            ('Delete'
            ,'Delete'
            ,:old.SC_ATTENDANCE_ID
            ,:old.STAFF_ID
            ,:old.ENTRY_DATE
            ,:old.SC_ALL_ID
            ,:old.ABSENCE_TYPE
            ,:old.POINT_VALUE
            ,:old.CREATE_BY
            ,:old.CREATE_DATETIME
            ,:old.BALANCE
            ,:old.INCENTIVE_BALANCE
            ,:old.TOTAL_BALANCE
            ,:old.INCENTIVE_FLAG
            ,:old.LAST_UPDATED_BY
            ,:old.LAST_UPDATED_DATETIME,
            SYSDATE);
    END IF;

END;


---------------------------------------------------------
-- Only change is adding the schema name
---------------------------------------------------------

CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_AIU_SC_AUDIT_TEAM_LEAD_QLT
AFTER INSERT OR UPDATE OR DELETE ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUALITY
for each row
BEGIN

IF UPDATING THEN

	BEGIN

	IF :old.DATES_MONTH_NUM				<>	:new.DATES_MONTH_NUM
	OR :old.Team_lead_Quality_Create_Date		<>	:new.Team_lead_Quality_Create_Date
	OR :old.Team_lead_Quality_Create_USER		<>	:new.Team_lead_Quality_Create_USER
	OR :old.Team_lead_Quality_Update_Date		<>	:new.Team_lead_Quality_Update_Date
	OR :old.Team_lead_Quality_Update_USER		<>	:new.Team_lead_Quality_Update_USER
	OR :old.Team_lead_Agent_STAFF_ID			<>	:new.Team_lead_Agent_STAFF_ID
	--
	OR :OLD.Review_Sessions_COMPLTD_Rating	<> :NEW.Review_Sessions_COMPLTD_Rating
	OR :OLD.Review_Sessions_COMPLTD_Points	<> :NEW.Review_Sessions_COMPLTD_Points
	OR :OLD.Live_Obsrv_COMPLTD_rating			<> :NEW.Live_Obsrv_COMPLTD_rating
	OR :OLD.Live_Obsrv_COMPLTD_points			<> :NEW.Live_Obsrv_COMPLTD_points
	OR :OLD.QPP_Checklist_COMPLTD_rating 		<> :NEW.QPP_Checklist_COMPLTD_rating
	OR :OLD.QPP_Checklist_COMPLTD_points		<> :NEW.QPP_Checklist_COMPLTD_points
	OR :OLD.QPP_Quality_Score_1_rating 			<> :NEW.QPP_Quality_Score_1_rating
	OR :OLD.QPP_Quality_Score_1_points 			<> :NEW.QPP_Quality_Score_1_points
	OR :OLD.QPP_Quality_Score_2_rating			<> :NEW.QPP_Quality_Score_2_rating
	OR :OLD.QPP_Quality_Score_2_points			<> :NEW.QPP_Quality_Score_2_points
	--
	THEN
		INSERT INTO SC_AUDIT_TEAM_LEAD_QUALITY_AUD
		(Record_type,
		Record_action,
		Transaction_Date,
		Team_lead_Quality_ID,
		DATES_MONTH_NUM,
		Team_lead_Quality_Create_Date,
		Team_lead_Quality_Create_USER,
		Team_lead_Quality_Update_Date,
		Team_lead_Quality_Update_USER,
		Team_lead_agent_STAFF_ID,
		--
		Review_Sessions_COMPLTD_Rating,
		Review_Sessions_COMPLTD_Points,
		Live_Obsrv_COMPLTD_rating,
		Live_Obsrv_COMPLTD_points,
		QPP_Checklist_COMPLTD_rating,
		QPP_Checklist_COMPLTD_points,
		QPP_Quality_Score_1_rating,
		QPP_Quality_Score_1_points,
		QPP_Quality_Score_2_rating,
		QPP_Quality_Score_2_points
		--
		)
		VALUES
			('Update',
			'Delete',
			sysdate,
			:OLD.Team_lead_Quality_ID,
		:old.DATES_MONTH_NUM,
		:old.Team_lead_Quality_Create_Date,
		:old.Team_lead_Quality_Create_USER,
		:old.Team_lead_Quality_Update_Date,
		:old.Team_lead_Quality_Update_USER,
		:old.Team_lead_Agent_STAFF_ID,
		--
		:OLD.Review_Sessions_COMPLTD_Rating,
		:OLD.Review_Sessions_COMPLTD_Points,
		:OLD.Live_Obsrv_COMPLTD_rating,
		:OLD.Live_Obsrv_COMPLTD_points,
		:OLD.QPP_Checklist_COMPLTD_rating,
		:OLD.QPP_Checklist_COMPLTD_points,
		:OLD.QPP_Quality_Score_1_rating,
		:OLD.QPP_Quality_Score_1_points,
		:OLD.QPP_Quality_Score_2_rating,
		:OLD.QPP_Quality_Score_2_points
		--
		);

    INSERT INTO SC_AUDIT_TEAM_LEAD_QUALITY_AUD
      (Record_type,
      Record_action,
	  Transaction_Date,
	  Team_lead_Quality_ID,
		DATES_MONTH_NUM,
		Team_lead_Quality_Create_Date,
		Team_lead_Quality_Create_USER,
		Team_lead_Quality_Update_Date,
		Team_lead_Quality_Update_USER,
		Team_lead_agent_STAFF_ID,
		--
		Review_Sessions_COMPLTD_Rating,
		Review_Sessions_COMPLTD_Points,
		Live_Obsrv_COMPLTD_rating,
		Live_Obsrv_COMPLTD_points,
		QPP_Checklist_COMPLTD_rating,
		QPP_Checklist_COMPLTD_points,
		QPP_Quality_Score_1_rating,
		QPP_Quality_Score_1_points,
		QPP_Quality_Score_2_rating,
		QPP_Quality_Score_2_points
		--
		)
     VALUES
      ('Update',
      'Insert',
	  sysdate,
	  :NEW.Team_lead_Quality_ID,
		:new.DATES_MONTH_NUM,
		:new.Team_lead_Quality_Create_Date,
		:new.Team_lead_Quality_Create_USER,
		:new.Team_lead_Quality_Update_Date,
		:new.Team_lead_Quality_Update_USER,
		:new.Team_lead_agent_STAFF_ID,
		--
		:NEW.Review_Sessions_COMPLTD_Rating,
		:NEW.Review_Sessions_COMPLTD_Points,
		:NEW.Live_Obsrv_COMPLTD_rating,
		:NEW.Live_Obsrv_COMPLTD_points,
		:NEW.QPP_Checklist_COMPLTD_rating,
		:NEW.QPP_Checklist_COMPLTD_points,
		:NEW.QPP_Quality_Score_1_rating,
		:NEW.QPP_Quality_Score_1_points,
		:NEW.QPP_Quality_Score_2_rating,
		:NEW.QPP_Quality_Score_2_points
		--
      );

	END IF;

	END;

END IF;

IF INSERTING THEN
    INSERT INTO SC_AUDIT_TEAM_LEAD_QUALITY_AUD
      (Record_type,
		Record_action,
		Transaction_Date,
		Team_lead_Quality_ID,
		DATES_MONTH_NUM,
		Team_lead_Quality_Create_Date,
		Team_lead_Quality_Create_USER,
		Team_lead_Quality_Update_Date,
		Team_lead_Quality_Update_USER,
		Team_lead_Agent_STAFF_ID,
		--
		Review_Sessions_COMPLTD_Rating,
		Review_Sessions_COMPLTD_Points,
		Live_Obsrv_COMPLTD_rating,
		Live_Obsrv_COMPLTD_points,
		QPP_Checklist_COMPLTD_rating,
		QPP_Checklist_COMPLTD_points,
		QPP_Quality_Score_1_rating,
		QPP_Quality_Score_1_points,
		QPP_Quality_Score_2_rating,
		QPP_Quality_Score_2_points
		--
		)
     VALUES
      ('Insert',
      'Insert',
	  sysdate,
	  :NEW.Team_lead_Quality_ID,
		:new.DATES_MONTH_NUM,
		:new.Team_lead_Quality_Create_Date,
		:new.Team_lead_Quality_Create_USER,
		:new.Team_lead_Quality_Update_Date,
		:new.Team_lead_Quality_Update_USER,
		:new.Team_lead_Agent_STAFF_ID,
		--
		:NEW.Review_Sessions_COMPLTD_Rating,
		:NEW.Review_Sessions_COMPLTD_Points,
		:NEW.Live_Obsrv_COMPLTD_rating,
		:NEW.Live_Obsrv_COMPLTD_points,
		:NEW.QPP_Checklist_COMPLTD_rating,
		:NEW.QPP_Checklist_COMPLTD_points,
		:NEW.QPP_Quality_Score_1_rating,
		:NEW.QPP_Quality_Score_1_points,
		:NEW.QPP_Quality_Score_2_rating,
		:NEW.QPP_Quality_Score_2_points
		--
		);

END IF;

IF DELETING THEN
        INSERT INTO SC_AUDIT_TEAM_LEAD_QUALITY_AUD
        (Record_type,
        Record_action,
		Transaction_Date,
		Team_lead_Quality_ID,
		DATES_MONTH_NUM,
		Team_lead_Quality_Create_Date,
		Team_lead_Quality_Create_USER,
		Team_lead_Quality_Update_Date,
		Team_lead_Quality_Update_USER,
		Team_lead_Agent_STAFF_ID,
--
		Review_Sessions_COMPLTD_Rating,
		Review_Sessions_COMPLTD_Points,
		Live_Obsrv_COMPLTD_rating,
		Live_Obsrv_COMPLTD_points,
		QPP_Checklist_COMPLTD_rating,
		QPP_Checklist_COMPLTD_points,
		QPP_Quality_Score_1_rating,
		QPP_Quality_Score_1_points,
		QPP_Quality_Score_2_rating,
		QPP_Quality_Score_2_points
--
		)
        VALUES
            ('Delete',
            'Delete',
			sysdate,
			:OLD.Team_lead_Quality_ID,
		:old.DATES_MONTH_NUM,
		:old.Team_lead_Quality_Create_Date,
		:old.Team_lead_Quality_Create_USER,
		:old.Team_lead_Quality_Update_Date,
		:old.Team_lead_Quality_Update_USER,
		:old.Team_lead_Agent_STAFF_ID,
		--
		:OLD.Review_Sessions_COMPLTD_Rating,
		:OLD.Review_Sessions_COMPLTD_Points,
		:OLD.Live_Obsrv_COMPLTD_rating,
		:OLD.Live_Obsrv_COMPLTD_points,
		:OLD.QPP_Checklist_COMPLTD_rating,
		:OLD.QPP_Checklist_COMPLTD_points,
		:OLD.QPP_Quality_Score_1_rating,
		:OLD.QPP_Quality_Score_1_points,
		:OLD.QPP_Quality_Score_2_rating,
		:OLD.QPP_Quality_Score_2_points
		--
		);
    END IF;

END;

------------------------------------------------
-- Only change is adding the schema name
------------------------------------------------

CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_AIU_SC_AUDIT_TEAM_LEAD_QZ
AFTER INSERT OR UPDATE OR DELETE ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUIZ
for each row
BEGIN

IF UPDATING THEN

	BEGIN

	IF :old.Team_lead_QUIZ_Create_Date		<>	:new.Team_lead_QUIZ_Create_Date
	OR :old.Team_lead_QUIZ_Create_USER		<>	:new.Team_lead_QUIZ_Create_USER
	OR :old.Team_lead_QUIZ_Update_Date		<>	:new.Team_lead_QUIZ_Update_Date
	OR :old.Team_lead_QUIZ_Update_USER		<>	:new.Team_lead_QUIZ_Update_USER
	OR :old.Team_lead_Agent_STAFF_ID		<>	:new.Team_lead_Agent_STAFF_ID
	--
	OR :old.CBT_EXAM_NAME					<>	:NEW.CBT_EXAM_NAME
	OR :old.CBT_EXAM_ASSIGNMENT_DATE		<>  :NEW.CBT_EXAM_ASSIGNMENT_DATE
	OR :old.CBT_EXAM_COMPLETION_DATE		<>  :NEW.CBT_EXAM_COMPLETION_DATE
	OR :old.CBT_EXAM_SCORE					<>  :NEW.CBT_EXAM_SCORE
	OR :old.CBT_EXAM_TIMELINESS				<>  :NEW.CBT_EXAM_TIMELINESS
	--
	THEN
		INSERT INTO SC_AUDIT_TEAM_LEAD_QUIZ_AUD
		(Record_type,
		Record_action,
		Transaction_Date,
		Team_lead_QUIZ_ID,
		Team_lead_QUIZ_Create_Date,
		Team_lead_QUIZ_Create_USER,
		Team_lead_QUIZ_Update_Date,
		Team_lead_QUIZ_Update_USER,
		Team_lead_agent_STAFF_ID,
		--
		CBT_EXAM_NAME,
		CBT_EXAM_ASSIGNMENT_DATE,
		CBT_EXAM_COMPLETION_DATE,
		CBT_EXAM_SCORE,
		CBT_EXAM_TIMELINESS
		--
		)
		VALUES
			('Update',
			'Delete',
			sysdate,
			:OLD.Team_lead_QUIZ_ID,
		:old.Team_lead_QUIZ_Create_Date,
		:old.Team_lead_QUIZ_Create_USER,
		:old.Team_lead_QUIZ_Update_Date,
		:old.Team_lead_QUIZ_Update_USER,
		:old.Team_lead_Agent_STAFF_ID,
		--
		:old.CBT_EXAM_NAME,
		:old.CBT_EXAM_ASSIGNMENT_DATE,
		:old.CBT_EXAM_COMPLETION_DATE,
		:old.CBT_EXAM_SCORE,
		:old.CBT_EXAM_TIMELINESS
		--
		);

    INSERT INTO SC_AUDIT_TEAM_LEAD_QUIZ_AUD
      (Record_type,
      Record_action,
	  Transaction_Date,
	  Team_lead_QUIZ_ID,
		Team_lead_QUIZ_Create_Date,
		Team_lead_QUIZ_Create_USER,
		Team_lead_QUIZ_Update_Date,
		Team_lead_QUIZ_Update_USER,
		Team_lead_agent_STAFF_ID,
		--
		CBT_EXAM_NAME,
		CBT_EXAM_ASSIGNMENT_DATE,
		CBT_EXAM_COMPLETION_DATE,
		CBT_EXAM_SCORE,
		CBT_EXAM_TIMELINESS
		--
		)
     VALUES
      ('Update',
      'Insert',
	  sysdate,
	  :NEW.Team_lead_QUIZ_ID,
		:new.Team_lead_QUIZ_Create_Date,
		:new.Team_lead_QUIZ_Create_USER,
		:new.Team_lead_QUIZ_Update_Date,
		:new.Team_lead_QUIZ_Update_USER,
		:new.Team_lead_agent_STAFF_ID,
		--
		:NEW.CBT_EXAM_NAME,
		:NEW.CBT_EXAM_ASSIGNMENT_DATE,
		:NEW.CBT_EXAM_COMPLETION_DATE,
		:NEW.CBT_EXAM_SCORE,
		:NEW.CBT_EXAM_TIMELINESS
		--
      );

	END IF;

	END;

END IF;

IF INSERTING THEN
    INSERT INTO SC_AUDIT_TEAM_LEAD_QUIZ_AUD
      (Record_type,
		Record_action,
		Transaction_Date,
		Team_lead_QUIZ_ID,
		Team_lead_QUIZ_Create_Date,
		Team_lead_QUIZ_Create_USER,
		Team_lead_QUIZ_Update_Date,
		Team_lead_QUIZ_Update_USER,
		Team_lead_Agent_STAFF_ID,
		--
		CBT_EXAM_NAME,
		CBT_EXAM_ASSIGNMENT_DATE,
		CBT_EXAM_COMPLETION_DATE,
		CBT_EXAM_SCORE,
		CBT_EXAM_TIMELINESS
		--
		)
     VALUES
      ('Insert',
      'Insert',
	  sysdate,
	  :NEW.Team_lead_QUIZ_ID,
		:new.Team_lead_QUIZ_Create_Date,
		:new.Team_lead_QUIZ_Create_USER,
		:new.Team_lead_QUIZ_Update_Date,
		:new.Team_lead_QUIZ_Update_USER,
		:new.Team_lead_Agent_STAFF_ID,
		--
		:NEW.CBT_EXAM_NAME,
		:NEW.CBT_EXAM_ASSIGNMENT_DATE,
		:NEW.CBT_EXAM_COMPLETION_DATE,
		:NEW.CBT_EXAM_SCORE,
		:NEW.CBT_EXAM_TIMELINESS
		--
		);

END IF;

IF DELETING THEN
        INSERT INTO SC_AUDIT_TEAM_LEAD_QUIZ_AUD
        (Record_type,
        Record_action,
		Transaction_Date,
		Team_lead_QUIZ_ID,
		Team_lead_QUIZ_Create_Date,
		Team_lead_QUIZ_Create_USER,
		Team_lead_QUIZ_Update_Date,
		Team_lead_QUIZ_Update_USER,
		Team_lead_Agent_STAFF_ID,
		CBT_EXAM_NAME,
		CBT_EXAM_ASSIGNMENT_DATE,
		CBT_EXAM_COMPLETION_DATE,
		CBT_EXAM_SCORE,
		CBT_EXAM_TIMELINESS
		)
        VALUES
            ('Delete',
            'Delete',
			sysdate,
			:OLD.Team_lead_QUIZ_ID,
		:old.Team_lead_QUIZ_Create_Date,
		:old.Team_lead_QUIZ_Create_USER,
		:old.Team_lead_QUIZ_Update_Date,
		:old.Team_lead_QUIZ_Update_USER,
		:old.Team_lead_Agent_STAFF_ID,
		--
		:OLD.CBT_EXAM_NAME,
		:OLD.CBT_EXAM_ASSIGNMENT_DATE,
		:OLD.CBT_EXAM_COMPLETION_DATE,
		:OLD.CBT_EXAM_SCORE,
		:OLD.CBT_EXAM_TIMELINESS
		--
		);
    END IF;

END;

------------------------------------------------
-- only change is adding schema name
------------------------------------------------

CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_BIU_SC_AUDIT_TEAM_LEAD_QLT
BEFORE INSERT OR UPDATE ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUALITY
FOR EACH ROW
BEGIN
 :new.Team_lead_Quality_Update_Date := sysdate;

 IF :new.Team_lead_Quality_Update_USER IS NULL
	THEN :new.Team_lead_Quality_Update_USER := USER;
 END IF;

 IF INSERTING THEN
	:new.Team_lead_Quality_ID			:= DP_SCORECARD.SEQ_SC_AUDIT_TEAM_LEAD_QUALITY.nextval;
    :new.Team_lead_Quality_Create_Date := sysdate;
    :new.Team_lead_Quality_Create_USER := NVL( :new.Team_lead_Quality_Create_USER, user);
	:NEW.Team_lead_Quality_Update_Date := sysdate;
    :new.Team_lead_Quality_Update_USER := NVL( :new.Team_lead_Quality_Create_USER, user);
  END IF;

end;

------------------------------------------------
-- only change is adding schema name
------------------------------------------------

CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_BIU_SC_AUDIT_TEAM_LEAD_QZ
BEFORE INSERT OR UPDATE ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUIZ
FOR EACH ROW
BEGIN
 :new.Team_lead_QUIZ_Update_Date := sysdate;

 IF :new.Team_lead_QUIZ_Update_USER IS NULL
	THEN :new.Team_lead_QUIZ_Update_USER := USER;
 END IF;

 IF INSERTING THEN
	:new.Team_lead_QUIZ_ID			:= DP_SCORECARD.SEQ_SC_AUDIT_TEAM_LEAD_QUIZ.nextval;
    :new.Team_lead_QUIZ_Create_Date := sysdate;
    :new.Team_lead_QUIZ_Create_USER := NVL( :new.Team_lead_QUIZ_Create_USER, user);
    :new.Team_lead_QUIZ_Update_Date := sysdate;
    :new.Team_lead_QUIZ_Update_USER := NVL( :new.Team_lead_QUIZ_Create_USER, user);
  END IF;

end;

---------------------------------------------------------------
-- Add trigger to UAT trigger is IN PRODUCTION BUT not in UAT 
---------------------------------------------------------------

CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_BIU_WEBCHAT_ACTUALS
BEFORE INSERT OR UPDATE ON DP_SCORECARD.WEBCHAT_ACTUALS
FOR EACH ROW

BEGIN
  IF INSERTING THEN
    :new.create_datetime := sysdate;
  else
    :new.last_update_date := sysdate;
 END IF;

end;

-- *************************************************************
-- *************************************************************
-- *************************************************************

-- moving the ";" to the end of the last line

CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV
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
            on ca.staff_id=sh.SEARCH_staff_id;

-- DROP TEST VIEW
DROP VIEW DP_SCORECARD.SCORECARD_QUALITY_MTHLY_RUSVXX;

--- After evaluating this view IN UAT VERSUS PRODUCTION
--  The view in DEV and UAT seem incorrect.

-- CREATE OR REPLACE VIEW  -- UAT Version  
-- DP_SCORECARD.SCORECARD_QUALITY_TL_MTHLY_SV
-- AS
-- select staff_staff_id,
--        staff_staff_name,
--        staff_natid,
--        dates_month_num,
--        dates_year,
--        audits as qcs_performed
--   from dp_scorecard.scorecard_quality_mthly_sv
-- ;

CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_QUALITY_TL_MTHLY_SV
AS
With just_months as
(
      SELECT
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'MM/DD/YYYY') as dates,
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'Month') as dates_month,
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'YYYYMM') as dates_month_num,
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'Month YYYY') as dates_year,
      0  as qcs_performed
    FROM Dual
    CONNECT BY Level <= MONTHS_BETWEEN(trunc(SYSDATE), TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM')) + 1
),
quality_by_month as
(
SELECT staff_staff_id,
       staff_staff_name,
       staff_natid,
       to_char(TRUNC(EVAL_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(EVAL_DATE), 'Month YYYY') as dates_year,
       count(*) over (partition by staff_staff_id ,to_char(TRUNC(EVAL_DATE), 'YYYYMM')) as qcs_performed
  from dp_scorecard.scorecard_quality_tl_sv
),
combined as
(
  select r.staff_staff_id,
         r.staff_staff_name,
         r.staff_natid,
         r.dates_month_num,
         r.dates_year,
         r.qcs_performed
         from quality_by_month r
  union
  select r.staff_staff_id,
         r.staff_staff_name,
         r.staff_natid,
         jm.dates_month_num,
         jm.dates_year,
         jm.qcs_performed
       from quality_by_month r, just_months jm
),
ranked as
(
select staff_staff_id,
         staff_staff_name,
         staff_natid,
         dates_month_num,
         dates_year,
         qcs_performed,
         rank() over(partition by staff_staff_id, dates_month_num order by qcs_performed desc) as rnk
         from combined order by staff_staff_id, dates_month_num
)
select staff_staff_id,
         staff_staff_name,
         staff_natid,
         dates_month_num,
         dates_year,
         qcs_performed
         from ranked where rnk=1
;
