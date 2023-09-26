alter session set current_schema = maxdat_dchix;

update cc_s_agent set first_name = 'Heisy', last_name = 'Posados' where login_id = '18505';
update cc_s_agent set first_name = 'Tymeasha', last_name = 'Cooper' where login_id = '18514';
update cc_s_agent set first_name = 'Shiara', last_name = 'Martinez-Rosario' where login_id = '18518';
update cc_s_agent set first_name = 'Esmeralda', last_name = 'Posados' where login_id = '18522';
update cc_s_agent set first_name = 'Evette', last_name = 'Chambers' where login_id = '18535';
update cc_s_agent set first_name = 'Starcia', last_name = 'Scarborough' where login_id = '18550';
update cc_s_agent set first_name = 'Shauntay', last_name = 'Jennings' where login_id = '18553';
update cc_s_agent set first_name = 'Lucretia', last_name = 'Hampton-Holt' where login_id = '18554';
update cc_s_agent set first_name = 'Arsha', last_name = 'Banks' where login_id = '18555';
update cc_s_agent set first_name = 'Gisell', last_name = 'Batista' where login_id = '18562';
update cc_s_agent set first_name = 'Angela', last_name = 'DeVihena' where login_id = '18569';
update cc_s_agent set first_name = 'Malik', last_name = 'Holbert' where login_id = '18570';
update cc_s_agent set first_name = 'Chantel', last_name = 'Jones' where login_id = '18575';


commit;

select login_id, max(version) from cc_d_agent
where login_id in (
'18555',
'18562',
'18535',
'18514',
'18554',
'18570',
'18553',
'18575',
'18518',
'18522',
'18505',
'18550',
'18569')
group by login_id
order by 2;

update cc_d_agent
set record_end_dt = to_date(sysdate,'DD-MON-RRRR')
where login_id in ('18553', '18522');

update cc_d_agent
set record_end_dt = to_date(sysdate,'DD-MON-RRRR')
where login_id in ( '18550', '18569',  '18562')
and version = 2;

update cc_d_agent
set record_end_dt = to_date(sysdate,'DD-MON-RRRR')
where login_id in ('18505', '18514')
and version = 3;

update cc_d_agent
set record_end_dt = to_date(sysdate,'DD-MON-RRRR')
where login_id in ('18575', '18555', '18518', '18554')
and version = 4;

update cc_d_agent
set record_end_dt = to_date(sysdate,'DD-MON-RRRR')
where login_id in ( '18535', '18570')
and version = 5;

commit;


