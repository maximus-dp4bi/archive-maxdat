alter session set plsql_code_type = native;

create or replace package MAXDAT_STATISTICS is

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/Admin/createdb/MAXDAT_STATISTICS_pkg.sql $'; 
  SVN_REVISION varchar2(20) := '$Revision: 13906 $'; 
  SVN_REVISION_DATE varchar2(60) := '$Date: 2015-03-13 08:44:14 -0700 (Fri, 13 Mar 2015) $'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: rk50472 $';
  
/*=================================================================================
||Purpose : This package is to insert and update statistics on MAXDAT tables only.  
||          There are 3 calls: 1)A call to do all the tables that are flagged in the lookup,
||          2)A call to do a table on demand to be called from SQL and 3)A call with
||          return values to be called from kettle.
||=================================================================================
|| Revisions:
|| DWD  02/04/2014  Written
|| DWD  02/06/2014  Added a lkup table to flag tables to be done in the All_Stats
|| DWD  02/10/2014  Randy change the name of the table and package
|| DWD  02/12/2014  Added bpm logging and added an "order by" to table_stats so that
||                    if process has to be restarted - will do oldest stat first
|| DWD  02/13/2014  Randy changed the table name again and a column name
||=================================================================================*/

  /* Declaring Constants */
  
  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/Admin/createdb/MAXDAT_STATISTICS_pkg.sql $'; 
  SVN_REVISION varchar2(20) := '$Revision: 13906 $'; 
  SVN_REVISION_DATE varchar2(60) := '$Date: 2015-03-13 08:44:14 -0700 (Fri, 13 Mar 2015) $'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author: rk50472 $';

  k_Deg constant number := 16;

  -- All Tables
  procedure ALL_STATS (p_Degree in number default k_Deg);

  -- Single Table
  procedure TABLE_STATS (p_Table in varchar2, p_Degree in number default k_Deg);

  -- Kettle Call
  procedure KETTLE_STATS (p_Table in varchar2, p_Degree in number default null);

  -- Create the Scheduler Job
  procedure CREATE_STATS_JOB;

  -- Start Stats Scheduler Job
  procedure START_SCHED;

  -- Stopping Stats Scheduler Job
  procedure STOP_SCHED;

end MAXDAT_STATISTICS;
/


create or replace package body MAXDAT_STATISTICS as

  v_job_name varchar2(30) := 'MAXDAT_STATISTICS_JOB';

  /* All Tables in MAXDAT Schema */
  procedure ALL_STATS 
    (p_Degree in number default k_Deg) 
  as
    v_ErrStr_Orig varchar2(4000) := null;
    v_ErrStr varchar2(4000) := null;
    
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'ALL_STATS';
    v_log_message clob := null;
    v_sql_code number := null;

  begin
    v_ErrStr_Orig := 'These gather stats tables did not complete:';
    v_ErrStr := v_ErrStr_Orig;

    -- Begin a loop through the tables
    for r_Tname in
      (select L.table_name
       from  gather_stats_table_config L
          ,  all_tables                A
       where L.table_name = A.table_name
         and L.gather_stats_periodically = 'Y'
       order by last_analyzed)
    loop
      begin  --Anon blk 1
         DBMS_STATS.GATHER_TABLE_STATS(OWNNAME => 'MAXDAT', TABNAME => r_Tname.table_name, CASCADE => TRUE,
                                       DEGREE  =>  p_Degree, ESTIMATE_PERCENT => DBMS_STATS.AUTO_SAMPLE_SIZE,
                                       METHOD_OPT => 'FOR ALL COLUMNS SIZE AUTO');
      exception
         when others then
            v_ErrStr := v_ErrStr || ' ' || r_Tname.table_name;
      end;  --Anon blk 1
    end loop;

    -- Insert the run time and any tables that failed into BPM Logging
    if v_ErrStr = v_ErrStr_Orig then
      v_log_message := 'All gather table stats ran OK.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);
    else
      v_log_message := v_ErrStr;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);
    end if;


  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);

  end ALL_STATS;


  /* A Single Specified Table in the MAXDAT Schema */
  procedure TABLE_STATS
    (p_Table  in varchar2, 
     p_Degree in number    default k_Deg) 
  as
    v_ErrStr varchar2(4000) := null;
    
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'TABLE_STATS';
    v_log_message clob := null;
    v_sql_code number := null;

  begin  --Anon blk 1
    DBMS_STATS.GATHER_TABLE_STATS(OWNNAME => 'MAXDAT', TABNAME => p_Table, CASCADE => TRUE,
                                       DEGREE  =>  p_Degree, ESTIMATE_PERCENT => DBMS_STATS.AUTO_SAMPLE_SIZE,
                                       METHOD_OPT => 'FOR ALL COLUMNS SIZE AUTO');

    -- Insert the run time
    v_log_message := 'Success for table ' || p_Table || ', using Degree ' || p_Degree;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);

  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);

  end TABLE_STATS;
  

  /* A Single Specified Table called by a Kettle Procedure */
  procedure KETTLE_STATS
    (p_Table  in  varchar2,
     p_Degree in number    default null) 
  as
    v_ErrStr  varchar2(4000) := null;
    v_Degree  number := null;
    
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'KETTLE_STATS';
    v_log_message clob := null;
    v_sql_code number := null;
  begin
     -- Checking for param. Had issues to pass null and use default
     if p_Degree is null then
       v_Degree := 16;
     else
       v_Degree := p_Degree;
     end if;

     DBMS_STATS.GATHER_TABLE_STATS(OWNNAME => 'MAXDAT', TABNAME => p_Table, CASCADE => TRUE, DEGREE  => v_Degree,
        ESTIMATE_PERCENT => DBMS_STATS.AUTO_SAMPLE_SIZE, METHOD_OPT => 'FOR ALL COLUMNS SIZE AUTO');

     -- Insert the run time 
     v_log_message := 'Success for Kettle table ' || p_Table || ', using Degree ' || p_Degree;
     BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);

  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);
      
  end KETTLE_STATS;


  procedure CREATE_STATS_JOB
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'CREATE_STATS_JOB';
    v_log_message clob := null;
    v_sql_code number := null;
  begin
    dbms_scheduler.create_job(job_name => v_job_name, job_type => 'STORED_PROCEDURE',
                              job_action => 'maxdat_statistics.all_stats', start_date => sysdate, 
                              repeat_interval => 'FREQ=DAILY;byhour=22',
                              enabled => true, auto_drop => false);

  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);

  end;


  procedure START_SCHED
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'START_SCHED';
    v_log_message clob := null;
    v_sql_code number := null;
  begin
   dbms_scheduler.enable(v_job_name);
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);
  end;


  procedure STOP_SCHED
  as 
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'STOP_SCHED';
    v_log_message clob := null;
    v_sql_code number := null;
  begin
    dbms_scheduler.disable(v_job_name);
  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);
  end;

end MAXDAT_STATISTICS;
/

alter session set plsql_code_type = interpreted;
