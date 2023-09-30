begin
	for cur in (select owner, constraint_name , table_name 
		from all_constraints
		where owner = USER and
		TABLE_NAME = 'D_MW_TASK_INSTANCE') loop
      begin        
          execute immediate 'ALTER TABLE '||cur.owner||'.'||cur.table_name||' 
          MODIFY CONSTRAINT "'||cur.constraint_name||'" DISABLE ';
      exception
        when others
        then null;
      end;
   end loop;
end;
/

begin
	for cur in (select owner, constraint_name , table_name 
		from all_constraints
		where owner = USER and
		TABLE_NAME = 'D_BPM_ENTITY_INSTANCE') loop
      begin        
          execute immediate 'ALTER TABLE '||cur.owner||'.'||cur.table_name||' 
          MODIFY CONSTRAINT "'||cur.constraint_name||'" DISABLE ';
      exception
        when others
        then null;
      end;
   end loop;
end;
/

begin
	for cur in (select owner, constraint_name , table_name 
		from all_constraints
		where owner = USER and
		TABLE_NAME = 'D_BPM_FLOW_INSTANCE') loop
      begin        
          execute immediate 'ALTER TABLE '||cur.owner||'.'||cur.table_name||' 
          MODIFY CONSTRAINT "'||cur.constraint_name||'" DISABLE ';
      exception
        when others
        then null;
      end;
   end loop;
end;
/

begin
	for cur in (select owner, constraint_name , table_name 
		from all_constraints
		where owner = USER and
		TABLE_NAME = 'D_BPM_PROCESS_SEGMENT_INSTANCE') loop
      begin        
          execute immediate 'ALTER TABLE '||cur.owner||'.'||cur.table_name||' 
          MODIFY CONSTRAINT "'||cur.constraint_name||'" DISABLE ';
      exception
        when others
        then null;
      end;
   end loop;
end;
/

begin
	for cur in (select owner, constraint_name , table_name 
		from all_constraints
		where owner = USER and
		TABLE_NAME = 'D_MW_TASK_HISTORY') loop
      begin        
          execute immediate 'ALTER TABLE '||cur.owner||'.'||cur.table_name||' 
          MODIFY CONSTRAINT "'||cur.constraint_name||'" DISABLE ';
      exception
        when others
        then null;
      end;
   end loop;
end;
/

begin
	for cur in (select owner, constraint_name , table_name 
		from all_constraints
		where owner = USER and
		TABLE_NAME = 'D_MW_TASK_INSTANCE') loop
      begin        
          execute immediate 'ALTER TABLE '||cur.owner||'.'||cur.table_name||' 
          MODIFY CONSTRAINT "'||cur.constraint_name||'" ENABLE ';
      exception
        when others
        then null;
      end;
   end loop;
end;
/


truncate table d_bpm_process_segment_instance cascade;
truncate table d_bpm_flow_instance cascade;
truncate table d_bpm_entity_instance cascade;
truncate table d_bpm_process_instance cascade;
truncate table d_hco_process_instance cascade;
truncate table step_instance cascade;
truncate table step_instance_history cascade;
truncate table step_instance_stg cascade;
truncate table corp_etl_mw cascade;
truncate table corp_etl_mw_wip cascade;
truncate table d_mw_task_history cascade;
truncate table d_mw_task_instance cascade;
--truncate table bpm_update_event_queue cascade;

delete FROM CORP_ETL_JOB_STATISTICS WHERE JOB_NAME ='MW_RUNALL';
commit;

truncate table hco_activity_queue cascade;
truncate table hco_case_dcn cascade;
truncate table hco_mail_client_trans cascade;
truncate table hco_d_mail_returned cascade;
truncate table hco_system_log cascade;
truncate table hco_enrollment_ext cascade;
truncate table hco_batch_dcn cascade;
truncate table hco_batch_stats cascade;
truncate table hco_d_employees cascade;

