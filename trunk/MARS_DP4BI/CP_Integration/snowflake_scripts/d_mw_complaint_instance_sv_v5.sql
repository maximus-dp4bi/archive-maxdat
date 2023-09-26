CREATE OR REPLACE VIEW MARS_DP4BI_DEV.PUBLIC.MW_D_COMPLAINT_INSTANCE_SV AS
SELECT  ts.PROJECT_ID
       ,ts.TASK_ID AS complaint_id
 	   ,ts.CREATED_ON AS complaint_create_date_time	   
       ,ts.TASK_TYPE_ID AS complaint_type_id
       ,ts.DEFAULT_PRIORITY AS complaint_priority
       ,ts.SOURCE AS complaint_source
	   ,ts.task_status AS complaint_status
       ,ts.STATUS_DATE AS complaint_status_date_time
	   ,ts.TASK_INFO AS complaint_info
       ,ts.TASK_NOTES AS complaint_notes
	   ,NULL AS complaint_association
       ,ts.CREATED_BY AS complaint_created_by_user_id
       ,pr.PROJECT_ROLE_ID AS complaint_created_by_user_role
       ,CASE WHEN ts.TASK_STATUS IN('Complete','Cancelled') THEN NULL ELSE ts.STAFF_ASSIGNED_TO END AS complaint_assignee_user_id
       ,CASE WHEN ts.TASK_STATUS IN('Complete','Cancelled') THEN NULL ELSE satpr.PROJECT_ROLE_ID END AS complaint_assignee_user_role
       ,tt.SLA_DAYS AS complaint_sla_days       
       ,tt.SLA_DAYS_TYPE AS complaint_sla_type
       ,CASE WHEN ts.TASK_STATUS IN('Complete','Cancelled') THEN NULL 
             WHEN ts.STAFF_ASSIGNED_TO IS NOT NULL THEN 'CLAIMED'
         ELSE 'UNCLAIMED' END AS complaint_claimed_status    
       ,CASE WHEN ts.TASK_STATUS IN('Complete','Cancelled') THEN ts.STAFF_ASSIGNED_TO ELSE NULL END AS complaint_worked_by_user_id
       ,CASE WHEN ts.TASK_STATUS IN('Complete','Cancelled') THEN satpr.PROJECT_ROLE_ID ELSE NULL END AS complaint_worked_by_user_role
       ,CASE WHEN ts.TASK_STATUS = 'Complete' THEN ts.STATUS_DATE ELSE NULL END AS complaint_complete_date_time
       ,ttw.total_time_worked AS total_time_worked
       ,exo.source_reference_type
       ,exo.source_reference_id  
       ,CASE WHEN ts.ESCALATED_FLAG = 1 THEN 'Y' ELSE 'N' END AS complaint_flag
       ,CASE WHEN ts.ESCALATED_FLAG = 1 THEN thesc.escalated_to_user_id ELSE NULL END AS complaint_escalated_to_user_id
       ,CASE WHEN tt.SLA_DAYS_TYPE = 'B' THEN
          (SELECT CASE WHEN (COUNT(*)-1) < 0 THEN 0 ELSE COUNT(*)-1 END
           FROM D_DATES
           WHERE d_dates.PROJECT_ID = ts.PROJECT_ID
           AND business_day_flag = 'Y'
           AND d_date BETWEEN DATE_TRUNC('DAY',ts.CREATED_ON) 
           AND (CASE WHEN ts.TASK_STATUS IN('Complete','Cancelled') THEN DATE_TRUNC('DAY',ts.STATUS_DATE) ELSE CURRENT_DATE() END) )
         ELSE DATEDIFF('DAY',ts.CREATED_ON,CASE WHEN ts.TASK_STATUS IN('Complete','Cancelled') THEN DATE_TRUNC('DAY',ts.STATUS_DATE) ELSE CURRENT_DATE() END)  END AS complaint_age
       ,tt.SLA_DAYS_TYPE AS complaint_age_type 
       ,CASE WHEN ts.TASK_STATUS IN('Complete') THEN 
          CASE WHEN tt.SLA_DAYS_TYPE = 'B' THEN 
                (SELECT CASE WHEN (COUNT(*)-1) < 0 THEN 0 ELSE COUNT(*)-1 END
                 FROM D_DATES
                 WHERE d_dates.PROJECT_ID = ts.PROJECT_ID
                 AND business_day_flag = 'Y'
                 AND d_date BETWEEN DATE_TRUNC('DAY',ts.CREATED_ON) AND DATE_TRUNC('DAY',ts.STATUS_DATE) ) 
          ELSE DATEDIFF('DAY',ts.CREATED_ON,ts.STATUS_DATE) END 
        ELSE NULL END complaint_cycle_time 
       ,COALESCE(tdcr.SELECTION_VARCHAR,tdcrh.SELECTION_VARCHAR) AS complaint_reason
       ,COALESCE(tdca.SELECTION_VARCHAR,tdcah.SELECTION_VARCHAR) AS complaint_about 
       ,CASE WHEN ts.TASK_STATUS = 'Cancelled' THEN ts.STATUS_DATE ELSE NULL END AS complaint_cancel_date_time
       ,ts.UPDATED_ON AS complaint_update_date_time
       ,ts.TASK_DISPOSITION AS complaint_disposition
