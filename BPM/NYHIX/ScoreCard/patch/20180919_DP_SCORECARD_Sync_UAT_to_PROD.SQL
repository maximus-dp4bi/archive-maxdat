CREATE or replace TRIGGER DP_SCORECARD.TRG_AIU_SC_AUDIT_TEAM_LEAD_QLT
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
/

show errors

CREATE or replace TRIGGER DP_SCORECARD.TRG_AIU_SC_AUDIT_TEAM_LEAD_QZ
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
/

show errors

CREATE or replace TRIGGER DP_SCORECARD.TRG_AIU_SC_CORRECTIVE_ACTION
AFTER INSERT OR UPDATE OR DELETE ON SC_CORRECTIVE_ACTION
for each row
BEGIN
IF UPDATING THEN
  begin
    INSERT INTO SC_CORRECTIVE_ACTION_AUDIT
     (   Record_type
       , Record_action
       , CA_ID
       , STAFF_ID
       , CA_ENTRY_DATE
       , CAL_ID
       , UNSATISFACTORY_BEHAVIOR
       , COMMENTS
       , CREATE_BY
       , CREATE_DATETIME
       , LAST_UPDATED_BY
       , LAST_UPDATED_DATETIME
     )
     VALUES
      ('Update'
      ,'Delete'
      ,:old.CA_ID
      ,:old.STAFF_ID
      ,:old.CA_ENTRY_DATE
      ,:old.CAL_ID
      ,:old.UNSATISFACTORY_BEHAVIOR
      ,:old.COMMENTS
      ,:old.CREATE_BY
      ,:old.CREATE_DATETIME
      ,:old.LAST_UPDATED_BY
      ,:old.LAST_UPDATED_DATETIME
     );

    INSERT INTO SC_CORRECTIVE_ACTION_AUDIT
     (   Record_type
       , Record_action
       , CA_ID
       , STAFF_ID
       , CA_ENTRY_DATE
       , CAL_ID
       , UNSATISFACTORY_BEHAVIOR
       , COMMENTS
       , CREATE_BY
       , CREATE_DATETIME
       , LAST_UPDATED_BY
       , LAST_UPDATED_DATETIME
    )
     VALUES
      ('Update'
      ,'Insert'
      ,:new.CA_ID
      ,:new.STAFF_ID
      ,:new.CA_ENTRY_DATE
      ,:new.CAL_ID
      ,:new.UNSATISFACTORY_BEHAVIOR
      ,:new.COMMENTS
      ,:new.CREATE_BY
      ,:new.CREATE_DATETIME
      ,:new.LAST_UPDATED_BY
      ,:new.LAST_UPDATED_DATETIME
     );
  END;
END IF;
IF INSERTING THEN
    INSERT INTO SC_CORRECTIVE_ACTION_AUDIT
      (Record_type
      ,Record_action
       , CA_ID
       , STAFF_ID
       , CA_ENTRY_DATE
       , CAL_ID
       , UNSATISFACTORY_BEHAVIOR
       , COMMENTS
       , CREATE_BY
       , CREATE_DATETIME
       , LAST_UPDATED_BY
       , LAST_UPDATED_DATETIME
    )
     VALUES
      ('Insert'
      ,'Insert'
      ,:new.CA_ID
      ,:new.STAFF_ID
      ,:new.CA_ENTRY_DATE
      ,:new.CAL_ID
      ,:new.UNSATISFACTORY_BEHAVIOR
      ,:new.COMMENTS
      ,:new.CREATE_BY
      ,:new.CREATE_DATETIME
      ,:new.LAST_UPDATED_BY
      ,:new.LAST_UPDATED_DATETIME
     );
END IF;
IF DELETING THEN
    INSERT INTO SC_CORRECTIVE_ACTION_AUDIT
     (   Record_type
       , Record_action
       , CA_ID
       , STAFF_ID
       , CA_ENTRY_DATE
       , CAL_ID
       , UNSATISFACTORY_BEHAVIOR
       , COMMENTS
       , CREATE_BY
       , CREATE_DATETIME
       , LAST_UPDATED_BY
       , LAST_UPDATED_DATETIME
     )
     VALUES
      ('Delete'
      ,'Delete'
      ,:old.CA_ID
      ,:old.STAFF_ID
      ,:old.CA_ENTRY_DATE
      ,:old.CAL_ID
      ,:old.UNSATISFACTORY_BEHAVIOR
      ,:old.COMMENTS
      ,:old.CREATE_BY
      ,:old.CREATE_DATETIME
      ,:old.LAST_UPDATED_BY
      ,:old.LAST_UPDATED_DATETIME
     );
END IF;

END;
/

show errors

