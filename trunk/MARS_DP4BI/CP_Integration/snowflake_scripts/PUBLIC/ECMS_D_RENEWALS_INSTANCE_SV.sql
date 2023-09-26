use database MARS_DP4BI_DEV;
use database MARS_DP4BI_UAT;

use schema public;

CREATE OR REPLACE VIEW ECMS_D_RENEWALS_INSTANCE_SV AS
WITH ts AS
(
    SELECT  t.*
            ,tt.task_type_name
            ,cfg.sla_days
            ,cfg.sla_days_type
      FROM  (
                SELECT  ts.project_id,
                        task_id,
                        ts.task_type_id,
                        default_priority,
                        task_status,
                        status_date,
                        staff_worked_by,
                        staff_assigned_to,
                        escalated_flag,
                        staff_forward_by,
                        source,
                        task_info,
                        task_notes,
                        action_taken,
                        task_disposition,
                        created_on,
                        created_by,
                        updated_on,
                        updated_by,
                        edit_reason,
                        hold_reason,
                        cancel_reason, 
                        default_due_date, 
                        due_in_days, 
                        1 AS thsrank 
                  FROM  MARSDB.MARSDB_TASKS_VW  ts
                  UNION ALL
                  SELECT    *
                    FROM    (
                                SELECT  ths.project_id,
                                        task_id,
                                        ths.task_type_id,
                                        default_priority,
                                        task_status,
                                        status_date,
                                        staff_worked_by,
                                        staff_assigned_to,
                                        CASE    WHEN    EXISTS  (
                                                                    SELECT  1 
                                                                      FROM  MARSDB.MARSDB_TASKS_HISTORY_VW th
                                                                     WHERE  th.TASK_ID      =   ths.TASK_ID 
                                                                       AND  th.PROJECT_ID   =   ths.PROJECT_ID
                                                                       AND  th.TASK_STATUS  =   'Escalated'
                                                                ) 
                                                THEN    1 
                                                ELSE    0 
                                        END AS escalated_flag,
                                        staff_forward_by,
                                        source,
                                        task_info,
                                        task_notes,
                                        action_taken,
                                        task_disposition,
                                        created_on,
                                        created_by,
                                        updated_on,
                                        updated_by,
                                        edit_reason,
                                        hold_reason,cancel_reason,
                                        default_due_date, 
                                        due_in_days,
                                        RANK() OVER (PARTITION BY ths.PROJECT_ID, ths.TASK_ID ORDER BY ths.TASK_HISTORY_ID DESC) thsrank
                                  FROM  MARSDB.MARSDB_TASKS_HISTORY_VW  ths             
                                 WHERE  task_status = 'Complete'
                            )   ths
                   WHERE    thsrank = 1       
            )   t
            JOIN
            MARSDB.MARSDB_TASK_TYPE_VW  tt
            ON
            (
                    t.task_type_id  =   tt.task_type_id
            )
            LEFT JOIN
            MARSDB.CFG_TASK_TYPE    cfg
            ON
            (   
                    t.task_type_id = cfg.task_type_id   
            )
     WHERE  t.task_type_id IN (13475)       
),
user_info AS
(
    SELECT  usv.*
            ,upr.user_project_role_id
            ,upr.project_role_id
            ,pr.role_name  
      FROM  D_USER_SV   usv
            INNER JOIN 
            (
                SELECT  * 
                  FROM  (
                            SELECT  upr.user_id
                                    ,upr.user_project_role_id
                                    ,upr.project_role_id
                                    ,RANK() OVER (PARTITION BY upr.user_id ORDER BY upr.created_on DESC) rnk
                              FROM  MARSDB.MARSDB_USER_PROJECT_ROLE_VW  upr 
                             WHERE  upr.is_default = 1 
                               AND  COALESCE(upr.end_date,CURRENT_DATE()) >= CURRENT_DATE()
                        ) 
                 WHERE  rnk = 1
            )   upr 
            ON 
            (
                    usv.user_id = upr.user_id
            )
            INNER JOIN 
            MARSDB.MARSDB_PROJECT_ROLE_VW    pr
            ON 
            (   
                    pr.project_role_id = upr.project_role_id    
            )
     WHERE  usv.user_project_id = 419
       AND  pr.project_id = 419
)
SELECT  sr.service_request_id                                               AS  renewal_id       
        ,ts.created_on::DATE                                                AS  renewal_create_date
        ,ts.created_on::TIME                                                AS  renewal_create_time
        ,'TBD'                                                              AS  renewal_type
        ,ts.default_priority                                                AS  renewal_priority
	    ,ts.task_status                                                     AS  renewal_status
        ,ts.status_date                                                     AS  renewal_status_date  
	    ,ts.task_info                                                       AS  renewal_info      
        ,ts.task_notes                                                      AS  renewal_notes   
	    ,cbs.benefit_status                                                 AS  renewal_association         
        ,cb.user_id                                                         AS  renewal_created_by_user_id
        ,cb.maximus_id                                                      AS  renewal_created_by_maximus_id
        ,cb.first_name                                                      AS  renewal_created_by_first_name
        ,cb.last_name                                                       AS  renewal_created_by_last_name
        ,cb.business_unit_id                                                AS  renewal_created_by_business_unit_id
        ,cb.business_unit_name                                              AS  renewal_created_by_business_unit_name
        ,cb.project_role_id                                                 AS  renewal_created_by_user_role_id
        ,cb.role_name                                                       AS  renewal_created_by_user_role_name        
        ,ub.user_id                                                         AS  renewal_updated_by_user_id
        ,ub.maximus_id                                                      AS  renewal_updated_by_maximus_id
        ,ub.first_name                                                      AS  renewal_updated_by_first_name
        ,ub.last_name                                                       AS  renewal_updated_by_last_name
        ,ub.business_unit_id                                                AS  renewal_updated_by_business_unit_id
        ,ub.business_unit_name                                              AS  renewal_updated_by_business_unit_name
        ,ub.project_role_id                                                 AS  renewal_updated_by_user_role_id
        ,ub.role_name                                                       AS  renewal_updated_by_user_role_name                
        ,CASE   WHEN    ts.task_status IN('Complete','Cancelled') 
                THEN    NULL 
                ELSE    ts.staff_assigned_to
         END                                                                AS  renewal_assignee_user_id
        ,asgn.maximus_id                                                    AS  renewal_assignee_maximus_id
        ,asgn.first_name                                                    AS  renewal_assignee_first_name
        ,asgn.last_name                                                     AS  renewal_assignee_last_name      
        ,asgn.business_unit_id                                              AS  renewal_assignee_business_unit_id
        ,asgn.business_unit_name                                            AS  renewal_assignee_business_unit_name
        ,CASE   WHEN    ts.task_status IN('Complete','Cancelled') 
                THEN    NULL 
                ELSE    asgn.project_role_id 
         END                                                                AS  renewal_assignee_user_role_id
        ,CASE   WHEN    ts.task_status IN('Complete','Cancelled') 
                THEN    NULL 
                ELSE    asgn.role_name
         END                                                                AS  renewal_assignee_user_role_name
        ,ts.sla_days                                                        AS  renewal_sla_days       
        ,ts.sla_days_type                                                   AS  renewal_sla_type
        ,CASE   WHEN    ts.sla_days_type = 'B' 
                THEN    (
                            SELECT  CASE    WHEN    (COUNT(*)-1) < 0 
                                            THEN    0 
                                            ELSE    COUNT(*)-1 
                                    END
                              FROM  D_DATES
                             WHERE  d_dates.project_id = ts.project_id
                               AND  business_day_flag = 'Y'
                               AND  d_date BETWEEN DATE_TRUNC('DAY',ts.created_on) 
                               AND  (
                                        CASE    WHEN    ts.task_status IN('Complete','Cancelled') 
                                                THEN    DATE_TRUNC('DAY',ts.status_date) 
                                                ELSE    CURRENT_DATE() 
                                        END
                                    ) 
                        )
                ELSE    DATEDIFF
                        (
                            'DAY'
                            ,ts.created_on
                            ,CASE   WHEN    ts.task_status IN('Complete','Cancelled') 
                                    THEN    DATE_TRUNC('DAY',ts.status_date) 
                                    ELSE    CURRENT_DATE() 
                             END
                        )  
         END                                                                AS  renewal_age
        ,ts.sla_days_type                                                   AS  renewal_age_type
        ,ts.task_disposition                                                AS  renewal_disposition
        ,CASE   WHEN    ts.task_status IN('Complete','Cancelled') 
                THEN    NULL 
                WHEN    ts.staff_assigned_to IS NOT NULL 
                THEN    'CLAIMED'
                ELSE    'UNCLAIMED' 
         END                                                                AS  renewal_claim_status    
        ,CASE   WHEN    ts.task_status IN('Complete','Cancelled') 
                THEN    ts.staff_assigned_to
                ELSE    NULL 
         END                                                                AS  renewal_worked_by_user_id
        ,wb.maximus_id                                                      AS  renewal_worked_by_maximus_id
        ,wb.first_name                                                      AS  renewal_worked_by_first_name
        ,wb.last_name                                                       AS  renewal_worked_by_last_name       
        ,wb.business_unit_id                                                AS  renewal_worked_by_business_unit_id
        ,wb.business_unit_name                                              AS  renewal_worked_by_business_unit_name
        ,CASE   WHEN    ts.task_status IN('Complete','Cancelled') 
                THEN    wb.project_role_id
                ELSE    NULL 
         END                                                                AS  renewal_worked_by_user_role_id
        ,CASE   WHEN    ts.task_status IN('Complete','Cancelled') 
                THEN    wb.role_name
                ELSE    NULL 
         END                                                                AS  renewal_worked_by_user_role_name
        ,CASE   WHEN    ts.task_status = 'Complete' 
                THEN    ts.status_date::DATE 
                ELSE    NULL 
         END                                                                AS  renewal_complete_date
        ,CASE   WHEN    ts.task_status = 'Complete' 
                THEN    ts.status_date::TIME 
                ELSE    NULL 
         END                                                                AS  renewal_complete_time
        ,ttw.total_time_worked                                              AS  total_time_worked
        ,exo.source_reference_type                                          AS  source_reference_type
        ,exo.source_reference_id                                            AS  source_reference_id
        ,CASE   WHEN    ts.escalated_flag = 1 
                THEN    'Y' 
                ELSE    'N' 
         END                                                                AS  renewal_flag       
        ,CASE   WHEN    ts.escalated_flag = 1 
                THEN    thesc.escalated_to_user_id 
                ELSE    NULL 
         END                                                                AS  renewal_escalated_to_user_id
        ,et.maximus_id                                                      AS  renewal_escalated_to_maximus_id
        ,et.first_name                                                      AS  renewal_escalated_to_first_name
        ,et.last_name                                                       AS  renewal_escalated_to_last_name  
        ,et.business_unit_id                                                AS  renewal_escalated_to_business_unit_id
        ,et.business_unit_name                                              AS  renewal_escalated_to_business_unit_name
        ,et.project_role_id                                                 AS  enrollment_escalated_to_user_role_id        
        ,et.role_name                                                       AS  enrollment_escalated_user_role_name                        
        ,CASE   WHEN    ts.task_status IN('Complete') 
                THEN    CASE    WHEN    ts.sla_days_type = 'B' 
                                THEN    (
                                            SELECT  CASE    WHEN    (COUNT(*)-1) < 0 
                                                            THEN    0 
                                                            ELSE    COUNT(*)-1 
                                                    END
                                              FROM  D_DATES
                                             WHERE  d_dates.project_id = ts.project_id
                                               AND  business_day_flag = 'Y'
                                               AND  d_date BETWEEN DATE_TRUNC('DAY',ts.created_on) AND DATE_TRUNC('DAY',ts.status_date)) 
                                ELSE    DATEDIFF('DAY',ts.created_on,ts.status_date) 
                        END 
                ELSE    NULL 
         END                                                                AS  renewal_cycle_time  
        ,COALESCE(tdrr.selection_varchar,tdrrh.selection_varchar)           AS  renewal_reason
        ,'TBD'                                                              AS  renewal_about  
        ,COALESCE(tdmm.selection_varchar,tdmmh.selection_varchar)           AS  mmis_member_id
        ,COALESCE(TO_CHAR(tdec.selection_numeric),tdech.selection_varchar)  AS  external_case_id
        ,COALESCE(tdbu.selection_varchar,tdbuh.selection_varchar)           AS  business_unit        
        ,COALESCE(tdl.selection_varchar,tdlh.selection_varchar)             AS  locality
        ,ts.default_due_date                                                AS  due_date
        ,ts.due_in_days                                                     AS  due_in
        ,ts.task_id                                                         AS  task_id
        ,ts.task_type_id                                                    AS  task_type_id
        ,COALESCE(tdat.selection_varchar,tdath.selection_varchar)           AS  action_taken
        ,'TBD'                                                              AS  appointment_date
        ,'TBD'                                                              AS  appointment_time        
        ,COALESCE(tcwfn.selection_varchar,tcwfnh.selection_varchar)         AS  case_worker_first_name
        ,COALESCE(tcwln.selection_varchar,tcwlnh.selection_varchar)         AS  case_worker_last_name
        ,COALESCE(tcr.selection_varchar,tcrh.selection_varchar)             AS  contact_reason
        ,COALESCE(tdch.selection_varchar,tdchh.selection_varchar)           AS  channel
        ,COALESCE(cr.consumer_dob, con.consumer_date_of_birth)              AS  date_of_birth
        ,COALESCE(cr.consumer_first_name, con.consumer_first_name)          AS  from_first_name
        ,COALESCE(cr.consumer_last_name, con.consumer_last_name)            AS  from_last_name
        ,cr.consumer_email_address                                          AS  from_email
        ,cr.consumer_phone_number                                           AS  from_phone    
        ,ic.inbound_correspondence_id                                       AS  inbound_correspondence_id
        ,ic.correspondence_type                                             AS  inbound_correspondence_type
        ,'TBD'                                                              AS  inbound_correspondence_workable_flag
        ,COALESCE(tdit.selection_varchar, tdith.selection_varchar)          AS  information_type
        ,COALESCE(tdiar.selection_varchar, tdiarh.selection_varchar)        AS  invalid_address_reason
        ,COALESCE(tdnal1.selection_varchar, tdnal1h.selection_varchar)      AS  new_address_line_1
        ,COALESCE(tdnal2.selection_varchar, tdnal2h.selection_varchar)      AS  new_address_line_2
        ,COALESCE(tdnac.selection_varchar, tdnach.selection_varchar)        AS  new_address_city
        ,COALESCE(tdnas.selection_varchar, tdnash.selection_varchar)        AS  new_address_state
        ,COALESCE(tdnazc.selection_varchar, tdnazch.selection_varchar)      AS  new_address_zip_code
        ,'TBD'                                                              AS  old_address_line_1
        ,'TBD'                                                              AS  old_address_line_2
        ,'TBD'                                                              AS  old_address_city
        ,'TBD'                                                              AS  old_address_state
        ,'TBD'                                                              AS  old_address_zip_code
        ,'TBD'                                                              AS  notification_id
        ,'TBD'                                                              AS  outreach_location
        ,'TBD'                                                              AS  plan_effective_end_date
        ,'TBD'                                                              AS  plan_change_reason
        ,enr.plan_id                                                        AS  plan_id
        ,'TBD'                                                              AS  plan_name
        ,'TBD'                                                              AS  plan_start_date
        ,COALESCE(tdpcbdt.selection_date_time, 
                  tdpcbdth.selection_date_time)::DATE                       AS  preferred_call_back_date
        ,COALESCE(tdpcbdt.selection_date_time, 
                  tdpcbdth.selection_date_time)::TIME                       AS  preferred_call_back_time
        ,COALESCE(tdpl.selection_varchar, tdplh.selection_varchar)          AS  preferred_language
        ,COALESCE(tdpp.selection_varchar, tdpph.selection_varchar)          AS  preferred_phone
        ,COALESCE(tdpr.selection_varchar, tdprh.selection_varchar)          AS  program
        ,ep.provider_address_line_1                                         AS  provider_address_line_1
        ,ep.provider_address_line_2                                         AS  provider_address_line_2
        ,ep.provider_address_city                                           AS  provider_address_city
        ,ep.provider_address_state                                          AS  provider_address_state
        ,ep.provider_zipcode_main                                           AS  provider_zipcode_main
        ,ep.provider_zipcode_extn                                           AS  provider_zipcode_extn
        ,COALESCE
         (
            COALESCE(tdpvfn.selection_varchar, tdpvfnh.selection_varchar)
            ,ep.provider_first_name
         )                                                                  AS  provider_first_name
        ,COALESCE
         (
            COALESCE(tdpvln.selection_varchar, tdpvlnh.selection_varchar)
            ,ep.provider_last_name
         )                                                                  AS  provider_last_name
        ,ep.provider_address_county                                         AS  provider_address_county        
        ,ep.provider_npi                                                    AS  provider_npi
        ,COALESCE(tdpvp.selection_varchar, tdpvph.selection_varchar)        AS  provider_phone
        ,'TBD'                                                              AS  provider_record_issue
        ,ts.edit_reason                                                     AS  reason
        ,COALESCE(tdrmr.selection_varchar, tdrmrh.selection_varchar)        AS  returned_mail_reason
        ,'TBD'                                                              AS  requested_new_plan
        ,'TBD'                                                              AS  requested_new_provider
        ,'TBD'                                                              AS  urgent_access_to_care
        ,ts.task_notes                                                      AS  notes
        ,COALESCE(tdard.selection_date, tdardh.selection_date)              AS  application_received_date
        ,conl.consumer_id                                                   AS  consumer_id        
  FROM  ts
        LEFT JOIN 
        (
            SELECT  el.*
              FROM  MARSDB.MARSDB_EXTERNAL_LINKS_VW el
             WHERE  el.internal_ref_type = 'TASK' 
               AND  el.external_ref_type = 'CONTACT_RECORD' 
               AND  el.effective_end_date IS NULL

        ) tcrl 
        ON 
        (
                ts.task_id = tcrl.internal_id 
            AND ts.project_id = tcrl.project_id
        )
        LEFT JOIN 
        D_CONTACT_RECORDS_SV cr 
        ON 
        (
                tcrl.external_ref_id = cr.contact_record_id
            AND tcrl.project_id = cr.project_id
        )
        LEFT JOIN 
        MARSDB.MARSDB_PROJECT_VW    p 
        ON 
        (
                p.PROJECT_ID = ts.PROJECT_ID
        )
 -- getting the latest linked reference				    
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT  ex.project_id
                                ,ex.internal_id
                                ,ex.external_ref_id     AS  source_reference_id
                                ,ex.external_ref_type   AS  source_reference_type
                 		        ,ROW_NUMBER() OVER (PARTITION BY ex.project_id,ex.internal_id ORDER BY ex.external_link_id DESC) exrn
	 	 		          FROM  MARSDB.MARSDB_EXTERNAL_LINKS_VW ex
			  	         WHERE  UPPER(ex.internal_ref_type) = 'TASK'
			               AND  UPPER(ex.external_ref_type) NOT IN('CONSUMER','CASE')
			               AND  ex.effective_end_date IS NULL	
                    )   tmp
			 WHERE  exrn = 1
        )   exo 
        ON 
        (
                ts.task_id = exo.internal_id
            AND ts.project_id = exo.project_id
        )
 -- get total time worked
        LEFT JOIN
        (
            SELECT  project_id
                    ,task_id
                    ,SUM(IFF(task_status = 'In-Progress', time_elapsed, NULL))  AS  total_time_worked
              FROM  (
                        SELECT  project_id
                                ,task_id
                                ,task_status
                                ,DATEDIFF('seconds', updated_on, COALESCE((LEAD(updated_on) OVER (PARTITION BY project_id,task_id ORDER BY project_id, task_id, updated_on, log_created_on)),CURRENT_DATE()) ) AS time_elapsed
                          FROM  MARSDB.MARSDB_TASKS_HISTORY_VW
                    )   th
             GROUP 
                BY  project_id, task_id
        )   ttw 
        ON 
        (
                ts.task_id = ttw.task_id
            AND ts.project_id = ttw.project_id
        )
 --get escalated to/by staff
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT  th.task_id
                                ,th.project_id
                                ,th.task_history_id
                                ,th.updated_on
                                ,th.staff_assigned_to   AS  escalated_to_user_id
                                ,task_escalated_ts
                                ,escalated_by_user_id
                                ,ROW_NUMBER() OVER (PARTITION BY th.project_id,th.task_id ORDER BY th.task_history_id DESC) thrn
                          FROM  MARSDB.MARSDB_TASKS_HISTORY_VW  th
                                JOIN
                                (
                                    SELECT  *
                                      FROM  (
                                                SELECT  the.task_history_id     AS  escalated_hist_id
                                                        ,the.project_id
                                                        ,the.task_id
                                                        ,the.updated_on         AS  task_escalated_ts
                                                        ,the.updated_by         AS  escalated_by_user_id
                                                        ,ROW_NUMBER() OVER (PARTITION BY the.project_id,the.task_id ORDER BY the.task_history_id DESC) esrn
                                                  FROM  MARSDB.MARSDB_TASKS_HISTORY_VW  the                               
                                                 WHERE  the.task_status = 'Escalated'
                                            )   tmp
                                     WHERE  esrn = 1
                                )   the 
                                ON 
                                (
                                        th.task_id = the.task_id
                                    AND th.project_id = the.project_id
                                )
                         WHERE  th.staff_assigned_to IS NOT NULL
                           AND th.task_status = 'In-Progress'             
                           AND th.task_history_id > the.escalated_hist_id 
                    )   tmp
             WHERE  thrn = 1
        )   thesc 
        ON 
        (
                ts.task_id = thesc.task_id
            AND ts.project_id = thesc.project_id
        )
