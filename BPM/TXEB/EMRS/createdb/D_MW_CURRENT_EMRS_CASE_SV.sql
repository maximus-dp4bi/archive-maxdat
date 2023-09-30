create index IDX3_CASENUM on EMRS_D_CASE(CURRENT_FLAG) TABLESPACE MAXDAT_INDX;


CREATE OR REPLACE VIEW d_mw_current_emrs_case_sv
AS
SELECT mw.*, case_generic_field6_txt, managed_care_program
FROM d_mw_current mw, emrs_d_case dc
WHERE mw.case_id = dc.case_number
AND dc.current_flag = 'Y'
AND "Complete Date" >= ADD_MONTHS(TRUNC(SYSDATE,'MM'),-6)
UNION ALL
SELECT mw.*, NULL case_generic_field6_txt, NULL managed_care_program
FROM d_mw_current mw
WHERE case_id IS NULL
AND "Complete Date" >= ADD_MONTHS(TRUNC(SYSDATE,'MM'),-6)
   ;


GRANT SELECT ON d_mw_current_emrs_case_sv TO MAXDAT_READ_ONLY;

