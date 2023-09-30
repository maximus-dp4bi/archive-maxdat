CREATE OR REPLACE VIEW PUBLIC.MW_F_TASK_INSTANCE_BY_DAY_SV AS
SELECT d_date
  ,PROJECT_ID
  ,TASK_ID AS MW_BI_ID
  ,TASK_ID 
  ,TASK_TYPE_ID
  ,TASK_TYPE_NAME
  ,TASK_TYPE_DESCRIPTION
  ,OPERATIONS_GROUP
  ,TASK_SLA_DAYS
  ,TASK_SLA_TYPE
  ,TASK_SLA_TARGET_DAYS
  ,TASK_SLA_JEOPARDY_DAYS
  ,TASK_PRIORITY
  ,TASK_SOURCE
  ,TASK_STATUS
  ,TASK_DISPOSITION
  ,TASK_CLAIM_STATUS
  ,TEAM_SUPERVISOR
  ,SUM(creation_count) creation_count
  ,SUM(completion_count) completion_count
  ,SUM(inventory_count) inventory_count
  ,SUM(cancellation_count) cancellation_count
  ,SUM(termination_count) termination_count
  ,AGE_IN_BUSINESS_DAYS
  ,COMPLETE_DATE_TIME
  ,CANCEL_WORK_DATE_TIME
