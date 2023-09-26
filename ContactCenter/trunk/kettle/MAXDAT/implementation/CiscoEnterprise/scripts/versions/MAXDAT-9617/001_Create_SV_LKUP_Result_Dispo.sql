alter session set current_schema = cisco_enterprise_cc;

create or replace view CC_C_CALL_RESULT_LKUP_SV
  AS select
   r.CALL_RESULT_CODE,
   r.CALL_RESULT_DESC,
   r.CREATE_DATE,
   r.LAST_UPDATE_DATE,
   r.LAST_UPDATED_BY
FROM   
CC_C_CALL_RESULT_LKUP r;
    

GRANT SELECT ON CC_C_CALL_RESULT_LKUP_SV  TO MAXDAT_READ_ONLY;


create or replace view CC_C_CALL_DISPOSITION_LKUP_SV
  AS select
   d.CALL_DISPOSITION_CODE,
   d.CALL_DISPOSITION_DESC,
   d.CREATE_DATE,
   d.LAST_UPDATE_DATE,
   d.LAST_UPDATED_BY
FROM   
CC_C_CALL_DISPOSITION_LKUP d;
    

GRANT SELECT ON CC_C_CALL_DISPOSITION_LKUP_SV  TO MAXDAT_READ_ONLY;