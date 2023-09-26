update corp_etl_proc_letters
set letter_type = 'Termination for Failure to Respond'
where letter_type = 'Termination (for failure to respond to renewal packet)';

update letters_stg
set letter_type = 'Termination for Failure to Respond'
where letter_type = 'Termination (for failure to respond to renewal packet)';


update corp_etl_proc_letters
set letter_type = 'Initial Renewal Packet (MAGI)'
where letter_type = 'Application Renewal Notice for MAGI cases';

update letters_stg
set letter_type = 'Initial Renewal Packet (MAGI)'
where letter_type = 'Application Renewal Notice for MAGI cases';

update corp_etl_proc_letters
set letter_type = 'LTSS Initial Renewal Packet'
where letter_type = 'Application Renewal Notice for LTSS cases';

update letters_stg
set letter_type = 'LTSS Initial Renewal Packet'
where letter_type = 'Application Renewal Notice for LTSS cases';

  update D_PL_CURRENT
    set
      AGE_IN_BUSINESS_DAYS = process_letters.GET_AGE_IN_BUSINESS_DAYS(CREATE_DATE,COMPLETE_DATE),
      AGE_IN_CALENDAR_DAYS = process_letters.GET_AGE_IN_CALENDAR_DAYS(CREATE_DATE,COMPLETE_DATE),
      TIMELINESS_STATUS = process_letters.GET_TIMELINESS_STATUS(LETTER_TYPE,NEWBORN_FLAG,CREATE_DATE,COMPLETE_DATE),
      JEOPARDY_STATUS = process_letters.GET_JEOPARDY_STATUS(LETTER_TYPE,NEWBORN_FLAG,CREATE_DATE,COMPLETE_DATE),      
      SLA_DAYS = process_letters.GET_SLA_DAYS(LETTER_TYPE,NEWBORN_FLAG),
      SLA_DAYS_TYPE = process_letters.GET_SLA_DAYS_TYPE(LETTER_TYPE,NEWBORN_FLAG),
      SLA_JEOPARDY_DATE = process_letters.GET_JEOPARDY_DATE(LETTER_TYPE,NEWBORN_FLAG,CREATE_DATE),
      SLA_JEOPARDY_DAYS = process_letters.GET_JEOPARDY_DAYS(LETTER_TYPE,NEWBORN_FLAG),
      SLA_TARGET_DAYS =process_letters.GET_SLA_TARGET_DAYS(LETTER_TYPE,NEWBORN_FLAG)
    where
      sla_days = 2;

commit;