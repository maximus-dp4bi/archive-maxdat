CREATE OR REPLACE FORCE VIEW D_LETTER_DEFINITION_SV AS
SELECT lmdef_id letter_definition_id
      ,name letter_name
      ,description description
      , report_label report_label
      , LETTER_OR_FORM letter_type
      , EFFECTIVE_FROM_DATE
      , EFFECTIVE_THRU_DATE
      , LETTER_SOURCE_CODE
      , LETTER_INVOICE_GROUP_CODE
      , LETTER_PROGRAM_GROUP
      , PROJECT_CODE
      , PROGRAM_CODE
FROM d_letter_definition;
grant select on D_LETTER_DEFINITION_SV to MAXDAT_MITRAN_OLTP_SIU;
grant select on D_LETTER_DEFINITION_SV to MAXDAT_MITRAN_OLTP_SIUD;
grant select on D_LETTER_DEFINITION_SV to MAXDAT_MITRAN_READ_ONLY;