-- reason
       LEFT JOIN 
        MARSDB.MARSDB_TASK_DETAIL_VW    tdrr 
        ON 
        (
                ts.task_id = tdrr.task_id 
            AND ts.project_id = tdrr.project_id 
            AND tdrr.task_field_name = 'Reason'
        )
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                            SELECT  task_id
                                    ,task_field_name
                                    ,project_id
                                    ,selection_varchar
                                    ,ROW_NUMBER() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                              FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                             WHERE  task_field_name = 'Reason'
                    )   r
             WHERE  tdcrn = 1 
        )   tdrrh 
        ON 
        (
                ts.task_id = tdrrh.task_id
            AND ts.project_id = tdrrh.project_id
        )
-- case work first name        
        LEFT JOIN 
        MARSDB.MARSDB_TASK_DETAIL_VW    tcwfn 
        ON 
        (
                ts.task_id = tcwfn.task_id 
            AND ts.project_id = tcwfn.project_id 
            AND tcwfn.task_field_id = 3
        )
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT  task_id
                                ,task_field_name
                                ,project_id
                                ,selection_varchar
                                ,ROW_NUMBER() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                          FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                         WHERE  task_field_id = 3
                    )   r
             WHERE  tdcrn = 1 
        )   tcwfnh 
        ON 
        (
                ts.task_id = tcwfnh.task_id
            AND ts.project_id = tcwfnh.project_id
        )
