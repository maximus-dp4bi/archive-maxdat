DROP MATERIALIZED VIEW APPEAL_TASKS_BY_DAY_MV;
CREATE MATERIALIZED VIEW APPEAL_TASKS_BY_DAY_MV
BUILD IMMEDIATE 
REFRESH FORCE
ON DEMAND
AS
SELECT  A11.D_DATE AS D_DATE,
    A12.TASK_TYPE_ID AS TASK_TYPE_ID,
    A17.TASK_NAME AS TASK_TYPE,
    A12.CURR_TASK_STATUS AS CURR_TASK_STATUS,
    A12.TASK_PRIORITY AS TASK_PRIORITY,
    A12.PREVIOUS_TASK_TYPE_ID AS PREVIOUS_TASK_TYPE_ID,
    A16.TASK_NAME AS PREVIOUS_TASK_TYPE,
    A13.APPEAL_TYPE AS APPEAL_TYPE,
    A13.APPEAL_STATUS AS APPEAL_STATUS,
    A13.APPEAL_STAGE AS APPEAL_STAGE,
    A13.APPEAL_REASON AS APPEAL_REASON,
    A13.APPEAL_PRIORITY AS APPEAL_PRIORITY,
    A13.APPEAL_PART AS APPEAL_PART,
    A13.APPEAL_ITEM AS APPEAL_ITEM,
    A13.APPEAL_ISSUE AS APPEAL_ISSUE,
    TRUNC(CAST(A13.DEADLINE_DATE AS DATE)) AS DEADLINE_DATE,
    A13.ADJUDICATOR AS ADJUDICATOR,
    SUM(A11.CREATION_COUNT) AS CREATION_COUNT,
    SUM(A11.INVENTORY_COUNT) AS INVENTORY_COUNT,
    SUM(A11.COMPLETION_COUNT) AS COMPLETION_COUNT,
    SUM(A11.CANCELLATION_COUNT) AS CANCELLATION_COUNT,
    SUM(A11.TERMINATION_COUNT) AS TERMINATION_COUNT,
    SUM(A11.HANDLE_TIME) AS HANDLE_TIME,
    SUM(CASE WHEN A12.TIMELINESS_STATUS IN ('Timely') THEN 1 ELSE 0 END) AS TASK_TIMELINESS_COUNT,
    SUM(CASE WHEN A12.TIMELINESS_STATUS IN ('Untimely') THEN 1 ELSE 0 END) AS TASK_UNTIMELINESS_COUNT,
    SUM(CASE WHEN A12.JEOPARDY_FLAG IN ('Y') THEN 1 ELSE 0 END) AS TASK_JEOPARDY_COUNT,
    SUM(A12.TASK_CLAIMED_TIME) AS TOTAL_CLAIMED_TIME,
    SUM(A12.TASK_UNCLAIMED_TIME) AS TOTAL_UNCLAIMED_TIME
FROM MAXDAT.F_MW_TASK_INSTANCE_BY_DATE_SV A11
LEFT OUTER JOIN MAXDAT.D_MW_TASK_INSTANCE_SV A12
    ON A11.MW_BI_ID = A12.MW_BI_ID
LEFT OUTER JOIN MAXDAT.D_MW_APPEAL_INSTANCE_SV A13
    ON A12.SOURCE_REFERENCE_ID = A13.APPEAL_ID
LEFT OUTER JOIN MAXDAT.D_TASK_TYPES_SV A16
    ON A12.PREVIOUS_TASK_TYPE_ID = A16.TASK_TYPE_ID
LEFT OUTER JOIN MAXDAT.D_TASK_TYPES_SV A17
    ON A12.TASK_TYPE_ID = A17.TASK_TYPE_ID
WHERE A11.D_DATE >= TRUNC((SYSDATE - trunc((select value from corp_etl_control where name = 'APPEAL_CUBE_SPAN')/2)),'MONTH')
AND A11.d_date < TRUNC(sysdate) - (select value from corp_etl_control where name = 'APPEAL_CUBE_LOOK_BACK_DAYS')
GROUP BY A11.D_DATE,
    A12.TASK_TYPE_ID,
    A17.TASK_NAME,
    A12.CURR_TASK_STATUS,
    A12.TASK_PRIORITY,
    A12.PREVIOUS_TASK_TYPE_ID,
    A16.TASK_NAME,
    A13.APPEAL_TYPE,
    A13.APPEAL_STATUS,
    A13.APPEAL_STAGE,
    A13.APPEAL_REASON,
    A13.APPEAL_PRIORITY,
    A13.APPEAL_PART,
    A13.APPEAL_ITEM,
    A13.APPEAL_ISSUE,
    TRUNC(CAST(A13.DEADLINE_DATE AS DATE)),
    A13.ADJUDICATOR
