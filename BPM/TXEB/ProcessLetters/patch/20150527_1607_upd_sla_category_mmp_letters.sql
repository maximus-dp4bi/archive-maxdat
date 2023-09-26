update D_PL_CURRENT
    set sla_category = 'Dual Eligibility Letter',
      TIMELINESS_STATUS = process_letters.GET_TIMELINE_STATUS(PROGRAM,CREATE_DATE,COMPLETE_DATE,MAILED_DATE,LETTER_TYPE,CASE_ID),
      JEOPARDY_STATUS = process_letters.GET_JEOPARDY_STATUS(PROGRAM,CREATE_DATE,COMPLETE_DATE,LETTER_TYPE),      
      SLA_DAYS = process_letters.GET_SLA_DAYS(PROGRAM,LETTER_TYPE),
      SLA_DAYS_TYPE = process_letters.GET_SLA_DAYS_TYPE(PROGRAM,LETTER_TYPE),
      SLA_JEOPARDY_DATE = process_letters.GET_JEOPARDY_DATE(PROGRAM,CREATE_DATE,LETTER_TYPE),
      SLA_JEOPARDY_DAYS = process_letters.GET_JEOPARDY_DAYS(PROGRAM,LETTER_TYPE),
      SLA_TARGET_DAYS = process_letters.GET_SLA_TARGET_DAYS(PROGRAM,LETTER_TYPE)
where letter_type in('MMP STAR+PLUS Re-enrollment Letter','MMP Unauthorized Disenrollment Request Letter','MMP Loss of Medicare Eligibility Letter');

commit;