-- case work last name
        LEFT JOIN 
        MARSDB.MARSDB_TASK_DETAIL_VW    tcwln 
        ON 
        (
                ts.task_id = tcwln.task_id 
            AND ts.project_id = tcwln.project_id 
            AND tcwln.task_field_id = 4
        )
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT  task_id
                                ,task_field_name
                                ,project_id
                                ,selection_varchar
                                ,ROW_NUMBER() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                          FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                         WHERE  task_field_id = 4
                    )   r
             WHERE  tdcrn = 1 
        )   tcwlnh 
        ON 
        (
                ts.task_id = tcwlnh.task_id
            AND ts.project_id = tcwlnh.project_id
        )
-- external case id   
        LEFT JOIN 
        MARSDB.MARSDB_TASK_DETAIL_VW    tdec 
        ON 
        (
                ts.task_id = tdec.task_id 
            AND ts.project_id = tdec.project_id 
            AND tdec.task_field_id = 91
        )
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT  task_id
                                ,task_field_name
                                ,project_id
                                ,selection_varchar
                                ,ROW_NUMBER() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                          FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                         WHERE  task_field_id = 91
                    )   r
             WHERE  tdcrn = 1 
        )   tdech 
        ON 
        (
                ts.task_id = tdech.task_id
            AND ts.project_id = tdech.project_id
        )
 -- business unit
        LEFT JOIN 
        MARSDB.MARSDB_TASK_DETAIL_VW    tdbu 
        ON 
        (
                ts.task_id = tdbu.task_id 
            AND ts.project_id = tdbu.project_id 
            AND tdbu.task_field_id = 100
        )
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT task_id
                                ,task_field_name
                                ,project_id
                                ,selection_varchar
                                ,ROW_NUMBER() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                          FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                         WHERE  task_field_id = 100
                    )   r
             WHERE  tdcrn = 1 
        )   tdbuh 
        ON 
        (
                ts.task_id = tdbuh.task_id
            AND ts.project_id = tdbuh.project_id
        )
