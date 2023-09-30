---------------------------------------------------------------------
-- Create the new function
---------------------------------------------------------------------
CREATE OR REPLACE FUNCTION DP_SCORECARD.FIND_SUPERVISOR_STAFF_ID(IN_STAFF_ID NUMBER, IN_DATE DATE, IN_SUPERVISOR_STAFF_ID_DEFAULT NUMBER DEFAULT 0)
RETURN NUMBER
IS
 	SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/patch/20170623_PP_WFM_BACK_OFFICE_LOAD_PKG.sql $';
  	SVN_REVISION varchar2(20) := '$Revision: 20489 $';
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2017-07-03 15:31:06 -0400 (Mon, 03 Jul 2017) $';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';

    LV_SUPERVISOR_STAFF_ID  NUMBER(10);

BEGIN

    LV_SUPERVISOR_STAFF_ID := 0;
    
	IF TRUNC(IN_DATE) <= TRUNC(SYSDATE)
	THEN 
	
		-- lookup the SUPERVISOR_ID based on the STAFF_ID and DATE
		BEGIN
			SELECT MAX(NVL(SUPERVISOR_ID,0)) 
				INTO LV_SUPERVISOR_STAFF_ID 
			FROM DP_SCORECARD.SC_HIERARCHY_STAFF_TO_STAFF Y
			WHERE Y.STAFF_ID = IN_STAFF_ID
			AND IN_DATE BETWEEN Y.EFFECTIVE_DATE AND Y.ADJUSTED_END_DATE 
			GROUP BY Y.SUPERVISOR_ID
			HAVING SUM(1) = 1;
		exception
			when no_data_found
				then null;
			when others 
				then raise;
		end;		
    
        -- Check(S) to determine a valid SUPERVISOR_ID
        
        
        IF  nvl(LV_SUPERVISOR_STAFF_ID,0 ) = 0 
        THEN
            -- Attempt to get one from MAXDAT
			begin
			
				SELECT MAX(NVL(SUPERVISOR_ID,0)) 
					INTO LV_SUPERVISOR_STAFF_ID 
				FROM MAXDAT.PP_WFM_SUPERVISOR_TO_STAFF MAXDAT
				WHERE MAXDAT.STAFF_ID = IN_STAFF_ID
				AND IN_DATE BETWEEN MAXDAT.EFFECTIVE_DATE AND MAXDAT.END_DATE 
				GROUP BY MAXDAT.SUPERVISOR_ID
				HAVING SUM(1) = 1;
			exception
			when no_data_found
				then null;
			when others 
				then raise;
			end;
        END IF;    
    
        IF  nvl(LV_SUPERVISOR_STAFF_ID,0 ) = 0 
        THEN
            -- Attempt to get one from the SCORECARD_HIERARCHY
		BEGIN	
			SELECT SUPERVISOR_STAFF_ID 
				INTO LV_SUPERVISOR_STAFF_ID 
			FROM DP_SCORECARD.SCORECARD_HIERARCHY
			WHERE STAFF_STAFF_ID = IN_STAFF_ID
			AND IN_DATE BETWEEN TRUNC(HIRE_DATE) AND TRUNC(NVL(TERMINATION_DATE,SYSDATE));
			 
		exception
			when no_data_found
				then null;
			when others 
				then raise;
			end;
			
        END IF;
		
        IF  nvl(LV_SUPERVISOR_STAFF_ID,0 ) = 0 
		THEN	
			LV_SUPERVISOR_STAFF_ID := IN_SUPERVISOR_STAFF_ID_DEFAULT;
		END IF;	
		
    END IF;
    
   RETURN LV_SUPERVISOR_STAFF_ID;
   
EXCEPTION

    WHEN OTHERS THEN 
    RETURN IN_SUPERVISOR_STAFF_ID_DEFAULT;
END;
/

show errors;

grant execute on DP_SCORECARD.FIND_SUPERVISOR_STAFF_ID to MAXDAT;

grant execute on DP_SCORECARD.FIND_SUPERVISOR_STAFF_ID to MAXDAT_REPORTS;

grant execute on DP_SCORECARD.FIND_SUPERVISOR_STAFF_ID to MAXDAT_READ_ONLY;

grant execute on DP_SCORECARD.FIND_SUPERVISOR_STAFF_ID to DP_SCORECARD_READ_ONLY;

---------------------------------------------------------------------
-- recreate the "new" triggers
---------------------------------------------------------------------

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

SHOW ERRORS;

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
	OR :old.Supervisor_Staff_ID 				<> :new.Supervisor_Staff_ID
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
		Scorecard_Audit_Summary, 
		Supervisor_staff_id
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
		:old.Scorecard_Audit_Summary,
		:old.Supervisor_staff_id
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
		Scorecard_Audit_Summary,
		Supervisor_staff_id
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
		:new.Scorecard_Audit_Summary,
		:new.Supervisor_staff_id
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
		Scorecard_Audit_Summary,
		Supervisor_staff_id
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
		:new.Scorecard_Audit_Summary,
		:new.Supervisor_staff_id
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
		Scorecard_Audit_Summary,
		Supervisor_staff_id
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
		:old.Scorecard_Audit_Summary,
		:old.Supervisor_staff_id
		);
    END IF;

