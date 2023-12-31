--FROM THE MAXDAT SCHEMA
--GRANT SELECT ON MAXDAT.BPM_D_DATES TO DP_SCORECARD WITH GRANT OPTION;

-- FROM THE DP_SCORECARD SCHEMA
CREATE OR REPLACE FORCE EDITIONABLE VIEW "DP_SCORECARD"."SCORECARD_WORK_SUB_ACTIVITY_ERRORS_SV" ("RT_ACTUALS_ID", "STAFF_ID", "EVENT_ID", "SOURCE_ID", "TASK_START", "TASK_CATEGORY_ID", "TASK_END", "WORK_ACTIVITY", "ANNOTATION", "CREATE_DATE", "CREATE_STAFF_ID", "MODIFY_DATE", "MODIFY_STAFF_ID", "QUEUE_ID", "EXCLUSION_FLAG", "WORK_SUBACTIVITY", "ADMIN_ID", "SR_DIRECTOR_NAME", "SR_DIRECTOR_STAFF_ID", "SR_DIRECTOR_NATID", "DIRECTOR_NAME", "DIRECTOR_STAFF_ID", "DIRECTOR_NATID", "SR_MANAGER_NAME", "SR_MANAGER_STAFF_ID", "SR_MANAGER_NATID", "MANAGER_NAME", "MANAGER_STAFF_ID", "MANAGER_NATID", "SUPERVISOR_NAME", "SUPERVISOR_STAFF_ID", "SUPERVISOR_NATID", "STAFF_STAFF_ID", "STAFF_STAFF_NAME", "STAFF_NATID", "HIRE_DATE", "POSITION", "OFFICE", "TERMINATION_DATE", "EVENT_NAME", "DEPARTMENT", "BUILDING", "QC_TENURE", "QC_GROUP", "LAST_UPDATED_DATE") AS 
  WITH 
BUSINESS_DAYS AS
(  SELECT D_DATE 
        FROM MAXDAT.BPM_D_DATES
        WHERE D_DATE >= 
            (   SELECT min(D_DATE) as d_date
                FROM ( SELECT D_DATE 
                        FROM MAXDAT.BPM_D_DATES
                        WHERE BUSINESS_DAY_FLAG = 'Y'
                        AND D_DATE >= TRUNC(ADD_MONTHS(SYSDATE,-3),'MM')
                        GROUP BY D_DATE 
                        ORDER BY D_DATE DESC
                    )
                --WHERE ROWNUM <= 5  --<< GO BACK 5 BUSINESS DAYS
                WHERE ROWNUM <= 60  --<< GO BACK 60 FOR TESTING
            )
 ),
ACTUALS AS 
( SELECT A.* FROM MAXDAT.PP_WFM_ACTUALS A
  JOIN BUSINESS_DAYS BD
  ON BD.D_DATE = TRUNC(TASK_START)
	WHERE TRUNC(TASK_END) = TRUNC(TASK_START)  --<< Only use events that start and end on the same day
	AND NVL(EXCLUSION_FLAG,'N') <> 'Y'
	AND TRUNC(TASK_START) >= TRUNC(ADD_MONTHS(SYSDATE, -12), 'MM')
	),
