update D_NYHIX_DOC_NOTIF_CURRENT  
set jeopardy_flag = 'NA'
   ,age_in_calendar_days = NYHIX_DOC_NOTIFICATIONS.GET_AGE_IN_CALENDAR_DAYS(CREATE_DT,CANCEL_DT)
   ,age_in_business_days = NYHIX_DOC_NOTIFICATIONS.GET_AGE_IN_BUSINESS_DAYS(CREATE_DT,CANCEL_DT)
   ,timeliness_status = 'Not Required'
where complete_dt is null
and cancel_dt is not null
and (jeopardy_flag != 'NA' or trunc(CANCEL_DT) - trunc(CREATE_DT) != age_in_Calendar_days or NYHIX_DOC_NOTIFICATIONS.GET_AGE_IN_BUSINESS_DAYS(CREATE_DT,CANCEL_DT) != age_in_business_days );

commit;