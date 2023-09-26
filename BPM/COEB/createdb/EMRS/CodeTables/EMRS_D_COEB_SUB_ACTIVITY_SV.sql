create or replace view EMRS_D_COEB_SUB_ACTIVITY_SV as 
select ACTIVITY_ID SUB_activity_id
, substr(activity_type, 1, instr(activity_type,',')-1) SUB_activity_type
, substr(activity_type, instr(activity_type,',')+1) SUB_activity_label
from (
 SELECT LEVEL ACTIVITY_ID, SUBSTR (TXT, INSTR (TXT, '|', 1, LEVEL ) + 1, INSTR (TXT, '|', 1, 
  LEVEL+1) - INSTR (TXT, '|', 1, LEVEL) -1 ) AS ACTIVITY_TYPE 
FROM
 (SELECT '|INFO_REQUEST,Inquiry - Information Request|MAIL_RETURNED,Inquiry - Mail Returned|ONLINE_WEB,Inquiry - Online Web Form|DOCTOR_NOT_IN_PLAN,ACC - Doctor Not in Plan|ACC_GOOD_CAUSE,ACC - Good Cause Processing|ACC_ENROLLMENT_CHANGE,ACC - Enrollment Change|ACC_ENROLLMENT,ACC - Enrollment|CHP_GOOD_CAUSE,CHP+ - Good Cause Processing|CHP_ENROLLMENT_CHANGE,CHP+ - Enrollment Change|CHP_ENROLLMENT,CHP+ - Enrollment|' AS TXT FROM DUAL) CONNECT BY LEVEL <= LENGTH(TXT) - 
  LENGTH(REPLACE(TXT,'|'))-1
  )
;

GRANT SELECT ON maxdat_support.EMRS_D_COEB_sub_ACTIVITY_SV TO MAXDAT_REPORTS;
  
