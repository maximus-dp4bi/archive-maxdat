alter session set plsql_code_type = native;

/*
Created on 11/17/2016 by Raj A.
Description: Created for MAXDAT-4283.
This package is to control the BPM_UPDATE_EVENT_QUEUE table, i.e., drop partitions of the BPM_UPDATE_EVENT_QUEUE table,
drop a specific partition, create and stop the job, etc.
*/

create or replace package BPM_UPDATE_EVENT_QUEUE_PART as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$';
  SVN_REVISION varchar2(20) := '$Revision$';
  SVN_REVISION_DATE varchar2(60) := '$Date$';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  procedure SET_SCHED_DEFAULT_TIMEZONE
    (p_timezone_region in varchar2);

  procedure CREATE_RM_BUEQ_PARTITIONS_JOB;

  procedure STOP_RM_BUEQ_PARTITIONS_JOB;

  procedure RM_BUEQ_PARTITIONS;

 end BPM_UPDATE_EVENT_QUEUE_PART;
/


create or replace package body BPM_UPDATE_EVENT_QUEUE_PART as

  -- Set DBMS Scheduler default timezone.
  -- Requires MANAGE SCHEDULER privilege.
  -- Example: US/Eastern
  -- List of Oracle TIMEZONE_REGION: http://psoug.org/definition/TIMEZONE_REGION.htm
  procedure SET_SCHED_DEFAULT_TIMEZONE
    (p_timezone_region in varchar2)
  as
  begin
    DBMS_SCHEDULER.SET_SCHEDULER_ATTRIBUTE
      (ATTRIBUTE => 'DEFAULT_TIMEZONE',
       VALUE => p_timezone_region);
  end;

-- Create scheduler job for CREATE_RM_BUEQ_PARTITIONS_JOB job.
  procedure CREATE_RM_BUEQ_PARTITIONS_JOB
  as
    v_package_name varchar2(100) := $$PLSQL_UNIT;
    v_procedure_name varchar2(61) := 'RM_BUEQ_PARTITIONS';
    v_log_message clob := null;
    v_sql_code number := null;
    v_default_timezone varchar2(30) := null;
    v_job_action varchar2(200) := null;
    v_job_name varchar2(30) := null;
    v_start_date varchar2(100) := null;
  begin

    select VALUE into v_default_timezone
    from ALL_SCHEDULER_GLOBAL_ATTRIBUTE
    where ATTRIBUTE_NAME = 'DEFAULT_TIMEZONE';

    if v_default_timezone is null then
      v_sql_code := -20080;
      v_log_message := 'Unable to start the job "' || v_procedure_name || '".  No DBMS Scheduler default timezone set.  This can be set via PROCESS_BPM_UPDATE_EVENT_QUEUE.SET_SCHED_DEFAULT_TIMEZONE(timezone_region) which requires MANAGE SCHEDULER privilege.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);
      return;
    end if;

    -- Create job to run daily.
    v_job_action := 'begin ' || v_package_name || '.' || v_procedure_name || ' ; end;';
    v_job_name := v_procedure_name;
    dbms_scheduler.create_job (
      job_name   => v_job_name,
      job_type   => 'PLSQL_BLOCK',
      job_action => v_job_action,
      repeat_interval=> 'FREQ=DAILY; BYHOUR=1; BYMINUTE=30; BYSECOND=0 ',
      enabled    =>  TRUE,
      comments   => 'Drop the zero-rowed partitions on the BPM_UPDATE_EVENT_QUEUE table.');

    dbms_scheduler.set_attribute(
      name => v_job_name,
      attribute => 'RESTARTABLE',
      value => TRUE);

    v_log_message := 'Created dbms_scheduler job "' || v_job_name || '".';
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,null,null,null,null,v_log_message,null);

  exception

    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to start job "' || v_procedure_name || '".  '  || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);

  end CREATE_RM_BUEQ_PARTITIONS_JOB;

  -- Control job.
  procedure RM_BUEQ_PARTITIONS
  /*
  This procedure will drop the old and empty partitions that are no longer needed.
  */
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'RM_BUEQ_PARTITIONS';
    v_log_message clob := null;
    
	l_table_owner  VARCHAR2(30)   := 'MAXDAT';
    l_table_name   VARCHAR2(30)   := 'BPM_UPDATE_EVENT_QUEUE';
    l_tot_count    NUMBER(5)      := 0;     -- Total count in each partition
    l_sql          VARCHAR2(3000) := NULL;  -- Dynamic SQL
    l_part_dropped BOOLEAN        := FALSE; -- indicates if a partition was dropped; if yes, rebuild global indexes

  begin
    -- Loop through all partitions except the initial and latest partitions
    FOR part_rec IN (
                     SELECT partition_name
                     FROM   all_tab_partitions
                     WHERE  table_name  = l_table_name
                     AND    table_owner = l_table_owner
                     AND    interval    = 'YES' -- initial partition will have interval set to 'NO'
                     AND    partition_position < (SELECT MAX(partition_position) FROM all_tab_partitions
                                                  WHERE  table_name  = l_table_name
                                                  AND    table_owner = l_table_owner)
                     ORDER BY partition_position
                    )
    LOOP

        -- Lock the partition first before checking for count. This may be redundant as data always goes into latest partition
        l_sql := 'LOCK TABLE ' || l_table_owner || '.' || l_table_name || ' PARTITION (' || part_rec.partition_name || ') IN EXCLUSIVE MODE';
        EXECUTE IMMEDIATE l_sql;

        -- Check the count from the partition
        l_sql := 'SELECT COUNT(*) FROM ' || l_table_owner || '.' || l_table_name || ' PARTITION (' || part_rec.partition_name || ')';
        EXECUTE IMMEDIATE l_sql INTO l_tot_count;

        -- If no rows exist in the partition, then drop it
        IF l_tot_count = 0
        THEN
