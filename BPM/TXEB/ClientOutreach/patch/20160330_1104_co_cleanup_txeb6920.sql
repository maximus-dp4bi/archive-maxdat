UPDATE corp_etl_clnt_outreach
SET outreach_status = 'Outreach No Longer Required'
   ,cancel_reason = 'TXEB-6920 - clean-up, history record and incident_header not updated'
   ,cancel_dt = sysdate
   ,complete_dt = sysdate
   ,cancel_by = 'TXEB-6920'
   ,cancel_method = 'Exception'
   ,stage_done_date = sysdate
WHERE outreach_req_type  IN( 'Newly Certified Children (excluding Foster Care and SSI)','Non Participants')
and instance_status = 'Complete'
and outreach_status = 'Outreach Attempt Unsuccessful - Waiting For Response';

commit;