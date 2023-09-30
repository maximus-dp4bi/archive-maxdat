CREATE OR REPLACE FORCE VIEW LETTER_ADJUSTMENT_FORM_CHRONO_SV AS
WITH LAFH AS
(SELECT * FROM
(SELECT
LETTER_ADJUSTMENT_FORM_ID
, HIST_CREATION_DATE
, CHRONO_CHANGES
, CHRONO_COMMENTS
, ROW_NUMBER() OVER (PARTITION BY LETTER_ADJUSTMENT_FORM_ID ORDER BY LETTER_ADJUSTMENT_FORM_HIST_ID DESC) ROWN
FROM LETTER_ADJUSTMENT_FORM_HIST)
WHERE ROWN = 1)
SELECT
LAF.LETTER_ADJUSTMENT_FORM_ID
, LIG.REPORT_LABEL INVOICE_GROUP
, LAF.ADJUSTMENT_DATE
, LAF.CREATED_BY
, LAF.CREATION_DATE
, LAF.UPDATED_BY
, LAF.UPDATED_DATE
, LT.REPORT_LABEL LETTER_TYPE
, LAF.ADJUSTMENT_COUNT
, LAR.REPORT_LABEL ADJUSTMENT_REASON
, PSX.REPORT_LABEL PROGRAM_CON_XWALK
, LAF.COMMENTS
, LT.LETTER_TYPE_NAME
, LAR.LETTER_ADJUST_REASON_CODE
, LIG.LETTER_INVOICE_GROUP_CODE
, LAF.PROGRAM_CON_XWALK_CODE
, LAF.LMDEF_ID
, LD.PROJECT_CODE
, LD.PROGRAM_CODE
, HIST_CREATION_DATE
, CHRONO_CHANGES
, CHRONO_COMMENTS
FROM LETTER_ADJUSTMENT_FORM LAF
LEFT JOIN LAFH LAFH ON LAF.LETTER_ADJUSTMENT_FORM_ID = LAFH.LETTER_ADJUSTMENT_FORM_ID
LEFT JOIN D_LETTER_TYPE_SV LT ON LT.LETTER_DEFINITION_ID = LAF.LMDEF_ID AND (LT.PROGRAM_CON_XWALK_CODE = LAF.PROGRAM_CON_XWALK_CODE OR LAF.PROGRAM_CON_XWALK_CODE IS NULL)
LEFT JOIN D_LETTER_DEFINITION LD ON LD.LMDEF_ID = LAF.LMDEF_ID
LEFT JOIN D_LETTER_INVOICE_GROUP LIG ON LIG.LETTER_INVOICE_GROUP_CODE = LD.LETTER_INVOICE_GROUP_CODE
LEFT JOIN D_LETTER_ADJUST_REASON LAR ON LAR.LETTER_ADJUST_REASON_CODE = LAF.LETTER_ADJUST_REASON_CODE
LEFT JOIN D_SUBPROGRAM_CON_XWALK PSX ON PSX.PROGRAM_CON_XWALK_CODE = LAF.PROGRAM_CON_XWALK_CODE
WHERE SYSDATE BETWEEN LD.EFFECTIVE_FROM_DATE AND LD.EFFECTIVE_THRU_DATE
AND SYSDATE BETWEEN LIG.EFFECTIVE_FROM_DATE AND LIG.EFFECTIVE_THRU_DATE
AND LD.PROJECT_CODE = 'MIEB'
AND LD.PROGRAM_CODE = 'MEDICAID'
AND (LAR.LETTER_ADJUST_REASON_CODE IS NULL OR SYSDATE BETWEEN LAR.EFFECTIVE_FROM_DATE AND LAR.EFFECTIVE_THRU_DATE);
grant select on LETTER_ADJUSTMENT_FORM_CHRONO_SV to MAXDAT_MITRAN_OLTP_SIU;
grant select on LETTER_ADJUSTMENT_FORM_CHRONO_SV to MAXDAT_MITRAN_OLTP_SIUD;
grant select on LETTER_ADJUSTMENT_FORM_CHRONO_SV to MAXDAT_MITRAN_READ_ONLY;

