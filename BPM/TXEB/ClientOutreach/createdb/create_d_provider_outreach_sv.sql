
CREATE OR REPLACE VIEW D_PROVIDER_OUTREACH_SV
AS
 SELECT dto.*
  ,CASE WHEN call_dt IS NOT NULL THEN 'Y' ELSE 'N' END call_made
  ,CASE WHEN letter_create_dt IS NOT NULL THEN 'Y' ELSE 'N' END letter_created
  ,COALESCE(trunc(task_create_dt),trunc(sysdate)) - trunc(released_date) time_to_task
  ,COALESCE(trunc(incident_create_dt),trunc(sysdate)) - trunc(released_date) time_to_OR_req
  ,COALESCE(trunc(call_dt),trunc(sysdate)) - trunc(released_date) time_to_call
  ,COALESCE(trunc(letter_create_dt),trunc(sysdate)) - trunc(released_date) time_to_letter
  ,bpm_common.BUS_DAYS_BETWEEN(released_date,COALESCE(co_instance_end_dt,trunc(sysdate))) age_in_business_days 
FROM(
SELECT mfdoc.mfdoc_bi_id
       ,mfdoc.dcn
       ,mfdoc."Document ID"
       ,mfdoc."Document Status Date" released_date
       ,mfdoc."Document Type" document_type
       ,mfdoc."Instance Complete Date" doc_complete_dt
       ,mfdoc."Work Task Type" task_type_created
       ,mw."Task ID" task_id
       ,mw."Create Date" task_create_dt
       ,coalesce(mw."Complete Date",mw."Cancel Work Date") task_end_dt   
       ,outreach_request_id incident_id
       ,co.create_date incident_create_dt
       ,outreach_request_status incident_status
       ,outreach_request_status_date incident_status_dt
       ,COALESCE(co.perform_outreach_end_date,cancel_date) co_instance_end_dt
       ,outreach_request_category 
       ,outreach_request_type
       ,(SELECT MAX(event_create_dt) FROM corp_etl_clnt_outreach_events oe WHERE oe.event_outreach_id = co.outreach_request_id and event_type = 'Outreach Request - Letter Request has been created.' and event_create_dt >= co.create_date) letter_create_dt
       ,oe.event_create_dt call_dt
       ,oe.event_type call_event_type
       ,oe.event_outcome call_event_outcome
FROM  d_mfdoc_current mfdoc 
 LEFT OUTER JOIN d_mw_current mw
   ON mfdoc."Work Task ID" = mw."Task ID"
 LEFT OUTER JOIN d_cor_current co  
   ON mfdoc."Document ID" = co.image_reference_id
 LEFT OUTER JOIN (SELECT * FROM corp_etl_clnt_outreach_events oe
                  WHERE (event_type IN(SELECT event_type 
                                       FROM corp_etl_clnt_or_activity_lkup 
                                       WHERE outreach_step_type LIKE 'Phone%' 
                                         OR outreach_step_type LIKE 'Automated%') 
                          OR event_type like '%Outbound Dialer%'
                          OR (event_call_rec_id IS NOT NULL AND event_type != 'Manual Action'))
                   AND event_id = (SELECT MAX(event_id) 
                                   FROM corp_etl_clnt_outreach_events oe1
                                   WHERE oe1.event_outreach_id = oe.event_outreach_id
                                   AND (oe1.event_type IN(SELECT event_type 
                                       FROM corp_etl_clnt_or_activity_lkup 
                                       WHERE outreach_step_type LIKE 'Phone%' 
                                         OR outreach_step_type LIKE 'Automated%') 
                          OR oe1.event_type like '%Outbound Dialer%'
                          OR (oe1.event_call_rec_id IS NOT NULL AND oe1.event_type != 'Manual Action')) )
    ) oe
    ON co.outreach_request_id = oe.event_outreach_id
WHERE "Document Form Type" = 'PROV_REF'
and "DCN Create Date" >= add_months(trunc(sysdate,'mm'),-12)
) dto;


GRANT SELECT ON D_PROVIDER_OUTREACH_SV TO MAXDAT_READ_ONLY;