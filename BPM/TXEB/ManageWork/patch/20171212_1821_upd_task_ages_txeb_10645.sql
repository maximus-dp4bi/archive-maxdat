update D_MW_CURRENT
    set
      "Age in Business Days" = manage_work.GET_AGE_IN_BUSINESS_DAYS("Create Date","Complete Date"),
      "Age in Calendar Days" = manage_work.GET_AGE_IN_CALENDAR_DAYS("Create Date","Complete Date"),
      "Jeopardy Flag" = manage_work.GET_JEOPARDY_FLAG("SLA Days Type","Age in Business Days","Age in Calendar Days","SLA Jeopardy Days","Jeopardy Flag"),
      "Status Age in Business Days" = manage_work.GET_STATUS_AGE_IN_BUS_DAYS("Current Status Date","Complete Date"),
      "Status Age in Calendar Days" = manage_work.GET_STATUS_AGE_IN_CAL_DAYS("Current Status Date","Complete Date"),
      "Timeliness Status" = manage_work.GET_TIMELINESS_STATUS("Complete Date","SLA Days Type","Age in Business Days","Age in Calendar Days","SLA Days")
where  "Current Task Type" like '%Data En%'--"Create Date" >= to_date('01/01/2017','mm/dd/yyyy')
and "Complete Date" is not null
--and "Age in Business Days" <> manage_work.GET_AGE_IN_BUSINESS_DAYS("Create Date","Complete Date")
and "Timeliness Status" <> manage_work.GET_TIMELINESS_STATUS("Complete Date","SLA Days Type","Age in Business Days","Age in Calendar Days","SLA Days")
;

commit;