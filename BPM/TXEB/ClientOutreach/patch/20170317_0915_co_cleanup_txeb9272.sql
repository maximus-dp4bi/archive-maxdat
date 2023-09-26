
UPDATE corp_etl_clnt_outreach
SET outreach_status = 'Outreach Successful' 
    ,cancel_reason  = 'TXEB-9272 – outreach closed in MAXeb by jira 8124'
WHERE outreach_id =    71521795;


UPDATE corp_etl_clnt_outreach
SET outreach_status = 'Outreach Successful' 
    ,cancel_reason  = 'TXEB-9272 – outreach closed in MAXeb by jira 8124'
WHERE outreach_id IN(38357635,
39718305,
43372543,
46917234);


UPDATE corp_etl_clnt_outreach
SET instance_status = 'Complete'
    ,complete_dt = outreach_status_dt                
    ,stage_done_date = sysdate
    ,Cancel_reason  = 'TXEB-9272 – old instance missing history record'
WHERE outreach_req_type = '4 Month Dental'
AND outreach_status = 'Outreach Successful'
AND instance_status = 'Active';


UPDATE corp_etl_clnt_outreach
SET instance_status = 'Complete'
    ,complete_dt = to_date('11/22/2016 09:47:28','mm/dd/yyyy hh24:mi:ss')
    ,outreach_status_dt = to_date('11/22/2016 09:47:28','mm/dd/yyyy hh24:mi:ss')
    ,stage_done_date = sysdate
    ,Cancel_reason  = 'TXEB-9272 – MAXeb did not update status_ts correctly'
WHERE outreach_id IN(34925345, 34992190, 38360303, 40529947, 52407108);

UPDATE corp_etl_clnt_outreach
SET instance_status = 'Complete'
    ,complete_dt = outreach_status_dt                
    ,stage_done_date = sysdate
    ,Cancel_reason  ='TXEB-9272 – old instance missing history record'
WHERE outreach_req_type = 'Appt Scheduled Reminder/Confirm'
AND outreach_status = 'Outreach Successful'
AND instance_status = 'Active';      



UPDATE corp_etl_clnt_outreach
SET ased_outreach_step1 = TO_DATE('01/10/2017','mm/dd/yyyy')
    ,aspb_outreach_step1 = 'TXEB-9272'
    ,asf_outreach_step1 = 'Y'
    ,assd_outreach_step2 = TO_DATE('01/10/2017','mm/dd/yyyy')
    ,ased_outreach_step2 = TO_DATE('01/10/2017','mm/dd/yyyy')
    ,aspb_outreach_step2 = 'TXEB-9272'
    ,asf_outreach_step2 = 'Y'
    ,assd_outreach_step3 = TO_DATE('01/10/2017','mm/dd/yyyy')
    ,ased_outreach_step3 = TO_DATE('01/10/2017','mm/dd/yyyy')
    ,aspb_outreach_step3 = 'TXEB-9272'
    ,asf_outreach_step3 = 'N'
    ,assd_outreach_step4 = TO_DATE('01/10/2017','mm/dd/yyyy')
    ,ased_outreach_step4 = TO_DATE('02/13/2017','mm/dd/yyyy')
    ,aspb_outreach_step4 = 'TXEB-9272'
    ,asf_outreach_step4 = 'Y'
    ,assd_outreach_step5 = TO_DATE('02/13/2017','mm/dd/yyyy')
    ,ased_outreach_step5 = TO_DATE('02/13/2017','mm/dd/yyyy')
    ,aspb_outreach_step5 = 'TXEB-9272'
    ,asf_outreach_step5 = 'Y'
    ,ased_perform_outreach =  TO_DATE('01/10/2017','mm/dd/yyyy')
    ,aspb_perform_outreach = 'TXEB-9272'
    ,asf_perform_outreach = 'N'
    ,gwf_invalid = 'N'
    ,gwf_unsuccessful = 'N'
    ,gwf_notify_client = 'N'
    ,gwf_notify_source = 'N'
    ,gwf_step2_required = 'Y'
    ,gwf_step3_required = 'Y'
    ,gwf_step4_required = 'Y'
    ,gwf_step5_required = 'Y'
    ,gwf_step6_required = 'N'
    ,instance_status = 'Complete'
    ,complete_dt = outreach_status_dt              
    ,stage_done_date = sysdate 
    ,cancel_reason  = 'TXEB-9272 – outreach closed in MAXeb missing event_outreach'
WHERE outreach_id = 77528387;   

UPDATE corp_etl_clnt_outreach
SET instance_status = 'Complete'
    ,complete_dt = outreach_status_dt                
    ,stage_done_date = sysdate 
    ,cancel_reason  = 'TXEB-9272 – outreach closed in MAXeb by jira 8124'
WHERE outreach_req_type =  'Children Leaving Conservatorship'
AND outreach_status = 'Outreach Unsuccessful'
AND instance_status = 'Active'
AND TRUNC(create_dt) <= TO_DATE('01/24/2017','mm/dd/yyyy');

UPDATE corp_etl_clnt_outreach
SET instance_status = 'Complete'
    ,complete_dt = outreach_status_dt                
    ,stage_done_date = sysdate 
    ,cancel_reason  = 'TXEB-9272 – outreach closed in MAXeb by jira 8124'
WHERE outreach_req_type =  'Children Leaving Conservatorship'
AND outreach_status = 'Outreach Successful'
AND instance_status = 'Active';

commit;