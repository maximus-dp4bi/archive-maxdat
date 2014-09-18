
alter table nyhix_etl_mail_fax_doc add  BATCH_NAME VARCHAR2(255);
alter table nyhix_etl_mail_fax_doc_oltp add  BATCH_NAME VARCHAR2(255);
alter table nyhix_etl_mail_fax_doc_wip_bpm add  BATCH_NAME VARCHAR2(255);

insert into BPM_ATTRIBUTE values (2589,131,18,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');

insert into BPM_ATTRIBUTE_STAGING_TABLE values (SEQ_BAST_ID.NEXTVAL,2589,18,'BATCH_NAME');


alter table D_NYHIX_MFD_CURRENT add (BATCH_NAME VARCHAR2(255));

CREATE OR REPLACE VIEW D_NYHIX_MFD_CURRENT_SV AS
SELECT * FROM D_NYHIX_MFD_CURRENT
WITH READ ONLY;


commit;