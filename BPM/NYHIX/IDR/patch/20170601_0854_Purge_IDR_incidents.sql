alter session set current_schema = MAXDAT;

execute MAXDAT_ADMIN.CONFIG_QUEUE_JOB(21,2,'ENABLED','N');
/
truncate table MAXDAT.NYHX_ETL_IDR_INCIDENTS;
truncate table MAXDAT.NYHX_ETL_IDR_INCIDENTS_OLTP;
truncate table MAXDAT.NYHX_ETL_IDR_INCIDENTS_WIP;
truncate table MAXDAT.NYHX_ETL_IDR_INCIDENT_RSN;

begin
  for cur1 in (select owner, constraint_name , table_name 
    from all_constraints
     where owner = 'MAXDAT' and
           TABLE_NAME = 'F_IDR_BY_DATE') loop
     execute immediate 'ALTER TABLE '||cur1.owner||'.'||cur1.table_name||' MODIFY CONSTRAINT "'||cur1.constraint_name||'" DISABLE ';
  end loop;
end;
/
truncate table MAXDAT.F_IDR_BY_DATE;
begin
  for cur2 in (select owner, constraint_name , table_name 
    from all_constraints
     where owner = 'MAXDAT' and
           TABLE_NAME = 'F_IDR_BY_DATE') loop
     execute immediate 'ALTER TABLE '||cur2.owner||'.'||cur2.table_name||' MODIFY CONSTRAINT "'||cur2.constraint_name||'" ENABLE ';
  end loop;
end;
/

delete from MAXDAT.D_IDR_CURRENT;
commit;

execute MAXDAT_ADMIN.SHUTDOWN_JOBS;

DELETE FROM BPM_UPDATE_EVENT_QUEUE
where BSL_ID = 21 ;
commit;

delete from bpm_update_event_queue_archive where bsl_id=21;
commit;

delete from BPM_LOGGING where BSL_ID = 21;
commit;

execute MAXDAT_ADMIN.STARTUP_JOBS;
/
update corp_etl_control set value = 57000 where name = 'IDRS_TO_LOOK_BACK';
commit;

update corp_etl_control set value = 26034525 where name = 'LAST_IDR_INCIDENT_ID';
commit;
execute MAXDAT_ADMIN.CONFIG_QUEUE_JOB(21,2,'ENABLED','Y');
/