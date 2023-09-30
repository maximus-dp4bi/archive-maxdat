/*
select 'drop public synonym "' || SYNONYM_NAME || '";'
from ALL_SYNONYMS  
where 
  TABLE_OWNER like 'MAXDAT%'
  and OWNER = 'PUBLIC'
order by 
  OWNER asc,
  SYNONYM_NAME asc;
*/
drop public synonym TEST_RBK;
drop public synonym "CORP_ETL_MFB_BATCH";
drop public synonym "CORP_ETL_MFB_BATCH_ARS_OLTP";
drop public synonym "CORP_ETL_MFB_BATCH_ARS_STG";
drop public synonym "CORP_ETL_MFB_BATCH_EVENTS";
drop public synonym "CORP_ETL_MFB_BATCH_EVENTS_OLTP";
drop public synonym "CORP_ETL_MFB_BATCH_EVENTS_STG";
drop public synonym "CORP_ETL_MFB_BATCH_EVENTS_WIP";
drop public synonym "CORP_ETL_MFB_BATCH_OLTP";
drop public synonym "CORP_ETL_MFB_BATCH_STG";
drop public synonym "CORP_ETL_MFB_BATCH_WIP";
drop public synonym "CORP_ETL_MFB_DOCUMENT";
drop public synonym "CORP_ETL_MFB_DOCUMENT_OLTP";
drop public synonym "CORP_ETL_MFB_DOCUMENT_STG";
drop public synonym "CORP_ETL_MFB_DOCUMENT_WIP";
drop public synonym "CORP_ETL_MFB_ENVELOPE";
drop public synonym "CORP_ETL_MFB_ENVELOPE_OLTP";
drop public synonym "CORP_ETL_MFB_ENVELOPE_STG";
drop public synonym "CORP_ETL_MFB_ENVELOPE_WIP";
drop public synonym "CORP_ETL_MFB_FORM";
drop public synonym "CORP_ETL_MFB_FORM_OLTP";
drop public synonym "CORP_ETL_MFB_FORM_STG";
drop public synonym "CORP_ETL_MFB_FORM_WIP";
drop public synonym "CORP_ETL_MFB_SBM_OLTP";
drop public synonym "CORP_ETL_MFB_SML_OLTP";
