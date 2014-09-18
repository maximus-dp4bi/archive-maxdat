-- Restore primary key on BPM_UPDATE_EVENT that was inadvertently moved to BPM_UPDATE_EVENT_BACKUP

alter table BPM_UPDATE_EVENT_QUEUE drop constraint BUEQ_BUE_ID_FK;
alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE drop constraint BUEQA_BUE_ID_FK;
alter table BPM_UPDATE_EVENT_QUEUE_CONV drop constraint BUEQC_BUE_ID_FK;

alter table BPM_UPDATE_EVENT_BACKUP drop constraint BPM_UPDATE_EVENT_PK;
drop index BPM_UPDATE_EVENT_PK;

alter table BPM_UPDATE_EVENT add constraint BPM_UPDATE_EVENT_PK primary key (BUE_ID);
alter index BPM_UPDATE_EVENT_PK rebuild tablespace MAXDAT_INDX parallel;

alter table BPM_INSTANCE_ATTRIBUTE add constraint BIA_BUE_FK
foreign key (BUE_ID) references BPM_UPDATE_EVENT (BUE_ID);

alter table BPM_UPDATE_EVENT_QUEUE add constraint BUEQ_BUE_ID_FK foreign key (BUE_ID) references BPM_UPDATE_EVENT (BUE_ID);
alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE add constraint BUEQA_BUE_ID_FK foreign key (BUE_ID) references BPM_UPDATE_EVENT (BUE_ID);
alter table BPM_UPDATE_EVENT_QUEUE_CONV add constraint BUEQC_BUE_ID_FK foreign key (BUE_ID) references BPM_UPDATE_EVENT (BUE_ID);
