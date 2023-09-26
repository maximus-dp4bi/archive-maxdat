--1
update corp_etl_clnt_outreach
set outreach_status = 'Outreach Unsuccessful'
   ,outreach_status_dt = complete_dt
   ,cancel_reason = 'Clean-up activity - updated status to a terminal status for completed instances - Aug 2015'
where outreach_id in(49813542, 49826381, 52408760);

--2
update corp_etl_clnt_outreach
set outreach_status = 'Outreach No Longer Required'
    ,outreach_status_dt = cancel_dt    
where outreach_req_type = 'TP 40/NOA Recipients'
and instance_status = 'Complete'
and outreach_status = 'Outreach Request Initiated';

--3
update corp_etl_clnt_outreach
set outreach_status = 'Outreach Invalid Request'
    ,outreach_status_dt = sysdate
    ,cancel_dt = sysdate
    ,cancel_by = 'TXEB-5614'
    ,cancel_method = 'Exception'
    ,cancel_reason = 'Clean-up activity - updated status to a terminal status for completed instances - Aug 2015'
    ,complete_dt = sysdate
    ,stage_done_date = sysdate
    ,instance_status = 'Complete'
    ,outreach_req_type = 'THSteps Checkup OverDue Letters'
where outreach_id in(45398264,
45398292,
45398378,
45398414,
45398489,
45398796,
45398837,
45398852,
45398877,
45398893);


update corp_etl_clnt_outreach
set outreach_status = 'Outreach Invalid Request'
    ,outreach_status_dt = sysdate
    ,cancel_dt = sysdate
    ,cancel_by = 'TXEB-5614'
    ,cancel_method = 'Exception'
    ,cancel_reason = 'Clean-up activity - updated status to a terminal status for completed instances - Aug 2015'
    ,complete_dt = sysdate
    ,stage_done_date = sysdate
    ,instance_status = 'Complete'
    ,outreach_req_type = 'THSteps Checkup Due Letters'
where outreach_id in(45398264,
45398292,
45398378,
45398414,
45398489,
45398796,
45398837,
45398852,
45398877,
45398893);

--4
update corp_etl_clnt_outreach
set complete_dt = outreach_status_dt
    ,cancel_reason = 'Clean-up activity - updated status to a terminal status for completed instances - Aug 2015'
    ,stage_done_date = sysdate
    ,instance_status = 'Complete'
where outreach_req_type = 'TP 40/NOA Recipients'
and instance_status = 'Active'
and outreach_status = 'Outreach Unsuccessful';

update corp_etl_clnt_outreach
set complete_dt = outreach_status_dt
    ,cancel_reason = 'Clean-up activity - updated status to a terminal status for completed instances - Aug 2015'
    ,stage_done_date = sysdate
    ,instance_status = 'Complete'
where outreach_id =52809220 ;

--5
update corp_etl_clnt_outreach
set outreach_status = 'Outreach Invalid Request'    
    ,cancel_dt = outreach_status_dt
    ,cancel_by = 'TXEB-5614'
    ,cancel_method = 'Exception'
    ,cancel_reason = 'Clean-up activity - updated status to a terminal status for completed instances - Aug 2015'
    ,complete_dt = outreach_status_dt
    ,stage_done_date = sysdate
    ,instance_status = 'Complete'
where outreach_req_type = 'THSteps Checkup Overdue Letters'
and instance_status = 'Active'
and outreach_status = 'Outreach Request Initiated';   

--6
update corp_etl_clnt_outreach
set outreach_status = 'Outreach Invalid Request'    
    ,cancel_dt = outreach_status_dt
    ,cancel_by = 'TXEB-5614'
    ,cancel_method = 'Exception'
    ,cancel_reason = 'Clean-up activity - updated status to a terminal status for completed instances - Aug 2015'
    ,complete_dt = outreach_status_dt
    ,stage_done_date = sysdate
    ,instance_status = 'Complete'
where outreach_req_type = 'THSteps Checkup Overdue Letters'
and instance_status = 'Active'
and outreach_status = 'Outreach Request Initiated';    

--7
update corp_etl_clnt_outreach
set outreach_status = 'Outreach Successful'    
    ,cancel_reason = 'Clean-up activity - updated status to a terminal status for completed instances - Aug 2015'
    ,complete_dt = outreach_status_dt
    ,stage_done_date = sysdate
    ,instance_status = 'Complete'
where outreach_req_type = 'THSteps Checkup OverDue Medical Letters'
and instance_status = 'Active'
and outreach_status = 'Outreach Request Initiated';  

--8 and 10

update corp_etl_clnt_outreach
set complete_dt = outreach_status_dt
    ,cancel_reason = 'Clean-up activity - updated status to a terminal status for completed instances - Aug 2015'
    ,stage_done_date = sysdate
    ,instance_status = 'Complete'
where outreach_req_type in('THSteps Checkup OverDue Medical Letters','THSteps Checkup OverDue Dental Letters')
and instance_status = 'Active'
and outreach_status = 'Outreach Successful';

--9
update corp_etl_clnt_outreach
set outreach_status = 'Outreach Successful'    
    ,cancel_reason = 'Clean-up activity - updated status to a terminal status for completed instances - Aug 2015'
    ,complete_dt = outreach_status_dt
    ,stage_done_date = sysdate
    ,instance_status = 'Complete'
where outreach_req_type = 'THSteps Checkup OverDue Medical Letters'
and instance_status = 'Active'
and outreach_status = 'Outreach Request Initiated';  

--11
update corp_etl_clnt_outreach
set outreach_status = 'Outreach Successful'    
    ,cancel_reason = 'Clean-up activity - updated status to a terminal status for completed instances - Aug 2015'
    ,complete_dt = outreach_status_dt
    ,stage_done_date = sysdate
    ,instance_status = 'Complete'
where outreach_req_type = 'THSteps Checkup Due Medical Letters'
and instance_status = 'Active'
and outreach_status = 'Outreach Request Initiated';  


--12
update corp_etl_clnt_outreach
set outreach_status = 'Outreach Successful'    
    ,cancel_reason = 'Clean-up activity - updated status to a terminal status for completed instances - Aug 2015'
    ,complete_dt = outreach_status_dt
    ,stage_done_date = sysdate
    ,instance_status = 'Complete'
where outreach_req_type = 'THSteps Checkup Due Dental Letters'
and instance_status = 'Active'
and outreach_status = 'Outreach Request Initiated'; 

commit;