-- locality
        LEFT JOIN 
        MARSDB.MARSDB_TASK_DETAIL_VW    tdl 
        ON 
        (
                ts.task_id = tdl.task_id 
            AND ts.project_id = tdl.project_id 
            AND tdl.task_field_id = 119
        )
        LEFT JOIN
        (
            SELECT  *
              FROM  (
                        SELECT task_id
                                ,task_field_name
                                ,project_id
                                ,selection_varchar,
                                 ROW_NUMBER() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                          FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                         WHERE  task_field_id = 119
                    )   r
             WHERE  tdcrn = 1 
        )   tdlh 
        ON 
        (
                ts.task_id = tdlh.task_id
            AND ts.project_id = tdlh.project_id 
        )
-- mmis member id
        LEFT JOIN 
        MARSDB.MARSDB_TASK_DETAIL_VW tdmm 
        ON 
        (
                ts.task_id = tdmm.task_id 
            AND ts.project_id = tdmm.project_id 
            AND tdmm.task_field_id = 111
        )
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT  task_id
                                ,task_field_name
                                ,project_id
                                ,selection_varchar
                                ,RANK() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                          FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                         WHERE  task_field_id = 111
                    )   r
             WHERE  tdcrn = 1
        )   tdmmh 
        ON 
        (
                ts.task_id = tdmmh.task_id
            AND ts.project_id = tdmmh.project_id
        )
