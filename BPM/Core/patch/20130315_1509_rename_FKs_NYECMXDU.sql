alter table BPM_INSTANCE_ATTRIBUTE add constraint BIA_BA_FK foreign key (BA_ID) references BPM_ATTRIBUTE (BA_ID);

drop table table BPM_UPDATE_EVENT_BACKUP;
drop table BPM_UPDATE_EVENT_QUEUE_CONV;

alter table BPM_UPDATE_EVENT rename constraint BPM_UPDATE_EVENT_PK1 to BPM_UPDATE_EVENT_PK;
alter table BPM_UPDATE_EVENT rename constraint BEM_BI_FK to BUE_BI_FK;
alter table BPM_UPDATE_EVENT rename constraint BUTL_BUE_FK to BUE_BUTL_FK;

