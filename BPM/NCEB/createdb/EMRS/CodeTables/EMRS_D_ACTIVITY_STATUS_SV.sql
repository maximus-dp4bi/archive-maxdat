create or replace view EMRS_D_ACTIVITY_STATUS_SV as 
select substr(listdesc, 1, instr(listdesc,',')-1) activity_status
, substr(listdesc, instr(listdesc,',')+1) activity_desc
, substr(listdesc, instr(listdesc,',')+1) activity_label
from (
 SELECT LEVEL listID, SUBSTR (TXT, INSTR (TXT, '|', 1, LEVEL ) + 1, INSTR (TXT, '|', 1, 
  LEVEL+1) - INSTR (TXT, '|', 1, LEVEL) -1 ) AS listdesc
FROM
 (SELECT '|APPROVED,Approved|INPROCESS,Inprocess|DENIED,Denied|' AS TXT FROM DUAL) CONNECT BY LEVEL <= LENGTH(TXT) - 
  LENGTH(REPLACE(TXT,'|'))-1
  )
;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ACTIVITY_STATUS_SV TO MAXDATSUPPORT_READ_ONLY;

GRANT SELECT ON maxdat_support.EMRS_D_ACTIVITY_STATUS_SV TO MAXDAT_REPORTS;
  
