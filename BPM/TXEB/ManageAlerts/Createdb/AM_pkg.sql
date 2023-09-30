alter session set plsql_code_type = native;

create or replace package AM_pkg is

function am_get_batch_id return number;

function am_get_report_name(p_logname in varchar2, p_report_name in out varchar2, p_redef_id in out number) return number;

function am_get_report_name_email(p_subject in varchar2, p_body in varchar2, p_report_name in out varchar2, p_redef_id in out number ) return number;

function am_get_report_time(p_body in varchar2, p_email_sent_time in timestamp, p_runtime in out timestamp) return number ;

procedure am_upd_fail(p_log_batch_id in number) ;

procedure am_upd_pass(p_log_batch_id in number) ;

procedure am_upd_passexcp(p_log_batch_id in number) ;

procedure am_email_upd(p_email_batch_id in number) ;

end ;
/
create or replace package body am_pkg is

function am_get_batch_id return number is
v_batch_id number;
begin
  select to_number(to_char(sysdate,'YYYYMMDDHH24MISS'))
  into v_batch_id
  from dual;
  return v_batch_id;
end;

function am_get_report_name(p_logname in varchar2, p_report_name in out varchar2, p_redef_id in out number) return number is
v_logname_strip varchar2(200);
begin
  v_logname_strip := upper(regexp_replace(p_logname, '[^[:alnum:]]', NULL));

  select redef_id, report_name
  into p_redef_id, p_report_name
  from d_report_definition redef
  where upper(p_logname) like upper(report_name) || '%'
  and rownum = 1;
  return p_redef_id;
  
exception when no_data_found then
    begin
          v_logname_strip := upper(regexp_replace(p_logname, '[^[:alnum:]]', NULL));

      select redef_id, report_name
      into p_redef_id, p_report_name
      from d_report_definition redef
      where v_logname_strip like '%' || upper(regexp_replace(report_name,'[^[:alnum:]]', NULL)) || '%'
      and rownum = 1;

      return p_redef_id;  
    exception when no_data_found then
      p_report_name := null;
      p_redef_id := null; 
      return p_redef_id; 
    end;
end;

function am_get_report_name_email(p_subject in varchar2, p_body in varchar2, p_report_name in out varchar2, p_redef_id in out number ) return number is
v_subject_strip varchar2(1000);
v_body_strip varchar2(3000);
begin

  select redef_id, report_name
  into p_redef_id, p_report_name
  from d_report_definition redef
  where instr(upper(p_subject),upper(report_name)) > 0 
  and rownum = 1;

  return p_redef_id;
  
exception when no_data_found then
  begin
    select redef_id, report_name
    into p_redef_id, p_report_name
    from d_report_definition redef
    where instr(upper(p_body),upper(report_name)) > 0 
    and rownum = 1;

    return p_redef_id;
  exception when no_data_found then
      begin
            v_subject_strip  := upper(regexp_replace(p_subject, '[^[:alnum:]]', NULL));

            select redef_id, report_name
            into p_redef_id, p_report_name
            from d_report_definition redef
            where v_subject_strip like '%' || upper(regexp_replace(report_name,'[^[:alnum:]]', NULL)) || '%'
            and rownum = 1;
            
            return p_redef_id;  
      exception when no_data_found then
            begin
                v_body_strip := upper(regexp_replace(P_body, '[^[:alnum:]]', NULL));
                
                select redef_id, report_name
                into p_redef_id, p_report_name
                from d_report_definition redef
                where v_body_strip like '%' || upper(regexp_replace(report_name,'[^[:alnum:]]', NULL)) || '%'
                and rownum = 1;
                
                return p_redef_id;  
            exception when no_data_found then
                p_report_name := null;
                p_redef_id := null; 
                return p_redef_id; 
            end;
      end; 
  end;
end;

function am_get_report_time(p_body in varchar2, p_email_sent_time in timestamp, p_runtime in out timestamp) return number is
p_r varchar2(3000);
begin
  p_runtime := trunc(p_email_sent_time, 'HH');
  if instr(p_body, 'Run at: ') > 0 then
     p_r := substr(p_body, instr(p_body, 'Run at: ')+8);
     dbms_output.put_line(p_r);
     p_r := substr(p_r, 1, instr(p_body,chr(10))+1);
     dbms_output.put_line(p_r);
     p_runtime := to_timestamp(p_r, 'mm/dd/yyyy hh:mi:ss pm');
  end if;
return 1;
end;

procedure am_upd_fail(p_log_batch_id in number) is
begin
    update alertlog_stg als
    set als.log_result = 'FAIL'
    --select * from alertlog_stg als
    where 
    als.log_batch_id = p_log_batch_id
    and 
    --als.report_name is not null
    als.log_result is null
    and exists (select 'x'
                       from alertlog_temp_stg alts
                       where alts.log_batch_id = als.log_batch_id
                       and alts.logline like to_char(als.logtime,'YYYY-MM-DD') ||'%Error%FAILED%' || als.logjob_name || '%' || als.logid || '%' || als.log_schd_exec_id || '%'
                       and alts.logtime >= als.logtime
                       )
    ;  
end;

procedure am_upd_passexcp(p_log_batch_id in number) is
begin
  update alertlog_stg als
  set als.log_result = 'COMPLETE-NOEXCP'