union all
SELECT  A11.D_DATE AS D_DATE,
    A12.TASK_TYPE_ID AS TASK_TYPE_ID,
    A17.TASK_NAME AS TASK_TYPE,
    A12.CURR_TASK_STATUS AS CURR_TASK_STATUS,
    A12.TASK_PRIORITY AS TASK_PRIORITY,
    A12.PREVIOUS_TASK_TYPE_ID AS PREVIOUS_TASK_TYPE_ID,
    A16.TASK_NAME AS PREVIOUS_TASK_TYPE,
    A13.APPEAL_TYPE AS APPEAL_TYPE,
    A13.APPEAL_STATUS AS APPEAL_STATUS,
    A13.APPEAL_STAGE AS APPEAL_STAGE,
    A13.APPEAL_REASON AS APPEAL_REASON,
    A13.APPEAL_PRIORITY AS APPEAL_PRIORITY,
    A13.APPEAL_PART AS APPEAL_PART,
    A13.APPEAL_ITEM AS APPEAL_ITEM,
    A13.APPEAL_ISSUE AS APPEAL_ISSUE,
    TRUNC(CAST(A13.DEADLINE_DATE AS DATE)) AS DEADLINE_DATE,
    A13.ADJUDICATOR AS ADJUDICATOR,
    SUM(A11.CREATION_COUNT) AS CREATION_COUNT,
    SUM(A11.INVENTORY_COUNT) AS INVENTORY_COUNT,
    SUM(A11.COMPLETION_COUNT) AS COMPLETION_COUNT,
    SUM(A11.CANCELLATION_COUNT) AS CANCELLATION_COUNT,
    SUM(A11.TERMINATION_COUNT) AS TERMINATION_COUNT,
    SUM(A11.HANDLE_TIME) AS HANDLE_TIME,
    SUM(CASE WHEN A12.TIMELINESS_STATUS IN ('Timely') THEN 1 ELSE 0 END) AS TASK_TIMELINESS_COUNT,
    SUM(CASE WHEN A12.TIMELINESS_STATUS IN ('Untimely') THEN 1 ELSE 0 END) AS TASK_UNTIMELINESS_COUNT,
    SUM(CASE WHEN A12.JEOPARDY_FLAG IN ('Y') THEN 1 ELSE 0 END) AS TASK_JEOPARDY_COUNT,
    SUM(A12.TASK_CLAIMED_TIME) AS TOTAL_CLAIMED_TIME,
    SUM(A12.TASK_UNCLAIMED_TIME) AS TOTAL_UNCLAIMED_TIME
FROM MAXDAT.F_MW_TASK_INSTANCE_BY_DATE_SV A11
LEFT OUTER JOIN MAXDAT.D_MW_TASK_INSTANCE_SV A12
    ON A11.MW_BI_ID = A12.MW_BI_ID
LEFT OUTER JOIN MAXDAT.D_MW_APPEAL_INSTANCE_SV A13
    ON A12.SOURCE_REFERENCE_ID = A13.APPEAL_ID
LEFT OUTER JOIN MAXDAT.D_TASK_TYPES_SV A16
    ON A12.PREVIOUS_TASK_TYPE_ID = A16.TASK_TYPE_ID
LEFT OUTER JOIN MAXDAT.D_TASK_TYPES_SV A17
    ON A12.TASK_TYPE_ID = A17.TASK_TYPE_ID
WHERE A11.D_DATE >= TRUNC((SYSDATE - (select value from corp_etl_control where name = 'APPEAL_CUBE_SPAN')),'MONTH')
AND A11.d_date < TRUNC((SYSDATE - trunc((select value from corp_etl_control where name = 'APPEAL_CUBE_SPAN')/2)),'MONTH')
GROUP BY A11.D_DATE,
    A12.TASK_TYPE_ID,
    A17.TASK_NAME,
    A12.CURR_TASK_STATUS,
    A12.TASK_PRIORITY,
    A12.PREVIOUS_TASK_TYPE_ID,
    A16.TASK_NAME,
    A13.APPEAL_TYPE,
    A13.APPEAL_STATUS,
    A13.APPEAL_STAGE,
    A13.APPEAL_REASON,
    A13.APPEAL_PRIORITY,
    A13.APPEAL_PART,
    A13.APPEAL_ITEM,
    A13.APPEAL_ISSUE,
    TRUNC(CAST(A13.DEADLINE_DATE AS DATE)),
    A13.ADJUDICATOR;



GRANT SELECT ON APPEAL_TASKS_BY_DAY_MV TO MAXDAT_READ_ONLY;
    
