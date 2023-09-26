UPDATE corp_etl_clnt_outreach
SET outreach_req_type = 'THSteps Check-up Due Letter'
,outreach_status = 'Outreach Invalid Request'
,cancel_reason = 'TXEB-6849 clean-up, no history in MAXeb'
,cancel_dt = sysdate
,complete_dt = sysdate
,cancel_by = 'TXEB-6849'
,instance_status = 'Complete'
,stage_done_date = sysdate
,cancel_method = 'Exception'
WHERE outreach_id IN ( 45398412,
45398488,
45398794,
45398836,
45398851,
45398876,
45398892,
45398263,
45398375,
45398919);

commit;