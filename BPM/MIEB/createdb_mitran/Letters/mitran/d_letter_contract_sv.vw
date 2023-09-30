CREATE OR REPLACE FORCE VIEW D_LETTER_CONTRACT_SV AS
SELECT
 lmdef.lmdef_id letter_definition_id
, CONTRACT_REFERENCE_LEVEL_1_CODE contract
,CONTRACT_REFERENCE_LEVEL_1_ORDER contract_order
,CONTRACT_REFERENCE_LEVEL_2_CODE program
,CONTRACT_REFERENCE_LEVEL_2_DESC program_label
,CONTRACT_REFERENCE_LEVEL_2_ORDER program_order
,CONTRACT_REFERENCE_LEVEL_3_CODE subprogram
,CONTRACT_REFERENCE_LEVEL_3_DESC subprogram_label
,CONTRACT_REFERENCE_LEVEL_3_ORDER subprogram_order
, c.letter_program_group
, c.LETTER_PROGRAM_GROUP_label group_label
, c.LETTER_PROGRAM_GROUP_ORDER group_order
, lmdef.name letter_name
, lmdef.report_label letter_label
, to_number(lmdef.contract_reference) letter_order
,c. PROJECT_CODE
,c. PROGRAM_CODE
FROM D_LETTER_CONTRACT c
join d_letter_definition lmdef on lmdef.letter_program_group = c.letter_program_group and c.project_code = lmdef.project_code and c.program_code = lmdef.program_code
WHERE c.EFFECTIVE_FROM_DATE <= TRUNC(SYSDATE) AND c.EFFECTIVE_THRU_DATE >= TRUNC(SYSDATE)
and lmdef.EFFECTIVE_FROM_DATE <= TRUNC(SYSDATE) AND lmdef.EFFECTIVE_THRU_DATE >= TRUNC(SYSDATE);
grant select on D_LETTER_CONTRACT_SV to MAXDAT_MITRAN_READ_ONLY;


