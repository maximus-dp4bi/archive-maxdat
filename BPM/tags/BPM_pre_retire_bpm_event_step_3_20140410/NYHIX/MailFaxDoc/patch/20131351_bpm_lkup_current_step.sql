--Delete old values

delete from BPM_ACTIVITY_ATTRIBUTE where baca_id >= 20;
delete from BPM_ACTIVITY_LKUP where bacl_id >= 20;
commit;

--Add semantic attributes for current_step

insert into BPM_ATTRIBUTE values (2583,178,18,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE_STAGING_TABLE values (SEQ_BAST_ID.NEXTVAL,2583,18,'CURRENT_STEP');
commit;

--Update values for instances already completed

update NYHIX_ETL_MAIL_FAX_DOC 
set current_step = 'End - Document Processed'
where complete_dt is not null;

--Update null values to 'Document received '

update NYHIX_ETL_MAIL_FAX_DOC 
set current_step = 'Document Received'
where current_step is null;