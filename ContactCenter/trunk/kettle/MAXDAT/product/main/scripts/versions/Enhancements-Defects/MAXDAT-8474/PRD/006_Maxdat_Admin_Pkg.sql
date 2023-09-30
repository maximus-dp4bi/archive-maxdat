alter session set plsql_code_type = native;

create or replace package MAXDAT_ADMIN as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/Admin/createdb/MAXDAT_ADMIN_pkg.sql $';
  SVN_REVISION varchar2(20) := '$Revision: 14422 $';
  SVN_REVISION_DATE varchar2(60) := '$Date: 2018-12-14 15:15:32 -0700 (Fri, 14 Dec 2018) $';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: lg74078 $';
  
   procedure UPDATE_HCO_V2_CALL;
   
    end;
  /
   
   create or replace package body MAXDAT_ADMIN as
   
   procedure UPDATE_HCO_V2_CALL
     as
       v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPDATE_HCO_V2_CALL';
       v_sql_code number := null;
       v_log_message clob := null;
       v_date date := null;
       
     begin
   
       v_log_message := 'Manually update CC_HCO_F_V2_CALL';
       
       select sysdate into v_date from dual;
       
       PKG_HCO_V2_CALL.INSERT_UPDATE_HCO_V2_CALL;
       
       
           exception
	      	when others then
	      		insert into cc_l_error ( MESSAGE , ERROR_DATE, JOB_NAME , TRANSFORM_NAME) 
		      values (v_log_message, v_date, v_procedure_name, v_procedure_name );
  end;
  
  end;
  /
  
  grant execute on MAXDAT_ADMIN to MAXDAT_READ_ONLY;
  
  alter session set plsql_code_type = interpreted;