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
drop public synonym "TRG_ADIU_CORP_ETL_CLEAN";
drop public synonym "TRG_ADIU_CORP_ETL_LIST_LKUP";
drop public synonym "TRG_AI_CORP_ETL_MANAGE_WORK_Q";
drop public synonym "TRG_AU_CORP_ETL_MANAGE_WORK_Q";
drop public synonym "TRG_BIU_BPM_ACTIVITY_EVENTS";
drop public synonym "TRG_BIU_BPM_ATTRIBUTE";
drop public synonym "TRG_BIU_BPM_INSTANCE";
drop public synonym "TRG_BIU_BPM_INSTANCE_ATTR";
drop public synonym "TRG_BIU_BPM_UPDATE_EVENT";
drop public synonym "TRG_BIU_CORP_ETL_CLEAN";
drop public synonym "TRG_BIU_CORP_ETL_CONTROL";
drop public synonym "TRG_BIU_CORP_ETL_ERROR_LOG";
drop public synonym "TRG_BIU_CORP_ETL_LIST_LKUP";
drop public synonym "TRG_BIU_CORP_ETL_MANAGE_WORK";
drop public synonym "TRG_BIU_CORP_INSTANCE_CLEANUP";
drop public synonym "TRG_BIU_STEP_INSTANCE_STG";
drop public synonym "TRG_HOLIDAYS";