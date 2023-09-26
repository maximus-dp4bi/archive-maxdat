insert into cc_a_list_lkup (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_ID,START_DATE,END_DATE,COMMENTS)
  values ('DISABLE_EMAIL_ALERTS_STARTTIME','DISABLE_EMAIL_ALERTS','DISABLE_EMAIL_ALERTS_STARTTIME','03:00',1,TO_DATE('01-JAN-1900','DD-MON-YYYY'),TO_DATE('31-DEC-2199','DD-MON-YYYY'),'Start time to disable email alerts on CC jobs');

insert into cc_a_list_lkup (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_ID,START_DATE,END_DATE,COMMENTS)
  values ('DISABLE_EMAIL_ALERTS_ENDTIME','DISABLE_EMAIL_ALERTS','DISABLE_EMAIL_ALERTS_ENDTIME','05:00',1,TO_DATE('01-JAN-1900','DD-MON-YYYY'),TO_DATE('31-DEC-2199','DD-MON-YYYY'),'End time to disable email alerts on CC jobs');
  
insert into cc_a_list_lkup (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_ID,START_DATE,END_DATE,COMMENTS)
  values ('LOAD_CC_JOBS_LIST','LOAD_CC_JOBS_LIST','LOAD_CC_JOBS_LIST','load_contact_center,load_interval_data,load_agent_detail,load_agent_by_date,load_agent_performance,load_predictive_dialer_details,load_call_details_v2,load_vm_calls,load_production_planning',1,TO_DATE('01-JAN-1900','DD-MON-YYYY'),TO_DATE('31-DEC-2199','DD-MON-YYYY'),'List of all load contact center related jobs that should run only one at a time');

COMMIT;