END;
/

SHOW ERRORS;

-----------------------------------------------------------------
-- replace the 2 procedures
-----------------------------------------------------------------

CREATE OR REPLACE Procedure DP_SCORECARD.INSERT_SC_AUDIT_SCORECARD
   (
  IN_SCORECARD_AUDIT_create_USER    in VARCHAR2,     	
  IN_SCORECARD_AUDIT_DATE           in DATE,
  IN_AGENT_STAFF_ID                 in NUMBER,
  IN_ATTEND_TRKR_UPDT_ACCURATELY    in VARCHAR2,
  IN_CORRECTIVE_ACTIONS_UP_TO_DT  in VARCHAR2,
  IN_PERFORMANCE_TRKR_UP_TO_DATE    in VARCHAR2,
  IN_GOALS_UPDATED                  in VARCHAR2,
  IN_SCORECARD_AUDIT_SUMMARY        in VARCHAR2,
  IN_SUPERVISOR_STAFF_ID            IN NUMBER
   )
   
AS
--   v_username varchar2(100);
    LV_SUPERVISOR_STAFF_ID          NUMBER(10) := 0;
    
BEGIN

    LV_SUPERVISOR_STAFF_ID := 0;

	IF TRUNC(IN_SCORECARD_AUDIT_DATE) <= TRUNC(SYSDATE)
	THEN 
	-- lookup the SUPERVISOR_ID based on the AGENT_STAFF_ID and SCORECARD_AUDIT_DATE
        SELECT MAX(NVL(SUPERVISOR_ID,0)) 
        INTO LV_SUPERVISOR_STAFF_ID 
        FROM DP_SCORECARD.SC_HIERARCHY_STAFF_TO_STAFF Y
        WHERE Y.STAFF_ID = IN_AGENT_STAFF_ID
        AND IN_SCORECARD_AUDIT_DATE BETWEEN Y.EFFECTIVE_DATE AND Y.ADJUSTED_END_DATE 
		GROUP BY Y.SUPERVISOR_ID
		HAVING SUM(1) = 1;
    
        -- Check(S) to determine a valid SUPERVISOR_ID
    
        IF  nvl(LV_SUPERVISOR_STAFF_ID,0 ) = 0 
        THEN
        -- use the one input from Micro Strategy
            LV_SUPERVISOR_STAFF_ID := NVL(IN_SUPERVISOR_STAFF_ID,0);
        END IF;    
    
        IF  nvl(LV_SUPERVISOR_STAFF_ID,0 ) = 0 
        THEN
            -- Attempt to get one from MAXDAT
            SELECT MAX(NVL(SUPERVISOR_ID,0)) 
                INTO LV_SUPERVISOR_STAFF_ID 
            FROM MAXDAT.PP_WFM_SUPERVISOR_TO_STAFF MAXDAT
            WHERE MAXDAT.STAFF_ID = IN_AGENT_STAFF_ID
            AND IN_SCORECARD_AUDIT_DATE BETWEEN MAXDAT.EFFECTIVE_DATE AND MAXDAT.END_DATE 
            GROUP BY MAXDAT.SUPERVISOR_ID
            HAVING SUM(1) = 1;
        END IF;    
    
        IF  nvl(LV_SUPERVISOR_STAFF_ID,0 ) = 0 
        THEN
            -- Attempt to get one from the SCORECARD_HIERARCHY
        SELECT SUPERVISOR_STAFF_ID 
            INTO LV_SUPERVISOR_STAFF_ID 
            FROM DP_SCORECARD.SCORECARD_HIERARCHY
            WHERE STAFF_STAFF_ID = IN_AGENT_STAFF_ID;
        END IF;
    
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
            SUPERVISOR_STAFF_ID       
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
            LV_SUPERVISOR_STAFF_ID        
            );
        END IF;
        
    ELSE
		NULL;  -- NO RECORD WAS INSERTED
	END IF;
		
    COMMIT;

END;
/

