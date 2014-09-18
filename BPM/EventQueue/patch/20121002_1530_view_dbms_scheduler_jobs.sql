create or replace view BPM_SCHEDULER_JOBS as select * from ALL_SCHEDULER_JOBS where OWNER = 'MAXDAT' with read only;
