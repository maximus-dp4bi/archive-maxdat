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
drop public synonym "TRG_BIU_CORP_ETL_LIST_LKUP";
drop public synonym "TRG_BIU_CORP_ETL_LIST_LKUP_NUM";
