alter session set current_schema = maxdat_dchix;

update cc_d_agent
set record_end_dt = to_date('03-FEB-21','DD-MON-RR')
where login_id = '18549'
and first_name = 'Anthony'
and last_name = 'Page';

update cc_s_agent
set first_name = 'Ayesha', last_name = 'Cumberbatch', extract_dt = to_date(sysdate,'DD-MON-RRRR')
where login_id = '18549';

insert into CC_D_AGENT (LOGIN_ID,FIRST_NAME,MIDDLE_INITIAL,LAST_NAME,JOB_TITLE,LANGUAGE,SITE_NAME,HOURLY_RATE,RATE_CURRENCY,HIRE_DATE,TERMINATION_DATE,VERSION,RECORD_EFF_DT,RECORD_END_DT) 
values ('18549','Ayesha',' ','Cumberbatch','CSR','English','Washington D.C.',0,'USD',null,null,3,to_date('03-FEB-2021','DD-MON-RRRR'),to_date('31-DEC-2199','DD-MON-RRRR'));

commit;