
alter table BPM_INSTANCE_ATTRIBUTE drop constraint BIA_BA_FK ;

delete from bpm_attribute
where ba_id=1978;

delete from bpm_attribute_lkup
where bal_id=950;

insert into BPM_ATTRIBUTE_LKUP(bal_id,bdl_id,name,purpose) values(47,3,'Cancel Dt','The date when the instance was cancelled');

insert into BPM_ATTRIBUTE (ba_id,bal_id,bem_id,when_populated,effective_date,end_date,retain_history_flag) values(1978,47,16,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');

alter table BPM_INSTANCE_ATTRIBUTE add constraint BIA_BA_FK foreign key(BA_ID) references BPM_ATTRIBUTE(BA_ID);

commit;

