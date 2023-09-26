/*
Created on 07/24/2015 by Raj A.
Description: Added Delete_dt per CADIR-973.
*/
CREATE OR REPLACE VIEW S_CRS_IMR_ISSUES_IN_DISPUTE_SV AS
SELECT
 SCIIID_ID
,ISSUE_IN_DISPUTE_ID
,IMR_ID
,ISSUE_TYPE_ID
,ISSUE_ELIGIBLE_FLAG
,INELIGIBILE_REASON_ID
,IMR_DECISION_ID
,CA_CITATION_PROVIDED_ID
,AGREE_CA_CITATION_FLAG
,CA_MTUS_ACOEM_FLAG
,CA_MTUS_ACUPUNCTURE_FLAG
,CA_MTUS_CHRONIC_PAIN_FLAG
,CA_MTUS_FLAG
,CA_MTUS_POSTSURGICAL_FLAG
,CA_NON_MTUS_FLAG
,HAS_MTUS_FLAG
,MTUS_ACOEM_FLAG
,MTUS_ACUPUNCTURE_FLAG
,MTUS_CHRONIC_PAIN_FLAG
,MTUS_POSTSURGICAL_FLAG
,NON_MTUS_FLAG
,CREATE_DT
,CREATED_BY
,LAST_UPDATE_DT
,LAST_UPDATED_BY
,DELETE_DT
FROM S_CRS_IMR_ISSUES_IN_DISPUTE;