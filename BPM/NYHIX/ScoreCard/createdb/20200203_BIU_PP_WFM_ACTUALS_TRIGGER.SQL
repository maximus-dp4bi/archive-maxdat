create or replace TRIGGER MAXDAT.BIU_PP_WFM_ACTUALS
  BEFORE INSERT OR UPDATE ON MAXDAT.PP_WFM_ACTUALS
	FOR EACH ROW
	
DECLARE
	LV_EXCLUSION_FLAG  VARCHAR2(1) := NULL;
BEGIN

	LV_EXCLUSION_FLAG := :NEW.EXCLUSION_FLAG;

    IF LENGTH(nvl(:NEW.WORK_SUBACTIVITY,0)) <= 6
    OR :NEW.EXCLUSION_FLAG = 'Y'
    THEN
        NULL;
    ELSE    

        IF INSERTING 
        THEN
            SELECT 'Y' INTO LV_EXCLUSION_FLAG FROM DUAL
            WHERE 1=1 
            AND NVL(:NEW.EXCLUSION_FLAG,'N') <> 'Y'
            AND TRUNC(:NEW.TASK_END) = TRUNC(:NEW.TASK_START)  
            AND EXISTS ( 
                        SELECT STAFF_STAFF_ID 
                        FROM DP_SCORECARD.SCORECARD_HIERARCHY 
                        WHERE STAFF_STAFF_ID = :NEW.STAFF_ID 
                        )
            AND EXISTS ( 
                        SELECT EVENT_ID 
                        FROM MAXDAT.PP_BO_EVENT_TARGET_LKUP LKUP
                        WHERE EVENT_ID = :NEW.EVENT_ID
                        AND TRUNC(:NEW.TASK_START) >= TRUNC(LKUP.START_DATE)
                        AND TRUNC(:NEW.TASK_START) <= TRUNC(NVL(LKUP.END_DATE,SYSDATE)) 
                        AND LKUP.WORKSUBACTIVITY_FLAG = 'Y'
                        AND NVL(QC_FLAG,'N') <> 'Y'
    --   AND LENGTH(NVL(DP_SCORECARD.RETURN_NUMERIC(TRIM(:NEW.WORK_SUBACTIVITY)),0)) > 6
                        );
        END IF;

        IF UPDATING
            THEN
                SELECT 'Y' INTO LV_EXCLUSION_FLAG FROM DUAL
            WHERE 1=1 
            AND NVL(:NEW.EXCLUSION_FLAG,'N') <> 'Y'
            AND TRUNC(:NEW.TASK_END) = TRUNC(:NEW.TASK_START)  --<< ONLY USE EVENTS THAT START AND END ON THE SAME DAY
            AND EXISTS ( 
                        SELECT STAFF_STAFF_ID 
                        FROM DP_SCORECARD.SCORECARD_HIERARCHY 
                        WHERE STAFF_STAFF_ID = :NEW.STAFF_ID 
                        )
            AND EXISTS ( 
                        SELECT EVENT_ID 
                        FROM MAXDAT.PP_BO_EVENT_TARGET_LKUP LKUP
                        WHERE EVENT_ID = :NEW.EVENT_ID
                        AND TRUNC(:NEW.TASK_START) >= TRUNC(LKUP.START_DATE)
                        AND TRUNC(:NEW.TASK_START) <= TRUNC(NVL(LKUP.END_DATE,SYSDATE)) 
                        AND LKUP.WORKSUBACTIVITY_FLAG = 'Y'
                        AND NVL(LKUP.QC_FLAG,'N') <> 'Y'
        --AND LENGTH(NVL(DP_SCORECARD.RETURN_NUMERIC(TRIM(:NEW.WORK_SUBACTIVITY)),0)) > 6
                        );

        END IF; 

    END IF;

		:NEW.EXCLUSION_FLAG := LV_EXCLUSION_FLAG; 

EXCEPTION

	WHEN NO_DATA_FOUND 
		THEN :NEW.EXCLUSION_FLAG := LV_EXCLUSION_FLAG; 

	WHEN OTHERS 
		THEN RAISE;

END;
/

SHOW ERRORS