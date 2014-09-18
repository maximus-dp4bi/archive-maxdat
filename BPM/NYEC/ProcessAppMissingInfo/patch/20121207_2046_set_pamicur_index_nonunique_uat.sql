-- Set end date for queue processors that were killed in the DB outage 12/9/2012
UPDATE PROCESS_BPM_QUEUE_JOB SET END_DATE=(SYSDATE-.3) WHERE END_DATE IS NULL;

-- Reset queue rows.
update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where 
PROCESS_BUEQ_ID is not null;

commit;

-- Set index to nonunique.
drop index DNPAMICUR_UIX1;
create index DNPAMICUR_IX1 on D_NYEC_PAMI_CURRENT ("Application ID") online tablespace MAXDAT_INDX parallel compute statistics; 