-- action taken
        LEFT JOIN
        MARSDB.MARSDB_TASK_DETAIL_VW    tdat 
        ON 
        (
                ts.task_id = tdat.task_id 
            AND ts.project_id = tdat.project_id 
            AND tdat.task_field_id = 59
        )
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT  task_id, 
                                task_field_name,
                                project_id, 
                                selection_varchar,
                                RANK() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC)  AS  tdcrn
                          FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                         WHERE  task_field_id = 59
                    ) r
             WHERE  tdcrn = 1 
        )   tdath 
        ON 
        (
                ts.task_id = tdath.task_id
            AND ts.project_id = tdath.project_id
        )        
-- contact reason
        LEFT JOIN 
        MARSDB.MARSDB_TASK_DETAIL_VW    tcr 
        ON 
        (
                ts.task_id = tcr.task_id 
            AND ts.project_id = tcr.project_id 
            AND tcr.task_field_id = 47
        )
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT  task_id
                                ,task_field_name
                                ,project_id
                                ,selection_varchar
                                ,ROW_NUMBER() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                          FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                         WHERE  task_field_id = 47
                    )   r
              WHERE tdcrn = 1 
        )   tcrh 
        ON 
        (
                ts.task_id = tcrh.task_id
            AND ts.project_id = tcrh.project_id
        )
