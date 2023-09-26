CREATE OR REPLACE VIEW D_UNDELIVER_MAIL_BY_STAFF_SV
AS
WITH plmail       
AS
(
 SELECT  TRUNC(pl.letter_return_date) letter_return_date,
       pl.return_reason,
       m.create_date task_creation_date,
       pl.mailed_date,
       pl.letter_status,  
       m.curr_created_by_staff_id,
       m.task_id,
       pl.client_id,
       pl.letter_request_id,
       m.complete_date task_complete_date,
       TRUNC(m.complete_date) processed_dt,
       TRUNC(m.complete_date,'mm') processed_month,
       TRUNC(pl.letter_return_date) cycle_start_date,
       TRUNC(pl.letter_return_date,'mm') cycle_start_month,
       m.curr_owner_staff_id,       
       m.case_id,    
      (SELECT TO_NUMBER(out_var) FROM corp_etl_list_lkup WHERE name = 'RTN_MAIL_SLA_DAYS' AND value = 'SLA_DAYS') sla_days,
      (SELECT TO_NUMBER(out_var) FROM corp_etl_list_lkup WHERE name = 'RTN_MAIL_JEOPARDY_DAYS' AND value = 'JEOPARDY_DAYS') jeopardy_days,
      -- ROW_NUMBER() OVER (PARTITION BY pl.letter_request_id ORDER BY abs(pl.letter_return_date-m.create_date)) rnpl       
       ROW_NUMBER() OVER (PARTITION BY m.task_id ORDER BY abs(pl.letter_return_date-m.create_date)) rnpl       
 FROM d_mw_v2_current m 
  INNER JOIN d_task_types d 
    ON m.task_type_id = d.task_type_id
  INNER JOIN (SELECT ls.letter_id letter_request_id,ls.letter_return_date, ls.return_reason,ls.letter_case_id case_id, ls.letter_mailed_date mailed_date,ls.letter_status, ll.client_id
              FROM letters_stg ls 
                INNER JOIN letter_request_link_stg ll ON ls.letter_id = ll.lmreq_id
              WHERE letter_return_date IS NOT NULL) pl
    ON pl.case_id = m.case_id
    AND TRUNC(m.create_date) between TRUNC(pl.mailed_date) and TRUNC(pl.letter_return_date) + 30
    AND m.create_date >= pl.letter_return_date
WHERE d.task_name = 'Returned Mail'     
AND m.curr_task_status != 'TERMINATED'
    )
SELECT letter_return_date
       ,return_reason
       ,task_creation_date
       ,mailed_date
       ,letter_status
       ,ccs.state_case_id
       ,curr_created_by_staff_id
       ,task_id
       ,plmail.client_id
       ,ccs.recipient_id
       ,task_complete_date       
       ,CASE WHEN plmail.task_complete_date IS NOT NULL THEN ds.first_name||' '||ds.last_name ELSE null END completed_by       
       ,sla_days
       ,CASE WHEN plmail.task_complete_date IS NULL THEN 'Not Processed' ELSE
         CASE WHEN BPM_COMMON.BUS_DAYS_BETWEEN(TRUNC(plmail.letter_return_date),TRUNC(COALESCE(plmail.task_complete_date,sysdate))) <= sla_days THEN 'Timely' 
         ELSE 'Untimely' END END rtn_mail_timeliness_status
       ,BPM_COMMON.BUS_DAYS_BETWEEN(TRUNC(plmail.letter_return_date),TRUNC(COALESCE(plmail.task_complete_date,sysdate))) rtn_mail_bus_cycle_time
       ,CASE WHEN TRUNC(COALESCE(plmail.task_complete_date,sysdate)) - TRUNC(plmail.letter_return_date) < 0 THEN 0 ELSE
         TRUNC(COALESCE(plmail.task_complete_date,sysdate)) - TRUNC(plmail.letter_return_date) END rtn_mail_cal_cycle_time
       ,letter_request_id
       ,processed_dt
       ,processed_month
       ,cycle_start_date
       ,cycle_start_month
       ,CASE WHEN plmail.task_complete_date IS NOT NULL THEN 'NA' ELSE
         CASE WHEN BPM_COMMON.BUS_DAYS_BETWEEN(TRUNC(plmail.letter_return_date),TRUNC(sysdate)) >= jeopardy_days THEN 'Y' 
         ELSE 'N' END END rtn_mail_jeopardy_status
       ,CASE WHEN plmail.task_complete_date IS NULL THEN ds.first_name||' '||ds.last_name ELSE null END current_task_owner  
 FROM plmail
  LEFT OUTER JOIN d_staff ds
    ON ds.staff_id = plmail.curr_owner_staff_id
  LEFT OUTER JOIN d_case_client_link_sv ccs
    ON ccs.case_id = plmail.case_id
    AND ccs.client_id = plmail.client_id
WHERE rnpl = 1 
--AND task_complete_date IS NOT NULL
;

GRANT SELECT ON D_UNDELIVER_MAIL_BY_STAFF_SV TO MAXDAT_READ_ONLY;