CREATE OR REPLACE PUBLIC SYNONYM EMRS_S_CLIENT_STATUS_STG FOR EMRS_S_CLIENT_STATUS_STG;

CREATE OR REPLACE PUBLIC SYNONYM EMRS_S_CLIENT_ELIGIBILITY_STG FOR EMRS_S_CLIENT_ELIGIBILITY_STG;

GRANT SELECT ON "EMRS_S_CLIENT_STATUS_STG" TO "MAXDAT_READ_ONLY";

GRANT SELECT ON "EMRS_S_CLIENT_ELIGIBILITY_STG" TO "MAXDAT_READ_ONLY";