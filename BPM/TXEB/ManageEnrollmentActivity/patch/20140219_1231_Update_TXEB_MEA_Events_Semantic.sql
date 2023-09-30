/*
Created on 19-Feb-20134by Raj A.

Description:
In order to avoid deleting millions of BPM Event records, we are updatinh the BSL_ID or BEM_ID to 999 for MEA instances.
We will delete these records later. However, BPM ETL stage & Semantic dimension and facts  will be truncated as usual.
*/

truncate table corp_etl_Manage_enroll;
truncate table corp_etl_Manage_enroll_oltp;
truncate table corp_etl_Manage_enroll_wip;

insert into bpm_source_lkup
values (999, 'DUMMY_CORP_ETL_MANAGE_ENROLL', 9);
commit;

insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) 
values (999,'Dummy Manage Enrollment Activity','Dummy Manage Enrollment Activity added to archive stale records instead of doing a HUGE DELETE.');
commit;

insert into BPM_EVENT_MASTER (BEM_ID,BRL_ID,BPRJ_ID,BPRG_ID,BPROL_ID,NAME,DESCRIPTION,EFFECTIVE_DATE,END_DATE) 
values (999,2,2,2,999,'Dummy Manage Enrollment','Dummy Manage Enrollment Activity added to archive stale records instead of doing a HUGE DELETE.',sysdate,BPM_COMMON.GET_MAX_DATE);
commit;

delete BPM_UPDATE_EVENT_QUEUE 
WHERE bsl_id = 14;
COMMIT;

alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE enable row movement;
update BPM_UPDATE_EVENT_QUEUE_ARCHIVE 
set bsl_id = 999
where BSL_ID = 14;
commit;
alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE disable row movement;

--------------------------------------------------------------------------------------
-- Remove from BPM Semantic.
truncate table F_ME_BY_DATE;
alter table F_ME_BY_DATE drop constraint FMEBD_DMECUR_FK;

truncate table D_ME_CURRENT;
alter table F_ME_BY_DATE add constraint FMEBD_DMECUR_FK foreign key (ME_BI_ID) references D_ME_CURRENT (ME_BI_ID);
--------------------------------------------------------------------------------------

--BPM_INSTANCE_ATTRIBUTE: No update needed for this table.
--BPM_UPDATE_EVENT: No update needed for this table.

alter table BPM_INSTANCE enable row movement;
update BPM_INSTANCE
set BSL_ID = 999,
    BEM_ID = 999
where BEM_ID = 14;
commit;
alter table BPM_INSTANCE disable row movement;