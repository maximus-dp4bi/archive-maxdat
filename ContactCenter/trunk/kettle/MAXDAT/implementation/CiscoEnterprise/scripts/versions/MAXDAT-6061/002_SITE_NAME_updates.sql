alter session set current_schema = cisco_enterprise_cc;

alter session set nls_date_format = 'YYYY-MM-DD HH24:MI:SS';

update cc_d_agent
set site_name = 'Maryland', record_eff_dt = '2017-10-09 00:00:00'
where site_name = 'Multiple'
and record_eff_dt >= '2017-10-12 00:00:00'
and record_end_dt <> '2199-12-31 23:59:59';

update cc_d_agent
set record_end_dt = '2017-10-09 00:00:00'
WHERE SITE_NAME IN ('CO Glendale', 'MD HIX', 'MD EB', 'MD LB')
and record_end_dt <> '2199-12-31 23:59:59'
and record_end_dt between '2017-10-12 00:00:00' and '2017-10-13 00:00:00' ;

update cc_d_agent
set record_eff_dt = '2017-10-09 00:00:00'
where site_name = 'Maryland'
and record_eff_dt = '2017-10-18 17:12:59'
and record_end_dt = '2199-12-31 23:59:59'
and version = 2;

update cc_d_agent
set record_eff_dt = '2017-10-09 00:00:00'
where site_name = 'Colorado'
and record_eff_dt = '2017-10-18 17:12:59'
and record_end_dt = '2199-12-31 23:59:59'
and version = 2;

update cc_d_agent
set record_end_dt = '2017-10-09 00:00:00'
WHERE SITE_NAME IN ('CO Glendale', 'MD HIX', 'MD EB', 'MD LB')
and record_end_dt <> '2199-12-31 23:59:59'
and record_end_dt >= '2017-10-18 00:00:00'
and version = 1;

update cc_d_agent
set record_end_dt = '2017-10-09 00:00:00'
WHERE SITE_NAME IN ('CO Glendale', 'MD HIX', 'MD EB', 'MD LB')
and record_end_dt <> '2199-12-31 23:59:59'
and record_end_dt >= '2017-10-12 00:00:00';

update cc_d_agent
set site_name = 'Maryland'
WHERE SITE_NAME IN ('MD HIX', 'MD EB', 'MD LB')
and record_end_dt = '2199-12-31 23:59:59'
and record_eff_dt = '1900-01-01 00:00:00';

update cc_d_agent
set site_name = 'Colorado'
WHERE SITE_NAME IN ('CO Glendale')
and record_end_dt = '2199-12-31 23:59:59'
and record_eff_dt = '1900-01-01 00:00:00';

update cc_d_agent
set site_name = 'Colorado'
where site_name = 'CO Glendale'
and version = 2
and record_end_dt = '2199-12-31 23:59:59';

update cc_d_agent
set record_end_dt = '2017-10-09 00:00:00'
where site_name = 'CO Glendale'
and version = 2
and record_end_dt = '2017-10-18 17:12:59';

update cc_d_agent
set record_eff_dt = '2017-10-09 00:00:00'
where site_name = 'Colorado'
and version = 3
and record_eff_dt = '2017-10-18 17:12:59';

commit;

------------------------------------------------------------

--Validations

select a15.PROJECT_NAME 
 ,a12.SITE_NAME SITE_NAME 
 ,sum(Handle_Calls_Count)CallsHandled 
 from CISCO_ENTERPRISE_CC.CC_F_AGENT_BY_DATE_SV a11 
 left outer join CISCO_ENTERPRISE_CC.CC_D_AGENT_SV a12 
 on (a11.D_AGENT_ID = a12.D_AGENT_ID) 
 left outer join CISCO_ENTERPRISE_CC.CC_D_DATES_SV a13 
 on (a11.D_DATE_ID = a13.D_DATE_ID) 
 left outer join CISCO_ENTERPRISE_CC.CC_D_PROJECT_TARGETS_SV a14 
 on (a11.D_PROJECT_TARGETS_ID = a14.D_PROJECT_TARGETS_ID) 
 left outer join CISCO_ENTERPRISE_CC.CC_D_PROJECT_SV a15 
 on (a14.PROJECT_ID = a15.PROJECT_ID) 
 where a15.PROJECT_NAME in ('MD HBE', 'MD EB', 'MD HIX') 
  and a13.D_DATE >= To_Date('09-10-2017', 'dd-mm-yyyy') 
  group by a15.PROJECT_NAME, a12.SITE_NAME; 
  
  
 
 select * from cc_d_agent
 WHERE SITE_NAME IN ('CO Glendale', 'MD HIX', 'MD EB', 'MD LB')
 and record_end_dt = '2199-12-31 23:59:59'
 and record_eff_dt = '1900-01-01 00:00:00';
 
 select * from cc_d_agent
where login_id = '122037';


select * from cc_d_agent
where site_name = 'CO Glendale'
and record_end_dt = '2199-12-31 23:59:59';


select * from cc_d_agent
where login_id = '0052256';


select * from cc_d_agent
where site_name = 'Colorado'
and version = 3
and record_eff_dt = '2017-10-18 17:12:59';

select * from cc_d_agent
where site_name = 'CO Glendale'
and version = 2
and record_end_dt = '2017-10-18 17:12:59';

select * from cc_f_Agent_by_date
where d_date_id >= 3273
and agent_login_id = '87236';

select * from cc_d_dates
where d_date_id = 3274;

