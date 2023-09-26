-----------------------------------------------------------
-- create the AUDIT table
-----------------------------------------------------------

--DROP TABLE DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUALITY_AUD CASCADE CONSTRAINTS;

CREATE TABLE DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUALITY_AUD
(
  RECORD_TYPE                     VARCHAR2(10 BYTE),
  RECORD_ACTION                   VARCHAR2(10 BYTE),
  TRANSACTION_DATE                DATE,
  TEAM_LEAD_QUALITY_ID            NUMBER(13)    NOT NULL,
  TEAM_LEAD_AGENT_STAFF_ID        NUMBER        NOT NULL,
  DATES_MONTH_NUM                 NUMBER(6)     NOT NULL,
  TEAM_LEAD_QUALITY_CREATE_USER   VARCHAR2(100 BYTE) NOT NULL,
  TEAM_LEAD_QUALITY_CREATE_DATE   DATE          NOT NULL,
  TEAM_LEAD_QUALITY_UPDATE_USER   VARCHAR2(100 BYTE) NOT NULL,
  TEAM_LEAD_QUALITY_UPDATE_DATE   DATE          NOT NULL,
  REVIEW_SESSIONS_COMPLTD_RATING  VARCHAR2(100 CHAR),
  REVIEW_SESSIONS_COMPLTD_POINTS  NUMBER(5),
  LIVE_OBSRV_COMPLTD_RATING       VARCHAR2(100 CHAR),
  LIVE_OBSRV_COMPLTD_POINTS       NUMBER(5),
  QPP_CHECKLIST_COMPLTD_RATING    VARCHAR2(100 CHAR),
  QPP_CHECKLIST_COMPLTD_POINTS    NUMBER(5),
  QPP_QUALITY_SCORE_1_RATING      VARCHAR2(100 CHAR),
  QPP_QUALITY_SCORE_1_POINTS      NUMBER(5),
  QPP_QUALITY_SCORE_2_RATING      VARCHAR2(100 CHAR),
  QPP_QUALITY_SCORE_2_POINTS      NUMBER(5)
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


GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUALITY_AUD TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUALITY_AUD TO MAXDAT_REPORTS;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUALITY_AUD TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUALITY_AUD TO DP_SCORECARD_READ_ONLY;

-----------------------------------------------------------
-- create the data table
-----------------------------------------------------------


--DROP TABLE DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUALITY;

CREATE TABLE DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUALITY
(
TEAM_LEAD_QUALITY_ID              	NUMBER(13)      	NOT NULL,
TEAM_LEAD_AGENT_STAFF_ID          	NUMBER          	NOT NULL,
DATES_MONTH_NUM            			NUMBER(6)          	NOT NULL,
TEAM_LEAD_QUALITY_CREATE_USER     	VARCHAR2(100 BYTE) 	NOT NULL,
TEAM_LEAD_QUALITY_CREATE_DATE     	DATE            	NOT NULL,
TEAM_LEAD_QUALITY_UPDATE_USER     	VARCHAR2(100 BYTE) 	NOT NULL,
TEAM_LEAD_QUALITY_UPDATE_DATE     	DATE    	        NOT NULL,
REVIEW_SESSIONS_COMPLTD_RATING	VARCHAR2(100 CHAR),
REVIEW_SESSIONS_COMPLTD_POINTS	NUMBER(5),
LIVE_OBSRV_COMPLTD_RATING			VARCHAR2(100 CHAR),
LIVE_OBSRV_COMPLTD_POINTS			NUMBER(5),
QPP_CHECKLIST_COMPLTD_RATING 		VARCHAR2(100 CHAR),
QPP_CHECKLIST_COMPLTD_POINTS		NUMBER(5),
QPP_QUALITY_SCORE_1_RATING 			VARCHAR2(100 CHAR),
QPP_QUALITY_SCORE_1_POINTS 			NUMBER(5),
QPP_QUALITY_SCORE_2_RATING			VARCHAR2(100 CHAR),
QPP_QUALITY_SCORE_2_POINTS			NUMBER(5)
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

GRANT SELECT, INSERT, UPDATE, DELETE ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUALITY TO MAXDAT;

GRANT SELECT, INSERT, UPDATE, DELETE ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUALITY TO MAXDAT_REPORTS;

GRANT SELECT, INSERT, UPDATE, DELETE ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUALITY TO MAXDAT_READ_ONLY;

GRANT SELECT, INSERT, UPDATE, DELETE ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUALITY TO DP_SCORECARD_READ_ONLY;

-----------------------------------------------------------
-- create the Sequence
-----------------------------------------------------------
drop SEQUENCE DP_SCORECARD.SEQ_SC_AUDIT_TEAM_LEAD_QUALITY;

CREATE SEQUENCE DP_SCORECARD.SEQ_SC_AUDIT_TEAM_LEAD_QUALITY;

-----------------------------------------------------------
-- create the Insert Update and Delete Trigger
-----------------------------------------------------------
CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_AIU_SC_AUDIT_Team_Lead_QLT
AFTER INSERT OR UPDATE OR DELETE ON SC_AUDIT_Team_lead_Quality 
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

-----------------------------------------------------------
-- initial insert trigger
----------------------------------------------------------

CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_BIU_SC_AUDIT_TEAM_LEAD_QLT
BEFORE INSERT OR UPDATE ON SC_AUDIT_TEAM_LEAD_QUALITY
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

-- ********************************************************************
-- ********************************************************************
-- ********************************************************************

-----------------------------------------------------------
-- create the AUDIT table
-----------------------------------------------------------

--DROP TABLE DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUIZ_AUD;

CREATE TABLE DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUIZ_AUD
(
  RECORD_TYPE                 VARCHAR2(10 BYTE),
  RECORD_ACTION               VARCHAR2(10 BYTE),
  TRANSACTION_DATE            DATE,
  TEAM_LEAD_QUIZ_ID           NUMBER(13)        NOT NULL,
  TEAM_LEAD_AGENT_STAFF_ID    NUMBER            NOT NULL,
  TEAM_LEAD_QUIZ_CREATE_USER  VARCHAR2(100 BYTE) NOT NULL,
  TEAM_LEAD_QUIZ_CREATE_DATE  DATE              NOT NULL,
  TEAM_LEAD_QUIZ_UPDATE_USER  VARCHAR2(100 BYTE) NOT NULL,
  TEAM_LEAD_QUIZ_UPDATE_DATE  DATE              NOT NULL,
  CBT_EXAM_NAME               VARCHAR2(200 BYTE) NOT NULL,
  CBT_EXAM_ASSIGNMENT_DATE    DATE,
  CBT_EXAM_COMPLETION_DATE    DATE,
  CBT_EXAM_SCORE              NUMBER(10,4),
  CBT_EXAM_TIMELINESS         VARCHAR2(100 BYTE)
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

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUIZ_AUD TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUIZ_AUD TO MAXDAT_REPORTS;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUIZ_AUD TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUIZ_AUD TO DP_SCORECARD_READ_ONLY;

-----------------------------------------------------------
-- create the data table
-----------------------------------------------------------


--DROP TABLE DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUIZ;

CREATE TABLE DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUIZ
(
TEAM_LEAD_QUIZ_ID              	NUMBER(13)      	NOT NULL,
TEAM_LEAD_AGENT_STAFF_ID          	NUMBER          	NOT NULL,
TEAM_LEAD_QUIZ_CREATE_USER     	VARCHAR2(100 BYTE) 	NOT NULL,
TEAM_LEAD_QUIZ_CREATE_DATE     	DATE            	NOT NULL,
TEAM_LEAD_QUIZ_UPDATE_USER     	VARCHAR2(100 BYTE) 	NOT NULL,
TEAM_LEAD_QUIZ_UPDATE_DATE     	DATE    	        NOT NULL,
CBT_EXAM_NAME					VARCHAR2(200 BYTE)	NOT NULL,
CBT_EXAM_ASSIGNMENT_DATE		DATE,
CBT_EXAM_COMPLETION_DATE		DATE,
CBT_EXAM_SCORE					NUMBER(10,4),		
CBT_EXAM_TIMELINESS				VARCHAR2(100)
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

-----------------------------------------------------------
-- create the Sequence
-----------------------------------------------------------
drop SEQUENCE DP_SCORECARD.SEQ_SC_AUDIT_TEAM_LEAD_QUIZ;

CREATE SEQUENCE DP_SCORECARD.SEQ_SC_AUDIT_TEAM_LEAD_QUIZ;

-----------------------------------------------------------
-- create the Insert Update and Delete Trigger
-----------------------------------------------------------
CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_AIU_SC_AUDIT_Team_Lead_QZ
AFTER INSERT OR UPDATE OR DELETE ON SC_AUDIT_Team_lead_QUIZ 
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

----------------------------------------------------------
-- initial insert trigger
----------------------------------------------------------

CREATE OR REPLACE TRIGGER DP_SCORECARD.TRG_BIU_SC_AUDIT_TEAM_LEAD_QZ
BEFORE INSERT OR UPDATE ON SC_AUDIT_TEAM_LEAD_QUIZ
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

GRANT SELECT, INSERT, UPDATE, DELETE ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUIZ TO MAXDAT;

GRANT SELECT, INSERT, UPDATE, DELETE ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUIZ TO MAXDAT_REPORTS;

GRANT SELECT, INSERT, UPDATE, DELETE ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUIZ TO MAXDAT_READ_ONLY;

GRANT SELECT, INSERT, UPDATE, DELETE ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUIZ TO DP_SCORECARD_READ_ONLY;

-- **********************************************************************
-- **********************************************************************

--DROP VIEW DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUALITY_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUALITY_SV
(DATES_MONTH_YEAR, DATES_QTR_YEAR, TEAM_LEAD_QUALITY_ID, TEAM_LEAD_AGENT_STAFF_ID, DATES_MONTH_NUM, 
 TEAM_LEAD_QUALITY_CREATE_USER, TEAM_LEAD_QUALITY_CREATE_DATE, TEAM_LEAD_QUALITY_UPDATE_USER, TEAM_LEAD_QUALITY_UPDATE_DATE, REVIEW_SESSIONS_COMPLTD_RATING, 
 REVIEW_SESSIONS_COMPLTD_POINTS, LIVE_OBSRV_COMPLTD_RATING, LIVE_OBSRV_COMPLTD_POINTS, QPP_CHECKLIST_COMPLTD_RATING, QPP_CHECKLIST_COMPLTD_POINTS, 
 QPP_QUALITY_SCORE_1_RATING, QPP_QUALITY_SCORE_1_POINTS, QPP_QUALITY_SCORE_2_RATING, QPP_QUALITY_SCORE_2_POINTS, TOTAL_POINTS, 
 EVALUATION_RATING)
AS 
WITH STAFF_REC AS
( SELECT 
    TEAM_LEAD_QUALITY_ID, TEAM_LEAD_AGENT_STAFF_ID, DATES_MONTH_NUM, 
   TEAM_LEAD_QUALITY_CREATE_USER, TEAM_LEAD_QUALITY_CREATE_DATE, TEAM_LEAD_QUALITY_UPDATE_USER, 
   TEAM_LEAD_QUALITY_UPDATE_DATE, REVIEW_SESSIONS_COMPLTD_RATING, REVIEW_SESSIONS_COMPLTD_POINTS, 
   LIVE_OBSRV_COMPLTD_RATING, LIVE_OBSRV_COMPLTD_POINTS, QPP_CHECKLIST_COMPLTD_RATING, 
   QPP_CHECKLIST_COMPLTD_POINTS, QPP_QUALITY_SCORE_1_RATING, QPP_QUALITY_SCORE_1_POINTS, 
   QPP_QUALITY_SCORE_2_RATING, QPP_QUALITY_SCORE_2_POINTS,
   ---
   REVIEW_SESSIONS_COMPLTD_POINTS 
   +LIVE_OBSRV_COMPLTD_POINTS  
   +QPP_CHECKLIST_COMPLTD_POINTS 
   +QPP_QUALITY_SCORE_1_POINTS 
   +QPP_QUALITY_SCORE_2_POINTS AS TOTAL_POINTS
   ---
FROM DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUALITY
)
SELECT QTRS.DATES_MONTH_YEAR, QTRS.DATES_QTR_YEAR, 
--
STAFF_REC.TEAM_LEAD_QUALITY_ID, 
STAFF_REC.TEAM_LEAD_AGENT_STAFF_ID, 
STAFF_REC.DATES_MONTH_NUM, 
STAFF_REC.TEAM_LEAD_QUALITY_CREATE_USER, 
STAFF_REC.TEAM_LEAD_QUALITY_CREATE_DATE, 
STAFF_REC.TEAM_LEAD_QUALITY_UPDATE_USER, 
STAFF_REC.TEAM_LEAD_QUALITY_UPDATE_DATE, 
STAFF_REC.REVIEW_SESSIONS_COMPLTD_RATING, 
STAFF_REC.REVIEW_SESSIONS_COMPLTD_POINTS, 
STAFF_REC.LIVE_OBSRV_COMPLTD_RATING, 
STAFF_REC.LIVE_OBSRV_COMPLTD_POINTS, 
STAFF_REC.QPP_CHECKLIST_COMPLTD_RATING, 
STAFF_REC.QPP_CHECKLIST_COMPLTD_POINTS, 
STAFF_REC.QPP_QUALITY_SCORE_1_RATING, 
STAFF_REC.QPP_QUALITY_SCORE_1_POINTS, 
STAFF_REC.QPP_QUALITY_SCORE_2_RATING, 
STAFF_REC.QPP_QUALITY_SCORE_2_POINTS,
STAFF_REC.TOTAL_POINTS,
---
OVERALL_RATING.EVALUATION_RATING 
FROM STAFF_REC
JOIN DP_SCORECARD.SCORECARD_QUARTERS_SV QTRS
    ON QTRS.DATES_MONTH_NUM = STAFF_REC.DATES_MONTH_NUM
LEFT OUTER JOIN 
	--QPP_EVALUATION_RATING AS
	(SELECT DROP_DOWN_VALUE, DROP_DOWN_TEXT AS EVALUATION_RATING, 
	DROP_DOWN_RANGE_LOW, DROP_DOWN_RANGE_HIGH,
        EFFECTIVE_DATE, END_DATE 
	FROM DP_SCORECARD.SCORECARD_DROP_DOWN_LKUP_SV
	WHERE TARGET_TABLE = 'SC_AUDIT_TEAM_LEAD_QUALITY'
	AND TARGET_COLUMN = 'QPP_EVALUATION_RATING'
	) OVERALL_RATING
ON  STAFF_REC.TOTAL_POINTS 
	BETWEEN OVERALL_RATING.DROP_DOWN_RANGE_LOW 
		AND OVERALL_RATING.DROP_DOWN_RANGE_HIGH
	AND TO_DATE(STAFF_REC.DATES_MONTH_NUM,'YYYYMM') BETWEEN OVERALL_RATING.EFFECTIVE_DATE
		AND TRUNC(NVL(OVERALL_RATING.END_DATE,SYSDATE))
ORDER BY TEAM_LEAD_AGENT_STAFF_ID, STAFF_REC.DATES_MONTH_NUM;


GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUALITY_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUALITY_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUALITY_SV TO MAXDAT_REPORTS;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUALITY_SV TO DP_SCORECARD_READ_ONLY;

-- ***************************************************************************
-- ***************************************************************************

--DROP VIEW DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUIZ_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUIZ_SV
(TEAM_LEAD_QUIZ_ID, TEAM_LEAD_AGENT_STAFF_ID, TEAM_LEAD_QUIZ_CREATE_USER, TEAM_LEAD_QUIZ_CREATE_DATE, TEAM_LEAD_QUIZ_UPDATE_USER, 
 TEAM_LEAD_QUIZ_UPDATE_DATE, CBT_EXAM_NAME, CBT_EXAM_ASSIGNMENT_DATE, CBT_EXAM_COMPLETION_DATE, CBT_EXAM_SCORE, 
 CBT_EXAM_TIMELINESS)
AS 
SELECT TEAM_LEAD_QUIZ_ID,
TEAM_LEAD_AGENT_STAFF_ID,
TEAM_LEAD_QUIZ_CREATE_USER,
TEAM_LEAD_QUIZ_CREATE_DATE,
TEAM_LEAD_QUIZ_UPDATE_USER,
TEAM_LEAD_QUIZ_UPDATE_DATE,
CBT_EXAM_NAME,
CBT_EXAM_ASSIGNMENT_DATE,
CBT_EXAM_COMPLETION_DATE,
CBT_EXAM_SCORE,
CBT_EXAM_TIMELINESS 
FROM DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUIZ;


GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUIZ_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUIZ_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUIZ_SV TO MAXDAT_REPORTS;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUIZ_SV TO DP_SCORECARD_READ_ONLY;
