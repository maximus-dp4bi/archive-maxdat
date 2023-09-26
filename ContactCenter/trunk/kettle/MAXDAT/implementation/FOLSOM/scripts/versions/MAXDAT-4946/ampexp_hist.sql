create or replace package ampexp_hist is
function check_params(p_calling_proc in varchar2, p_date in date, p_reporting_type in varchar2, p_partial in varchar2, p_project_name in varchar2, p_program_name in varchar2) return varchar2;

procedure create_hist_ampexp_golive(p_golive_date in date, p_reporting_type in varchar2, p_partial in varchar2, p_project_name in varchar2, p_program_name in varchar2);

procedure create_hist_ampexp_monthly(p_month in date, p_project_name in varchar2, p_program_name in varchar2);

procedure create_hist_ampexp_weekly(p_monday in date, p_project_name in varchar2, p_program_name in varchar2);

procedure create_hist_ampexp_projects(p_month in date, p_reporting_type in varchar2, p_project_list in varchar2);
end ;
/
create or replace package body ampexp_hist is

function check_params(p_calling_proc in varchar2, p_date in date, p_reporting_type in varchar2, p_partial in varchar2, p_project_name in varchar2, p_program_name in varchar2) return varchar2
 is
v_error_txt varchar2(100);
v_count number := 0;
 begin
if p_date is null and p_calling_proc = 'create_hist_ampexp_golive' then
   v_error_txt := 'Go live date required';
   return v_error_txt;
end if;
if p_date >= sysdate and p_calling_proc = 'create_hist_ampexp_golive' then
   v_count := 0;
   select count(1) into v_count from d_reporting_period drep where drep.end_date > p_date and drep.end_date < trunc(sysdate);
   if v_count = 0 then
     v_error_txt := 'No valid reporting periods available for Go live date';
   return v_error_txt;
   end if;
end if;
if upper(p_reporting_type) <> 'MONTHLY' and upper(p_reporting_type) <> 'WEEKLY' and p_calling_proc = 'create_hist_ampexp_golive' then
   v_error_txt := 'Reporting type should be MONTHLY/WEEKLY';
   return v_error_txt;
end if;
if p_partial <> 'Y' and p_partial <> 'N' and p_calling_proc in ( 'create_hist_ampexp_golive', 'create_hist_ampexp_weekly') then
   v_error_txt := 'Partial should be Y/N';
   return v_error_txt;
end if;
if p_date is null and p_calling_proc = 'create_hist_ampexp_monthly' then
   return 'Month parameter required';
end if;
if p_date >= sysdate and p_calling_proc = 'create_hist_ampexp_monthly' then
   v_count := 0;
   select count(1) into v_count from d_reporting_period drep where trunc(drep.start_date,'MM') = trunc(p_date,'MM');
   if v_count = 0 then
     v_error_txt := 'No valid reporting periods available for month';
   return v_error_txt;
   end if;
end if;

if p_date is null and p_calling_proc = 'create_hist_ampexp_weekly' then
   return 'Monday of the week parameter required';
end if;
if p_date >= sysdate and p_calling_proc = 'create_hist_ampexp_weekly' then
   v_count := 0;
   select count(1) into v_count from d_reporting_period drep where drep.type = 'WEEKLY' and p_date between drep.start_date and drep.end_date ;
   if v_count = 0 then
     v_error_txt := 'No valid reporting periods available for given date';
   return v_error_txt;
   end if;
end if;

if p_project_name is not null then
      v_count := 0;
      select count(1) into v_count from  cc_c_project_config where project_name = p_project_name;
      if v_count = 0 then
         v_error_txt := 'Project does not exist in cc_c_project_config';
            return v_error_txt;
      end if;
end if;
if p_project_name is null and p_program_name is not null then
   v_error_txt := 'Project name is required for Program name';
   return v_error_txt;
end if;
if p_program_name is not null then
      v_count := 0;
      select count(1) into v_count from  cc_c_project_config where project_name = p_project_name and program_name = p_program_name;
      if v_count = 0 then
         v_error_txt := 'Project and Program does not exist in cc_c_project_config';
            return v_error_txt;
      end if;
end if;
return null;
end;

procedure create_hist_ampexp_golive(p_golive_date in date, p_reporting_type in varchar2, p_partial in varchar2, p_project_name in varchar2, p_program_name in varchar2) is
v_start_date date := p_golive_date;
v_adhoc_job_id number := 0;
invalid_params exception;
v_error_txt varchar2(100);
v_calling_proc varchar2(40) := 'create_hist_ampexp_golive';
begin
--check input vars
v_error_txt := check_params(v_calling_proc, p_golive_date , p_reporting_type, p_partial ,p_project_name , p_program_name);
if v_error_txt is not null then
   raise invalid_params;
end if;
    -- create req
for crep in (select *
                   from d_reporting_period drep
                   where drep.end_date >= v_start_date
                   and (p_partial = 'Y' or (p_partial <> 'Y' and drep.start_date >= v_start_date))
                   and drep.type = upper(p_reporting_type)
                   and drep.end_date < trunc(sysdate)
                   order by end_date desc) loop
INSERT INTO CC_A_ADHOC_JOB (ADHOC_JOB_TYPE, START_DATETIME_PARAM, END_DATETIME_PARAM, REPORTING_PERIOD_TYPE_PARAM, IS_PENDING)
VALUES ('export_amp_metrics', to_char(trunc(crep.start_date),'YYYY/MM/DD'), to_char(trunc(crep.end_date),'YYYY/MM/DD'), upper(p_reporting_type), '1')
returning adhoc_job_id into v_adhoc_job_id;