FROM(
 SELECT DISTINCT d.d_date 
    ,TS.TASK_ID 
    ,TS.PROJECT_ID
    ,TS.TASK_TYPE_ID
    ,TT.TASK_NAME AS TASK_TYPE_NAME
    ,TT.TASK_DESCRIPTION AS TASK_TYPE_DESCRIPTION
    ,TT.OPERATIONS_GROUP
    ,TT.SLA_DAYS AS TASK_SLA_DAYS
    ,TT.SLA_DAYS_TYPE AS TASK_SLA_TYPE
    ,TT.SLA_TARGET_DAYS AS TASK_SLA_TARGET_DAYS
    ,TT.SLA_JEOPARDY_DAYS AS TASK_SLA_JEOPARDY_DAYS
    ,TS.DEFAULT_PRIORITY TASK_PRIORITY
    ,TS.SOURCE TASK_SOURCE
    ,TS.TASK_STATUS
    ,TS.TASK_DISPOSITION
    ,TS.TEAM_SUPERVISOR
    ,CASE WHEN TS.TASK_STATUS IN('Complete','Cancelled') THEN NULL ELSE
       CASE WHEN TS.STAFF_ASSIGNED_TO IS NOT NULL THEN 'CLAIMED' ELSE 'UNCLAIMED' END END AS TASK_CLAIM_STATUS
    ,CASE WHEN TS.TASK_STATUS = 'Complete' AND d.d_date = TO_DATE(TS.STATUS_DATE) THEN 0 ELSE 1 END AS inventory_count
    ,CASE WHEN d_date = TO_DATE(TS.CREATED_ON) THEN 1 ELSE 0 END creation_count
    ,CASE WHEN TS.TASK_STATUS = 'Complete' AND d.d_date = TO_DATE(TS.STATUS_DATE) THEN 1 ELSE 0 END AS completion_count
    ,CASE WHEN TS.TASK_STATUS = 'Cancelled' AND d.d_date = TO_DATE(TS.STATUS_DATE) THEN 1 ELSE 0 END AS cancellation_count
    ,CASE WHEN TS.TASK_STATUS IN('Complete','Cancelled') AND d.d_date = TO_DATE(TS.STATUS_DATE) THEN 1 ELSE 0 END AS termination_count
    ,CASE WHEN ts.TASK_STATUS = 'Complete' THEN ts.STATUS_DATE ELSE NULL END AS complete_date_time    
    ,(SELECT CASE WHEN (COUNT(*)-1) < 0 THEN 0 ELSE COUNT(*)-1 END
      FROM D_DATES
      WHERE d_dates.PROJECT_ID = ts.PROJECT_ID
      AND d_dates.business_day_flag = 'Y'
      AND d_dates.d_date BETWEEN TO_DATE(ts.CREATED_ON) 
      AND (CASE WHEN ts.TASK_STATUS IN('Complete','Cancelled') THEN 
            CASE WHEN d.d_date < TO_DATE(ts.STATUS_DATE) THEN d.d_date ELSE TO_DATE(ts.STATUS_DATE) END ELSE d.d_date END) ) age_in_business_days
    ,CASE WHEN ts.TASK_STATUS = 'Cancelled' THEN ts.STATUS_DATE ELSE NULL END AS cancel_work_date_time                
FROM PUBLIC.D_DATES d
  JOIN (SELECT ts.project_id,ts.task_id,ts.task_type_id,ts.default_priority,ts.task_status,ts.status_date,ts.staff_assigned_to,ts.source,ts.task_disposition,ts.created_on,ts.created_by,ts.updated_on,ts.updated_by,sato.team_supervisor
        FROM(SELECT project_id,task_id,task_type_id,default_priority,task_status,status_date,staff_assigned_to,source,task_disposition,created_on,created_by,updated_on,updated_by,1 thsrank 
             FROM MARSDB.MARSDB_TASKS_VW AS ts
             UNION ALL
             SELECT *
             FROM(SELECT project_id,task_id,task_type_id,default_priority,task_status,status_date,staff_assigned_to,source,task_disposition,created_on,created_by,updated_on,updated_by
                    ,RANK() OVER (PARTITION BY ths.PROJECT_ID, ths.TASK_ID ORDER BY ths.TASK_HISTORY_ID DESC) thsrank
                  FROM MARSDB.MARSDB_TASKS_HISTORY_VW ths             
                  WHERE task_status = 'Complete') ths
             WHERE thsrank = 1)  ts          
          LEFT JOIN (SELECT *
                     FROM(SELECT sato.USER_ID,sato.STAFF_ID,tsup.sup_user_id, tsup.team_supervisor, t.TEAM_NAME, t.TEAM_ID, t.PROJECT_ID, b.BUSINESS_UNIT_ID, b.BUSINESS_UNIT_NAME,
                            CASE WHEN sato.USER_ID = tsup.SUP_USER_ID THEN 'Supervisor' ELSE 'Non Supervisor' END owner_is_supervisor
                             ,RANK() OVER (PARTITION BY t.PROJECT_ID,sato.USER_ID ORDER BY tu.EFFECTIVE_END_DATE DESC NULLS FIRST, tu.TEAM_USER_ID) turank 
                          FROM MARSDB.MARSDB_USER_VW sato                                       
                            LEFT JOIN MARSDB.MARSDB_TEAM_USER_VW tu ON sato.USER_ID = tu.USER_ID 
                            LEFT JOIN MARSDB.MARSDB_TEAM_VW t ON tu.TEAM_ID = t.TEAM_ID 
                            LEFT JOIN MARSDB.MARSDB_BUSINESS_UNIT_VW b ON t.BUSINESS_UNIT_ID = b.BUSINESS_UNIT_ID AND t.PROJECT_ID = b.PROJECT_ID
                            LEFT JOIN (SELECT tsup.TEAM_ID, tsup.USER_ID AS sup_user_id, CONCAT(sup.FIRST_NAME,' ',sup.LAST_NAME)  team_supervisor
                                       FROM MARSDB.MARSDB_TEAM_USER_VW tsup
                                         JOIN MARSDB.MARSDB_USER_VW ust ON tsup.USER_ID = ust.USER_ID 
                                         JOIN MARSDB.MARSDB_STAFF_VW sup ON ust.STAFF_ID = sup.STAFF_ID
                                       WHERE tsup.SUPERVISOR_FLAG = 1 
                                       AND tsup.EFFECTIVE_END_DATE IS NULL) tsup ON t.TEAM_ID = tsup.TEAM_ID ) tmp
                          WHERE turank = 1) sato ON TO_CHAR(sato.USER_ID) = ts.STAFF_ASSIGNED_TO AND sato.PROJECT_ID = ts.PROJECT_ID  )ts          
     ON  d.PROJECT_ID = ts.PROJECT_ID AND d.d_date BETWEEN TO_DATE(ts.CREATED_ON) AND CASE WHEN ts.TASK_STATUS IN('Complete','Cancelled') THEN TO_DATE(ts.STATUS_DATE) ELSE CURRENT_DATE() END    
  LEFT JOIN MARSDB.CFG_TASK_TYPE TT  ON TS.TASK_TYPE_ID = TT.TASK_TYPE_ID
 )    
GROUP BY d_date
  ,MW_BI_ID
  ,PROJECT_ID
  ,TASK_TYPE_ID
  ,TASK_TYPE_NAME
  ,TASK_TYPE_DESCRIPTION
  ,OPERATIONS_GROUP
  ,TASK_SLA_DAYS
  ,TASK_SLA_TYPE
  ,TASK_SLA_TARGET_DAYS
  ,TASK_SLA_JEOPARDY_DAYS
  ,TASK_PRIORITY
  ,TASK_SOURCE
  ,TASK_STATUS
  ,TASK_DISPOSITION
  ,TASK_CLAIM_STATUS
  ,TEAM_SUPERVISOR
  ,AGE_IN_BUSINESS_DAYS
  ,COMPLETE_DATE_TIME
  ,CANCEL_WORK_DATE_TIME; 