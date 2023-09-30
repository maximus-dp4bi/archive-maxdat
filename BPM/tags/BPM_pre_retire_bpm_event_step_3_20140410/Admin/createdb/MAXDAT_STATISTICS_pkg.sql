alter session set plsql_code_type = native;

create or replace package MAXDAT_STATISTICS is
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

/*
|| Declaring Constants
*/
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
SVN_FILE_URL varchar2(200) := '$URL$'; 
SVN_REVISION varchar2(20) := '$Revision$'; 
SVN_REVISION_DATE varchar2(60) := '$Date$'; 
SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

k_Deg  constant number  := 16;

-- All Tables
procedure All_Stats (p_Degree in number default k_Deg);

-- Single Table
procedure Table_Stats (p_Table in varchar2, p_Degree in number default k_Deg);

-- Kettle Call
procedure Kettle_Stats (p_Table in varchar2, p_Degree in number default null);

-- Create the Scheduler Job
procedure Create_Stats_Job;

-- Start Stats Scheduler Job
procedure Start_Sched;

-- Stopping Stats Scheduler Job
procedure Stop_Sched;

end MAXDAT_STATISTICS;
/
create or replace package body MAXDAT_STATISTICS is

/*
|| All Tables in MAXDAT Schema
*/
procedure All_Stats (
      p_Degree in number default k_Deg
) is
    v_ErrStr  varchar2(4000);

begin
   v_ErrStr := 'These tables did not complete:';

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
            v_ErrStr := v_ErrStr||' '||r_Tname.table_name;
      end;  --Anon blk 1
   end loop;

   -- Insert the run time and any tables that failed into BPM Logging
   BPM_COMMON.LOGGER(p_log_level => 'INFO', p_run_data_object => 'MAXDAT_STATISTICS.ALL_STATS', p_log_message =>  v_ErrStr,
                     p_pbqj_id => null, p_bsl_id => null, p_bil_id => null, p_identifier => null,
                     p_bi_id => null, p_ba_id => null, p_error_number => null);

exception
   when others then
      v_ErrStr := sqlerrm||'-'||dbms_utility.format_error_backtrace;
      BPM_COMMON.LOGGER(p_log_level => 'SEVERE', p_run_data_object => 'MAXDAT_STATISTICS.ALL_STATS', p_log_message =>  v_ErrStr,
                     p_pbqj_id => null, p_bsl_id => null, p_bil_id => null, p_identifier => null,
                     p_bi_id => null, p_ba_id => null, p_error_number => null);
end All_Stats;

/*
|| A Single Specified Table in the MAXDAT Schema
*/
procedure Table_Stats (
      p_Table  in varchar2
    , p_Degree in number    default k_Deg
) is
    v_ErrStr  varchar2(4000);

 begin  --Anon blk 1
    DBMS_STATS.GATHER_TABLE_STATS(OWNNAME => 'MAXDAT', TABNAME => p_Table, CASCADE => TRUE,
                                       DEGREE  =>  p_Degree, ESTIMATE_PERCENT => DBMS_STATS.AUTO_SAMPLE_SIZE,
                                       METHOD_OPT => 'FOR ALL COLUMNS SIZE AUTO');

   -- Insert the run time 
   BPM_COMMON.LOGGER(p_log_level => 'INFO', p_run_data_object => 'MAXDAT_STATISTICS.TABLE_STATS', 
                     p_log_message => 'Success for table '||p_Table||', Degree '||p_Degree,
                     p_pbqj_id => null, p_bsl_id => null, p_bil_id => null, p_identifier => null,
                     p_bi_id => null, p_ba_id => null, p_error_number => null);

exception
   when others then
      v_ErrStr := sqlerrm||'-'||dbms_utility.format_error_backtrace;
      BPM_COMMON.LOGGER(p_log_level => 'SEVERE', p_run_data_object => 'MAXDAT_STATISTICS.TABLE_STATS', p_log_message =>  v_ErrStr,
                     p_pbqj_id => null, p_bsl_id => null, p_bil_id => null, p_identifier => null,
                     p_bi_id => null, p_ba_id => null, p_error_number => null);
end Table_Stats;

/*
|| A Single Specified Table called by a Kettle Procedure
*/
procedure Kettle_Stats (
      p_Table  in  varchar2
    , p_Degree in number    default null
) is
    v_ErrStr  varchar2(4000);
    v_Degree  number;

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
   BPM_COMMON.LOGGER(p_log_level => 'INFO', p_run_data_object => 'MAXDAT_STATISTICS.KETTLE_STATS', 
                     p_log_message => 'Success for Kettle table '||p_Table||', using Degree '||p_Degree,
                     p_pbqj_id => null, p_bsl_id => null, p_bil_id => null, p_identifier => null,
                     p_bi_id => null, p_ba_id => null, p_error_number => null);

exception
   when others then
      v_ErrStr := '(Kettle Call)  '||sqlerrm||'-'||dbms_utility.format_error_backtrace;
      BPM_COMMON.LOGGER(p_log_level => 'SEVERE', p_run_data_object => 'MAXDAT_STATISTICS.KETTLE_STATS', p_log_message =>  v_ErrStr,
                     p_pbqj_id => null, p_bsl_id => null, p_bil_id => null, p_identifier => null,
                     p_bi_id => null, p_ba_id => null, p_error_number => null);
end Kettle_Stats;

procedure Create_Stats_Job
is
begin
   dbms_scheduler.create_job(job_name => 'MXDAT_STAT_BTCH_TBLS', job_type => 'STORED_PROCEDURE',
                             job_action => 'maxdat_statistics.all_stats', start_date => sysdate, 
                             repeat_interval => 'FREQ=DAILY;byhour=22',
                             enabled => true, auto_drop => false);
end;

procedure Start_Sched
is
begin
   dbms_scheduler.enable('MXDAT_STAT_BTCH_TBLS');
end;

procedure Stop_Sched
is 
begin
   dbms_scheduler.disable('MXDAT_STAT_BTCH_TBLS');
end;

end MAXDAT_STATISTICS;
/

alter session set plsql_code_type = interpreted;
