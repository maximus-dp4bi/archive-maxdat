-- NYHIX-34419 - MAXDAT PRD NYHIX PL Remove Backfill QC_FLAG data from BPM Queue

alter session set current_schema = MAXDAT;

create global temporary table temp_bpm_event_queue
on commit preserve rows
as
select * from maxdat.bpm_update_event_queue
where 
  bsl_id = 12
  and event_date > to_date('2017/09/22 19:30:00','yyyy/mm/dd hh24:mi:ss') 
  and event_date < to_date('2017/09/23 00:00:00','yyyy/mm/dd hh24:mi:ss'); 

commit;

Alter table maxdat.bpm_update_event_queue drop partition SYS_P353109;

alter index maxdat.BUEQ_PK rebuild;
alter index maxdat.BUEQ_IX1 rebuild;
alter index maxdat.BUEQ_IX2 rebuild;
alter index maxdat.BUEQ_IX3 rebuild;
alter index maxdat.BUEQ_IX4 rebuild;

insert into maxdat.bpm_update_event_queue
select * from temp_bpm_event_queue;

commit;

-- The next two selects should have the same count values
select count(*) temp_count from maxdat.temp_bpm_event_queue;

select count(*) queue_count from maxdat.bpm_update_event_queue where bsl_id = 12;

-- If they match drop the temp table
drop table temp_bpm_event_queue;

  