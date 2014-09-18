drop table BPM_INSTANCE_ATTRIBUTE_BACKUP;

alter table BPM_ACTIVITY_EVENTS drop constraint BI_BACE_FK;

alter table BPM_ACTIVITY_EVENTS add constraint BI_BACE_FK 
foreign key (BI_ID) references BPM_INSTANCE (BI_ID);

drop table BPM_INSTANCE_BACKUP;
