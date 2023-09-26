update corp_etl_clnt_outreach
set outreach_status = 'Outreach No Longer Required'
,cancel_reason = 'No history record in maxeb, updated maxdat to complete instance'
where outreach_id = 52429163;

commit;