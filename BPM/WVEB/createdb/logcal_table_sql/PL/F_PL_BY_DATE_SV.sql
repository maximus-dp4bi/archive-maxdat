select distinct
  lr.LMREQ_ID fplbd_id
  ,d.d_date
  ,lr.CREATE_TS bucket_start_date
  ,case 
     when lr.SENT_ON is null and lr.ERROR_CODES is not null and si.STEP_INSTANCE_ID is null then lrsh.CREATE_TS 
     when lr.MAILED_DATE is not null then lr.MAILED_DATE 
     when emer.DESCRIPTION is not null and si.STEP_INSTANCE_ID is null then c.LETTER_RESP_FILE_DT 
     when l.cancel_dt is not null then l.cancel_dt 
     else lr.CREATE_TS 
     end bucket_end_date
  ,lr.LMREQ_ID pl_bi_id
  ,els.VALUE dplls_id
  ,case 
     when ((trunc(d.d_date) = trunc(lrsh.CREATE_TS)) and (trunc(d.d_date) < 
       (trunc(case 
                when lr.SENT_ON is null and lr.ERROR_CODES is not null and si.STEP_INSTANCE_ID is null then lrsh.CREATE_TS 
                when lr.MAILED_DATE is not null then lr.MAILED_DATE 
                when emer.DESCRIPTION is not null and si.STEP_INSTANCE_ID is null then c.LETTER_RESP_FILE_DT 
                when l.cancel_dt is not null then l.cancel_dt 
                else lr.CREATE_TS 
                end)))) 
       then 1 else 0 
     end inventory_count
  ,case 
     when ((trunc(d.d_date) = trunc(lrsh.CREATE_TS)) and (trunc(d.d_date) = 
       (trunc(case 
                when lr.SENT_ON is null and lr.ERROR_CODES is not null and si.STEP_INSTANCE_ID is null then lrsh.CREATE_TS 
                when lr.MAILED_DATE is not null then lr.MAILED_DATE 
                when emer.DESCRIPTION is not null and si.STEP_INSTANCE_ID is null then c.letter_resp_file_dt 
                when l.cancel_dt is not null then l.cancel_dt else lr.CREATE_TS end)))) then 1 
                else 0 
                end creation_count
  ,case 
     when ((trunc(d.d_date) <> trunc(lrsh.CREATE_TS)) or ((trunc(d.d_date) = trunc(lrsh.CREATE_TS)) and (trunc(d.d_date) = 
       (trunc(case 
                when lr.SENT_ON is null and lr.ERROR_CODES is not null and si.STEP_INSTANCE_ID is null then lrsh.CREATE_TS 
                when lr.MAILED_DATE is not null then lr.MAILED_DATE 
                when emer.DESCRIPTION is not null and si.STEP_INSTANCE_ID is null then c.letter_resp_file_dt 
                when l.cancel_dt is not null then l.cancel_dt 
                else lr.CREATE_TS 
                end))))) 
       then 1 
     else 0 
     end completion_count
  ,lrsh.CREATE_TS letter_status_date
from EB.LETTER_REQUEST lr
inner join 
  (select (add_months(trunc(sysdate,'MM'),-5) + rownum) d_date 
   from dual 
   connect by rownum <= (sysdate - (add_months(trunc(sysdate,'MM'),-2)))) d 
  on trunc(lr.CREATE_TS) = trunc(d.d_date)
left outer join EB.ENUM_LM_STATUS els on lr.STATUS_CD = els.VALUE
left outer join EB.LETTER_REQ_STATUS_HISTORY lrsh on lr.LMREQ_ID = lrsh.LMREQ_ID
left outer join EB.ENUM_MAILHOUSE_ERROR_REASONS emer on lr.REJECT_REASON_CD = emer.value
left outer join EB.STEP_INSTANCE si on lr.CASE_ID = si.CASE_ID 
left outer join 
  (select distinct 
     elm.LMREQ_ID, 
     jrd.CREATE_TS letter_resp_file_dt
   from EB.ETL_L_MAILHOUSE elm
   join EB.JOB_RUN_DATA jrd on jrd.JOB_RUN_DATA_ID = elm.JOB_ID) c 
  on lr.LMREQ_ID = c.LMREQ_ID
left outer join 
  (select 
     LMREQ_ID, 
     max(CREATE_TS) over (partition by LMREQ_ID) cancel_dt
   from EB.LETTER_REQ_STATUS_HISTORY
   where STATUS_CD in ('CANC','VOID','OBE','COMBND')) l 
  on l.LMREQ_ID = lr.LMREQ_ID
where lrsh.STATUS_CD = 'REQ'