TARGRT_LKUP AS
( SELECT EVENT_ID,
       CASE
         WHEN UPPER(SCORECARD_GROUP) LIKE 'OTHER%' THEN
          'All Other Tasks'
         ELSE
          scorecard_group
       END AS scorecard_group,
	   SCORECARD_FLAG,
       TRUNC(start_date)   AS start_date,
       NVL(TRUNC(end_date), TRUNC(sysdate+1)) AS end_date,
       WORKSUBACTIVITY_FLAG  AS SUBACTIVITY_FLAG,
	   EE_ADHERENCE, EE_ADHERENCE_V2,
	   target,
	   ops_group,
	   qc_flag
  FROM maxdat.PP_BO_EVENT_TARGET_LKUP
),
HSV AS
( SELECT * FROM DP_SCORECARD.SCORECARD_HIERARCHY
)
SELECT ACTUALS."RT_ACTUALS_ID",ACTUALS."STAFF_ID",ACTUALS."EVENT_ID",ACTUALS."SOURCE_ID",ACTUALS."TASK_START",ACTUALS."TASK_CATEGORY_ID",ACTUALS."TASK_END",ACTUALS."WORK_ACTIVITY",ACTUALS."ANNOTATION",ACTUALS."CREATE_DATE",ACTUALS."CREATE_STAFF_ID",ACTUALS."MODIFY_DATE",ACTUALS."MODIFY_STAFF_ID",ACTUALS."QUEUE_ID",ACTUALS."EXCLUSION_FLAG",ACTUALS."WORK_SUBACTIVITY", HSV."ADMIN_ID",HSV."SR_DIRECTOR_NAME",HSV."SR_DIRECTOR_STAFF_ID",HSV."SR_DIRECTOR_NATID",HSV."DIRECTOR_NAME",HSV."DIRECTOR_STAFF_ID",HSV."DIRECTOR_NATID",HSV."SR_MANAGER_NAME",HSV."SR_MANAGER_STAFF_ID",HSV."SR_MANAGER_NATID",HSV."MANAGER_NAME",HSV."MANAGER_STAFF_ID",HSV."MANAGER_NATID",HSV."SUPERVISOR_NAME",HSV."SUPERVISOR_STAFF_ID",HSV."SUPERVISOR_NATID",HSV."STAFF_STAFF_ID",HSV."STAFF_STAFF_NAME",HSV."STAFF_NATID",HSV."HIRE_DATE",HSV."POSITION",HSV."OFFICE",HSV."TERMINATION_DATE",HSV."EVENT_NAME",HSV."DEPARTMENT",HSV."BUILDING",HSV."QC_TENURE",HSV."QC_GROUP",HSV."LAST_UPDATED_DATE" 
FROM ACTUALS
JOIN DP_SCORECARD.SCORECARD_HIERARCHY HSV
	ON HSV.STAFF_STAFF_ID = ACTUALS.STAFF_ID
--left outer JOIN  (    
JOIN  TARGRT_LKUP 
    ON   (ACTUALS.EVENT_ID = TARGRT_LKUP.EVENT_ID)
    AND (TRUNC(ACTUALS.TASK_START) >= TRUNC(TARGRT_LKUP.start_date)
    AND TRUNC(ACTUALS.TASK_START) <= TRUNC(TARGRT_LKUP.end_date) )
	-- NYHIX-54316 - NYSOH - DP - Scorecard Errors on Large Sub Activity Values
    -- exclude any records where the lenght of the sub_activity > 6
WHERE    
	 LENGTH(to_number(
		CASE
			WHEN TARGRT_LKUP.SUBACTIVITY_FLAG = 'Y'
			AND TARGRT_LKUP.QC_FLAG = 'Y'
			AND ACTUALS.WORK_SUBACTIVITY = '10'
				THEN '1'
			----
			WHEN TARGRT_LKUP.SUBACTIVITY_FLAG = 'Y'
			AND TARGRT_LKUP.QC_FLAG = 'Y'
			AND  NVL(ACTUALS.WORK_SUBACTIVITY,'?') <> '10'
				THEN '0'
			----
			WHEN TARGRT_LKUP.SUBACTIVITY_FLAG = 'Y'
			THEN NVL(DP_SCORECARD.RETURN_NUMERIC(TRIM(ACTUALS.WORK_SUBACTIVITY)),0)
			ELSE '0'
			END
        )) > 6 --<= 6
       ORDER BY TASK_START, ACTUALS.STAFF_ID, ACTUALS.EVENT_ID;
       
grant select on  DP_SCORECARD.SCORECARD_WORK_SUB_ACTIVITY_ERRORS_SV to maxdat;      
grant select on  DP_SCORECARD.SCORECARD_WORK_SUB_ACTIVITY_ERRORS_SV to maxdat_reports;      
grant select on  DP_SCORECARD.SCORECARD_WORK_SUB_ACTIVITY_ERRORS_SV to maxdat_read_only;      
grant select on  DP_SCORECARD.SCORECARD_WORK_SUB_ACTIVITY_ERRORS_SV to dp_scorecard_read_only;      