FROM (SELECT project_id,task_id,task_type_id,default_priority,task_status,status_date,staff_worked_by,staff_assigned_to
               ,escalated_flag,staff_forward_by,source,task_info,task_notes,action_taken,task_disposition
               ,created_on,created_by,updated_on,updated_by,edit_reason,hold_reason,cancel_reason, 1 thsrank 
        FROM MARSDB.MARSDB_TASKS_VW AS ts
        UNION ALL
        SELECT *
        FROM(SELECT project_id,task_id,task_type_id,default_priority,task_status,status_date,staff_worked_by,staff_assigned_to,
               CASE WHEN EXISTS(SELECT 1 FROM MARSDB.MARSDB_TASKS_HISTORY_VW th
                                WHERE th.TASK_ID = ths.TASK_ID AND th.PROJECT_ID = ths.PROJECT_ID
                                AND th.TASK_STATUS = 'Escalated') THEN 1 ELSE 0 END escalated_flag
               ,staff_forward_by,source,task_info,task_notes,action_taken,task_disposition
               ,created_on,created_by,updated_on,updated_by,edit_reason,hold_reason,cancel_reason
               ,RANK() OVER (PARTITION BY ths.PROJECT_ID, ths.TASK_ID ORDER BY ths.TASK_HISTORY_ID DESC) thsrank
             FROM MARSDB.MARSDB_TASKS_HISTORY_VW ths             
             WHERE task_status = 'Complete') ths
        WHERE thsrank = 1)  ts
 LEFT JOIN  MARSDB.CFG_TASK_TYPE tt ON  ts.TASK_TYPE_ID = tt.TASK_TYPE_ID 
 LEFT JOIN MARSDB.MARSDB_TASK_DETAIL_VW tdca ON ts.task_id = tdca.task_id AND ts.project_id = tdca.project_id AND tdca.task_field_name = 'Complaint About'
 LEFT JOIN MARSDB.MARSDB_TASK_DETAIL_VW tdcr ON ts.task_id = tdcr.task_id AND ts.project_id = tdcr.project_id AND tdcr.task_field_name = 'Reason'
 LEFT JOIN (SELECT *
            FROM (SELECT task_id, task_field_name,project_id, selection_varchar,RANK() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcarn
                  FROM MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                  WHERE task_field_name = 'Complaint About') r
            WHERE tdcarn = 1 ) tdcah ON ts.TASK_ID = tdcah.TASK_ID AND ts.project_id = tdcah.project_id 
 LEFT JOIN (SELECT *
            FROM (SELECT task_id, task_field_name,project_id, selection_varchar,RANK() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                  FROM MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                  WHERE task_field_name = 'Reason') r
            WHERE tdcrn = 1 ) tdcrh ON ts.TASK_ID = tdcrh.TASK_ID AND ts.project_id = tdcrh.project_id
 LEFT JOIN MARSDB.MARSDB_PROJECT_VW p ON p.PROJECT_ID = ts.PROJECT_ID
 LEFT JOIN MARSDB.MARSDB_USER_VW cu ON ts.CREATED_BY = TO_CHAR(cu.USER_ID)  
 LEFT JOIN (SELECT * FROM 
             (SELECT upr.user_id, upr.project_role_id, RANK() OVER (PARTITION BY upr.user_id ORDER BY upr.created_on DESC) rnk
              FROM MARSDB.MARSDB_USER_PROJECT_ROLE_VW upr 
              WHERE upr.IS_DEFAULT = 1 AND COALESCE(upr.END_DATE,CURRENT_DATE()) >= CURRENT_DATE()) 
            WHERE rnk = 1) upr ON cu.USER_ID = upr.USER_ID 
 LEFT JOIN MARSDB.MARSDB_PROJECT_ROLE_VW pr ON upr.PROJECT_ROLE_ID = pr.PROJECT_ROLE_ID AND pr.PROJECT_ID = p.PROJECT_ID
 LEFT JOIN MARSDB.MARSDB_USER_VW satu ON ts.STAFF_ASSIGNED_TO = TO_CHAR(satu.USER_ID) 
 LEFT JOIN (SELECT * FROM 
             (SELECT upr.user_id, upr.project_role_id, RANK() OVER (PARTITION BY upr.user_id ORDER BY upr.created_on DESC) rnk
              FROM MARSDB.MARSDB_USER_PROJECT_ROLE_VW upr 
              WHERE upr.IS_DEFAULT = 1 AND COALESCE(upr.END_DATE,CURRENT_DATE()) >= CURRENT_DATE()) 
            WHERE rnk = 1) satupr ON satu.USER_ID = satupr.USER_ID 
 LEFT JOIN MARSDB.MARSDB_PROJECT_ROLE_VW satpr ON satupr.PROJECT_ROLE_ID = satpr.PROJECT_ROLE_ID AND satpr.PROJECT_ID = p.PROJECT_ID
 -- getting the latest linked reference				    
 LEFT JOIN (SELECT *
             FROM(SELECT ex.PROJECT_ID,ex.INTERNAL_ID,ex.EXTERNAL_REF_ID AS source_reference_id,ex.EXTERNAL_REF_TYPE AS source_reference_type
                 		,RANK() OVER (PARTITION BY ex.PROJECT_ID,ex.INTERNAL_ID ORDER BY ex.EXTERNAL_LINK_ID DESC) exrank
	 	 		  FROM MARSDB.MARSDB_EXTERNAL_LINKS_VW ex
			  	  WHERE UPPER(ex.INTERNAL_REF_TYPE) = 'TASK'
			      AND UPPER(ex.EXTERNAL_REF_TYPE) NOT IN('CONSUMER','CASE')
			      AND ex.EFFECTIVE_END_DATE IS NULL	) tmp
			  WHERE exrank = 1) exo ON exo.INTERNAL_ID = ts.TASK_ID AND exo.PROJECT_ID = ts.PROJECT_ID
 -- get total time worked
 LEFT JOIN (SELECT PROJECT_ID, TASK_ID, SUM(IFF(TASK_STATUS = 'In-Progress', time_elapsed, NULL)) AS total_time_worked
                FROM(SELECT PROJECT_ID,TASK_ID,TASK_STATUS,                                 
                        DATEDIFF('seconds', UPDATED_ON, COALESCE((LEAD(UPDATED_ON) OVER (PARTITION BY PROJECT_ID,TASK_ID ORDER BY PROJECT_ID, TASK_ID, UPDATED_ON, LOG_CREATED_ON)),CURRENT_DATE()) ) AS time_elapsed
                     FROM MARSDB.MARSDB_TASKS_HISTORY_VW) th
                GROUP BY PROJECT_ID, TASK_ID) ttw ON ts.TASK_ID = ttw.TASK_ID AND ts.PROJECT_ID = ttw.PROJECT_ID 
 --get escalated to/by staff
 LEFT JOIN (SELECT *
            FROM(SELECT th.TASK_ID,th.PROJECT_ID,th.TASK_HISTORY_ID,th.UPDATED_ON,th.STAFF_ASSIGNED_TO AS escalated_to_user_id,
                      task_escalated_ts,escalated_by_user_id
                      ,RANK() OVER (PARTITION BY th.PROJECT_ID,th.TASK_ID ORDER BY th.task_history_id DESC) thrank                     
                 FROM MARSDB.MARSDB_TASKS_HISTORY_VW th
                   JOIN (SELECT *
                         FROM (SELECT the.TASK_HISTORY_ID AS escalated_hist_id, the.PROJECT_ID,the.TASK_ID, the.UPDATED_ON AS task_escalated_ts,the.UPDATED_BY AS escalated_by_user_id,                               
                                RANK() OVER (PARTITION BY the.PROJECT_ID,the.TASK_ID ORDER BY the.task_history_id DESC) esrank
                            FROM MARSDB.MARSDB_TASKS_HISTORY_VW the                               
                            WHERE the.TASK_STATUS = 'Escalated') tmp
                         WHERE esrank = 1) the ON th.TASK_ID = the.TASK_ID AND th.PROJECT_ID = the.PROJECT_ID                     
                 WHERE th.STAFF_ASSIGNED_TO IS NOT NULL
                 AND th.TASK_STATUS = 'In-Progress'             
                 AND th.TASK_HISTORY_ID > the.escalated_hist_id ) tmp
            WHERE thrank = 1) thesc ON ts.TASK_ID = thesc.TASK_ID AND ts.PROJECT_ID = thesc.PROJECT_ID    
WHERE tt.TASK_NAME = 'Review Complaint' ;