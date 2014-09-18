CREATE OR REPLACE VIEW BPM_LAST_ETL_RUN_SV AS 
SELECT
  BEM.bem_id
, BSL.BSL_ID
, BSL.NAME                                           "Process Name"
, max(CJS.job_start_date)                            "Last Completed ETL Start Time"
, nvl(round(((sysdate - min(EVENT_DATE)) * 24),2),0) "Queue Hours Behind"
, case when nvl(round(((sysdate - min(EVENT_DATE)) * 24),2),0) = 0 then 'Complete'
  else 'Pending'
  end                                                "Queue Processing"  
FROM BPM_SOURCE_LKUP BSL
LEFT OUTER JOIN BPM_UPDATE_EVENT_QUEUE BUQ
   on BSL.BSL_ID = BUQ.BSL_ID
INNER JOIN BPM_EVENT_MASTER BEM
   on BEM.bem_id = BSL.bsl_id
INNER JOIN BPM_PROCESS_LKUP BPL
   on BPL.BPROL_ID = BEM.BPROL_ID
INNER JOIN corp_etl_list_lkup CEL
   on CEL.ref_id = BEM.bprol_id
INNER JOIN corp_etl_job_statistics CJS
   on CJS.job_name = CEL.value
WHERE CJS.job_status_cd = 'COMPLETED'
GROUP BY BSL.BSL_ID, BSL.NAME, BEM.bem_id, CEL.name;


--create or replace public synonym BPM_LAST_ETL_RUN_SV for BPM_LAST_ETL_RUN_SV;
grant select on BPM_LAST_ETL_RUN_SV to MAXDAT_READ_ONLY;