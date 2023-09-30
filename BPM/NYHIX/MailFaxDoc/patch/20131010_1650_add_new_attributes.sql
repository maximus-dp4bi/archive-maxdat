
alter table NYHIX_ETL_MAIL_FAX_DOC add (DOC_COMPLETE_DT date);
alter table NYHIX_ETL_MAIL_FAX_DOC_OLTP add (DOC_COMPLETE_DT date);
alter table NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM add (DOC_COMPLETE_DT date);

alter table NYHIX_ETL_MAIL_FAX_DOC add (CURRENT_TASK_ID number(18,0));
alter table NYHIX_ETL_MAIL_FAX_DOC_OLTP add (CURRENT_TASK_ID number(18,0));
alter table NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM add (CURRENT_TASK_ID number(18,0));


alter table NYHIX_ETL_MAIL_FAX_DOC add (KOFAX_DCN varchar2(256) NOT NULL);
alter table NYHIX_ETL_MAIL_FAX_DOC_OLTP add (KOFAX_DCN varchar2(256)NOT NULL);
alter table NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM add (KOFAX_DCN varchar2(256)NOT NULL);


insert into BPM_ATTRIBUTE_LKUP values(60,1,'Current Task ID','Task ID identifying the current task for the instance');
insert into BPM_ATTRIBUTE_LKUP values(1541,3,'Document Complete Dt','This is the date/time that MAXe considers the Document Complete');
insert into BPM_ATTRIBUTE_LKUP values(1542,2,'KOFAX DCN','The user visible unique identifier for a document, which is assigned by KOFAX and persists through the DMS and MAXe, and sent to the 
CSC portal');


insert into BPM_ATTRIBUTE values (2480,60,18,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE values (2481,1541,18,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE values (2482,1542,18,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');



insert into BPM_ATTRIBUTE_STAGING_TABLE values (SEQ_BAST_ID.NEXTVAL,2480,18,'CURRENT_TASK_ID');
insert into BPM_ATTRIBUTE_STAGING_TABLE values (SEQ_BAST_ID.NEXTVAL,2481,18,'DOC_COMPLETE_DT');
insert into BPM_ATTRIBUTE_STAGING_TABLE values (SEQ_BAST_ID.NEXTVAL,2482,18,'KOFAX_DCN');


alter table D_NYHIX_MFD_CURRENT add (DOC_COMPLETE_DT date);
alter table D_NYHIX_MFD_CURRENT add (CURRENT_TASK_ID number(18,0));
alter table D_NYHIX_MFD_CURRENT add (KOFAX_DCN varchar2(256));


CREATE OR REPLACE VIEW D_NYHIX_MFD_CURRENT_SV AS
SELECT * FROM D_NYHIX_MFD_CURRENT
WITH READ ONLY;


commit;