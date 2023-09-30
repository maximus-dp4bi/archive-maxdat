--------------------------------------------------------
--  File created - Tuesday-February-25-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View F_NYHIX_NOTIFICATIONS_BY_TYPE_SV
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT"."F_NYHIX_NOTIFICATIONS_BY_TYPE_SV" ("DOCUMENT_TYPE", "COMPLETED_COUNT", "COMPLETE_DATE") AS 
  WITH Web AS
( 
select        'Consumer Documents (Web)' DOCUMENT_TYPE,
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
(SELECT 'Consumer Documents (Mail/Fax/Mobile)' as document_type,ENV_STATUS_DT as complete_date,
        COUNT((CASE WHEN (a11.DOC_TYPE IN ('Verification Document') AND a11.FORM_TYPE NOT IN ('Identity Proof Form','Identity Proofing Form')) THEN a11.DCN ELSE NULL END))  completed_count
 FROM     maxdat.D_NYHIX_MFD_CURRENT_V2            a11
 WHERE (TRUNC(a11.ENV_STATUS_DT) BETWEEN TRUNC(ADD_MONTHS(SYSDATE, -12),'MM')  AND TRUNC(sysdate)
 AND a11.ENV_STATUS_CD IN ('COMPLETEDRELEASED')
 AND ((a11.DOC_TYPE IN ('Verification Document')
AND a11.FORM_TYPE NOT IN ('Identity Proof Form','Identity Proofing Form')))) 
group by ENV_STATUS_DT
)
, IdentityProof  as
(SELECT 'Identity Proof Forms' as document_type,ENV_STATUS_DT as complete_date,
              COUNT((CASE WHEN (a11.FORM_TYPE in ('Identity Proof Form','Identity Proofing Form') OR (a11.DOC_TYPE in ('Other') AND a11.FORM_TYPE in ('Other','Nav/CAC ID Proofing Form'))) THEN a11.DCN ELSE NULL END))  completed_count
 FROM     maxdat.D_NYHIX_MFD_CURRENT_V2            a11
 WHERE   (TRUNC(a11.ENV_STATUS_DT) BETWEEN  TRUNC(ADD_MONTHS(SYSDATE, -12),'MM')  AND TRUNC(sysdate)
 AND a11.ENV_STATUS_CD in ('COMPLETEDRELEASED')
 AND ((a11.FORM_TYPE in ('Identity Proof Form','Identity Proofing Form') OR (a11.DOC_TYPE in ('Other')
 AND a11.FORM_TYPE in ('Other','Nav/CAC ID Proofing Form'))))) 
 group by ENV_STATUS_DT
)
SELECT document_type, completed_count,complete_date FROM Applications
UNION
SELECT document_type, completed_count , complete_date FROM MailFax
UNION
SELECT document_type, completed_count, complete_date  FROM Web
UNION
SELECT document_type, completed_count, complete_date FROM IdentityProof
;
