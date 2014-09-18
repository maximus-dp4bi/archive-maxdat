
--F_NYHIX_MFD_BY_DATE
--Drop references
alter table F_NYHIX_MFD_BY_DATE drop constraint FNMFDBD_DNMFDDST_FK;
alter table F_NYHIX_MFD_BY_DATE drop constraint FNMFDBD_DNMFDDS_FK;
alter table F_NYHIX_MFD_BY_DATE drop constraint FNMFDBD_DNMFDDT_FK;
alter table F_NYHIX_MFD_BY_DATE drop constraint FNMFDBD_DNMFDES_FK;
alter table F_NYHIX_MFD_BY_DATE drop constraint FNMFDBD_DNMFDFT_FK;
alter table F_NYHIX_MFD_BY_DATE drop constraint FNMFDBD_DNMFDIS_FK;
alter table F_NYHIX_MFD_BY_DATE drop constraint FNMFDBD_DNMFDTS_FK;
alter table F_NYHIX_MFD_BY_DATE drop constraint FNMFDBD_NYHIX_MFD_BI_ID_FK;

--Drop primary key
alter table F_NYHIX_MFD_BY_DATE drop primary key;

--Drop table & view
drop table F_NYHIX_MFD_BY_DATE;
drop view F_NYHIX_MFD_BY_DATE_SV;

--Drop sequence 
drop sequence SEQ_FNMFDBD_ID;



--D_MFDOC_TIMELINESS_STATUS


--Drop primary key
alter table D_NYHIX_MFD_TIME_STATUS drop primary key;

--Drop table & view
drop table D_NYHIX_MFD_TIME_STATUS;
drop view D_NYHIX_MFD_TIME_STATUS_SV;

--Drop sequence 
drop sequence SEQ_DNMFDTS_ID;

--D_MFDOC_FORM_TYPE


--Drop primary key
alter table D_NYHIX_MFD_FORM_TYPE drop primary key;

--Drop table & view
drop table D_NYHIX_MFD_FORM_TYPE;
drop view D_NYHIX_MFD_FORM_TYPE_SV;

--Drop sequence 
drop sequence SEQ_DNMFDFT_ID;

--D_MFDOC_DOCUMENT_SUBTYPE


--Drop primary key
alter table D_NYHIX_MFD_DOC_SUB_TYPE drop primary key;

--Drop table & view
drop table D_NYHIX_MFD_DOC_SUB_TYPE;
drop view D_NYHIX_MFD_DOC_SUB_TYPE_SV;

--Drop sequence 
drop sequence SEQ_DNMFDDST_ID;

--D_MFDOC_ENV_STATUS


--Drop primary key
alter table D_NYHIX_MFD_ENV_STATUS drop primary key;

--Drop table & view
drop table D_NYHIX_MFD_ENV_STATUS;
drop view D_NYHIX_MFD_ENV_STATUS_SV;

--Drop sequence 
drop sequence SEQ_DNMFDES_ID;

--D_MFDOC_DOCUMENT_STATUS


--Drop primary key
alter table D_NYHIX_MFD_DOC_STATUS drop primary key;

--Drop table & view
drop table D_NYHIX_MFD_DOC_STATUS;
drop view D_NYHIX_MFD_DOC_STATUS_SV;

--Drop sequence 
drop sequence SEQ_DNMFDDS_ID;


--D_MFDOC_INSTANCE_STATUS


--Drop primary key
alter table D_NYHIX_MFD_INS_STATUS drop primary key;

--Drop table & view
drop table D_NYHIX_MFD_INS_STATUS;
drop view D_NYHIX_MFD_INS_STATUS_SV;

--Drop sequence 
drop sequence SEQ_DNMFDIS_ID;

--D_MFDOC_DOCUMENT_TYPE


--Drop primary key
alter table D_NYHIX_MFD_DOC_TYPE drop primary key;

--Drop table & view
drop table D_NYHIX_MFD_DOC_TYPE;
drop view D_NYHIX_MFD_DOC_TYPE_SV;

--Drop sequence 
drop sequence SEQ_DNMFDDT_ID;


drop table D_NYHIX_MFD_CURRENT;
drop view D_NYHIX_MFD_CURRENT_SV;