insert into CC_D_AGENT (LOGIN_ID,FIRST_NAME,MIDDLE_INITIAL,LAST_NAME,JOB_TITLE,LANGUAGE,SITE_NAME,HOURLY_RATE,RATE_CURRENCY,HIRE_DATE,TERMINATION_DATE,VERSION,RECORD_EFF_DT,RECORD_END_DT)  values ('18505','Heisy',' ','Posados','CSR','English','Washington D.C.',0,'USD',null,null,4,to_date(sysdate,'DD-MON-RRRR'),to_date('31-DEC-2199','DD-MON-RRRR'));
insert into CC_D_AGENT (LOGIN_ID,FIRST_NAME,MIDDLE_INITIAL,LAST_NAME,JOB_TITLE,LANGUAGE,SITE_NAME,HOURLY_RATE,RATE_CURRENCY,HIRE_DATE,TERMINATION_DATE,VERSION,RECORD_EFF_DT,RECORD_END_DT)  values ('18514','Tymeasha',' ','Cooper ','CSR','English','Washington D.C.',0,'USD',null,null,4,to_date(sysdate,'DD-MON-RRRR'),to_date('31-DEC-2199','DD-MON-RRRR'));
insert into CC_D_AGENT (LOGIN_ID,FIRST_NAME,MIDDLE_INITIAL,LAST_NAME,JOB_TITLE,LANGUAGE,SITE_NAME,HOURLY_RATE,RATE_CURRENCY,HIRE_DATE,TERMINATION_DATE,VERSION,RECORD_EFF_DT,RECORD_END_DT)  values ('18518','Shiara',' ','Martinez-Rosario','CSR','English','Washington D.C.',0,'USD',null,null,5,to_date(sysdate,'DD-MON-RRRR'),to_date('31-DEC-2199','DD-MON-RRRR'));
insert into CC_D_AGENT (LOGIN_ID,FIRST_NAME,MIDDLE_INITIAL,LAST_NAME,JOB_TITLE,LANGUAGE,SITE_NAME,HOURLY_RATE,RATE_CURRENCY,HIRE_DATE,TERMINATION_DATE,VERSION,RECORD_EFF_DT,RECORD_END_DT)  values ('18522','Esmeralda',' ','Posados','CSR','English','Washington D.C.',0,'USD',null,null,2,to_date(sysdate,'DD-MON-RRRR'),to_date('31-DEC-2199','DD-MON-RRRR'));
insert into CC_D_AGENT (LOGIN_ID,FIRST_NAME,MIDDLE_INITIAL,LAST_NAME,JOB_TITLE,LANGUAGE,SITE_NAME,HOURLY_RATE,RATE_CURRENCY,HIRE_DATE,TERMINATION_DATE,VERSION,RECORD_EFF_DT,RECORD_END_DT)  values ('18535','Evette',' ','Chambers','CSR','English','Washington D.C.',0,'USD',null,null,6,to_date(sysdate,'DD-MON-RRRR'),to_date('31-DEC-2199','DD-MON-RRRR'));
insert into CC_D_AGENT (LOGIN_ID,FIRST_NAME,MIDDLE_INITIAL,LAST_NAME,JOB_TITLE,LANGUAGE,SITE_NAME,HOURLY_RATE,RATE_CURRENCY,HIRE_DATE,TERMINATION_DATE,VERSION,RECORD_EFF_DT,RECORD_END_DT)  values ('18550','Starcia',' ','Scarborough','CSR','English','Washington D.C.',0,'USD',null,null,3,to_date(sysdate,'DD-MON-RRRR'),to_date('31-DEC-2199','DD-MON-RRRR'));
insert into CC_D_AGENT (LOGIN_ID,FIRST_NAME,MIDDLE_INITIAL,LAST_NAME,JOB_TITLE,LANGUAGE,SITE_NAME,HOURLY_RATE,RATE_CURRENCY,HIRE_DATE,TERMINATION_DATE,VERSION,RECORD_EFF_DT,RECORD_END_DT)  values ('18553','Shauntay',' ','Jennings','CSR','English','Washington D.C.',0,'USD',null,null,2,to_date(sysdate,'DD-MON-RRRR'),to_date('31-DEC-2199','DD-MON-RRRR'));
insert into CC_D_AGENT (LOGIN_ID,FIRST_NAME,MIDDLE_INITIAL,LAST_NAME,JOB_TITLE,LANGUAGE,SITE_NAME,HOURLY_RATE,RATE_CURRENCY,HIRE_DATE,TERMINATION_DATE,VERSION,RECORD_EFF_DT,RECORD_END_DT)  values ('18554','Lucretia',' ','Hampton-Holt','CSR','English','Washington D.C.',0,'USD',null,null,5,to_date(sysdate,'DD-MON-RRRR'),to_date('31-DEC-2199','DD-MON-RRRR'));
insert into CC_D_AGENT (LOGIN_ID,FIRST_NAME,MIDDLE_INITIAL,LAST_NAME,JOB_TITLE,LANGUAGE,SITE_NAME,HOURLY_RATE,RATE_CURRENCY,HIRE_DATE,TERMINATION_DATE,VERSION,RECORD_EFF_DT,RECORD_END_DT)  values ('18555','Arsha',' ','Banks','CSR','English','Washington D.C.',0,'USD',null,null,5,to_date(sysdate,'DD-MON-RRRR'),to_date('31-DEC-2199','DD-MON-RRRR'));
insert into CC_D_AGENT (LOGIN_ID,FIRST_NAME,MIDDLE_INITIAL,LAST_NAME,JOB_TITLE,LANGUAGE,SITE_NAME,HOURLY_RATE,RATE_CURRENCY,HIRE_DATE,TERMINATION_DATE,VERSION,RECORD_EFF_DT,RECORD_END_DT)  values ('18562','Gisell',' ','Batista','CSR','English','Washington D.C.',0,'USD',null,null,3,to_date(sysdate,'DD-MON-RRRR'),to_date('31-DEC-2199','DD-MON-RRRR'));
insert into CC_D_AGENT (LOGIN_ID,FIRST_NAME,MIDDLE_INITIAL,LAST_NAME,JOB_TITLE,LANGUAGE,SITE_NAME,HOURLY_RATE,RATE_CURRENCY,HIRE_DATE,TERMINATION_DATE,VERSION,RECORD_EFF_DT,RECORD_END_DT)  values ('18569','Angela',' ','DeVihena','CSR','English','Washington D.C.',0,'USD',null,null,3,to_date(sysdate,'DD-MON-RRRR'),to_date('31-DEC-2199','DD-MON-RRRR'));
insert into CC_D_AGENT (LOGIN_ID,FIRST_NAME,MIDDLE_INITIAL,LAST_NAME,JOB_TITLE,LANGUAGE,SITE_NAME,HOURLY_RATE,RATE_CURRENCY,HIRE_DATE,TERMINATION_DATE,VERSION,RECORD_EFF_DT,RECORD_END_DT)  values ('18570','Malik',' ','Holbert','CSR','English','Washington D.C.',0,'USD',null,null,6,to_date(sysdate,'DD-MON-RRRR'),to_date('31-DEC-2199','DD-MON-RRRR'));
insert into CC_D_AGENT (LOGIN_ID,FIRST_NAME,MIDDLE_INITIAL,LAST_NAME,JOB_TITLE,LANGUAGE,SITE_NAME,HOURLY_RATE,RATE_CURRENCY,HIRE_DATE,TERMINATION_DATE,VERSION,RECORD_EFF_DT,RECORD_END_DT)  values ('18575','Chantel ',' ','Jones','CSR','English','Washington D.C.',0,'USD',null,null,5,to_date(sysdate,'DD-MON-RRRR'),to_date('31-DEC-2199','DD-MON-RRRR'));

commit;


