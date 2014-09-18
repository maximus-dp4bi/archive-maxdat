-- Ignore error if any of these two constraints fail.
alter table BPM_EVENT_MASTER rename constraint BEM_BRL_FK to BEM_BPROL_FK;
alter table BPM_EVENT_MASTER add constraint BEM_BPROL_FK foreign key(BPROL_ID) references BPM_PROCESS_LKUP(BPROL_ID);

alter table BPM_ATTRIBUTE_STAGING_TABLE add constraint BAST_BSL_FK foreign key(BSL_ID) references BPM_SOURCE_LKUP(BSL_ID);
alter table PROCESS_BPM_QUEUE_JOB_BATCH add constraint PBQJB_PBQJ_ID_FK foreign key (PBQJ_ID) references PROCESS_BPM_QUEUE_JOB(PBQJ_ID);