-- information type
        LEFT JOIN 
        MARSDB.MARSDB_TASK_DETAIL_VW    tdit 
        ON 
        (
                ts.task_id = tdit.task_id 
            AND ts.project_id = tdit.project_id 
            AND tdit.task_field_id = 11
        )
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT  task_id
                                ,task_field_name
                                ,project_id
                                ,selection_varchar
                                ,ROW_NUMBER() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                          FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                         WHERE  task_field_id = 11
                    )   r
              WHERE tdcrn = 1 
        )   tdith 
        ON 
        (
                ts.task_id = tdith.task_id
            AND ts.project_id = tdith.project_id
        )
-- invalid address reason
        LEFT JOIN 
        MARSDB.MARSDB_TASK_DETAIL_VW    tdiar
        ON 
        (
                ts.task_id = tdiar.task_id 
            AND ts.project_id = tdiar.project_id 
            AND tdiar.task_field_id = 16
        )
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT  task_id
                                ,task_field_name
                                ,project_id
                                ,selection_varchar
                                ,ROW_NUMBER() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                          FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                         WHERE  task_field_id = 16
                    )   r
              WHERE tdcrn = 1 
        )   tdiarh 
        ON 
        (
                ts.task_id = tdiarh.task_id
            AND ts.project_id = tdiarh.project_id
        )
-- channel
        LEFT JOIN 
        MARSDB.MARSDB_TASK_DETAIL_VW    tdch 
        ON 
        (
                ts.task_id = tdch.task_id 
            AND ts.project_id = tdch.project_id 
            AND tdch.task_field_id = 12
        )
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT  task_id
                                ,task_field_name
                                ,project_id
                                ,selection_varchar
                                ,ROW_NUMBER() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                          FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                         WHERE  task_field_id = 12
                    )   r
              WHERE tdcrn = 1 
        )   tdchh 
        ON 
        (
                ts.task_id = tdchh.task_id
            AND ts.project_id = tdchh.project_id
        )
-- application received date
        LEFT JOIN 
        MARSDB.MARSDB_TASK_DETAIL_VW    tdard
        ON 
        (
                ts.task_id = tdard.task_id 
            AND ts.project_id = tdard.project_id 
            AND tdard.task_field_id = 145
        )
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT  task_id
                                ,task_field_name
                                ,project_id
                                ,selection_varchar
                                ,selection_date
                                ,ROW_NUMBER() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                          FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                         WHERE  task_field_id = 145
                    )   r
              WHERE tdcrn = 1 
        )   tdardh 
        ON 
        (
                ts.task_id = tdardh.task_id
            AND ts.project_id = tdardh.project_id
        )
-- returned mail reason
        LEFT JOIN 
        MARSDB.MARSDB_TASK_DETAIL_VW    tdrmr
        ON 
        (
                ts.task_id = tdrmr.task_id 
            AND ts.project_id = tdrmr.project_id 
            AND tdrmr.task_field_id = 16
        )
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT  task_id
                                ,task_field_name
                                ,project_id
                                ,selection_varchar
                                ,ROW_NUMBER() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                          FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                         WHERE  task_field_id = 16
                    )   r
              WHERE tdcrn = 1 
        )   tdrmrh 
        ON 
        (
                ts.task_id = tdrmrh.task_id
            AND ts.project_id = tdrmrh.project_id
        )
-- provider first name
        LEFT JOIN 
        MARSDB.MARSDB_TASK_DETAIL_VW    tdpvfn 
        ON 
        (
                ts.task_id = tdpvfn.task_id 
            AND ts.project_id = tdpvfn.project_id 
            AND tdpvfn.task_field_id = 1
        )
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT  task_id
                                ,task_field_name
                                ,project_id
                                ,selection_varchar
                                ,ROW_NUMBER() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                          FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                         WHERE  task_field_id = 1
                    )   r
              WHERE tdcrn = 1 
        )   tdpvfnh 
        ON 
        (
                ts.task_id = tdpvfnh.task_id
            AND ts.project_id = tdpvfnh.project_id
        )
-- provider last name
        LEFT JOIN 
        MARSDB.MARSDB_TASK_DETAIL_VW    tdpvln 
        ON 
        (
                ts.task_id = tdpvln.task_id 
            AND ts.project_id = tdpvln .project_id 
            AND tdpvln.task_field_id = 21
        )
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT  task_id
                                ,task_field_name
                                ,project_id
                                ,selection_varchar
                                ,ROW_NUMBER() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                          FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                         WHERE  task_field_id = 21
                    )   r
              WHERE tdcrn = 1 
        )   tdpvlnh 
        ON 
        (
                ts.task_id = tdpvlnh.task_id
            AND ts.project_id = tdpvlnh.project_id
        )
-- provider phone
        LEFT JOIN 
        MARSDB.MARSDB_TASK_DETAIL_VW    tdpvp
        ON 
        (
                ts.task_id = tdpvp.task_id 
            AND ts.project_id = tdpvp.project_id 
            AND tdpvp.task_field_id = 52
        )
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT  task_id
                                ,task_field_name
                                ,project_id
                                ,selection_varchar
                                ,ROW_NUMBER() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                          FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                         WHERE  task_field_id = 52
                    )   r
              WHERE tdcrn = 1 
        )   tdpvph 
        ON 
        (
                ts.task_id = tdpvph.task_id
            AND ts.project_id = tdpvph.project_id
        )
-- program
        LEFT JOIN 
        MARSDB.MARSDB_TASK_DETAIL_VW    tdpr 
        ON 
        (
                ts.task_id = tdpr.task_id 
            AND ts.project_id = tdpr.project_id 
            AND tdpr.task_field_id = 44
        )
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT  task_id
                                ,task_field_name
                                ,project_id
                                ,selection_varchar
                                ,ROW_NUMBER() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                          FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                         WHERE  task_field_id = 44
                    )   r
              WHERE tdcrn = 1 
        )   tdprh 
        ON 
        (
                ts.task_id = tdprh.task_id
            AND ts.project_id = tdprh.project_id
        )
