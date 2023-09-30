 update corp_etl_list_lkup
  set out_var = 'Incident Type'
  where name='PI_INCIDENT_SLA_BASIS';
  
  update corp_etl_list_lkup
  set out_var = '4'
  where name='PI_JEOPARDY_DAYS';
  
    update corp_etl_list_lkup
  set out_var = '5'
  where name='PI_TIMELINESS_DAYS';

update D_PI_CURRENT
    set
      "Age in Business Days" = DPY_PROCESS_INCIDENTS.GET_AGE_IN_BUSINESS_DAYS("Receipt Date","Complete Date"),
      "Age in Calendar Days" = DPY_PROCESS_INCIDENTS.GET_AGE_IN_CALENDAR_DAYS("Receipt Date","Complete Date"),
      "Status Age in Business Days" = DPY_PROCESS_INCIDENTS.GET_STATUS_AGE_IN_BUS_DAYS("Cur Incident Status Date","Cur Instance Status"),
      "Status Age in Calendar Days" = DPY_PROCESS_INCIDENTS.GET_STATUS_AGE_IN_CAL_DAYS("Cur Incident Status Date","Cur Instance Status"),
      "Cur Jeopardy Status" = DPY_PROCESS_INCIDENTS.GET_JEOPARDY_STATUS("Receipt Date","Cur Instance Status",PRIORITY),
      "Jeopardy Status Date" = DPY_PROCESS_INCIDENTS.GET_JEOPARDY_STATUS_DATE("Receipt Date","Cur Instance Status",PRIORITY),
      "Timeliness Status" = DPY_PROCESS_INCIDENTS.GET_TIMELINESS_STATUS("Receipt Date","Cur Incident Status Date","Cur Instance Status","Cancel Date",PRIORITY)
    where "Create Date" >= to_date('09/01/2017','mm/dd/yyyy')
    and "Cur Instance Status" = 'Complete'
    and "Age in Business Days" <=5
    and "Timeliness Status" = 'Processed Timely';

update D_PI_CURRENT
    set
      "Age in Business Days" = DPY_PROCESS_INCIDENTS.GET_AGE_IN_BUSINESS_DAYS("Receipt Date","Complete Date"),
      "Age in Calendar Days" = DPY_PROCESS_INCIDENTS.GET_AGE_IN_CALENDAR_DAYS("Receipt Date","Complete Date"),
      "Status Age in Business Days" = DPY_PROCESS_INCIDENTS.GET_STATUS_AGE_IN_BUS_DAYS("Cur Incident Status Date","Cur Instance Status"),
      "Status Age in Calendar Days" = DPY_PROCESS_INCIDENTS.GET_STATUS_AGE_IN_CAL_DAYS("Cur Incident Status Date","Cur Instance Status"),
      "Cur Jeopardy Status" = DPY_PROCESS_INCIDENTS.GET_JEOPARDY_STATUS("Receipt Date","Cur Instance Status",PRIORITY),
      "Jeopardy Status Date" = DPY_PROCESS_INCIDENTS.GET_JEOPARDY_STATUS_DATE("Receipt Date","Cur Instance Status",PRIORITY),
      "Timeliness Status" = DPY_PROCESS_INCIDENTS.GET_TIMELINESS_STATUS("Receipt Date","Cur Incident Status Date","Cur Instance Status","Cancel Date",PRIORITY)
    where "Complete Date" is null
    and "Cancel Date" is null;
    
commit;