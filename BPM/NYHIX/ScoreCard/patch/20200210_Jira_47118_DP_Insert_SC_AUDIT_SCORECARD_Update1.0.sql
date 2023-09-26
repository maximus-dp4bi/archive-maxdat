--------------------------------------------------------
--  DDL for Procedure INSERT_SC_AUDIT_SCORECARD
--------------------------------------------------------

create or replace Procedure              INSERT_SC_AUDIT_SCORECARD
   (
  IN_SCORECARD_AUDIT_create_USER    in VARCHAR2,     	
  IN_SCORECARD_AUDIT_DATE           in DATE,
  IN_AGENT_STAFF_ID                 in NUMBER,
  IN_ATTEND_TRKR_UPDT_ACCURATELY    in VARCHAR2,
  IN_CORRECTIVE_ACTIONS_UP_TO_DT  in VARCHAR2,
  IN_PERFORMANCE_TRKR_UP_TO_DATE    in VARCHAR2,
  IN_GOALS_UPDATED                  in VARCHAR2,
  IN_SCORECARD_AUDIT_SUMMARY        in VARCHAR2,
  IN_SUPERVISOR_STAFF_ID            IN NUMBER,
  IN_DOCUMENT_UPLOAD_COMPLETED      IN VARCHAR2
   )
   
AS
--   v_username varchar2(100);
    LV_SUPERVISOR_STAFF_ID          NUMBER(10) := 0;
    
BEGIN

    LV_SUPERVISOR_STAFF_ID := 0;

    LV_SUPERVISOR_STAFF_ID := FIND_SUPERVISOR_STAFF_ID(IN_AGENT_STAFF_ID, IN_SCORECARD_AUDIT_DATE, IN_SUPERVISOR_STAFF_ID);    

        -- DO THE INSERT
        IF  NVL(LV_SUPERVISOR_STAFF_ID,0 ) <> 0
        THEN 
            INSERT INTO DP_SCORECARD.SC_AUDIT_SCORECARD
            (
            SCORECARD_AUDIT_CREATE_USER, 
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
            SCORECARD_AUDIT_SUMMARY,
            SUPERVISOR_STAFF_ID,
            DOCUMENT_UPLOAD_COMPLETED
            )
            VALUES
            (
            IN_SCORECARD_AUDIT_CREATE_USER,    
            SYSDATE,
            IN_SCORECARD_AUDIT_CREATE_USER,    
            SYSDATE,
            --
            IN_SCORECARD_AUDIT_DATE,           
            IN_AGENT_STAFF_ID,                 
            IN_ATTEND_TRKR_UPDT_ACCURATELY,    
            IN_CORRECTIVE_ACTIONS_UP_TO_DT, 
            IN_PERFORMANCE_TRKR_UP_TO_DATE,    
            IN_GOALS_UPDATED,                  
            IN_SCORECARD_AUDIT_SUMMARY,
            LV_SUPERVISOR_STAFF_ID,
            IN_DOCUMENT_UPLOAD_COMPLETED
            );
        
    ELSE
		NULL;  -- NO RECORD WAS INSERTED
	END IF;
		
    COMMIT;

END;

/
Commit;