-- preferred phone
        LEFT JOIN 
        MARSDB.MARSDB_TASK_DETAIL_VW    tdpp
        ON 
        (
                ts.task_id = tdpp.task_id 
            AND ts.project_id = tdpp.project_id 
            AND tdpp.task_field_id = 13
        )
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT  task_id
                                ,task_field_name
                                ,project_id
                                ,selection_varchar
                                ,ROW_NUMBER() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                          FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                         WHERE  task_field_id = 13
                    )   r
              WHERE tdcrn = 1 
        )   tdpph 
        ON 
        (
                ts.task_id = tdpph.task_id
            AND ts.project_id = tdpph.project_id
        )
-- preferred language
        LEFT JOIN 
        MARSDB.MARSDB_TASK_DETAIL_VW    tdpl
        ON 
        (
                ts.task_id = tdpl.task_id 
            AND ts.project_id = tdpl.project_id 
            AND tdpl.task_field_id = 48
        )
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT  task_id
                                ,task_field_name
                                ,project_id
                                ,selection_varchar
                                ,ROW_NUMBER() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                          FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                         WHERE  task_field_id = 48
                    )   r
              WHERE tdcrn = 1 
        )   tdplh 
        ON 
        (
                ts.task_id = tdplh.task_id
            AND ts.project_id = tdplh.project_id
        )
-- preferred call back date time
        LEFT JOIN 
        MARSDB.MARSDB_TASK_DETAIL_VW    tdpcbdt
        ON 
        (
                ts.task_id = tdpcbdt.task_id 
            AND ts.project_id = tdpcbdt.project_id 
            AND tdpcbdt.task_field_id = 50
        )
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT  task_id
                                ,task_field_name
                                ,project_id
                                ,selection_varchar
                                ,selection_date_time
                                ,ROW_NUMBER() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                          FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                         WHERE  task_field_id = 50
                    )   r
              WHERE tdcrn = 1 
        )   tdpcbdth 
        ON 
        (
                ts.task_id = tdpcbdth.task_id
            AND ts.project_id = tdpcbdth.project_id
        )
-- New Address:  Address Line 1
        LEFT JOIN 
        MARSDB.MARSDB_TASK_DETAIL_VW    tdnal1 
        ON 
        (
                ts.task_id = tdnal1.task_id 
            AND ts.project_id = tdnal1.project_id 
            AND tdnal1.task_field_id = 95
        )
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT  task_id
                                ,task_field_name
                                ,project_id
                                ,selection_varchar
                                ,ROW_NUMBER() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                          FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                         WHERE  task_field_id = 95
                    )   r
              WHERE tdcrn = 1 
        )   tdnal1h 
        ON 
        (
                ts.task_id = tdnal1h.task_id
            AND ts.project_id = tdnal1h.project_id
        )
-- New Address:  Address Line 2
        LEFT JOIN 
        MARSDB.MARSDB_TASK_DETAIL_VW    tdnal2
        ON 
        (
                ts.task_id = tdnal2.task_id 
            AND ts.project_id = tdnal2.project_id 
            AND tdnal2.task_field_id = 96
        )
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT  task_id
                                ,task_field_name
                                ,project_id
                                ,selection_varchar
                                ,ROW_NUMBER() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                          FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                         WHERE  task_field_id = 96
                    )   r
              WHERE tdcrn = 1 
        )   tdnal2h 
        ON 
        (
                ts.task_id = tdnal2h.task_id
            AND ts.project_id = tdnal2h.project_id
        )
-- New Address:  City
        LEFT JOIN 
        MARSDB.MARSDB_TASK_DETAIL_VW    tdnac 
        ON 
        (
                ts.task_id = tdnac.task_id 
            AND ts.project_id = tdnac.project_id 
            AND tdnac.task_field_id = 97
        )
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT  task_id
                                ,task_field_name
                                ,project_id
                                ,selection_varchar
                                ,ROW_NUMBER() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                          FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                         WHERE  task_field_id = 97
                    )   r
              WHERE tdcrn = 1 
        )   tdnach 
        ON 
        (
                ts.task_id = tdnach.task_id
            AND ts.project_id = tdnach.project_id
        )
-- New Address:  State
        LEFT JOIN 
        MARSDB.MARSDB_TASK_DETAIL_VW    tdnas
        ON 
        (
                ts.task_id = tdnas.task_id 
            AND ts.project_id = tdnas.project_id 
            AND tdnas.task_field_id = 98
        )
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT  task_id
                                ,task_field_name
                                ,project_id
                                ,selection_varchar
                                ,ROW_NUMBER() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                          FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                         WHERE  task_field_id = 98
                    )   r
              WHERE tdcrn = 1 
        )   tdnash 
        ON 
        (
                ts.task_id = tdnash.task_id
            AND ts.project_id = tdnash.project_id
        )        
