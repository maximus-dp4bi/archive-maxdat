--------------------------------------------------------
--  DDL for Procedure Update_SC_AUDIT_SCORECARD
--------------------------------------------------------

create or replace Procedure     UPDATE_SC_AUDIT_SCORECARD
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
  IN_SCORECARD_AUDIT_SUMMARY        in VARCHAR2,
  IN_SUPERVISOR_STAFF_ID            in NUMBER
   )

   
AS
    --  v_username varchar2(100);
    LV_SUPERVISOR_STAFF_ID          NUMBER(10) := 0;

BEGIN

	IF IN_SCORECARD_AUDIT_ID IS NULL
	OR TRUNC(IN_SCORECARD_AUDIT_DATE) > TRUNC(SYSDATE)
	THEN -- DO NOTHING
		NULL;
		
    ELSIF IN_DELETE_FLAG = 1 
        THEN
        
            DELETE FROM DP_SCORECARD.SC_AUDIT_SCORECARD WHERE SCORECARD_AUDIT_ID = IN_SCORECARD_AUDIT_ID;
            COMMIT;
		
    ELSE -- PREPARE TO DO THE UPDATE
    
        LV_SUPERVISOR_STAFF_ID := 0;

            IF TRUNC(IN_SCORECARD_AUDIT_DATE) <= TRUNC(SYSDATE)
            THEN 
        
    LV_SUPERVISOR_STAFF_ID := FIND_SUPERVISOR_STAFF_ID(IN_AGENT_STAFF_ID, IN_SCORECARD_AUDIT_DATE, IN_SUPERVISOR_STAFF_ID);    

    
                -- DO THE UPDATE
       
                IF NVL(LV_SUPERVISOR_STAFF_ID,0) <> 0
                THEN
                    UPDATE DP_SCORECARD.SC_AUDIT_SCORECARD
                    SET 
                        SCORECARD_AUDIT_DATE           = IN_SCORECARD_AUDIT_DATE,         
                        SCORECARD_AUDIT_UPDATE_USER    = IN_SCORECARD_AUDIT_UPDATE_USER,  
                        AGENT_STAFF_ID                 = IN_AGENT_STAFF_ID,               
                        ATTEND_TRKR_UPDT_ACCURATELY    = IN_ATTEND_TRKR_UPDT_ACCURATELY,  
                        CORRECTIVE_ACTIONS_UP_TO_DATE  = IN_CORRECTIVE_ACTIONS_UP_TO_DT,
                        PERFORMANCE_TRKR_UP_TO_DATE    = IN_PERFORMANCE_TRKR_UP_TO_DATE,  
                        GOALS_UPDATED                  = IN_GOALS_UPDATED,                
                        SCORECARD_AUDIT_SUMMARY        = IN_SCORECARD_AUDIT_SUMMARY,
                        SUPERVISOR_STAFF_ID            = LV_SUPERVISOR_STAFF_ID
                    WHERE SCORECARD_AUDIT_ID = IN_SCORECARD_AUDIT_ID;

                    COMMIT;
        
                END IF;
            END IF;
        
    END IF;

END;
/
COMMIT;

