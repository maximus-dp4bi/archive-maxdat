CREATE OR REPLACE PUBLIC SYNONYM EMRS_D_PLAN_PERCENTAGE FOR EMRS_D_PLAN_PERCENTAGE;

CREATE OR REPLACE PUBLIC SYNONYM EMRS_D_AA_CONTRACT FOR EMRS_D_AA_CONTRACT;

CREATE OR REPLACE PUBLIC SYNONYM EMRS_D_AA_COUNTYCONTRACT FOR EMRS_D_AA_COUNTYCONTRACT;

GRANT SELECT ON "EMRS_D_PLAN_PERCENTAGE" TO "MAXDAT_READ_ONLY";

GRANT SELECT ON "EMRS_D_AA_CONTRACT" TO "MAXDAT_READ_ONLY";

GRANT SELECT ON "EMRS_D_AA_COUNTYCONTRACT" TO "MAXDAT_READ_ONLY";