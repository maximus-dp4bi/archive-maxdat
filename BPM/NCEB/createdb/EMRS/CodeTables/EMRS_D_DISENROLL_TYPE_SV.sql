create or replace view EMRS_D_DISENROLL_TYPE_SV as 
select substr(listdesc, 1, instr(listdesc,',')-1) DISENROLL_TYPE_CD
, substr(listdesc, instr(listdesc,',')+1) DISENROLL_TYPE
, substr(listdesc, instr(listdesc,',')+1) DISENROLL_TYPE_DESC
from (
 SELECT LEVEL listID, SUBSTR (TXT, INSTR (TXT, '|', 1, LEVEL ) + 1, INSTR (TXT, '|', 1, 
  LEVEL+1) - INSTR (TXT, '|', 1, LEVEL) -1 ) AS listdesc
FROM
 (SELECT '|WITHCAUSE,With Cause Disenrollments|WITHOUTCAUSE,Without Cause Disenrollments|' AS TXT FROM DUAL) CONNECT BY LEVEL <= LENGTH(TXT) - 
  LENGTH(REPLACE(TXT,'|'))-1
  )
;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_DISENROLL_TYPE_SV TO MAXDATSUPPORT_READ_ONLY;

GRANT SELECT ON maxdat_support.EMRS_D_DISENROLL_TYPE_SV TO MAXDAT_REPORTS;
  
