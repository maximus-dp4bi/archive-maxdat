alter session set plsql_code_type = native;

create or replace package PBQJ_ADJUST_REASON as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
  SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';
  
  -- PBQJ_ADJUST_REASON_LKUP.PBQJ_ADJUST_REASON_ID IDs
  
  START_ALL_PROC_ENABLED     number := 101;
  START_BSL_BDM_PROC_ENABLED number := 102;
  START_MANUAL               number := 103;
  START_TOO_FEW_JOBS         number := 111;
  START_WORK_BACKLOG         number := 130;
  
  STOP_ALL_PROC_DISABLED     number := 201;
  STOP_BSL_BDM_PROC_DISABLED number := 202;
  STOP_MANUAL                number := 203;
  STOP_TOO_MANY_TOTAL_JOBS   number := 210;
  STOP_TOO_MANY_JOBS         number := 211;
  STOP_SLEEPING              number := 220;
  STOP_BAD_METADATA          number := 240;
  STOP_STARTED               number := 241;
end;
/

create or replace package body PBQJ_ADJUST_REASON as
end;
/

alter session set plsql_code_type = interpreted;