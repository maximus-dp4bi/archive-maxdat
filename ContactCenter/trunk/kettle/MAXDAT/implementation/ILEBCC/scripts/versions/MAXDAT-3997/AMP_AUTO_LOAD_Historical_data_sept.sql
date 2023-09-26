declare
v_start_date date := to_date('7/1/2016','mm/dd/yyyy');
begin
  
for crep in (select * 
                   from d_reporting_period drep 
                   where drep.end_date > v_start_date 
                   and drep.type = 'MONTHLY' 
                   and drep.end_date < trunc(sysdate) 
                   order by end_date desc) loop
INSERT INTO CC_A_ADHOC_JOB (ADHOC_JOB_TYPE, START_DATETIME_PARAM, END_DATETIME_PARAM, REPORTING_PERIOD_TYPE_PARAM, IS_PENDING)
VALUES ('export_amp_metrics', to_char(trunc(crep.start_date),'YYYY/MM/DD'), to_char(trunc(crep.end_date),'YYYY/MM/DD'), 'MONTHLY', '1');                             
end loop;
end;
       