CREATE OR REPLACE VIEW APPEAL_TASKS_BY_DAY_VW as    
SELECT  A11.D_DATE AS D_DATE,
    A12.TASK_TYPE_ID AS TASK_TYPE_ID,
    A17.TASK_NAME AS TASK_TYPE,
    A12.CURR_TASK_STATUS AS CURR_TASK_STATUS,
    A12.TASK_PRIORITY AS TASK_PRIORITY,
    A12.PREVIOUS_TASK_TYPE_ID AS PREVIOUS_TASK_TYPE_ID,
    A16.TASK_NAME AS PREVIOUS_TASK_TYPE,
    A13.APPEAL_TYPE AS APPEAL_TYPE,
    A13.APPEAL_STATUS AS APPEAL_STATUS,
    A13.APPEAL_STAGE AS APPEAL_STAGE,
    A13.APPEAL_REASON AS APPEAL_REASON,
    A13.APPEAL_PRIORITY AS APPEAL_PRIORITY,
    A13.APPEAL_PART AS APPEAL_PART,
    A13.APPEAL_ITEM AS APPEAL_ITEM,
    A13.APPEAL_ISSUE AS APPEAL_ISSUE,
    TRUNC(CAST(A13.DEADLINE_DATE AS DATE)) AS DEADLINE_DATE,
    A13.ADJUDICATOR AS ADJUDICATOR,
    SUM(A11.CREATION_COUNT) AS CREATION_COUNT,
    SUM(A11.INVENTORY_COUNT) AS INVENTORY_COUNT,
    SUM(A11.COMPLETION_COUNT) AS COMPLETION_COUNT,
    SUM(A11.CANCELLATION_COUNT) AS CANCELLATION_COUNT,
    SUM(A11.TERMINATION_COUNT) AS TERMINATION_COUNT,
    SUM(A11.HANDLE_TIME) AS HANDLE_TIME,
    SUM(CASE WHEN A12.TIMELINESS_STATUS IN ('Timely') THEN 1 ELSE 0 END) AS TASK_TIMELINESS_COUNT,
    SUM(CASE WHEN A12.TIMELINESS_STATUS IN ('Untimely') THEN 1 ELSE 0 END) AS TASK_UNTIMELINESS_COUNT,
    SUM(CASE WHEN A12.JEOPARDY_FLAG IN ('Y') THEN 1 ELSE 0 END) AS TASK_JEOPARDY_COUNT,
    SUM(A12.TASK_CLAIMED_TIME) AS TOTAL_CLAIMED_TIME,
    SUM(A12.TASK_UNCLAIMED_TIME) AS TOTAL_UNCLAIMED_TIME
FROM MAXDAT.F_MW_TASK_INSTANCE_BY_DATE_SV A11
LEFT OUTER JOIN MAXDAT.D_MW_TASK_INSTANCE_SV A12
    ON A11.MW_BI_ID = A12.MW_BI_ID
LEFT OUTER JOIN MAXDAT.D_MW_APPEAL_INSTANCE_SV A13
    ON A12.SOURCE_REFERENCE_ID = A13.APPEAL_ID
LEFT OUTER JOIN MAXDAT.D_TASK_TYPES_SV A16
    ON A12.PREVIOUS_TASK_TYPE_ID = A16.TASK_TYPE_ID
LEFT OUTER JOIN MAXDAT.D_TASK_TYPES_SV A17
    ON A12.TASK_TYPE_ID = A17.TASK_TYPE_ID
WHERE A11.d_date >= TRUNC(sysdate) - (select value from corp_etl_control where name = 'APPEAL_CUBE_LOOK_BACK_DAYS')
GROUP BY A11.D_DATE,
    A12.TASK_TYPE_ID,
    A17.TASK_NAME,
    A12.CURR_TASK_STATUS,
    A12.TASK_PRIORITY,
    A12.PREVIOUS_TASK_TYPE_ID,
    A16.TASK_NAME,
    A13.APPEAL_TYPE,
    A13.APPEAL_STATUS,
    A13.APPEAL_STAGE,
    A13.APPEAL_REASON,
    A13.APPEAL_PRIORITY,
    A13.APPEAL_PART,
    A13.APPEAL_ITEM,
    A13.APPEAL_ISSUE,
    TRUNC(CAST(A13.DEADLINE_DATE AS DATE)),
    A13.ADJUDICATOR
    union all 
    select * from APPEAL_TASKS_BY_DAY_MV;

GRANT SELECT ON APPEAL_TASKS_BY_DAY_VW TO MAXDAT_READ_ONLY; 




CREATE OR REPLACE PROCEDURE refresh_appeal_cube_material_views
AS
BEGIN
  dbms_mview.refresh('APPEAL_DETAILS_BY_DAY_MV','?');
  dbms_mview.refresh('APPEAL_TASKS_BY_DAY_MV','?');
  dbms_mview.refresh('APPEAL_STAFF_PERFORMANCE_BY_DAY_MV','?');
END;

BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'REFRESH_APPEAL_CUBE_MVIEWS',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'REFRESH_APPEAL_CUBE_MATERIAL_VIEWS',
   start_date         =>  '15-SEP-19 12.05.00 AM',
   repeat_interval    =>  'FREQ=DAILY;INTERVAL=01',
   end_date           =>  '30-SEP-25 12.00.00 AM',
   auto_drop          =>   FALSE,
 --  job_class          =>  'batch_update_jobs',
   comments           =>  'To refresh the materialzed views for fedqic appeal cubes');
END;
/

begin
dbms_scheduler.enable('REFRESH_APPEAL_CUBE_MVIEWS');
end;
/
begin
DBMS_SCHEDULER.SET_ATTRIBUTE('REFRESH_APPEAL_CUBE_MVIEWS','logging_level',DBMS_SCHEDULER.LOGGING_FAILED_RUNS);
end;
/
    