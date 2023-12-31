
CREATE OR REPLACE VIEW "CISCO_ENTERPRISE_CC"."HCO_F_VOICEMAIL_DETAILS_SV" AS
  SELECT
D.D_DATE AS "DATE"
,V.F_V2_CALL_ID AS CALL_ID
,F.F_DIALER_ID AS CALLBACK_CALL_ID
,CAST(FROM_TZ(CAST(F.DATETIME AS TIMESTAMP),'UTC') AT TIME ZONE ('US/Pacific') AS DATE) AS DATE_VOICEMAIL_RETURNED
,TO_CHAR(CAST(FROM_TZ(CAST(F.DATETIME AS TIMESTAMP),'UTC') AT TIME ZONE ('US/Pacific') AS DATE), 'HH24') AS HOUR_VOICEMAIL_RETURNED
,(F.DATETIME-V.DATETIME)*24*60 AS VM_RETURN_TIME
,CASE WHEN (F.DATETIME-V.DATETIME)*24 <=1 THEN 'Y' ELSE 'N' END AS VM_SLA_FLAG
,(SELECT L.BUSINESS_HOUR_TYPE 
  from HCO_BUSINESS_HOURS_TYPE_LKUP l where  (TO_CHAR(V.DATETIME,'HH24.MISS') BETWEEN L.START_HOUR AND L.END_HOUR) and (v.datetime between L.START_DATE AND L.END_DATE) ) AS BUSINESS_HOUR_TYPE
from 
CC_F_V2_CALL V
INNER JOIN CC_D_DATES D ON (V.D_DATE_ID=D.D_DATE_ID)
LEFT OUTER JOIN CC_F_DIALER_BY_DATE F ON ( V.ANI_PHONE_NUMBER=F.PHONE)
INNER JOIN CC_D_CONTACT_QUEUE Q ON (V.D_CONTACT_QUEUE_ID=Q.D_CONTACT_QUEUE_ID AND Q.QUEUE_TYPE  in  (SELECT distinct rtrim(ltrim(regexp_substr(OUT_VAR, '[^,]+', 1, level),''''),'''') 
  FROM (SELECT OUT_VAR  FROM CC_A_LIST_LKUP WHERE NAME = 'VM_call_types') 
CONNECT BY instr(OUT_VAR, ',', 1, level - 1) > 0)  )
/* Real time data for callback is currently not available and testing this view will be put on hold until real callback data gets populated. The view would remain as stub until then. Comment out below line when real time data is available and the view is ready to test */ 
where 1=2;