SHOW ERRORS;

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
        
                -- lookup the SUPERVISOR_ID based on the AGENT_STAFF_ID and SCORECARD_AUDIT_DATE
                SELECT MAX(NVL(SUPERVISOR_ID,0)) 
                INTO LV_SUPERVISOR_STAFF_ID 
                FROM DP_SCORECARD.SC_HIERARCHY_STAFF_TO_STAFF Y
                WHERE Y.STAFF_ID = IN_AGENT_STAFF_ID
                AND IN_SCORECARD_AUDIT_DATE BETWEEN Y.EFFECTIVE_DATE AND Y.ADJUSTED_END_DATE 
                GROUP BY Y.SUPERVISOR_ID
                HAVING SUM(1) = 1;
    
                -- Check(S) to determine a valid SUPERVISOR_ID
    
                IF  nvl(LV_SUPERVISOR_STAFF_ID,0 ) = 0 
                THEN
                    -- use the one input from Micro Strategy
                    LV_SUPERVISOR_STAFF_ID := NVL(IN_SUPERVISOR_STAFF_ID,0);
                END IF;    
    
                IF  nvl(LV_SUPERVISOR_STAFF_ID,0 ) = 0 
                THEN
                    -- Attempt to get one from MAXDAT
                    SELECT MAX(NVL(SUPERVISOR_ID,0)) 
                    INTO LV_SUPERVISOR_STAFF_ID 
                    FROM MAXDAT.PP_WFM_SUPERVISOR_TO_STAFF MAXDAT
                    WHERE MAXDAT.STAFF_ID = IN_AGENT_STAFF_ID
                    AND IN_SCORECARD_AUDIT_DATE BETWEEN MAXDAT.EFFECTIVE_DATE AND MAXDAT.END_DATE 
                    GROUP BY MAXDAT.SUPERVISOR_ID
                    HAVING SUM(1) = 1;
                END IF;    
    
                IF  nvl(LV_SUPERVISOR_STAFF_ID,0 ) = 0 
                THEN
                -- Attempt to get one from the SCORECARD_HIERARCHY
                    SELECT SUPERVISOR_STAFF_ID 
                    INTO LV_SUPERVISOR_STAFF_ID 
                    FROM DP_SCORECARD.SCORECARD_HIERARCHY
                    WHERE STAFF_STAFF_ID = IN_AGENT_STAFF_ID;
                END IF;
    
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

SHOW ERRORS;

------------------------------------------------------------------------------
-- recreate tte view
------------------------------------------------------------------------------

DROP VIEW DP_SCORECARD.SC_AUDIT_SCORECARD_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SC_AUDIT_SCORECARD_SV
(SCORECARD_AUDIT_ID, SCORECARD_AUDIT_DATE, SCORECARD_AUDIT_CREATE_DATE, SCORECARD_AUDIT_CREATE_USER, SCORECARD_AUDIT_UPDATE_DATE, 
 SCORECARD_AUDIT_UPDATE_USER, AGENT_STAFF_ID, ATTEND_TRKR_UPDT_ACCURATELY, CORRECTIVE_ACTIONS_UP_TO_DATE, PERFORMANCE_TRKR_UP_TO_DATE, 
 GOALS_UPDATED, SCORECARD_AUDIT_SUMMARY,SUPERVISOR_STAFF_ID)
AS 
SELECT SCORECARD_AUDIT_ID,SCORECARD_AUDIT_DATE,SCORECARD_AUDIT_CREATE_DATE,SCORECARD_AUDIT_CREATE_USER,SCORECARD_AUDIT_UPDATE_DATE,
SCORECARD_AUDIT_UPDATE_USER,AGENT_STAFF_ID,ATTEND_TRKR_UPDT_ACCURATELY,CORRECTIVE_ACTIONS_UP_TO_DATE,PERFORMANCE_TRKR_UP_TO_DATE,
GOALS_UPDATED,SCORECARD_AUDIT_SUMMARY,SUPERVISOR_STAFF_ID 
FROM DP_SCORECARD.SC_AUDIT_SCORECARD;

SHOW ERRORS;

GRANT DELETE, INSERT, SELECT, UPDATE ON DP_SCORECARD.SC_AUDIT_SCORECARD_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SCORECARD_SV TO MAXDAT_READ_ONLY;

GRANT DELETE, INSERT, SELECT, UPDATE ON DP_SCORECARD.SC_AUDIT_SCORECARD_SV TO MAXDAT_REPORTS;


----------------------------------------------------------------------------------
-- recreate the view
----------------------------------------------------------------------------------

DROP VIEW DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT_SV
(RECORD_TYPE, RECORD_ACTION, TRANSACTION_DATE, SCORECARD_AUDIT_ID, SCORECARD_AUDIT_DATE, 
 SCORECARD_AUDIT_CREATE_DATE, SCORECARD_AUDIT_CREATE_USER, SCORECARD_AUDIT_UPDATE_DATE, SCORECARD_AUDIT_UPDATE_USER, AGENT_STAFF_ID, 
 ATTEND_TRKR_UPDT_ACCURATELY, CORRECTIVE_ACTIONS_UP_TO_DATE, PERFORMANCE_TRKR_UP_TO_DATE, GOALS_UPDATED, SCORECARD_AUDIT_SUMMARY, SUPERVISOR_STAFF_ID)
AS 
SELECT RECORD_TYPE,RECORD_ACTION,TRANSACTION_DATE,SCORECARD_AUDIT_ID,SCORECARD_AUDIT_DATE,
SCORECARD_AUDIT_CREATE_DATE,SCORECARD_AUDIT_CREATE_USER,SCORECARD_AUDIT_UPDATE_DATE,SCORECARD_AUDIT_UPDATE_USER,AGENT_STAFF_ID,
ATTEND_TRKR_UPDT_ACCURATELY,CORRECTIVE_ACTIONS_UP_TO_DATE,PERFORMANCE_TRKR_UP_TO_DATE,GOALS_UPDATED,SCORECARD_AUDIT_SUMMARY, SUPERVISOR_STAFF_ID
 FROM DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT;

SHOW ERRORS; 

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SC_AUDIT_SCORECARD_AUDIT_SV TO MAXDAT_REPORTS;
