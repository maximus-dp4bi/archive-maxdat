alter table CORP_ETL_MFB_BATCH_OLTP modify GWF_QC_REQUIRED varchar2(1) null;
alter table CORP_ETL_MFB_BATCH_STG modify GWF_QC_REQUIRED  varchar2(1) null;
alter table CORP_ETL_MFB_BATCH_WIP modify GWF_QC_REQUIRED  varchar2(1) null;
alter table CORP_ETL_MFB_BATCH modify GWF_QC_REQUIRED varchar2(1) null;

alter table CORP_ETL_MFB_BATCH_OLTP modify GWF_QC_REQUIRED default null;
alter table CORP_ETL_MFB_BATCH_STG modify GWF_QC_REQUIRED  default null;
alter table CORP_ETL_MFB_BATCH_WIP modify GWF_QC_REQUIRED  default null;
alter table CORP_ETL_MFB_BATCH modify GWF_QC_REQUIRED default null;








