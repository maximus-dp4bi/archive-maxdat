CREATE OR REPLACE VIEW D_NYHIX_WEB_NOTIFICATIONS_SV
AS
SELECT DISTINCT --a12.COMPLETE_DATE  COMPLETE_DATE_TIME, 
  a11.kofax_dcn,
  (Case when a12.TASK_TYPE_ID in (2013019) and a11.CREATE_DT <=  a12.COMPLETE_DATE then 1 else 0 end)  GODWFLAG2_1,
  (Case when a12.TASK_TYPE_ID in (2016306, 2016308, 2013051, 2013050, 2016307, 2013052) and a11.CREATE_DT >= a12.create_date then 1 else 0 end)  GODWFLAG4_1,
  TRUNC(a12.complete_date) complete_date,
  'Consumer Docs(Web)' as document_type,
  'Web' as channel,
  (Case when a12.TASK_TYPE_ID in (2013019) and a11.CREATE_DT <=  a12.COMPLETE_DATE then 1 else 0 end)   +
  (Case when a12.TASK_TYPE_ID in (2016306, 2016308, 2013051, 2013050, 2016307, 2013052) and a11.CREATE_DT >= a12.create_date then 1 else 0 end) as 
   completed_count
FROM D_NYHIX_DOC_NOTIF_CURRENT a11
INNER JOIN D_MW_V2_CURRENT a12
ON a12.SOURCE_PROCESS_INSTANCE_ID = a11.PROCESS_INSTANCE_ID
WHERE a11.KOFAX_DCN LIKE 'U%'
AND a12.CURR_TASK_STATUS = 'COMPLETED'
AND ( ( a12.TASK_TYPE_ID in (2016306,2013054,2016308,2013051,2013050,2016307,2013052) AND a11.CREATE_DT >= a12.create_date) 
  OR  (a12.task_type_id = 2013019 AND a11.CREATE_DT <= a12.COMPLETE_DATE ) );
  
grant select on D_NYHIX_WEB_NOTIFICATIONS_SV to MAXDAT_READ_ONLY;  


CREATE OR REPLACE VIEW F_NYHIX_NOTIFICATIONS_BY_TYPE_SV
AS
WITH Web AS
( 
select       a11.DOCUMENT_TYPE  DOCUMENT_TYPE,
                 a11.COMPLETE_DATE  COMPLETE_DATE,
                 sum(a11.COMPLETED_COUNT)  COMPLETED_COUNT
from         MAXDAT.D_NYHIX_WEB_NOTIFICATIONS_SV       a11
where      a11.COMPLETE_DATE BETWEEN  TRUNC(ADD_MONTHS(SYSDATE, -12),'MM')  AND TRUNC(sysdate)
group by  a11.DOCUMENT_TYPE,
                 a11.COMPLETE_DATE

)
, Applications  AS
(SELECT 'Applications' as document_type,ENV_STATUS_DT as complete_date,
        COUNT((CASE WHEN a11.DOC_TYPE IN ('Application') THEN a11.DCN ELSE NULL END))  completed_count
 FROM     maxdat.D_NYHIX_MFD_CURRENT_V2            a11
 WHERE   (TRUNC(a11.ENV_STATUS_DT) BETWEEN  TRUNC(ADD_MONTHS(SYSDATE, -12),'MM')  AND TRUNC(sysdate)
 AND a11.ENV_STATUS_CD IN ('COMPLETEDRELEASED')
 AND (a11.DOC_TYPE IN ('Application'))) 
 group by ENV_STATUS_DT
)
, MailFax  as
(SELECT 'Consumer Documents (mail/Fax)' as document_type,ENV_STATUS_DT as complete_date,
        COUNT((CASE WHEN (a11.DOC_TYPE IN ('Verification Document') AND a11.FORM_TYPE NOT IN ('Identity Proof Form')) THEN a11.DCN ELSE NULL END))  completed_count
 FROM     maxdat.D_NYHIX_MFD_CURRENT_V2            a11
 WHERE (TRUNC(a11.ENV_STATUS_DT) BETWEEN TRUNC(ADD_MONTHS(SYSDATE, -12),'MM')  AND TRUNC(sysdate)
 AND a11.ENV_STATUS_CD IN ('COMPLETEDRELEASED')
 AND ((a11.DOC_TYPE IN ('Verification Document')
AND a11.FORM_TYPE NOT IN ('Identity Proof Form')))) 
group by ENV_STATUS_DT
)
, IdentityProof  as
(SELECT 'Identity Proof Forms' as document_type,ENV_STATUS_DT as complete_date,
              COUNT((CASE WHEN (a11.FORM_TYPE in ('Identity Proof Form') OR (a11.DOC_TYPE in ('Other') AND a11.FORM_TYPE in ('Other'))) THEN a11.DCN ELSE NULL END))  completed_count
 FROM     maxdat.D_NYHIX_MFD_CURRENT_V2            a11
 WHERE   (TRUNC(a11.ENV_STATUS_DT) BETWEEN  TRUNC(ADD_MONTHS(SYSDATE, -12),'MM')  AND TRUNC(sysdate)
 AND a11.ENV_STATUS_CD in ('COMPLETEDRELEASED')
 AND ((a11.FORM_TYPE in ('Identity Proof Form') OR (a11.DOC_TYPE in ('Other')
 AND a11.FORM_TYPE in ('Other'))))) 
 group by ENV_STATUS_DT
)
SELECT document_type, completed_count,complete_date FROM Applications
UNION
SELECT document_type, completed_count , complete_date FROM MailFax
UNION
SELECT document_type, completed_count, complete_date  FROM Web
UNION
SELECT document_type, completed_count, complete_date FROM IdentityProof;

GRANT  select on F_NYHIX_NOTIFICATIONS_BY_TYPE_SV to MAXDAT_READ_ONLY;