
begin
	for cur in (select owner, constraint_name , table_name 
		from all_constraints
		where owner = USER and
		TABLE_NAME = 'D_BPM_PROCESS_INSTANCE') loop
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
          MODIFY CONSTRAINT "'||cur.constraint_name||'" DISABLE ';
      exception
        when others
        then null;
      end;
   end loop;
end;
/ 
  
truncate table maxdat.bpm_update_event_queue;
truncate table maxdat.d_bpm_process_segment_instance;
truncate table maxdat.d_bpm_flow_instance;
truncate table maxdat.d_bpm_process_instance;
truncate table maxdat.d_bpm_entity_instance;
truncate table maxdat.d_bpm_process_instance;

delete maxdat.d_mw_task_history th
where exists (select 1 from maxdat.d_mw_task_instance ti
where ti.mw_bi_id = th.mw_bi_id
and ti.source_reference_type in ('Exemption','EDER')
);

delete maxdat.d_mw_task_instance
where source_reference_type in ('Exemption','EDER');

delete maxdat.corp_etl_mw 
where source_reference_type in ('Exemption','EDER');

delete maxdat.corp_etl_mw_wip 
where source_reference_type in ('Exemption','EDER');

delete maxdat.step_instance_history sih
where exists (select 1 from maxdat.step_instance si
where si.step_instance_id = sih.step_instance_id
and si.ref_type in ('Exemption','EDER'));

delete maxdat.step_instance_stg
where ref_type in ('Exemption','EDER'); 

delete maxdat.step_instance
where ref_type in ('Exemption','EDER');

commit;

begin
	for cur in (select owner, constraint_name , table_name 
		from all_constraints
		where owner = USER and
		TABLE_NAME = 'D_BPM_PROCESS_INSTANCE') loop
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

update corp_etl_control set value = '2019/02/04 00:00:00' 
WHERE NAME 
IN 
(
    'MW_EDER_PROC_DATE',
    'MW_EDER_SH_PROC_DATE',
    'MW_EXEMPTION_PROC_DATE',
    'MW_EXEMPTION_SH_PROC_DATE'
); 
 
commit; 