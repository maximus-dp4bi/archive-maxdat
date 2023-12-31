CREATE INDEX MAXDAT.IX_MAILFAX_STG_DT ON MAXDAT.corp_etl_mailfaxdoc (stage_done_dt)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_DCN ON MAXDAT.corp_etl_mailfaxdoc (DCN)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_INS_STATUS ON MAXDAT.corp_etl_mailfaxdoc (INSTANCE_STATUS)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_BARCODED ON MAXDAT.corp_etl_mailfaxdoc (gwf_document_barcoded)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_DOC_STAT ON MAXDAT.corp_etl_mailfaxdoc (document_status)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_DOC_type ON MAXDAT.corp_etl_mailfaxdoc (document_type)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_AUTOLINK ON MAXDAT.corp_etl_mailfaxdoc (gwf_autolink_outcome)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_IA_TASK ON MAXDAT.corp_etl_mailfaxdoc ( IA_MANUAL_LINK_TASK_ID)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_CLASS_TASK ON MAXDAT.corp_etl_mailfaxdoc ( IA_MANUAL_CLASSIFY_TASK_ID)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_RESCAN ON MAXDAT.corp_etl_mailfaxdoc ( GWF_RESCAN_REQUIRED)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_DOC_CLASS ON MAXDAT.corp_etl_mailfaxdoc ( GWF_DOC_CLASS_PRESENT)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_WORK ON MAXDAT.corp_etl_mailfaxdoc ( GWF_WORK_IDENTIFIED)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_CANCEL ON MAXDAT.corp_etl_mailfaxdoc (CANCEL_DT)TABLESPACE  MAXDAT_INDX ;





CREATE INDEX MAXDAT.IX_MAILFAX_STG_DT2 ON MAXDAT.corp_etl_mailfaxdoc_oltp (stage_done_dt)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_DCN2 ON MAXDAT.corp_etl_mailfaxdoc_oltp (DCN)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_INS_STATUS2 ON MAXDAT.corp_etl_mailfaxdoc_oltp (INSTANCE_STATUS)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_BARCODED2 ON MAXDAT.corp_etl_mailfaxdoc_oltp (gwf_document_barcoded)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_DOC_STAT2 ON MAXDAT.corp_etl_mailfaxdoc_oltp (document_status)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_DOC_type2 ON MAXDAT.corp_etl_mailfaxdoc_oltp (document_type)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_AUTOLINK2 ON MAXDAT.corp_etl_mailfaxdoc_oltp (gwf_autolink_outcome)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_IA_TASK2 ON MAXDAT.corp_etl_mailfaxdoc_oltp ( IA_MANUAL_LINK_TASK_ID)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_CLASS_TASK2 ON MAXDAT.corp_etl_mailfaxdoc_oltp ( IA_MANUAL_CLASSIFY_TASK_ID)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_RESCAN2 ON MAXDAT.corp_etl_mailfaxdoc_oltp ( GWF_RESCAN_REQUIRED)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_DOC_CLASS2 ON MAXDAT.corp_etl_mailfaxdoc_oltp ( GWF_DOC_CLASS_PRESENT)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_WORK2 ON MAXDAT.corp_etl_mailfaxdoc_oltp ( GWF_WORK_IDENTIFIED)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_CANCEL2 ON MAXDAT.corp_etl_mailfaxdoc_oltp (CANCEL_DT)TABLESPACE  MAXDAT_INDX ;





CREATE INDEX MAXDAT.IX_MAILFAX_STG_DT3 ON MAXDAT.corp_etl_mailfaxdoc_wip_bpm (stage_done_dt)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_DCN3 ON MAXDAT.corp_etl_mailfaxdoc_wip_bpm (DCN)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_INS_STATUS3 ON MAXDAT.corp_etl_mailfaxdoc_wip_bpm (INSTANCE_STATUS)TABLESPACE  MAXDAT_INDX TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_BARCODED3 ON MAXDAT.corp_etl_mailfaxdoc_wip_bpm(gwf_document_barcoded)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_DOC_STAT3 ON MAXDAT.corp_etl_mailfaxdoc_wip_bpm (document_status)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_DOC_type3 ON MAXDAT.corp_etl_mailfaxdoc_wip_bpm (document_type)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_AUTOLINK3 ON MAXDAT.corp_etl_mailfaxdoc_wip_bpm (gwf_autolink_outcome)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_IA_TASK3 ON MAXDAT.corp_etl_mailfaxdoc_wip_bpm ( IA_MANUAL_LINK_TASK_ID)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_CLASS_TASK3 ON MAXDAT.corp_etl_mailfaxdoc_wip_bpm ( IA_MANUAL_CLASSIFY_TASK_ID)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_RESCAN3 ON MAXDAT.corp_etl_mailfaxdoc_wip_bpm ( GWF_RESCAN_REQUIRED)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_DOC_CLASS3 ON MAXDAT.corp_etl_mailfaxdoc_wip_bpm ( GWF_DOC_CLASS_PRESENT)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_WORK3 ON MAXDAT.corp_etl_mailfaxdoc_wip_bpm ( GWF_WORK_IDENTIFIED)TABLESPACE  MAXDAT_INDX ;
CREATE INDEX MAXDAT.IX_MAILFAX_CANCEL3 ON MAXDAT.corp_etl_mailfaxdoc_wip_bpm (CANCEL_DT)TABLESPACE  MAXDAT_INDX ;




