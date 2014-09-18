alter session set plsql_code_type = native;

create or replace package SVN_REVISION_KEYWORD as

  SVN_FILE_URL varchar2(200) := '$URL$';
  SVN_REVISION varchar2(20) := '$Revision$';
  SVN_REVISION_DATE varchar2(60) := '$Date$';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  function GET_VALUE 
    (p_package_keyword in varchar2) 
    return varchar2;

  function GET_SVN_FILE_URL
    (p_package_name in varchar2)
    return varchar2;
    
  function GET_SVN_REVISION
    (p_package_name in varchar2)
    return number;
    
  function GET_SVN_REVISION_DATE
    (p_package_name in varchar2)
    return date;
    
  function GET_SVN_REVISION_AUTHOR
    (p_package_name in varchar2)
    return varchar2;
    
end;
/


create or replace package body SVN_REVISION_KEYWORD as

  function GET_VALUE (p_package_keyword in varchar2) return varchar2
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_VALUE';
    v_sql_code number := null;
    v_log_message clob := null;
    v_keyword_value varchar2(200) := null;
  begin
    execute immediate 'begin :v_string := ' || BPM_COMMON.CLEAN_PARAMETER(p_package_keyword) || '; end;' using out v_keyword_value;   
    return v_keyword_value;
  exception
    when others then
      v_sql_code := SQLCODE;
      -- Do not log error if only missing SVN keyword.
      if v_sql_code != -6550 then
        v_log_message := 'Unable to get value for "' || p_package_keyword || '".  ' || SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null,v_procedure_name,null,null,null,null,null,v_log_message,v_sql_code);
      end if; 
      return null;
  end;
  

  function GET_SVN_FILE_URL
    (p_package_name in varchar2)
    return varchar2
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_SVN_FILE_URL';
    v_sql_code number := null;
    v_log_message clob := null;
    v_keyword_value varchar2(200) := null;
    v_length_value_prefix number := length('$URL: ') + 1;
    v_length_value_suffix number := 1;
  begin
    select GET_VALUE(p_package_name || '.SVN_FILE_URL') into v_keyword_value from dual;
    return substr(v_keyword_value,v_length_value_prefix,(nvl(length(v_keyword_value),0) - (v_length_value_prefix + 1)));
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to get deployed SVN_FILE_URL for package "' || p_package_name || '".  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,null,v_log_message,v_sql_code);
      return null;
  end;
    

  function GET_SVN_REVISION
    (p_package_name in varchar2)
    return number
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_SVN_REVISION';
    v_sql_code number := null;
    v_log_message clob := null;
    v_keyword_value varchar2(200) := null;
    v_length_value_prefix number := length('$Revision: ') + 1;
    v_length_value_suffix number := 1;
  begin
    select GET_VALUE(p_package_name || '.SVN_REVISION') into v_keyword_value from dual;
    return to_number(substr(v_keyword_value,v_length_value_prefix,(nvl(length(v_keyword_value),0) - (v_length_value_prefix + 1))));
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to get deployed SVN_REVISION for package "' || p_package_name || '".  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,null,v_log_message,v_sql_code);
      return null;
  end;   
    

  function GET_SVN_REVISION_DATE
    (p_package_name in varchar2)
    return date
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_SVN_REVISION_DATE';
    v_sql_code number := null;
    v_log_message clob := null;
    v_keyword_value varchar2(200) := null;
    v_length_value_prefix number := length('$Date: ') + 1;
    v_length_value_suffix number := length('-nnnn (Day, dd Mon YYYY) ');
  begin
    select GET_VALUE(p_package_name || '.SVN_REVISION_DATE') into v_keyword_value from dual;
    return to_date(substr(v_keyword_value,v_length_value_prefix,(nvl(length(v_keyword_value),0) - (v_length_value_prefix + v_length_value_suffix))),BPM_COMMON.DATE_FMT);
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to get deployed SVN_REVISION_DATE for package "' || p_package_name || '".  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,null,v_log_message,v_sql_code);
      return null;
  end; 
    
    
  function GET_SVN_REVISION_AUTHOR
    (p_package_name in varchar2)
    return varchar2
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'GET_SVN_REVISION_AUTHOR';
    v_sql_code number := null;
    v_log_message clob := null;
    v_keyword_value varchar2(200) := null;
    v_length_value_prefix number := length('$Author: ') + 1;
    v_length_value_suffix number := 1;
  begin
    select GET_VALUE(p_package_name || '.SVN_REVISION_AUTHOR') into v_keyword_value from dual;
    return substr(v_keyword_value,v_length_value_prefix,(nvl(length(v_keyword_value),0) - (v_length_value_prefix + v_length_value_suffix))); 
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to get deployed SVN_REVISION_AUTHOR for package "' || p_package_name || '".  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,null,v_log_message,v_sql_code);
      return null;
  end; 
  
end;
/

alter session set plsql_code_type = interpreted;