CREATE or replace TRIGGER DP_SCORECARD.TRG_AIU_SC_GOAL
AFTER INSERT OR UPDATE OR DELETE ON SC_GOAL
for each row
BEGIN
IF UPDATING THEN
  begin
    INSERT INTO SC_GOAL_AUDIT
    ( Record_type
    , Record_action
    , GOAL_ID
    , STAFF_ID
    , GOAL_ENTRY_DATE
    , GTL_ID
    , GOAL_DESCRIPTION
    , GOAL_DATE
    , PROGRESS_NOTE
    , CREATE_BY
    , CREATE_DATETIME
    , LAST_UPDATED_BY
    , LAST_UPDATED_DATETIME
    )
     VALUES
      ('Update'
      ,'Delete'
      ,:old.GOAL_ID
      ,:old.STAFF_ID
      ,:old.GOAL_ENTRY_DATE
      ,:old.GTL_ID
      ,:old.GOAL_DESCRIPTION
      ,:old.GOAL_DATE
      ,:old.PROGRESS_NOTE
      ,:old.CREATE_BY
      ,:old.CREATE_DATETIME
      ,:old.LAST_UPDATED_BY
      ,:old.LAST_UPDATED_DATETIME
     );

    INSERT INTO SC_GOAL_AUDIT
    ( Record_type
    , Record_action
    , GOAL_ID
    , STAFF_ID
    , GOAL_ENTRY_DATE
    , GTL_ID
    , GOAL_DESCRIPTION
    , GOAL_DATE
    , PROGRESS_NOTE
    , CREATE_BY
    , CREATE_DATETIME
    , LAST_UPDATED_BY
    , LAST_UPDATED_DATETIME
    )
     VALUES
      ('Update'
      ,'Insert'
      ,:new.GOAL_ID
      ,:new.STAFF_ID
      ,:new.GOAL_ENTRY_DATE
      ,:new.GTL_ID
      ,:new.GOAL_DESCRIPTION
      ,:new.GOAL_DATE
      ,:new.PROGRESS_NOTE
      ,:new.CREATE_BY
      ,:new.CREATE_DATETIME
      ,:new.LAST_UPDATED_BY
      ,:new.LAST_UPDATED_DATETIME
     );
  END;
END IF;
IF INSERTING THEN
    INSERT INTO SC_GOAL_AUDIT
    ( Record_type
    , Record_action
    , GOAL_ID
    , STAFF_ID
    , GOAL_ENTRY_DATE
    , GTL_ID
    , GOAL_DESCRIPTION
    , GOAL_DATE
    , PROGRESS_NOTE
    , CREATE_BY
    , CREATE_DATETIME
    , LAST_UPDATED_BY
    , LAST_UPDATED_DATETIME
    )
     VALUES
      ('Insert'
      ,'Insert'
      ,:new.GOAL_ID
      ,:new.STAFF_ID
      ,:new.GOAL_ENTRY_DATE
      ,:new.GTL_ID
      ,:new.GOAL_DESCRIPTION
      ,:new.GOAL_DATE
      ,:new.PROGRESS_NOTE
      ,:new.CREATE_BY
      ,:new.CREATE_DATETIME
      ,:new.LAST_UPDATED_BY
      ,:new.LAST_UPDATED_DATETIME
     );
END IF;
IF DELETING THEN
    INSERT INTO SC_GOAL_AUDIT
    ( Record_type
    , Record_action
    , GOAL_ID
    , STAFF_ID
    , GOAL_ENTRY_DATE
    , GTL_ID
    , GOAL_DESCRIPTION
    , GOAL_DATE
    , PROGRESS_NOTE
    , CREATE_BY
    , CREATE_DATETIME
    , LAST_UPDATED_BY
    , LAST_UPDATED_DATETIME
    )
     VALUES
      ('Delete'
      ,'Delete'
      ,:old.GOAL_ID
      ,:old.STAFF_ID
      ,:old.GOAL_ENTRY_DATE
      ,:old.GTL_ID
      ,:old.GOAL_DESCRIPTION
      ,:old.GOAL_DATE
      ,:old.PROGRESS_NOTE
      ,:old.CREATE_BY
      ,:old.CREATE_DATETIME
      ,:old.LAST_UPDATED_BY
      ,:old.LAST_UPDATED_DATETIME
     );
END IF;

END;
/

show errors

CREATE or replace TRIGGER DP_SCORECARD.TRG_BIU_SC_AUDIT_TEAM_LEAD_QLT
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
/

show errors

CREATE or replace TRIGGER DP_SCORECARD.TRG_BIU_SC_AUDIT_TEAM_LEAD_QZ
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
/

show errors


