alter table NYHIX_ETL_MAIL_FAX_DOC add (PREVIOUS_KOFAX_DCN varchar2(256));
alter table NYHIX_ETL_MAIL_FAX_DOC_OLTP add (PREVIOUS_KOFAX_DCN varchar2(256));
alter table NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM add (PREVIOUS_KOFAX_DCN varchar2(256));

alter table APP_DOC_DATA_EXT_STG add (PREVIOUS_KOFAX_DCN varchar2(256));

alter table D_NYHIX_MFD_CURRENT add (PREVIOUS_KOFAX_DCN varchar2(256));

alter table D_NYHIX_MFD_CURRENT add (PAPER_SLA_TIME_STATUS varchar2(256) default 'Not Complete' not null);


insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1609,2,'Previous KOFAX DCN','If a document has a duplicate Kofax DCN, systems populates this value with the original value when Kofax DCN is updated in MAXe.');
insert into BPM_ATTRIBUTE values (2604,1609,18,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.nextval,2604,18,'PREVIOUS_KOFAX_DCN');

commit;


