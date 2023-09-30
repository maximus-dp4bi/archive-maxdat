delete from bpm_attribute_staging_table where ba_id in (1781,1782,1783);

insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1767,576,10,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1768,722,10,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1769,547,10,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 

insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,1767,10,'CANCEL_BY');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,1768,10,'CANCEL_METHOD');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,1769,10,'CANCEL_REASON');

update bpm_update_event_queue
set process_bueq_id=null,
bue_id=null,
wrote_bpm_event_date=null
where identifier in ('391465','391478','391480','394174','394175','394177','397672','397678','397679')
and bsl_id=10;

delete from bpm_instance_attribute
where bi_id in (select bi_id from bpm_instance
where identifier in ('391465','391478','391480','394174','394175','394177','397672','397678','397679')
and bsl_id=10);

delete from bpm_update_event
where bi_id in (select bi_id from bpm_instance
where identifier in ('391465','391478','391480','394174','394175','394177','397672','397678','397679')
and bsl_id=10);

delete from bpm_instance
where identifier in ('391465','391478','391480','394174','394175','394177','397672','397678','397679')
and bsl_id=10;

commit;