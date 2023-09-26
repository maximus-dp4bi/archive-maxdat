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
drop public synonym "CC_D_MANAGER_SV";
drop public synonym "CC_D_SUPERVISOR_SV";
drop public synonym "SEQ_CEPN_ID";