if p_project_name is not null then
   insert into cc_a_ampexp_filter values('A', v_adhoc_job_id, p_project_name, p_program_name, null);
end if;
end loop;

commit;
exception when invalid_params then
          raise_application_error(-20001,'An error was encountered - '||v_error_txt);
          return;
          when others then
          raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
end;

procedure create_hist_ampexp_monthly(p_month in date, p_project_name in varchar2, p_program_name in varchar2) is
v_adhoc_job_id number := 0;
invalid_params exception;
v_error_txt varchar2(100);
v_calling_proc varchar2(40) := 'create_hist_ampexp_monthly';
begin
--check input vars
v_error_txt := check_params(v_calling_proc, p_month , null, null ,p_project_name , p_program_name);
if v_error_txt is not null then
   raise invalid_params;
end if;

for crep in (select *
                   from d_reporting_period drep
                   where trunc(drep.end_date,'MM') = trunc( p_month,'MM')
                   and drep.type = 'MONTHLY'
                   order by end_date desc) loop
INSERT INTO CC_A_ADHOC_JOB (ADHOC_JOB_TYPE, START_DATETIME_PARAM, END_DATETIME_PARAM, REPORTING_PERIOD_TYPE_PARAM, IS_PENDING)
VALUES ('export_amp_metrics', to_char(trunc(crep.start_date),'YYYY/MM/DD'), to_char(trunc(crep.end_date),'YYYY/MM/DD'), 'MONTHLY', '1')
returning adhoc_job_id into v_adhoc_job_id;

if p_project_name is not null then
   insert into cc_a_ampexp_filter values('A', v_adhoc_job_id, p_project_name, p_program_name, null);
end if;
end loop;

commit;
exception when invalid_params then
          raise_application_error(-20001,'An error was encountered - '||v_error_txt);
          return;
          when others then
          raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
end;

procedure create_hist_ampexp_weekly(p_monday in date, p_project_name in varchar2, p_program_name in varchar2) is
v_adhoc_job_id number := 0;
invalid_params exception;
v_error_txt varchar2(100);
v_calling_proc varchar2(40) := 'create_hist_ampexp_weekly';
begin
--check input vars
v_error_txt := check_params(v_calling_proc, p_monday , null, null ,p_project_name , p_program_name);
if v_error_txt is not null then
   raise invalid_params;
end if;

for crep in (select *
                   from d_reporting_period drep
                   where p_monday between drep.start_date and drep.end_date
                   and drep.type = 'WEEKLY'
                   order by end_date desc) loop
INSERT INTO CC_A_ADHOC_JOB (ADHOC_JOB_TYPE, START_DATETIME_PARAM, END_DATETIME_PARAM, REPORTING_PERIOD_TYPE_PARAM, IS_PENDING)
VALUES ('export_amp_metrics', to_char(trunc(crep.start_date),'YYYY/MM/DD'), to_char(trunc(crep.end_date),'YYYY/MM/DD'), 'WEEKLY', '1')
returning adhoc_job_id into v_adhoc_job_id;

if p_project_name is not null then
   insert into cc_a_ampexp_filter values('A', v_adhoc_job_id, p_project_name, p_program_name, null);
end if;
end loop;

commit;
exception when invalid_params then
          raise_application_error(-20001,'An error was encountered - '||v_error_txt);
          return;
          when others then
          raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
end;

procedure create_hist_ampexp_projects(p_month in date, p_reporting_type in varchar2, p_project_list in varchar2) is
v_adhoc_job_id number := 0;
invalid_params exception;
v_error_txt varchar2(100);
v_calling_proc varchar2(40) := 'create_hist_ampexp_projects';
begin
  
--check input vars
if p_project_list is null then
   v_error_txt := 'Project list cannot be empty';
   raise invalid_params;
end if;

for cproj in (select regexp_substr(p_project_list ,'[^,]+', 1, level) project_name from dual
      connect by regexp_substr(p_project_list , '[^,]+', 1, level) is not null)
loop      
v_error_txt := check_params(v_calling_proc, p_month , p_reporting_type, null ,cproj.project_name , null);
if v_error_txt is not null then
   raise invalid_params;
end if;
end loop;

  for crep in (select *
                     from d_reporting_period drep
                     where p_month between drep.start_date and drep.end_date
                     and drep.type = upper(p_reporting_type)
                     order by end_date desc) loop
  INSERT INTO CC_A_ADHOC_JOB (ADHOC_JOB_TYPE, START_DATETIME_PARAM, END_DATETIME_PARAM, REPORTING_PERIOD_TYPE_PARAM, IS_PENDING)
  VALUES ('export_amp_metrics', to_char(trunc(crep.start_date),'YYYY/MM/DD'), to_char(trunc(crep.end_date),'YYYY/MM/DD'), upper(p_reporting_type), '1')
  returning adhoc_job_id into v_adhoc_job_id;

      for cproj in (select regexp_substr(p_project_list ,'[^,]+', 1, level) project_name from dual
            connect by regexp_substr(p_project_list , '[^,]+', 1, level) is not null)
      loop      
      if cproj.project_name is not null then
         insert into cc_a_ampexp_filter values('A', v_adhoc_job_id, cproj.project_name, null, null);
      end if;
      end loop;
  end loop;
commit;
exception when invalid_params then
          raise_application_error(-20001,'An error was encountered - '||v_error_txt);
          return;
          when others then
          raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
end;
  
  
end;
/
