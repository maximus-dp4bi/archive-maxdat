CREATE OR REPLACE VIEW EMRS_D_CITIZENSHIP_STATUS_SV
AS
SELECT 'U' citizenship_code
       ,'Unknown' citizenship_description
FROM dual;

GRANT SELECT ON "EMRS_D_CITIZENSHIP_STATUS_SV" TO "MAXDAT_READ_ONLY";

