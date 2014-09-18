alter table BPM_UPDATE_EVENT_QUEUE_BCK rename constraint BUEQ_BIL_FK to BUEQB_BIL_FK;
alter table BPM_UPDATE_EVENT_QUEUE add constraint BUEQ_BIL_ID_FK foreign key (BIL_ID) references BPM_IDENTIFIER_TYPE_LKUP (BIL_ID);

alter table BPM_UPDATE_EVENT_QUEUE_BCK rename constraint BUEQ_BSL_FK to BUEQB_BSL_FK;
alter table BPM_UPDATE_EVENT_QUEUE add constraint BUEQ_BSL_ID_FK foreign key (BSL_ID) references BPM_SOURCE_LKUP (BSL_ID);

alter table BPM_UPDATE_EVENT_QUEUE_BCK rename constraint BUEQ_BUE_FK to BUEQB_BUE_FK;
alter table BPM_UPDATE_EVENT_QUEUE add constraint BUEQ_BUE_ID_FK foreign key (BUE_ID) references BPM_UPDATE_EVENT (BUE_ID);
