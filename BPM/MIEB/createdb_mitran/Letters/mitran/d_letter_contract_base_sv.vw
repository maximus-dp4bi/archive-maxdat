CREATE OR REPLACE FORCE VIEW D_LETTER_CONTRACT_BASE_SV AS
SELECT
LETTER_PROGRAM_GROUP
,LETTER_PROGRAM_GROUP_LABEL
,LETTER_PROGRAM_GROUP_ORDER
,CONTRACT_REFERENCE_LEVEL_1_CODE
,CONTRACT_REFERENCE_LEVEL_1_DESC
,CONTRACT_REFERENCE_LEVEL_1_ORDER
,CONTRACT_REFERENCE_LEVEL_2_CODE
,CONTRACT_REFERENCE_LEVEL_2_DESC
,CONTRACT_REFERENCE_LEVEL_2_ORDER
,CONTRACT_REFERENCE_LEVEL_3_CODE
,CONTRACT_REFERENCE_LEVEL_3_DESC
,CONTRACT_REFERENCE_LEVEL_3_ORDER
,CONTRACT_REFERENCE_LEVEL_4_CODE
,CONTRACT_REFERENCE_LEVEL_4_DESC
,CONTRACT_REFERENCE_LEVEL_4_ORDER
,CONTRACT_REFERENCE_LEVEL_5_CODE
,CONTRACT_REFERENCE_LEVEL_5_DESC
,CONTRACT_REFERENCE_LEVEL_5_ORDER
,PROJECT_CODE
,PROGRAM_CODE
FROM D_LETTER_CONTRACT
WHERE EFFECTIVE_FROM_DATE <= TRUNC(SYSDATE) AND EFFECTIVE_THRU_DATE >= TRUNC(SYSDATE);
grant select on D_LETTER_CONTRACT_BASE_SV to MAXDAT_MITRAN_READ_ONLY;