--          dbms_output.put_line('Total count for partition ' || part_rec.partition_name || ' is 0. This partition can be dropped');
            l_sql := 'ALTER TABLE ' || l_table_owner || '.' || l_table_name || ' DROP PARTITION ' || part_rec.partition_name;
            EXECUTE IMMEDIATE l_sql;
--|| "'l_table_owner'"
           v_log_message := 'Dropped the partition "'||part_rec.partition_name||'" from the table "'||l_table_name||'".';
		   BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,null,null,null,null,v_log_message,null);
		   l_part_dropped := TRUE;
        END IF;

    END LOOP;

    -- Rebuild global indexes online if any partition was dropped
    -- If partition had no rows, then index will be usable even after dropping partition
    -- But we are rebuilding to eliminate 'holes' in the index
    IF l_part_dropped
    THEN
        FOR ind_rec IN (
                        SELECT owner
                              ,index_name
                        FROM   all_indexes
                        WHERE  table_name  =  l_table_name
                        AND    table_owner =  l_table_owner
                        AND    index_type != 'LOB' -- Ignore LOB indexes
                        AND    PARTITIONED = 'NO'  -- consider only global indexes
                       )
        LOOP
            l_sql := 'ALTER INDEX ' || ind_rec.owner || '.' || ind_rec.index_name || ' REBUILD ONLINE';
            EXECUTE IMMEDIATE l_sql;
        END LOOP;
    END IF;


  end RM_BUEQ_PARTITIONS;

-- Gracefully stop job.
  procedure STOP_RM_BUEQ_PARTITIONS_JOB
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'STOP_RM_BUEQ_PARTITIONS_JOB';
    v_log_message clob := null;
    v_sql_code number := null;
    v_num_jobs number := null;
	v_job_name varchar2(61) := 'RM_BUEQ_PARTITIONS';
  begin

    select count(*)
    into v_num_jobs
    from USER_SCHEDULER_JOBS
    where JOB_NAME = v_job_name;

    if v_num_jobs = 0 then
      v_log_message := 'dbms_scheduler job "' || v_job_name || '" was already stopped.';
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_WARNING,null,v_procedure_name,null,null,null,null,v_log_message,null);
    else
      dbms_scheduler.drop_job(v_job_name,TRUE);
    end if;

  exception

    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to stop job "' || v_job_name || '".  '  || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,v_log_message,v_sql_code);

  end STOP_RM_BUEQ_PARTITIONS_JOB;

end BPM_UPDATE_EVENT_QUEUE_PART;  
/
 
alter session set plsql_code_type = interpreted;