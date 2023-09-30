
update d_pl_current p
set age_in_business_days = BPM_COMMON.BUS_DAYS_BETWEEN(create_date,complete_date)
where instance_status = 'Complete'
and complete_date >= to_date('01/01/2015','mm/dd/yyyy')
and age_in_business_days <> BPM_COMMON.BUS_DAYS_BETWEEN(create_date,complete_date);

update d_pl_current
set timeliness_status = PROCESS_LETTERS.GET_TIMELINE_STATUS(PROGRAM,CREATE_DATE,COMPLETE_DATE,MAILED_DATE,LETTER_TYPE,CASE_ID)
where instance_status = 'Complete'
and complete_date >= to_date('01/01/2015','mm/dd/yyyy')
and timeliness_status <> PROCESS_LETTERS.GET_TIMELINE_STATUS(PROGRAM,CREATE_DATE,COMPLETE_DATE,MAILED_DATE,LETTER_TYPE,CASE_ID);

update d_mfdoc_current
set  "Age in Business Days" = BPM_COMMON.BUS_DAYS_BETWEEN("DCN Create Date","Instance Complete Date")
where "Instance Status" = 'Complete'
and "Instance Complete Date" >=  to_date('01/01/2015','mm/dd/yyyy')
and "Age in Business Days" <> BPM_COMMON.BUS_DAYS_BETWEEN("DCN Create Date","Instance Complete Date");

update d_pi_current
set "Age in Business Days" = BPM_COMMON.BUS_DAYS_BETWEEN("Create Date","Complete Date")
where "Complete Date" is not null
and "Complete Date" >= to_date('01/01/2015','mm/dd/yyyy')
and "Age in Business Days" <> BPM_COMMON.BUS_DAYS_BETWEEN("Create Date","Complete Date");

update d_pi_current
set "Timeliness Status" = DPY_PROCESS_INCIDENTS.GET_TIMELINESS_STATUS("Receipt Date","Cur Incident Status Date","Cur Instance Status","Cancel Date",PRIORITY)
where  "Complete Date" is not null
and "Complete Date" >= to_date('01/01/2015','mm/dd/yyyy')
and "Timeliness Status" <> DPY_PROCESS_INCIDENTS.GET_TIMELINESS_STATUS("Receipt Date","Cur Incident Status Date","Cur Instance Status","Cancel Date",PRIORITY);

update d_mw_current mw
set "Age in Business Days" = BPM_COMMON.BUS_DAYS_BETWEEN("Create Date","Complete Date")
where "Complete Date" is not null
and "Complete Date" >= to_date('01/01/2015','mm/dd/yyyy')
and "Age in Business Days" <> BPM_COMMON.BUS_DAYS_BETWEEN("Create Date","Complete Date");

update d_mw_current
set "Timeliness Status" = MANAGE_WORK.GET_TIMELINESS_STATUS("Complete Date","SLA Days Type","Age in Business Days","Age in Calendar Days","SLA Days")
where "Complete Date" is not null
and "Complete Date" >= to_date('01/01/2015','mm/dd/yyyy')
and "Timeliness Status" <> MANAGE_WORK.GET_TIMELINESS_STATUS("Complete Date","SLA Days Type","Age in Business Days","Age in Calendar Days","SLA Days");

update d_cmor_current
set age_in_business_days = BPM_COMMON.BUS_DAYS_BETWEEN(session_create_date,complete_date)
where instance_status = 'Complete'
and complete_date >= to_date('01/01/2015','mm/dd/yyyy')
and age_in_business_days <> BPM_COMMON.BUS_DAYS_BETWEEN(session_create_date,complete_date);

update d_me_current sc
set age_in_business_days = BPM_COMMON.BUS_DAYS_BETWEEN(create_dt,complete_date)    
where instance_status = 'Complete'
and complete_date >= to_date('01/01/2015','mm/dd/yyyy')
and age_in_business_days <> BPM_COMMON.BUS_DAYS_BETWEEN(create_dt,complete_date);

update d_cor_current cc
set age_in_business_days = BPM_COMMON.BUS_DAYS_BETWEEN(create_date,complete_date)
    , timeliness_status = CLIENT_OUTREACH.GET_TIMELINE_STATUS(create_date,generic_field_2,outreach_request_category, outreach_request_type,
                                              perform_or_step1_end_date,perform_or_step2_end_date,
                                              perform_or_step3_end_date,perform_or_step4_end_date,perform_or_step5_end_date,
                                              outreach_step_6_type,perform_or_step6_end_date,
                                              TO_DATE(reminder_appointment_date,'mm/dd/yy'),complete_date,outreach_request_status)
where instance_status = 'Complete'
and complete_date >= to_date('01/01/2015','mm/dd/yyyy')
and age_in_business_days <> BPM_COMMON.BUS_DAYS_BETWEEN(create_date,complete_date);

commit;