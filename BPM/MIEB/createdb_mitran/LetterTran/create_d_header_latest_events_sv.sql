CREATE OR REPLACE VIEW D_HEADER_LATEST_EVENTS_SV AS
SELECT a.TRAN_REF_PKID TRAN_HEADER_ID
, INIT_DT initiated_dt
, JOBID_ASSIGNED_DT jobid_assigned_dt
, CONFIRMATION_RCVD_FROM_EYR_DT rcvd_conf_eyr_dt
, SENT_TO_EYR_QA_DT sent_qa_dt
, MAILED_BY_EYR_DT rcvd_mail_eyr_dt
, init_id initiated_event_id
, jobid_assigned_id jobid_assigned_event_id
, CONFIRMATION_RCVD_FROM_EYR_id rcvd_conf_eyr_id
, SENT_TO_EYR_QA_id sent_qa_id
, MAILED_BY_EYR_id rcvd_mail_eyr_id
, inite.filename initiated_filename
, inite.ltr_source_code initiated_source
, jobe.filename jobid_filename
, jobe.ltr_source_code jobid_source
, confe.filename conf_filename
, confe.ltr_source_code conf_source
, qae.filename qa_filename
, qae.ltr_source_code qa_source
, maile.filename mail_filename
, maile.ltr_source_code mail_source
FROM (
select *
from
(
select tran_ref_pkid, tran_event_id, event_date, event_name
, row_number() over(partition by tran_ref_table, tran_ref_pkid, event_name order by tran_event_id desc) rn
from d_tran_events te
where tran_ref_table = 'D_TRAN_HEADER'
--AND tran_ref_pkid = 4
) te
pivot (
max(tran_event_id) as id, max(event_date) as dt
for event_name in (
  'TRAN_INIT' as "INIT"
  , 'TRAN_JOBID_ASSIGNED' as "JOBID_ASSIGNED"
  , 'TRAN_CONFIRMATION_RCVD_FROM_EYR' as "CONFIRMATION_RCVD_FROM_EYR"
  , 'TRAN_SENT_TO_EYR_QA' as "SENT_TO_EYR_QA"
  , 'TRAN_MAILED_BY_EYR' as "MAILED_BY_EYR"
))
 where rn = 1
 ) a
 left join d_tran_events inite on inite.tran_event_id = init_id
 left join d_tran_events jobe on jobe.tran_event_id = jobid_assigned_id
 left join d_tran_events confe on confe.tran_event_id = CONFIRMATION_RCVD_FROM_EYR_id
 left join d_tran_events qae on qae.tran_event_id = SENT_TO_EYR_QA_id
 left join d_tran_events maile on maile.tran_event_id = MAILED_BY_EYR_id
;
