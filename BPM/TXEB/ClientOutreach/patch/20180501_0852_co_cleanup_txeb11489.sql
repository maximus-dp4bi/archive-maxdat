--5 instances
UPDATE corp_etl_clnt_outreach
SET instance_status = 'Complete'
    ,complete_dt = outreach_status_dt               
    ,stage_done_date = sysdate 
    ,cancel_reason  = 'TXEB-11489 – close old client outreach requests'
    ,cancel_dt = sysdate
    ,cancel_by = 'MAXDAT'
WHERE outreach_req_type IN( 'Children Leaving Conservatorship','Provider Outreach Referrals (Missed Appt)')
AND outreach_status IN('Outreach Successful','Closed')
AND instance_status = 'Active'
AND TRUNC(create_dt) < TO_DATE('01/01/2018','mm/dd/yyyy');

--11136 instances
UPDATE corp_etl_clnt_outreach
SET instance_status = 'Complete'
    ,complete_dt = outreach_status_dt               
    ,stage_done_date = sysdate 
    ,cancel_reason  = 'TXEB-11489 – close old client outreach requests'
    ,cancel_dt = sysdate
    ,cancel_by = 'MAXDAT'
WHERE outreach_req_type IN('1087 - Checkup Verifications',
'Health Care Orientation',
'Newly Certified Foster Care Children',
'Newly Certified SSI Children',
'Pregnant Women',
'Provider Outreach Referrals (High Lead Levels)',
'Provider Outreach Referrals (Missed Appt)',
'Provider Outreach Referrals (Scheduling Assistance)',
'STARKIDS Recipients')
AND outreach_status IN('Outreach Successful', 'Outreach Unsuccessful')
AND instance_status = 'Active'
AND TRUNC(create_dt) < TO_DATE('01/01/2017','mm/dd/yyyy');

--203463 instances
UPDATE corp_etl_clnt_outreach
SET instance_status = 'Complete'
    ,complete_dt = outreach_status_dt               
    ,stage_done_date = sysdate 
    ,cancel_reason  = 'TXEB-11489 – close unsucessful client outreach'
    ,cancel_dt = sysdate
    ,cancel_by = 'MAXDAT'
WHERE outreach_req_type IN( 'Newly Certified Children (excluding Foster Care and SSI)')
AND instance_status = 'Active'
AND TRUNC(create_dt) < TO_DATE('01/01/2018','mm/dd/yyyy');

commit;