--  select * from alertlog_stg als
  where 
  als.log_batch_id = p_log_batch_id
  and 
  --als.report_name is not null
  als.log_result is null
  and exists (select 'x'
                     from alertlog_temp_stg alts
                     where alts.log_batch_id = als.log_batch_id
                     and alts.logline like to_char(als.logtime,'YYYY-MM-DD') ||'%Delivery finished for delivery number%' || als.logjob_name || '%' || als.logid || '%' || als.log_schd_exec_id || '%'
                     and alts.logtime >= als.logtime
                     )
  and exists (select 'x'
                     from alertlog_temp_stg alts
                     where alts.log_batch_id = als.log_batch_id
                     and (alts.logline like to_char(als.logtime,'YYYY-MM-DD') ||'%' || als.logjob_id || '%Return S_OK from DSSPersistResultTask::Run()%' --|| als.logjob_name || '%' || als.logid || '%' || als.log_schd_exec_id || '%'
                          or
                          alts.logline like to_char(als.logtime,'YYYY-MM-DD') || '%Return S_OK from DSSPersistResultTask::Run()%' || '= ' || als.logjob_id || '%'--|| als.logjob_name || '%' || als.logid || '%' || als.log_schd_exec_id || '%'
                          )
                     and alts.logtime >= als.logtime
                     )
  and exists (select 'x'
                     from alertlog_temp_stg alts
                     where alts.log_batch_id = als.log_batch_id
                     and alts.logline like to_char(als.logtime,'YYYY-MM-DD') ||'%Return FALSE from DSSPersistResultTask::hProcessCacheUpdateSubscription%= ' || als.logjob_id || '%Get empty document instance from process context%' --|| als.logjob_name || '%' || als.logid || '%' || als.log_schd_exec_id || '%'
                     and alts.logtime >= als.logtime
                     )
    ;  

  update alertlog_stg als
  set als.log_result = 'COMPLETE-NOEXCP-NODL'
--  select * from alertlog_stg als
  where 
  als.log_batch_id = p_log_batch_id
  and 
  --als.report_name is not null
  als.log_result is null
  and not exists (select 'x'
                     from alertlog_temp_stg alts
                     where alts.log_batch_id = als.log_batch_id
                     and alts.logline like to_char(als.logtime,'YYYY-MM-DD') ||'%Delivery finished for delivery number%' || als.logjob_name || '%' || als.logid || '%' || als.log_schd_exec_id || '%'
                     and alts.logtime >= als.logtime
                     )
  and exists (select 'x'
                     from alertlog_temp_stg alts
                     where alts.log_batch_id = als.log_batch_id
                     and (alts.logline like to_char(als.logtime,'YYYY-MM-DD') ||'%' || als.logjob_id || '%Return S_OK from DSSPersistResultTask::Run()%' --|| als.logjob_name || '%' || als.logid || '%' || als.log_schd_exec_id || '%'
                          or
                          alts.logline like to_char(als.logtime,'YYYY-MM-DD') || '%Return S_OK from DSSPersistResultTask::Run()%' || '= ' || als.logjob_id || '%'--|| als.logjob_name || '%' || als.logid || '%' || als.log_schd_exec_id || '%'
                          )
                     and alts.logtime >= als.logtime
                     )
  and exists (select 'x'
                     from alertlog_temp_stg alts
                     where alts.log_batch_id = als.log_batch_id
                     and alts.logline like to_char(als.logtime,'YYYY-MM-DD') ||'%Return FALSE from DSSPersistResultTask::hProcessCacheUpdateSubscription%= ' || als.logjob_id || '%Get empty document instance from process context%' --|| als.logjob_name || '%' || als.logid || '%' || als.log_schd_exec_id || '%'
                     and alts.logtime >= als.logtime
                     )
    ;  

end;

procedure am_upd_pass(p_log_batch_id in number) is
begin
  update alertlog_stg als
  set als.log_result = 'COMPLETE-EXCP'
--  select * from alertlog_stg als
  where 
  als.log_batch_id = p_log_batch_id
  and 
  --als.report_name is not null
  als.log_result is null
  and exists (select 'x'
                     from alertlog_temp_stg alts
                     where alts.log_batch_id = als.log_batch_id
                     and alts.logline like to_char(als.logtime,'YYYY-MM-DD') ||'%Delivery finished for delivery number%' || als.logjob_name || '%' || als.logid || '%' || als.log_schd_exec_id || '%'
                     and alts.logtime >= als.logtime
                     )
  and exists (select 'x'
                     from alertlog_temp_stg alts
                     where alts.log_batch_id = als.log_batch_id
                     and alts.logline like to_char(als.logtime,'YYYY-MM-DD') ||'%' || als.logjob_id || '%Return S_OK from DSSPersistResultTask::Run()%' --|| als.logjob_name || '%' || als.logid || '%' || als.log_schd_exec_id || '%'
                     and alts.logtime >= als.logtime
                     )
    ;  

end;

procedure am_email_upd(p_email_batch_id in number) is
begin
    update alertemail_stg als
    set als.email_result = 'FAIL'
    --select * from alertlog_stg als
    where 
    als.email_batch_id = p_email_batch_id
    and 
    als.report_name is not null
    and als.email_result is null
    and upper(als.email_subject) like 'FAILURE%'
    ;  

    update alertemail_stg als
    set als.email_result = 'COMPLETE-NOEXCP'
    --select * from alertlog_stg als
    where 
    als.email_batch_id = p_email_batch_id
    and 
    als.report_name is not null
    and als.email_result is null
    and upper(als.email_subject) not like 'FAILURE%'
    ;  

end;

end;
/

alter session set plsql_code_type = interpreted;