delete from staff_key_lkup;

delete from d_staff where staff_id > 0;
delete from d_business_units where business_unit_id > 1;
delete from d_teams where team_id > 0;
delete from groups_stg where group_id > 1;

update corp_etl_control set value = '1900/01/01 00:00:00' 
WHERE NAME 
IN 
(
    'MW_BATCH_STATS_SCAN_END_DATE',
    'MW_BATCH_STATS_SCAN_START_DATE',
    'MW_CASE_DCN_CREATE_DATE',
    'MW_CASE_DCN_UPDATE_DATE',
    'MW_ENROLL_EXT_CREATE_DATE',
    'MW_ENROLL_EXT_UPDATE_DATE',
    'MW_MAIL_CLIENT_CREATE_DATE',
    'MW_MAIL_CLIENT_UPDATE_DATE',
    'MW_MAIL_RETURNED_CREATE_DATE',
    'MW_MAIL_RETURNED_UPDATE_DATE',
    'MW_SYSTEM_LOG_DATE',
    'MW_ETL_DATA_START_DATE',
    'MW_ETL_DTE_CREATE_DATE',
    'MW_ETL_DTE_UPDATE_DATE'
);

update corp_etl_control set value = '1900/01/01 00:00:00' 
WHERE NAME 
IN 
(
    'MW_EDER_PROC_DATE',
    'MW_EDER_SH_PROC_DATE',
    'MW_ENROLLMENT_PROC_DATE',
    'MW_EXEMPTION_PROC_DATE',
    'MW_EXEMPTION_SH_PROC_DATE',
    'MW_LETTER_MAILING_PROC_DATE',
    'MW_PACKET_MAILING_PROC_DATE',
    'MW_RETURN_MAIL_PROC_DATE',
    'MW_MAIL_RETURNED_PROC_DATE'
);

update corp_etl_control set value = '0' 
WHERE NAME  IN ('MW_LAST_HCO_BATCH_DCN_REC_NUM', 'MW_LAST_MAIL_TRANSACTION_ID');

commit;

begin
	for cur in (select owner, constraint_name , table_name 
		from all_constraints
		where owner = USER and
		TABLE_NAME = 'D_BPM_ENTITY_INSTANCE') loop
      begin        
          execute immediate 'ALTER TABLE '||cur.owner||'.'||cur.table_name||' 
          MODIFY CONSTRAINT "'||cur.constraint_name||'" ENABLE ';
      exception
        when others
        then null;
      end;
   end loop;
end;
/

begin
	for cur in (select owner, constraint_name , table_name 
		from all_constraints
		where owner = USER and
		TABLE_NAME = 'D_BPM_FLOW_INSTANCE') loop
      begin        
          execute immediate 'ALTER TABLE '||cur.owner||'.'||cur.table_name||' 
          MODIFY CONSTRAINT "'||cur.constraint_name||'" ENABLE ';
      exception
        when others
        then null;
      end;
   end loop;
end;
/

begin
	for cur in (select owner, constraint_name , table_name 
		from all_constraints
		where owner = USER and
		TABLE_NAME = 'D_BPM_PROCESS_SEGMENT_INSTANCE') loop
      begin        
          execute immediate 'ALTER TABLE '||cur.owner||'.'||cur.table_name||' 
          MODIFY CONSTRAINT "'||cur.constraint_name||'" ENABLE ';
      exception
        when others
        then null;
      end;
   end loop;
end;
/

begin
	for cur in (select owner, constraint_name , table_name 
		from all_constraints
		where owner = USER and
		TABLE_NAME = 'D_MW_TASK_HISTORY') loop
      begin        
          execute immediate 'ALTER TABLE '||cur.owner||'.'||cur.table_name||' 
          MODIFY CONSTRAINT "'||cur.constraint_name||'" ENABLE ';
      exception
        when others
        then null;
      end;
   end loop;
end;
/