-- New Address:  Zip Code
        LEFT JOIN 
        MARSDB.MARSDB_TASK_DETAIL_VW    tdnazc
        ON 
        (
                ts.task_id = tdnazc.task_id 
            AND ts.project_id = tdnazc.project_id 
            AND tdnazc.task_field_id = 99
        )
        LEFT JOIN 
        (
            SELECT  *
              FROM  (
                        SELECT  task_id
                                ,task_field_name
                                ,project_id
                                ,selection_varchar
                                ,ROW_NUMBER() OVER (PARTITION BY task_id,project_id ORDER BY task_detail_history_id DESC) tdcrn
                          FROM  MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW
                         WHERE  task_field_id = 99
                    )   r
              WHERE tdcrn = 1 
        )   tdnazch 
        ON 
        (
                ts.task_id = tdnazch.task_id
            AND ts.project_id = tdnazch.project_id
        )        
        LEFT JOIN 
        (
            SELECT  el.external_link_id
                    ,el.internal_id AS service_request_id
                    ,el.project_id
              FROM  MARSDB.MARSDB_EXTERNAL_LINKS_VW el
             WHERE  el.external_ref_type = 'TASK' 
               AND  el.internal_ref_type = 'SERVICE_REQUEST' 
               AND  el.effective_end_date IS NULL

        )   sr
        ON 
        (
                ts.task_id = sr.external_link_id
            AND ts.project_id = sr.project_id
        )
        LEFT JOIN 
        (
            SELECT  el.external_ref_id
                    ,el.internal_id AS consumer_id
                    ,el.project_id
              FROM  MARSDB.MARSDB_EXTERNAL_LINKS_VW el
             WHERE  el.external_ref_type = 'SERVICE_REQUEST' 
               AND  el.internal_ref_type = 'CONSUMER' 
               AND  el.effective_end_date IS NULL

        )   conl
        ON 
        (
                sr.service_request_id = conl.external_ref_id
            AND ts.project_id = conl.project_id
        )
        LEFT JOIN
        (
            SELECT  c.*
              FROM  MARSDB.MARSDB_CONSUMER_VW   c
        )   con
        ON
        (
                conl.consumer_id = con.consumer_id
            AND ts.project_id = con.project_id
        )
        LEFT JOIN
        (
            SELECT  e.*
              FROM  MARSDB.MARSDB_ENROLLMENTS_VW    e
        )   enr
        ON
        (
                con.consumer_id = enr.consumer_id
            AND ts.project_id = enr.project_id
            AND ts.created_on BETWEEN enr.created_on AND COALESCE(enr.end_date, CURRENT_TIMESTAMP())
            AND UPPER(enr.status) NOT LIKE 'DISREGARD%'
            AND UPPER(enr.status) NOT LIKE 'DISENROLL%'          
            AND UPPER(enr.txn_status) NOT LIKE 'DISREGARD%'
            AND UPPER(enr.txn_status) NOT LIKE 'DISENROLL%'                    
        )        
        LEFT JOIN 
        (
            SELECT *
              FROM (
                        SELECT   ep1.*
                                ,ROW_NUMBER() OVER (PARTITION BY ep1.project_id, ep1.enrollment_id, ep1.consumer_id ORDER BY ep1.effective_start_date DESC) AS crnk                    
                          FROM  MARSDB.MARSDB_ENROLLMENT_PROVIDER_VW  ep1
                         WHERE  CURRENT_TIMESTAMP::DATE BETWEEN ep1.effective_start_date AND COALESCE(ep1.effective_end_date, CURRENT_TIMESTAMP::DATE)
                   )
             WHERE crnk = 1
        )   ep 
        ON 
        (
                enr.project_id = ep.project_id
            AND enr.enrollment_id = ep.enrollment_id
            AND enr.consumer_id = ep.consumer_id
        )
        LEFT JOIN 
        (
            SELECT *
              FROM (
                        SELECT   cc1.case_id
                                ,cc1.consumer_id
                                ,cc1.project_id
                                ,ROW_NUMBER() OVER (PARTITION BY cc1.project_id, cc1.case_id, cc1.consumer_id ORDER BY cc1.effective_start_date DESC) AS crnk                    
                          FROM  MARSDB.MARSDB_CASE_CONSUMER_VW  cc1
                         WHERE  CURRENT_TIMESTAMP::DATE BETWEEN cc1.effective_start_date AND COALESCE(cc1.effective_end_date, CURRENT_TIMESTAMP::DATE)
                   )
             WHERE crnk = 1
        )   cc 
        ON 
        (
                ts.project_id = cc.project_id
            AND con.consumer_id = cc.consumer_id
        )
        LEFT JOIN 
        MARSDB.MARSDB_INBOUND_CORRESPONDENCE_VW ic 
        ON 
        (
                cc.case_id = ic.case_id
            AND cc.project_id = ic.project_id
        )
        LEFT JOIN
        MARSDB.MARSDB_CONSUMER_BENEFIT_STATUS   cbs 
        ON 
        (
                con.consumer_id = cbs.consumer_id            
        )
        LEFT JOIN
        user_info   cb 
        ON 
        (
                ts.created_by = TO_CHAR(cb.user_id)
            AND ts.project_id = COALESCE(cb.team_project_id, cb.user_project_id)
        )
        LEFT JOIN
        user_info   ub 
        ON 
        (
                ts.updated_by = TO_CHAR(ub.user_id)
            AND ts.project_id = COALESCE(ub.team_project_id, ub.user_project_id)
        )        
        LEFT JOIN 
        user_info   asgn 
        ON 
        (
                CASE WHEN ts.TASK_STATUS IN('Complete','Cancelled') THEN NULL ELSE ts.staff_assigned_to END = TO_CHAR(asgn.user_id)
            AND ts.project_id = COALESCE(asgn.team_project_id, asgn.user_project_id)
        )
        LEFT JOIN
        user_info   wb 
        ON 
        (
                CASE WHEN ts.task_status IN('Complete','Cancelled') THEN ts.staff_assigned_to ELSE NULL END = TO_CHAR(wb.user_id)
            AND ts.project_id = COALESCE(wb.team_project_id, wb.user_project_id)
        )
        LEFT JOIN 
        user_info   et 
        ON 
        (
                CASE WHEN ts.escalated_flag = 1 THEN thesc.escalated_to_user_id ELSE NULL END = TO_CHAR(et.user_id)
            AND ts.project_id = COALESCE(et.team_project_id, et.user_project_id)
        );
